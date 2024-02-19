Return-Path: <linux-kernel+bounces-71818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943D85AB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA771F23638
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DA64BAA7;
	Mon, 19 Feb 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJ++q+Q5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yd4lyYcM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AAD482FE;
	Mon, 19 Feb 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367851; cv=none; b=EBh37/HQ8fnzwK/HrxIDvVN61JpOvbALeAktUgyiRur+e+8W/ZId7nhtcRapTnTuXrooLUWAQvZjEnIN95ie9REksI5ek59Zma03TLogKrL1IkdieU3y6+wdSUxV1sx9QQnf/VJ7GwmLB6JvnF8El4pPMFLqhqFbf6964bUmdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367851; c=relaxed/simple;
	bh=uTjzT9wsK5t/j5Jdi+CXuqJYUDR7qEaE1+gPR2Y6bvM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LLpmUcQOonNpYVjAUyV+9gyqTpQixW/9zwLePHZpGu6gZUItO5vFVXQy5Wfk/oWJQcQ4WqxGAXvT/eliRQm05Mj3qeUItp79JKQgRveDiuqEpZn74Evm6Liyti5wNaM5KNcfRwsIsMacCclGZ3KR6YCKhE22sTt8SFA+0RDvZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJ++q+Q5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yd4lyYcM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOaICoYsXlC1dBeVQGyX7a5ZCGRDm7PdNeva/BlOHj0=;
	b=cJ++q+Q5VxDyJNQtnN7eFl+xHDAjoEvW7xh6BE3X8J87OTYX4YQzrBP5iRM6Xfj4slNaMV
	Hu1N9D7RHSyGBD7CaHimImEoBceAKfBq0CK6qcnPB3VqM5tpls9rbH1yXOTxN1uH6J0oUT
	2ecks5gIXBYgGbVzpsvhoJD8yjEpkSc5c/t/aev62XSer5JZVraWWZXu8/rGKHLqphGOpL
	uuuhixcOujo/m8dwkUatMHWSrDZ6lPB2TVtZpGIv4kXf/Fcn193tHS9ciHsEZHKRuGkYiY
	dJ5XDgASHXdgNIM8u3BO9zKpW0yo3aFbMocI2AptdqRN6BOFuMjBvgLdPm9BPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOaICoYsXlC1dBeVQGyX7a5ZCGRDm7PdNeva/BlOHj0=;
	b=Yd4lyYcM++cevgfH/XlDjncE8xYg9Fsmz/G8AuU5/xBITA2qMbxhWHs+xT6BzQRCuXdy4l
	qfxx6JPlpplxUUCA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make rdt_enable_key the arch's decision
 to switch
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-19-james.morse@arm.com>
References: <20240213184438.16675-19-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784676.398.13493876023963749293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0a2f4d9b548c5b1e2e3fcfa966f5d47b1cacff01
Gitweb:        https://git.kernel.org/tip/0a2f4d9b548c5b1e2e3fcfa966f5d47b1cacff01
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:32 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:33 +01:00

x86/resctrl: Make rdt_enable_key the arch's decision to switch

rdt_enable_key is switched when resctrl is mounted. It was also previously used
to prevent a second mount of the filesystem.

Any other architecture that wants to support resctrl has to provide identical
static keys.

Now that there are helpers for enabling and disabling the alloc/mon keys,
resctrl doesn't need to switch this extra key, it can be done by the arch code.
Use the static-key increment and decrement helpers, and change resctrl to
ensure the calls are balanced.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-19-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/resctrl.h         |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 3c9137b..b74aa34 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -45,21 +45,25 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 static inline void resctrl_arch_enable_alloc(void)
 {
 	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_disable_alloc(void)
 {
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_enable_mon(void)
 {
 	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
 }
 
 static inline void resctrl_arch_disable_mon(void)
 {
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 231207f..7e57ac9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2672,10 +2672,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable) {
-		static_branch_enable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable || rdt_mon_capable)
 		resctrl_mounted = true;
-	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2946,9 +2944,10 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
-	resctrl_arch_disable_alloc();
-	resctrl_arch_disable_mon();
-	static_branch_disable_cpuslocked(&rdt_enable_key);
+	if (rdt_alloc_capable)
+		resctrl_arch_disable_alloc();
+	if (rdt_mon_capable)
+		resctrl_arch_disable_mon();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);

