Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645EA7E2BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKFSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjKFSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:21:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287511BF;
        Mon,  6 Nov 2023 10:21:13 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GvrbE026671;
        Mon, 6 Nov 2023 18:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=AA5O2SCvUm9mfQBN4CAXYP/QY4STb+gr3WQyrPEczG8=;
 b=D7MfIvHwOsfJWhGClYEzy+ypr+bbNzgh7lgpg2XAD/TP9tVqupUBqQ5boIpamasdcD2Q
 Lthq/konhgC51RhE4xlthwS6qxLX1OExiuH+DUqx4MrBlHtVNafdAKcmfar4houfMHcS
 6p/R42ybUSkY4ygH3CpnI//xI3T8A1ASCzOt+YCXFrDZzORrDsfLbcVqdzI5NT/ZaUBB
 TIfJpTaG8lbNPsIw03mEpKOa9cR61P7riZGgRfNF9cAFL0ks9BHbdQazfq5ZlWnCBsa7
 stjyOA8l4OdgMWUy0yQlu8jS57B6JjmIsGXL2QsJ5i40qLV4K+x0mY3nL8R6WmreCLoN hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5efyn3tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 18:21:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6IL5LB012649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 18:21:05 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 10:21:05 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 6 Nov 2023 10:21:05 -0800
Subject: [PATCH 2/2] wifi: ath12k: Remove struct ath12k::ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231106-ath12k-remove-ieee80211_ops-v1-2-d72cef1a855b@quicinc.com>
References: <20231106-ath12k-remove-ieee80211_ops-v1-0-d72cef1a855b@quicinc.com>
In-Reply-To: <20231106-ath12k-remove-ieee80211_ops-v1-0-d72cef1a855b@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qj7TBQjdYMMaxBubdRIegKMRt751ls1E
X-Proofpoint-ORIG-GUID: Qj7TBQjdYMMaxBubdRIegKMRt751ls1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=484 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently struct ath12k defines the following member:
	struct ieee80211_ops *ops;

This is being flagged by checkpatch.pl:
WARNING: struct ieee80211_ops should normally be const

The original plan was to add the const qualifier.  However, it turns
out this is actually unused, so remove it.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 68c42ca44fcb..6dbe817d2ec7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CORE_H
@@ -467,7 +467,6 @@ struct ath12k {
 	struct ath12k_base *ab;
 	struct ath12k_pdev *pdev;
 	struct ieee80211_hw *hw;
-	struct ieee80211_ops *ops;
 	struct ath12k_wmi_pdev *wmi;
 	struct ath12k_pdev_dp dp;
 	u8 mac_addr[ETH_ALEN];

-- 
2.42.0

