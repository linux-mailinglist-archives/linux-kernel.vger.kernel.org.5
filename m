Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11B0808C06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443539AbjLGPiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443495AbjLGPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:38:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EFA9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:38:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A55C433CB;
        Thu,  7 Dec 2023 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701963494;
        bh=wvVN+1YIFHu6pwuC8my2GQeLCZBlFO2tSFyxQF8MEoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BwBLlw5eO1GwXbEIAOPxS00/C0TZYafXou2wc/4do1UG3aFN+nnzSSA5mXnu5gzKN
         ++ArkvzxIsTVYgdlDD09GaZYkw39DyQv1MnL2HE5ZYiAz9G4nwmeRvLiEHI6TF6Xyj
         F7Bc/ntE8UuQznRkoo3k4paYxXtP+YekIgDKu2H+MKFd34HqpLv5BmOkBcd98Pbz5/
         z2/qkCKtoad7MxiAD6wrFdoxf4fJlbly5v09CObEup7PTOfw1PGFtZ+H3Nt1pTXmNL
         dE6ZRSVjo/L+4RdBt852KgFxEL0soBCSeoF9rDgb0+BD0qvXdOf108VvM3RvpnF5ep
         bJkkQ5ND3sEBQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ca0d14976aso11119651fa.2;
        Thu, 07 Dec 2023 07:38:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxqTAcfQiOF++ADXxtRp33L6X1oImJKGUwdKA6Z/W8STMjfgRgT
        mCOZh+pmvmsUEA1DR3zatZUwizz9hSeCalHRIy8=
X-Google-Smtp-Source: AGHT+IFvQXuCu2DYdb90avyxL8P6qli6omWybxLqio1Iex9LuiGceMcEqs0UsqxMj6ERwpyXfaCn99dgbPE4v3Fpqtg=
X-Received: by 2002:a2e:9686:0:b0:2ca:c76:c021 with SMTP id
 q6-20020a2e9686000000b002ca0c76c021mr1610161lji.68.1701963492420; Thu, 07 Dec
 2023 07:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20231206125433.18420-1-tzimmermann@suse.de> <20231206125433.18420-4-tzimmermann@suse.de>
In-Reply-To: <20231206125433.18420-4-tzimmermann@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Dec 2023 16:38:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE7JtotB=V7hrkbseDUwkwgUdkd5ownrsAdhayEqpy4sA@mail.gmail.com>
Message-ID: <CAMj1kXE7JtotB=V7hrkbseDUwkwgUdkd5ownrsAdhayEqpy4sA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arch/x86: Do not include <asm/bootparam.h> in several
 header files
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 13:54, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Remove the include statement for <asm/bootparam.h> from several header
> files that don't require it. Limits the exposure of the boot parameters
> within the Linux kernel code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/include/asm/kexec.h       | 1 -
>  arch/x86/include/asm/mem_encrypt.h | 2 +-
>  arch/x86/include/asm/sev.h         | 3 ++-
>  arch/x86/include/asm/x86_init.h    | 2 --
>  4 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index c9f6a6c5de3c..91ca9a9ee3a2 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -25,7 +25,6 @@
>
>  #include <asm/page.h>
>  #include <asm/ptrace.h>
> -#include <asm/bootparam.h>
>
>  struct kimage;
>
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 359ada486fa9..c1a8a3408c18 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -15,7 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/cc_platform.h>
>
> -#include <asm/bootparam.h>
> +struct boot_params;
>
>  #ifdef CONFIG_X86_MEM_ENCRYPT
>  void __init mem_encrypt_init(void);
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 5b4a1ce3d368..8dad8b1613bf 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -13,7 +13,6 @@
>
>  #include <asm/insn.h>
>  #include <asm/sev-common.h>
> -#include <asm/bootparam.h>
>  #include <asm/coco.h>
>
>  #define GHCB_PROTOCOL_MIN      1ULL
> @@ -22,6 +21,8 @@
>
>  #define        VMGEXIT()                       { asm volatile("rep; vmmcall\n\r"); }
>
> +struct boot_params;
> +
>  enum es_result {
>         ES_OK,                  /* All good */
>         ES_UNSUPPORTED,         /* Requested operation not supported */
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index c878616a18b8..f062715578a0 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -2,8 +2,6 @@
>  #ifndef _ASM_X86_PLATFORM_H
>  #define _ASM_X86_PLATFORM_H
>
> -#include <asm/bootparam.h>
> -
>  struct ghcb;
>  struct mpc_bus;
>  struct mpc_cpu;
> --
> 2.43.0
>
