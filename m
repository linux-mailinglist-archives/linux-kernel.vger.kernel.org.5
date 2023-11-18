Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044B7EFFAD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjKRMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjKRMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:40:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CAF9;
        Sat, 18 Nov 2023 04:40:33 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AICJXnw000459;
        Sat, 18 Nov 2023 12:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=SF9w/N/G7EMdZm4OIiDNIKEOU2y4lBIzmGyXxw5dZF8=;
 b=Z7xd7EDUAqz1QIThp6FHPyA5vcWFSkRyt0yhzEqqsKVZtFUe+FSECs9WP647Z1TmpFFC
 fQ7Nrv4WkmPiBykGLEcvTIlPjj6FLgbAN46rGi1mcAmT6MXW7AcOYnKIZlrg5qcsZLzM
 WedY/JfFQlttGzgnTqXjRYBK0VI2VJqgNml3uxbps2nMmA3BvvSml4t0QObSrLLoaA0W
 vWeC6GZYKfx79G+MN+YMHrlqZY5XN8yPT8wlGmVObcATVwdrG6C04TUUu4NPVEaS5PUM
 1agi7trPJXy9XfmkvDFFtoZ19KzzajFF4oqmQF6lCnpPBY2rg5gSlA9q2Qpdp+57tZ3R IQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uenc0rgu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 12:40:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AICeR2J020878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 12:40:27 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 18 Nov 2023 04:40:23 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/4] dt-bindings: clock: Update the videocc resets for sm8150
Date:   Sat, 18 Nov 2023 18:09:41 +0530
Message-ID: <20231118123944.2202630-2-quic_skakitap@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
References: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 293MLCKV0DvE_qFI4XCyHx27zXj6PgOP
X-Proofpoint-ORIG-GUID: 293MLCKV0DvE_qFI4XCyHx27zXj6PgOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_11,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=701 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the available resets for the video clock controller
on sm8150.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
 - None.

 include/dt-bindings/clock/qcom,videocc-sm8150.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,videocc-sm8150.h b/include/dt-bindings/clock/qcom,videocc-sm8150.h
index e24ee840cfdb..c557b78dc572 100644
--- a/include/dt-bindings/clock/qcom,videocc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,videocc-sm8150.h
@@ -16,6 +16,10 @@
 
 /* VIDEO_CC Resets */
 #define VIDEO_CC_MVSC_CORE_CLK_BCR	0
+#define VIDEO_CC_INTERFACE_BCR		1
+#define VIDEO_CC_MVS0_BCR		2
+#define VIDEO_CC_MVS1_BCR		3
+#define VIDEO_CC_MVSC_BCR		4
 
 /* VIDEO_CC GDSCRs */
 #define VENUS_GDSC			0
-- 
2.25.1

