Return-Path: <linux-kernel+bounces-118254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88388B6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB78DB23382
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB4200D1;
	Tue, 26 Mar 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzslBCk1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD29282EB;
	Tue, 26 Mar 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416706; cv=none; b=CScmilDHRXHwEXPhyTzJORAgUeXzzniuSms5fSbGRUcDoBaVWVjzM8sAjpm4hA5hjs7+CIHjDVjI8t9Cr024QAukXrMzv74hsxvuAFoCSSF0UFFACXNuvMhG48tUQG4WTMnUCaHczVmGjyskACCvi4qvCvIUUCdIRTqMvFLTL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416706; c=relaxed/simple;
	bh=fyMVCArFo+f8p4yZJMhm4nPq0mpcMqn01kbP8JFPM+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mg0na/zPkpDeS5V4xaYK7R5foLO3duwPoB5AJqMNGx7EeZFkIV8wbxBd21E+g3nJFetFhbmA/wtAbH9Y0/shIcTGVSxdVYbl94aWBI59t7RELlNNG7elbzyJcy2z/4jAa5hEvMtCh77Y5tRslJwMBTrnq7Kc2PWCn97/GXGLU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzslBCk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEE4C433F1;
	Tue, 26 Mar 2024 01:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416706;
	bh=fyMVCArFo+f8p4yZJMhm4nPq0mpcMqn01kbP8JFPM+w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IzslBCk1C74hsa8EtTUZRErzCYazb1ez8+TFdOfWsvRuudRGkP8Usg+3yZnVnKSAf
	 QK6TPzCjn8coUnMfy0q6bNYpZzDYzGFPrVPHJYGLeyLafGa57Q5ehgmYimzYNSDsPH
	 DPINiDT8By+kfJz7cyFzNpWaD+Dn1M/JY4oup9RdIonlGSaDANAo9le0aL55QSB5as
	 5+C5Gmdq+VVnwXHsFvbsYZBPTFNhgc6xrla1LyEVPqk68rNJa/MXhjkrekYuFlFJaG
	 lVgXeka5EdnyDrCK9hCfrePFc57JSmUq1U9YcX5SMPOA+W1UJ1TcS4IPsuHnpclUNZ
	 dcjQyzXEEFSMA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 03:31:42 +0200
Message-Id: <D03AL7A5G3M2.3UK4ASWILGBJS@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240326095836.f43d259b7747269a7c0b9d23@kernel.org>
In-Reply-To: <20240326095836.f43d259b7747269a7c0b9d23@kernel.org>

On Tue Mar 26, 2024 at 2:58 AM EET, Masami Hiramatsu (Google) wrote:
> On Mon, 25 Mar 2024 23:55:01 +0200
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible because CONFIG_KPROBES depends on CONFIG_MODULES because it =
uses
> > the kernel module allocator.
> >=20
> > Introduce alloc_textmem() and free_textmem() for allocating executable
> > memory. If an arch implements these functions, it can mark this up with
> > the HAVE_ALLOC_EXECMEM kconfig flag.
> >=20
> > At first this feature will be used for enabling kprobes without
> > modules support for arch/riscv.
> >=20
> > Link: https://lore.kernel.org/all/20240325115632.04e37297491cadfbbf3827=
67@kernel.org/
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - alloc_execmem() was missing GFP_KERNEL parameter. The patch set did
> >   compile because 2/2 had the fixup (leaked there when rebasing the
> >   patch set).
> > v4:
> > - Squashed a couple of unrequired CONFIG_MODULES checks.
> > - See https://lore.kernel.org/all/D034M18D63EC.2Y11D954YSZYK@kernel.org=
/
> > v3:
> > - A new patch added.
> > - For IS_DEFINED() I need advice as I could not really find that many
> >   locations where it would be applicable.
> > ---
> >  arch/Kconfig                | 16 +++++++++++++++-
> >  include/linux/execmem.h     | 13 +++++++++++++
> >  kernel/kprobes.c            | 17 ++++++++++++++---
> >  kernel/trace/trace_kprobe.c |  8 ++++++++
> >  4 files changed, 50 insertions(+), 4 deletions(-)
> >  create mode 100644 include/linux/execmem.h
> >=20
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index a5af0edd3eb8..33ba68b7168f 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,8 +52,8 @@ config GENERIC_ENTRY
> > =20
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> >  	depends on HAVE_KPROBES
> > +	select ALLOC_EXECMEM
> >  	select KALLSYMS
> >  	select TASKS_RCU if PREEMPTION
> >  	help
> > @@ -215,6 +215,20 @@ config HAVE_OPTPROBES
> >  config HAVE_KPROBES_ON_FTRACE
> >  	bool
> > =20
> > +config HAVE_ALLOC_EXECMEM
> > +	bool
> > +	help
> > +	  Architectures that select this option are capable of allocating exe=
cutable
> > +	  memory, which can be used by subsystems but is not dependent of any=
 of its
> > +	  clients.
> > +
> > +config ALLOC_EXECMEM
> > +	bool "Executable (trampoline) memory allocation"
> > +	depends on MODULES || HAVE_ALLOC_EXECMEM
> > +	help
> > +	  Select this for executable (trampoline) memory. Can be enabled when=
 either
> > +	  module allocator or arch-specific allocator is available.
> > +
> >  config ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> >  	bool
> >  	help
> > diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> > new file mode 100644
> > index 000000000000..ae2ff151523a
> > --- /dev/null
> > +++ b/include/linux/execmem.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_EXECMEM_H
> > +#define _LINUX_EXECMEM_H
> > +
> > +#ifdef CONFIG_HAVE_ALLOC_EXECMEM
> > +void *alloc_execmem(unsigned long size, gfp_t gfp);
> > +void free_execmem(void *region);
> > +#else
> > +#define alloc_execmem(size, gfp)	module_alloc(size)
> > +#define free_execmem(region)		module_memfree(region)
> > +#endif
> > +
> > +#endif /* _LINUX_EXECMEM_H */
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..87fd8c14a938 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -44,6 +44,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/errno.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/execmem.h>
> > =20
> >  #define KPROBE_HASH_BITS 6
> >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > @@ -113,17 +114,17 @@ enum kprobe_slot_state {
> >  void __weak *alloc_insn_page(void)
> >  {
> >  	/*
> > -	 * Use module_alloc() so this page is within +/- 2GB of where the
> > +	 * Use alloc_execmem() so this page is within +/- 2GB of where the
> >  	 * kernel image and loaded module images reside. This is required
> >  	 * for most of the architectures.
> >  	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
> >  	 */
> > -	return module_alloc(PAGE_SIZE);
> > +	return alloc_execmem(PAGE_SIZE, GFP_KERNEL);
> >  }
> > =20
> >  static void free_insn_page(void *page)
> >  {
> > -	module_memfree(page);
> > +	free_execmem(page);
> >  }
> > =20
> >  struct kprobe_insn_cache kprobe_insn_slots =3D {
> > @@ -1580,6 +1581,7 @@ static int check_kprobe_address_safe(struct kprob=
e *p,
> >  		goto out;
> >  	}
> > =20
> > +#ifdef CONFIG_MODULES
>
> You don't need this block, because these APIs have dummy functions.

Hmm... I'll verify this tomorrow.

>
> >  	/* Check if 'p' is probing a module. */
> >  	*probed_mod =3D __module_text_address((unsigned long) p->addr);
> >  	if (*probed_mod) {
>
> So this block never be true if !CONFIG_MODULES automatically, and it shou=
ld be
> optimized out by compiler.

Yeah sure, was not done for saving cycles. Just wanted to make sure that
my stuff compiles with different config flag combinations related but
I'll check tomorrow morning if I can relax this further.

>
> > @@ -1603,6 +1605,8 @@ static int check_kprobe_address_safe(struct kprob=
e *p,
> >  			ret =3D -ENOENT;
> >  		}
> >  	}
> > +#endif
> > +
> >  out:
> >  	preempt_enable();
> >  	jump_label_unlock();
> > @@ -2482,6 +2486,7 @@ int kprobe_add_area_blacklist(unsigned long start=
, unsigned long end)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_MODULES
> >  /* Remove all symbols in given area from kprobe blacklist */
> >  static void kprobe_remove_area_blacklist(unsigned long start, unsigned=
 long end)
> >  {
> > @@ -2499,6 +2504,7 @@ static void kprobe_remove_ksym_blacklist(unsigned=
 long entry)
> >  {
> >  	kprobe_remove_area_blacklist(entry, entry + 1);
> >  }
> > +#endif /* CONFIG_MODULES */
>
> I think this block should be moved right before remove_module_kprobe_blac=
klist().
> Then we can gather the code depending on modules in one place.

Agree with this without verification :-)


>
> > =20
> >  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long=
 *value,
> >  				   char *type, char *sym)
> > @@ -2564,6 +2570,7 @@ static int __init populate_kprobe_blacklist(unsig=
ned long *start,
> >  	return ret ? : arch_populate_kprobe_blacklist();
> >  }
> > =20
> > +#ifdef CONFIG_MODULES
> >  static void add_module_kprobe_blacklist(struct module *mod)
> >  {
> >  	unsigned long start, end;
> > @@ -2665,6 +2672,7 @@ static struct notifier_block kprobe_module_nb =3D=
 {
> >  	.notifier_call =3D kprobes_module_callback,
> >  	.priority =3D 0
> >  };
> > +#endif /* CONFIG_MODULES */
>
> So, keep the kprobe_module_nb outside of this #ifdef as I sed.

Yup, already done in v6.

>
>
> > =20
> >  void kprobe_free_init_mem(void)
> >  {
> > @@ -2724,8 +2732,11 @@ static int __init init_kprobes(void)
> >  	err =3D arch_init_kprobes();
> >  	if (!err)
> >  		err =3D register_die_notifier(&kprobe_exceptions_nb);
> > +
> > +#ifdef CONFIG_MODULES
> >  	if (!err)
> >  		err =3D register_module_notifier(&kprobe_module_nb);
> > +#endif
>
> Then we don't need this #ifdef.

Addressed in v6.

>
> > =20
> >  	kprobes_initialized =3D (err =3D=3D 0);
> >  	kprobe_sysctls_init();
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index c4c6e0e0068b..af70bb1e9c3a 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_mod=
ule(struct trace_kprobe *tk,
> >  	return strncmp(module_name(mod), name, len) =3D=3D 0 && name[len] =3D=
=3D ':';
> >  }
> > =20
> > +#ifdef CONFIG_MODULES
> >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kpr=
obe *tk)
> >  {
> >  	char *p;
> > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exi=
st(struct trace_kprobe *tk)
> > =20
> >  	return ret;
> >  }
> > +#else
> > +#define trace_kprobe_module_exist(tk) false /* aka a module never exis=
ts */
> > +#endif /* CONFIG_MODULES */
> > =20
> >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> >  {
> > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprob=
e *tk)
> >  	return ret;
> >  }
> > =20
> > +#ifdef CONFIG_MODULES
> >  /* Module notifier call back, checking event on the module */
> >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> >  				       unsigned long val, void *data)
> > @@ -704,6 +709,7 @@ static struct notifier_block trace_kprobe_module_nb=
 =3D {
> >  	.notifier_call =3D trace_kprobe_module_callback,
> >  	.priority =3D 1	/* Invoked after kprobe module callback */
> >  };
> > +#endif /* CONFIG_MODULES */
>
> As I similar to the above, let's move trace_kprobe_module_nb outside
> of #ifdef.

Ditto (also in v6).

>
> > =20
> >  static int count_symbols(void *data, unsigned long unused)
> >  {
> > @@ -1897,8 +1903,10 @@ static __init int init_kprobe_trace_early(void)
> >  	if (ret)
> >  		return ret;
> > =20
> > +#ifdef CONFIG_MODULES
> >  	if (register_module_notifier(&trace_kprobe_module_nb))
> >  		return -EINVAL;
> > +#endif /* CONFIG_MODULES */
>
> And remove this #ifdef.
>
> Thank you!

Thanks for quick reviews and sorry for the spam. I just try to move this
forward with small pushes because with compilation flags it is easy to
blow up compilation.

I'll do the aforementioned suggestions that were missing from v6 to v7.

>
> > =20
> >  	return 0;
> >  }
> > --=20
> > 2.44.0
> >=20


BR, Jarkko

