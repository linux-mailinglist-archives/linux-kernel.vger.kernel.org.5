Return-Path: <linux-kernel+bounces-9326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A181C41A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3648B1C227CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123226FD9;
	Fri, 22 Dec 2023 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LKhr8/H8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63D23D0;
	Fri, 22 Dec 2023 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM4TRwH017770;
	Fri, 22 Dec 2023 04:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=Qbin1MDWtgD2Z6
	BNw6dsvWzgNMGrWXH3a2K1bEuyIsI=; b=LKhr8/H8rLoTlEiFzDEa5Wp+0oXVPj
	8fcY7zgql77JHNgOHLVN+fuzf5iMYWnr4d9N+BtXLjOCRmCv+39PXGzMji4nGwOf
	XLyvMVWolzW0+ekP6tnRhlwI00pOG0nOiAEFAaz+Ftc8u6pwkZQy05yymA/l8ln5
	mnsZ5vIpdtrAb2C6yNUtj3gj6gLOLAa68POaBrgsfvn7gFaI20tD6Ap7XtvkHSQQ
	G9k3+pC/UzXgc8O+ZmQAyMCm3uuhlgiq31uEzXn3/pTJwretFP2ZT0WAav9Uo7EB
	4fC/c18WsnhRCB4sppSjtS7erd6qyvpWj5jLDUWTV1SfdTZ5yqUjTcvw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4tue944m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM4dOw8020639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 20:39:23 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v2 0/8] arm64: dts: qcom: sa8295p: Enable GPU
Date: Thu, 21 Dec 2023 20:39:21 -0800
Message-ID: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPoShWUC/22NQQ6CMBBFr0K6toZObQBX3sOwKMMUJsFSWyEaw
 t2trF2+l/z/NpEoMiVxLTYRaeXEs88Ap0LgaP1AkvvMAkrQCqCUydbQmCCHsEij0Dh90aQJRV5
 0NpHsovU45o1fpinLEMnx+0jc28wjp9ccP0dxVT/7/3xVspR9jb0DMJVrqttzYWSPZ5wfot33/
 QvNFOrPvQAAAA==
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
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703219963; l=2019;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=6XXhKGY3qCr9TRqoSU1IuAhN+jJnCQfdDEIh/8dtY7o=;
 b=Shlow2GSYupq659NMQndbaHupO+v8joPkZ9l77lALfbgCYmjjPxjLcanMkXqQRzHg8Hgzkj3NLnO
 S4wifrb8Bb8A6X0AS+eRhp+gOWB0Yx/34PLcu2th6jKsx128mM9V
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6dVZo-OyXNljnol6Q8f5UdTem9qFd9Vi
X-Proofpoint-ORIG-GUID: 6dVZo-OyXNljnol6Q8f5UdTem9qFd9Vi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=735 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220029

Due to the different PMIC configuration found in the SA8295P platform,
compared to SC8280XP, the VDD_GFX pads are supplied by an dedicated
MAX20411 LDO.

Support for expressing the regulator supply is added to the binding, the
support for enabling the parent supply for GX is added, the missing
gfx.lvl power-domain is dropped, and the DeviceTree is wired up to
enable the GPU in this configuration.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v2:
- Made gpucc binding accept either power-domain or vdd-gfx-supply
- Updated comment in gdsc_gx_do_nothing_enable()
- Added a comment for the /delete-property/ power-domains
- Fixed node and property sort order in dts
- Switched zap firmware to use mbn file
- Link to v1: https://lore.kernel.org/r/20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com

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

 .../devicetree/bindings/clock/qcom,gpucc.yaml      | 16 +++++
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |  3 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/qcom/gdsc.c                            | 12 +++-
 drivers/clk/qcom/gpucc-sc8280xp.c                  |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  1 -
 7 files changed, 100 insertions(+), 3 deletions(-)
---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20231220-sa8295p-gpu-51c5f343e3ec

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


