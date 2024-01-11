Return-Path: <linux-kernel+bounces-24006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17682B52D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9EEB22A62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724E55786;
	Thu, 11 Jan 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pORZF7Am"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E039F;
	Thu, 11 Jan 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BEwjZD012289;
	Thu, 11 Jan 2024 19:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=DNl
	WpZ0L6MS40umooaV+XdQdfO8wM83O25YiAyQqwRU=; b=pORZF7AmE+fo9CUnuGW
	LFpohaT+NYIAj2hND9gcxZyh03AfScCYHE5CE/H2VlD0JivSyyP+SlVYCfUWC61+
	mSyJRNHH63HkTVEzYyJLSwGxoCWpqljL8Ejb9EsKHlD6CG2tn0YsLHjFjWJGk9OV
	b+tFQBc+wCuu7SR78UC9upGmnEVVmmV+uoJNDZWUOWSUdJ4LiBlhyrN6FycJqy4X
	eKuZUGlbSqdItLkbJ5246B5UNXwgAL8yR38LZ9jlMXKs0H4JsoayAzgncdXQqAfc
	0aSAHesTODnukmtDnACPKdIOcHl4L+rOe5OhN0DcmkXzSLm/9GCQFbdZGoocvUAe
	ZxA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjjjj0mgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:24:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BJORTs022843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:24:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 11:24:27 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 11 Jan 2024 11:24:23 -0800
Subject: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGZAoGUC/x3NTQqDMBBA4avIrBvIiAj2KqUM+ZnUgSaWSbWCe
 PcGl9/mvQMqq3CFe3eA8iZVltKAtw7C7MqLjcRm6G0/WEQ0cQlr5vI1s3uT7uTXROoz1d9APpv
 JpTiNzvqACVrko5xkvwaP53n+AV6o8HRwAAAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -qaC1G6DoNyx-Ab7O8KvO9QvZr6CyBGS
X-Proofpoint-GUID: -qaC1G6DoNyx-Ab7O8KvO9QvZr6CyBGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=423
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110152

Commit 7636c9a6e7d7 ("wifi: ath11k: Add multi TX ring support for WCN6750")
added HAL_RX_BUF_RBM_SW4_BM to enum hal_rx_buf_return_buf_manager. However,
as flagged by the kernel-doc script, the documentation was not updated:

drivers/net/wireless/ath/ath11k/hal.h:689: warning: Enum value 'HAL_RX_BUF_RBM_SW4_BM' not described in enum 'hal_rx_buf_return_buf_manager'

So update the documentation. No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 80447f488954..65e8f244ebb9 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HAL_H
@@ -674,6 +674,7 @@ struct hal_srng_config {
  * @HAL_RX_BUF_RBM_SW1_BM: For Tx completion -- returned to host
  * @HAL_RX_BUF_RBM_SW2_BM: For Tx completion -- returned to host
  * @HAL_RX_BUF_RBM_SW3_BM: For Rx release -- returned to host
+ * @HAL_RX_BUF_RBM_SW4_BM: For Tx completion -- returned to host
  */
 
 enum hal_rx_buf_return_buf_manager {

---
base-commit: fba97a777dcb90896ab1dc32e796d85bb7bbcd69
change-id: 20240111-document-hal_rx_buf_rbm_sw4_bm-9afd96a0bc1f


