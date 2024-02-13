Return-Path: <linux-kernel+bounces-64285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD6853CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6420EB24D76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469E62803;
	Tue, 13 Feb 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldtFlijz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3x1/734"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95916627F6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858337; cv=none; b=SC68b2/sQ453fA83LFpsBCDJOXGrkCoNodROFkcbJyfOlNtmA9YM3NEZGgZL6KR435Oi8q+Razm2ATBM2u5GDq/p0KDA2lvrUf+MJJMnv7sgy7Mrwq7aU7VZINDTGxkBh7V1g+Qi9ePeXDnx9sxm5paimnajFsNZL9X0kFzD8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858337; c=relaxed/simple;
	bh=kgDzKsdtMuEF7Io1ivouh6eeY3b6/bdYYWaBxrvsXw0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=a9yGGOEXPrvYabgUpFoRBRyUQKc7VV8GpkuyAFHwDlHToqM9u0qGyJWwbm5RrEy7k+sQDQ4JUfOm+WB+r7pg0u7kbCr8Ums+uCpVSnJamIqu7/TA1xxUIZyj5gXgC5XVtsUGzTQ/fmWwep2z80gZ276m5ZxAIPsOoP2ccYSrkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldtFlijz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3x1/734; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213205415.307029033@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=oO9YwDPbVLpDwvub49RefHM96AIua9PV2/ig3ZsO23A=;
	b=ldtFlijzgXi6yrny//BEJJlJGoc/CLC2DFfqEASUa5ciOxs+a6j6s/mxOuC5X283BmjASj
	+K+IZSZ/4GsYRNAangze7NXrWDOdy7cJIK1ydRJeGLjp94zR4O+Qr3h97WqfLj/g0mh77A
	iqWK/3UI8Kz5JS/vTlUpo0kk/i7w2sVtV1aiuwofGeCFw+n4uB0odePaKK2D8T8bqjk3O6
	ScLX7UDQtVYOKLwCudUDb1v43nBDhEMKNzYCHEhEQOExFHGxikGRZU7qKp7fy7Ii5/5el5
	Qkb1TY0fWt1iVtTmSqctTm5OYIFK4ZVnSyxwXDXgQvx1U54S1nF7bhXnL5h8Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=oO9YwDPbVLpDwvub49RefHM96AIua9PV2/ig3ZsO23A=;
	b=A3x1/734u0dwCwJxZT7pa8q6Gm0/CREkj0ujMoqMP20y8PCyXrq4XbLkLaUCo0r6aaDx9A
	Y8Z6AzSzbeRBDgAA==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 00/30] x86/apic: Rework APIC registration
Date: Tue, 13 Feb 2024 22:05:33 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up to the V2 series which can be found here:

  https://lore.kernel.org/all/20240118123127.055361964@linutronix.de

addressing the issues of the current topology code:

  - Wrong core count on hybrid systems

  - Heuristics based size information for packages and dies which
    are failing to work correctly with certain command line parameters.

  - Full evaluation fail for a theoretical hybrid system which boots
    from an E-core

  - The complete insanity of manipulating global data from firmware parsers
    or the XEN/PV fake SMP enumeration. The latter is really a piece of art.

This series addresses this by

  - Consolidating all topology relevant functionality into one place

  - Providing separate interfaces for boot time and ACPI hotplug operations

  - A sane ordering of command line options and restrictions

  - A sensible way to handle the BSP problem in kdump kernels instead of
    the unreliable command line option.

  - Confinement of topology relevant variables by replacing the XEN/PV SMP
    enumeration fake with something halfways sensible.

  - Evaluation of sizes by analysing the topology via the CPUID provided
    APIC ID segmentation and the actual APIC IDs which are registered at
    boot time.

  - Removal of heuristics and broken size calculations

The idea behind this is the following:

The APIC IDs describe the system topology in multiple domain levels. The
CPUID topology parser provides the information which part of the APIC ID is
associated to the individual levels (Intel terminology):

   [ROOT][PACKAGE][DIEGRP][DIE][TILE][MODULE][CORE][THREAD]

The root space contains the package (socket) IDs. Not enumerated levels
consume 0 bits space, but conceptually they are always represented. If
e.g. only CORE and THREAD levels are enumerated then the DIEGRP, DIE,
MODULE and TILE have the same physical ID as the PACKAGE.

If SMT is not supported, then the THREAD domain is still used. It then
has the same physical ID as the CORE domain and is the only child of
the core domain.

This allows an unified view on the system independent of the enumerated
domain levels without requiring any conditionals in the code.

AMD does only expose 4 domain levels with obviously different terminology,
but that can be easily mapped into the Intel variant with a trivial lookup
table added to the CPUID parser.

The resulting topology information of an ADL hybrid system with 8 P-Cores
and 8 E-Cores looks like this:

 CPU topo: Max. logical packages:   1
 CPU topo: Max. logical dies:       1
 CPU topo: Max. dies per package:   1
 CPU topo: Max. threads per core:   2
 CPU topo: Num. cores per package:    16
 CPU topo: Num. threads per package:  24
 CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
 CPU topo: Thread    :    24
 CPU topo: Core      :    16
 CPU topo: Module    :     1
 CPU topo: Tile      :     1
 CPU topo: Die       :     1
 CPU topo: Package   :     1

This is happening on the boot CPU before any of the APs is started and
provides correct size information right from the start.

Even the XEN/PV trainwreck makes use of this now. On Dom0 it utilizes the
MADT and on DomU it provides fake APIC IDs, which combined with the
provided CPUID information make it at least look halfways realistic instead
of claiming to have one CPU per package as the current upstream code does.

This is solely addressing the core topology issues, but there is a plan for
further consolidation of other topology related information into one single
source of information instead of having a gazillion of localized special
parsers and representations all over the place. There are quite some other
things which can be simplified on top of this, like updating the various
cpumasks during CPU bringup, but that's all left for later.

Changes vs. V2:

   - Rebase on topo-cleanup-v3

   - Fix the SMT calculation thinko (Rui)

   - Fix the BSP detection code (Michael, Sohil)

   - Rename a misnomed function (Arjan)

The current series applies on top of 

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cleanup-v3

and is available from git here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v3

Thanks,

	tglx
---
 Documentation/admin-guide/kdump/kdump.rst                      |    7 
 Documentation/admin-guide/kernel-parameters.txt                |    9 
 Documentation/arch/x86/topology.rst                            |   24 
 arch/x86/events/intel/cstate.c                                 |    2 
 arch/x86/events/intel/uncore.c                                 |    2 
 arch/x86/events/intel/uncore_nhmex.c                           |    4 
 arch/x86/events/intel/uncore_snb.c                             |    8 
 arch/x86/events/intel/uncore_snbep.c                           |   18 
 arch/x86/events/rapl.c                                         |    2 
 arch/x86/include/asm/apic.h                                    |   10 
 arch/x86/include/asm/cpu.h                                     |   10 
 arch/x86/include/asm/mpspec.h                                  |    2 
 arch/x86/include/asm/perf_event_p4.h                           |    4 
 arch/x86/include/asm/processor.h                               |    2 
 arch/x86/include/asm/smp.h                                     |    6 
 arch/x86/include/asm/topology.h                                |   53 -
 arch/x86/kernel/acpi/boot.c                                    |   59 -
 arch/x86/kernel/apic/apic.c                                    |  186 ---
 arch/x86/kernel/cpu/Makefile                                   |   12 
 arch/x86/kernel/cpu/cacheinfo.c                                |    2 
 arch/x86/kernel/cpu/common.c                                   |   33 
 arch/x86/kernel/cpu/debugfs.c                                  |    7 
 arch/x86/kernel/cpu/mce/inject.c                               |    3 
 arch/x86/kernel/cpu/microcode/intel.c                          |    2 
 arch/x86/kernel/cpu/topology.c                                 |  489 ++++++++++
 arch/x86/kernel/cpu/topology.h                                 |   11 
 arch/x86/kernel/cpu/topology_common.c                          |   45 
 arch/x86/kernel/devicetree.c                                   |    2 
 arch/x86/kernel/jailhouse.c                                    |    2 
 arch/x86/kernel/mpparse.c                                      |   17 
 arch/x86/kernel/process.c                                      |    2 
 arch/x86/kernel/setup.c                                        |    9 
 arch/x86/kernel/smpboot.c                                      |  219 ----
 arch/x86/xen/apic.c                                            |   14 
 arch/x86/xen/enlighten_pv.c                                    |    3 
 arch/x86/xen/smp.c                                             |    2 
 arch/x86/xen/smp.h                                             |    2 
 arch/x86/xen/smp_pv.c                                          |   58 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c               |    2 
 drivers/hwmon/coretemp.c                                       |    2 
 drivers/hwmon/fam15h_power.c                                   |    2 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |    2 
 drivers/powercap/intel_rapl_common.c                           |    2 
 drivers/thermal/intel/intel_hfi.c                              |    2 
 drivers/thermal/intel/intel_powerclamp.c                       |    2 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                   |    2 
 46 files changed, 703 insertions(+), 655 deletions(-)



