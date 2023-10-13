Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6247C87C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJMOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:24:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB43BD;
        Fri, 13 Oct 2023 07:24:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDgIpY022651;
        Fri, 13 Oct 2023 14:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Pir3ku6EK/1+189ah2jxDNBM4ljMV2VO5+1SLY1pm7o=;
 b=DoIU1Ijl7NPjgnowNkqLnUDsrRBZC91Bzz7ze1RG0T3qVFmgF9S0GzrmBvmgss3i9Wax
 iDIWzLArZ9w42g9TUosZnH8WdcUIlwrHCGHo41rhDwT8eVXOyaN9wqhHTRmMfpuWDIRt
 96hI9aJVITS7St/IYIlr4JwFNvibhZvGOY/o6kskIhimorNUnl/2Qnc4lDYK9j7v1SWl
 OgVq9tH8XKHTRO6l0kGGJY2/EWny3isx/qkRy73YP2+fq8nxGYwjc9cOaeySot7mSo72
 rO0khbjh2DLSnIMK0zpB7db/AJ1Nd29lIaSzGXqV9QQALFpER6aP+Et/3+dla/v8nYbl qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1nsw9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:24:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DEOAA8018261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:24:10 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 07:24:09 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Fri, 13 Oct 2023 07:24:09 -0700
Subject: [PATCH 2/2] wifi: ath12k: Remove ath12k_base::bd_api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231013-ath11k_bd_api-v1-2-3fefe4629706@quicinc.com>
References: <20231013-ath11k_bd_api-v1-0-3fefe4629706@quicinc.com>
In-Reply-To: <20231013-ath11k_bd_api-v1-0-3fefe4629706@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FeGpHGFb-SMvgN0PWMIR2ipi0-XpTjZE
X-Proofpoint-ORIG-GUID: FeGpHGFb-SMvgN0PWMIR2ipi0-XpTjZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=894 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310130120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently struct ath12k_base defines the member bd_api. However, this
member is only accessed within ath12k_core_fetch_bdf(). Since the
scope is local just to that one function, remove it from ath12k_base
and instead just use a local stack variable.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 7 ++++---
 drivers/net/wireless/ath/ath12k/core.h | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c68750cb3c4d..dbffd1c7cd88 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -360,6 +360,7 @@ int ath12k_core_fetch_board_data_api_1(struct ath12k_base *ab,
 int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 {
 	char boardname[BOARD_NAME_SIZE];
+	int bd_api;
 	int ret;
 
 	ret = ath12k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
@@ -368,12 +369,12 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 		return ret;
 	}
 
-	ab->bd_api = 2;
+	bd_api = 2;
 	ret = ath12k_core_fetch_board_data_api_n(ab, bd, boardname);
 	if (!ret)
 		goto success;
 
-	ab->bd_api = 1;
+	bd_api = 1;
 	ret = ath12k_core_fetch_board_data_api_1(ab, bd, ATH12K_DEFAULT_BOARD_FILE);
 	if (ret) {
 		ath12k_err(ab, "failed to fetch board-2.bin or board.bin from %s\n",
@@ -382,7 +383,7 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 	}
 
 success:
-	ath12k_dbg(ab, ATH12K_DBG_BOOT, "using board api %d\n", ab->bd_api);
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "using board api %d\n", bd_api);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 254eb42a85c5..fafb2a5b9350 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -737,7 +737,6 @@ struct ath12k_base {
 	struct ath12k_wmi_target_cap_arg target_caps;
 	u32 ext_service_bitmap[WMI_SERVICE_EXT_BM_SIZE];
 	bool pdevs_macaddr_valid;
-	int bd_api;
 
 	const struct ath12k_hw_params *hw_params;
 

-- 
2.42.0

