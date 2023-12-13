Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE2811A74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378876AbjLMRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjLMRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:07:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594EEB7;
        Wed, 13 Dec 2023 09:07:22 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDEPklS014035;
        Wed, 13 Dec 2023 17:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=1AcIyhIoIAYJEtYsTXVyARk5rQvUQbVh1Ib4zg2TLCE
        =; b=dsPfN0hSWYs1sLKCm2AmjvcLvn+LO7gg6JnUc0xvnsrE+rR+g5L+J0qzCcv
        8wT5veZNZMxs7dynQ+CmbgenCaPOQq7iYptql35iG0f2HlSjh1xS/Td8Sx4kgZOH
        bgTfl1s2ftDPe+pOXx+HGebMUKuWHRn2mrQcUYDxQKs67BAwlqoE7dwveaEEFJA3
        SFJXrtWnpWYqLYLfB8SLONJxlLhAyB3eH5fKfEER3cKs8nPE8p/J4uFb0mLleS8n
        kUD7v/ec9obubrB4hQFotKAXObffwyoHHMnmrqADpuCAggO2AIfCts8tlY3t4Jbr
        TthV0LlTItdPgJbGscNny45d6hg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyec5rdh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDH6fPC024419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:41 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 09:06:41 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Wed, 13 Dec 2023 09:06:42 -0800
Subject: [PATCH 4/6] wifi: ath10k: remove unused template structs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PFG6XjTlsqLAs94-J63S1rJBZS3WW0s2
X-Proofpoint-GUID: PFG6XjTlsqLAs94-J63S1rJBZS3WW0s2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently both the wmi_bcn_tmpl_cmd and wmi_prb_tmpl_cmd structs
define:
	  u8 data[1];

Per the guidance in [1] both instances of this should be flexible
arrays. However during conversion it was discovered that neither of
these structs are actually used, so just remove them.

No functional changes, compile tested only.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wmi.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 37a7d421bd86..e16410e348ca 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -5782,30 +5782,6 @@ struct wmi_bcn_prb_info {
 	/* app IE */
 } __packed;
 
-struct wmi_bcn_tmpl_cmd {
-	/* unique id identifying the VDEV, generated by the caller */
-	__le32 vdev_id;
-	/* TIM IE offset from the beginning of the template. */
-	__le32 tim_ie_offset;
-	/* beacon probe capabilities and IEs */
-	struct wmi_bcn_prb_info bcn_prb_info;
-	/* beacon buffer length */
-	__le32 buf_len;
-	/* variable length data */
-	u8 data[1];
-} __packed;
-
-struct wmi_prb_tmpl_cmd {
-	/* unique id identifying the VDEV, generated by the caller */
-	__le32 vdev_id;
-	/* beacon probe capabilities and IEs */
-	struct wmi_bcn_prb_info bcn_prb_info;
-	/* beacon buffer length */
-	__le32 buf_len;
-	/* Variable length data */
-	u8 data[1];
-} __packed;
-
 enum wmi_sta_ps_mode {
 	/* enable power save for the given STA VDEV */
 	WMI_STA_PS_MODE_DISABLED = 0,

-- 
2.42.0

