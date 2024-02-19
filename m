Return-Path: <linux-kernel+bounces-71814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036E85AB13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A549B1C21DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C71482E6;
	Mon, 19 Feb 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b1dwxeR+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CuerjmFu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED92E3F1;
	Mon, 19 Feb 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367847; cv=none; b=bfwmPp0mCooe/lSEoZoaSNKKYxnCn5JLPeDhUMchG4geBv5dXLm4D+zyklkpHJpR/KvoAQDuFGzzBZxyq965M+BaHzjPjT9IVkYUfhbBR09QAVNTCiiFXqpSJm7qbBx3sIedlFmhS3dErsCMTXlv+d6ENH20E5yJqua+6B8xjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367847; c=relaxed/simple;
	bh=Luj1MF9VR1EItf/KkQIMsU5Rre93ssXek9Hhh7nL2yw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mjFL4NpSmRnUYAwvVKiYBdyuVEWPDSMJK5gFKRj1BAVc5En7XmYwvJL/3yUanWQrEhygvFJbAPxQADNmvAe5Q497umcRXFi+D0PMXDP9t4+pa2Q/p+ZZaTDyREfL++o+3zyD+57k3JEalGkjTsCkmaa6ntcKAOgc40yQ8QWFvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b1dwxeR+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CuerjmFu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+1C2Zt8CnH0iCo7ZJRja2DS3pesy6U/jvuaPwN0/HM=;
	b=b1dwxeR+V8DFS3RPg0rRMjOMApxn48Xst7q611ppsAzGlmCPgkuBmIVJQf+dkYtGMZuLKD
	Mp8VTVHkyqCZiuANWyrk8O28QYHYIpjApIY9E0m7zQGyuI2VtGdFi6qi/iVW3v8SXEagtV
	fSFet0DEselkxfYNobEpjGR3sveWBFBoBKb0iMk/Yqi2aFtd+eqjGsECF/IrYLKNHFggDw
	6ZgqMbkBbjQ2+Rx3ql7YLzlJWN9kYn4PY+Vlh3DfN8CzSJ/IlCwWAFZrmaPAO9sZgiChv/
	1b2S1doZBSHeQ3ATKn0RcQtkDRrtSsy63cakMYb49PcAzHhAiKDVR5jya9c8gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+1C2Zt8CnH0iCo7ZJRja2DS3pesy6U/jvuaPwN0/HM=;
	b=CuerjmFuYozV8xT6VntgMJuHCrKD8HWq+x2du8Ye9QsPEE5sdKi4I/cnhwihOm/dKAMFdp
	HBirXDqhaV8MS2Dg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add CPU offline callback for resctrl work
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-23-james.morse@arm.com>
References: <20240213184438.16675-23-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784318.398.13490664857150950536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     258c91e84fedc789353a35ad91d827a9111d3cbd
Gitweb:        https://git.kernel.org/tip/258c91e84fedc789353a35ad91d827a9111d3cbd
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:36 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:33 +01:00

x86/resctrl: Add CPU offline callback for resctrl work

The resctrl architecture specific code may need to free a domain when a CPU
goes offline, it also needs to reset the CPUs PQR_ASSOC register.  Amongst
other things, the resctrl filesystem code needs to clear this CPU from the
cpu_mask of any control and monitor groups.

Currently, this is all done in core.c and called from resctrl_offline_cpu(),
making the split between architecture and filesystem code unclear.

Move the filesystem work to remove the CPU from the control and monitor groups
into a filesystem helper called resctrl_offline_cpu(), and rename the one in
core.c resctrl_arch_offline_cpu().

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-23-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 25 +++++--------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 24 ++++++++++++++++++++++++-
 include/linux/resctrl.h                |  1 +-
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 55322ba..4aedefa 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -625,31 +625,15 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+static int resctrl_arch_offline_cpu(unsigned int cpu)
 {
-	struct rdtgroup *cr;
-
-	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask)) {
-			break;
-		}
-	}
-}
-
-static int resctrl_offline_cpu(unsigned int cpu)
-{
-	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
+	resctrl_offline_cpu(cpu);
+
 	for_each_capable_rdt_resource(r)
 		domain_remove_cpu(cpu, r);
-	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
-			clear_childcpus(rdtgrp, cpu);
-			break;
-		}
-	}
 	clear_closid_rmid(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
@@ -971,7 +955,8 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_arch_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu,
+				  resctrl_arch_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f5688c7..5bd3d8f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4017,6 +4017,30 @@ void resctrl_online_cpu(unsigned int cpu)
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
 }
 
+static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+{
+	struct rdtgroup *cr;
+
+	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
+			break;
+	}
+}
+
+void resctrl_offline_cpu(unsigned int cpu)
+{
+	struct rdtgroup *rdtgrp;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
+			clear_childcpus(rdtgrp, cpu);
+			break;
+		}
+	}
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ccbbbe5..270ff1d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -226,6 +226,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_online_cpu(unsigned int cpu);
+void resctrl_offline_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid

