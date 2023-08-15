Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD577D6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbjHOXku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbjHOXk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:40:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25826A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:40:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68706b39c4cso4306600b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692142799; x=1692747599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIaRDF0hVkKVd118QxNJ2cE/XyLPoGMK6bw4OO6dAQI=;
        b=KpiC1bx2GBkkMOEUPYLOcCkfIKKrETx6xewfdKH2qxYUpAR1dH+2CCuQbTiVl1twuN
         1cgsfirNT3DznrIxn4vvefZyiC/hGImcqAFIJImFVc/XldElBR//n133wjYT1u7CvWay
         dUmrifB1r/a+Yg4dQstXSjcMasY3eh7p7zyb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142799; x=1692747599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIaRDF0hVkKVd118QxNJ2cE/XyLPoGMK6bw4OO6dAQI=;
        b=LwpEtbsPrgtpU+QCLxNix6BY6k/XwYG2qIHgny7Ze8weG6pHmAmT5LQZ3eE6DTvsj/
         eKNx9QUfYuNaZyhi4XPNNsypBAAdu+2aU6hSu7sIQFNW4kfL4BJ81tVEfjmoxnDBGPef
         HIar0e6H/19z4nb4bd7VIKi1qiBPG4nJTW0XWvF1A3d4B2T5KKZbdhuwsXihT33lpId0
         iEYtJiDaMElj1dElyLnWJOTAVsQUpab4fl2SmqXOzr6S1WYb40IXWHElkiwigx+Ea0+x
         f+lrQHxz7MAq5OJ8MJ1COrSLBDcZvnMZA2qQxuqP+/gaCQnYQ9AZ1ADOvX7IDTkBfW64
         OYIQ==
X-Gm-Message-State: AOJu0Yyf3kNexXUy31ZLLQbUWNGxN6Yol+wClF/WY6H9kIL6LRVPCpL5
        fOpy5L019hvUZRd0ejkbCzEqKA==
X-Google-Smtp-Source: AGHT+IGKj1OJIbGGo8TvNIdevDKSCFtWd0N+yBBZ3SGTCWIvm7nfp5p39o9iYLxM+kzcddzCJGhj7A==
X-Received: by 2002:a05:6a20:5503:b0:13e:f5b5:48f5 with SMTP id ko3-20020a056a20550300b0013ef5b548f5mr307713pzb.27.1692142799586;
        Tue, 15 Aug 2023 16:39:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b0056420d3cd20sm10723119pgc.71.2023.08.15.16.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:39:59 -0700 (PDT)
Date:   Tue, 15 Aug 2023 16:39:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] lkdtm: Fix CFI_BACKWARD on RISC-V
Message-ID: <202308151639.44FEBD10@keescook>
References: <20230815203442.1608773-8-samitolvanen@google.com>
 <20230815203442.1608773-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815203442.1608773-14-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:34:49PM +0000, Sami Tolvanen wrote:
> On RISC-V, the return address is before the current frame pointer,
> unlike on most other architectures. Use the correct offset on RISC-V
> to fix the CFI_BACKWARD test.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
