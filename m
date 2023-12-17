Return-Path: <linux-kernel+bounces-2742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84573816136
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399A02824AA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76143495E7;
	Sun, 17 Dec 2023 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UAFhWJZf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920EC48CC7;
	Sun, 17 Dec 2023 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BHGouJl008899;
	Sun, 17 Dec 2023 17:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=VjZ
	R7oDV4TXbIlaut9ptun19/6e99jP+7OHlnySjDiA=; b=UAFhWJZfMexP7byvzQw
	v+1vfnsULuNzos1tJgSjNYDAMudTeteCkc6xcoW3K4iO2eppsuz5uH4hZ5U5txb+
	yfrJdkdcmZgQAFAjmwO8oSUs5FD63RVqpeU/7uROtOAZdVArP4IhSIApHktUm/7n
	EkilNDnk7htGmKKGEUhRgXBFEq84o8IBxlMuvQcZbCdwbuFMDmiGP1+9bxbK3fBN
	gBOy16qhdOWQWqyaI9Ru+PjA2Aw+hn+/i4Z8aFslU4cobteMBg2Z/Zjmzg1mT5aN
	djeubr4fIjFMJbWb96/KRQXDV2OD2p03g2CSG2dbmMtlvblVYy1NdjMosKkoFftY
	iKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152qahtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Dec 2023 17:27:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BHHQlxt005329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Dec 2023 17:26:47 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 09:26:47 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 17 Dec 2023 09:26:46 -0800
Subject: [PATCH] wifi: ath12k: Make QMI message rules const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231217-ath12k-qmi_elem_info-const-v1-1-7ebb0de0a2b6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFUvf2UC/43NQQ6CMBCF4auQWVvTaSFEV97DEALtIBOllbYSD
 eHuVk7g8nuL/60QKTBFOBcrBFo4sncZeCjAjJ27kWCbDUoqjQor0aUR1V3ME7f0oKllN3hhvIt
 JyL4uZV1rPPUV5MAz0MDvPX5tskeOyYfP/rXgb/0ru6BAYQddllb2Vnf2Mr/YsDNH4ydotm37A
 uP4PCrGAAAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M5mXuLBGpv0GVQ9dGTX8b0niuLu_JKib
X-Proofpoint-GUID: M5mXuLBGpv0GVQ9dGTX8b0niuLu_JKib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312170130

Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct
qmi_elem_info") allows QMI message encoding/decoding rules
to be const, so do that for ath12k.

Compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 64 +++++++++++++++++------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 77a132f6bbd1..98cb6f44c261 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -17,7 +17,7 @@
 #define PLATFORM_CAP_PCIE_GLOBAL_RESET	0x08
 #define ATH12K_QMI_MAX_CHUNK_SIZE	2097152
 
-static struct qmi_elem_info wlfw_host_mlo_chip_info_s_v01_ei[] = {
+static const struct qmi_elem_info wlfw_host_mlo_chip_info_s_v01_ei[] = {
 	{
 		.data_type      = QMI_UNSIGNED_1_BYTE,
 		.elem_len       = 1,
@@ -61,7 +61,7 @@ static struct qmi_elem_info wlfw_host_mlo_chip_info_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_OPT_FLAG,
 		.elem_len	= 1,
@@ -511,7 +511,7 @@ static struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_host_cap_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_host_cap_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -528,7 +528,7 @@ static struct qmi_elem_info qmi_wlanfw_host_cap_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_ind_register_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_ind_register_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_OPT_FLAG,
 		.elem_len	= 1,
@@ -753,7 +753,7 @@ static struct qmi_elem_info qmi_wlanfw_ind_register_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_ind_register_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_ind_register_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -789,7 +789,7 @@ static struct qmi_elem_info qmi_wlanfw_ind_register_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_mem_cfg_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_mem_cfg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_8_BYTE,
 		.elem_len	= 1,
@@ -821,7 +821,7 @@ static struct qmi_elem_info qmi_wlanfw_mem_cfg_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_mem_seg_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_mem_seg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -863,7 +863,7 @@ static struct qmi_elem_info qmi_wlanfw_mem_seg_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_request_mem_ind_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_request_mem_ind_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_DATA_LEN,
 		.elem_len	= 1,
@@ -890,7 +890,7 @@ static struct qmi_elem_info qmi_wlanfw_request_mem_ind_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_mem_seg_resp_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_mem_seg_resp_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_8_BYTE,
 		.elem_len	= 1,
@@ -930,7 +930,7 @@ static struct qmi_elem_info qmi_wlanfw_mem_seg_resp_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_respond_mem_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_respond_mem_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_DATA_LEN,
 		.elem_len	= 1,
@@ -957,7 +957,7 @@ static struct qmi_elem_info qmi_wlanfw_respond_mem_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_respond_mem_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_respond_mem_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -975,7 +975,7 @@ static struct qmi_elem_info qmi_wlanfw_respond_mem_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_cap_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_cap_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -983,7 +983,7 @@ static struct qmi_elem_info qmi_wlanfw_cap_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_rf_chip_info_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_rf_chip_info_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1009,7 +1009,7 @@ static struct qmi_elem_info qmi_wlanfw_rf_chip_info_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_rf_board_info_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_rf_board_info_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1026,7 +1026,7 @@ static struct qmi_elem_info qmi_wlanfw_rf_board_info_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_soc_info_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_soc_info_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1042,7 +1042,7 @@ static struct qmi_elem_info qmi_wlanfw_soc_info_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_dev_mem_info_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_dev_mem_info_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_8_BYTE,
 		.elem_len	= 1,
@@ -1068,7 +1068,7 @@ static struct qmi_elem_info qmi_wlanfw_dev_mem_info_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_fw_version_info_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_fw_version_info_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1094,7 +1094,7 @@ static struct qmi_elem_info qmi_wlanfw_fw_version_info_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_cap_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_cap_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -1348,7 +1348,7 @@ static struct qmi_elem_info qmi_wlanfw_cap_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_bdf_download_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_bdf_download_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_1_BYTE,
 		.elem_len	= 1,
@@ -1483,7 +1483,7 @@ static struct qmi_elem_info qmi_wlanfw_bdf_download_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_bdf_download_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_bdf_download_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -1501,7 +1501,7 @@ static struct qmi_elem_info qmi_wlanfw_bdf_download_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_m3_info_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_m3_info_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_8_BYTE,
 		.elem_len	= 1,
@@ -1525,7 +1525,7 @@ static struct qmi_elem_info qmi_wlanfw_m3_info_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_m3_info_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_m3_info_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -1542,7 +1542,7 @@ static struct qmi_elem_info qmi_wlanfw_m3_info_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_ce_tgt_pipe_cfg_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_ce_tgt_pipe_cfg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1595,7 +1595,7 @@ static struct qmi_elem_info qmi_wlanfw_ce_tgt_pipe_cfg_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_ce_svc_pipe_cfg_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_ce_svc_pipe_cfg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1630,7 +1630,7 @@ static struct qmi_elem_info qmi_wlanfw_ce_svc_pipe_cfg_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_shadow_reg_cfg_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_shadow_reg_cfg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_2_BYTE,
 		.elem_len	= 1,
@@ -1654,7 +1654,7 @@ static struct qmi_elem_info qmi_wlanfw_shadow_reg_cfg_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_shadow_reg_v3_cfg_s_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_shadow_reg_v3_cfg_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1671,7 +1671,7 @@ static struct qmi_elem_info qmi_wlanfw_shadow_reg_v3_cfg_s_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_wlan_mode_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_wlan_mode_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -1706,7 +1706,7 @@ static struct qmi_elem_info qmi_wlanfw_wlan_mode_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_wlan_mode_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_wlan_mode_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -1724,7 +1724,7 @@ static struct qmi_elem_info qmi_wlanfw_wlan_mode_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_wlan_cfg_req_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_wlan_cfg_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_OPT_FLAG,
 		.elem_len	= 1,
@@ -1862,7 +1862,7 @@ static struct qmi_elem_info qmi_wlanfw_wlan_cfg_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_wlan_cfg_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_wlan_cfg_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -1879,14 +1879,14 @@ static struct qmi_elem_info qmi_wlanfw_wlan_cfg_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_mem_ready_ind_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_mem_ready_ind_msg_v01_ei[] = {
 	{
 		.data_type = QMI_EOTI,
 		.array_type = NO_ARRAY,
 	},
 };
 
-static struct qmi_elem_info qmi_wlanfw_fw_ready_ind_msg_v01_ei[] = {
+static const struct qmi_elem_info qmi_wlanfw_fw_ready_ind_msg_v01_ei[] = {
 	{
 		.data_type = QMI_EOTI,
 		.array_type = NO_ARRAY,

---
base-commit: fd6ed1772b2c639370b7b41602d4c925dbd003d4
change-id: 20231215-ath12k-qmi_elem_info-const-0b74077319b5


