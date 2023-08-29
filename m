Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9178C695
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjH2N7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjH2N7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:59:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9ADD7;
        Tue, 29 Aug 2023 06:59:13 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TC9ur6001349;
        Tue, 29 Aug 2023 13:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=+sqVmn9ndDXOtOS2zil6chnAI2vLNwnPdIa3pu3h6hk=;
 b=WgZDsabTccUPya36giHTumIozw27Qy6jTy6HcfpjI6YkTuoHSm2sxJJ53PlER7dZIx7a
 hhS42b6qMQyFwMB3TUCPO9PMMSsc0fYJjIZJFyVKbnnq1GfNUIIGVUx4yxSRRaLsFMKf
 26vNBHHMLJNz6tL0CXwzGun4RdZrzudSF5aBmhq/X2+elubvDIk/8WArLzoykQPnKXka
 QxwWNKsQwpx4+fTvLXV7478NyQWoA4c3eW8NBo5kMtHrhK5CNKh/u9hfblKzw/SPyaQO
 BkIJCCd4pxANU1rb1Evwwxg/+Tcvrr60DP55esgmN3WyQtNo+71j6EOI+w1o0Df9zWyq 0w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4g6hm6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:58:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDwbVO012042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:58:37 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 29 Aug 2023 06:58:29 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <quic_ipkumar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 0/9] Enable USB3 for IPQ5332
Date:   Tue, 29 Aug 2023 19:28:09 +0530
Message-ID: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b0sZeBPaa5Wb0IysTsxCneRbgo0TWAP5
X-Proofpoint-GUID: b0sZeBPaa5Wb0IysTsxCneRbgo0TWAP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=538 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 has UNIPHY for USB and PCIe which is similar to the UNIPHY
present in IPQ4019. Few extra settings like clock, reset delay, mux
selection and voltage regulator are required for IPQ5332. Hence
repurposed the IPQ4019 PHY driver for IPQ5332 UNIPHY. Few more Qualcomm
SoCs are also having the UNIPHY which can use the same driver for both
USB and PCIe PHY.

Praveenkumar I (9):
  dt-bindings: phy: qcom,uniphy: Rename ipq4019 usb PHY to UNIPHY
  phy: qcom: uniphy: Rename ipq4019 USB phy driver to UNIPHY driver
  phy: qcom: uniphy: Update UNIPHY driver to be a common driver
  dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS UNIPHY
  dt-bindings: usb: dwc3: Update IPQ5332 compatible
  arm64: dts: qcom: ipq5332: Add USB3 related nodes
  arm64: dts: qcom: ipq5332: Enable USB SS UNIPHY
  phy: qcom: uniphy: Add ipq5332 USB UNIPHY support
  arm64: defconfig: Enable UNIPHY driver

 .../devicetree/bindings/phy/qcom,uniphy.yaml  | 168 +++++++
 .../bindings/phy/qcom-usb-ipq4019-phy.yaml    |  52 --
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  20 +-
 MAINTAINERS                                   |   7 +-
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts   |   7 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  39 +-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/phy/qualcomm/Kconfig                  |   7 +-
 drivers/phy/qualcomm/Makefile                 |   2 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c   | 145 ------
 drivers/phy/qualcomm/phy-qcom-uniphy.c        | 451 ++++++++++++++++++
 11 files changed, 686 insertions(+), 213 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy.c

-- 
2.34.1

