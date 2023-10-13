Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB37C87D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJMOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjJMOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:24:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38ACE;
        Fri, 13 Oct 2023 07:24:33 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDaxgB001036;
        Fri, 13 Oct 2023 14:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=+6I0AQwGs3UbA5zjU9MEBUHD6ofogj+7asD/bxCen0I=;
 b=kcPMq5Ula18AiIRbt8KeJAKg7boR+L1KlwN8Ui4iUzEi8ZpMmVG8d6dRMGPbYjCfccJj
 qpvH10GVd03rQ2qSUaoHp47qEMOB6HNpDq1XYxoZ/jIcNWY+/eps3Tyv7q8b6KPY/Z0d
 t9pdilq98q3PWZqJFP05pva+81itVvd3QLHopyQgAeJvdYGG7Ui8mMGz8QuhZZzkYMqU
 6RATG6vBIU/bVwNubz4VG9Q9v5iQZJn6FUDFJ1x3wxv3x7nPCzpupJyXUf6he4tjdhrv
 WD3m1lSbkamIFQ5TJBalMBut7khASTMGYUsixftdAIchbbdKHf0iK/HHA0nCG0NQkz3E PQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tq2sr8m55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:24:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DEOAsO025426
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:24:10 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 07:24:09 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Fri, 13 Oct 2023 07:24:08 -0700
Subject: [PATCH 1/2] wifi: ath11k: Remove ath11k_base::bd_api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231013-ath11k_bd_api-v1-1-3fefe4629706@quicinc.com>
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
X-Proofpoint-GUID: yx679Zmrl0SjBv1A6ybZFuB2iy19ebYa
X-Proofpoint-ORIG-GUID: yx679Zmrl0SjBv1A6ybZFuB2iy19ebYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=858 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently struct ath11k_base defines the member bd_api. However, this
member is only accessed within ath11k_core_fetch_bdf(). Since the
scope is local just to that one function, remove it from ath11k_base
and instead just use a local stack variable.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 7 ++++---
 drivers/net/wireless/ath/ath11k/core.h | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c3a0dd15d8ea..1469ab4a2df9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1317,6 +1317,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
 	char *boardname = NULL, *fallback_boardname = NULL, *chip_id_boardname = NULL;
 	char *filename, filepath[100];
+	int bd_api;
 	int ret = 0;
 
 	filename = ATH11K_BOARD_API2_FILE;
@@ -1332,7 +1333,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 		goto exit;
 	}
 
-	ab->bd_api = 2;
+	bd_api = 2;
 	ret = ath11k_core_fetch_board_data_api_n(ab, bd, boardname,
 						 ATH11K_BD_IE_BOARD,
 						 ATH11K_BD_IE_BOARD_NAME,
@@ -1381,7 +1382,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 	if (!ret)
 		goto exit;
 
-	ab->bd_api = 1;
+	bd_api = 1;
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_DEFAULT_BOARD_FILE);
 	if (ret) {
 		ath11k_core_create_firmware_path(ab, filename,
@@ -1405,7 +1406,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 	kfree(chip_id_boardname);
 
 	if (!ret)
-		ath11k_dbg(ab, ATH11K_DBG_BOOT, "using board api %d\n", ab->bd_api);
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "using board api %d\n", bd_api);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 650972f9d146..f4e8b3b9ed4d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -906,7 +906,6 @@ struct ath11k_base {
 	struct ath11k_targ_cap target_caps;
 	u32 ext_service_bitmap[WMI_SERVICE_EXT_BM_SIZE];
 	bool pdevs_macaddr_valid;
-	int bd_api;
 
 	struct ath11k_hw_params hw_params;
 

-- 
2.42.0

