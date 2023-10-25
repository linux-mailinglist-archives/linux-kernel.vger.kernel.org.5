Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A47D71D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjJYQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:42:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D66129;
        Wed, 25 Oct 2023 09:42:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PGRbPl015650;
        Wed, 25 Oct 2023 16:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=d8nKHq6vP32/G9WpFKcF9tbFdH3iYH/jlEEi4rxDT2E=;
 b=TaPqwyQTX88BfLlkBaCMzpM7LbxJGPRyH9aMKNCsoXIF1R9in88sZ4bt4hlBCg0HPAcV
 z07QAYOPhwbU8eIOIz9GayXqK9Fp5avDu2YF7XOv0iW82p5ZQNsLI+Xt5LVNwAvWxu7n
 Sc5NFd+04z6w6ZwzD2kOnAtnpDK0n+adJE8KUt6WlCmGLE+bfxQ+VWJgrZiy1VF3BauU
 BYGwYTcV/XXoYoe/HgFyvasEUvvtKaEgk5gjH0dGtK34Wtd2sxHVdXpCYyn4ndM8w4gQ
 RgrWR2QDf4jwQB+FVJT3g/T3u9w2ZTdLs7xGd77V6r84L4JBKvqSYOHWsnE8SNWEupC2 qQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txpj5hxm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 16:42:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PGgOeD013753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 16:42:24 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 09:42:20 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 25 Oct 2023 22:12:12 +0530
Subject: [PATCH] arm64: dts: qcom: ipq5018: add few more reserved memory
 regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231025-ipq5018-misc-v1-1-7d14fde97fe7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGNFOWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNT3cyCQlMDQwvd3MziZF0TQ5MkY6PU1BQLC0MloJaCotS0zAqwcdG
 xtbUA5Vu+SV4AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698252140; l=2054;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=EErLWDu3JbW/Wz5VJQSKT7cY8Rf7EtU84+KGyMh1Kgc=;
 b=kWAHfuFfR+M+Dm/WDRwRgRw48ObTWtcH8ZsUr379rasascYk0V+K6t8sIHEe5ZoTTa1irrsVe
 fMq1odBn54SD+USFlGjU7TuSl2E9mWeRWD83mWT8fvXPfTCiqKB1LfD
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1G8K5GUZUICZRWU-hzoSK54dYtcQi2ND
X-Proofpoint-GUID: 1G8K5GUZUICZRWU-hzoSK54dYtcQi2ND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=478 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like all other IPQ SoCs, bootloader will collect the system RAM contents
upon crash for the post morterm analysis. If we don't reserve the memory
region used by bootloader, obviously linux will consume it and upon next
boot on crash, bootloader will be loaded in the same region, which will
lead to loose some of the data, sometimes we may miss out critical
information. So lets reserve the region used by the bootloader.

Similarly SBL copies some data into the reserved region and it will be
used in the crash scenario. So reserve 1MB for SBL as well.

While at it, enable the SMEM support along with TCSR mutex.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 0b739077ed70..6fbdac7a73f5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -82,6 +82,24 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		bootloader@4a800000 {
+			reg = <0x0 0x4a800000 0x0 0x200000>;
+			no-map;
+		};
+
+		sbl@4aa00000 {
+			reg = <0x0 0x4aa00000 0x0 0x100000>;
+			no-map;
+		};
+
+		smem@4ab00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4ab00000 0x0 0x100000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
 		tz_region: tz@4ac00000 {
 			reg = <0x0 0x4ac00000 0x0 0x200000>;
 			no-map;
@@ -142,6 +160,12 @@ gcc: clock-controller@1800000 {
 			#power-domain-cells = <1>;
 		};
 
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x7804000 0x1000>;

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231025-ipq5018-misc-414b32eed881

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

