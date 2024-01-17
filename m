Return-Path: <linux-kernel+bounces-29065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909648307CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347D2B24F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401020DC7;
	Wed, 17 Jan 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kdHSy9Px"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7820B1E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500925; cv=none; b=HCHdBm7kRzHHA2vqynzgoyg63s5WOJMMkd2w2IFPTzTS+l2PtQKlweOD06ExdB12pExLHvq/QYrzl1fArewf06BJ/esedJ7aeXtly3owqeiQdpvaNQFvGLlw69lRmG0DMXK1enE/Zvbz2C+xmNS9m1Ejl7/VvT2NveeVKDck//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500925; c=relaxed/simple;
	bh=Imf7O7zcNOVCd81mclixADJXwQRt2xYwWPLl/E/y0Hc=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version; b=XAj2sM4h2BGKQa1K4iyMusOOPaYT3VBJMxxbhZgUFw2vRKPyudMPKICbiwV30TNMxi7e+1NxKUS7fWf5qc7PHz6IQbGT2v/RZz7KBej3BS3xwF+pTamYWG7fRv3YDRX/xxNdE3s45Z7TABG6rnZMpID8vwC/DSkNbdk36sGtsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kdHSy9Px; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8Ydfc012684;
	Wed, 17 Jan 2024 06:15:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=AyLoq4qCvNRklZsb/iMNJS5tPScAkgwgIIVRtypuMfA=; b=kdH
	Sy9Px9R7Tvl0q0/LYGJ+MZyus/ZDTBeBOZy34UQ9y2H9pwUcWnTzOS7W3NwtO/sM
	y8eVeyPel4oTGTL0sIugJbEAbmjOE73fmhn62MPlfZR7mqnN/LrI9CyaqJMyCgtb
	+PrqOmXTw0FUTqXeHlmXsFO9sS1VuIQZGohS8AYJXa0Srvi6bke3M8czpke7q/q1
	oa+QtSyI6pvH0UsI6lfC/v9rcw2Ggp2PdRlGBoQeFPckXoi8uGsZLS0I9a8FRI8k
	wiqHsjKFL8kGXDbabTOG0ZjMhmlolBwO4WM4HBgFmvrYh8ds2yponi2/E3uay9UJ
	u6Z2Sc138bK8bCvMTRA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vp0ge393y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:15:00 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:58 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id D7A7D5B6931;
	Wed, 17 Jan 2024 06:14:54 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 12/14] arm_mpam: Program Downstream priority value
Date: Wed, 17 Jan 2024 19:44:03 +0530
Message-ID: <20240117141405.3063506-13-amitsinght@marvell.com>
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
X-Proofpoint-GUID: zpp2hqTM8jJAkQKnD65_Nno9V8gilWRY
X-Proofpoint-ORIG-GUID: zpp2hqTM8jJAkQKnD65_Nno9V8gilWRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Now that Downstream priorities values can be passed from resource control
schemata file, let's program it into memory mapped Priority Partition
Configuration Register.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
		* Priority value is inverted based on DSPRI_0_IS_LOW value.
---
 drivers/platform/mpam/mpam_devices.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 9953f2050d35..388d57281fd8 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -1101,6 +1101,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	struct mpam_props *rprops = &ris->props;
 	u16 dspri = GENMASK((rprops->dspri_wd - 1), 0);
 	u16 intpri = GENMASK((rprops->intpri_wd - 1), 0);
+	u8 dspri_part_0_low, dspri_rprops, dspri_cfg;
 
 	lockdep_assert_held(&msc->lock);
 
@@ -1143,18 +1144,33 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	if (mpam_has_feature(mpam_feat_ccap_part, rprops))
 		mpam_write_partsel_reg(msc, CMAX, cmax);
 
-	if (mpam_has_feature(mpam_feat_intpri_part, rprops) ||
-	    mpam_has_feature(mpam_feat_dspri_part, rprops)) {
+	if (mpam_has_feature(mpam_feat_intpri_part, rprops)) {
 		/* aces high? */
 		if (!mpam_has_feature(mpam_feat_intpri_part_0_low, rprops))
 			intpri = 0;
-		if (!mpam_has_feature(mpam_feat_dspri_part_0_low, rprops))
-			dspri = 0;
 
 		if (mpam_has_feature(mpam_feat_intpri_part, rprops))
 			pri_val |= FIELD_PREP(MPAMCFG_PRI_INTPRI, intpri);
-		if (mpam_has_feature(mpam_feat_dspri_part, rprops))
-			pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
+
+		mpam_write_partsel_reg(msc, PRI, pri_val);
+	}
+
+	dspri_rprops = mpam_has_feature(mpam_feat_dspri_part,
+					rprops);
+	dspri_part_0_low = mpam_has_feature(mpam_feat_dspri_part_0_low,
+						rprops);
+	if (dspri_rprops) {
+		dspri_cfg = mpam_has_feature(mpam_feat_dspri_part,
+						cfg);
+		if (dspri_cfg) {
+			pri_val |= (!dspri_part_0_low)
+			? FIELD_PREP(MPAMCFG_PRI_DSPRI, cfg->dspri ^ dspri)
+			: FIELD_PREP(MPAMCFG_PRI_DSPRI, cfg->dspri & dspri);
+		} else {
+			pri_val |= (!dspri_part_0_low)
+			? FIELD_PREP(MPAMCFG_PRI_DSPRI, 0)
+			: FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
+		}
 
 		mpam_write_partsel_reg(msc, PRI, pri_val);
 	}
-- 
2.25.1


