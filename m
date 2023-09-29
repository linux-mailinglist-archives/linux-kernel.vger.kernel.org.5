Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966917B3A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjI2TRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjI2TRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:17:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E151AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso11790482b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015068; x=1696619868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDYWsdWil9zbQW5R6gj/5ZmSzR6wTayh9fz7CUaf8pU=;
        b=Goktd67Tg8lYDKiXaINvkN3AaVpYaA3ud8M9AflT92uWcrPjuVt1t4P2eH5blKq/yT
         NZ8ulKNgRaJZqwgFxJWaZi6BAGE/xo2xkMZSat/WyY1NNpXc71HMFCKL/lGgmtQdIAs7
         AkHJueEsis8GCrXrwsH7SBHV9+albejbZoEd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015068; x=1696619868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDYWsdWil9zbQW5R6gj/5ZmSzR6wTayh9fz7CUaf8pU=;
        b=Yc+a3g2fAWGixNljSdyIOpa18o0Tb8fJpoReEPUUs2CLsedgT24Jk0Mqrq0gicdYjb
         c8nhaVjnasyLwomZVy8xFeYnlOOVfky4JcaYt/tdSdsDPNikVSoZFQTBI1qJDRfEAQRT
         oM+nqgdaPBmD5tOb79ozh/jVIqws530QA4T3fquufb+wqGgjVgTs1gCL+4DYIOYBFwmb
         00NVy6PbIIIejO7L8ymwVUpUnPpsa3gczkbuzFZ2Pl5tTs5q90hIlk0bKt3nWC4VDmda
         Kw01AD2ixDF1KBJluxO/noFXDdGeoprOzA4QRcaMGMh+T9uPtw+Y+WxCG8k5orbPguAx
         WFDA==
X-Gm-Message-State: AOJu0YwLgp1DRBvk9AUrgtaBSQFty/VsMxPjwAgnVHw0jYCs/wIfmwyA
        0ax3ozVd3h9DdYiv6uNok8BUUA==
X-Google-Smtp-Source: AGHT+IGdsmoNdh/Arkb8UEaGz2niq5l6pVZkZZWHMJonh+QTEtqj7fKdMqUpwLVu/aGM0F0r0Em/BA==
X-Received: by 2002:a05:6a21:a593:b0:14c:ad99:22a9 with SMTP id gd19-20020a056a21a59300b0014cad9922a9mr6139280pzc.32.1696015068592;
        Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79043000000b0068e12e6954csm4745873pfo.36.2023.09.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Fasheh <mark@fasheh.com>, Kees Cook <keescook@chromium.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ocfs2: Annotate struct ocfs2_slot_info with __counted_by
Date:   Fri, 29 Sep 2023 12:17:46 -0700
Message-Id: <169601506493.3012633.12707221094157928597.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201522.never.979-kees@kernel.org>
References: <20230915201522.never.979-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:15:23 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ocfs2_slot_info.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ocfs2: Annotate struct ocfs2_slot_info with __counted_by
      https://git.kernel.org/kees/c/7c993785ae63

Take care,

-- 
Kees Cook

