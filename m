Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1357E0AF1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjKCWF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjKCWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:05:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6BDD68;
        Fri,  3 Nov 2023 15:05:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3LunVt010061;
        Fri, 3 Nov 2023 22:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=NqUTEFbJ5nq8FmahHI75LFuipe+tD6i+E3bAsGInr5k=;
 b=DULFBaHq3SIQkrzSbiqcLHPxtRiMDk/rNhL/b9+cG4Wgr4PdG6j4VC6AX6hsZil7PGu3
 deFXkqFhzWNqvK2GE0K7JNcT4cNdE5g32mQyQ0FgtVRL7bLIJgLGRhqEo4GsUNlgAhAY
 V1KfiB+X/eaZQejBLXkT8w2qoqn0qXgohtCSPVeEBTp6xXhYRzt7iPxgw/nZ8rS8F7Qz
 lJZCr4sROl/pC7iBQ3vj5bQQjtrESVP1K6DgnvoxnI+ddmaoJZi7WmK1qBB+OcsK2zN5
 iUrkyYSW8ed3nUEixbKlzlN670DjhYfmrEABkRO4QLmCKTQn+8f7OtylCt08MAYkZj8L gA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u533j8wcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 22:05:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3M5c67021096
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 22:05:38 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 15:05:37 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Fri, 3 Nov 2023 15:05:36 -0700
Subject: [PATCH] wifi: ath10k: Remove unused struct ath10k_htc_frame
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231103-ath10k_htc_frame-v1-1-ff00b38a9630@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAK9uRWUC/32NQQ6CMBBFr0JmbU2nVEBX3sMQUsvUTgygbSUaw
 t2tHMDle8l/f4FIgSnCqVgg0MyRpzED7gqw3ow3EtxnBiVViVIdhEke5b3zyXYumIEEVn1DunT
 1seohzx6BHL+35KXN7DmmKXy2hxl/9k9sRoFCNgq1Kmttrvr8fLHl0e7tNEC7rusXLp8pWbIAA
 AA=
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8yDxnvN3hX6ED0uM-r3Or87iMcaGtgww
X-Proofpoint-ORIG-GUID: 8yDxnvN3hX6ED0uM-r3Or87iMcaGtgww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=713 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ath10k_htc_frame is unused, and since it illogically contains
two consecutive flexible arrays, it could never be used, so remove it.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htc.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index 0d180faf3b77..0eaa21ad86ac 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -253,19 +253,6 @@ struct ath10k_htc_record {
 	};
 } __packed __aligned(4);
 
-/*
- * note: the trailer offset is dynamic depending
- * on payload length. this is only a struct layout draft
- */
-struct ath10k_htc_frame {
-	struct ath10k_htc_hdr hdr;
-	union {
-		struct ath10k_htc_msg msg;
-		u8 payload[0];
-	};
-	struct ath10k_htc_record trailer[0];
-} __packed __aligned(4);
-
 /*******************/
 /* Host-side stuff */
 /*******************/

---
base-commit: ac2f43d3d34e52b0d388b4c573ff6bbac90235b9
change-id: 20231025-ath10k_htc_frame-16d8e43f796d

