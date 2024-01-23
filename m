Return-Path: <linux-kernel+bounces-35342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE0838F92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CEB1F23351
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661461687;
	Tue, 23 Jan 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qbkftHaL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1KlwejD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5F61675
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015453; cv=none; b=tM8IffPHeEyPd+LxE6ol1EQObJEZOW2WxBr+ldf6h3NLC9olMRpXBTJZFbtay5spgCwFlV0yYAGeqMQ8sip/TDhw1UfAF6OiztiTtQkrS6ZFsZ9P5UiDqH5G6EnbqR38Jii60IFQLuc5xdJ9QvZMvfFaizXNesZ+NS/QDsXLhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015453; c=relaxed/simple;
	bh=JHkSD1CkdRbfj+1k3modyeIMoSQ2jw1eW9tZvG/jkFY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=XRm0a1z47zdwf55HY/P1HDUHVOdq3Jm13WT+0foy/LaEEpzCaqnkH10aqHz5IE1l4KlAvY76QDXORlj7dMDEoNTtv1Nf6rX8TwtzT5oaZb+mK4ipE1aYOPB/eq4cY4W2tE2feKPNr2OssdDpIY4hF7AJyhTCu7i+aRBqZ6Ll+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qbkftHaL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1KlwejD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123127.055361964@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=uEr1HqJVrTZ9Ntw6uWkIwomiVTX/iLSyIll72RSXZMo=;
	b=qbkftHaLpmphSmQUYllkMnBxhIIKDwsEWQjJ1fviLG8Foyu1O+5ts4h3hvmLUhsnMFY0TD
	cn5SvyPkgBR+5+M5KREGn4KP2VXWk9MY0BcRRkOCyqe+npPXJaFRTvz7ygzR63eEHSvCCp
	DCtGRsWGKhZC1FW0AS0DtHWcI4c8V6008S9rZYQdbkq9gL4lwOrJyXHblOfed3t/P1ghMi
	5rifO2Xf2ZmxoK68HIXaNtmsz7gg87IHPjGC9Q7WIFdLfSWi5AKjdaAl9QwG0DJUsv44z4
	LVNdJiLf9x/j0w9EXKWU53M+q66X1OzColT2UDJ64k6AIN0W9omJPOV8UvOGOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=uEr1HqJVrTZ9Ntw6uWkIwomiVTX/iLSyIll72RSXZMo=;
	b=B1KlwejD0vYYC1leKcC//fDoVRGsAvG/M5gdlRSMG6caJo6xb5FbT12Jx2N0OqAfKnMIrF
	4Yimr+keIgImLgDw==
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
Subject: [patch v2 00/30] x86/apic: Rework APIC registration
Date: Tue, 23 Jan 2024 14:10:49 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a breakout from:

  https://lore.kernel.org/all/20230807130108.853357011@linutronix.de

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

Changes vs. V1:

	- Breakout of the actual topology management changes

	- Adopt DIEGRP

	- Different approach to identify the BSP on enumeration (Rui)

The current series applies on top of 

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cleanup-v2

and is available from git here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v2

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
 arch/x86/kernel/cpu/topology.c                                 |  484 ++++++++++
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
 46 files changed, 698 insertions(+), 655 deletions(-)



