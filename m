Return-Path: <linux-kernel+bounces-119524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DAB88CA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FDE1F6750D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CFA84FD8;
	Tue, 26 Mar 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft27l9pE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074E41238;
	Tue, 26 Mar 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472091; cv=none; b=IGWpTsXebLgiMStpJ0OvUXFLrs8xtCE9P4MV+zqkc13lzD9hEUMM4vPsLi8GxMuKqoEKIhg456tbJf7PIAt4does63EicKHPUI9Sj9T5MBL+nNxlwoAPRfCuvBeFf/8cUychGhdprnMe6SQE+v5DrR3wJknQ5wkVmPB19vbS9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472091; c=relaxed/simple;
	bh=kfvUE/tPrPQaCp2NEJWZn+NkD/GzFr+HXyYsWmXWBms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=vF1wIFG45wUI63KmXahlkIvzri4ZcgbKwb7mvIpXIz3o5qHLf4Taw6Yry9peFfdHJyAQyYSxFsQYszsH1vu9cEblFkek836/gs4aYJ5AZOy2L/SMqksE5ahhHmDZOQS2gctauQl8GE/89CjZu66uHY5trBwL9ogEmA1KYTX3kHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft27l9pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B28C433F1;
	Tue, 26 Mar 2024 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472090;
	bh=kfvUE/tPrPQaCp2NEJWZn+NkD/GzFr+HXyYsWmXWBms=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ft27l9pEEf4nP9p1LalDYbwgGlKP0QZMe2l/7Zy7s/yBZOZ/6AuibNn0ERZqdIWJY
	 7ROkwF/gi+ZOsOZNzcc5Pm0lgeBUUyaFisU2ZWpnIVR9OgGnUea9K+tq3tJpL/M9KF
	 Rveg6dZD2TyuiwQ8uRrd+CUa/hYrmGkzsFjpmVSjpfB/nwoHYzB1yWtRFIS+MUBXgE
	 B8cLjcZRQZxFm06+Bq523kTiY5VxDq/3HPZkldm9n4TMS8XUfuWXY3DCzL/lhAHrV7
	 TJzcNm1VDfyeiy9dg6JSnpQ2cvIzpt2vsBbQElU+oz00709fzcJW6KAn+lh9ughGkA
	 csNLdbHlWvQVg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 18:54:45 +0200
Message-Id: <D03U7Y29RXR8.374E0V78LPHFF@kernel.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 <linux-kernel@vger.kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 <linux-modules@vger.kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [PATCH v5 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Alexandre Ghiti"
 <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240325215502.660-2-jarkko@kernel.org>
 <474ed846-672a-4ff0-9d53-cbf8192fee5f@ghiti.fr>
 <D03U3UZ4XBOW.66TLKVR1PKPH@kernel.org>
In-Reply-To: <D03U3UZ4XBOW.66TLKVR1PKPH@kernel.org>

On Tue Mar 26, 2024 at 6:49 PM EET, Jarkko Sakkinen wrote:
> On Tue Mar 26, 2024 at 3:57 PM EET, Alexandre Ghiti wrote:
> > Hi Jarkko,
> >
> > On 25/03/2024 22:55, Jarkko Sakkinen wrote:
> > > Tacing with kprobes while running a monolithic kernel is currently
> > > impossible due the kernel module allocator dependency.
> > >
> > > Address the issue by implementing textmem API for RISC-V.
> > >
> > > Link: https://www.sochub.fi # for power on testing new SoC's with a m=
inimal stack
> > > Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@pro=
fian.com/ # continuation
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > v5:
> > > - No changes, expect removing alloc_execmem() call which should have
> > >    been part of the previous patch.
> > > v4:
> > > - Include linux/execmem.h.
> > > v3:
> > > - Architecture independent parts have been split to separate patches.
> > > - Do not change arch/riscv/kernel/module.c as it is out of scope for
> > >    this patch set now.
> > > v2:
> > > - Better late than never right? :-)
> > > - Focus only to RISC-V for now to make the patch more digestable. Thi=
s
> > >    is the arch where I use the patch on a daily basis to help with QA=
.
> > > - Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migrati=
on.
> > > ---
> > >   arch/riscv/Kconfig          |  1 +
> > >   arch/riscv/kernel/Makefile  |  3 +++
> > >   arch/riscv/kernel/execmem.c | 22 ++++++++++++++++++++++
> > >   3 files changed, 26 insertions(+)
> > >   create mode 100644 arch/riscv/kernel/execmem.c
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index e3142ce531a0..499512fb17ff 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -132,6 +132,7 @@ config RISCV
> > >   	select HAVE_KPROBES if !XIP_KERNEL
> > >   	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > >   	select HAVE_KRETPROBES if !XIP_KERNEL
> > > +	select HAVE_ALLOC_EXECMEM if !XIP_KERNEL
> > >   	# https://github.com/ClangBuiltLinux/linux/issues/1881
> > >   	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> > >   	select HAVE_MOVE_PMD
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 604d6bf7e476..337797f10d3e 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -73,6 +73,9 @@ obj-$(CONFIG_SMP)		+=3D cpu_ops.o
> > >  =20
> > >   obj-$(CONFIG_RISCV_BOOT_SPINWAIT) +=3D cpu_ops_spinwait.o
> > >   obj-$(CONFIG_MODULES)		+=3D module.o
> > > +ifeq ($(CONFIG_ALLOC_EXECMEM),y)
> > > +obj-y				+=3D execmem.o
> > > +endif
> > >   obj-$(CONFIG_MODULE_SECTIONS)	+=3D module-sections.o
> > >  =20
> > >   obj-$(CONFIG_CPU_PM)		+=3D suspend_entry.o suspend.o
> > > diff --git a/arch/riscv/kernel/execmem.c b/arch/riscv/kernel/execmem.=
c
> > > new file mode 100644
> > > index 000000000000..3e52522ead32
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/execmem.c
> > > @@ -0,0 +1,22 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +#include <linux/mm.h>
> > > +#include <linux/execmem.h>
> > > +#include <linux/vmalloc.h>
> > > +#include <asm/sections.h>
> > > +
> > > +void *alloc_execmem(unsigned long size, gfp_t /* gfp */)
>
> Need to have the parameter name here. I guess this could just as well
> pass through gfp to vmalloc from the caller as kprobes does call
> module_alloc() with GFP_KERNEL set in RISC-V.
>
> > > +{
> > > +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> > > +				    MODULES_END, GFP_KERNEL,
> > > +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > > +				    __builtin_return_address(0));
> > > +}
> >
> >
> > The __vmalloc_node_range() line ^^ must be from an old kernel since we=
=20
> > added VM_FLUSH_RESET_PERMS in 6.8, see 749b94b08005 ("riscv: Fix=20
> > module_alloc() that did not reset the linear mapping permissions").
> >
> > In addition, I guess module_alloc() should now use alloc_execmem() righ=
t?
>
> Ack for the first comment. For the 2nd it is up to arch/<arch> to choose
> whether to have shared or separate allocators.
>
> So if you want I can change it that way but did not want to make the
> call myself.
>
> >
> >
> > > +
> > > +void free_execmem(void *region)
> > > +{
> > > +	if (in_interrupt())
> > > +		pr_warn("In interrupt context: vmalloc may not work.\n");
> > > +
> > > +	vfree(region);
> > > +}
> >
> >
> > I remember Mike Rapoport sent a patchset to introduce an API for=20
> > executable memory allocation=20
> > (https://lore.kernel.org/linux-mm/20230918072955.2507221-1-rppt@kernel.=
org/),=20
> > how does this intersect with your work? I don't know the status of his=
=20
> > patchset though.
> >
> > Thanks,
> >
> > Alex
>
> I have also made a patch set for kprobes in the 2022:
>
> https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/
>
> I think this Calvin's, Mike's and my early patch set have the same
> problem: they try to choke all architectures at once. And further,
> Calvin's and Mike's work also try to cover also tracing subsystems
> at once.
>
> I feel that my relatively small patch set which deals only with
> trivial kprobe (which is more in the leaf than e.g. bpf which
> is more like orchestrator tool) and implements one arch of which
> dog food I actually eat is a better starting point.
>
> Arch code is always something where you need to have genuine
> understanding so full architecture coverage from day one is
> just too risky for stability. Linux is better off if people who
> work on a  specific arch proactively will "fill the holes".
>
> So the way I see my patch set is "lowest common denominator"
> in both architecture axis and tracing subsystem axist. It should
> not interfere that much with the other work (like bpf).

Here also there is a lot of kconfig flag logic changes. I've verified
them but still I think we are better off if this stuff is put in the
wild first in small scale rather than spraying kernel with code changes
in the first run.

BR, Jarkko

