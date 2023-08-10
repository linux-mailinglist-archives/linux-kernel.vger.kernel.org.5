Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E9777511
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjHJJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjHJJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:57:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135082684;
        Thu, 10 Aug 2023 02:57:15 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A86utO017063;
        Thu, 10 Aug 2023 09:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qs9N8rfFTVwVbHCl3QcliIEoiN2bxMMKsoxhS6BMiLo=;
 b=UH59NrWucHbXvn35iGG5Wr9gdH+lxm3lomO9OX6vhML1H4Ju52RYrVnUmsqKHSI5leIg
 E5z/NXShUFSsDhG05RIFexYL5R0JgzNnZAFxNcxDkmMGkR4wU2oCKfU5UeQlPXCYeh27
 bYU8fXVi9rbYdtUxOd1Vuyzx7WOXZZsQbb2kjH1nR1bQPOC4NLdBlwaYCi6x4jWLoaqQ
 DqMS+Ih3spxeMiJozES0d+5A5ErStGICKUQYWLtYlrJlkpknuBjHOySgM3XsNw5mKQ9e
 zr34+vmBQ/dh4BebXqP4IwmcXQiYO5HcjZb0qCVfcVOO+VbDaG65AdvQvkZ5bVXJS4wX CA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scsty0fpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A9unIk019181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:49 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 10 Aug 2023 02:56:42 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 4/5] arm64: dts: qcom: ipq5332: Enable USB
Date:   Thu, 10 Aug 2023 15:26:07 +0530
Message-ID: <02317e86c1c8838e66a852b3576988719df8028e.1691660905.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1691660905.git.quic_varada@quicinc.com>
References: <cover.1691660905.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: btCA9ZfKmqO4QBfex235ZIF2smhd9BsG
X-Proofpoint-GUID: btCA9ZfKmqO4QBfex235ZIF2smhd9BsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_09,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=638 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB2 in host mode.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6:
	Add vdd-supply and corresponding regulator
v1:
	Enable usb-phy node
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
index f96b0c8..b4099a2f 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
@@ -12,6 +12,15 @@
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.6";
 	compatible = "qcom,ipq5332-ap-mi01.6", "qcom,ipq5332";
+
+	regulator_fixed_5p0: s0500 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <500000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-name = "fixed_5p0";
+	};
 };
 
 &blsp1_spi0 {
@@ -79,3 +88,17 @@
 		bias-pull-up;
 	};
 };
+
+&usbphy0 {
+	vdd-supply = <&regulator_fixed_5p0>;
+
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb2_0_dwc {
+	dr_mode = "host";
+};
-- 
2.7.4

