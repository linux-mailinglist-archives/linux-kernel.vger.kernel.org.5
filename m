Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9623278B20C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjH1NdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjH1Nce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:32:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48718D;
        Mon, 28 Aug 2023 06:32:28 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SBRt21021856;
        Mon, 28 Aug 2023 13:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Y0ayW8WEjPSLgxGdaTnQfXuDQNueBAnSTw7btlG1/bE=;
 b=ElHzj91wkXrKEo22DrrC7HQgOyxB0R2mQyJiHO1mJ03bSSOcbbdiwjaNloQNLk/b7UzB
 InCqxtZQXmYQY8fT9FwPIOycty7FGq74wajE4Y9sOMmBrUYFMkqaAGL1veBqPjRyVsyA
 4cZjHffVhltsP7Ek+3ng40/kR8rkt9IKdPrLDU31YVdo14OH27xoyqZg8hkfMiAl1tkz
 eMvcUl1VW0aNhO5NGeWkHSYb0DlgmcaaA6arMymu286lfktysJUlvmHkzLNPvKViuLNo
 Edqgflr2GRIxk+X9Fvoy5ENlgyo50UbQPYrcRmA3IyIKEfPId15nCga1xxE1OpvNdRL6 GQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqa5pumfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:32:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDWFI2014549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:32:15 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 06:32:09 -0700
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
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v11 13/13] arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb controller
Date:   Mon, 28 Aug 2023 19:00:33 +0530
Message-ID: <20230828133033.11988-14-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230828133033.11988-1-quic_kriskura@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W-w6UTmZlc6NJHFTz_6hA9p7Ppo9IdpN
X-Proofpoint-GUID: W-w6UTmZlc6NJHFTz_6hA9p7Ppo9IdpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_10,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=953 lowpriorityscore=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280118
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
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 5a26974dcf8f..69f6b13e6197 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -488,6 +488,19 @@ &usb_2_qmpphy0 {
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
+	dr_mode = "host";
+	phy-names = "usb2-port0", "usb3-port0";
+	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
@@ -640,4 +653,13 @@ wake-pins {
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
2.40.0

