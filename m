Return-Path: <linux-kernel+bounces-71823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D185AB26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0D1C2207B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186D5027F;
	Mon, 19 Feb 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ojrk2NUF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTPzUfBa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B224E1CD;
	Mon, 19 Feb 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367856; cv=none; b=IEJSkkV1NkFdNxLQByEfg5RigOSba+DjLRM7y3B87RxhRwbKQpf74VzIgoojJRWHQhIxPFk1mBrEgc0ne/9osxVnHf2fRCD7Ut/gtQ/G1fIRsbSDxrfviHOyu9torbQFVIyrJYVl6C797RvxgDf32/bXotbsRFek8LH2XyKml80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367856; c=relaxed/simple;
	bh=WAcpIo++xdW6mUgmCOPJgAqn1tr1nX4+wsLRGBJtWT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TRdMTsznQ8BLeCiTbxxVuLCJxGsEAo9uTIll7RGdJYEus5DU1IXnoqxLtfyMcSPFrdh+ih/f1s9M3hcLvb0Z2Oofl5mtCn9fdm6mTcZz3nVGjvavqvpKJLkpiv9YM/7m4EoB1M0Hyun0rWuHKvE+zuaZWj2atzncEz5rm4D9mWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ojrk2NUF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTPzUfBa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J81Dhws8oKIj4m/kQnRvgedlbXL8PWp0Nqu7A9Vp3e0=;
	b=Ojrk2NUFmlUqtJbBlspgeXYneSYExZBjHc3YzLGp5f3Bo6g/XjTsU2VkLTlrpi+7LHyApP
	buXqHs9mH1z6bGFec/hX5pfjz0TEiupD3lD1ejW8y+6nE0nrVErgR2wSFSZwCCKei9rjMa
	EHregrbCASu8DpIe4kI0ww0cStTL9g909zeWkLa529UscZxwijOEVrCtVOObJcj6yR9jTB
	qKFuk/nFDd75UdVwj8kP4iCDWjPCG3PgSo2jA0k3VuqGQmZgFnc8nVd2z9dwCWv4GJySpb
	FWqZ08s+MOPH9m588V0zQ2mp9Z1cN2cKE1P63Px1QRverwrhnDp90S6FJzbbiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J81Dhws8oKIj4m/kQnRvgedlbXL8PWp0Nqu7A9Vp3e0=;
	b=aTPzUfBa3nBSwoPUGdO+P++XOZarw0YNs4SxzwnEZZWOn1zaXUVIhTweB3zuhezvIdCXaF
	B1l+Dqswr5V0WtBg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-14-james.morse@arm.com>
References: <20240213184438.16675-14-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785117.398.9171723521136729207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     09909e098113bed99c9f63e1df89073e92c69891
Gitweb:        https://git.kernel.org/tip/09909e098113bed99c9f63e1df89073e92c69891
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:27 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Queue mon_event_read() instead of sending an IPI

Intel is blessed with an abundance of monitors, one per RMID, that can be
read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
the number implemented is up to the manufacturer. This means when there are
fewer monitors than needed, they need to be allocated and freed.

MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
CSU counter is allowed to return 'not ready' for a small number of
micro-seconds after programming. To allow one CSU hardware monitor to be
used for multiple control or monitor groups, the CPU accessing the
monitor needs to be able to block when configuring and reading the
counter.

Worse, the domain may be broken up into slices, and the MMIO accesses
for each slice may need performing from different CPUs.

These two details mean MPAMs monitor code needs to be able to sleep, and
IPI another CPU in the domain to read from a resource that has been sliced.

mon_event_read() already invokes mon_event_count() via IPI, which means
this isn't possible. On systems using nohz-full, some CPUs need to be
interrupted to run kernel work as they otherwise stay in user-space
running realtime workloads. Interrupting these CPUs should be avoided,
and scheduling work on them may never complete.

Change mon_event_read() to pick a housekeeping CPU, (one that is not using
nohz_full) and schedule mon_event_count() and wait. If all the CPUs
in a domain are using nohz-full, then an IPI is used as the fallback.

This function is only used in response to a user-space filesystem request
(not the timing sensitive overflow code).

This allows MPAM to hide the slice behaviour from resctrl, and to keep
the monitor-allocation in monitor.c. When the IPI fallback is used on
machines where MPAM needs to make an access on multiple CPUs, the counter
read will always fail.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-14-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 26 ++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index beccb0e..e933e1c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -19,6 +19,8 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
+
 #include "internal.h"
 
 /*
@@ -522,12 +524,21 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int smp_mon_event_count(void *arg)
+{
+	mon_event_count(arg);
+
+	return 0;
+}
+
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
+	int cpu;
+
 	/*
-	 * setup the parameters to send to the IPI to read the data.
+	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
@@ -536,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->val = 0;
 	rr->first = first;
 
-	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	cpu = cpumask_any_housekeeping(&d->cpu_mask);
+
+	/*
+	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
+	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
+	 * MPAM's resctrl_arch_rmid_read() is unable to read the
+	 * counters on some platforms if its called in IRQ context.
+	 */
+	if (tick_nohz_full_cpu(cpu))
+		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	else
+		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 38f85e5..fd060ef 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -585,7 +585,7 @@ static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 }
 
 /*
- * This is called via IPI to read the CQM/MBM counters
+ * This is scheduled by mon_event_read() to read the CQM/MBM counters
  * on a domain.
  */
 void mon_event_count(void *info)

