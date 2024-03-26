Return-Path: <linux-kernel+bounces-119509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7788C9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC631C6406F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5F1BC3E;
	Tue, 26 Mar 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb1LiOVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220481C288;
	Tue, 26 Mar 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471770; cv=none; b=qTZLQizcyqj1hsDTUROJJzGe0XgN0B7PFvHIF+w9mSDEF7+HpU8gUnzFZ4+Dar0lnOv4lRxmdSF5A94Dc2uI+1OhzAjCqcLZbsnIpAXJ56x3c+ZSc1meDO2c4IExD57baK76qFiwb1H9S8FdvEoen2EtVuaykIwGqt4xXQ9xc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471770; c=relaxed/simple;
	bh=H2HpTU1EmHDoY/mcqae3NhFHA7uFSeakgfW/r6p76sQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nd8z9KI+D3SM869O1EcDxODGDcS4RM6ouAqzzKTug6YrAf50R3Hit2JhPBJAn1e7CK2levSvf705BMy9V9jAPA1FbObC5a1HlbOZ+VXO+4koECGPqrpsVbExwrXX8gBm3nZwYjbPod/ocHGKr4y/wSkbmIKh1T3EAUalow5lSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb1LiOVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9400CC433C7;
	Tue, 26 Mar 2024 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471770;
	bh=H2HpTU1EmHDoY/mcqae3NhFHA7uFSeakgfW/r6p76sQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Rb1LiOVjtZh6e2NNbZ+rKw3OGvUoB+4Y12YHHS/D+WSBc0gCcc/iRQX3Ub2HGSj5F
	 Dt8yu94iSHRlIB+e3gelfxcGfDAcDl0IRzBJTkS5OTTrO66OGnqxCmnKd9PteK6mV/
	 m4zTp75pHeBPPkOckURWggi/akxlFKVQTH6IQNn1/W+6NILIvtJd4B9uNQ+iox0JgT
	 shYeK4DSLx5hgEDTFAyHfT3Mf2NjKSelhKZlpQJC0flSKpkt8Tt4MkUzZQDK0shRyT
	 TWqBnwyfjWMGzDHucKvIxZNyLYemKUuvwtI2g+euY2CHGQOQcxQtzy20QtBFxGATNR
	 yT1Ivng41AjmQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 18:49:25 +0200
Message-Id: <D03U3UZ4XBOW.66TLKVR1PKPH@kernel.org>
To: "Alexandre Ghiti" <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 <linux-kernel@vger.kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 <linux-modules@vger.kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [PATCH v5 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240325215502.660-2-jarkko@kernel.org>
 <474ed846-672a-4ff0-9d53-cbf8192fee5f@ghiti.fr>
In-Reply-To: <474ed846-672a-4ff0-9d53-cbf8192fee5f@ghiti.fr>

On Tue Mar 26, 2024 at 3:57 PM EET, Alexandre Ghiti wrote:
> Hi Jarkko,
>
> On 25/03/2024 22:55, Jarkko Sakkinen wrote:
> > Tacing with kprobes while running a monolithic kernel is currently
> > impossible due the kernel module allocator dependency.
> >
> > Address the issue by implementing textmem API for RISC-V.
> >
> > Link: https://www.sochub.fi # for power on testing new SoC's with a min=
imal stack
> > Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profi=
an.com/ # continuation
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - No changes, expect removing alloc_execmem() call which should have
> >    been part of the previous patch.
> > v4:
> > - Include linux/execmem.h.
> > v3:
> > - Architecture independent parts have been split to separate patches.
> > - Do not change arch/riscv/kernel/module.c as it is out of scope for
> >    this patch set now.
> > v2:
> > - Better late than never right? :-)
> > - Focus only to RISC-V for now to make the patch more digestable. This
> >    is the arch where I use the patch on a daily basis to help with QA.
> > - Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migration=
.
> > ---
> >   arch/riscv/Kconfig          |  1 +
> >   arch/riscv/kernel/Makefile  |  3 +++
> >   arch/riscv/kernel/execmem.c | 22 ++++++++++++++++++++++
> >   3 files changed, 26 insertions(+)
> >   create mode 100644 arch/riscv/kernel/execmem.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e3142ce531a0..499512fb17ff 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -132,6 +132,7 @@ config RISCV
> >   	select HAVE_KPROBES if !XIP_KERNEL
> >   	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> >   	select HAVE_KRETPROBES if !XIP_KERNEL
> > +	select HAVE_ALLOC_EXECMEM if !XIP_KERNEL
> >   	# https://github.com/ClangBuiltLinux/linux/issues/1881
> >   	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> >   	select HAVE_MOVE_PMD
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 604d6bf7e476..337797f10d3e 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -73,6 +73,9 @@ obj-$(CONFIG_SMP)		+=3D cpu_ops.o
> >  =20
> >   obj-$(CONFIG_RISCV_BOOT_SPINWAIT) +=3D cpu_ops_spinwait.o
> >   obj-$(CONFIG_MODULES)		+=3D module.o
> > +ifeq ($(CONFIG_ALLOC_EXECMEM),y)
> > +obj-y				+=3D execmem.o
> > +endif
> >   obj-$(CONFIG_MODULE_SECTIONS)	+=3D module-sections.o
> >  =20
> >   obj-$(CONFIG_CPU_PM)		+=3D suspend_entry.o suspend.o
> > diff --git a/arch/riscv/kernel/execmem.c b/arch/riscv/kernel/execmem.c
> > new file mode 100644
> > index 000000000000..3e52522ead32
> > --- /dev/null
> > +++ b/arch/riscv/kernel/execmem.c
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/mm.h>
> > +#include <linux/execmem.h>
> > +#include <linux/vmalloc.h>
> > +#include <asm/sections.h>
> > +
> > +void *alloc_execmem(unsigned long size, gfp_t /* gfp */)

Need to have the parameter name here. I guess this could just as well
pass through gfp to vmalloc from the caller as kprobes does call
module_alloc() with GFP_KERNEL set in RISC-V.

> > +{
> > +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> > +				    MODULES_END, GFP_KERNEL,
> > +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > +				    __builtin_return_address(0));
> > +}
>
>
> The __vmalloc_node_range() line ^^ must be from an old kernel since we=20
> added VM_FLUSH_RESET_PERMS in 6.8, see 749b94b08005 ("riscv: Fix=20
> module_alloc() that did not reset the linear mapping permissions").
>
> In addition, I guess module_alloc() should now use alloc_execmem() right?

Ack for the first comment. For the 2nd it is up to arch/<arch> to choose
whether to have shared or separate allocators.

So if you want I can change it that way but did not want to make the
call myself.

>
>
> > +
> > +void free_execmem(void *region)
> > +{
> > +	if (in_interrupt())
> > +		pr_warn("In interrupt context: vmalloc may not work.\n");
> > +
> > +	vfree(region);
> > +}
>
>
> I remember Mike Rapoport sent a patchset to introduce an API for=20
> executable memory allocation=20
> (https://lore.kernel.org/linux-mm/20230918072955.2507221-1-rppt@kernel.or=
g/),=20
> how does this intersect with your work? I don't know the status of his=20
> patchset though.
>
> Thanks,
>
> Alex

I have also made a patch set for kprobes in the 2022:

https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/

I think this Calvin's, Mike's and my early patch set have the same
problem: they try to choke all architectures at once. And further,
Calvin's and Mike's work also try to cover also tracing subsystems
at once.

I feel that my relatively small patch set which deals only with
trivial kprobe (which is more in the leaf than e.g. bpf which
is more like orchestrator tool) and implements one arch of which
dog food I actually eat is a better starting point.

Arch code is always something where you need to have genuine
understanding so full architecture coverage from day one is
just too risky for stability. Linux is better off if people who
work on a  specific arch proactively will "fill the holes".

So the way I see my patch set is "lowest common denominator"
in both architecture axis and tracing subsystem axist. It should
not interfere that much with the other work (like bpf).

BR, Jarkko

