Return-Path: <linux-kernel+bounces-35318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED604838F71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0E61C259C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD25EE8D;
	Tue, 23 Jan 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKpc2djB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxImnPBo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114F5EE74
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015407; cv=none; b=Xws3Dh+izC6eihAFI2o3xo5MP/WOPo8FqLX2PREvDsKHsYT8Av6z//Dp7fXVnniti10AiDEZ7vqmPolktnzKfiWwzaVSvvC8YKq8KXtcGb/X1BY2p60htqgOyw7mQ+JcxlYPz51IGTqOOLZvgNb4yQ1/O2oP0Trznf1HQav6NZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015407; c=relaxed/simple;
	bh=bGVBAZlY0x7DSwAyeKfr/If8lLjIpCFiLDXRX28FEg4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=qC/ruzejGUVoBZF9tud/SQWrvznUAKwPE4UR4GnT7/RsKnZoeJmUn+J9M6NiwzAK48tu4hDMJMMDHSiD10JwZ/pvpPOojBJjQDCvZOtUq9dZ7qkjshueOfohTMx0GUfgs0peqPtCOvtUpF1qqsGUF9QnNku0Tf7S2XRgvQXK9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKpc2djB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxImnPBo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124704.044462658@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ElgRLHgjdgKvlWt1OxX82ZuXGnBuxeJDyrHpld0uVRU=;
	b=UKpc2djBj45ZxjjLmhJsrMf5x9gQO23utVB2TZ9PHdzZz6U00UNR0KMiOJM3AJG9ydYPCH
	QyXbiTz/0/YwHxdb8rVpZQigsXgZyiBo91HRhwYBdMaUSMayQLDcM4RHW1ZooYRCu1JCL2
	v4maqW/sLkwKre9NLrvBsPWdAMVv/FrNtWzL2iPoNkDv/Cqnu4x0SMAmAc0yOSRnUDU2Ye
	S3z+jdQh13YKpiLY1R8eSqT/ohbBDySLcyn5pamGu7vN+KfOCyCEP5Nea7GCv9QtMLebPF
	0alfduM3rmzOzMSi47JE1AFYcqgcBTdyqtO+DUm1EknDita5JXNi+UFNmy2BTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ElgRLHgjdgKvlWt1OxX82ZuXGnBuxeJDyrHpld0uVRU=;
	b=DxImnPBovmCWVsfWnZTnh97es4c0aStS613TSYbPs6i1coDOfP4vkG0m7f+1bfqK+qGGmt
	PCsH2gZAXU5W9gBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 00/22] x86/topology: More cleanups and preparatory work
Date: Tue, 23 Jan 2024 14:10:02 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up to and a breakout from:

  https://lore.kernel.org/all/20230807130108.853357011@linutronix.de

It's mostly mopping up technical debt and preparing for the actual APIC ID
management rework, which is required to handle asymmetric configurations
like P/E systems correctly.

Changes vs. the original series:

  - Split out the preparatory work

  - Address review feedback (Andy)

It applies on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v5

and is available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cleanup-v2

Thanks,

	tglx
---
 hyperv/hv_vtl.c                |    5 +-
 include/asm/apic.h             |   11 +----
 include/asm/io_apic.h          |    1 
 include/asm/mpspec.h           |   64 ++++++-----------------------
 include/asm/prom.h             |    4 -
 include/asm/x86_init.h         |   10 ++--
 kernel/apic/apic.c             |   29 ++-----------
 kernel/apic/apic_common.c      |   15 ------
 kernel/apic/apic_flat_64.c     |    9 ----
 kernel/apic/apic_noop.c        |    2 
 kernel/apic/apic_numachip.c    |   12 -----
 kernel/apic/bigsmp_32.c        |   14 ------
 kernel/apic/io_apic.c          |   90 +++++++++++++++--------------------------
 kernel/apic/local.h            |    4 -
 kernel/apic/probe_32.c         |    3 -
 kernel/apic/x2apic_cluster.c   |    3 -
 kernel/apic/x2apic_phys.c      |    6 --
 kernel/apic/x2apic_uv_x.c      |    6 --
 kernel/cpu/common.c            |   15 ------
 kernel/cpu/topology_common.c   |   12 +++++
 kernel/devicetree.c            |    2 
 kernel/jailhouse.c             |   28 ++++++------
 kernel/mpparse.c               |   14 +++++-
 kernel/setup.c                 |   18 +++-----
 kernel/smpboot.c               |    8 +--
 kernel/x86_init.c              |    5 +-
 mm/amdtopology.c               |    7 ---
 platform/ce4100/ce4100.c       |   14 +++---
 platform/intel-mid/intel-mid.c |    5 +-
 xen/apic.c                     |    7 ---
 xen/enlighten_hvm.c            |    2 
 xen/smp_pv.c                   |   10 +---
 32 files changed, 140 insertions(+), 295 deletions(-)





