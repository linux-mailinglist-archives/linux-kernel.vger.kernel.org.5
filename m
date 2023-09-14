Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268FE79FC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbjINHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjINHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:01:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34BE59;
        Thu, 14 Sep 2023 00:01:16 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E5wHG7000988;
        Thu, 14 Sep 2023 07:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Dg8yePeMXk6SuL/s9wPiXmMtqd5f1HuB1ZPVH7RbQWg=;
 b=LYNV/KuqJ1U/r1r1OCLWdmNz39h7DbQJF4V1bOdWxYFtJmQG3PBcs4MP9oPrdvLaFaqT
 4v2xRAiEpGtRKqQcGWg41PTUD7Vii1OXfHmLpPjTxSE3zq4zW692sKC9ajO6HQ8LpqfI
 aaMtmTNsDX4ODKCaMgT5ztyWrf1ItR1o6x0d0FBQUIlVyWLSDZDOuvo9l8FKm0QlhJ8a
 oyIdneT4CXJ0y3UnXB/Bg0tgVlB/eXZYa9Mnglz9fVFqZy4OO8UIU7nJdhRccN8Osh2u
 IR2mZd6a0KEbtTiCtyVLjiRBoKPZTb4uWCtXxdSWuWV3RvA3irDH7bWgrkDkK+mUYZrJ dA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ar3jmwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:01:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E712na023370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:01:02 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 00:00:57 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Thu, 14 Sep 2023 12:29:58 +0530
Subject: [PATCH v2 08/11] arm64: dts: qcom: ipq8074: include the GPLL0 as
 clock provider for mailbox
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230913-gpll_cleanup-v2-8-c8ceb1a37680@quicinc.com>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
In-Reply-To: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694674810; l=1255;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=1ug/sW+kzuMORC21mgnQOlnFEwUOksulPA68xrrHMRg=;
 b=G8S+bURsKhd4b3okT0iuutbUpLpoPigwAAzr1aK669ErDT/RX8ZBAcoQJddUb19yHbF6l8ua2
 aOIrpsQf8gzCW8PQ9lp3hQ2KNRTns9YiqrTCOTHyYhkkWp7GD/MUKB2
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hWmykwGiHMv2sAQezU959x2G9BRfJnBS
X-Proofpoint-ORIG-GUID: hWmykwGiHMv2sAQezU959x2G9BRfJnBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=845
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=2 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel is booting up, APSS PLL will be running at 800MHz with
GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
configured to the rate based on the opp table and the source also will
be changed to APSS_PLL_EARLY. So allow the mailbox to consume the GPLL0,
with this inclusion, CPU Freq correctly reports that CPU is running at
800MHz rather than 24MHz.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Splitted the change into target specific file
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 00ed71936b47..0be19267bdcf 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -719,8 +719,8 @@ apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq8074-apcs-apps-global",
 				     "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0b111000 0x1000>;
-			clocks = <&a53pll>, <&xo>;
-			clock-names = "pll", "xo";
+			clocks = <&a53pll>, <&xo>, <&gcc GPLL0>;
+			clock-names = "pll", "xo", "gpll0";
 
 			#clock-cells = <1>;
 			#mbox-cells = <1>;

-- 
2.34.1

