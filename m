Return-Path: <linux-kernel+bounces-39278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC183CE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2829A9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7813B787;
	Thu, 25 Jan 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ud0xfDpj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5521386C9;
	Thu, 25 Jan 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216722; cv=none; b=nxLvft5CZAmTC2X8M84HKaG9o6qzSagzBYQgVfai54wo0FaviOwttAnNXMfbIun296D4Wl5CIUzYa8i/tE723vO+yKKhJeqScZtfRtMs708hYdaXX4p5XfrPRDv9+9gbVjkg/gzBMTv5ohR9wOE+yDSE1NEc3cXoBzRyys6YPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216722; c=relaxed/simple;
	bh=Nl9b9TRKAUzcyVeNR/dhN73aiBlrX2553FEf70SUp2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jECwaeteoaEIntQJYTdK5Bm5nGAIIZHKE1tb0oPNHNox5zWuDLMuSuvM8ky3BBw5ovOhglGx78W4cp2R6up7aZaSfMolLvB8KlgTHBOMifUcVKhgW1F6FIxEklqjOmajhzBuTHoTrgjTnEjZ80orqysnYD8WwxxK0Uam17tON7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ud0xfDpj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PJUF8G031292;
	Thu, 25 Jan 2024 21:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=TOnkT3GPqAZyv4K107NWfhQ6gHvUulqo+58RTD/8Iho
	=; b=Ud0xfDpjdoAucY8Q+mZrEbNUml0G0i5y2i+dB+fzvrElT0v3e2y6f8hieFk
	cbll0dpQw4MzBipLQBQhQ3lQMgJgz69KlHVwocP7MWpNR5069DVPzS9oqZRlriv3
	oSXyBViCnqveXcbtPtgX9iXQC76F7KAMc/0zBCtDyra5CDmuwj80LPC+bADFkVkK
	9gAwypNdcchdnXMppxGdWPoyAReXvjS8L6Gl5tuThFLpQHh9ykeaDxJs9DabLB8x
	PB73JUk/+3xHijcLBP0PAZtR6EgvPg6uW6lIYOnMHzxdDCwI+0PsH15U9YFzeg93
	EykT39RaEFsLGnk6rpZ4f5bcliQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vup2thnfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5DN4027232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:13 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:13 -0800
Subject: [PATCH v4 7/8] arm64: dts: qcom: sa8295p-adp: Enable GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-7-7011c2a63037@quicinc.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=1267;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Nl9b9TRKAUzcyVeNR/dhN73aiBlrX2553FEf70SUp2E=;
 b=BSGLgx/0vlC09nLOEhrMfV9nSIdfOGLsMiMkEaeZZTAZ07Lm1GCmhe52fCD4kjYnV8A0/fFY7
 Nnjbk5wXFFaAJG9DTCDYTm04StrI2rvpQBJhqC7/V94/yYh3UEXGqm2
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b9sfyQeWepVhTjjxlRRN102tlQ6-nqDS
X-Proofpoint-ORIG-GUID: b9sfyQeWepVhTjjxlRRN102tlQ6-nqDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=871 phishscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401250151

With the necessary support in place for supplying VDD_GFX from the
MAX20411 regulator, enable the GPU clock controller, GMU, Adreno SMMU
and the GPU on the SA8295P ADP.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index bd0962f39fc5..78e933c42c31 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -108,6 +108,13 @@ edp3_connector_in: endpoint {
 			};
 		};
 	};
+
+	reserved-memory {
+		gpu_mem: gpu-mem@8bf00000 {
+			reg = <0 0x8bf00000 0 0x2000>;
+			no-map;
+		};
+	};
 };
 
 &apps_rsc {
@@ -286,6 +293,28 @@ vdd_gfx: regulator@39 {
 	};
 };
 
+&gpucc {
+	vdd-gfx-supply = <&vdd_gfx>;
+	status = "okay";
+};
+
+&gmu {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sa8295p/a690_zap.mbn";
+	};
+};
+
+&gpu_smmu {
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.25.1


