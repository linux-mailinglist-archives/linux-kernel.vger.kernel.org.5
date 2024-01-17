Return-Path: <linux-kernel+bounces-29058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321908307C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7AF1F2202E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B32230D;
	Wed, 17 Jan 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fzYLqD2e"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8721A0C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500908; cv=none; b=XKNgi+8delOO0DUKY54Qhup9Ia7IpICZ/fFbNLH3aAuUR6bDzF/PoEaXzqc6nHUeT0TRUBzBQd3IVbydsZ18ZoYDqRk2GnedPD9nPjL1C2n9IdMZEHtYUhiQZYE7IxpXMD8NDjfGw0kkAAkbpZKfjyi8IElNndKU3SgM+9h8TOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500908; c=relaxed/simple;
	bh=9nleSWUzKD6TdJg/UJWhtcJTMDxZtwm01y3JBhz3QOM=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=YCPPbN1/seOFdMydehH8fLh0tSKkcnN63/WxWDz16XkcXzRe9lX3CFU1Y54poe6eZ75XPQdpK2HQsJETqdge42tes/RSV9N7W9BozbUiCrGXllIthojBlzyGr/pXwxRhf4r5+7+1o+1b2HoF00QD1ksBdZPUD+YJ+7gOzuBXtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fzYLqD2e; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jo69029521;
	Wed, 17 Jan 2024 06:14:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=0WIJ5Saq1p5+ZFQkIuWbmHjZZkw8Y3vMm4fuMdgzxlI=; b=fzY
	LqD2eeckn2TGAN+FrnWZWqW7SnFe6KexzmVa/MZ0cGQZKtT7yF8UIY62FmLQ3kKM
	GS88UryB4nUx2ZkDBDzZvs8RRX0c6D8Mv83IeebmOFRZzILTr1yVMJ5ImBuvDDlI
	y/AwwE+mBSDELApc7Z4ZBuF60o1NykgqJiOmO8mXnAZRhlHbk7nuSM3/g0IHyqpx
	yU5qpaFDba3aL8yNqTEqHBmkXTggThslQ4G8tRX66UlLruN/vt/yQOXYTLPzUAy7
	WGtdUELGvDG0HwKXthNBq30CtUQnDhQkeN+mfxtRbsKwv+WflO1A2E8IR1/wmzNL
	I8n1HebnHTwPSFPxDNQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask952w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:52 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:50 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 25DA35B6931;
	Wed, 17 Jan 2024 06:14:46 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 10/14] arm_mpam: resctrl: Facilitate writing downstream priority value
Date: Wed, 17 Jan 2024 19:44:01 +0530
Message-ID: <20240117141405.3063506-11-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: qrSVuiQUoMB2R6Cr5vwbsSEvLyZpLED2
X-Proofpoint-GUID: qrSVuiQUoMB2R6Cr5vwbsSEvLyZpLED2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

This change provides a way to write downstream priority value (passed from
schemata file) to arch specific resource control code. The priority value
is stored in mpam_config structure, and eventually gets programmed into
MPAMCFG_PRI register.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
                * Schemata write is based on Control type.
---
 drivers/platform/mpam/mpam_devices.c |  4 ----
 drivers/platform/mpam/mpam_resctrl.c | 26 ++++++++++++++++----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 589ff1ef2b6b..3ef9e5d70afc 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -2329,10 +2329,6 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 	lockdep_assert_cpus_held();
 
-	if (!memcmp(&comp->cfg[partid], cfg, sizeof(*cfg)))
-		return 0;
-
-	comp->cfg[partid] = *cfg;
 	arg.comp = comp;
 	arg.partid = partid;
 
diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 7a797f9bcaed..42602bffba3f 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -925,7 +925,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 {
 	int err;
 	u32 partid;
-	struct mpam_config cfg;
+	struct mpam_config *cfg;
 	struct mpam_props *cprops;
 	struct mpam_resctrl_res *res;
 	struct mpam_resctrl_dom *dom;
@@ -940,24 +940,30 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	cprops = &res->class->props;
 
 	partid = resctrl_get_config_index(closid, t);
+	cfg = &dom->comp->cfg[partid];
 	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r))
 		return -EINVAL;
 
 	switch (r->rid) {
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
+		if (type == SCHEMA_DSPRI) {
+			cfg->dspri = cfg_val;
+			mpam_set_feature(mpam_feat_dspri_part, cfg);
+		} else {
 		/* TODO: Scaling is not yet supported */
-		cfg.cpbm = cfg_val;
-		mpam_set_feature(mpam_feat_cpor_part, &cfg);
+			cfg->cpbm = cfg_val;
+			mpam_set_feature(mpam_feat_cpor_part, cfg);
+		}
 		break;
 	case RDT_RESOURCE_MBA:
 		if (mba_class_use_mbw_part(cprops)) {
-			cfg.mbw_pbm = percent_to_mbw_pbm(cfg_val, cprops);
-			mpam_set_feature(mpam_feat_mbw_part, &cfg);
+			cfg->mbw_pbm = percent_to_mbw_pbm(cfg_val, cprops);
+			mpam_set_feature(mpam_feat_mbw_part, cfg);
 			break;
 		} else if (mpam_has_feature(mpam_feat_mbw_max, cprops)) {
-			cfg.mbw_max = percent_to_mbw_max(cfg_val, cprops);
-			mpam_set_feature(mpam_feat_mbw_max, &cfg);
+			cfg->mbw_max = percent_to_mbw_max(cfg_val, cprops);
+			mpam_set_feature(mpam_feat_mbw_max, cfg);
 			break;
 		}
 		fallthrough;
@@ -971,15 +977,15 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	 */
 	if (mpam_resctrl_hide_cdp(r->rid)) {
 		partid = resctrl_get_config_index(closid, CDP_CODE);
-		err = mpam_apply_config(dom->comp, partid, &cfg);
+		err = mpam_apply_config(dom->comp, partid, cfg);
 		if (err)
 			return err;
 
 		partid = resctrl_get_config_index(closid, CDP_DATA);
-		return mpam_apply_config(dom->comp, partid, &cfg);
+		return mpam_apply_config(dom->comp, partid, cfg);
 
 	} else {
-		return mpam_apply_config(dom->comp, partid, &cfg);
+		return mpam_apply_config(dom->comp, partid, cfg);
 	}
 }
 
-- 
2.25.1


