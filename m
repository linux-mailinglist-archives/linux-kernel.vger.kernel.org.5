Return-Path: <linux-kernel+bounces-120196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B028D88D44A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C21E1F36E87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108321105;
	Wed, 27 Mar 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A1zdoEob"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D61F60A;
	Wed, 27 Mar 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505086; cv=none; b=C8Ih7zRuTPmCYtjYCsptrx8Zr1p58OiRMi8kH4CSLlERXn8AK4xS+MvLLz2UXszvCjL42eQ5eEJla+HA8RPPT2iejhTQHYdQUOWkCSVysRAvhTcG8iCjRNil9FX1ygBAZAjaxml4+fIzAfpxX5Hfr1ygkn6ECgN2qhoi9VTWNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505086; c=relaxed/simple;
	bh=2q3XmdhCrp5V0Qh058jRSaSu37Y4N5p7jL1h2CErt+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iA50FtvbhCyVsbgDG+aLI4rqXgRxg1EC/5JB5Ovtxsfsdi6EEhyVZyfwWTFieWi4ncMMqcblfb4jqhnCK0+o8hnVdpo1no+IoUaI4p7gRbVHcnNl7d1oxW6NVNjY3aovcq74rqTjSw+YS4EQQkRPbDTwFcWimPY6JVuk4q1fS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A1zdoEob; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R1o4aW032726;
	Wed, 27 Mar 2024 02:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=AYiI7olk1kWz4JEe8So4zIwLR4wK6tGFf5eCXaa6pYI
	=; b=A1zdoEob3UejTrceCUBX/tyJlKO5TyKdZM10CNNjPk+uJdSX4D5+ji3Q7Ay
	SHyejo3Jf6FL3zxmieJzVVwTwfIojKQFsL/vZZrRcWMriV8Hml5THMLbVHat7geK
	aNt28wQy9u6bGtKQWhDu4vF8+JDX0FtI8uzKyY4d9+HoL0uyUWuduWShcNyORXnZ
	7R3OP5DWCDty12fGHrfwvfJV50J0i8pSe8IhcBWWxBzPx6MWQk8e/Yxgl0U961dN
	0s2GI++O9BEGl6W7MksfMzTzXJvzKoHulXfQDoVDEoNSP8pvsn3XTy0XgOulBRMF
	L/KsLHN1vfPCIC5CreR2iND1iNg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4780gbw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24UHa030762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:30 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 19:04:21 -0700
Subject: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB
 redriver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-dp-connector-v2-4-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=958;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=2q3XmdhCrp5V0Qh058jRSaSu37Y4N5p7jL1h2CErt+Q=;
 b=IMY0mnWRcbRU/mm9djEMzMkf672fYfNSC5lkOG2ZaPrEzcxB7w/fBuHRUYsykJ2zRWWQsVYav
 Cmk6s0p+l2SD63OVh3y0NsuGCVA2ijKTOWSg0KvLIRr8IPVn3UrFkcV
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iw_8KntqAIAt5MrWcYno1sgPcL_Qr3Rh
X-Proofpoint-ORIG-GUID: iw_8KntqAIAt5MrWcYno1sgPcL_Qr3Rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=998 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403270012

The RB3gen2 has a USB redriver on APPS_I2C, enable the bus and introduce
the redriver. The plumbing with other components is kept separate for
clarity.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5b267a94a282..2f94b1b865e7 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -485,6 +485,20 @@ &gcc {
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&i2c1 {
+	status = "okay";
+
+	typec-mux@1c {
+		compatible = "onnn,nb7vpq904m";
+		reg = <0x1c>;
+
+		vcc-supply = <&vreg_l18b_1p8>;
+
+		retimer-switch;
+		orientation-switch;
+	};
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.25.1


