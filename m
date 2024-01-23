Return-Path: <linux-kernel+bounces-35264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C5838EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F33286DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50285F549;
	Tue, 23 Jan 2024 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMQ3AGH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWlqUNF+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DB5F540
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014414; cv=none; b=iYmivekgaUZvLZaOG+WcN57q08DCudAo2VJuP15cpFhJEiH5MTWs1cntJ3L4qkrmypEkx4pTBU4guX6Ax6bSBSn87AwxVYc8bh3Dk+TMxgSgc3XzR+JZEibRHcugh5ECEOzgyIWo4S2qDCMMCe+JHzsq/UA25ew0KAhjZzjzwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014414; c=relaxed/simple;
	bh=wOSIRE7vK8aKnDShnAbJeJb+a6x9BurgdxlcOpOD0lg=;
	h=Message-ID:From:To:Cc:Subject:Date; b=GV6/WGl7LSvupzuT3x9IFi9VEjA/WBPbAZ0yR84NfZ/aVBdNSRox5tsxcLZY+y+pa4tP5yqDdNrJAvRAfjg051A7giB4FjA9+vJ0tH0qCjxkR86S7IdEr1BqwCedVTUch+rYCGSab0D/VHv3sQt1tbeYv3czzH/PpLeTaI0HBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMQ3AGH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWlqUNF+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115752.863482697@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=1wZd9ffAqGbuli/t8ueJvyjn6qOFNSXfo6836tJNYwM=;
	b=pMQ3AGH5Q7JkuavYsDR7ITmmIgsuT4o4oh9ckkzcPoFCNLQfgCBADFe8QeZZb6aOAusYBj
	hZK75EarN94xLx7cXoITAo1U0EBaJET11wRLkVKhVzfZDhxb5kyk+3wKNH95ZkTbc4grhl
	TLeTSjOaMekjzA0vuSX8a8LSS/Gnx2NNl8AujAgxFtCHxi0lLvPvBxyS1ws0fL0zpacVhQ
	754q1g0+lHN1WmTW/H/gGOm2kVtpWiLalXB7vQ6tT2D8W9AlIlj1vLni1yYzSy58zyDh66
	FhAT9bYLn+o72YB/Ia+KOZhzf4F0hgr4Td/6fdfi7oYWd5wRPxJ9/poDzPSVmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=1wZd9ffAqGbuli/t8ueJvyjn6qOFNSXfo6836tJNYwM=;
	b=YWlqUNF+IyCBJXStAl+Bad5d2YIIPH+cIo6ZHX9GNwz3SmTtDM0t92nNiDX1oGDHp7Nqlv
	2uWxvqvW8OKoedAQ==
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
Subject: [patch v5 00/19] x86/cpu: Rework topology evaluation
Date: Tue, 23 Jan 2024 13:53:29 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on V4 of this work:

  https://lore.kernel.org/all/20230814085006.593997112@linutronix.de

and contains only the not yet applied part which reworks the CPUID
parsing. This is also preparatory work for the general overhaul of APIC ID
enumeration and management.

Changes vs. V4:

  - Add DIEGRP level explicitly

This applies on Linus tree and is available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v5

Thanks,

	tglx
---
 arch/x86/kernel/cpu/topology.c          |  167 ----------------------
 b/arch/x86/events/amd/core.c            |    2 
 b/arch/x86/include/asm/apic.h           |    1 
 b/arch/x86/include/asm/cpuid.h          |   36 ++++
 b/arch/x86/include/asm/processor.h      |    5 
 b/arch/x86/include/asm/topology.h       |   39 +++++
 b/arch/x86/kernel/amd_nb.c              |    4 
 b/arch/x86/kernel/apic/apic_flat_64.c   |    7 
 b/arch/x86/kernel/apic/apic_noop.c      |    3 
 b/arch/x86/kernel/apic/apic_numachip.c  |    7 
 b/arch/x86/kernel/apic/bigsmp_32.c      |    6 
 b/arch/x86/kernel/apic/local.h          |    1 
 b/arch/x86/kernel/apic/probe_32.c       |    6 
 b/arch/x86/kernel/apic/x2apic_cluster.c |    1 
 b/arch/x86/kernel/apic/x2apic_phys.c    |    6 
 b/arch/x86/kernel/apic/x2apic_uv_x.c    |   63 +-------
 b/arch/x86/kernel/cpu/Makefile          |    3 
 b/arch/x86/kernel/cpu/amd.c             |  146 -------------------
 b/arch/x86/kernel/cpu/cacheinfo.c       |    6 
 b/arch/x86/kernel/cpu/centaur.c         |    4 
 b/arch/x86/kernel/cpu/common.c          |   91 +-----------
 b/arch/x86/kernel/cpu/cpu.h             |   13 -
 b/arch/x86/kernel/cpu/debugfs.c         |   40 +++++
 b/arch/x86/kernel/cpu/hygon.c           |  129 -----------------
 b/arch/x86/kernel/cpu/intel.c           |   25 ---
 b/arch/x86/kernel/cpu/mce/amd.c         |    4 
 b/arch/x86/kernel/cpu/mce/inject.c      |    7 
 b/arch/x86/kernel/cpu/topology.h        |   56 +++++++
 b/arch/x86/kernel/cpu/topology_amd.c    |  182 ++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_common.c |  241 ++++++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_ext.c    |  130 +++++++++++++++++
 b/arch/x86/kernel/cpu/zhaoxin.c         |    4 
 b/arch/x86/kernel/smpboot.c             |   12 +
 b/arch/x86/kernel/vsmp_64.c             |   13 -
 b/arch/x86/mm/amdtopology.c             |   35 ++--
 b/arch/x86/xen/apic.c                   |    6 
 b/arch/x86/xen/smp_pv.c                 |    3 
 b/drivers/edac/amd64_edac.c             |    4 
 b/drivers/edac/mce_amd.c                |    4 
 39 files changed, 792 insertions(+), 720 deletions(-)



