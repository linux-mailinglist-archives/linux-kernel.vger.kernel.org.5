Return-Path: <linux-kernel+bounces-156828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E88B08D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2224B22593
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4415ADA1;
	Wed, 24 Apr 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B8M7xj/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7ppjG9o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146D15AAA7;
	Wed, 24 Apr 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960098; cv=none; b=TydSkfC4NkAyun03/ms+o/yFei+0MTG1JRMYEHMMnH27W2qzFmq8QTcDPWo+mRUiCPgHrxhNSmK8AfRLc3lo8xVcXu23yljOD53na7HVIOwxY2yFkIi8PRg4TF0IUMAPQ6OQnIRLai68u6ZPCy//wH10UogKR4DQwJCITOVF3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960098; c=relaxed/simple;
	bh=gK3wp21w/k0oVq1YDzRBOiUQn+4aHYCTIeO8DoUi090=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U3n7fOG1NvXGFdIfI9Nz3kHnft0js1JMnzzGLOZX9V7TqCh7RjRDO8PhHMgbfi0HqlHGzWruEyITWi4L40nep27iLiJ8i2PpZ/LzZlNW+ifAHVUHDoNxrFQ5ZjV0rZNdMxH9vC1gmHr1PvUnK9XGaIfYbhJbFpB4iK2dmCbG8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B8M7xj/Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7ppjG9o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 12:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713960087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4b8Ew+3Lxiu7qiq1mb7rXGCKfr+q/WtObVJghToldxw=;
	b=B8M7xj/YzrI13sLPsKTbtPf9E2IgWgDPf3hGkObG2u3BAYHLtvgogjjzMpbtNZd5oLTUjy
	znwtok7+HVfb7d70Wm2bBaMxd2NJy3kSrT0GWHJOodx6npgV2UC4+qIG32rGR98zGD1ccX
	XfSbwwBPvgNgK5b0RDNPaiS09QTBHnp4cN5SZ3B56XSmMADEOqLfsqkSSCKkBLYAfxf5Lg
	1FC1wpTobx84CrCa1zc04ExpoDJ9MFfYlBCfTZNYbIukFzOlL/W5bhJ0xUzXJmEdJeQFoS
	u+pEYaSj1rZ5JMmnpYYl+YzNd1kdyxCmGSARRWXChXEZANAgb2Sio9ObUR3lLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713960087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4b8Ew+3Lxiu7qiq1mb7rXGCKfr+q/WtObVJghToldxw=;
	b=G7ppjG9oGmJB1giyOq+FsnK0OIs+qIb0EjWK8WgFTRurohlJLS2v/xpEe5mGPxEUJxBmEZ
	r0/C61or3u2rMZAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Simplify call convention for MSR update
 functions
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Babu Moger <babu.moger@amd.com>,
 "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308213846.77075-3-tony.luck@intel.com>
References: <20240308213846.77075-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171396008598.10875.1036187242067626064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     bd4955d4bc2182ccb660c9c30a4dd7f36feaf943
Gitweb:        https://git.kernel.org/tip/bd4955d4bc2182ccb660c9c30a4dd7f36feaf943
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 08 Mar 2024 13:38:46 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Apr 2024 13:47:00 +02:00

x86/resctrl: Simplify call convention for MSR update functions

The per-resource MSR update functions cat_wrmsr(), mba_wrmsr_intel(),
and mba_wrmsr_amd() all take three arguments:

  (struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)

struct msr_param contains pointers to both struct rdt_resource and struct
rdt_domain, thus only struct msr_param is necessary.

Pass struct msr_param as a single parameter. Clean up formatting and
fix some fir tree declaration ordering.

No functional change.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Link: https://lore.kernel.org/r/20240308213846.77075-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 40 ++++++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  3 +--
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index acf52aa..7751eea 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -56,14 +56,9 @@ int max_name_width, max_data_width;
  */
 bool rdt_alloc_capable;
 
-static void
-mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
-		struct rdt_resource *r);
-static void
-cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
-static void
-mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
-	      struct rdt_resource *r);
+static void mba_wrmsr_intel(struct msr_param *m);
+static void cat_wrmsr(struct msr_param *m);
+static void mba_wrmsr_amd(struct msr_param *m);
 
 #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
 
@@ -309,12 +304,11 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
-static void
-mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+static void mba_wrmsr_amd(struct msr_param *m)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
@@ -334,25 +328,22 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 	return r->default_ctrl;
 }
 
-static void
-mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
-		struct rdt_resource *r)
+static void mba_wrmsr_intel(struct msr_param *m)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], m->res));
 }
 
-static void
-cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+static void cat_wrmsr(struct msr_param *m)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
@@ -384,7 +375,7 @@ void rdt_ctrl_update(void *arg)
 	struct msr_param *m = arg;
 
 	hw_res = resctrl_to_arch_res(m->res);
-	hw_res->msr_update(m->dom, m, m->res);
+	hw_res->msr_update(m);
 }
 
 /*
@@ -457,10 +448,11 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	hw_dom->ctrl_val = dc;
 	setup_default_ctrlval(r, dc);
 
+	m.res = r;
 	m.dom = d;
 	m.low = 0;
 	m.high = hw_res->num_closid;
-	hw_res->msr_update(d, &m, r);
+	hw_res->msr_update(&m);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 165d8d4..b7291f6 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -289,7 +289,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	msr_param.dom = d;
 	msr_param.low = idx;
 	msr_param.high = idx + 1;
-	hw_res->msr_update(d, &msr_param, r);
+	hw_res->msr_update(&msr_param);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ab2d315..f1d9268 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -445,8 +445,7 @@ struct rdt_hw_resource {
 	struct rdt_resource	r_resctrl;
 	u32			num_closid;
 	unsigned int		msr_base;
-	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
-				 struct rdt_resource *r);
+	void			(*msr_update)(struct msr_param *m);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;

