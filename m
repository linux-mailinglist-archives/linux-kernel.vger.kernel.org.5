Return-Path: <linux-kernel+bounces-112427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A648879A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47522281A2E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AB51C2A;
	Sat, 23 Mar 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaY48V3t"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C62523C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214160; cv=none; b=PaFthXhuvMjEcgF83mjoHPcqQ7uQ0J02cAHGmiAXjFtEnd3cRyVLZKG6MQmfq5KMXeJZYNAaaYZR3mQPeLUE2LMJK4eT5Un6jCiRki9TZBOE+rA+LSuQkZY+03qmWPsRg1ddh50OjJdyWyu2WPSfkitRG0y277yJzdrO5CeA2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214160; c=relaxed/simple;
	bh=+cAnT9/23YCm1UGxLPoEdmXBizLq9w5uODd4oMKiDzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLiPHt1WTxCCv070JGTlIPCV4as2Dw1DCXPTbcwc+zWzbcRE8kz749RrRG3iODpY6vliEYLXQ0TWatOkgUHRXOT9Uo0mKfJg7YaMUlZbcpcaSqpv3pG/egwfhmrFha4mabUkgrRmLFoeCQ5ZKTndjdi+QE9mxwstyyjeVmsXwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaY48V3t; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d687da75c4so37727251fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214157; x=1711818957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRryrKrDSut7gj25c71ZBHXM/GtVAlA3RqmHC8y+9hU=;
        b=ZaY48V3tlhC/p6YPqyuLTIdoMNlNMMm1Tr+f5Vb5zs6/8kAERDDWqkOZES6dT/hYzb
         iQBwV8DlV4Yz3x/Sj1oirCac+ArgI5FVFBX6V3zENlnerPAGiWvg6i+rff1EYPZ2o6Gs
         qHX4k5QIYp8Pi3Fs2hXv8Rekyr0+1rPjKdW9gZoacGNCgyxQ9VAw0T9XCZM3lJ7/vOr8
         Q7J1toW8ZHvElBeJcEtoYdnLWO6X3GFrMMqX55FB7ii+ox7uICLZbgoPw92v6XLHaM4T
         y3W0juY6ust+PjyuJo6uJsa+oaZoaf6q0e489S+j1qEfLtwvcf7HtCYUGAIZaXeuhWth
         1fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214157; x=1711818957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRryrKrDSut7gj25c71ZBHXM/GtVAlA3RqmHC8y+9hU=;
        b=wUasBp0dZaumoFaoPjXCyUvoj6a55pDqXVDKYKffVtpZ0h/bevTWiAygNcUzgW6A0Q
         MFW53IBCt/Ngg3TdkUxgjbXuTHADKEOOQAofleWgiM53iL/HrOi5/Q3Lc7b/Iv6NZ46Q
         mNIfJqU+tRetEkW+PPWGt7jr7EDIMSD9RU6fSo20SKcF8AsPIgSfuwcsMrEcNtLakGBp
         XWi4n9mqs3Osjo7HVb099h+yggMCF9JwDPwKj/HgWdWzVRuIu0QKWy1CUIlLVmks+EEA
         vSx1kCd58grA/e7zIHB1dh7Bc+wppEwpRNZdkptHpiB7JpfJNJvCWpEtGafQj98YuN+d
         Z4ag==
X-Gm-Message-State: AOJu0YwU9HKyXOAndLQEIATpRSpIqLp5xAgRHA2+UpuxJOT8MMIo6Slj
	BzEaPt6JOPE0vlCshYquPzEsPm5I4I6+3IKiQceplT/ix9fZrAjzDqwpT9I7Kk5GTVK8lURxrsT
	vnpsh4h1pWPJ1f7/rZCOiX9gsH/I=
X-Google-Smtp-Source: AGHT+IH6rcekarx0V1Va8axGFQT0JdfF9Law0ZFrJGb0nr7hDM7wjUh4sTy6N2DlglkXH+IbxoO1/A2pjvxs1xrRP6U=
X-Received: by 2002:a2e:890a:0:b0:2d3:e954:221d with SMTP id
 d10-20020a2e890a000000b002d3e954221dmr1724137lji.34.1711214157095; Sat, 23
 Mar 2024 10:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-13-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-13-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:15:55 +0100
Message-ID: <CAFULd4YQBKxoObJcfg9VutEhApCYUx_u7zBWVHpdPrAqGd92JQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] x86/percpu/64: Remove INIT_PER_CPU macros
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:53=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Now that the load and link addresses of percpu variables are the same,
> these macros are no longer necessary.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/desc.h   |  1 -
>  arch/x86/include/asm/percpu.h | 22 ----------------------
>  arch/x86/kernel/head64.c      |  2 +-
>  arch/x86/kernel/irq_64.c      |  1 -
>  arch/x86/kernel/vmlinux.lds.S |  7 -------
>  arch/x86/tools/relocs.c       |  1 -
>  6 files changed, 1 insertion(+), 33 deletions(-)
>
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index 62dc9f59ea76..ec95fe44fa3a 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -46,7 +46,6 @@ struct gdt_page {
>  } __attribute__((aligned(PAGE_SIZE)));
>
>  DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
> -DECLARE_INIT_PER_CPU(gdt_page);
>
>  /* Provide the original GDT */
>  static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index f6ddbaaf80bc..59d91fdfe037 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -20,12 +20,6 @@
>
>  #define PER_CPU_VAR(var)       __percpu(var)__percpu_rel
>
> -#ifdef CONFIG_X86_64_SMP
> -#define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
> -#else
> -#define INIT_PER_CPU_VAR(var)  var
> -#endif
> -
>  #else /* ...!ASSEMBLY */
>
>  #include <linux/build_bug.h>
> @@ -101,22 +95,6 @@
>  #define __percpu_arg(x)                __percpu_prefix "%" #x
>  #define __force_percpu_arg(x)  __force_percpu_prefix "%" #x
>
> -/*
> - * Initialized pointers to per-cpu variables needed for the boot
> - * processor need to use these macros to get the proper address
> - * offset from __per_cpu_load on SMP.
> - *
> - * There also must be an entry in vmlinux_64.lds.S
> - */
> -#define DECLARE_INIT_PER_CPU(var) \
> -       extern typeof(var) init_per_cpu_var(var)
> -
> -#ifdef CONFIG_X86_64_SMP
> -#define init_per_cpu_var(var)  init_per_cpu__##var
> -#else
> -#define init_per_cpu_var(var)  var
> -#endif
> -
>  /* For arch-specific code, we can use direct single-insn ops (they
>   * don't give an lvalue though). */
>
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 212e8e06aeba..5f0523610e92 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -564,7 +564,7 @@ void __head startup_64_setup_gdt_idt(void)
>         void *handler =3D NULL;
>
>         struct desc_ptr startup_gdt_descr =3D {
> -               .address =3D (unsigned long)&RIP_REL_REF(init_per_cpu_var=
(gdt_page.gdt)),
> +               .address =3D (unsigned long)&RIP_REL_REF(gdt_page.gdt),
>                 .size    =3D GDT_SIZE - 1,
>         };
>
> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index fe0c859873d1..30424f9876bc 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -26,7 +26,6 @@
>  #include <asm/apic.h>
>
>  DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) _=
_visible;
> -DECLARE_INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_VMAP_STACK
>  /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 667202ebd37f..8d5bf4a71e39 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -467,13 +467,6 @@ SECTIONS
>            "kernel image bigger than KERNEL_IMAGE_SIZE");
>
>  #ifdef CONFIG_X86_64
> -/*
> - * Per-cpu symbols which need to be offset from __per_cpu_load
> - * for the boot processor.
> - */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
> -INIT_PER_CPU(gdt_page);
> -INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_MITIGATION_UNRET_ENTRY
>  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return_t=
hunk not cacheline-aligned");
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index e490297a486b..8db231affba2 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -88,7 +88,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES]=
 =3D {
>         "__initramfs_start|"
>         "(jiffies|jiffies_64)|"
>  #if ELF_BITS =3D=3D 64
> -       "init_per_cpu__.*|"
>         "__end_rodata_hpage_align|"
>  #endif
>         "__vvar_page|"
> --
> 2.44.0
>

