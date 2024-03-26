Return-Path: <linux-kernel+bounces-119557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9988CA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F22B2877F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB51BC41;
	Tue, 26 Mar 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjUkjYOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941717BA0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473082; cv=none; b=ucfWGMnbWA80BHXNCcf1yI/w+5RodVwt2/kifVx9uHxIYiSPAiQNNkC+1aweUF7vcVoyiYo/09oE77iQkt3INR5DteYb+r/IiPQttCUy+T2Z6zndLmSLI17t34QR07DaHn6LP3o6Vf7XqTjKL+JkzthKqnQi33Ih6PsgHfC+f1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473082; c=relaxed/simple;
	bh=mQUI3GmOLYS1TdPvn+bI+NQ5ZYZ5NHX0vOh6ybKZb7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=tD6o5XIRvmaLvRzTkZ58cJcVB62LQ1Yh8EL3aQezutA1/Mu/PQLWyIbY5nXMj3pictIkhVhmJ0VIdm4o00Pw1oHF8Yf6qzH5Wx07vIXAkGWNdeAu2xioeiyXSNiU4RngMsSNOPoLepONNKwyRAS0k7kufndAmCfeiuf0u2428Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjUkjYOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84394C433C7;
	Tue, 26 Mar 2024 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473081;
	bh=mQUI3GmOLYS1TdPvn+bI+NQ5ZYZ5NHX0vOh6ybKZb7E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AjUkjYOjAPAd5xzCGUlCgqFnK2GN9nKqPs1fYBK6gBeIX0giX6GGNF2Q+OvcmSozA
	 fOAJML5JeIYrsKmlzcI1CJVObPkN24QSniSyS9ifvFNvtX3ZWI1LwWutrxux+KwzEX
	 WCzWGuFNNsow+VbmYQhwUE8pmFIi+d5KdAWvptaiuEjt3IdUcaFch0ec7shzE4SfIq
	 E+3Q4xc5flld+aFyLyv9SRyfVQ4VcWZPysm2ND79bVfNuOObVr1+Ch1av4k75Yn3qg
	 7h4sjONwpOYAnZeBAPa+yy+Tp1uw0BZmTF+c76DPj33TUpNkWMaYNOKp8dk1EygPMm
	 L905a06E4O7Nw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:11:15 +0200
Message-Id: <D03UKKU89SFI.IHNEKQ3LT8CO@kernel.org>
Subject: Re: [PATCH 2/4] kprobes/treewide: Add kprobes_ prefix to insn
 alloc/free functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
Cc: <agordeev@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <aou@eecs.berkeley.edu>, <bp@alien8.de>, <catalin.marinas@arm.com>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>, <gor@linux.ibm.com>,
 <hca@linux.ibm.com>, <jcalvinowens@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <mhiramat@kernel.org>,
 <mingo@redhat.com>, <mpe@ellerman.id.au>, <naveen.n.rao@linux.ibm.com>,
 <palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <tglx@linutronix.de>,
 <will@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-3-mark.rutland@arm.com>
In-Reply-To: <20240326163624.3253157-3-mark.rutland@arm.com>

On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> The alloc_(opt)insn_page() and free_(opt)insn_page() functions are
> specific to KPROBES, but their name makes them sound more generic than
> they are.
>
> Given them a 'kprobes_' prefix to make it clear that they're part of
> kprobes.
>
> This was generated automatically with:
>
>   sed -i 's/alloc_insn_page/kprobes_alloc_insn_page/' $(git grep -l 'allo=
c_insn_page')
>   sed -i 's/free_insn_page/kprobes_free_insn_page/' $(git grep -l 'free_i=
nsn_page')
>   sed -i 's/alloc_optinsn_page/kprobes_alloc_optinsn_page/' $(git grep -l=
 'alloc_optinsn_page')
>   sed -i 's/free_optinsn_page/kprobes_free_optinsn_page/' $(git grep -l '=
free_optinsn_page')
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c |  2 +-
>  arch/powerpc/kernel/kprobes.c      |  2 +-
>  arch/powerpc/kernel/optprobes.c    |  4 ++--
>  arch/riscv/kernel/probes/kprobes.c |  2 +-
>  arch/s390/kernel/kprobes.c         |  2 +-
>  arch/x86/kernel/kprobes/core.c     |  2 +-
>  include/linux/kprobes.h            |  6 +++---
>  kernel/kprobes.c                   | 20 ++++++++++----------
>  8 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probe=
s/kprobes.c
> index 327855a11df2f..4b6ab7b1fa211 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -129,7 +129,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	return 0;
>  }
> =20
> -void *alloc_insn_page(void)
> +void *kprobes_alloc_insn_page(void)
>  {
>  	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>  			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.=
c
> index bbca90a5e2ec0..0b297718d5de6 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -126,7 +126,7 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned lon=
g addr, unsigned long offse
>  	return (kprobe_opcode_t *)(addr + offset);
>  }
> =20
> -void *alloc_insn_page(void)
> +void *kprobes_alloc_insn_page(void)
>  {
>  	void *page;
> =20
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optpro=
bes.c
> index 004fae2044a3e..0ddbda217073f 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -27,7 +27,7 @@
> =20
>  static bool insn_page_in_use;
> =20
> -void *alloc_optinsn_page(void)
> +void *kprobes_alloc_optinsn_page(void)
>  {
>  	if (insn_page_in_use)
>  		return NULL;
> @@ -35,7 +35,7 @@ void *alloc_optinsn_page(void)
>  	return &optinsn_slot;
>  }
> =20
> -void free_optinsn_page(void *page)
> +void kprobes_free_optinsn_page(void *page)
>  {
>  	insn_page_in_use =3D false;
>  }
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 2f08c14a933d0..75201ce721057 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -105,7 +105,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  }
> =20
>  #ifdef CONFIG_MMU
> -void *alloc_insn_page(void)
> +void *kprobes_alloc_insn_page(void)
>  {
>  	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>  				     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
> diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> index f0cf20d4b3c58..91ca4d501d4ef 100644
> --- a/arch/s390/kernel/kprobes.c
> +++ b/arch/s390/kernel/kprobes.c
> @@ -34,7 +34,7 @@ struct kretprobe_blackpoint kretprobe_blacklist[] =3D {=
 };
> =20
>  static int insn_page_in_use;
> =20
> -void *alloc_insn_page(void)
> +void *kprobes_alloc_insn_page(void)
>  {
>  	void *page;
> =20
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/cor=
e.c
> index d0e49bd7c6f3f..7f01bbbfa9e2a 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -491,7 +491,7 @@ static int prepare_singlestep(kprobe_opcode_t *buf, s=
truct kprobe *p,
>  }
> =20
>  /* Make page to RO mode when allocate it */
> -void *alloc_insn_page(void)
> +void *kprobes_alloc_insn_page(void)
>  {
>  	void *page;
> =20
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 0ff44d6633e33..ad4b561100f9e 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -430,10 +430,10 @@ int enable_kprobe(struct kprobe *kp);
> =20
>  void dump_kprobe(struct kprobe *kp);
> =20
> -void *alloc_insn_page(void);
> +void *kprobes_alloc_insn_page(void);
> =20
> -void *alloc_optinsn_page(void);
> -void free_optinsn_page(void *page);
> +void *kprobes_alloc_optinsn_page(void);
> +void kprobes_free_optinsn_page(void *page);
> =20
>  int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *=
type,
>  		       char *sym);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9d9095e817928..35adf56430c9b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -110,7 +110,7 @@ enum kprobe_slot_state {
>  	SLOT_USED =3D 2,
>  };
> =20
> -void __weak *alloc_insn_page(void)
> +void __weak *kprobes_alloc_insn_page(void)
>  {
>  	/*
>  	 * Use module_alloc() so this page is within +/- 2GB of where the
> @@ -121,15 +121,15 @@ void __weak *alloc_insn_page(void)
>  	return module_alloc(PAGE_SIZE);
>  }
> =20
> -static void free_insn_page(void *page)
> +static void kprobes_free_insn_page(void *page)
>  {
>  	module_memfree(page);
>  }
> =20
>  struct kprobe_insn_cache kprobe_insn_slots =3D {
>  	.mutex =3D __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),
> -	.alloc =3D alloc_insn_page,
> -	.free =3D free_insn_page,
> +	.alloc =3D kprobes_alloc_insn_page,
> +	.free =3D kprobes_free_insn_page,
>  	.sym =3D KPROBE_INSN_PAGE_SYM,
>  	.pages =3D LIST_HEAD_INIT(kprobe_insn_slots.pages),
>  	.insn_size =3D MAX_INSN_SIZE,
> @@ -333,21 +333,21 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cac=
he *c, unsigned int *symnum,
>  }
> =20
>  #ifdef CONFIG_OPTPROBES
> -void __weak *alloc_optinsn_page(void)
> +void __weak *kprobes_alloc_optinsn_page(void)
>  {
> -	return alloc_insn_page();
> +	return kprobes_alloc_insn_page();
>  }
> =20
> -void __weak free_optinsn_page(void *page)
> +void __weak kprobes_free_optinsn_page(void *page)
>  {
> -	free_insn_page(page);
> +	kprobes_free_insn_page(page);
>  }
> =20
>  /* For optimized_kprobe buffer */
>  struct kprobe_insn_cache kprobe_optinsn_slots =3D {
>  	.mutex =3D __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
> -	.alloc =3D alloc_optinsn_page,
> -	.free =3D free_optinsn_page,
> +	.alloc =3D kprobes_alloc_optinsn_page,
> +	.free =3D kprobes_free_optinsn_page,
>  	.sym =3D KPROBE_OPTINSN_PAGE_SYM,
>  	.pages =3D LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
>  	/* .insn_size is initialized later */


OK, great, I'll test this.

BR, Jarkko

