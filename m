Return-Path: <linux-kernel+bounces-40363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E583DF05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286AB1F262C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E11EB3C;
	Fri, 26 Jan 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SRKz1RiW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD21DFEC;
	Fri, 26 Jan 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287314; cv=none; b=qj2WHp7zy15Woe/6KVaKloJq9ktF9HjKMfUBg7NR+GfUCIO60kpf3jNCL32b8Tp5bHgmOhX23RkXeRwuUB5yHbYYgNDv+NPKgzHK1kPXixbKQp/HnmqWswptOhrKRwMUfpRA5wwBy8FXLRVQhzEvb7H+jX8xzsRNahWgKykRdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287314; c=relaxed/simple;
	bh=9wrWS5+nAeBPi2a8R9d2fHJwKwhx8d4m0xQeKrBuHb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lP4TjOfPUZgeLCa7Zn82Vxw4NB09ayPkkBO2Hp3zC9/UOddTcvXw8ya/ejiDsfYI/XMf+Am+OCF+7IxJzn3JeFL7vnFwpsJsq8hqiAeEvowgsD4SSsK0vP2G/gswmE32TWqc6S6e6Ktp/jPnelDbY8bt0liZJcqgVRLdJQ3ujAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SRKz1RiW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QE0DQh002236;
	Fri, 26 Jan 2024 16:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=1eXKvAVVPRF6khDnSxpGB2gqMCXAzT0bIxUd6e655Es
	=; b=SRKz1RiW5UinIcerHxvTCMUXpEOhh1+dsrW+qtSzPDxWu11xWN2vRQR0ewP
	xXEEYBoBT1UCELwP52E89OwRbfoqe7IotTtxHkVpn4HGbW3F95GaWGAkmDoX7RST
	C6yspRKySP6jA6IV2tGtqlq7PSRfC0wYH0B2ewZLmoNfiuRgxr5qzSC5UzSvamX3
	AMGyAuysY0kBjrg2X26A10aBW+5o9Di7XXMtClbx3bhsnTRYQCQ2VaDlnfdz2+8c
	ZgvUgFqfrZtF52ouIJDTQGAOm0qaiJqCGwl2Cnf9IbxywGgOklmj453OAwRIWHWm
	8GM3R0vLQXy2lwBh03LHcHIUe/Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4f9hkyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:41:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QGffPq027479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:41:41 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 08:41:41 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 26 Jan 2024 08:41:39 -0800
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240126-x13s-touchscreen-v2-2-5374ccc9e10d@quicinc.com>
References: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
In-Reply-To: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706287300; l=1549;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=9wrWS5+nAeBPi2a8R9d2fHJwKwhx8d4m0xQeKrBuHb8=;
 b=qc1obTJvuXDDoFCNXg7IQoTkuhbVjgSRksqJodnu8XcyVR98XwCHJtxYG7OTXCIsncz+g9u8m
 tkMXrCQUVbqCHhJo/ySId8SGzGacTVDLdU7pcNgrTFi330fFI7IEXEq
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3OldgpkjdqRsh2iAIu9AYcZerGAf2PpJ
X-Proofpoint-GUID: 3OldgpkjdqRsh2iAIu9AYcZerGAf2PpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260123

The failing read-test in __i2c_hid_core_probe() determines that there's
nothing connected at the documented address of the touchscreen.

Introduce the 5ms after-power and 200ms after-reset delays found in the
ACPI tables. Also wire up the reset-gpio, for good measure.

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


