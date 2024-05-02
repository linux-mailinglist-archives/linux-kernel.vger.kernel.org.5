Return-Path: <linux-kernel+bounces-166405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1738B9A33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2305B22A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343D69944;
	Thu,  2 May 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5e+D3+Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pwuz9xKk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430E64CE9;
	Thu,  2 May 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650188; cv=none; b=DnqPwVjx7yYBPBVjB6Su6Sd22zSZCa6ZEqE0wTwaZgEp8FpuTj5t+8NIVxYeyJFx/aCnCy5DJFWGV9s8d3st42XSZV8zVBH+6fAerlX/5uYMJWXRXR+E2gQUV1Mk/YO1XhYNYustMB6vIfu9+Mns+3Rv1QHCdMd5pIIqSLhJROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650188; c=relaxed/simple;
	bh=segDebKFJR58OLMOPDzjbchamkQ/rfMYFmAiqWN9efY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cbB2p5oKnRP2ou7Zy4h+AwLjl+j/7OwO48paMMaHcLfaVaNv5CSY8mBnAmB0gH5RatjEiEwVTCnbSamKW4nPyzyEOlug/8XiAauG0UD3thhfvsPFTCVdK+Hpfn+TVk4zD0aVXsahMtofYt1UcQZ2jK62ZKQNWGegR8r6zQs0mxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e5e+D3+Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pwuz9xKk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714650185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jzm6wh+gmO7OWFLqLVXLXzyQDUBZhRRXpOWIf8kUSMY=;
	b=e5e+D3+Yy5ih6PZmtlmef6WzaGfK+WRmEMhqGTE/kNPjBarZWgwUg8jjylwWejPHwO91Qm
	JBhicVgHw4qZZ4Yj9zltW53QdS5lwopAjnCPt7Su/Y1jF3S534E4VAyLeLlp+TP0F98/yI
	LggoYGjuXHV+3z+K695J28ZB2/P2HLsyqLnurqtSL2CYvFpK/ANDYYFM61M3D26uDAyGyJ
	bzEAK+W1aqlzcKGKZStpFlH/Jfz45A091OMWclwt/KIvKi/qhH7W9xo5ZybY5smQiCg8hh
	H5WkncxM1R7NslSfmwYvP2JeJ9/D1v6aJfIjzVRQKw7BXN3tMPdNmCXe/6a2AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714650185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jzm6wh+gmO7OWFLqLVXLXzyQDUBZhRRXpOWIf8kUSMY=;
	b=Pwuz9xKktbmJCv9AgpVvW8xlCurduDBRopKkU08T97CT5yXgyoiSIKTAlaqr5uu/AN29pU
	gu8gbVN/JwpVkmCQ==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Rename 'maxdie' to nr_rapl_pmu and
 'dieid' to rapl_pmu_idx
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Ingo Molnar <mingo@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502095115.177713-2-Dhananjay.Ugwekar@amd.com>
References: <20240502095115.177713-2-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171465018490.10875.7721607041690178507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     626c5acf39ba929a0d82d37e72072e21492a958e
Gitweb:        https://git.kernel.org/tip/626c5acf39ba929a0d82d37e72072e21492a958e
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Thu, 02 May 2024 15:21:14 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:32:21 +02:00

perf/x86/rapl: Rename 'maxdie' to nr_rapl_pmu and 'dieid' to rapl_pmu_idx

AMD CPUs have the scope of RAPL energy-pkg event as package, whereas
Intel Cascade Lake CPUs have the scope as die.

To account for the difference in the energy-pkg event scope between AMD
and Intel CPUs, give more generic and semantically correct names to the
maxdie and dieid variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240502095115.177713-2-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ca5f687..46e6735 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -114,8 +114,8 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
-	unsigned int		maxdie;
-	struct rapl_pmu		*pmus[] __counted_by(maxdie);
+	unsigned int		nr_rapl_pmu;
+	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
 };
 
 enum rapl_unit_quirk {
@@ -141,13 +141,13 @@ static struct perf_msr *rapl_msrs;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int dieid = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return dieid < rapl_pmus->maxdie ? rapl_pmus->pmus[dieid] : NULL;
+	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -658,7 +658,7 @@ static void cleanup_rapl_pmus(void)
 {
 	int i;
 
-	for (i = 0; i < rapl_pmus->maxdie; i++)
+	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
 		kfree(rapl_pmus->pmus[i]);
 	kfree(rapl_pmus);
 }
@@ -674,13 +674,13 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmus(void)
 {
-	int maxdie = topology_max_packages() * topology_max_dies_per_package();
+	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-	rapl_pmus->maxdie		= maxdie;
+	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
 	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;

