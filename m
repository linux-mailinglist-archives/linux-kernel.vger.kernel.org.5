Return-Path: <linux-kernel+bounces-29055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2018307BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B71C1F2533E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB22111D;
	Wed, 17 Jan 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eot7qCge"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D82110E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500898; cv=none; b=oiEm25fKBswhHAYKL05fcwvjcK4rpx0ZniyJGWDmtsa+UxFXPGwtJBHi+jnygdnXjKH2lX0ME2Xokauo56d8IWihq1MiEQcQmxgdHoMgYBNc40fV2QfocUb8BANNtN0Co3f5gGb0Iu9UcFHg57OsM47s7P1VBsmHXFUq7LK5Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500898; c=relaxed/simple;
	bh=HNvW3WKsIlxMJniVquCnypLBT+tR+7lOcEkV6NGM0lY=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version; b=ozFg6swkO1RnhIOjJGlyOpyepTIF08jSwG2Af0qlmMdGcW9xvIhtaMAFNMhPYRf89ehOftiwhBkKJK4EXvc/CIwpew+UaTDk3OczDUk9Y3Qd9rbmsesRbcXz9/vawpHo00OR/ezS++mE6rYO1cnzLsmpbSR7iyLbAtLlZeUu304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eot7qCge; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7jhMO028705;
	Wed, 17 Jan 2024 06:14:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=1GHNM7+8NlxPbSSdFb5vYISuQDRZWQGahxCDaGr7f4Y=; b=eot
	7qCgeBIML4qezMB3bQ7MNs3dEL7TCEDzVb/nfkrQwGw9JGYrT9FgWJBkFRahG5J4
	dpOIRbWIv/cFReS4nhTURSIG5Ax1/tJFqTC1mgkbhh+Odkl7NnnPuDA1SxR2JrPX
	v2UgxMtBQjQu/xo0zYSV37ueaS0N3GDUZ4QZs8pcc4dVQrM/KMbthp3UVYAFr9MB
	Me8d44s+VxP4Q+ZQvOy5cgJ+YHBPKaF0AKjA5K1819PVSBlqhhivHT5Sf11M/AyD
	KFZus3gENc52epW65Huiu2vxH9rdc67Yu4i06dwRTdES9j2IXYvAiaYwC4xCATno
	0n7m+Y9Rryy7LjDgb9A==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vpask951u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:36 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:35 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id B26705B6932;
	Wed, 17 Jan 2024 06:14:31 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 06/14] arm_mpam: resctrl: Retrieve priority values from arch code
Date: Wed, 17 Jan 2024 19:43:57 +0530
Message-ID: <20240117141405.3063506-7-amitsinght@marvell.com>
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
X-Proofpoint-ORIG-GUID: R37DkmxraFyJkxBGo5nvB__FmHpVufj_
X-Proofpoint-GUID: R37DkmxraFyJkxBGo5nvB__FmHpVufj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Downstream priority values can be read from the "schemata" file, which is
fetched from mpam_config structure.

This change does the necessary modifications in arch specific code to
facilitate reading priority values.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
                * Reworked, To configure DSPRI partition control use
                  control type instead of dspri_show/store flags.
---
 drivers/platform/mpam/mpam_internal.h |  1 +
 drivers/platform/mpam/mpam_resctrl.c  | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/mpam/mpam_internal.h b/drivers/platform/mpam/mpam_internal.h
index 30e32389d394..45552ae6548b 100644
--- a/drivers/platform/mpam/mpam_internal.h
+++ b/drivers/platform/mpam/mpam_internal.h
@@ -160,6 +160,7 @@ struct mpam_config {
 	u32	cpbm;
 	u32	mbw_pbm;
 	u16	mbw_max;
+	u16	dspri;
 };
 
 struct mpam_component
diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 4c44d65e6047..0de09e9deee5 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -860,8 +860,12 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 
 	lockdep_assert_cpus_held();
 
-	if (!mpam_is_enabled())
-		return r->default_ctrl;
+	if (!mpam_is_enabled()) {
+		if (ctrl_type == SCHEMA_DSPRI)
+			return r->default_dspri_ctrl;
+		else
+			return r->default_ctrl;
+	}
 
 	res = container_of(r, struct mpam_resctrl_res, resctrl_res);
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_dom);
@@ -873,7 +877,10 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	switch (r->rid) {
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
-		configured_by = mpam_feat_cpor_part;
+		if (ctrl_type == SCHEMA_DSPRI)
+			configured_by = mpam_feat_dspri_part;
+		else
+			configured_by = mpam_feat_cpor_part;
 		break;
 	case RDT_RESOURCE_MBA:
 		if (mba_class_use_mbw_part(cprops)) {
@@ -889,13 +896,19 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	}
 
 	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r) ||
-	    !mpam_has_feature(configured_by, cfg))
-		return r->default_ctrl;
+	    !mpam_has_feature(configured_by, cfg)) {
+		if (ctrl_type == SCHEMA_DSPRI)
+			return r->default_dspri_ctrl;
+		else
+			return r->default_ctrl;
+	}
 
 	switch (configured_by) {
 	case mpam_feat_cpor_part:
 		/* TODO: Scaling is not yet supported */
 		return cfg->cpbm;
+	case mpam_feat_dspri_part:
+		return cfg->dspri;
 	case mpam_feat_mbw_part:
 		/* TODO: Scaling is not yet supported */
 		return mbw_pbm_to_percent(cfg->mbw_pbm, cprops);
-- 
2.25.1


