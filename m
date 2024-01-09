Return-Path: <linux-kernel+bounces-21189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93176828B81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A628E1C24781
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531B3C47D;
	Tue,  9 Jan 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANGw3fPw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770643BB33;
	Tue,  9 Jan 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409FwJm5001291;
	Tue, 9 Jan 2024 17:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=x8mI8xVxho6usfeyYDPHPyWvfEXa6ZMB/rRz6yGDxGo
	=; b=ANGw3fPwyVpXG/i6Q8p0HDgX3a6gLfLI2wqJsYaBlrdfJNSIZlQWQOI89rn
	oi1dn4BDCCzNid9VfkrNF9rKSl15YqAls28i05si/WLEASzqHblyiOJ9Q5CAf35P
	n4K/OSQ5+6TsYbuXBeKRsL97k+YwOUqCGLvTfuCniD4YPaJ0QxcXUoKYNGL2mzmv
	T+4ccjVr++1pb1RLGB/OFBROW9PL/ZsO24UhA9JNU6Nqthe4KiLanAvowT3YLUAD
	nRNaJ4w8ZCR1Hn+35boY3kA3GWYlCsoP3toW7VJWS09SnEtnqtKqDoQF9lDgQJUQ
	oA7t9dwrITAiqNa3Kw85eFGvgfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh98m89j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 17:51:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Hp70N032037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 17:51:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 09:51:06 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 9 Jan 2024 09:51:03 -0800
Subject: [PATCH 1/3] wifi: ath12k: Remove unnecessary struct qmi_txn
 initializers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-qmi-cleanup-v1-1-607b10858566@quicinc.com>
References: <20240109-qmi-cleanup-v1-0-607b10858566@quicinc.com>
In-Reply-To: <20240109-qmi-cleanup-v1-0-607b10858566@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N2K5Q2q1DNfj2AmCnmjbHxgDb0IIDgL1
X-Proofpoint-GUID: N2K5Q2q1DNfj2AmCnmjbHxgDb0IIDgL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090144

Currently most of the ath12k QMI messaging functions define their
struct qmi_txn variables with a {} initializer. However, all of these
functions subsequently call qmi_txn_init(), and the very first thing
that function does is zero the struct. Hence, the initializers are
unnecessary. Since these consume code space and cpu cycles, remove
them.

No functional changes, compile tested only.
---
 drivers/net/wireless/ath/ath12k/qmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 536856234f3b..180e86c2a10c 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -1921,7 +1921,7 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_host_cap_req_msg_v01 req;
 	struct qmi_wlanfw_host_cap_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -2069,7 +2069,7 @@ static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_respond_mem_req_msg_v01 *req;
 	struct qmi_wlanfw_respond_mem_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0, i;
 	bool delayed;
 
@@ -2210,7 +2210,7 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_cap_req_msg_v01 req;
 	struct qmi_wlanfw_cap_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	unsigned int board_id = ATH12K_BOARD_ID_DEFAULT;
 	int ret = 0;
 	int r;
@@ -2311,7 +2311,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 {
 	struct qmi_wlanfw_bdf_download_req_msg_v01 *req;
 	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	const u8 *temp = data;
 	int ret;
 	u32 remaining = len;
@@ -2547,7 +2547,7 @@ static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 	struct qmi_wlanfw_m3_info_req_msg_v01 req;
 	struct qmi_wlanfw_m3_info_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -2598,7 +2598,7 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 {
 	struct qmi_wlanfw_wlan_mode_req_msg_v01 req;
 	struct qmi_wlanfw_wlan_mode_resp_msg_v01 resp;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -2651,7 +2651,7 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	struct qmi_wlanfw_wlan_cfg_resp_msg_v01 resp;
 	struct ce_pipe_config *ce_cfg;
 	struct service_to_pipe *svc_cfg;
-	struct qmi_txn txn = {};
+	struct qmi_txn txn;
 	int ret = 0, pipe_num;
 
 	ce_cfg	= (struct ce_pipe_config *)ab->qmi.ce_cfg.tgt_ce;

-- 
2.42.0


