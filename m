Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6607BE6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377181AbjJIQhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377652AbjJIQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:37:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2499;
        Mon,  9 Oct 2023 09:37:26 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399FG7Z4019110;
        Mon, 9 Oct 2023 16:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=EUT3yna1+55BbbaWoFfRXex3+SqxJsdKJA4s4YIXlCM=;
 b=S3yrRV/KEakM6lB+9qjVWxyJSCAz6EAvI8Wputws8tA4HKZUdeNldWu06oz+ckGbap0G
 VWOztCuZaDB9uB/fv7y6GBaIPcvmCXKBAKA9M8dGtKhS2B0Lee1DE2sILxp5FMEUIK/4
 ffh8NbssPv4q93wiRMjNjXjUW+9G/kR88ccrIceMXQ+1oYjZj0SO9ucaioKaNsfYb6uf
 FU0eTwM3yAMMxAOLG5UssCgLt22QgP9hcgjraHh9/SA/PxI4O29Hsh2dVbxrkgK6BMjt
 0QtEZSBfrw99XturTR12P8S128X5k1OzmqjrNYp0YLLjrw8Nco6zrLOLzri3T0CHc/Se SA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh5930gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 16:37:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399GbDD2013167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 16:37:13 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 9 Oct 2023 09:37:13 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 9 Oct 2023 09:36:54 -0700
Subject: [PATCH] wifi: ath11k: Remove unused struct ath11k_htc_frame
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231009-ath11k_htc_frame-v1-1-81d405b7a195@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACUsJGUC/32NWwrCMBBFt1Lm28hMqtH65T6klJBOzCB9mNSil
 O7d2AX4eQ7ccxdIHIUTXIoFIs+SZOgz0K4AF2x/ZyVtZtCoS0I8KjsFokcTJtf4aDtW/lQZ5z0
 imgPk2RjZy3tL3urMQdI0xM/2MNPP/onNpEgxGm31uWyNqa7Plzjp3d4NHdTrun4BYHdg5LIAA
 AA=
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OOjjguzu5qcAxXqtdFsmhyF6n7M-Lc6q
X-Proofpoint-GUID: OOjjguzu5qcAxXqtdFsmhyF6n7M-Lc6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_14,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxlogscore=717
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090136
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ath11k_htc_frame is unused, and since it illogically contains
two consecutive flexible arrays, it could never be used, so remove it.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/htc.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
index f429b37cfdf7..d31e501c807c 100644
--- a/drivers/net/wireless/ath/ath11k/htc.h
+++ b/drivers/net/wireless/ath/ath11k/htc.h
@@ -156,18 +156,6 @@ struct ath11k_htc_record {
 	};
 } __packed __aligned(4);
 
-/* note: the trailer offset is dynamic depending
- * on payload length. this is only a struct layout draft
- */
-struct ath11k_htc_frame {
-	struct ath11k_htc_hdr hdr;
-	union {
-		struct ath11k_htc_msg msg;
-		u8 payload[0];
-	};
-	struct ath11k_htc_record trailer[0];
-} __packed __aligned(4);
-
 enum ath11k_htc_svc_gid {
 	ATH11K_HTC_SVC_GRP_RSVD = 0,
 	ATH11K_HTC_SVC_GRP_WMI = 1,

---
base-commit: 453a62a3ee65aeba6e69bfd09227fc2f19290bea
change-id: 20231005-ath11k_htc_frame-f796cff00064

