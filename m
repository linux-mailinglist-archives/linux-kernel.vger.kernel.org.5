Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E56D7942BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbjIFSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbjIFSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:06:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8966CE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:06:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c0d4cc3a4so116509b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694023563; x=1694628363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O40bo/gxfF03whhMFXEqEedi7R6NFirN94zwY0Dca7U=;
        b=ldH5bOXPn4zFGDFzW5RJ6cSXi53LCn7GKh/nbeYhWXeP7hvXu5WhUNCM0XmyfWo0GQ
         z2JACE9BK5jYzyURVNCafSdVcfi/iFTDyny2gmSFPEITZTpwSgX0gWjJH0QoGIv7bjyD
         72fDzimiSxi5I/4TSKrcfJIUjNAWBW6vO8qTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023563; x=1694628363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O40bo/gxfF03whhMFXEqEedi7R6NFirN94zwY0Dca7U=;
        b=XHLneWldZqVSfqdpM1MaHuL8dgF0yU+tdGCu2LfFpmyLwE6HE0tbfdckVRFbLx4kSj
         TXszCc1F1+fmYmdl1k1RSNy/tbTt4VsGJU5P/JT159FOSpf7UHnfppzExi/v4IOeOKpy
         GuhT3BIZqaTVjA7b26s0+jFa+pb6EkbSm8u3bKE8FCE9xOmBSaw1ms3eXhuJY2zn0H+B
         GVrSwxeGOaDhlkcSGFl9zAhQtImHSc2zqlsEZ/+J1nqbt/tQaePak9H51GS4PUv95WVm
         zovf1aJVau/5tIlEA3JDCjzJfH1bmWL3K/tvi1Z5sHiulGC7lSlw6R4PZLwxbnQxH5VJ
         3Exw==
X-Gm-Message-State: AOJu0YyFpW+/ZcbjFMZG0VbzPxRag+VXNJLOw/XCVhDNr0sYENOqaZuW
        5EEyGdBajUz1JdG+jQakzq/Q0g==
X-Google-Smtp-Source: AGHT+IFVidGBv05UhqX2YIvVWb0IhPX+FPDQhL5+tVhZ0nsxBP5ZEoBlEwgCMn0DOZzFYA3QvqJ9WQ==
X-Received: by 2002:a05:6a00:80c:b0:68a:55ff:3a02 with SMTP id m12-20020a056a00080c00b0068a55ff3a02mr17550041pfk.18.1694023563375;
        Wed, 06 Sep 2023 11:06:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fm14-20020a056a002f8e00b0068c6889e146sm11398521pfb.98.2023.09.06.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:06:02 -0700 (PDT)
Date:   Wed, 6 Sep 2023 11:06:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>, Fangrui Song <maskray@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, x86@kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
Message-ID: <202309061102.DB794AD295@keescook>
References: <20230906175215.2236033-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906175215.2236033-1-song@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:52:15AM -0700, Song Liu wrote:
> With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
> Example objdump -D output:
> 
> ffffffff82b04203:       00 00                   add    %al,(%rax)
> ffffffff82b04205:       cc                      int3
> ffffffff82b04206:       cc                      int3
> ffffffff82b04207:       00 00                   add    %al,(%rax)
> ffffffff82b04209:       cc                      int3
> ffffffff82b0420a:       cc                      int3
> 
> Replace it with ":text =0xcccccccc", so we get the following instead:
> 
> ffffffff82b04203:       cc                      int3
> ffffffff82b04204:       cc                      int3
> ffffffff82b04205:       cc                      int3
> ffffffff82b04206:       cc                      int3
> ffffffff82b04207:       cc                      int3
> ffffffff82b04208:       cc                      int3
> 
> gcc/ld doesn't seem to have the same issue. The generated code stays the
> same for gcc/ld.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: x86@kernel.org
> Signed-off-by: Song Liu <song@kernel.org>

Ah! Thanks for the catch... I wonder if ld.lld should be fixed too? My
understanding was that ":text =...." was defined as being explicitly
u16?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
