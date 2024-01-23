Return-Path: <linux-kernel+bounces-35568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C675E839363
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E83A1F27621
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59543605B7;
	Tue, 23 Jan 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+7P1vcO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/+a/mfm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1F320D;
	Tue, 23 Jan 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024210; cv=none; b=XOWS2QbI9RsVgtabSctA3c2LDSBMDmzAvJLr5XnS+R8gYERGbwUYdnR4jvxZrWQO9NxApfYl0QQiGW/ZUlq9Bl8+GoQT9wywDhXkjqZf2pfVlLT8euP2qg3Y0fGj+vBnlYQy6vF+EStdq017/9qhIun15iWxXP6ZKezKE20vr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024210; c=relaxed/simple;
	bh=BzJqiMcgyzlFNI3Knp+0uqWZQXC+YZig9A+940qhzGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Au2QdhZu1YsCzDcvCmxyyIGe1VpRt5ECNltR1fjLgBCU+qsJgI7yOBuiHIjmEOdHHL6fz4xkHY+9HktSa7zrO+bWHgHpXhJkQHc7EaajhUw25NSR/kIK8/Qqr28eweRebxMggzlXfa9nginu0vcQqu5U0GfRYDWqsxFgU+jG7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+7P1vcO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/+a/mfm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Jan 2024 15:36:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706024206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiUK2TP0uB+jBjXZmMvIPziX7NUOWUg1Q3Wut2ydyuE=;
	b=g+7P1vcOY+TFcf4v+AoDTsd01ogCciYEww51Z1exGNyUfz3FziH06GRin9ZHnx4ehygFA0
	21xBSrYo7LsMt4knvuiClS0pY9dHM30vUsnCsYRVTy8eLxwUlRVowsXcwFbERc9mGDNHoW
	ZG1+skGMzusWP2fZVkGP2GOG23of/Lv21o381Ik6IJeR7/1EM4sqIntvqQf3MQcQEjL/Bn
	DIKcgE8ZGF9XHBu5752DO4yGalriI0UDmMo8gS9Cf94xSA/eO0Iz+bpAFzncCf5bF9DaSv
	BOVlWufdmDd2ALnwQixtFWZtk6ooS+EVg7udSem91wlY5WxlJhjj7XltBBEz8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706024206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiUK2TP0uB+jBjXZmMvIPziX7NUOWUg1Q3Wut2ydyuE=;
	b=u/+a/mfmF1W1n2dwACExjlOxpWyEcADlmXWhGfz767sxqEzU2bKqljahxf1/v0t2GOWaOL
	3D4YTPS8m28HgBBg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Read supported bandwidth sources from CPUID
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com>
References:
 <669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170602420544.398.8627515196017767305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     54e35eb8611cce5550d3d7689679b1a91c864f28
Gitweb:        https://git.kernel.org/tip/54e35eb8611cce5550d3d7689679b1a91c864f28
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 15 Jan 2024 16:52:28 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 23 Jan 2024 16:26:42 +01:00

x86/resctrl: Read supported bandwidth sources from CPUID

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured. The maximum supported
bandwidth bitmask can be read from CPUID:

  CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event Configuration]
  Bits    Description
  31:7    Reserved
   6:0    Identifies the bandwidth sources that can be tracked.

While at it, move the mask checking to mon_config_write() before
iterating over all the domains. Also, print the valid bitmask when the
user tries to configure invalid event configuration value.

The CPUID details are documented in the Processor Programming Reference
(PPR) Vol 1.1 for AMD Family 19h Model 11h B1 - 55901 Rev 0.25 in the
Link tag.

Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: https://lore.kernel.org/r/669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d297974..e3dc35a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -394,6 +394,8 @@ struct rdt_parse_data {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
+ *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -408,6 +410,7 @@ struct rdt_hw_resource {
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac0..acca577 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		return ret;
 
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* Detect list of bandwidth sources that can be tracked */
+		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
+		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
 			mbm_config_rftype_init("mbm_total_bytes_config");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de9..2b69e56 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1620,12 +1620,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
 
-	/* mon_config cannot be more than the supported set of events */
-	if (val > MAX_EVT_CONFIG_BITS) {
-		rdt_last_cmd_puts("Invalid event configuration\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
@@ -1663,6 +1657,7 @@ out:
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
@@ -1686,6 +1681,13 @@ next:
 		return -EINVAL;
 	}
 
+	/* Value from user cannot be more than the supported set of events */
+	if ((val & hw_res->mbm_cfg_mask) != val) {
+		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
+				    hw_res->mbm_cfg_mask);
+		return -EINVAL;
+	}
+
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);

