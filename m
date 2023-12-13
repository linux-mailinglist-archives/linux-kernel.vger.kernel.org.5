Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023B6811A72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378832AbjLMRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:07:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D34D0;
        Wed, 13 Dec 2023 09:07:21 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDDnRpt014846;
        Wed, 13 Dec 2023 17:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=g2R8Hf30ansh0q9veiXH67BzJDPzuP0bNK2kUtXNSos
        =; b=mo1n7OBDa1yH+r8RdZTX5mnOsLptTudDDTFL9OmXBheyRZWnifbfbv8dB4c
        7s+0xT3fgWs+AyJ6V7mLVWYofOxwmmik8FWMYm56phFHAcRl8r4aCR8QexrgjPVb
        Qn27K+o9a72ogLF/WFmZxnlk28r39C/HJlPW4KJX9gQOo4h5LeNB2ng1K3vEKP/3
        Nz+nCVcPq+CvBkah3D89aFxJIDXDsQTZf6YKv69737iH5cu3oFSqn41mEKZ+fBZM
        cE89Wt6TJomsXLtvLelLsp6IUsyzc49tC7axSaPJoovzcuEeIkX+3uiWy2pseBVk
        51YPtVdqQk8RdIN05bZj00Bz0EA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy9gd15qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDH6gev024426
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 09:06:41 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Wed, 13 Dec 2023 09:06:44 -0800
Subject: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
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
X-Proofpoint-ORIG-GUID: o113M8uWNgMGPXX11Br_ZlzAUJuPoPVd
X-Proofpoint-GUID: o113M8uWNgMGPXX11Br_ZlzAUJuPoPVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=521
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.

No functional changes, compile tested only.

[1] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 4d5aadbc7159..0cfd9484c45e 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -8918,8 +8918,6 @@ ath10k_wmi_10_4_gen_tdls_peer_update(struct ath10k *ar,
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
-	memset(skb->data, 0, sizeof(*cmd));
-
 	cmd = (struct wmi_10_4_tdls_peer_update_cmd *)skb->data;
 	cmd->vdev_id = __cpu_to_le32(arg->vdev_id);
 	ether_addr_copy(cmd->peer_macaddr.addr, arg->addr);

-- 
2.42.0

