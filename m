Return-Path: <linux-kernel+bounces-36417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3683A06F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385B42850A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164ECA67;
	Wed, 24 Jan 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V+MR7BRD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E346B8;
	Wed, 24 Jan 2024 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070328; cv=none; b=sD4dKE/qIvuDxbVdPf3uMh6UZ7Tg874ZR3jGoJA1sJ0Y1TGKybhxTn5bW5dtNULEbteIN6XGfmz6KNccXDQhf6/ER4n1sFFiK9wDDI5X+wVX5mVTopy8H7TEhBVuUDFpUmiDgdZnt8Levhu5bWbXCWyVa9rKXrPqz5dJ7N6Ly0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070328; c=relaxed/simple;
	bh=JBAvZdygoJumjb+30fjq+Ggh3vYoPDqruBZLxBaFeb4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rFekStxZ7/4qt2XUxKPRQDALLGhzMv1o4IBpevoydi0LSZ6t4y55ykz9kzoVXXvgF5CqqdKu0NfNaLdKJSYaMXvcdPV9AzJ49/EfnO/aWeXXJ+di9qIUBYy2zv02uL4LhcY9PxVr0L/oPxPfT7sTW9zgSv6j7/Y2ax0YqP3OFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V+MR7BRD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O4LAos024273;
	Wed, 24 Jan 2024 04:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=NZB9SFWt1RCiGp
	+zofXJB9SXOMyqD2ABPKksWfi6zUE=; b=V+MR7BRDG+pbBdaqUOtCPxg3G2iI/f
	XJAGuOYoFeJ4W/ivFei6fE6XMH4rnEXjsJ6pJIaqMqooAl4Zc/s/8PHxUoxuxRwr
	dw3Ur3u4jLl1uDCDIX1ACTmf5KGQrKAtqi7Pp87lnFFhuGBZKg4rDg6AbilLPO6J
	h5ImDj8zQl2iTfr/mgBKy6GPosZzlE46CviGDxm39pH5eH8OReOp5jiH0bvKLXmq
	GbIuh60no1oplWEGxcI7O7/IQsDnRUudbW38IMv9tTqpFiQk0IQjCTC+zGK6JWBi
	4qUuxO7sVcc39XG5C2QHvEvH1LQBPHvyNo/OMTZFih9POfo/eZZjotGQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgxgr09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O4PGOU030407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 20:25:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v3 0/8] arm64: dts: qcom: sa8295p: Enable GPU
Date: Tue, 23 Jan 2024 20:25:14 -0800
Message-ID: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqRsGUC/32N0Q6CIBhGX6VxHQ1+RLSr3qN1gb+gbIYGyWrOd
 w+9a2tdnm8751tINMGZSM6HhQSTXHSjzyCOB4K99p2hrs1MgIHgAIxGXUEtJ9pNM5UcpRWFMMI
 gyUajo6FN0B777Ph5GPI4BWPda7+43jL3Lj7H8N4fE9/W3/HEKaNtha0FkMrW6vKYHTqPJxzvZ
 Csl+GNDtgtVCijKRgGyb3td1w8IWxMf+wAAAA==
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
	<dmitry.baryshkov@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706070315; l=2207;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=JBAvZdygoJumjb+30fjq+Ggh3vYoPDqruBZLxBaFeb4=;
 b=nz1kdPx8aLlo0fDIp0HbexT861uovf4X+FVzQZ7MIfF/1qH1pH6f7svj6tMM6CoaHm2AnKkBx
 XXwJSONNNRSBJYnCzfWLOKw19wo2662nALMfENAFSOyq4F3gkY1t6/Q
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: soDsf3vnQ3pUqDz-dx-NrW5fZDJKgYDf
X-Proofpoint-GUID: soDsf3vnQ3pUqDz-dx-NrW5fZDJKgYDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=758 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240029

Due to the different PMIC configuration found in the SA8295P platform,
compared to SC8280XP, the VDD_GFX pads are supplied by an dedicated
MAX20411 LDO.

Support for expressing the regulator supply is added to the binding, the
support for enabling the parent supply for GX is added, the missing
gfx.lvl power-domain is dropped, and the DeviceTree is wired up to
enable the GPU in this configuration.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v3:
- Removed one unnecessary empty line in DT node
- Rebased series to v6.8-rc1
- Link to v2: https://lore.kernel.org/r/20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com

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
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 68 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |  3 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/qcom/gdsc.c                            | 12 +++-
 drivers/clk/qcom/gpucc-sc8280xp.c                  |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  1 -
 7 files changed, 99 insertions(+), 3 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231220-sa8295p-gpu-51c5f343e3ec

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


