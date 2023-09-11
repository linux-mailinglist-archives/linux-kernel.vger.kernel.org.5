Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4B79B250
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjIKVPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbjIKQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:00:08 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019971AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:00:01 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so29867546d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694448000; x=1695052800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhCiYm6x7iq9o4rbclNiuNRftcu8ARPlt13VmKx0QnQ=;
        b=6MrI4tp9EqIJC+JIX5u0CdWcot8DSk/gMupHOW9kXQBhibKT/8rDvfr/GpMqTTCb3T
         XjREvumMK1zHGjIrh0JkCVnkVS3a1tROCrsH/36t3PtQgy4NjOpPae41Z6RgYBQqEadz
         0qUA0CmPYKm7AXGa1LEsauACqWexyd+jJO339nLuTZr8wRZ+lo7QSPggYnu3pn+P4WDI
         PhwJ0gBXw9toviSdGMk2oy9V5b7aGyjVNozO+5ss2KTtMyc9oLZeKmTL5PNompeYqgZm
         0nu2xAQ97tkaF3aX8ABgP8DVNzBh+7JUnJoS36Cc4JqocuU9c4WxZ4I8apBhiTmXG4uy
         BU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448000; x=1695052800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhCiYm6x7iq9o4rbclNiuNRftcu8ARPlt13VmKx0QnQ=;
        b=qerMbko4nzsXPfvR2aY1X6yF/MNZ97V77TiO/8OMXdI+1QmQivukoCPgSweeNPGGSJ
         AHeUzdjAGOp58LhtJ1qClsr4yyDqkoAuQ+RX1ka8JmMvson18BCoHCC7C242CpFsGOn4
         8QOrOVeFs0jMlF6DabtQcJGz9y0y3Hsem1QqOwAXE1DVwh8EapZ5RtuhuiJpx5BrOdzq
         4yTFRCQ+vmRYA6MgItyUvB/cJSi4p/h90RZGF8HcR8gDJAmOSzpS4P55fBPsX8iTd3Ko
         7vMbJbaKfcCrYd4+BEPTqKPrCYFNy8BM9L32c/6qGB9OpzK89H1gHzmXw7iEIoMVlPGT
         O38g==
X-Gm-Message-State: AOJu0YwBZhUKE6Uux0G343jeWKdfx3lYVGfKsZtEVTyNjXvHFAW2TvfC
        BOEXnpRJ7cp/VrcB2x6kQ9X4b8Ex/0cSwnLMv3EOKw==
X-Google-Smtp-Source: AGHT+IG1BrjMOhxrQ5uTqPmUsGxbwZhnQhQdQWAFkmEevIFzaHDDcwRIiVmuW4KxFZCM92Owt5ocwv+noWH4lf1gUmY=
X-Received: by 2002:a0c:8ecb:0:b0:655:87a1:49c4 with SMTP id
 y11-20020a0c8ecb000000b0065587a149c4mr8746780qvb.39.1694447999884; Mon, 11
 Sep 2023 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org>
In-Reply-To: <20230908231244.1092614-1-song@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Sep 2023 08:59:48 -0700
Message-ID: <CAKwvOdmGSNj0FF0Mx97xAq6Zn5nc816k1QMzXQtR2C+VDq_3+Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        kexec@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 4:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> With LTO enabled, ld.lld generates multiple .text sections for
> purgatory.ro:
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

Thanks for the v2!

>
> Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections"=
)

Dunno that this fixes tag is precise.  I think perhaps

Fixes: b33fff07e3e3 ("x86, build: allow LTO to be selected")

would be more precise.

> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Song Liu <song@kernel.org>
>
> ---
> AFAICT, x86 is the only arch that supports LTO and purgatory.
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

-flto* in LLVM implies -ffunction-sections, which creates a .text.<fn
name> section per function definition to facilitate -Wl,--gc-sections.

Overall the question here is "do we really need to optimize kexec?"

If the answer is yes, then this patch AND 8652d44f466a are both
pessimizing kexec (though having it work at all is strictly better
than not at all).  The best fix IMO would be to provide a linker
script for this purgatory image that rejoins the text sections back
into one .text.  For example:

commit eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")

I assume people do care about the time to kexec, hence the raison
d'etre for projects like kpatch.

I'm fine to sign off on this approach if we don't really care, or want
to care more later, but we can do better here.

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
