Return-Path: <linux-kernel+bounces-29056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A2B8307BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4585F282D55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453321376;
	Wed, 17 Jan 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="feEuBCZA"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4D21111
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500899; cv=none; b=lzn2F2kbwMJDZ4j+UPFwXj2mDuz0thfLNJAWAgbslZp6QJoE0tGFfDO2QF6n7XF+W/ku/9Fu44vSUMGMmUDcpzCXWU/K1knpKoNIN6IuI5sZdQugi/stIkOOYKS0tw4J6rb2rUp7yA6K+lEgHIYz7H1b3gToyImv32H9+peGl80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500899; c=relaxed/simple;
	bh=PlxnDdzYWanafax0YDQ9BGwaZnEygVqcN/A54H59VCI=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=cGIX4vsOBTbzFbZe3zbG06Rq2Bj0OgU0yY91OYqh6jsnmtWZQcVd0zOulNkeCMboM8oZnF/91VXsTMAIPrWOUxPQlkPrWnC+vWvaYlb25dkI28BqUaJoR/tQTnZNxGaeusNSvURGoh5N4x3bdvkdQgJVosSRc58ncIojjw5u6mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=feEuBCZA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jROm028480;
	Wed, 17 Jan 2024 06:14:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=n7v/dHuitqVY/OrcrDypXnmmjVNc5dx4KrCK3+Y0P6k=; b=feE
	uBCZAe3zIlJLmpbclGDkkjXd/hqgoGufJ4bnnANMRw2ub6Kl+8aZNMSLcqAst6Tm
	pF2tq4onVhdNHiZ4/JizFDaThxU9D/QjgqsgymS5bPJfD6iHgzZ5p/7I23unlIoK
	F4lhuX+Un4Mo7oWF9kIRFZwqGSkwopm7B0ddZuVRYGXU2nGl16NMmpZpIZrgeQSg
	zBPxog54KtBAPTBYqwHXLO49+i01+jSoo+uJCMMnTC7xVQQHNkgAUi2PjA+9Gx9L
	G3oSOY5ffGNmxSt+UwfR+AsYS/hv1/SLvXG/vNaWKMjF0/hp2J2kt61mJZFMsSdx
	hQqGF9ohWBMlKtpWaRw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask951j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:32 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:31 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id D6EC75B6931;
	Wed, 17 Jan 2024 06:14:27 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 05/14] fs/resctrl: fetch configuration based on control type
Date: Wed, 17 Jan 2024 19:43:56 +0530
Message-ID: <20240117141405.3063506-6-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: 3S_HAtC8gmVQXzdJNFcbPofkXiDQLEf5
X-Proofpoint-GUID: 3S_HAtC8gmVQXzdJNFcbPofkXiDQLEf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Now that, we have support for different control types, divided into
the BASIC and PRIORITY controls types. Schemata list is pertained to
the SCHEMAT_BASIC control type that is used to set up/configure
CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation)
capabilities, and SCHEMAT_DSPRI used to configure downstream priority
partitioning. Let's add boilerplate changes to fetch the control
configuration based on different control types.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
                * No change, it's new patch.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 ++-
 drivers/platform/mpam/mpam_resctrl.c      |  3 ++-
 fs/resctrl/ctrlmondata.c                  |  6 ++++--
 fs/resctrl/monitor.c                      |  3 ++-
 fs/resctrl/rdtgroup.c                     | 19 +++++++++++++------
 include/linux/resctrl.h                   |  3 ++-
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0d10107eab62..b34e86cfc111 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -116,7 +116,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 }
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			    u32 closid, enum resctrl_conf_type type)
+			    u32 closid, enum resctrl_conf_type type,
+			    enum resctrl_conf_type ctrl_type)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = resctrl_get_config_index(closid, type);
diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 02efec42bbe2..4c44d65e6047 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -848,7 +848,8 @@ void mpam_resctrl_exit(void)
 }
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			    u32 closid, enum resctrl_conf_type type)
+			    u32 closid, enum resctrl_conf_type type,
+			    enum resctrl_ctrl_type ctrl_type)
 {
 	u32 partid;
 	struct mpam_config *cfg;
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 27d8bc25a4cb..451cbb7357fb 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -373,6 +373,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
+	enum resctrl_ctrl_type ctrl_type = schema->ctrl_type;
 	struct rdt_resource *r = schema->res;
 	struct rdt_domain *dom;
 	bool sep = false;
@@ -390,9 +391,10 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = dom->mbps_val[closid];
 		else
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
-							   schema->conf_type);
+							   schema->conf_type,
+							   ctrl_type);
 
-		seq_printf(s, r->format_str, dom->id, max_data_width,
+		seq_printf(s, r->format_str, dom->id, schema->max_data_width,
 			   ctrl_val);
 		sep = true;
 	}
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 885b0ca177b0..6c0804273753 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -478,7 +478,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	delta_bw = pmbm_data->delta_bw;
 
 	/* MBA resource doesn't support CDP */
-	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
+	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE,
+					      SCHEMA_BASIC);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d57eb2c7afa7..92d9bee210eb 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1064,7 +1064,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			if (!closid_allocated(i))
 				continue;
 			ctrl_val = resctrl_arch_get_config(r, dom, i,
-							   s->conf_type);
+							   s->conf_type,
+							   s->ctrl_type);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
@@ -1281,7 +1282,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 	/* Check for overlap with other resource groups */
 	for (i = 0; i < closids_supported(); i++) {
-		ctrl_b = resctrl_arch_get_config(r, d, i, type);
+		ctrl_b = resctrl_arch_get_config(r, d, i, type, SCHEMA_BASIC);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1365,7 +1366,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
 			ctrl = resctrl_arch_get_config(r, d, closid,
-						       s->conf_type);
+						       s->conf_type,
+						       s->ctrl_type);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1499,6 +1501,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct resctrl_schema *schema;
+	enum resctrl_ctrl_type ctrl_type;
 	enum resctrl_conf_type type;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -1536,6 +1539,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	list_for_each_entry(schema, &resctrl_schema_all, list) {
 		r = schema->res;
 		type = schema->conf_type;
+		ctrl_type = schema->ctrl_type;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -1549,7 +1553,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 				else
 					ctrl = resctrl_arch_get_config(r, d,
 								       closid,
-								       type);
+								       type,
+								       ctrl_type);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -3013,11 +3018,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 */
 			if (resctrl_arch_get_cdp_enabled(r->rid))
 				peer_ctl = resctrl_arch_get_config(r, d, i,
-								   peer_type);
+								   peer_type,
+								   s->ctrl_type);
 			else
 				peer_ctl = 0;
 			ctrl_val = resctrl_arch_get_config(r, d, i,
-							   s->conf_type);
+							   s->conf_type,
+							   s->ctrl_type);
 			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
 				cfg->new_ctrl |= ctrl_val | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 93b3e3b21d5d..2c0dc01d070e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -377,7 +377,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			    u32 closid, enum resctrl_conf_type type);
+			    u32 closid, enum resctrl_conf_type type,
+			    enum resctrl_ctrl_type ctrl_type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 int resctrl_online_cpu(unsigned int cpu);
-- 
2.25.1


