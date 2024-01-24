Return-Path: <linux-kernel+bounces-37807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9947C83B5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4518B22A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D53136666;
	Wed, 24 Jan 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTKytzZm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UImZUpaa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A64135407;
	Wed, 24 Jan 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140233; cv=none; b=WChWUqMEQgK8rxThY1Ms620Vj199U4+ix+BNlMhB3Uc618O8Of/dySLBZgbTV5KcWaZACY7a9ds2XaILFuU86OQGBmw+4x2fdxSNIL1wb4jrhHg+59C2Jw/nn+YxKFGXhLLzBj7fI4eF210lMLlDAOfwX6AJF7SJ20H+9HqCSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140233; c=relaxed/simple;
	bh=28oyuCWqOzuiUre2BYd/XpqNp2z9rDAea2r+BqtLB6U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b1PQVsFwUhpl/WRYmIy8IDoFpMOqvYRBomRjsk53q/ZahquQayQrvJsyv4whU2zHF85j+2rbXFxgG6N43xFS4zoMa8Y/7C8/RHOVRQIZ9rltjI/KWncGWeJ2ywPOchlnZUr35Qicfo25yL18j2/EdhH3hLRThTQ6SRtvqUD6rU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTKytzZm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UImZUpaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 23:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706140228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqtun/gfSuSGqOJXigUbaoDPBPqs2SxC2sefNXP0Rlg=;
	b=DTKytzZmHaG0uo7rcCbsvJIXJq4TetR2hbwLaj/CJIYTT34weeAuN21OFgPTozDhgEp1by
	sZ766xOq03HmfDGtv6DLQJXfOxe7wmgrAZ6RNTMsHVOXrxsJxXXr8+rl6xR29gdrfLTgrE
	f6gkvINMU1egezBuwD3d+6y/aTE6nxT+fJRABM8YofDWlz4mSq/WqKwb+EPgmwYLlsZeJX
	d4s0uUXKmuQkub1xB73q8pklfCt+d1M+ejikh245uI9sHihdNLkMLbXObQBEbmNUxZlmXv
	ILuA7q2X+ZluwmobXP+L327K6kJ6yTxQhf5/yS3KBdSxBACbbizog4kMrmZIcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706140228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqtun/gfSuSGqOJXigUbaoDPBPqs2SxC2sefNXP0Rlg=;
	b=UImZUpaa85vE6/qjQH+2zGu+1jwryq0Wp1qHzWsMjQ3HCf9R1ULAdo6yvvFkKQBf9QH1a5
	gcEHwTC+LrfmC2Cw==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove redundant variable in
 mbm_config_write_domain()
Cc: kernel test robot <lkp@intel.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <202401241810.jbd8Ipa1-lkp@intel.com>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170614022689.398.12396173216201868713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     fc747eebef734563cf68a512f57937c8f231834a
Gitweb:        https://git.kernel.org/tip/fc747eebef734563cf68a512f57937c8f231834a
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 24 Jan 2024 11:52:56 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Jan 2024 00:41:59 +01:00

x86/resctrl: Remove redundant variable in mbm_config_write_domain()

The kernel test robot reported the following warning after commit

  54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").

even though the issue is present even in the original commit

  92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")

which added this function. The reported warning is:

  $ make C=1 CHECK=scripts/coccicheck arch/x86/kernel/cpu/resctrl/rdtgroup.o
  ...
  arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "0" on line 1655

Remove the local variable 'ret'.

  [ bp: Massage commit message, make mbm_config_write_domain() void. ]

Fixes: 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/202401241810.jbd8Ipa1-lkp@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2b69e56..aa24343 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1614,11 +1614,10 @@ static void mon_event_config_write(void *info)
 	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
 }
 
-static int mbm_config_write_domain(struct rdt_resource *r,
-				   struct rdt_domain *d, u32 evtid, u32 val)
+static void mbm_config_write_domain(struct rdt_resource *r,
+				    struct rdt_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
-	int ret = 0;
 
 	/*
 	 * Read the current config value first. If both are the same then
@@ -1627,7 +1626,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	mon_info.evtid = evtid;
 	mondata_config_read(d, &mon_info);
 	if (mon_info.mon_config == val)
-		goto out;
+		return;
 
 	mon_info.mon_config = val;
 
@@ -1650,9 +1649,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	 * mbm_local and mbm_total counts for all the RMIDs.
 	 */
 	resctrl_arch_reset_rmid_all(r, d);
-
-out:
-	return ret;
 }
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
@@ -1661,7 +1657,6 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
-	int ret = 0;
 
 next:
 	if (!tok || tok[0] == '\0')
@@ -1690,9 +1685,7 @@ next:
 
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
-			ret = mbm_config_write_domain(r, d, evtid, val);
-			if (ret)
-				return -EINVAL;
+			mbm_config_write_domain(r, d, evtid, val);
 			goto next;
 		}
 	}

