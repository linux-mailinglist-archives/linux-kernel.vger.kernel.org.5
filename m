Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6A7A0B84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjINRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbjINRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:22:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD12715
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:22:27 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-649c6ea6e72so7029566d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694712146; x=1695316946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8eQORumJtaroUI8JT9bu5D1IY7lPGvpUmpxNHPhsvg=;
        b=jE6UjXJ7BkxVirgNwrjHB7bsXjKXr2s3aEpRyLtBIqG/VsMWL7lrJetRWxk2CGiH51
         y68z9mb9sTRUuVyf8pX7yULzgFKeGOVCGGyXoS35TuCfJQwo2zatN0cICH7wVqbctbWh
         bySNekPa/ZnfWkQUQ7x9zncSSoiNCA1ixMDo57DXY2sWRFR0XYd8jbuaSfjSjkjlFLYJ
         2FP6rrwAyXW/khvvlEhgZ2hETZVjp0T+lPF7cDCsF842iuE7CTMYmF058jD3ycRAMawF
         RT8DH0rkmquiSEnkS/q7MD2BjzSWYCoF5Nquqf2zuVVWN9WcUgPKvsKb60UfsWOONgI2
         zi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712146; x=1695316946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8eQORumJtaroUI8JT9bu5D1IY7lPGvpUmpxNHPhsvg=;
        b=HFMxLngHkwnrKNKhNJCHTG5M9d+3gAIMov7IBRAcreyGZZ7ByeY3zSWt3naGSNYAla
         Hu2sZCctQeDaRrwpNBKio+I5LYrv0swjHtzSnY2dda4+owUTa1rbUdyfuH1nrYh5NS5U
         loHwJlX5J6Dd4fXMTOIdl6xlfKau8RzHtvCMUNw4Dl/G2+Dq8GUu2ZsWrdVKvNAS+qEr
         6iYSBnwscGPxqJ50gMB9Mh2e6dzhjT2dr9wtecu7Z3Y/+r8UYBQCFQavk18cma9LwnJ/
         zxsI3q7E0quiTSwgZP7etyODv7xJDUtp6vv7HQFsH2cWpuHrVwWoj6IDyM5KGiKHTwTA
         127Q==
X-Gm-Message-State: AOJu0YyQ/ffQW/oEdrBbDd7TOIjIsfIE3fCkzorKh9B9CMXrJOrAJONZ
        ypZbj0Gnvo4zVNIHyYvZC5wUKVWTlJsb1YAOKjC4+Q==
X-Google-Smtp-Source: AGHT+IFA5G/u9fTxemIh7ppyemUF4heb6N+w5pTJ0x1vdhIE9rGnXqUnizt0BXWM/DV2ecQatLz805H4QnF5kKUSyAs=
X-Received: by 2002:ad4:5851:0:b0:63d:7214:638e with SMTP id
 de17-20020ad45851000000b0063d7214638emr7042473qvb.56.1694712146470; Thu, 14
 Sep 2023 10:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230914170138.995606-1-song@kernel.org>
In-Reply-To: <20230914170138.995606-1-song@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Sep 2023 10:22:12 -0700
Message-ID: <CAKwvOdnisbzAx3eQD_U8gQU05WzuOr48VRJfySu5WRTWZVDiPw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/purgatory: Remove LTO flags
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        kexec@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:02=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> -flto* implies -ffunction-sections. With LTO enabled, ld.lld generates
> multiple .text sections for purgatory.ro:
>
> $ readelf -S purgatory.ro  | grep " .text"
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>   [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
>   [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
>   [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
>   [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
>   [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
>   [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0
>
> This cause WARNING from kexec_purgatory_setup_sechdrs():
>
> WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> kexec_load_purgatory+0x37f/0x390
>
> Fix this by disabling LTO for purgatory.
>
> We could also fix this with an explicit linker script to rejoin .text.*
> sections back into .text. However, given the benefit of LTOing pugatory

s/pugatory/purgatory/

(maybe the x86 maintainers can apply that fixup if/when picked up)

> is small, simply disable the production of more .text.* sections for now.
>
> Fixes: b33fff07e3e3 ("x86, build: allow LTO to be selected")
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Song Liu <song@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> ---
> AFAICT, x86 is the only arch that supports LTO and purgatory.
>
> Changes in v3:
> 1. Fix "Fixes" tag. (Nick Desaulniers)
> 2. Add description of an alternative fix, with linker script.
>    (Nick Desaulniers)
>
> Changes in v2:
> 1. Use CC_FLAGS_LTO instead of hardcode -flto. (Nick Desaulniers)
> ---
>  arch/x86/purgatory/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index c2a29be35c01..08aa0f25f12a 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -19,6 +19,10 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS -D__NO_FORTIF=
Y
>  # optimization flags.
>  KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))
>
> +# When LTO is enabled, llvm emits many text sections, which is not suppo=
rted
> +# by kexec. Remove -flto=3D* flags.
> +KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
>  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
