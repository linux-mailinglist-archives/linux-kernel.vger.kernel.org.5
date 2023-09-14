Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25BC7A0DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbjINTQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbjINTQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:16:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FA26B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:15:59 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bf2427b947so752198a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694718958; x=1695323758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/OKaoFTzHFPckQ8elHjeRhc3HPJtJWQjmgI/gL6p9I=;
        b=ezA1rVCZD+dRibxTs+KY2HucRI4VFs0SDCIkBKV/mRtDmqp5HPsA7oNBu98jk5Eypd
         kDLs9VGH2jV+dFA3fOQDB5KGf14uMJQ/U2Ccpjfw8UyIN1GK6NVcFXE59snWTHcHz40H
         v+1S1cldo3XY9dZIhWU1cgKEEGGJQ2frmRPtVsVimsy9xVZcncyVGaoOgj4le0eeo9iZ
         oCDAzNn6uzAj05CLNHQedDUJ2YpOq3ycgxQlccStSkcoSZNml/S5snA/Tuvgy2JLuGeC
         kJgHhxqeM9jkrqVIgCLI8syw4hUqZBGRFNvKk/XN6QxCkfDFfPmBPnwUQMtgPKj3SsCJ
         QBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694718958; x=1695323758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/OKaoFTzHFPckQ8elHjeRhc3HPJtJWQjmgI/gL6p9I=;
        b=Xa0Fdit+9Z4oq8s9KbsApMgicOwSdarAklLx2/FJNmtjujijNrAEcO91Z4Svrfek5q
         RIoCaIs3bdBHHGONHZNHMTp6Nb0qF4p2ngR7VbbQ6BTzvxiMHZDeetT5vtWzF4EbwUxn
         wp7YjdIv/4kUrG9AzxzvSJGwa6LXg90Z+EW0cPCr+MeJw1wGr3FDUAIOabVRkeRRm1H9
         FdwPhILaj4yyVK/1KCjhU0u6CxI+yn5zhinEKnTxqzq0Qkj28MNSgu4L9Caa84v+qTyv
         AyMEgZ9majA+9Z3mjJHLHiMfX8KBEx4D6QCudicvBzGQpYyrC6e6Xzx6PWHnU3qCDLhE
         VPvg==
X-Gm-Message-State: AOJu0YzphBCHS1DAxasbW7jXNnCocGoo3pdGLcT57R8mw4dObgGHDTN8
        HMIGhzSmXX+s8zJVLvfPFXgzzmKNYGRddZET65TOH3rzzpQR0el2DK8=
X-Google-Smtp-Source: AGHT+IFgjCX7b6T7mbh0ViVMGicpC/DaCfIz07Wpfl/pmZh0VIBshCVYBpO+RJhvDcH2HnGIfPB6GohIOiUqcipNCFE=
X-Received: by 2002:a05:6358:7302:b0:135:4003:7857 with SMTP id
 d2-20020a056358730200b0013540037857mr3832327rwg.31.1694718958043; Thu, 14 Sep
 2023 12:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230914170138.995606-1-song@kernel.org>
In-Reply-To: <20230914170138.995606-1-song@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Sep 2023 12:15:21 -0700
Message-ID: <CABCJKufZJstbnjtcwKRY1CSE-eZBnbYScpD6wp9fMXmpFfdBoA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/purgatory: Remove LTO flags
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        Ricardo Ribalda <ribalda@chromium.org>,
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

LGTM, thanks for the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
