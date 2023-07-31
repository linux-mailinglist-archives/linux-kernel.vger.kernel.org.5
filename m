Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D80768F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGaICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjGaICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:02:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD6E46;
        Mon, 31 Jul 2023 01:01:42 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V67LXs005540;
        Mon, 31 Jul 2023 08:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RQ0SS+sbmKlbk+zwOC6vfKWq+WoGIVZSLGsdqA14lAU=;
 b=fImflUNyqHqlPkEsYOgrT3TyaSUX/OyyAyipRaF/V5PoYWd059ca0dSqZDyQfPe+NPop
 Czk+YaqdFeQUf5/ESODgjZgEfbAyoSFYEW/yCRktr4kwfRs62pvu4qBjAcmiIdfoik1l
 IJUMi8fOprBMnJDjaESf1ljCpWp/6BDHYa/VNNKbGUE9wHgovAUV8SIzW9VEh+w0uq4G
 09ejuWZth+5kTRt6VeAeyAAnnCvQ4VLvqCpd7RzWqqD6Rq1yHsWhX72Lvq1Cg/41OHzi
 mHrqEVn5AO09F71e5VMHW2yQRWEuGgbpbRQZreD66dDf4ZG+g5gb1F34iBNjDiqZYJ/y EQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uantyby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 08:01:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V81co3026782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 08:01:38 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 01:01:33 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v4 6/6] soc: qcom: socinfo: add SM4450 ID
Date:   Mon, 31 Jul 2023 16:00:43 +0800
Message-ID: <20230731080043.38552-7-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230731080043.38552-1-quic_tengfan@quicinc.com>
References: <20230731080043.38552-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a4NT5ydRbc-pw0zDQBL21vsH17OK8TPO
X-Proofpoint-ORIG-GUID: a4NT5ydRbc-pw0zDQBL21vsH17OK8TPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_01,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=831
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ID for the Qualcomm SM4450 SoC.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..441a40f58838 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -405,6 +405,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SA8775P) },
 	{ qcom_board_id(QRU1000) },
 	{ qcom_board_id(QDU1000) },
+	{ qcom_board_id(SM4450) },
 	{ qcom_board_id(QDU1010) },
 	{ qcom_board_id(IPQ5019) },
 	{ qcom_board_id(QRU1032) },
-- 
2.17.1

