Return-Path: <linux-kernel+bounces-29060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055D48307C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838D01F21756
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9522334;
	Wed, 17 Jan 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LmEOAJxG"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D621A19
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500909; cv=none; b=VtqFKZsQHz2N4+ZE3EbRf6zSZFbJtCA4OVwg8asyORptkgK+f0Q1BmY2GmBSzSXVI3uPRMBm1+FHQB1VAzK44Vx0016gbRDT7qt4/KNAFJ4VEHQ0zVOeukfyA7nW0e1ORAWBDcQ71ddSD8YCTnohE1t3i2Lxvh/VF2oBfzDcYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500909; c=relaxed/simple;
	bh=DrmYJbwpv8RVrBaCOAySn0hApY2UP4eG38NIM3IFk5w=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=kMxSlmDAqkPyJtXFHTbMtcGZkt6Ne+Tx3GEkMcRJoTsu3/AV2BJB984/wXtiAiLH0MuYQQ0rLPSBZ4Q/NRPxQVXn+TC/499hdmk8XR4Mzmcz2JYA2t1uRrvGaT2iKh5H/3d5JHoN3UP9Ep+ddrzQp3YGnLwrOy64IjnB+4cjYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LmEOAJxG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jfHh028536;
	Wed, 17 Jan 2024 06:14:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=zo41x27c4kcVqmTh43FB/0d5x1krHnjvte4oiC06x+E=; b=LmE
	OAJxGpsu0A1Vo6q7FUpeLRx7pafIP/fl1ytcFclFCkWwZRv3aEddZdOd6ZUuGhAz
	siBW9l9Yi1RbbYBtuIwuuYYqJA5IMWOibKh7Anr96/t7hvR8+/rMxOwhZfr19WKY
	vD5gcb8+7I/+XfPNLM3QnEZnK/A9Z7PTYngnw6v0WrYcGVvD+cxVFYCtTknK4Plb
	vJEKuFpstWJXD6lXxUHEdqhivwU8QofQgcZbQMrMpDaA9UmWOjvMvi6xSJKS/3GY
	Tg07T4paMRYTbBrUaXiZ/n4/lkTp6txI61KrRLm96HAXv85PCGtAPFelAVp/TdRX
	FIv8i0sF5gZLRjA1Gng==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask952s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:48 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:46 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 492455B6932;
	Wed, 17 Jan 2024 06:14:43 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 09/14] fs/resctrl: set configuration based on Control type
Date: Wed, 17 Jan 2024 19:44:00 +0530
Message-ID: <20240117141405.3063506-10-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117141405.3063506-1-amitsinght@marvell.com>
References: <20240117141405.3063506-1-amitsinght@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZUM7RWHKmN4PPOpzbZYqgyMr01Hrf6Xw
X-Proofpoint-GUID: ZUM7RWHKmN4PPOpzbZYqgyMr01Hrf6Xw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Now that, we have support for different control types, divided into
the BASIC and PRIORITY controls types. Schemata list is pertained to
the SCHEMAT_BASIC control type that is used to set up/configure
CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation)
capabilities, and SCHEMAT_DSPRI used to configure downstream priority
partitioning. Let's add boilerplate changes to set the control
configuration based on different control types.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
                * No change, it's new patch.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 6 ++++--
 drivers/platform/mpam/mpam_resctrl.c      | 9 ++++++---
 fs/resctrl/ctrlmondata.c                  | 3 ++-
 fs/resctrl/monitor.c                      | 3 ++-
 fs/resctrl/rdtgroup.c                     | 3 ++-
 include/linux/resctrl.h                   | 6 ++++--
 6 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b34e86cfc111..4423d8979b5e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -39,7 +39,8 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
 }
 
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
-			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val,
+			    enum resctrl_ctrl_type type)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
@@ -59,7 +60,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	return 0;
 }
 
-int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid,
+				enum resctrl_ctrl_type type)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 0de09e9deee5..7a797f9bcaed 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -920,7 +920,8 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 }
 
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
-			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val,
+			    enum resctrl_ctrl_type type)
 {
 	int err;
 	u32 partid;
@@ -983,7 +984,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 }
 
 /* TODO: this is IPI heavy */
-int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid,
+				enum resctrl_ctrl_type type)
 {
 	int err = 0;
 	struct rdt_domain *d;
@@ -1000,7 +1002,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				continue;
 
 			err = resctrl_arch_update_one(r, d, closid, t,
-						      cfg->new_ctrl);
+						      cfg->new_ctrl,
+						      type);
 			if (err)
 				return err;
 		}
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index f1f57bbfa094..005a91192847 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -405,7 +405,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			continue;
 
 		if (!strcmp(resname, s->name)) {
-			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
+			ret = resctrl_arch_update_domains(r, rdtgrp->closid,
+							  s->ctrl_type);
 			if (ret)
 				goto out;
 		}
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 6c0804273753..5eccb38cb7d7 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -514,7 +514,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		return;
 	}
 
-	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
+	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val,
+				SCHEMA_BASIC);
 
 	/*
 	 * Delta values are updated dynamically package wise for each
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 92d9bee210eb..d71fac0ae4d4 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3136,7 +3136,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 				return ret;
 		}
 
-		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r, rdtgrp->closid,
+						  s->ctrl_type);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2c0dc01d070e..f28d4ff737dc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -334,7 +334,8 @@ int resctrl_rdtgroup_show(struct seq_file *seq, u32 closid, u32 rmid);
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 
 struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
-int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid,
+				enum resctrl_ctrl_type type);
 
 /* For use by arch code that needs to remap resctrl's smaller CDP closid */
 static inline u32 resctrl_get_config_index(u32 closid,
@@ -374,7 +375,8 @@ resctrl_get_domain_from_cpu(int cpu, struct rdt_resource *r)
  * Must be called on one of the domain's CPUs.
  */
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
-			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val,
+			    enum resctrl_ctrl_type ctrl_type);
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type,
-- 
2.25.1


