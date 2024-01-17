Return-Path: <linux-kernel+bounces-29062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE878307C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424501C223A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375762032A;
	Wed, 17 Jan 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y4qAhAMP"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20713224DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500913; cv=none; b=eGjWaz/eR2eGbkFUI5e4wU5pLSB8MpTqez6J4mjMU7BwMiFptSPgRbHbdmovHW0JST/8cyBDDN/BWObUp105Ft4fo4o9vQCdtzFwKCss8xkIsBlgMXsajbZQ6cBJktrrDo6xEdpSJ7CssqH3903TM1mMSPvXRFm1R3RxMPJn5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500913; c=relaxed/simple;
	bh=XqpEiXH77fKWUiq0SUEclrUDkD2zv5jXOhPfycIhMOA=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=EYC0GBlu6Ww9qsc0nnuMElg72X04sozP4znwkq/mb2vyp+AyQrVTkmgAXMDUSI6vt1MUyNntmh0UCdo3uTGInzzkyuAJG6b5TBGGO9FmrXJw+TZ+t2YKyfdpIdpShihPtwTR8hISKssCCDffd9NjmZxg1cB+apI+R4R0yXGaL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y4qAhAMP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jROl028480;
	Wed, 17 Jan 2024 06:14:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=rTHrkWdzMVpRooEbJUcNk7UPFjuqmUJZpANqwMplbL0=; b=Y4q
	AhAMPXhv3tDDDIogb5f0ehr8BUhpggzdQeB8fjlTleGmzvQDCyresuYYawHZw8yd
	Rvvl6Lc8yB1Zqh27ss1dGGVoUCPhHetcMgaLdhHjdiw16MojgBtwwR1XUHUqNixT
	uNl8vep6Ezi0ye/T7/ExFXE9lR+e2E7nR1RolnX/KyCWqrN1Bp6gcYpWLHo/PVS5
	1SRxqbWrhDbQiSXzcJpuQHUgTQqWhBNs+GM9wq7b1SuZcaCuo5lX88yin5+E6KHH
	Hkp/06V3r3y22V1b+Td7uVzM72KPgkzmL2Up00K0OlH8CmWdrBJ+HXaaYAeR+kL0
	kbX478OphYkh9Bf0Y5w==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask950r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:21 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:19 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 542765B6949;
	Wed, 17 Jan 2024 06:14:16 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 02/14] arm_mpam: resctrl: Detect priority partitioning capability
Date: Wed, 17 Jan 2024 19:43:53 +0530
Message-ID: <20240117141405.3063506-3-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: VcNmQzlMrK097VLHZ7DMYhHno_UZvD3W
X-Proofpoint-GUID: VcNmQzlMrK097VLHZ7DMYhHno_UZvD3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

ARM MPAM supports different control that can be applied to different
resources in the system, for instance priority partitioning control
where priority value is generated from one MSC, propagates over
interconnect to other MSC (known as downstream priority), or can be
applied within an MSC for internal operations.

This change lets the resctrl know the about MSC's priority partitioning
capability.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* No change.
---
 drivers/platform/mpam/mpam_resctrl.c | 14 ++++++++++++++
 include/linux/resctrl.h              |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 1dbfb6f6dd34..09618d9ceb1d 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -435,6 +435,16 @@ static bool cache_has_usable_cpor(struct mpam_class *class)
 	return (class->props.cpbm_wd <= RESCTRL_MAX_CBM);
 }
 
+static bool cache_has_usable_priority_part(struct mpam_class *class)
+{
+	struct mpam_props *cprops = &class->props;
+
+	if (!mpam_has_feature(mpam_feat_dspri_part, cprops))
+		return false;
+
+	return (class->props.dspri_wd <= RESCTRL_MAX_DSPRI);
+}
+
 static bool cache_has_usable_csu(struct mpam_class *class)
 {
 	struct mpam_props *cprops;
@@ -691,6 +701,7 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 	    res->resctrl_res.rid == RDT_RESOURCE_L3) {
 		bool has_csu = cache_has_usable_csu(class);
 		bool has_mbwu = class_has_usable_mbwu(class);
+		bool has_ppart = cache_has_usable_priority_part(class);
 
 		/* TODO: Scaling is not yet supported */
 		r->cache.cbm_len = class->props.cpbm_wd;
@@ -718,6 +729,9 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 			exposed_alloc_capable = true;
 		}
 
+		if (has_ppart)
+			r->priority_cap = true;
+
 		/*
 		 * MBWU counters may be 'local' or 'total' depending on where
 		 * they are in the topology. If The counter is on the L3, its
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 125c4b0c2ff7..d49aed80a05e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -38,6 +38,8 @@ int proc_resctrl_show(struct seq_file *m,
  */
 #define RESCTRL_MAX_CBM			32
 
+#define RESCTRL_MAX_DSPRI               63
+
 /* The format for packing fields into the u64 'id' exposed to user-space */
 #define RESCTRL_ID_CLOSID	GENMASK_ULL(31, 0)
 #define RESCTRL_ID_RMID		GENMASK_ULL(63, 32)
@@ -195,6 +197,7 @@ struct resctrl_membw {
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
+ * @priority_capable:   Is priority partitioning feature available on this machine
  * @num_rmid:		Number of RMIDs available
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
@@ -212,6 +215,7 @@ struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
+	bool                    priority_cap;
 	int			num_rmid;
 	int			cache_level;
 	struct resctrl_cache	cache;
-- 
2.25.1


