Return-Path: <linux-kernel+bounces-39576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60183D31E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820781C2472C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FBBE4E;
	Fri, 26 Jan 2024 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FQZ2jyqn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5EBE49;
	Fri, 26 Jan 2024 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241332; cv=none; b=Gt8i/9ZOozfhIOK6egNH8dBQ9SIFoacf+mje9oWRg6XK8obQ+YddLyidfhJwsrJTTVaML2D5PpUKqUVHJuyKJUI/uEolkVDGVMp0nu1o2cLy/aZMSPdTMNN6mqZw+3ihIi0pNEwczrXaenzacyY789vkQ8Leh5oUEv48sCQzaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241332; c=relaxed/simple;
	bh=Kk+y5hNnOiQ2qFggH/zRNiKdLX4XwYFzmrAqZbWNdE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p6wkreno5qS8JWm4EB9wRi6d3TYWCA0pL6+egyJEACmCHMeppPbxEqR8k0N+K9x1+fuoV7CHPO+CAXzH56jv9PHfhv6IDG8QaUirz5S4HI9U5apEOGf6zV0+uvXm5PVqgOKK80TPwsDK4GBqyaiUt70dnVwpP3gXTtGtaTLXTAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FQZ2jyqn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q0uWGk023947;
	Fri, 26 Jan 2024 03:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Cck/GJxSluI5ev4MbkCdy2c7VJsUu3P8mIgrgZQqg0o
	=; b=FQZ2jyqnH6QiChIcx1hgrlX3uZC2Kl4xmM/4TerUXvd4Y4mKDEsM4iSINFv
	6CBTRDiHbd/3v3hiOsb/H9/4f+9FDetcunv0zVl0146wxQH9VhjnOquoS08xB8ym
	jvrnGlI0X4oQC6j7ZY2zEdbQ911qFcdUCFza5oiS2+tWoa2OOby4qwt+0do0fo1v
	kV9cYGZ/O+6vnbKyVU2su/cDO63LamR4Jx2w7I/aYsUC7akGTiDyMyWrTekjdGs4
	sD4imc+zra+q0qFxcIoMRx8rVFZpgNIuTh5//e1whHJryG8tMod6WpITGfOsXBW1
	gpPsm2s8qyqOmx+R/uLI8u/wHJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuqra1xek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 03:55:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q3tH9G023435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 03:55:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 19:55:17 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 19:55:14 -0800
Subject: [PATCH 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
In-Reply-To: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706241316; l=1330;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Kk+y5hNnOiQ2qFggH/zRNiKdLX4XwYFzmrAqZbWNdE4=;
 b=XXT4ELI9bJf5JFfwnJVzWRjPWf/opRDOL12nu58PFDtuwjH3AZI9SKtQvEzhzxzkdqWkA9Fu6
 w5PjI8TexGKCCUz/IQmmsi0XRVCrjWOtx8ww5WL8+CISnVfZhjNoyWL
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RgVbnw65RNvrWLmkuNOf9f2ff1_gARDJ
X-Proofpoint-ORIG-GUID: RgVbnw65RNvrWLmkuNOf9f2ff1_gARDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260026

The failing read-test in __i2c_hid_core_probe() determines that there's
nothing connected at the documented address of the touchscreen.

Introduce the 5ms after-power and 200ms after-reset delays found in the
ACPI tables. Also wire up the reset-gpio, for good measure.

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index def3976bd5bb..d64d0e76c1ea 100644
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

-- 
2.25.1


