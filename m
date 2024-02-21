Return-Path: <linux-kernel+bounces-75642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8E85ECC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7055B1F23BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B112D77A;
	Wed, 21 Feb 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1lx0ezd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2E1272B2;
	Wed, 21 Feb 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557568; cv=none; b=YetQ+EL17lB7vBwh4nn8EalGg4yHGrA7rhQXS4h3NiLjHoZbksptVYmSFvlIf5tpaPFoH5hx7nm8ODQ+fcv8pG3lu3Df8MNrIpg/E878DBu/34IXSkSUCUKvZ0Ajtk152liqSG1rLs72f7x52LoEF3bXL6qIwGeAqO64eUWYzjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557568; c=relaxed/simple;
	bh=ijqglwDc8WiopNfqSSR9fe0J9bSen9wiW+HoJ1qLCKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c7Ozy8XqurMYesqLThcmjsp2Vf/uRTdLP34x2zo5nxO1djdI8qoxemkhVyuwOrR1k0nIE2jB7znG69LJ25w+Jf7uoIUpf6Uf/hP+W48U7r4fs0nNgGzwrwfbEGLIuTNwfji2DKi2q+L0vouRqx0QmvNSTbuBuCPKoKHegQ/cOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L1lx0ezd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LKviK4026736;
	Wed, 21 Feb 2024 23:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=D4LgidvEndL3vEKGD6CEujrHPjeSfHEBUouRKygfBfo
	=; b=L1lx0ezduSLpVxBjh58korma8Gmokij/j96oVdxOqvV2XFOZnyn5z+0+kuM
	a7vTdht7nWdHG19WNbg5X52byvm3b8FWy/mahbvG1ylTkKcFJWdI9iP+xReTVUD3
	H/BvbHeCls7z+IlHX7q4ipWCWxYkGjnjOkzIH8vSImczpxZp49xozPdZS6aqqlQl
	JiwRL4JymImY78b4UHnN2S9HL+7MgFCAw8pHN3/MxA4HJwPGqGrKjE1XG97RPmWQ
	OqtWx0yZE+a+WWP0cpyXdYShoyc9j+68ct+uCXLdxJeu454WP5/chj4uREVmB9yC
	blrCiy/u+N4mKDfkuI9D7fVXiGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdr8r892n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNJFuR020304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:15 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:19:15 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 21 Feb 2024 15:19:15 -0800
Subject: [PATCH 7/9] arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB
 redriver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240221-rb3gen2-dp-connector-v1-7-dc0964ef7d96@quicinc.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708557553; l=897;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=ijqglwDc8WiopNfqSSR9fe0J9bSen9wiW+HoJ1qLCKQ=;
 b=DPmSIcOOmbn+TMCAOQgjorGGuDX/M3jiG2Qw89PZbuv3P0LZaaBJKWt/+lAsUpiQiOQCm01iW
 vDElaoN/VArApuRE5vzH0MD4TUVBHKj3th+TkC1Q6W0T0nTYbB74vK8
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P-Q1vnuIKcqO7l0XarTJ3uZAsmLxQqpk
X-Proofpoint-GUID: P-Q1vnuIKcqO7l0XarTJ3uZAsmLxQqpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210183

The RB3gen2 has a USB redriver on APPS_I2C, enable the bus and introduce
the redriver. The plumbing with other components is kept separate for
clarity.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 079bf43b14cc..171ed979d55f 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -465,6 +465,20 @@ &gcc {
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


