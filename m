Return-Path: <linux-kernel+bounces-7822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9781ADBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB91C22C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51EC2C6;
	Thu, 21 Dec 2023 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hwtfozIn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BD63D5;
	Thu, 21 Dec 2023 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL31Ugn012423;
	Thu, 21 Dec 2023 03:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=s9b4MZ8weiSojT
	IfRsZ5Ycdt8rZB3bdGHp5md8HL4w4=; b=hwtfozInE/3ng8fy04SVKlnCAxiFCQ
	adFa+K6p0X1VsY7Iur6e3jjls6S+9emnJmucKpHbtxqroBHiSUGX/BfyIUjZns6Z
	HphSq7Sxuz8HsBtvrNz000VsX9aRAUDrGCvTnuGfP50c5xh9R381sSbO4xxFAw6r
	JLBm/HEGCCj10cjytVqjWEhWkPdBWpAJm8D8zgSfgawk9F053vL/e3dZ+5KCL6Gk
	L6o6J+VXHyPB5GPHLEuN6UrfWFLq2atePdNFpST8a2g46zgB2u4VORBkZM60PI6s
	1u6IcSrEdAUTKG9dagDAEmNfwWWP9nmOtxhloEJKZktpQ+H/tGqmeliw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3wt9tjaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL3on9G004593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 19:50:49 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 0/8] arm64: dts: qcom: sa8295p: Enable GPU
Date: Wed, 20 Dec 2023 19:50:34 -0800
Message-ID: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAq2g2UC/x2NQQqEMAwAvyI5b8CmW9j1K7KHWqMGpFsaFEH8u
 8HjDAxzgnIVVuiaEyrvovLPBu7VQFpinhllNAZqyTuiFjV+6BsKzmXD4FKY/Nuz5wRWDFEZhxp
 zWqzJ27qaLJUnOZ5F/7uuG8pwJsZyAAAA
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
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703130649; l=1636;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=FiZgkZfXSovh7vIjDrL3sD8wd3dejO0nieX2YoLE65U=;
 b=C0OfEAnCzRC0wPMuHy5id+exPNU9XxOmfFL/T+44tZ9a9yVzzjrrZhETzzTc3PYc27yiiU8ygtGN
 g+v6ZbAIBIQjF/kD220breLrdza58X3ftqmd7VlAFCr861mqG0O9
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5xBJz-S5nOWnNOgV6lUjZuxHvnI6wXiB
X-Proofpoint-GUID: 5xBJz-S5nOWnNOgV6lUjZuxHvnI6wXiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=635
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210026

Due to the different PMIC configuration found in the SA8295P platform,
compared to SC8280XP, the VDD_GFX pads are supplied by an dedicated
MAX20411 LDO.

Support for expressing the regulator supply is added to the binding, the
support for enabling the parent supply for GX is added, the missing
gfx.lvl power-domain is dropped, and the DeviceTree is wired up to
enable the GPU in this configuration.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (8):
      dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
      clk: qcom: gdsc: Enable supply reglator in GPU GX handler
      clk: qcom: gpucc-sc8280xp: Add external supply for GX gdsc
      soc: qcom: rpmhpd: Drop SA8540P gfx.lvl
      arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
      arm64: dts: qcom: sa8295p-adp: add max20411
      arm64: dts: qcom: sa8295p-adp: Enable GPU
      arm64: defconfig: Enable MAX20411 regulator driver

 .../devicetree/bindings/clock/qcom,gpucc.yaml      |  3 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |  2 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/qcom/gdsc.c                            |  8 ++-
 drivers/clk/qcom/gpucc-sc8280xp.c                  |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  1 -
 7 files changed, 83 insertions(+), 2 deletions(-)
---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20231220-sa8295p-gpu-51c5f343e3ec

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


