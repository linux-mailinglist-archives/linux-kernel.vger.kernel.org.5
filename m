Return-Path: <linux-kernel+bounces-131710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBA898AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C18B2F146
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F6130E25;
	Thu,  4 Apr 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc+eKnYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37F1D547
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243907; cv=none; b=HSvedlYgITJ0wxLf1Q8QlYORbSF/Xvh0hQkZYZvily95DfVhDD7GC017wYh3AgMYqVLgcqq8LKy3vgUMd+EhiYXRPcBs++34Aqixb8kALSDL7X7rfIzXkVsoNz2Xxz7rsIOjk9hTYpCYYmUvixRNPqQzfRIRXey/oNlpErwBMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243907; c=relaxed/simple;
	bh=TvEvr9FBUdBPzVIz7Xo6925tGz3ksxrEHjA3jd2o6gQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TCYeMXGFUVmC9F9PfsjJjZJziVk97SaPeUmbe7lI85H7KGA14D1b/w5lfw19g+/mPreUMul/HTC5fCgjbnabviMTk250DiJj5UKtR7qc61bq/vNFeToYAZe5tdYvqvyM9C7wiWOaMFzYpOBxn7So5SJYZUvYhOcdfkAbhG87cJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc+eKnYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D27C433F1;
	Thu,  4 Apr 2024 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243905;
	bh=TvEvr9FBUdBPzVIz7Xo6925tGz3ksxrEHjA3jd2o6gQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uc+eKnYDHQCarh9ior1695h4dE8Q7VytiZ1RR23OVgkk18QX/uj6Yy2UUmf40vdGH
	 uHWh47+peHOH+5RwcmI79d1rfyQ1YJfWxtoJ5NsgciMNxgASFbuTMWjoPw2JIdgEzr
	 tKlBr7GvDo/3LM2Q8T5MWua0k8+ZuA9NeZEM9MTjjo19FLHblDcwW9+C8aFZGm/Erv
	 8EbaHK9katpUacGJc5D2nO/VwjD5y0kJlyI0InTABF6knrQONAguHJUxQ73hFRv8SU
	 hK7C0ngToMUmHUJ+aN6BBnpTvxJU6tYx2NppOg8Fn7gwTR8W88MIbsCjSElXNbIO7Q
	 Y3oPToKH7ViZQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 18:18:21 +0300
Message-Id: <D0BFT1AHHVYR.2V75A0HT23T67@kernel.org>
Cc: <anil.s.keshavamurthy@intel.com>, <aou@eecs.berkeley.edu>,
 <catalin.marinas@arm.com>, <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>, <mhiramat@kernel.org>,
 <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <will@kernel.org>
Subject: Re: [PATCH v2 4/4] kprobes: Remove core dependency on modules
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-5-mark.rutland@arm.com>
 <D0B6SY8DJ5RC.KLZ08YRNLOH3@kernel.org>
In-Reply-To: <D0B6SY8DJ5RC.KLZ08YRNLOH3@kernel.org>

On Thu Apr 4, 2024 at 11:15 AM EEST, Jarkko Sakkinen wrote:
> On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible because KPROBES depends on MODULES. While this dependency is
> > necessary when HAVE_KPROBES_ALLOC=3Dn and the core kprobes code allocat=
es
> > memory using module_alloc(), all the other module-specific code only
> > exist to handle the case when MODULES=3Dy, and can be hidden behind
> > ifdeffery.
> >
> > Add the necessary ifdeffery, and remove the dependency on MODULES=3Dy w=
hen
> > HAVE_KPROBES_ALLOC=3Dy.
> >
> > As of this patch kprobes can be used when MODULES=3Dn on arm64 and
> > riscv. All other architectures still depend on MODULES, either by virtu=
e
> > of the core dependency on MODULES when HAVE_KPROBES_ALLOC=3Dn, or by
> > virtue of an explciit dependency on MODULES in arch code.
> >
> > Other architectures can enable support by implementing their own
> > kprobes_alloc_insn_page() and kprobes_free_insn_page() which do not
> > depend on MODULES.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Link: https://lore.kernel.org/lkml/20240326134616.7691-1-jarkko@kernel.=
org/
> > [Mark: Remove execmem changes, depend on HAVE_KPROBES_ALLOC]
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/Kconfig                |  2 +-
> >  kernel/kprobes.c            | 46 ++++++++++++++++++++++---------------
> >  kernel/trace/trace_kprobe.c | 15 ++++++++++--
> >  3 files changed, 41 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 85bb59f7b8c07..0df2c88547b3c 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,7 +52,7 @@ config GENERIC_ENTRY
> > =20
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> > +	depends on MODULES || HAVE_KPROBES_ALLOC
> >  	depends on HAVE_KPROBES
> >  	select KALLSYMS
> >  	select TASKS_RCU if PREEMPTION
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index fa2ee4e59eca2..ec4493a41b505 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1594,6 +1594,7 @@ static int check_kprobe_address_safe(struct kprob=
e *p,
> >  			goto out;
> >  		}
> > =20
> > +#ifdef CONFIG_MODULES
> >  		/*
> >  		 * If the module freed '.init.text', we couldn't insert
> >  		 * kprobes in there.
> > @@ -1604,7 +1605,9 @@ static int check_kprobe_address_safe(struct kprob=
e *p,
> >  			*probed_mod =3D NULL;
> >  			ret =3D -ENOENT;
> >  		}
> > +#endif /* CONFIG_MODULES */
> >  	}
> > +
> >  out:
> >  	preempt_enable();
> >  	jump_label_unlock();
> > @@ -2484,24 +2487,6 @@ int kprobe_add_area_blacklist(unsigned long star=
t, unsigned long end)
> >  	return 0;
> >  }
> > =20
> > -/* Remove all symbols in given area from kprobe blacklist */
> > -static void kprobe_remove_area_blacklist(unsigned long start, unsigned=
 long end)
> > -{
> > -	struct kprobe_blacklist_entry *ent, *n;
> > -
> > -	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> > -		if (ent->start_addr < start || ent->start_addr >=3D end)
> > -			continue;
> > -		list_del(&ent->list);
> > -		kfree(ent);
> > -	}
> > -}
> > -
> > -static void kprobe_remove_ksym_blacklist(unsigned long entry)
> > -{
> > -	kprobe_remove_area_blacklist(entry, entry + 1);
> > -}
> > -
> >  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long=
 *value,
> >  				   char *type, char *sym)
> >  {
> > @@ -2566,6 +2551,25 @@ static int __init populate_kprobe_blacklist(unsi=
gned long *start,
> >  	return ret ? : arch_populate_kprobe_blacklist();
> >  }
> > =20
> > +#ifdef CONFIG_MODULES
> > +/* Remove all symbols in given area from kprobe blacklist */
> > +static void kprobe_remove_area_blacklist(unsigned long start, unsigned=
 long end)
> > +{
> > +	struct kprobe_blacklist_entry *ent, *n;
> > +
> > +	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> > +		if (ent->start_addr < start || ent->start_addr >=3D end)
> > +			continue;
> > +		list_del(&ent->list);
> > +		kfree(ent);
> > +	}
> > +}
> > +
> > +static void kprobe_remove_ksym_blacklist(unsigned long entry)
> > +{
> > +	kprobe_remove_area_blacklist(entry, entry + 1);
> > +}
> > +
> >  static void add_module_kprobe_blacklist(struct module *mod)
> >  {
> >  	unsigned long start, end;
> > @@ -2662,6 +2666,9 @@ static int kprobes_module_callback(struct notifie=
r_block *nb,
> >  	mutex_unlock(&kprobe_mutex);
> >  	return NOTIFY_DONE;
> >  }
> > +#else
> > +#define kprobes_module_callback	(NULL)
> > +#endif /* CONFIG_MODULES */
> > =20
> >  static struct notifier_block kprobe_module_nb =3D {
> >  	.notifier_call =3D kprobes_module_callback,
> > @@ -2726,7 +2733,8 @@ static int __init init_kprobes(void)
> >  	err =3D arch_init_kprobes();
> >  	if (!err)
> >  		err =3D register_die_notifier(&kprobe_exceptions_nb);
> > -	if (!err)
> > +
> > +	if (!err && IS_ENABLED(CONFIG_MODULES))
> >  		err =3D register_module_notifier(&kprobe_module_nb);
> > =20
> >  	kprobes_initialized =3D (err =3D=3D 0);
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 14099cc17fc9e..c509ba776e679 100644
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
> > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct noti=
fier_block *nb,
> > =20
> >  	return NOTIFY_DONE;
> >  }
> > +#else
> > +#define trace_kprobe_module_callback (NULL)
> > +#endif /* CONFIG_MODULES */
> > =20
> >  static struct notifier_block trace_kprobe_module_nb =3D {
> >  	.notifier_call =3D trace_kprobe_module_callback,
> > @@ -1933,8 +1941,11 @@ static __init int init_kprobe_trace_early(void)
> >  	if (ret)
> >  		return ret;
> > =20
> > -	if (register_module_notifier(&trace_kprobe_module_nb))
> > -		return -EINVAL;
> > +	if (IS_ENABLED(CONFIG_MODULES)) {
> > +		ret =3D register_module_notifier(&trace_kprobe_module_nb);
> > +		if (ret)
> > +			return -EINVAL;
> > +	}
> > =20
> >  	return 0;
> >  }
>
> 2/4, 3/4, 4/4:
>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # arch/riscv

Hey, I tried the pci_proc_init example:

[    3.060703] ------------[ ftrace bug ]------------
[    3.060944] ftrace faulted on writing
[    3.060987] [<ffffffff8102c0da>] pci_proc_init+0x0/0x80
[    3.061509] Updating ftrace call site to call a different ftrace functio=
n
[    3.061756] ftrace record flags: 80100001
[    3.061925]  (1)
[    3.061925]  expected tramp: ffffffff8000aa60
[    3.062527] ------------[ cut here ]------------
[    3.062652] WARNING: CPU: 0 PID: 18 at kernel/trace/ftrace.c:2180 ftrace=
_bug+0x282/0x2b8
[    3.062747] CPU: 0 PID: 18 Comm: migration/0 Not tainted 6.9.0-rc1 #2
[    3.062807] Hardware name: riscv-virtio,qemu (DT)
[    3.062868] Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked=
+0x140/0x18c
[    3.062925] epc : ftrace_bug+0x282/0x2b8
[    3.062957]  ra : ftrace_bug+0x282/0x2b8
[    3.062989] epc : ffffffff80fc31f4 ra : ffffffff80fc31f4 sp : ff20000000=
093c70
[    3.063014]  gp : ffffffff824b7780 tp : ff60000002a85940 t0 : ffffffff80=
0923a6
[    3.063037]  t1 : 0000000000000020 t2 : 6465746365707865 s0 : ff20000000=
093cb0
[    3.063061]  s1 : ffffffff8102c0da a0 : 0000000000000022 a1 : ffffffff82=
29b7f0
[    3.063084]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000=
000000
[    3.063108]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000=
000001
[    3.063131]  s2 : ff60000002850ab0 s3 : ffffffffffffffff s4 : 0000000000=
000002
[    3.063154]  s5 : 0000000002000000 s6 : 0000000082000000 s7 : 0000000000=
000000
[    3.063178]  s8 : 0000000000000001 s9 : ffffffff824bca18 s10: ff60000002=
845140
[    3.063202]  s11: 00000000000000ab t3 : ffffffff824ce9ef t4 : ffffffff82=
4ce9ef
[    3.063225]  t5 : ffffffff824ce9f0 t6 : ff20000000093aa8
[    3.063248] status: 0000000200000100 badaddr: 0000000000000000 cause: 00=
00000000000003
[    3.063331] [<ffffffff80fc31f4>] ftrace_bug+0x282/0x2b8
[    3.063398] [<ffffffff80108b1a>] ftrace_replace_code+0xfe/0x168
[    3.063430] [<ffffffff80108c82>] ftrace_modify_all_code+0x5c/0x16a
[    3.063460] [<ffffffff80108da2>] __ftrace_modify_code+0x12/0x1c
[    3.063490] [<ffffffff800f299c>] multi_cpu_stop+0x118/0x1a0
[    3.063519] [<ffffffff800f242e>] cpu_stopper_thread+0xb2/0x12a
[    3.063548] [<ffffffff8005dece>] smpboot_thread_fn+0x1aa/0x1d2
[    3.063577] [<ffffffff80057fec>] kthread+0xfe/0x106
[    3.063606] [<ffffffff80fe3d76>] ret_from_fork+0xe/0x20
[    3.063676] ---[ end trace 0000000000000000 ]---
[    3.069730] ------------[ cut here ]------------
[    3.069861] Failed to disarm kprobe-ftrace at pci_proc_init+0x0/0x80 (er=
ror -19)
[    3.070078] WARNING: CPU: 0 PID: 1 at kernel/kprobes.c:1128 __disarm_kpr=
obe_ftrace+0x9a/0xae
[    3.070124] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6=
9.0-rc1 #2
[    3.070133] Hardware name: riscv-virtio,qemu (DT)
[    3.070141] epc : __disarm_kprobe_ftrace+0x9a/0xae
[    3.070150]  ra : __disarm_kprobe_ftrace+0x9a/0xae
[    3.070157] epc : ffffffff800ffcda ra : ffffffff800ffcda sp : ff20000000=
00be30
[    3.070162]  gp : ffffffff824b7780 tp : ff60000002a70000 t0 : ffffffff80=
0923a6
[    3.070167]  t1 : 0000000000000046 t2 : 6f742064656c6961 s0 : ff20000000=
00be60
[    3.070173]  s1 : ffffffffffffffed a0 : 0000000000000044 a1 : ffffffff82=
29b7f0
[    3.070178]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000=
000000
[    3.070182]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000=
000001
[    3.070187]  s2 : ffffffff824bc940 s3 : ffffffff822ac158 s4 : ff60000002=
b53c80
[    3.070192]  s5 : ffffffff824bc940 s6 : ffffffff822ac158 s7 : ffffffff81=
000000
[    3.070197]  s8 : ffffffff814775f8 s9 : ffffffff824f23d8 s10: 0000000000=
000000
[    3.070202]  s11: 0000000000000000 t3 : ffffffff824ce9d7 t4 : ffffffff82=
4ce9d7
[    3.070206]  t5 : ffffffff824ce9d8 t6 : ff2000000000bc48
[    3.070211] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    3.070218] [<ffffffff800ffcda>] __disarm_kprobe_ftrace+0x9a/0xae
[    3.070228] [<ffffffff80101b16>] kprobe_free_init_mem+0xc2/0x130
[    3.070236] [<ffffffff80fd9b38>] kernel_init+0x46/0x14e
[    3.070245] [<ffffffff80fe3d76>] ret_from_fork+0xe/0x20
[    3.070254] ---[ end trace 0000000000000000 ]---
[

This is with riscv64 defconfig, tracing shenanigans and the following
bootconfig and the bug was realized in QEMU:

ftrace {
	tracing_on =3D 0
	tracer =3D "function_graph"
	event {
		kprobes.pci_proc_init_begin {
			probes =3D "pci_proc_init"
			actions =3D "traceon"
		}
		kprobes.pci_proc_init_end {
			probes =3D "pci_proc_init%return"
			actions =3D "traceoff"
		}
	}
}

kernel {
	console =3D hvc0
	dyndbg =3D "file arch/riscv/kernel/* +p"
	earlycon =3D sbi
	memblock =3D debug
	memtest =3D 1
	tp_printk
	frace_dump_on_oops
}

BR, Jarkko

