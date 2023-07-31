Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1B768BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGaGP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGaGPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:15:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0811980;
        Sun, 30 Jul 2023 23:15:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V67NqN018898;
        Mon, 31 Jul 2023 06:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VXGz9M1YLK4EDF1rkPp/tWfQEev+4mESG3cjPeecTao=;
 b=XJJaQYFfJ8dReHxp3MhMYEAPt/LWVt1wl1UQRcwXd8y1h8XkxchotKVe8xRTi9ziOh+w
 OtQiGJXrEuWdxz2TlPe9apDa9jgaJbXqTP9T1wJM6+CaLL5BNojtmgLbyLajnGb//8Gq
 gm9sjpBycUc0cBVlVY4f8Y/Hc5SbEqE5n2QuIZlgxI9eVtGtoUnHkxVLZZYSju2RE6eI
 89IuykLgZIA3b6mo96+/8xeD7/rsZADoVG9dPEx0AzoXVbTWlJm5s8nbDrS4hnRXF1Ux
 hM0sIZSWtv1sL0ShQVy2sI1oltQ59DcV7QRgIAecl3xhmsZH/7P+R0GW/PavzPTHHPT6 yA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uxsaq55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 06:14:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V6EHGl031187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 06:14:17 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 30 Jul 2023 23:14:11 -0700
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
Subject: [PATCH v3 6/8] soc: qcom: socinfo: adjust the position of QDU1010
Date:   Mon, 31 Jul 2023 14:13:23 +0800
Message-ID: <20230731061325.26431-7-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230731061325.26431-1-quic_tengfan@quicinc.com>
References: <20230731061325.26431-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: do4zPwx6xzNkgqDufVrRifqx2YDE5pgw
X-Proofpoint-GUID: do4zPwx6xzNkgqDufVrRifqx2YDE5pgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=892
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the position of QDU1010, so that QDU1010 have
same sequence with QCOM_ID_QDU1010 in bindings file.

Change-Id: I86d46eca55e877aaa1fd948db99b41ae138a3129
---
 drivers/soc/qcom/socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..ad7699b401a8 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -405,8 +405,8 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SA8775P) },
 	{ qcom_board_id(QRU1000) },
 	{ qcom_board_id(QDU1000) },
-	{ qcom_board_id(QDU1010) },
 	{ qcom_board_id(IPQ5019) },
+	{ qcom_board_id(QDU1010) },
 	{ qcom_board_id(QRU1032) },
 	{ qcom_board_id(QRU1052) },
 	{ qcom_board_id(QRU1062) },
-- 
2.17.1

