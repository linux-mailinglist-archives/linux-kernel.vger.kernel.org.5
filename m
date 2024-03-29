Return-Path: <linux-kernel+bounces-124364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F0891641
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48AF1F22837
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5884D107;
	Fri, 29 Mar 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="HtaLcmDX";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="lM7CM1rP"
Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175141740
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705572; cv=none; b=baEVmQapMMeTr7Ezj6c7/vkhlX3YoN8Jxt2Vy2jv9dEDqllOklAMUqI/UJJcbGxTRPi2E+a3M4DCkx1r+4L9fxorR7iYZTxCleqO9FBZ63VyG/Wr2O6nyWqwbdy4NQoeLi9g5SQnewN2DU9TXubYb5D2fVhkA+2+xC+U+yc8mdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705572; c=relaxed/simple;
	bh=5eh1LRXd5nmvFvjVFyc2eA97A0oxvEmwBBzfWaixRGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaSDjQ0ZiGkHaryYORzKj51bzZMavyw523RTnyKvR+rax1CVw5hu+As4oK5lBIKBvJ3mPq+1fdnL3DRqjzjDWJ2Ch72pt6vl6WrjkAOO6bPjMoOpQhhxlDdaTiaQj7f98QZbzosenhsYqq9vxjxIOJoSsa9SZS6LEQSGvTMmfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=HtaLcmDX; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=lM7CM1rP; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=3posw3aF/pMHBf0L+fS4u0dsD0hBXMZlR0kURZ1EsvQ=;
	b=HtaLcmDXG+yhe1LyCwzuJFbMn3QlNTVDlVjkaRK99DCZTOyiU0PKy/fA1te74et227FYnzVqjYkSK
	 rZ28SuUQVbEWbv/qhCKVRiKcZsScXrKDlh5lIkJ+57RrTw5/dgleu3BLqLpaI7+EcrWL5L8buCBAMk
	 5+BTnpMP0VlVbN7i1eHN2BOa0LWxduI1ujdt3cpU90bYYiL90ispbfXtN+y/DJvDETfrhSJZZxlJGO
	 GJ7i54PtHetSnjWc2udQH8ZiEMVVp3kUB5PzBdLn+jnYTdOcq+/Hn2Y0CevMpjGTnvJ7HVXioIMWCn
	 08l2CqUOvLk+8f1noRqZQgzBR4P8y2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=3posw3aF/pMHBf0L+fS4u0dsD0hBXMZlR0kURZ1EsvQ=;
	b=lM7CM1rPfy3FSKRPpuaHF9mCkbIzHw2H1+iu5lnnog/EZuyaiWySNFxogVCKHRTQW5kpSG+/9J4VJ
	 vxvN/2tDg==
X-HalOne-ID: 0058c688-edb1-11ee-b65f-1ff1563c5748
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 0058c688-edb1-11ee-b65f-1ff1563c5748;
	Fri, 29 Mar 2024 09:44:57 +0000 (UTC)
Date: Fri, 29 Mar 2024 10:44:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nick Bowler <nbowler@draconx.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Andreas Larsson <andreas@gaisler.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
Message-ID: <20240329094456.GA44268@ravnborg.org>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
 <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
 <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
 <943c6d11-e214-43c8-8813-8e1aba6be15c@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943c6d11-e214-43c8-8813-8e1aba6be15c@draconx.ca>

Hi Nick,

On Thu, Mar 28, 2024 at 05:08:50PM -0400, Nick Bowler wrote:
> On 2024-03-28 16:09, Linus Torvalds wrote:
> > On Thu, 28 Mar 2024 at 12:36, Linux regression tracking (Thorsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> [CCing Linus, in case I say something to his disliking]
> >>
> >> On 22.03.24 05:57, Nick Bowler wrote:
> >>>
> >>> Just a friendly reminder that this issue still happens on Linux 6.8 and
> >>> reverting commit 9b2f753ec237 as indicated below is still sufficient to
> >>> resolve the problem.
> >>
> >> FWIW, that commit 9b2f753ec23710 ("sparc64: Fix cpu_possible_mask if
> >> nr_cpus is set") is from v4.8. Reverting it after all that time might
> >> easily lead to even bigger trouble.
> > 
> > I'm definitely not reverting a patch from almost a decade ago as a regression.
> > 
> > If it took that long to find, it can't be that critical of a regression.
> 
> FWIW I'm not the first person to notice this problem.  Searching the sparclinux
> archive for "ultra 60" which turns up this very similar report[1] from two years
> prior to mine which also went nowhere (sadly, this reporter did not perform a
> bisection to find the problematic commit -- perhaps because nobody asked).
> 
> [1] https://lore.kernel.org/sparclinux/20201009161924.c8f031c079dd852941307870@gmx.de/

I took a look at this and may have a fix. Could you try the following
patch. It builds - but I have not tested it.

	Sam


From a0fb7c6e6817849550d07b4c5a354ccc58382bc1 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 29 Mar 2024 10:34:07 +0100
Subject: [PATCH] sparc64: Fix number of online CPUs

Nick Bowler reported:
    When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
    CPUs, I noticed that only CPU 0 comes up, while older kernels (including
    4.7) are working fine with both CPUs.

      I bisected the failure to this commit:

      9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
      commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
      Author: Atish Patra <atish.patra@oracle.com>
      Date:   Thu Sep 15 14:54:40 2016 -0600

      sparc64: Fix cpu_possible_mask if nr_cpus is set

    This is a small change that reverts very easily on top of 5.18: there is
    just one trivial conflict.  Once reverted, both CPUs work again.

    Maybe this is related to the fact that the CPUs on this system are
    numbered CPU0 and CPU2 (there is no CPU1)?

The current code that adjust cpu_possible based on nr_cpu_ids do not
take into account that CPU's may not come one after each other.
Move the check to the function that setup the cpu_possible mask
so there is no need to adjust it later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: Nick Bowler <nbowler@draconx.ca>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/smp_64.h |  2 --
 arch/sparc/kernel/prom_64.c     |  4 +++-
 arch/sparc/kernel/setup_64.c    |  1 -
 arch/sparc/kernel/smp_64.c      | 14 --------------
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 505b6700805d..0964fede0b2c 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -47,7 +47,6 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
 void __noreturn cpu_play_dead(void);
 
@@ -77,7 +76,6 @@ void __cpu_die(unsigned int cpu);
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
-#define smp_fill_in_cpu_possible_map() do { } while (0)
 #define smp_init_cpu_poke() do { } while (0)
 #define scheduler_poke() do { } while (0)
 
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 998aa693d491..ba82884cb92a 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -483,7 +483,9 @@ static void *record_one_cpu(struct device_node *dp, int cpuid, int arg)
 	ncpus_probed++;
 #ifdef CONFIG_SMP
 	set_cpu_present(cpuid, true);
-	set_cpu_possible(cpuid, true);
+
+	if (num_possible_cpus() < nr_cpu_ids)
+		set_cpu_possible(cpuid, true);
 #endif
 	return NULL;
 }
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6a4797dec34b..6bbe8e394ad3 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -671,7 +671,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 	init_sparc64_elf_hwcap();
-	smp_fill_in_cpu_possible_map();
 	/*
 	 * Once the OF device tree and MDESC have been setup and nr_cpus has
 	 * been parsed, we know the list of possible cpus.  Therefore we can
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f3969a3600db..e50c38eba2b8 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1220,20 +1220,6 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
-void __init smp_fill_in_cpu_possible_map(void)
-{
-	int possible_cpus = num_possible_cpus();
-	int i;
-
-	if (possible_cpus > nr_cpu_ids)
-		possible_cpus = nr_cpu_ids;
-
-	for (i = 0; i < possible_cpus; i++)
-		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
-		set_cpu_possible(i, false);
-}
-
 void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;
-- 
2.34.1


