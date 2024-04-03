Return-Path: <linux-kernel+bounces-130208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00674897563
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7581F27083
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9014C58A;
	Wed,  3 Apr 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWDZvyOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296671B7F4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162438; cv=none; b=f5Pp/IcS42L1gMBsAwxq4xeHvx3U7T4Z9l2QioBUVDFT4oFUF7L4EMkwadf9m5APYSRvFoUSMbhn2/UL08TCifUDP5Rh53jTMKQ0yQox6+lkxE2zyh6z00xFDq8D81uetoEMwdSQBBhAiLf4ahsIqcmoLbg9GzGPGQ16F3R3fbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162438; c=relaxed/simple;
	bh=7Ip43YcwmnuH9bhF9pf3iTFeDXUcpz6/2V40eu0FyHg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ENev7btVsVHEFpDXWtMMkhoo394epLgR0S3/FHLIVmKn3nRCmInCYF0Bbqe3dsJBf1LIMQrDlT+LoULJqsyjxiknY7DUktfZFsapoShYoHK0fKjicNpDnwttqUawGkwMRWIoLbLb/5IEMRXWnoi8f1v6WLldhdps3Tcdtznr6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWDZvyOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A351C433C7;
	Wed,  3 Apr 2024 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712162437;
	bh=7Ip43YcwmnuH9bhF9pf3iTFeDXUcpz6/2V40eu0FyHg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rWDZvyOYC/L3CancgYptl4auRHe2yVlt1x4pLQWhcq3nAiyk+PTKMIlMMWPz3s1jh
	 4fRA1weWExd+FCH3anTrtDCF89vrZadhrXFOWJRYbdLka5t8vm5NrAfQm2398G7gY4
	 NIDMXDtLsuEBUvgZftd4p7sXuTq8Ul4YfBBW/1S7voGkqPEFeMqK27eehN7ymXozqF
	 ZxWrrTLO1d/C82m3l0voOpdgWtUqw/qX0HkEXGPS4Fk9B9my8ZFnhy37wjKSD8nY6J
	 h0muIiXoWqqK87VlJaFRbvbhoXWn1uQnG8I6FxSdz+NQgrBUYtbQxb0WXSsogNOmwV
	 5ctnI/Vz0ajVg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 19:40:33 +0300
Message-Id: <D0AMXFFH9WX8.3G0IX3GW60V7W@kernel.org>
Cc: <anil.s.keshavamurthy@intel.com>, <aou@eecs.berkeley.edu>,
 <catalin.marinas@arm.com>, <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>, <mhiramat@kernel.org>,
 <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <will@kernel.org>
Subject: Re: [PATCH v2 3/4] kprobes/treewide: Explicitly override alloc/free
 functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-4-mark.rutland@arm.com>
In-Reply-To: <20240403150154.667649-4-mark.rutland@arm.com>

On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> Currently architectures can override kprobes_alloc_insn_page(), but
> kprobes_free_insn_page() is always implemented using module_memfree(),
> which might not be what an architecture needs, especially as we'd like
> to make it possible to use kprobes without requiring MODULES.
>
> It would be nicer if architectures either:
>
> (a) Used only the generic kprobes_alloc_insn_page() and
>     kprobes_free_insn_page(), implicitly depending on MODULES.
>
> (b) Provided their own implementation of both kprobes_alloc_insn_page()
>     and kprobes_free_insn_page(), handling the relevant dependencies
>     themselves.
>
> This patch applies that split treewide:
>
> (a) Architectures using the generic kprobes_free_insn_page() and
>     kprobes_free_insn_page() are left as-is. The __weak annotation is
>     removed from the generic implementations so that accidental
>     overrides/misuse can be detected easily.
>
> (b) Architectures which provide their own kprobes_free_insn_page() are
>     given a matching implementation of kprobes_free_insn_page(), and
>     select HAVE_KPROBES_ALLOC.
>
>     This new Kconfig symbol will allow subsequent patches to relax the
>     dependency on MODULES to (MODULES || HAVE_KPROBES_ALLOC) once other
>     module dependencies in the core kprobes code are cleaned up.
>
>     Architectures which use module_alloc() are given an implementation
>     using module_memfree() along with an explicit dependency on MODULES.
>
>     Architectures using __vmalloc_node_range() are given an
>     implementation using vfree(). This loses the warning for
>     in_interrupt(), but vfree() can handle this via vfree_atomic(), so
>     the warning isn't necessary.
>
>     On riscv, the allocator depends on !XIP_KERNEL, which is already a
>     dependency for HAVE_KPROBES in arch/riscv/Kconfig.
>
> As of this patch arm64 and riscv have kprobe allocation functions which
> do not explicitly depend on MODULES. The core kprobes code still depends
> on MODULES.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/Kconfig                       | 3 +++
>  arch/arm64/Kconfig                 | 1 +
>  arch/arm64/kernel/probes/kprobes.c | 5 +++++
>  arch/powerpc/Kconfig               | 3 ++-
>  arch/powerpc/kernel/kprobes.c      | 5 +++++
>  arch/riscv/Kconfig                 | 1 +
>  arch/riscv/kernel/probes/kprobes.c | 5 +++++
>  arch/s390/Kconfig                  | 3 ++-
>  arch/s390/kernel/kprobes.c         | 5 +++++
>  arch/x86/Kconfig                   | 3 ++-
>  arch/x86/kernel/kprobes/core.c     | 5 +++++
>  include/linux/kprobes.h            | 1 +
>  kernel/kprobes.c                   | 6 ++++--
>  13 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9f066785bb71d..85bb59f7b8c07 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -206,6 +206,9 @@ config HAVE_IOREMAP_PROT
>  config HAVE_KPROBES
>  	bool
> =20
> +config HAVE_KPROBES_ALLOC
> +	bool
> +
>  config HAVE_KRETPROBES
>  	bool
> =20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b11c98b3e84b..bda7913d6c9b8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -233,6 +233,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> +	select HAVE_KPROBES_ALLOC
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probe=
s/kprobes.c
> index 4b6ab7b1fa211..69d19a390cd48 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -136,6 +136,11 @@ void *kprobes_alloc_insn_page(void)
>  			NUMA_NO_NODE, __builtin_return_address(0));
>  }
> =20
> +void kprobes_free_insn_page(void *page)
> +{
> +	vfree(page);
> +}
> +
>  /* arm kprobe: install breakpoint in text */
>  void __kprobes arch_arm_kprobe(struct kprobe *p)
>  {
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1c4be33736860..13e0fc51dcdcf 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -254,7 +254,8 @@ config PPC
>  	select HAVE_KERNEL_LZMA			if DEFAULT_UIMAGE
>  	select HAVE_KERNEL_LZO			if DEFAULT_UIMAGE
>  	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
> -	select HAVE_KPROBES
> +	select HAVE_KPROBES			if MODULES
> +	select HAVE_KPROBES_ALLOC
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
>  	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if HAVE_OBJTOOL_MCOUNT && (!A=
RCH_USING_PATCHABLE_FUNCTION_ENTRY || (!CC_IS_GCC || GCC_VERSION >=3D 11010=
0))
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.=
c
> index 0b297718d5de6..d0332aaebab09 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -146,6 +146,11 @@ void *kprobes_alloc_insn_page(void)
>  	return NULL;
>  }
> =20
> +void kprobes_free_insn_page(void *page)
> +{
> +	module_memfree(page);
> +}
> +
>  int arch_prepare_kprobe(struct kprobe *p)
>  {
>  	int ret =3D 0;
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56b..4e22549a522a5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -139,6 +139,7 @@ config RISCV
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KPROBES if !XIP_KERNEL
> +	select HAVE_KPROBES_ALLOC
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
>  	# https://github.com/ClangBuiltLinux/linux/issues/1881
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 75201ce721057..37fdfa952d999 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -112,6 +112,11 @@ void *kprobes_alloc_insn_page(void)
>  				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>  				     __builtin_return_address(0));
>  }
> +
> +void kprobes_free_insn_page(void *page)
> +{
> +	vfree(page);
> +}
>  #endif
> =20
>  /* install breakpoint in text */
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8f01ada6845e3..635eddc3fce80 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -193,7 +193,8 @@ config S390
>  	select HAVE_KERNEL_UNCOMPRESSED
>  	select HAVE_KERNEL_XZ
>  	select HAVE_KERNEL_ZSTD
> -	select HAVE_KPROBES
> +	select HAVE_KPROBES		if MODULES
> +	select HAVE_KPROBES_ALLOC
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
>  	select HAVE_LIVEPATCH
> diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> index 91ca4d501d4ef..a5b142b8eb0f7 100644
> --- a/arch/s390/kernel/kprobes.c
> +++ b/arch/s390/kernel/kprobes.c
> @@ -45,6 +45,11 @@ void *kprobes_alloc_insn_page(void)
>  	return page;
>  }
> =20
> +void kprobes_free_insn_page(void *page)
> +{
> +	module_memfree(page);
> +}
> +
>  static void *alloc_s390_insn_page(void)
>  {
>  	if (xchg(&insn_page_in_use, 1) =3D=3D 1)
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4fff6ed46e902..0810cd0bdeca9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -240,7 +240,8 @@ config X86
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_XZ
>  	select HAVE_KERNEL_ZSTD
> -	select HAVE_KPROBES
> +	select HAVE_KPROBES			if MODULES
> +	select HAVE_KPROBES_ALLOC
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_KRETPROBES
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/cor=
e.c
> index 7f01bbbfa9e2a..5f093b94d9b40 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -508,6 +508,11 @@ void *kprobes_alloc_insn_page(void)
>  	return page;
>  }
> =20
> +void kprobes_free_insn_page(void *page)
> +{
> +	module_memfree(page);
> +}
> +
>  /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers=
 */
> =20
>  static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs =
*regs)
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index ad4b561100f9e..651c807727bea 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -431,6 +431,7 @@ int enable_kprobe(struct kprobe *kp);
>  void dump_kprobe(struct kprobe *kp);
> =20
>  void *kprobes_alloc_insn_page(void);
> +void kprobes_free_insn_page(void *page);
> =20
>  void *kprobes_alloc_optinsn_page(void);
>  void kprobes_free_optinsn_page(void *page);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 35adf56430c9b..fa2ee4e59eca2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -110,7 +110,8 @@ enum kprobe_slot_state {
>  	SLOT_USED =3D 2,
>  };
> =20
> -void __weak *kprobes_alloc_insn_page(void)
> +#ifndef CONFIG_HAVE_KPROBES_ALLOC
> +void *kprobes_alloc_insn_page(void)
>  {
>  	/*
>  	 * Use module_alloc() so this page is within +/- 2GB of where the
> @@ -121,10 +122,11 @@ void __weak *kprobes_alloc_insn_page(void)
>  	return module_alloc(PAGE_SIZE);
>  }
> =20
> -static void kprobes_free_insn_page(void *page)
> +void kprobes_free_insn_page(void *page)
>  {
>  	module_memfree(page);
>  }
> +#endif
> =20
>  struct kprobe_insn_cache kprobe_insn_slots =3D {
>  	.mutex =3D __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

