Return-Path: <linux-kernel+bounces-112734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8546887D98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE241C209AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91E18EB8;
	Sun, 24 Mar 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NHi5D1H/"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB610A19
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711297721; cv=none; b=PIcQ2qcdmKOO1NOlKiTYslMZy12RDC90eUrp+l+wlFIpJ3QGx6gBaVq/5HmJFe9SBSF8t0I86ECSvZv+r8Q6upZIUMm8jy5hYdqcVNr0QrtRALsJnix3tqX5Eky9DcwVTSQyhAFpve+H5r/+3verKCMr779myhqTZNN801kS0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711297721; c=relaxed/simple;
	bh=VVxT1+30kfFtynlw5txLe5LXptKYOBoBmsWHltYGTU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnjFKCXZt+fpXCanJ0DhpwhO46nJkXExvXpABoQl3KYejjFg+bV26msF9erGyAymQhe9bvmwnO5eFLddnW6PgpEE00EvLplfMPqF9LcPjOxUugIILrvSyYrCTR6PjZBEVoo1+Mz+Q3XLgPr9P3cbkneIBmU21DPk0bMAoKy5ohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NHi5D1H/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 87C1D20B74C0; Sun, 24 Mar 2024 09:28:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87C1D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711297713;
	bh=L7aJR+/O/U52wmp8nXcyTTBjlAy8uzaOy6DxR8fMbvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHi5D1H/nl3xhC4xFnWkToLc6k2tX03KxmPP45asdxiiWuALs7QL2DbMuCWfkgtNy
	 SbameL55W851rQeHRK0xK1OgR0rD0AOcw/ov4LXV46sDmtxb6saDF3a7A3GWtpk4Jh
	 vJ7XNvC906SDyGSFVZQbOUgBaJlbwh4uxdhOlktA=
Date: Sun, 24 Mar 2024 09:28:33 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	sgeorgejohn@microsoft.com
Subject: Re: [PATCH] x86/numa: Map NUMA node to CPUs as per DeviceTree
Message-ID: <20240324162833.GA18417@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
 <87v85bfzg0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v85bfzg0.ffs@tglx>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Mar 24, 2024 at 03:59:27PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 12 2024 at 10:43, Saurabh Sengar wrote:
> > Currently for DeviceTree bootup, x86 code does the default mapping of
> > CPUs to NUMA, which is wrong. This can cause incorrect mapping and WARN
> > on a SMT enabled system like below:
> >
> > [0.417551] ------------[ cut here ]------------
> > [0.417551] Saurabh sched: CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
> > [0.417551] WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
> > [0.417551] Modules linked in:
> > [0.417551] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.71-microsoft-hcl+ #4
> > [0.417551] RIP: 0010:topology_sane.isra.0+0x5c/0x6d
> > [0.417551] Code: 41 39 dc 74 27 80 3d 32 ae 2d 00 00 75 1e 41 89 d9 45 89 e0 44 89 d6 48 c7 c7 00 a6 4a 88 c6 05 19 ae 2d 00 01 e8 6e 1f cb ff <0f> 0b 41 39 dc 5b 41 5c 0f 94 c0 5d c3 cc cc cc cc 55 48 8b 05 05
> > [0.417551] RSP: 0000:ffffc9000013feb0 EFLAGS: 00010086
> > [0.417551] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [0.417551] RDX: 0000000000000003 RSI: 0000000000000086 RDI: 00000000ffffffff
> > [0.417551] RBP: ffffc9000013fec0 R08: ffffffff88778160 R09: ffffffff88778160
> > [0.417551] R10: ffff888227fe26da R11: ffff888227fe26c1 R12: 0000000000000001
> > [0.417551] R13: 0000000000000000 R14: ffff888216415040 R15: 0000000000000000
> > [0.417551] FS:  0000000000000000(0000) GS:ffff888216400000(0000) knlGS:0000000000000000
> > [0.417551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [0.417551] CR2: 0000000000000000 CR3: 0000000208809001 CR4: 0000000000330ea0
> > [0.417551] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [0.417551] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > [0.417551] Call Trace:
> > [0.417551]  <TASK>
> > [0.417551]  ? show_regs.cold+0x1a/0x1f
> > [0.417551]  ? __warn+0x6e/0xc0
> > [0.417551]  ? report_bug+0x101/0x1a0
> > [0.417551]  ? handle_bug+0x40/0x70
> > [0.417551]  ? exc_invalid_op+0x19/0x70
> > [0.417551]  ? asm_exc_invalid_op+0x1b/0x20
> > [0.417551]  ? topology_sane.isra.0+0x5c/0x6d
> > [0.417551]  match_smt+0xf6/0xfc
> > [0.417551]  set_cpu_sibling_map.cold+0x24f/0x512
> > [0.417551]  start_secondary+0x5c/0x110
> > [0.417551]  secondary_startup_64_no_verify+0xcd/0xdb
> > [0.417551]  </TASK>
> > [0.417551] ---[ end trace 0000000000000000 ]---
> 
> Can you please trim the backtrace like documented. 95% of the pasted
> information above is completely irrelevant to understand the issue.
> 
>  CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
>  WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
>   match_smt+0xf6/0xfc
>   set_cpu_sibling_map.cold+0x24f/0x512
>   start_secondary+0x5c/0x110
> 
> is more than sufficient, no?
> 
> > +static void __init of_parse_and_init_cpus(void)
> > +{
> > +	struct device_node *dn;
> > +	int cpuid = 0;
> > +	int nid;
> > +
> > +	for_each_of_cpu_node(dn) {
> > +		if (cpuid >= NR_CPUS) {
> 
> This condition is wrong. nr_cpu_ids != NR_CPUS.
> 
> > +			pr_warn("NR_CPUS too small for %d cpuid\n", cpuid);
> 
> What's this for? The APIC enumeration code warns about this already.
> 
> > +			return;
> > +		}
> > +		nid = of_node_to_nid(dn);
> > +		numa_set_node(cpuid, nid);
> > +		cpuid++;
> > +	}
> > +}
> > +
> >  static int __init numa_init(int (*init_func)(void))
> >  {
> >  	int i;
> > @@ -645,6 +662,9 @@ static int __init numa_init(int (*init_func)(void))
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	if (acpi_disabled)
> > +		of_parse_and_init_cpus();
> 
> numa_init() is invoked from x86_numa_init() with the various NUMA init
> functions as argument and x86_numa_init() already has OF NUMA logic:
> 
> #ifdef CONFIG_ACPI_NUMA
> 		if (!numa_init(x86_acpi_numa_init))
> 			return;
> #endif
> #ifdef CONFIG_AMD_NUMA
> 		if (!numa_init(amd_numa_init))
> 			return;
> #endif
> 		if (acpi_disabled && !numa_init(of_numa_init))
> 			return;
> 
> of_numa_init() does not do the numa_set_node() part, but that's not a
> justification to glue this into numa_init() which is firmware
> independent except for the firmware specific callback argument.
> 
> Also x86_numa_init() is invoked _before_ the APIC ID to Linux CPU number
> association happens, so doing the CPU number to node mapping at this
> point is just wrong for any CPU number != 0.
> 
> It "works" for OF just by chance as the actual APIC enumeration which
> associates Linux CPU numbers works in the same order, but that does not
> make it correct in any way.
> 
> x86_acpi_numa_init() and amd_numa_init() set up the nodes like
> of_numa_init() does and aside of that save the APIC ID to node mapping.
> 
> Aside of that the numa_set_node() variant happens to "work" for Intel
> CPUs as srat_detect_node() falls back to cpu_to_node() when
> numa_cpu_node() returns NO_NUMA_NODE.
> 
> Though the AMD variant falls back to cpu_info.topo.llc_id which is not
> necessarily the same result as what the device tree enumerated.
> 
> I can see why you glued it into numa_init():
> 
>   of_node_to_nid() requires node_possible_map to be initialized, which
>   happens in numa_register_memblks() invoked from numa_init() if the
>   firmware specific callback which enumerates the nodes was successful.
> 
> Of course the change log is silent about this.
> 
> But there is no reason to scan this right in numa_init() as nothing
> needs the information to be set at this point, unless I'm missing
> something obscure, which might be the case when staring at this NUMA
> enumeration maze.
> 
> The CPU to node mapping based on the APIC ID to node mapping happens in
> init_cpu_to_node() which is after the APIC enumeration and the
> finalizing of cpu_possible_map completed. At this point the CPU number
> to APIC ID mapping is stable.
> 
> So the uncompiled below should just work, no?
> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -24,6 +24,7 @@
>  #include <asm/pci_x86.h>
>  #include <asm/setup.h>
>  #include <asm/i8259.h>
> +#include <asm/numa.h>
>  #include <asm/prom.h>
>  
>  __initdata u64 initial_dtb;
> @@ -137,6 +138,7 @@ static void __init dtb_cpu_setup(void)
>  			continue;
>  		}
>  		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> +		set_apicid_to_node(apic_id, of_node_to_nid(dn));
>  	}
>  }
>  

Thanks for your suggestion. I use this approach because ARM64 and riscv
platforms were having a function of_parse_and_init_cpus to do the same.
But I agree in x86 DeviceTree is handled differently, and we can restrict
the DT related code from numa_init. I will look in to making this approach
work for our platform and send the new patch.

Few thoughts related to recent change wrt removal of x86_dtb_init:
 
I recognize that due to recent changes, each dtb platform will now need to set
a pointer for x86_init.mpparse.early_parse_smp_cfg to get the dtb_cpu_setup
executed. This was not the requirement before because earlier x86_dtb_init was
anyway getting called. Do you think we should improve this as well by setting
x86_init.mpparse.early_parse_smp_cfg to x86_dtb_parse_smp_config for all the
dtb platforms by default.

I see the ce4100 platform is setting the parse_smp_cfg, shouldn't the
early_parse_smp_cfg be more accurate there ?

Let me know if my understanding is correct, I can accommodate these improvements
as well in my patch series.

- Saurabh

