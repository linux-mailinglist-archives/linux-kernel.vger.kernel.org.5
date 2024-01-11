Return-Path: <linux-kernel+bounces-23942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8582B43A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D09D1F2275F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C698652F60;
	Thu, 11 Jan 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m1DOegKp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410351C5E;
	Thu, 11 Jan 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B2nkJk012253;
	Thu, 11 Jan 2024 17:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:to:cc:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=rXpv7UpBmMgFq8OcLbEU
	aV3lBTiJi6g9qk41Zt53hGY=; b=m1DOegKpGWTVGzftQ4HR6D4jrciQYxZPDo+4
	4uelwzhwKKtKL5lB/lMKOgsNfsa9Fz8sBqXmrE2roVyF6ij18n3DUuFpW6GgKUpl
	SaoABHRTQLmcSJ0wIgCI/bTJrH/b9PjNZJ2ebkcKoETrYrzWSIdHbo08THkV4kx+
	BCsos992tmSUJ3Hafsg9eK0P+4OK32rIqDkTMBZky3eksIFjLpE5X7s2VmkhgYqw
	kmgXicJ4u9ogO4XZVhS2qKGeMcSswWFOUMN8ntn93vMTnLP8+OYOJ0ryLVlUZcWF
	3ppjtgQxhyTgsyYcCRh0eKfQ9dIE4uocNsqpzIPFnhS8vPJr7A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj7w221at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:39:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BHd1SQ018445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:39:01 GMT
Received: from [10.216.55.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 09:38:57 -0800
Message-ID: <413d612f-0e31-6281-64e3-6484b85afe06@quicinc.com>
Date: Thu, 11 Jan 2024 23:08:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Veerabhadrarao
 Badiganti" <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM"
	<linux-arm-msm@vger.kernel.org>
Subject: Proposal for QCOM PCIe switch power and configuration driver
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pWA4eBRACFwke8WxsHKijw-Dzf-RzMPf
X-Proofpoint-ORIG-GUID: pWA4eBRACFwke8WxsHKijw-Dzf-RzMPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110139

Hi DT maintainers,

We are trying to upstream the QCOM PCIe switch which has I2C interface
to configure the switch.

In generic a PCIe switch is a device that allows expansion of PCI
Express hierarchy, which allows more devices(PCIe endpoints) to be
connected to a single PCIe port.

We need to configure the QCOM switch like L0s, L1ss entry times, Tx
amplitudes etc.. through I2C interface before PCIe link is established
as these settings can affect link stability if we don't configure them.

Once PCIe switch is configured, PCIe link between the PCIe switch and
PCIe port connected should be established by the QCOM PCIe controller
driver to enumerate the PCIe endpoints connected to the PCIe switch.

We had a QCOM switch driver which powers on the switch and do the I2C
configurations.

This is how the flow goes.
-->Power on the switch
     -->Do Switch configuration (over i2c) with qcom switch driver
         -->PCIe link training and enumeration.

 From the the above requirements we want a I2C client driver which probes
first and power's on the switch and do switch configurations through
I2C, and then PCIe driver needs to probe and do the link training and
enumeration. And for suspend resume usecase also we need these probe
dependencies.

As we can't keep the probe dependencies between PCIe controller driver
and I2C client driver in the DT, we want to propose following solution.

Since the I2C driver need to configure the switch and power it on before
the PCIe driver attempts to probe the device, we thought of exposing a
reset controller from the I2C driver.

We came up with this reset controller idea because the I2C driver
essentially has to configure the switch and power on the device, then
only the PCIe driver has to probe the switch. This aligns with how reset
controller operates in general.

This is how sample DT looks like

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi 
b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 2ff549f4dc7a..222206902305 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -414,6 +414,18 @@ &lpass_va_macro {
         vdd-micb-supply = <&vreg_bob>;
  };

+&i2c0 {
+       clock-frequency = <100000>;
+       status = "okay";
+
+       pcie_switch: pcie-switch@77 {
+               compatible = "qcom,switch-i2c";
+               reg = <0x77>;
+               vdda-supply = <&pcie_switch_rest_vreg>;
+               status = "okay";
+       };
+};
+
  &pcie1 {
         status = "okay";
         perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
@@ -422,6 +434,10 @@ &pcie1 {

         pinctrl-names = "default";
         pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
+
+       resets = <&gcc GCC_PCIE_1_BCR>,
+                <&pcie_switch 0>;
+       reset-names = "pci","device";
  };

Can you please tell us whether this approach is acceptable or not?
we are open for any other suggestions also.

Thanks & Regards,
Krishna Chaitanya.

