Return-Path: <linux-kernel+bounces-23958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88982B47B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A513A1F26DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4B53E10;
	Thu, 11 Jan 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YJltR07/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586251C53;
	Thu, 11 Jan 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BHw8hk019164;
	Thu, 11 Jan 2024 18:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=uHlh8/WPYEz50ylDKG1fngiZKs9h0EptbdHAyeorwuU
	=; b=YJltR07/eBESka0vrwDGdS4E01/h6rFDoDI+iT/kkAYxip5B9OfRauCxWU3
	fK1rGy34H4fmZV3xmDcqSFaU+naXs6RJayjL8sRgSqOT5T9Iwb46ERj5Uw9kPKH+
	QKDoYRAIGQacMTFicEX5Ja2EJUgX13y74B3LxC/SmgazQmPiNztp4WRjsRSy3EKw
	RXdYTQJbrEgjnNVJVpXqiwhkWfLIlD5unQF1lw7UAjheqo0o/07GJZs43hqGwTgi
	JVqi1nw8VwH39/czccqQPqilqbuYamlVtMv8jKPrTwhmvL7PWODrtBuAf/mdUiOK
	INuGuEnyTTOAK44VTqvpmlniLSQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcmu9b8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:05:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BI5hor007455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:05:43 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 10:05:42 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 11 Jan 2024 10:05:32 -0800
Subject: [PATCH v2 3/3] wifi: ath12k: Use initializers for QMI message
 buffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-qmi-cleanup-v2-3-53343af953d5@quicinc.com>
References: <20240111-qmi-cleanup-v2-0-53343af953d5@quicinc.com>
In-Reply-To: <20240111-qmi-cleanup-v2-0-53343af953d5@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vw3hv8y6H0-pB6PLQSi6skjk3bRHSAh3
X-Proofpoint-ORIG-GUID: vw3hv8y6H0-pB6PLQSi6skjk3bRHSAh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110142

Currently most of the QMI messaging functions use memset() to zero out
the QMI message buffers. Prefer to use a {} initializer to allow the
compiler to generate optimized code and avoid the function call
overhead.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 40 ++++++++++-------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 1f2df2e3fbce..c4c7f31a91cd 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1919,14 +1919,11 @@ static void ath12k_host_cap_parse_mlo(struct qmi_wlanfw_host_cap_req_msg_v01 *re
 
 static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 {
-	struct qmi_wlanfw_host_cap_req_msg_v01 req;
-	struct qmi_wlanfw_host_cap_resp_msg_v01 resp;
+	struct qmi_wlanfw_host_cap_req_msg_v01 req = {};
+	struct qmi_wlanfw_host_cap_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	int ret = 0;
 
-	memset(&req, 0, sizeof(req));
-	memset(&resp, 0, sizeof(resp));
-
 	req.num_clients_valid = 1;
 	req.num_clients = 1;
 	req.mem_cfg_mode = ab->qmi.target_mem_mode;
@@ -2070,7 +2067,7 @@ static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_respond_mem_req_msg_v01 *req;
-	struct qmi_wlanfw_respond_mem_resp_msg_v01 resp;
+	struct qmi_wlanfw_respond_mem_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	int ret = 0, i;
 	bool delayed;
@@ -2079,8 +2076,6 @@ static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	if (!req)
 		return -ENOMEM;
 
-	memset(&resp, 0, sizeof(resp));
-
 	/* Some targets by default request a block of big contiguous
 	 * DMA memory, it's hard to allocate from kernel. So host returns
 	 * failure to firmware and firmware then request multiple blocks of
@@ -2090,7 +2085,6 @@ static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 		delayed = true;
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi delays mem_request %d\n",
 			   ab->qmi.mem_seg_count);
-		memset(req, 0, sizeof(*req));
 	} else {
 		delayed = false;
 		req->mem_seg_len = ab->qmi.mem_seg_count;
@@ -2211,17 +2205,14 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 
 static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 {
-	struct qmi_wlanfw_cap_req_msg_v01 req;
-	struct qmi_wlanfw_cap_resp_msg_v01 resp;
+	struct qmi_wlanfw_cap_req_msg_v01 req = {};
+	struct qmi_wlanfw_cap_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	unsigned int board_id = ATH12K_BOARD_ID_DEFAULT;
 	int ret = 0;
 	int r;
 	int i;
 
-	memset(&req, 0, sizeof(req));
-	memset(&resp, 0, sizeof(resp));
-
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
@@ -2314,7 +2305,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 					   const u8 *data, u32 len, u8 type)
 {
 	struct qmi_wlanfw_bdf_download_req_msg_v01 *req;
-	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp;
+	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	const u8 *temp = data;
 	int ret;
@@ -2323,7 +2314,6 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
-	memset(&resp, 0, sizeof(resp));
 
 	while (remaining) {
 		req->valid = 1;
@@ -2549,14 +2539,11 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
-	struct qmi_wlanfw_m3_info_req_msg_v01 req;
-	struct qmi_wlanfw_m3_info_resp_msg_v01 resp;
+	struct qmi_wlanfw_m3_info_req_msg_v01 req = {};
+	struct qmi_wlanfw_m3_info_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	int ret = 0;
 
-	memset(&req, 0, sizeof(req));
-	memset(&resp, 0, sizeof(resp));
-
 	ret = ath12k_qmi_m3_load(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to load m3 firmware: %d", ret);
@@ -2601,14 +2588,11 @@ static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 				       u32 mode)
 {
-	struct qmi_wlanfw_wlan_mode_req_msg_v01 req;
-	struct qmi_wlanfw_wlan_mode_resp_msg_v01 resp;
+	struct qmi_wlanfw_wlan_mode_req_msg_v01 req = {};
+	struct qmi_wlanfw_wlan_mode_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	int ret = 0;
 
-	memset(&req, 0, sizeof(req));
-	memset(&resp, 0, sizeof(resp));
-
 	req.mode = mode;
 	req.hw_debug_valid = 1;
 	req.hw_debug = 0;
@@ -2654,7 +2638,7 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_wlan_cfg_req_msg_v01 *req;
-	struct qmi_wlanfw_wlan_cfg_resp_msg_v01 resp;
+	struct qmi_wlanfw_wlan_cfg_resp_msg_v01 resp = {};
 	struct ce_pipe_config *ce_cfg;
 	struct service_to_pipe *svc_cfg;
 	struct qmi_txn txn;
@@ -2667,8 +2651,6 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	if (!req)
 		return -ENOMEM;
 
-	memset(&resp, 0, sizeof(resp));
-
 	req->host_version_valid = 1;
 	strscpy(req->host_version, ATH12K_HOST_VERSION_STRING,
 		sizeof(req->host_version));

-- 
2.42.0


