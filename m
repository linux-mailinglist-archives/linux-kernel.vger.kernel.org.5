Return-Path: <linux-kernel+bounces-43139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D2840C32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197A528526A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F21586C5;
	Mon, 29 Jan 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hJtT3U7I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8D157042;
	Mon, 29 Jan 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546883; cv=none; b=DuN6H5FANP9IQzmOYMf1/G+cZebX5ukMnC1KXyBN3HcshBH/1LQULqoJcLQYxcMZvrvZiSp/8rpeLmGyldZGGiO+agLiwo7yEq0fqiWj1W/+BnVtmQg1nvxqRbJ9iNsg1ARJcGhjqOxAI/OOcqmsK1S+K9xXKinBGQJ9KIpgaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546883; c=relaxed/simple;
	bh=g00yfl+DH1PKAIhHjXI5WM7KPvf1gOq1U0BZdBe3hL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dQqcNYEqZCQNyKkJj3oIv5C2xYp9jr0csbRl/vmlPTAPxY6T9vga6PYDHl8KDJulkR7kCbWSrbkeBjRe+2XwH8403klz7N3oJpNuAs5cW9Kcpb0Ulaj2n04saamO8aXRHBI9ybQcqSwFlJ2shAjZ2gHIw5WinBwt5dH9jIc+N7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hJtT3U7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TFGE0W022275;
	Mon, 29 Jan 2024 16:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=1mIWBEQ6I23iUlEuFHefHGRm8rrhe7cwzgQMQ0yrhek
	=; b=hJtT3U7ILfuI5oI6Z6TjEId1TmaiCho8XN/Zit+oowMisR5f22NQzNXbFPb
	NXunzgScWkZ4dOgFwpIqwyfkPvOiVemDyg3gB5jf+KvjNCY0Yiv3fwARN8xZa76f
	vJXw4yctB77duzBaaUbdE61P4PX9MIxunDO9YHRDYKhWLBVreC572Vult7J3LJkv
	ASg3M5/Ud9eNe6Y4ZkTvcbMTAvwSP2z6lxWvpxte71VKWar8HfcaMiG/YvTog23g
	BKDzn1B8N7eoVh18yHva63yJiKiRf8A8dQs6Cpt30RXl9XgANtpnsr1S0/5JmEQ8
	HLmdf+O2B1Ljkug33Bw0ShzgDqQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxcva0ka1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:47:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TGlmT6016571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 16:47:48 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 08:47:48 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Mon, 29 Jan 2024 08:47:48 -0800
Subject: [PATCH v3 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240129-x13s-touchscreen-v3-2-c4a933034145@quicinc.com>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
In-Reply-To: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina
	<jikos@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706546867; l=2463;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=g00yfl+DH1PKAIhHjXI5WM7KPvf1gOq1U0BZdBe3hL8=;
 b=EOvZZXYktDen8bCHavy3UmspUhexUqjoxc2j6BMlA6sDPH/3gG8tqL1zMbp6ZbmzTbf0PNHYN
 qJgV7CrlARMDtv7C3QyV0/zulaRi8ZYIMlf3iwY4oDOotMUYixHzC67
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VDQlIuiBCYbKjJg_QcyRTiUPRWLyTxTn
X-Proofpoint-GUID: VDQlIuiBCYbKjJg_QcyRTiUPRWLyTxTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401290124

The touchscreen present on some SKUs of Lenovo Thinkpad X13s is never
detected by Linux. Power is applied and the device is brought out of
reset using the pinconfig in DeviceTree, but the read-test in
__i2c_hid_core_probe() fails to access the device, which result in probe
being aborted.

Some users have reported success after rebinding the device.

Looking to the ACPI tables, there's a 5ms after-power and a 200ms
after-reset delay. The power-supply is shared with other components, so
this is active all the way through boot. The reset GPIO, on the other
hand, is low (reset asserted) at boot, so this is first deasserted by
the implicit application of the pinconf state.

This means the time between reset deassert and __i2c_hid_core_probe() is
significantly below the value documented in the ACPI tables.

As the I2C HID binding and driver support specifying a reset gpio,
replace the pinconf-based scheme to pull the device out of reset. Then
specify the after-reset time.

The shared power rail is currently always on, but in case this ever
change, the after-power delay is added as well, to not violate the
power-on to reset-deassert timing requirement.

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index def3976bd5bb..33731b95ad51 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -620,7 +620,6 @@ &i2c4 {
 
 	status = "okay";
 
-	/* FIXME: verify */
 	touchscreen@10 {
 		compatible = "hid-over-i2c";
 		reg = <0x10>;
@@ -630,6 +629,11 @@ touchscreen@10 {
 		vdd-supply = <&vreg_misc_3p3>;
 		vddl-supply = <&vreg_s10b>;
 
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+		post-power-on-delay-ms = <5>;
+		post-reset-deassert-delay-ms = <200>;
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts0_default>;
 	};
@@ -1450,7 +1454,6 @@ int-n-pins {
 		reset-n-pins {
 			pins = "gpio99";
 			function = "gpio";
-			output-high;
 			drive-strength = <16>;
 		};
 	};

-- 
2.25.1


