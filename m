Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF97B7BC8E9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjJGPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbjJGPtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:49:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BCBCA;
        Sat,  7 Oct 2023 08:49:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397FlgSI011667;
        Sat, 7 Oct 2023 15:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ru5jfmYWa9vHMjM+QOrIHJoVV6lz6+EGc5Ri10pd6sk=;
 b=WfO49cTeXsnXpnFBqKtpS+/IXpqbmLfzTrPvWn+F0EaR7OHarOWGbx8XAeiajlNw4Z++
 00CKyr2tcBOnp6SPPSonkPPs63gO9QVKzihVotjf1gwQ9dqmgaWb4NrWSINgHmBkplZ0
 3WISK0sKCecrfLZMT4zP62pQA7/u+aVlMrqxqcnVAHDCPJrLEKY82aBccO9fvk0+hZTq
 xIDFl4oSPdtVqZ4N8UEJwpWQ4BM9rUWQqBMva0KuNC3Syo/K/8a2yvQzwPrAqQpBQYPf
 401nLcjezcxldtgLhBVt3vxMkCd/Zdl492MaxtBs+rGH/9klpy/XA5PRkvxTYR2j1qG5 eA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjxx88yg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 15:49:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397FnV2I029276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 15:49:31 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 7 Oct 2023 08:49:25 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v13 10/10] arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb controller
Date:   Sat, 7 Oct 2023 21:18:06 +0530
Message-ID: <20231007154806.605-11-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007154806.605-1-quic_kriskura@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y-X6bI1sFiL9Y0vzY8sS68XNeUgKB9Sp
X-Proofpoint-ORIG-GUID: y-X6bI1sFiL9Y0vzY8sS68XNeUgKB9Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=925 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310070143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Halaney <ahalaney@redhat.com>

There is now support for the multiport USB controller this uses so
enable it.

The board only has a single port hooked up (despite it being wired up to
the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
which by default on boot is selected to mux properly. Grab the gpio
controlling that and ensure it stays in the right position so USB 2.0
continues to be routed from the external port to the SoC.

Co-developed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
[Krishna: Rebased on top of usb-next]
Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index b04f72ec097c..6904a4c201ff 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -503,6 +503,18 @@ &usb_2_qmpphy0 {
 	status = "okay";
 };
 
+&usb_2 {
+	pinctrl-0 = <&usb2_en_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	phy-names = "usb2-port0", "usb3-port0";
+	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
@@ -655,4 +667,13 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	usb2_en_state: usb2-en-state {
+		/* TS3USB221A USB2.0 mux select */
+		pins = "gpio24";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };
-- 
2.42.0

