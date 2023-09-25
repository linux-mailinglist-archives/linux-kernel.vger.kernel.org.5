Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FCD7AD09E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjIYGvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjIYGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:51:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5DCF;
        Sun, 24 Sep 2023 23:51:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P4nxb2013442;
        Mon, 25 Sep 2023 06:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4VIZxs8DjczlVgSQKkcQ7k7fvAkaKqb4Bg0Ju/+yY7E=;
 b=Y+vPU3E6FVy6evCIsTQgqd52cSyTd2R1tKymZumUAlEHut2SXEYJvGpTZc0ZQYUsCggk
 5hnKGVTY0O4/R6K3tZ3jba9UvEoHFzB6SWgGYi9MDEeH7oREb+rpkpX77xwQAphtgYnA
 d6dytrzmMQ6FgohriJ2kuCtU31cbgMdQdGJZ/DRwjbwDvFKgL2fgdWt/48gZy/klTGqX
 R0a0p6+C9GFJgZTr++wnSP5cAGIeKANvVnrrmWErasmC0HNAZCYh0GbeIdpUUjiiw0H1
 sqoJ7f30C5ksi5i2Ehj2IxnCrzhejADb6XCB1O+BUlXP4gn83ljkBoMWau1gtT4+QI36 oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9qbpu2wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 06:50:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P6oduY022120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 06:50:39 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 24 Sep 2023 23:50:31 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v5 6/7] arm64: dts: qcom: sm4450-qrd: mark QRD4450 reserved gpios
Date:   Mon, 25 Sep 2023 14:49:26 +0800
Message-ID: <20230925064927.26448-7-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230925064927.26448-1-quic_tengfan@quicinc.com>
References: <20230925064927.26448-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C2QFN28yiSVCTsk6XQkpeWksbtEvV-lk
X-Proofpoint-ORIG-GUID: C2QFN28yiSVCTsk6XQkpeWksbtEvV-lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_03,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=680 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some gpios are reserved for other subsystems, so mark these reserved
gpios.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
index bb8c58fb4267..e354bad57a9e 100644
--- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
@@ -23,6 +23,11 @@
 	status = "okay";
 };
 
+&tlmm {
+	/* Reserved for other subsystems */
+	gpio-reserved-ranges = <0 4>, <136 1>;
+};
+
 &uart7 {
 	status = "okay";
 };
-- 
2.17.1

