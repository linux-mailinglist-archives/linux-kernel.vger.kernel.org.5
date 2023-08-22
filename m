Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53997844BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjHVOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjHVOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:51:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BA6CEE;
        Tue, 22 Aug 2023 07:51:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M8KlSi002021;
        Tue, 22 Aug 2023 14:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=2dl+LHrfehLIiNC5ETXJvv6T3K9bYXbgbwVsdshjTB0=;
 b=S8GUxND1XuxIskXend56x9oPsEZecQkr1HjU+94TbbjASt8PNSohfaNvi4OGhrcYF0uc
 8/s081o04sujUz8xgdcrsXaNJQF7Mic7MPmJQH+INvwJLHpH9W3L96qb5R7LtAuOi5NE
 /sC5qBRceudTembK5ABzam1tSLh6CffPlb4GiB9wBGOx3h5yKYzjT/GHuz56vLG7YTja
 ftJLNtDl6zb/8vfr/3e8VWixEGH98DHhMxGFJw64UWbdQ5XG+HLKNhz4qu9f9Q5HoLop
 MNUNesVqthQWyk6I6Gmf+AT7Ln71w0HsywWpFzyquT4eAM3LwTPedYrzJDJfdGIoXvau ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smfjs9p88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:50:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MEopbW008793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:50:51 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 07:50:51 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 22 Aug 2023 07:50:49 -0700
Subject: [PATCH 2/3] wifi: ath11k: Fix a few spelling errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230822-ath_spelling-v1-2-8e2698759564@quicinc.com>
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
In-Reply-To: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OaV4s_iopqYNx0M6d_lqzRxZKHrADQ-e
X-Proofpoint-GUID: OaV4s_iopqYNx0M6d_lqzRxZKHrADQ-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few issues flagged by 'codespell'.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp.h    | 2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index d04f78ab6b37..15815af453b2 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -635,7 +635,7 @@ enum htt_ppdu_stats_tag_type {
  *          b'24    - status_swap: 1 is to swap status TLV
  *          b'25    - pkt_swap:  1 is to swap packet TLV
  *          b'26:31 - rsvd1:  reserved for future use
- * dword1 - b'0:16  - ring_buffer_size: size of bufferes referenced by rx ring,
+ * dword1 - b'0:16  - ring_buffer_size: size of buffers referenced by rx ring,
  *                    in byte units.
  *                    Valid only for HW_TO_SW_RING and SW_TO_HW_RING
  *        - b'16:31 - rsvd2: Reserved for future use
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1e488eed282b..62bc98852f0f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3423,7 +3423,7 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
 	ath11k_hal_rx_buf_addr_info_set(msdu0, paddr, cookie,
 					ab->hw_params.hal_params->rx_buf_rbm);
 
-	/* Fill mpdu details into reo entrace ring */
+	/* Fill mpdu details into reo entrance ring */
 	srng = &ab->hal.srng_list[ab->dp.reo_reinject_ring.ring_id];
 
 	spin_lock_bh(&srng->lock);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a34833de7c67..352e76fc4c1f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -238,7 +238,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		spin_unlock_bh(&tcl_ring->lock);
 		ret = -ENOMEM;
 
-		/* Checking for available tcl descritors in another ring in
+		/* Checking for available tcl descriptors in another ring in
 		 * case of failure due to full tcl ring now, is better than
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.

-- 
2.25.1

