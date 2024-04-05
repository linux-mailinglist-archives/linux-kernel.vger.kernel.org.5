Return-Path: <linux-kernel+bounces-132369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7F78993A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F53287191
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA252032D;
	Fri,  5 Apr 2024 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKFevKn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D467200C1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286796; cv=none; b=Y6AT/5kLWuoFFsF+SiNh90ceRZlqqfYbEcFnKOqjzB5sF1R8Ww5S/fctod/jePVoZju9wN7Jvuo6LF5PwII8BiurAVW5byJNJ1c/NdBv9Tr5AUg1O3e5Q0zJNTcHSE/vg8bknrbHTK2DRJ02zC6WbOtRkV2YDaiov9gsLbbKCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286796; c=relaxed/simple;
	bh=EMELq0obr0iUNDd/t6whIzR6WpNBCIGq8hfw5S0tzpI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tvokItdzJU1sBjrtp2h2N7s6M1a4QCaxlPZZVmdeCyMkYW/IFUD6DUsps1GQPjp531ENkqH87l7kYKzapMWLpjv5Hl0Y7662Srb34SlQa2if8cw/jgH0VBnaicrxLbJ/KdXi3g7vrbimCzHgpJE83bsXo0zzViLbZnggrQexeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKFevKn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B567C433C7;
	Fri,  5 Apr 2024 03:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712286795;
	bh=EMELq0obr0iUNDd/t6whIzR6WpNBCIGq8hfw5S0tzpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nKFevKn1KGCLwolbC5odIVeymRo3Z9TMw1pEY0yYMFdXvglL4PVrR4U1BGK/MkCsz
	 IIcfC27MzjSFwumaZ1aFcTbNuGB5R2ng9gYz13ZldgTiYBtXFIn7a/0vQ8FiQ8Y0zs
	 4KPk2I69A5MKytdKnnF8jsGW6Rf5WZJuQQyJhXDsa7uzJDH7m9fN4EGMWFAYusvKOI
	 cX1MutRaU/Sji6ixCViCBH6yqP9xl4d4KIE3OKkumIULQZ5K5i96PG/4ewbHhUsdXn
	 5V24dltyMdw7IqVKsXB9E7aCRy8iZP4e0fu9ljsby/pjIpAu11moAZQdNMc0YliHUf
	 5ThmJmhg3Agxw==
Date: Fri, 5 Apr 2024 12:13:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, aou@eecs.berkeley.edu,
 catalin.marinas@arm.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, naveen.n.rao@linux.ibm.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, will@kernel.org
Subject: Re: [PATCH v2 4/4] kprobes: Remove core dependency on modules
Message-Id: <20240405121310.171d3bc0172f8f604a45c15f@kernel.org>
In-Reply-To: <Zg7Zi9Gfa3jWNJ6q@FVFF77S0Q05N.cambridge.arm.com>
References: <20240403150154.667649-1-mark.rutland@arm.com>
	<20240403150154.667649-5-mark.rutland@arm.com>
	<D0B6SY8DJ5RC.KLZ08YRNLOH3@kernel.org>
	<D0BFT1AHHVYR.2V75A0HT23T67@kernel.org>
	<20240405011026.8e96b1d129452f84210b6f66@kernel.org>
	<Zg7Zi9Gfa3jWNJ6q@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 17:47:07 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Apr 05, 2024 at 01:10:26AM +0900, Masami Hiramatsu wrote:
> > On Thu, 04 Apr 2024 18:18:21 +0300
> > "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
> > 
> > > On Thu Apr 4, 2024 at 11:15 AM EEST, Jarkko Sakkinen wrote:
> > > > On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> > > > > From: Jarkko Sakkinen <jarkko@kernel.org>
> > > > >
> > > > > Tracing with kprobes while running a monolithic kernel is currently
> > > > > impossible because KPROBES depends on MODULES. While this dependency is
> > > > > necessary when HAVE_KPROBES_ALLOC=n and the core kprobes code allocates
> > > > > memory using module_alloc(), all the other module-specific code only
> > > > > exist to handle the case when MODULES=y, and can be hidden behind
> > > > > ifdeffery.
> > > > >
> > > > > Add the necessary ifdeffery, and remove the dependency on MODULES=y when
> > > > > HAVE_KPROBES_ALLOC=y.
> > > > >
> > > > > As of this patch kprobes can be used when MODULES=n on arm64 and
> > > > > riscv. All other architectures still depend on MODULES, either by virtue
> > > > > of the core dependency on MODULES when HAVE_KPROBES_ALLOC=n, or by
> > > > > virtue of an explciit dependency on MODULES in arch code.
> > > > >
> > > > > Other architectures can enable support by implementing their own
> > > > > kprobes_alloc_insn_page() and kprobes_free_insn_page() which do not
> > > > > depend on MODULES.
> > > > >
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > Link: https://lore.kernel.org/lkml/20240326134616.7691-1-jarkko@kernel.org/
> > > > > [Mark: Remove execmem changes, depend on HAVE_KPROBES_ALLOC]
> > > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > > > > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: David S. Miller <davem@davemloft.net>
> > > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> > > > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > > > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > ---
> > > > >  arch/Kconfig                |  2 +-
> > > > >  kernel/kprobes.c            | 46 ++++++++++++++++++++++---------------
> > > > >  kernel/trace/trace_kprobe.c | 15 ++++++++++--
> > > > >  3 files changed, 41 insertions(+), 22 deletions(-)
> > > > >
> > > > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > > > index 85bb59f7b8c07..0df2c88547b3c 100644
> > > > > --- a/arch/Kconfig
> > > > > +++ b/arch/Kconfig
> > > > > @@ -52,7 +52,7 @@ config GENERIC_ENTRY
> > > > >  
> > > > >  config KPROBES
> > > > >  	bool "Kprobes"
> > > > > -	depends on MODULES
> > > > > +	depends on MODULES || HAVE_KPROBES_ALLOC
> > > > >  	depends on HAVE_KPROBES
> > > > >  	select KALLSYMS
> > > > >  	select TASKS_RCU if PREEMPTION
> > > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > > index fa2ee4e59eca2..ec4493a41b505 100644
> > > > > --- a/kernel/kprobes.c
> > > > > +++ b/kernel/kprobes.c
> > > > > @@ -1594,6 +1594,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > > > >  			goto out;
> > > > >  		}
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > > >  		/*
> > > > >  		 * If the module freed '.init.text', we couldn't insert
> > > > >  		 * kprobes in there.
> > > > > @@ -1604,7 +1605,9 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > > > >  			*probed_mod = NULL;
> > > > >  			ret = -ENOENT;
> > > > >  		}
> > > > > +#endif /* CONFIG_MODULES */
> > > > >  	}
> > > > > +
> > > > >  out:
> > > > >  	preempt_enable();
> > > > >  	jump_label_unlock();
> > > > > @@ -2484,24 +2487,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > -/* Remove all symbols in given area from kprobe blacklist */
> > > > > -static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> > > > > -{
> > > > > -	struct kprobe_blacklist_entry *ent, *n;
> > > > > -
> > > > > -	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> > > > > -		if (ent->start_addr < start || ent->start_addr >= end)
> > > > > -			continue;
> > > > > -		list_del(&ent->list);
> > > > > -		kfree(ent);
> > > > > -	}
> > > > > -}
> > > > > -
> > > > > -static void kprobe_remove_ksym_blacklist(unsigned long entry)
> > > > > -{
> > > > > -	kprobe_remove_area_blacklist(entry, entry + 1);
> > > > > -}
> > > > > -
> > > > >  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> > > > >  				   char *type, char *sym)
> > > > >  {
> > > > > @@ -2566,6 +2551,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
> > > > >  	return ret ? : arch_populate_kprobe_blacklist();
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > > > +/* Remove all symbols in given area from kprobe blacklist */
> > > > > +static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> > > > > +{
> > > > > +	struct kprobe_blacklist_entry *ent, *n;
> > > > > +
> > > > > +	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> > > > > +		if (ent->start_addr < start || ent->start_addr >= end)
> > > > > +			continue;
> > > > > +		list_del(&ent->list);
> > > > > +		kfree(ent);
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static void kprobe_remove_ksym_blacklist(unsigned long entry)
> > > > > +{
> > > > > +	kprobe_remove_area_blacklist(entry, entry + 1);
> > > > > +}
> > > > > +
> > > > >  static void add_module_kprobe_blacklist(struct module *mod)
> > > > >  {
> > > > >  	unsigned long start, end;
> > > > > @@ -2662,6 +2666,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
> > > > >  	mutex_unlock(&kprobe_mutex);
> > > > >  	return NOTIFY_DONE;
> > > > >  }
> > > > > +#else
> > > > > +#define kprobes_module_callback	(NULL)
> > > > > +#endif /* CONFIG_MODULES */
> > > > >  
> > > > >  static struct notifier_block kprobe_module_nb = {
> > > > >  	.notifier_call = kprobes_module_callback,
> > > > > @@ -2726,7 +2733,8 @@ static int __init init_kprobes(void)
> > > > >  	err = arch_init_kprobes();
> > > > >  	if (!err)
> > > > >  		err = register_die_notifier(&kprobe_exceptions_nb);
> > > > > -	if (!err)
> > > > > +
> > > > > +	if (!err && IS_ENABLED(CONFIG_MODULES))
> > > > >  		err = register_module_notifier(&kprobe_module_nb);
> > > > >  
> > > > >  	kprobes_initialized = (err == 0);
> > > > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > > > index 14099cc17fc9e..c509ba776e679 100644
> > > > > --- a/kernel/trace/trace_kprobe.c
> > > > > +++ b/kernel/trace/trace_kprobe.c
> > > > > @@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> > > > >  	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > > >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > > > >  {
> > > > >  	char *p;
> > > > > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > > > >  
> > > > >  	return ret;
> > > > >  }
> > > > > +#else
> > > > > +#define trace_kprobe_module_exist(tk) false /* aka a module never exists */
> > > > > +#endif /* CONFIG_MODULES */
> > > > >  
> > > > >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> > > > >  {
> > > > > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > > >  /* Module notifier call back, checking event on the module */
> > > > >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> > > > >  				       unsigned long val, void *data)
> > > > > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
> > > > >  
> > > > >  	return NOTIFY_DONE;
> > > > >  }
> > > > > +#else
> > > > > +#define trace_kprobe_module_callback (NULL)
> > > > > +#endif /* CONFIG_MODULES */
> > > > >  
> > > > >  static struct notifier_block trace_kprobe_module_nb = {
> > > > >  	.notifier_call = trace_kprobe_module_callback,
> > > > > @@ -1933,8 +1941,11 @@ static __init int init_kprobe_trace_early(void)
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > >  
> > > > > -	if (register_module_notifier(&trace_kprobe_module_nb))
> > > > > -		return -EINVAL;
> > > > > +	if (IS_ENABLED(CONFIG_MODULES)) {
> > > > > +		ret = register_module_notifier(&trace_kprobe_module_nb);
> > > > > +		if (ret)
> > > > > +			return -EINVAL;
> > > > > +	}
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > >
> > > > 2/4, 3/4, 4/4:
> > > >
> > > > Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # arch/riscv
> > > 
> > > Hey, I tried the pci_proc_init example:
> > > 
> > > [    3.060703] ------------[ ftrace bug ]------------
> > > [    3.060944] ftrace faulted on writing
> > > [    3.060987] [<ffffffff8102c0da>] pci_proc_init+0x0/0x80
> > > [    3.061509] Updating ftrace call site to call a different ftrace function
> > > [    3.061756] ftrace record flags: 80100001
> > > [    3.061925]  (1)
> > > [    3.061925]  expected tramp: ffffffff8000aa60
> > > [    3.062527] ------------[ cut here ]------------
> > > [    3.062652] WARNING: CPU: 0 PID: 18 at kernel/trace/ftrace.c:2180 ftrace_bug+0x282/0x2b8
> > > [    3.062747] CPU: 0 PID: 18 Comm: migration/0 Not tainted 6.9.0-rc1 #2
> > > [    3.062807] Hardware name: riscv-virtio,qemu (DT)
> > > [    3.062868] Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x140/0x18c
> > > [    3.062925] epc : ftrace_bug+0x282/0x2b8
> > > [    3.062957]  ra : ftrace_bug+0x282/0x2b8
> > > [    3.062989] epc : ffffffff80fc31f4 ra : ffffffff80fc31f4 sp : ff20000000093c70
> > > [    3.063014]  gp : ffffffff824b7780 tp : ff60000002a85940 t0 : ffffffff800923a6
> > > [    3.063037]  t1 : 0000000000000020 t2 : 6465746365707865 s0 : ff20000000093cb0
> > > [    3.063061]  s1 : ffffffff8102c0da a0 : 0000000000000022 a1 : ffffffff8229b7f0
> > > [    3.063084]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
> > > [    3.063108]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000001
> > > [    3.063131]  s2 : ff60000002850ab0 s3 : ffffffffffffffff s4 : 0000000000000002
> > > [    3.063154]  s5 : 0000000002000000 s6 : 0000000082000000 s7 : 0000000000000000
> > > [    3.063178]  s8 : 0000000000000001 s9 : ffffffff824bca18 s10: ff60000002845140
> > > [    3.063202]  s11: 00000000000000ab t3 : ffffffff824ce9ef t4 : ffffffff824ce9ef
> > > [    3.063225]  t5 : ffffffff824ce9f0 t6 : ff20000000093aa8
> > > [    3.063248] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> > > [    3.063331] [<ffffffff80fc31f4>] ftrace_bug+0x282/0x2b8
> > > [    3.063398] [<ffffffff80108b1a>] ftrace_replace_code+0xfe/0x168
> > > [    3.063430] [<ffffffff80108c82>] ftrace_modify_all_code+0x5c/0x16a
> > > [    3.063460] [<ffffffff80108da2>] __ftrace_modify_code+0x12/0x1c
> > > [    3.063490] [<ffffffff800f299c>] multi_cpu_stop+0x118/0x1a0
> > > [    3.063519] [<ffffffff800f242e>] cpu_stopper_thread+0xb2/0x12a
> > > [    3.063548] [<ffffffff8005dece>] smpboot_thread_fn+0x1aa/0x1d2
> > > [    3.063577] [<ffffffff80057fec>] kthread+0xfe/0x106
> > > [    3.063606] [<ffffffff80fe3d76>] ret_from_fork+0xe/0x20
> > > [    3.063676] ---[ end trace 0000000000000000 ]---
> > > [    3.069730] ------------[ cut here ]------------
> > > [    3.069861] Failed to disarm kprobe-ftrace at pci_proc_init+0x0/0x80 (error -19)
> > > [    3.070078] WARNING: CPU: 0 PID: 1 at kernel/kprobes.c:1128 __disarm_kprobe_ftrace+0x9a/0xae
> > > [    3.070124] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.9.0-rc1 #2
> > > [    3.070133] Hardware name: riscv-virtio,qemu (DT)
> > > [    3.070141] epc : __disarm_kprobe_ftrace+0x9a/0xae
> > > [    3.070150]  ra : __disarm_kprobe_ftrace+0x9a/0xae
> > > [    3.070157] epc : ffffffff800ffcda ra : ffffffff800ffcda sp : ff2000000000be30
> > > [    3.070162]  gp : ffffffff824b7780 tp : ff60000002a70000 t0 : ffffffff800923a6
> > > [    3.070167]  t1 : 0000000000000046 t2 : 6f742064656c6961 s0 : ff2000000000be60
> > > [    3.070173]  s1 : ffffffffffffffed a0 : 0000000000000044 a1 : ffffffff8229b7f0
> > > [    3.070178]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
> > > [    3.070182]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000001
> > > [    3.070187]  s2 : ffffffff824bc940 s3 : ffffffff822ac158 s4 : ff60000002b53c80
> > > [    3.070192]  s5 : ffffffff824bc940 s6 : ffffffff822ac158 s7 : ffffffff81000000
> > > [    3.070197]  s8 : ffffffff814775f8 s9 : ffffffff824f23d8 s10: 0000000000000000
> > > [    3.070202]  s11: 0000000000000000 t3 : ffffffff824ce9d7 t4 : ffffffff824ce9d7
> > > [    3.070206]  t5 : ffffffff824ce9d8 t6 : ff2000000000bc48
> > > [    3.070211] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> > > [    3.070218] [<ffffffff800ffcda>] __disarm_kprobe_ftrace+0x9a/0xae
> > > [    3.070228] [<ffffffff80101b16>] kprobe_free_init_mem+0xc2/0x130
> > > [    3.070236] [<ffffffff80fd9b38>] kernel_init+0x46/0x14e
> > > [    3.070245] [<ffffffff80fe3d76>] ret_from_fork+0xe/0x20
> > > [    3.070254] ---[ end trace 0000000000000000 ]---
> > > [
> > > 
> > > This is with riscv64 defconfig, tracing shenanigans and the following
> > > bootconfig and the bug was realized in QEMU:
> > 
> > So this is with CONFIG_MODULES=y?
> > This seems like an actual bug but not related to this series.
> > Can you reproduce this without this patch series?
> 
> IIUC what's going on here is:
> 
> CONFIG_MODULES=n
> 
> . and so CONFIG_STRICT_MODULE_RWX=n
> 
> When kprobe_free_init_mem() is called, system_state == SYSTEM_FREEING_INITMEM, which causes
> core_kernel_text() to return 0 for inittext:
> 
> | int notrace core_kernel_text(unsigned long addr)
> | {
> |         if (is_kernel_text(addr))
> |                 return 1;
> | 
> |         if (system_state < SYSTEM_FREEING_INITMEM &&
> |             is_kernel_inittext(addr))
> |                 return 1;
> |         return 0;
> | }
> 
> This causes riscv's patch_map() to *not* fixmap the inittext, since it does:
> 
> |	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr))
> |		page = phys_to_page(__pa_symbol(addr));
> |	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> |		page = vmalloc_to_page(addr);
> |	else
> |		return addr;
> 
> .. which fails core_kernel_text(), and IS_ENABLED(CONFIG_STRICT_MODULE_RWX),
> returning the (read-only) mapping of the kernel image.

Ah, I got it. Yes, kprobes is able to probe on init text.
(in the boot time and module load time)

> 
> That would happen (by luck) to work with CONFIG_MODULES=because it'd be handled
> by vmalloc_to_page() walking the page tables. I suspect that'll happen to work
> on arm64 by virtue of patch 1, but that wasn't intentional.

Yeah, even with init text, it should be handled as a part of text address.
So using phys_to_page() will be better.

> 
> I'm not sure what the right fix is here, it's annoying that core_kernel_text()
> is special-cased for SYSTEM_FREEING_INITMEM, but that was deliberate as of
> commit:
> 
>   d2635f2012a44e3d ("mm: create a new system state and fix core_kernel_text()")
> 
> .. though I'm not sure what exactly that was trying to fix at a higher level.

at the kprobe_free_init_mem() point, init text is not freed yet, so why not we check
the is_kernel_inittext() in patch_map()? I think this special case is handled in
patch_map(). (Or, we can introduce early_patch_map())

> 
> I can look into this some more tomorrow.

Thank you!

> 
> Mark.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

