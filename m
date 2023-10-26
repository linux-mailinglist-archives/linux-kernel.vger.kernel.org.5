Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5497D87ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjJZR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:59:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72351B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:59:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso1866207a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698343166; x=1698947966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w/kSr2KveuTw8WecJoTR/o4YptbqW7cASbxPYo+p8w=;
        b=lcnuQEzfrJlCi5aTZf89r9olWQZtS6LevgFq8d1qM1jQcZsOs7mTl7qbq1A3kh5mmb
         0WfRy3uctfn0Z3We8qU0WLXb9//Jhhxsim991tv89jT6BfNv1ND9tR4LdTzAp+6Qx5UG
         40Nv7+LooBaOIyZj/oVSLSEGp61YoX6eUFNlrqKX/4KqHqw1JiHrFuP9OklUNdZsYR2S
         3/Itn8zDM3icWHCLX02gCU3KbXpRAm24OpePgPFItVAWqD97CldZ6NdT7XNEn3dn9jOH
         7darBO2Mf29pBgPj56hdlneXawgwMInE2IN7wDBYpKCSwy01v4rVic3jjlM65KwmzsRs
         VQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698343166; x=1698947966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w/kSr2KveuTw8WecJoTR/o4YptbqW7cASbxPYo+p8w=;
        b=reIaibR+KFAwGsblx8YSEB/xoreqbKgAN43eeKOl+IzpqxY4EhpOc7qobVJHhyrvXR
         5r03Fn44ar5pTnQJLgwP65ekdsNLj3r/heP/1YyV2NyVSFiqZ9SxBZxf1a4S21iT/k5F
         45oXpE3OWOMMM1cPIhR1rkWyQiGnDY+rFKsJ5fdslMvzSeSxZZXUGy6n4lV6/76Kd1US
         RMRuXq4qtvCBX4Xg2F/12/P4/RdhX0wDBPulWXwYBWb6PFVgLW/Hy8qujuNFlkFOUeKM
         tg5B05HlhtMpBNjpHEyffv8UU4nA8tykLWzIPZLh+pQDAFxGzhaUvh2KOoQbMqkNaDUa
         skWg==
X-Gm-Message-State: AOJu0YyuSqSp1Sb0bJnFj4XfxAo+HOQ3IObym+pHCShzZvlYC4u0s9AM
        iGpIrzKfJuC5y1zcWo36fXAwDB5h/g7VHoQ4l4I=
X-Google-Smtp-Source: AGHT+IFmiMI0VxE+EbR2MK72Jy8+9lVzxV++f+9Bquqosr6csrgh7Be29B8y5UV2Wm+rSCNTL0v5Wpte9Pc/NHrdtNA=
X-Received: by 2002:a50:9ecb:0:b0:53f:ef3b:adbb with SMTP id
 a69-20020a509ecb000000b0053fef3badbbmr479225edf.2.1698343165868; Thu, 26 Oct
 2023 10:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-2-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-2-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 19:59:14 +0200
Message-ID: <CAFULd4ZLBtdJSQb2wfq=xFPEWPYT4TX306qfeoUL7LJ3Naq3AA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] x86/stackprotector/32: Remove stack protector
 test script
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Test for compiler support directly in Kconfig.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                          | 2 +-
>  scripts/gcc-x86_32-has-stack-protector.sh | 8 --------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5ef081aa12ac..039872be1630 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -411,7 +411,7 @@ config PGTABLE_LEVELS
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
>         default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS)) if 64BIT
> -       default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS))
> +       default $(cc-option,-mstack-protector-guard-reg=3Dfs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard)
>         help
>           We have to make sure stack protector is unconditionally disable=
d if
>           the compiler produces broken code or if it does not let us cont=
rol
> diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_=
32-has-stack-protector.sh
> deleted file mode 100755
> index 825c75c5b715..000000000000
> --- a/scripts/gcc-x86_32-has-stack-protector.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# This requires GCC 8.1 or better.  Specifically, we require
> -# -mstack-protector-guard-reg, added by
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0=
 -fstack-protector -mstack-protector-guard-reg=3Dfs -mstack-protector-guard=
-symbol=3D__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
> --
> 2.41.0
>
