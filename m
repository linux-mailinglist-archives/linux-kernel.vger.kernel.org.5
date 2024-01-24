Return-Path: <linux-kernel+bounces-36806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9083A70E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05567289CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA518E1F;
	Wed, 24 Jan 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mMpXXIRf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TnqR0Lgc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731117551;
	Wed, 24 Jan 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092979; cv=none; b=mjTwSPFvv/3YlpkrKQtYCl+cCGIqRJxwAe0qZ5LeDYo/ODcrubAv4oZ+uDA1hJEUwNjMeZzKFhk5iBhdKSbsGrqJ9qVqa40nRTVLDnfD5U/2ElDQ7qRJPduSLZ/gHYO2MSh5pPapKSBAE/Fy6TIAL7eHkHBYPbA3bj7Ai8yGMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092979; c=relaxed/simple;
	bh=oxmjWtPvBx5rEhH4YdjT7eWZot350oQd77Q9C4n8EQI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fWf+Dg3T5eqmqboyhB/L0i6phkdNT1cqN6Nejru4fwSaqs0rJw7SoG/+QcWPG4vzoLtaolRtveiMWVwrLgvE9ohKs9dU7Zb5/wOt9BSrKrnbQe0FTmP9tq0jLO2q50azXrn0cSH1SS3MwxOuabJTtvxL6ObwCTD8kdLC1R3P988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mMpXXIRf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TnqR0Lgc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 10:42:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706092975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxjl9tdgLylb446oB4wTQBq/k8U/wbxYM/OPAQBZMQk=;
	b=mMpXXIRf5If4pma6AMsDv06fkhFZAqX9rqY27x2v7SRcANRp1c5zx76g2E6WwVfAhHZnAJ
	SepXZw2Pco0Ayn1uPzSwB427clVz4JjjmDn8yDK1cLWpvXvu95OpAesDouoTnoz+1Xu54o
	g2FQCK/I+WSESVaHAd2Vmb8d3f0ODp5Kbr9qg4b477BtzHIKnwAopFZ9xeClK2rar9STCM
	NTp8jfDEdDChcV6+qgMDhjSL6HTn1Aax2NeFXsEzZOIk4H0ezd5FDTQjhqcn3h6cegEJpw
	KAlKLhhsj+HW5bRJ4zn+VyLo/qTksKqxC9uxbxY9jIlRGhXVWc1XvC3ghWi7Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706092975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxjl9tdgLylb446oB4wTQBq/k8U/wbxYM/OPAQBZMQk=;
	b=TnqR0LgcfAhDyWGoPHViG2LonnOL8fGCRUo1nIufonWhtWxi5Texl6ZVOdl+gou+6j0zOG
	zV/Qg0EnZ0kn6sAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Implement new mba_MBps throttling heuristic
Cc: Xiaochen Shen <xiaochen.shen@intel.com>, Tony Luck <tony.luck@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122180807.70518-1-tony.luck@intel.com>
References: <20240122180807.70518-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170609297426.398.11727734850392673356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     c2427e70c1630d98966375fffc2b713ab9768a94
Gitweb:        https://git.kernel.org/tip/c2427e70c1630d98966375fffc2b713ab9768a94
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 22 Jan 2024 10:08:07 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Jan 2024 11:32:01 +01:00

x86/resctrl: Implement new mba_MBps throttling heuristic

The mba_MBps feedback loop increases throttling when a group is using
more bandwidth than the target set by the user in the schemata file, and
decreases throttling when below target.

To avoid possibly stepping throttling up and down on every poll a flag
"delta_comp" is set whenever throttling is changed to indicate that the
actual change in bandwidth should be recorded on the next poll in
"delta_bw". Throttling is only reduced if the current bandwidth plus
delta_bw is below the user target.

This algorithm works well if the workload has steady bandwidth needs.
But it can go badly wrong if the workload moves to a different phase
just as the throttling level changed. E.g. if the workload becomes
essentially idle right as throttling level is increased, the value
calculated for delta_bw will be more or less the old bandwidth level.
If the workload then resumes, Linux may never reduce throttling because
current bandwidth plus delta_bw is above the target set by the user.

Implement a simpler heuristic by assuming that in the worst case the
currently measured bandwidth is being controlled by the current level of
throttling. Compute how much it may increase if throttling is relaxed to
the next higher level. If that is still below the user target, then it
is ok to reduce the amount of throttling.

Fixes: ba0f26d8529c ("x86/intel_rdt/mba_sc: Prepare for feedback loop")
Reported-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xiaochen Shen <xiaochen.shen@intel.com>
Link: https://lore.kernel.org/r/20240122180807.70518-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 42 +++++--------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e3dc35a..52e7e7d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -295,14 +295,10 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
- * @delta_bw:	Difference between the current and previous bandwidth
- * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
 	u64	prev_bw_bytes;
 	u32	prev_bw;
-	u32	delta_bw;
-	bool	delta_comp;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index acca577..3a6c069 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -440,9 +440,6 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	cur_bw = bytes / SZ_1M;
 
-	if (m->delta_comp)
-		m->delta_bw = abs(cur_bw - m->prev_bw);
-	m->delta_comp = false;
 	m->prev_bw = cur_bw;
 }
 
@@ -520,11 +517,11 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
 	struct rdtgroup *entry;
+	u32 cur_bw, user_bw;
 
 	if (!is_mbm_local_enabled())
 		return;
@@ -543,7 +540,6 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	cur_bw = pmbm_data->prev_bw;
 	user_bw = dom_mba->mbps_val[closid];
-	delta_bw = pmbm_data->delta_bw;
 
 	/* MBA resource doesn't support CDP */
 	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
@@ -555,49 +551,31 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
 		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
 		cur_bw += cmbm_data->prev_bw;
-		delta_bw += cmbm_data->delta_bw;
 	}
 
 	/*
 	 * Scale up/down the bandwidth linearly for the ctrl group.  The
 	 * bandwidth step is the bandwidth granularity specified by the
 	 * hardware.
-	 *
-	 * The delta_bw is used when increasing the bandwidth so that we
-	 * dont alternately increase and decrease the control values
-	 * continuously.
-	 *
-	 * For ex: consider cur_bw = 90MBps, user_bw = 100MBps and if
-	 * bandwidth step is 20MBps(> user_bw - cur_bw), we would keep
-	 * switching between 90 and 110 continuously if we only check
-	 * cur_bw < user_bw.
+	 * Always increase throttling if current bandwidth is above the
+	 * target set by user.
+	 * But avoid thrashing up and down on every poll by checking
+	 * whether a decrease in throttling is likely to push the group
+	 * back over target. E.g. if currently throttling to 30% of bandwidth
+	 * on a system with 10% granularity steps, check whether moving to
+	 * 40% would go past the limit by multiplying current bandwidth by
+	 * "(30 + 10) / 30".
 	 */
 	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
 		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
 	} else if (cur_msr_val < MAX_MBA_BW &&
-		   (user_bw > (cur_bw + delta_bw))) {
+		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val))) {
 		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
 	} else {
 		return;
 	}
 
 	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
-
-	/*
-	 * Delta values are updated dynamically package wise for each
-	 * rdtgrp every time the throttle MSR changes value.
-	 *
-	 * This is because (1)the increase in bandwidth is not perfectly
-	 * linear and only "approximately" linear even when the hardware
-	 * says it is linear.(2)Also since MBA is a core specific
-	 * mechanism, the delta values vary based on number of cores used
-	 * by the rdtgrp.
-	 */
-	pmbm_data->delta_comp = true;
-	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
-		cmbm_data->delta_comp = true;
-	}
 }
 
 static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)

