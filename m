Return-Path: <linux-kernel+bounces-29064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF978307CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E0D1C224F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B720B37;
	Wed, 17 Jan 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dqopITq0"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3120B0D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500924; cv=none; b=HKs6jFN8Hf12z5hB2OhF0/Z0GuZe1YnfAJmI9x4y8+hUIoCJWJr2xmMj2PVb3/0e0JFZMpe1Z/8Kw8fSqNIEVUHqbUtrZyYFIBBNdCsf2Uz8ZbhsuYNxLCMGH5ulf7dAuT59n21aN+cOZQ38KGZOvVdLf0Rpq+VeM57c27qjVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500924; c=relaxed/simple;
	bh=ZoARrx+gHm4/p7Lyn4Uzr529OkYrUKtuOYv73qnkK1Y=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=DdJUrYMgTNxCjyIRmIxBzj6MmUFGQLD3zlDEw/yujCj5osbvhNg2A+2yN2HsYkp4pZHWQx4FcY9fRHTx6aPfofXb5obQLuw1jzp+ippk+xHjDhHecai34TtnifXF4OHZSt0RaAIy/FxtZ7HDcviM5lvcWYZbkdA87tuvpEMgokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dqopITq0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jo6D029521;
	Wed, 17 Jan 2024 06:15:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=e2FEk6dn1f45GCWDdcLSp1yy8Sk+sRaao8A7hXcl/EU=; b=dqo
	pITq0ZvmdXV5iNtzQ66DUxRchrnsJZFhGD4BmR87AbU3gTZxwCAq7biLjsZaZQCc
	SybPqJVr87HQcOYnW97z4l+YQevdBP+9ACFTM3GJu5FiqiVv02HoEJvBDvp/jD78
	XlZZyXMauL5zW4CfAW4doaRmlvT+SJgrSJaBdHQFgZg0UApPqNu97hdn2A36MFgx
	qKRvpcMYGjWsEXBE9HPe7hsqcKDrCqAnDtHRc3HwjW6OFT2rJ3AF/ezFV8qlGgnP
	Qp6rq4Ti6FDX4fZNxHVBZDybn3w+X0MP2UxBALcw8p/4pttn233TBM5TfoBoZzYK
	c5+5lwPLy7lMfBmUFrw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask953n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:15:04 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:15:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:15:02 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id B0AA05B694B;
	Wed, 17 Jan 2024 06:14:58 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 13/14] arm_mpam: Handle resource instances mapped to different controls
Date: Wed, 17 Jan 2024 19:44:04 +0530
Message-ID: <20240117141405.3063506-14-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: 7DY7CrDzFhuxEwNa6eWmX5ZR2SQcd4hT
X-Proofpoint-GUID: 7DY7CrDzFhuxEwNa6eWmX5ZR2SQcd4hT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

At the moment, configuring multiple resource instances (mapped to same
control) under a resource class is not supported. For instance, on MARVELL
SoC MPAMF_IDR_NS[RIS_MAX] (under LLC MSC) is 0x2, and there are three
different resource at index 0,1,2. These are enumerated in
TAD_CMN_MPAM_RIS_E:

0: MSC
1: LTG
2: DTG

LLC MSC resource at index 0 has the Priority partitioning features.
If MPAMCFG_PART_SEL_NS[RIS] is set to 0 (MSC), then MPAMF_IDR_NS[HAS_PRI_PART]
is set to 1, leaving HAS_CPOR_PART bit to 0. CPOR and PRI_PART are
mutually exclusive resources as far configuration is concerned.

With this change, multiple resource instances that maps to different
control, say LTG for CPOR, and MSC for PRI_PART is handled properly.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
	* Trimmed down the commit message.
	* Tried to handle the corner case as suggested by Jonathan
	  by calling the __resource_props_mismatch even when different
	  controls are enumerated at different RIS index.
---
 drivers/platform/mpam/mpam_devices.c | 36 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 388d57281fd8..df7ac2c8bcb3 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -1788,11 +1788,15 @@ __resource_props_mismatch(struct mpam_msc_ris *ris, struct mpam_class *class)
 
 	lockdep_assert_held(&mpam_list_lock); /* we modify class */
 
-	/* Clear missing features */
-	cprops->features &= rprops->features;
+	/* Clear missing features, we don't want to clear features,
+	 * when different controls are implemented at different RIS
+	 * index.
+	 */
+	if (class->props.features == ris->props.features)
+		cprops->features &= rprops->features;
 
 	/* Clear incompatible features */
-	if (cprops->cpbm_wd != rprops->cpbm_wd)
+	if (cprops->cpbm_wd != rprops->cpbm_wd && rprops->cpbm_wd)
 		mpam_clear_feature(mpam_feat_cpor_part, &cprops->features);
 	if (cprops->mbw_pbm_bits != rprops->mbw_pbm_bits)
 		mpam_clear_feature(mpam_feat_mbw_part, &cprops->features);
@@ -1802,14 +1806,14 @@ __resource_props_mismatch(struct mpam_msc_ris *ris, struct mpam_class *class)
 		cprops->bwa_wd = min(cprops->bwa_wd, rprops->bwa_wd);
 
 	/* For num properties, take the minimum */
-	if (cprops->num_csu_mon != rprops->num_csu_mon)
+	if (cprops->num_csu_mon != rprops->num_csu_mon && rprops->num_csu_mon)
 		cprops->num_csu_mon = min(cprops->num_csu_mon, rprops->num_csu_mon);
 	if (cprops->num_mbwu_mon != rprops->num_mbwu_mon)
 		cprops->num_mbwu_mon = min(cprops->num_mbwu_mon, rprops->num_mbwu_mon);
 
 	if (cprops->intpri_wd != rprops->intpri_wd)
 		cprops->intpri_wd = min(cprops->intpri_wd, rprops->intpri_wd);
-	if (cprops->dspri_wd != rprops->dspri_wd)
+	if (cprops->dspri_wd != rprops->dspri_wd && rprops->dspri_wd)
 		cprops->dspri_wd = min(cprops->dspri_wd, rprops->dspri_wd);
 
 	/* {int,ds}pri may not have differing 0-low behaviour */
@@ -1845,6 +1849,20 @@ static void mpam_enable_init_class_features(struct mpam_class *class)
 	class->props = ris->props;
 }
 
+/* Club different resource properties under a class that resctrl uses,
+ * for instance, L3 cache that supports both CPOR, and DSPRI need to have
+ * knowledge of both cpbm_wd and dspri_wd. This is needed when two controls
+ * are enumerated under differnt RIS Index.
+ */
+static void mpam_enable_club_class_features(struct mpam_class *class,
+					    struct mpam_msc_ris *ris)
+{
+	class->props.features |= ris->props.features;
+	class->props.cpbm_wd |= ris->props.cpbm_wd;
+	class->props.dspri_wd |= ris->props.dspri_wd;
+	class->props.num_csu_mon |= ris->props.num_csu_mon;
+}
+
 /* Merge all the common resource features into class. */
 static void mpam_enable_merge_features(void)
 {
@@ -1860,6 +1878,14 @@ static void mpam_enable_merge_features(void)
 		list_for_each_entry(comp, &class->components, class_list) {
 			list_for_each_entry(ris, &comp->ris, comp_list) {
 				__resource_props_mismatch(ris, class);
+				/*
+				 * There can be multiple resources under a class which is
+				 * mapped to different controls, For instance L3 cache
+				 * can have both CPOR and DSPRI implemented with different
+				 * RIS.
+				 */
+				if (class->props.features != ris->props.features)
+					mpam_enable_club_class_features(class, ris);
 
 				class->nrdy_usec = max(class->nrdy_usec,
 						     ris->msc->nrdy_usec);
-- 
2.25.1


