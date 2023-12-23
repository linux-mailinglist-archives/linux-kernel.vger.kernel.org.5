Return-Path: <linux-kernel+bounces-10490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900781D4FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7321C20C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB965171A8;
	Sat, 23 Dec 2023 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/YSffjs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vhaj9sAt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB712B76;
	Sat, 23 Dec 2023 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjlXgqox03zc35mYon6VO8Qr24+OLsYom0EbYgttlNs=;
	b=R/YSffjswpF9HVPZXKFVUKY5O8+aDf5teojhdEN130QRRO6Ogy15IJ9M5LvuK0tjZSgAug
	33G02iCyoUfzxv0XUBst4Qa0tJNlfYX4VqyD3PVXF2kDDMB/g7vajbKCCUNfA9ajx6CeSL
	fbGXY4LRVrNwN4X99t1JUUZVR7eGDWOIE0a15fRIGCCWT7TdAeebzE7Xk/hYHOaiNDWyKV
	h07iUGFCv+KrwjfiTiIsNUrM+8yzj93PmnB+BBgOZjDWmrtRyqfho2DO3sXcBBNdgxjxia
	GUZYllmlY4e5xpm2zwo1JOGcrNRoZgFO1Hc5ZKSjI2CWXvHDumR5EcQn0WNDEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjlXgqox03zc35mYon6VO8Qr24+OLsYom0EbYgttlNs=;
	b=Vhaj9sAty8w/ziE/44AXDSz90q3z/9XCkI2Rvgz9icZL3237tstbxw7GuYydfo7P7NgsCZ
	sWLyW8FrCSF5F9DQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq/cppc: Set the frequency used for computing
 the capacity
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Pierre Gondois <pierre.gondois@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231211104855.558096-7-vincent.guittot@linaro.org>
References: <20231211104855.558096-7-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334779172.398.3874376570543618455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5477fa249b56c59c3baa1b237bf083cffa64c84a
Gitweb:        https://git.kernel.org/tip/5477fa249b56c59c3baa1b237bf083cffa64c84a
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 11 Dec 2023 11:48:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 15:52:36 +01:00

cpufreq/cppc: Set the frequency used for computing the capacity

Save the frequency associated to the performance that has been used when
initializing the capacity of CPUs.

Also, cppc cpufreq driver can register an artificial energy model. In such
case, it needs the frequency for this compute capacity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20231211104855.558096-7-vincent.guittot@linaro.org
---
 drivers/base/arch_topology.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0c9ae5b..1aa76b5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 
 void topology_init_cpu_capacity_cppc(void)
 {
+	u64 capacity, capacity_scale = 0;
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
@@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
 		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
 		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
 			raw_capacity[cpu] = perf_caps.highest_perf;
+			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
+
+			per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
+
 			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
 				 cpu, raw_capacity[cpu]);
 			continue;
@@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
 		goto exit;
 	}
 
-	topology_normalize_cpu_scale();
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu];
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+				     capacity_scale);
+		topology_set_cpu_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, topology_get_cpu_scale(cpu));
+	}
+
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 

