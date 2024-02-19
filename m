Return-Path: <linux-kernel+bounces-71834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3C85AB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36100B26138
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84355E56;
	Mon, 19 Feb 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjcp4DqB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5LRbMJu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C453E39;
	Mon, 19 Feb 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367865; cv=none; b=QyJlK5nqtNcza0d7v1s/JVKm2wDyC5GIxWgO0Zm9UUQ4Aozch0AZNKKzZRMJbpilPWq1QGc7yOU0PWs8vrkHRnJsEDmtA3GG/R+Gqy4uZ9LN6LmHWo9jh4K8Hbo6itNJWCG3olaQOE6CAb74ngrK/brNgqthsc+BoXjZ6uo0pBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367865; c=relaxed/simple;
	bh=3N9P4a0i7dcdrj931WaklTIUwvtpjGdAE2hAVW5Azsc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ShBzgkoT0olXp61FqFsj7EEGmE9BfnzpvAzqMbPvBP/HKjc0MvFLIftZy7qc8CxGOm/6H5gY/U1NMzOzK88oo5yxRpsBpnmmvIJMM+GJ0aw7RBiRzbFxm1e34+K9IPzHJGcadpkuxhgY86PzMghrKxrPo3ZbIDlwPF3g33nWT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjcp4DqB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5LRbMJu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gylPkh/GXT4spEx7pBMUKcdiEuP1e+HFpCy9X4zge8o=;
	b=rjcp4DqBRvs/VJvmtuXOK4eG91zKp5MBRg85j6oGWAZleQYdwdwnrCclhHqq9KhIwHXg4e
	D7e7M+miC6yYK8SrMOTGb9MEZfyIpaLimgysq1Zo9Pqu2O1RmaGKmIws4Fr0GDR76JHaf0
	T4RXycowZquDGQI4IdF7wFujhGsmREv10xl7wdp71qfFLfEjzYClfmqDxqq28zGqcS3Psu
	9J+vZ93WBpkmT/RvtQfpDV2HKCLAr64F8Cl1AoHmeISdURSrrY8pbRg7sp2fH8i4lNTL9c
	c3ONQF0wFjTQMR2rM4a92XBMeRauJiQbhIDQl6n/HJq0/iSQ2VbzvX/LirWf5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gylPkh/GXT4spEx7pBMUKcdiEuP1e+HFpCy9X4zge8o=;
	b=v5LRbMJugSUzgxy+xCkM9TTW1y9IKLBy0QGqm1PREAWM7g7MLeCkpxnoMicVdi8zruLw4A
	+z8LGzf79IP/J/Cg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Free rmid_ptrs from resctrl_exit()
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Babu Moger <babu.moger@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-3-james.morse@arm.com>
References: <20240213184438.16675-3-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836786051.398.1615891156083894968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3f7b07380d58cfbb6a2d3aa672dcc76c0f4b0745
Gitweb:        https://git.kernel.org/tip/3f7b07380d58cfbb6a2d3aa672dcc76c0f4b0745
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:16 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:31 +01:00

x86/resctrl: Free rmid_ptrs from resctrl_exit()

rmid_ptrs[] is allocated from dom_data_init() but never free()d.

While the exit text ends up in the linker script's DISCARD section,
the direction of travel is for resctrl to be/have loadable modules.

Add resctrl_put_mon_l3_config() to cleanup any memory allocated
by rdt_get_mon_l3_config().

There is no reason to backport this to a stable kernel.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-3-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index aa9810a..9641c42 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -990,8 +990,14 @@ late_initcall(resctrl_late_init);
 
 static void __exit resctrl_exit(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	cpuhp_remove_state(rdt_online);
+
 	rdtgroup_exit();
+
+	if (r->mon_capable)
+		rdt_put_mon_l3_config();
 }
 
 __exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 52e7e7d..61c7636 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -544,6 +544,7 @@ void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
+void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3a6c069..3a73db0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -719,6 +719,16 @@ static int dom_data_init(struct rdt_resource *r)
 	return 0;
 }
 
+static void __exit dom_data_exit(void)
+{
+	mutex_lock(&rdtgroup_mutex);
+
+	kfree(rmid_ptrs);
+	rmid_ptrs = NULL;
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
 static struct mon_evt llc_occupancy_event = {
 	.name		= "llc_occupancy",
 	.evtid		= QOS_L3_OCCUP_EVENT_ID,
@@ -814,6 +824,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void __exit rdt_put_mon_l3_config(void)
+{
+	dom_data_exit();
+}
+
 void __init intel_rdt_mbm_apply_quirk(void)
 {
 	int cf_index;

