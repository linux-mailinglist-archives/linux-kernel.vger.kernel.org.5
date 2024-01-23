Return-Path: <linux-kernel+bounces-34817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9318387DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19792884C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F0524AB;
	Tue, 23 Jan 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SVZ3ZYTd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FB3E491;
	Tue, 23 Jan 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994311; cv=none; b=hbUTV+ZLLAVWDnJXfbqgP5cFUln2eGhrZATpTko+4Y+trAHcW8eFs3fH32z+MZEwEbMrJxfXPOBS/SH/GRlzfgHuhLg66a+shDfeq736OYUCYkHoKJm7RknGXnKqfRxqnfFf+NPD/dBZP5sa/jfV07CX1IiSRZFawSSRl77qjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994311; c=relaxed/simple;
	bh=85mfHoW/rpawyiBkjKN3SkUwp+RWW6vEkwPKJakzIr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sxRVVd0hsNVXzguj+uQL+wt8p+UhfJdR2QU14KBl9THgiQTI5cM8VDMB2nJJVgzrizRgWvB3pc/zYrZBTtEGS6Ry0/az05+E4iWrVeGEYrEZXyo5e1j4AIQI0oRB+3qbr6fKmldB6ySw4z12jWTtvU4DWh+LSP6id3xJl3CThH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SVZ3ZYTd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N6EuV2029783;
	Tue, 23 Jan 2024 07:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=4eLFyPK9hzslnCNNM7uWyoY3CKCizhvtb8xZHpfVf3k=; b=SV
	Z3ZYTdzkr0Ym4iQJun+TTqp1q52tYcQKinWL6aEuTlkrK5zIuUeYzWkr9spHsxiA
	yOsjHgU7Y/zv5A2RkYjHG/mTty+qWKr/4UjbpjibtOz456HMXitMg4ZZB5Sg6XFq
	PeeNcTP+IK5ymuEqgtzoKdrcC8MzEvg61WXt/V6km/oVYDEi3lp+6Vr8DgHHSJLq
	3y5kl5cdCHuTsp1qYCQWAKa7X+hSnoaSUe/ijMpZLci+O2HN2DYCUTujWoYM5P5Y
	tH9lHFLSNQxkrWSwCG3s0DqInV5jTTCx+Yhjvut4DZGHt5PQQPKSmoGlqtc/LLBA
	NfZfkPZZ8G5dteyeKdDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt814041p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 07:18:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N7IP0C028492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 07:18:25 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 23:18:22 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT
Date: Tue, 23 Jan 2024 12:45:23 +0530
Message-ID: <20240123071523.23480-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: llPOI5ZAVD-91kHl2X9ijivwXz0qFwBT
X-Proofpoint-ORIG-GUID: llPOI5ZAVD-91kHl2X9ijivwXz0qFwBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=707 clxscore=1011 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230052

This change is done to avoid BT not to go UNCONFIGURED state when BDA
fwnode is not available in DT for QTI SOCs.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 94b8c406f0c0..11d66f3e5f3f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -7,6 +7,7 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
+ *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -1904,7 +1905,17 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+		/* Set BDA quirk bit for reading BDA value from fwnode property
+		 * only if that property exist in DT.
+		 */
+		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
+			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
+		} else {
+			bt_dev_info(hdev, "Not setting quirk bit for BDA");
+		}
+
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
prerequisite-patch-id: de5460a6c886a233feff19313b545ee6569369fb
prerequisite-patch-id: e18252a26d0f289afcbec18113b7f636a46a9aed
prerequisite-patch-id: 26e607ac96dc6d0d295793a0449a5b4c0f7ddc92
prerequisite-patch-id: c8d7f229399fc8075722ffe05260675ece93f691
prerequisite-patch-id: 554cc93ba4899eabe31585bf9591052058609d96
prerequisite-patch-id: 99c00a3d8d98a880c0d3a5545def0ca9ade0f903
prerequisite-patch-id: b1ef1add471677d1e1b60eaaab3e109abf7c7b2b
prerequisite-patch-id: 96131754c09914f327f353dee4daabb7ab5e6f29
prerequisite-patch-id: 610b5ec4a338d15cf8dba0459d5a1bfd28dccb4d
prerequisite-patch-id: 5172cd9d99462e123f264f0fd9a9768f2cae5498
prerequisite-patch-id: f57b8285516730da78089325d53f6125daaf2e6a
prerequisite-patch-id: 69dc26e36476660935070261f0e11cdd55c35688
prerequisite-patch-id: 8087dd28f6ef90fc3ad847b4bcde8a096ff721b5
prerequisite-patch-id: 8640fbfd7e5dcbdb4eacf5b748ea49678a2e6675
prerequisite-patch-id: b3613c0002cfd9cc77923f6ce781cec90a2f0cd1
prerequisite-patch-id: dc4f4077bfa02a5d5128bb39ef3a36dfc3db27bc
prerequisite-patch-id: 9c9aa8de9b4c50252d451a2dd76717c287fe1848
prerequisite-patch-id: 3c4a931debe7e8aa7d0b70870456421a17ff86a5
prerequisite-patch-id: df500031c7b6de9320021d52b060338b71340d91
prerequisite-patch-id: 14758d2fb4b6151aa9c27ab7e3cb8c742988f1d7
prerequisite-patch-id: 1c28faa0d8a4e294752229611ade87a216da0ce6
prerequisite-patch-id: 03680549373d9a5b0ab0e4c94260e8aaea04ef25
prerequisite-patch-id: cfcc27083466c9c87801628fe9c0f2131fc22dae
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


