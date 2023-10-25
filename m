Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCB7D6E35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjJYNu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjJYNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:50:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3909B18D;
        Wed, 25 Oct 2023 06:50:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDRh49002577;
        Wed, 25 Oct 2023 13:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=7cJQQLgfNtag3CM9m5goRoDk2o6+kMRbdE7ZcxpFZb0=;
 b=YZcOdSv8QjYLm5si2grmZ/Xc9RX+H9veGLRWjYYTGj2zV6bGOnXvV5mKBLcGlowSNBRP
 +TEBhZ9sfuWmUtIQHaorBrtYr7u5h1+04npJeL+hsIQww09drFUZ1fi91cPsYaVtFUWP
 MH/ckSk3zPQ0m+G4/dF2rCPN3PqjQ++AK5gMEaZ9g/4keRSTHVRRHIHTlKRjwvDDcObs
 9ZIcnH59l++NgwYyI/8Mu4wAQxg56+zu7G0710Nhkt6rrK9uyFsijQeswdHC8yKm3Nct
 tt5lX1daZx/vK1KVw4dMhdUIwdpBb2w2sNfXMrcUvjKqS4u6mcoDPWgKs01ywtILucf3 BQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txuj7h09h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:50:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PDoGrf031530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:50:16 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 06:50:13 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 25 Oct 2023 19:20:05 +0530
Subject: [PATCH] arm64: dts: qcom: ipq5332: add missing properties to the
 GPIO LED node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231025-ipq5332-gpio-led-v1-1-0f0f52617648@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAwdOWUC/x3MQQqAIBBA0avIrBvQESm6SrQonWog0hQiiO6et
 HyL/x8onIUL9OqBzJcUiUeFaRT4bTpWRgnVQJqs0eRQ0umsJVyTRNw5oA/GtdyZ0M4aapYyL3L
 /y2F83w9PyHX+YgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698241813; l=1154;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=UywHMnpVYZIWimRYi5B9NXhvzfdxufXWwJsRbxvul7g=;
 b=3Y8EUIQ8t37PcXcABwRT8FbIbx5eVw5QmEkXCCe0M6e59NKpeHm4lDL8QdCif6AiX5zcqtDjE
 BNweoW68wx7B5zPJVUEOIIc4ilXlL/mprBMxnplDy52d0JRie43UZaj
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8i6CMffMReeyQs8Ot7YjpihFjUZQ6xB0
X-Proofpoint-GUID: 8i6CMffMReeyQs8Ot7YjpihFjUZQ6xB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=692
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the color and function property to the GPIO LED node, which are
missed out in the initial submission.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
index 4870cdb764d0..b37ae7749083 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
@@ -9,6 +9,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include "ipq5332.dtsi"
 
 / {
@@ -39,6 +40,8 @@ leds {
 		pinctrl-names = "default";
 
 		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
 			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tx";
 			default-state = "off";

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231025-ipq5332-gpio-led-cd157e81d7b0

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

