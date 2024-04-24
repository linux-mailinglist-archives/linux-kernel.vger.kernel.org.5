Return-Path: <linux-kernel+bounces-156829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3B8B08D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C00B22000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6215ADA8;
	Wed, 24 Apr 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9SS5slV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7tyB6E14"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142015A4B0;
	Wed, 24 Apr 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960099; cv=none; b=TUxG508E0uUHMlawpYkdpebeL9HloKtDaz9pYm4JrK+n4UCnZa87Mfb93Hlan0AdYOq8iiwDWC+4KTjnEdc8ACgnpIMU7eivZxCEtUWzyapYP6o+wrrvA77IBCS44/qWT8Oa1jDdlGF//SYJRahPDZXWBa1FwYbIQgSR2hA+W0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960099; c=relaxed/simple;
	bh=lOB4RcL6VX1+OLBxkTjD+573crsAa1zaNOnoIu/0s6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MKDBmJYPtIsLrWrjUcdzhLLEiGFcUR4yKCYEORkSbO4pJQEUqIokv/NWVz8glJWrhPcwRW3YSgw2TFc2ACPuc3v+qQ8K7l7HrzvNhmQyivItd3m5OTgG+ty4Av35uzNg9tA/2h9B88sC7Cu1I8MNeODKoAKolBjQ9QRADSOKzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9SS5slV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7tyB6E14; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 12:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713960087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i81BhLTbMeabXlLemHAZuwudZvtJncr9zG0RQ6knvrQ=;
	b=m9SS5slV++4qUM5muihslAxh+vfn7ACAjhjH6oeFpY5QFj2ieE6CaEcmVtIZ7A2vp80A0n
	WYUMcPVpfv9EeLZoYGs/0PB/9kLoRzC2kZTWVddi8FJt2vdb7CT4hKKeQmlF/qQyaEJ1nU
	Zocv2dK5VjadIiI/1MuVRHJC/0+3KHzAM8yrH5apU44ZbC4gamaePvTdhXO0kWiBJxZQzv
	xjGUJC8Aa2xxI+dpxxzDf+bEtVt80LiUGxn1ns4gz/BS/F8NcWYDs6MtC4LT0udm13XjY/
	2NX2q+DkqBhCJvUUyuS/NV02Ovb0w30UT0ZDrXxHDHJUZC5qdTbqLAArdgfdPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713960087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i81BhLTbMeabXlLemHAZuwudZvtJncr9zG0RQ6knvrQ=;
	b=7tyB6E147E/pX2ZDCOJdxFh66eKBixIbo+NYKoNGU7bqXmtEKez5CKjoOuOg3pLLu5yNh+
	3OilzfFTVlhmrpAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Pass domain to target CPU
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308213846.77075-2-tony.luck@intel.com>
References: <20240308213846.77075-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171396008685.10875.2283874532355149736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e3ca96e479c91d6ee657d3caa5092a6a3a620f9f
Gitweb:        https://git.kernel.org/tip/e3ca96e479c91d6ee657d3caa5092a6a3a620f9f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 08 Mar 2024 13:38:45 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Apr 2024 13:41:41 +02:00

x86/resctrl: Pass domain to target CPU

reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
to call rdt_ctrl_update() on potentially one CPU from each domain.

But this means rdt_ctrl_update() needs to figure out which domain to
apply changes to. Doing so requires a search of all domains in a resource,
which can only be done safely if cpus_lock is held. Both callers do hold
this lock, but there isn't a way for a function called on another CPU
via IPI to verify this.

Commit

  c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
  false positive")

removed the incorrect assertions.

Add the target domain to the msr_param structure and call
rdt_ctrl_update() for each domain separately using
smp_call_function_single(). This means that rdt_ctrl_update() doesn't
need to search for the domain and get_domain_from_cpu() can safely
assert that the cpus_lock is held since the remaining callers do not use
IPI.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Link: https://lore.kernel.org/r/20240308213846.77075-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 17 +++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 ++++------------------
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 +------
 4 files changed, 17 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e4034..acf52aa 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -362,6 +362,8 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
+	lockdep_assert_cpus_held();
+
 	list_for_each_entry(d, &r->domains, list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->cpu_mask))
@@ -378,19 +380,11 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
 
 void rdt_ctrl_update(void *arg)
 {
+	struct rdt_hw_resource *hw_res;
 	struct msr_param *m = arg;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
-	struct rdt_resource *r = m->res;
-	int cpu = smp_processor_id();
-	struct rdt_domain *d;
 
-	d = get_domain_from_cpu(cpu, r);
-	if (d) {
-		hw_res->msr_update(d, m, r);
-		return;
-	}
-	pr_warn_once("cpu %d not found in any domain for resource %s\n",
-		     cpu, r->name);
+	hw_res = resctrl_to_arch_res(m->res);
+	hw_res->msr_update(m->dom, m, m->res);
 }
 
 /*
@@ -463,6 +457,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	hw_dom->ctrl_val = dc;
 	setup_default_ctrlval(r, dc);
 
+	m.dom = d;
 	m.low = 0;
 	m.high = hw_res->num_closid;
 	hw_res->msr_update(d, &m, r);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7997b47..165d8d4 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -272,22 +272,6 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 	}
 }
 
-static bool apply_config(struct rdt_hw_domain *hw_dom,
-			 struct resctrl_staged_config *cfg, u32 idx,
-			 cpumask_var_t cpu_mask)
-{
-	struct rdt_domain *dom = &hw_dom->d_resctrl;
-
-	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
-		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
-
-		return true;
-	}
-
-	return false;
-}
-
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
@@ -302,6 +286,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	hw_dom->ctrl_val[idx] = cfg_val;
 
 	msr_param.res = r;
+	msr_param.dom = d;
 	msr_param.low = idx;
 	msr_param.high = idx + 1;
 	hw_res->msr_update(d, &msr_param, r);
@@ -315,48 +300,39 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	enum resctrl_conf_type t;
-	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	u32 idx;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
+		msr_param.res = NULL;
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
 			if (!cfg->have_new_ctrl)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
+			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
+			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
 
 			if (!msr_param.res) {
 				msr_param.low = idx;
 				msr_param.high = msr_param.low + 1;
 				msr_param.res = r;
+				msr_param.dom = d;
 			} else {
 				msr_param.low = min(msr_param.low, idx);
 				msr_param.high = max(msr_param.high, idx + 1);
 			}
 		}
+		if (msr_param.res)
+			smp_call_function_any(&d->cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
 
-	if (cpumask_empty(cpu_mask))
-		goto done;
-
-	/* Update resource control msr on all the CPUs. */
-	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-
-done:
-	free_cpumask_var(cpu_mask);
-
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1a8687f..ab2d315 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -379,11 +379,13 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
+ * @dom:       The domain to update
  * @low:       Beginning index from base MSR
  * @high:      End index
  */
 struct msr_param {
 	struct rdt_resource	*res;
+	struct rdt_domain	*dom;
 	u32			low;
 	u32			high;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 011e17e..02f213f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2813,16 +2813,12 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
-	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	int i;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	msr_param.res = r;
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
@@ -2834,17 +2830,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 */
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
 		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
+		msr_param.dom = d;
+		smp_call_function_any(&d->cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
 
-	/* Update CBM on all the CPUs in cpu_mask */
-	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-
-	free_cpumask_var(cpu_mask);
-
 	return 0;
 }
 

