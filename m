Return-Path: <linux-kernel+bounces-39277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD283CE02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE85CB232E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3913A26D;
	Thu, 25 Jan 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CsG6hcNU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8338131E40;
	Thu, 25 Jan 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216721; cv=none; b=VAUpICtfjGn6WOEiKyQVv1dmwwuYhv6E7h3IGs2u/LcH2n9RheCwRabsqsDFUhoWValBdFuJsM/l5CTfB372ZsFZ4gYJwBjoZcxcHbDXxeFTg88Ylifx0r8RA9cKHJH2//Efed5t/9j8c2JOZvpNvxT1N4YGqhvdhEM4g6yAZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216721; c=relaxed/simple;
	bh=iV/VVbB+LF9A5XFalBXnJOGND1zdaRgP6KBAr1Le8EA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rbOaw3gmHgz7aOSNkxyTXM2nYB8CAhTRChcY2lGoutwoqAgopdo2mZeNOpQpHPGwPJBMwPkfxVu+Ou+/T3F1Mz1XXBDywwkF83co1Hw12NRUHSyhswNOw9LBqDgssPe+AzlRiSCB5iCK8WQdwlT/uj/Ae/X/ulKEasxloaTCkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CsG6hcNU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PKc0mA012615;
	Thu, 25 Jan 2024 21:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=VzgYNPq3m2joSX
	eSyslUZFLsLX/phwtjsHm3fw0PvB8=; b=CsG6hcNU9qqUG3TWmhXrjzTRedT09n
	9ci5KPhBpdnKCMPVkXRDzW7H4pi4w5GTVVJ7I3H8/zY1hgph44TBkLdlu6nPmnOZ
	mg4HzhDhj/dIFZHw5Ttw8Xn14lBpr+JA9WKjOWDXDGnuVJr2t6epKJciZ3xvYztO
	qW+6EpwCboKaqncfDS7E8ejgSIBm0wfMupGlHE7exOpRf67CzajeN5xd2Y8h2K1C
	+q/yuWDuUMHKtN7shFfmoiwtwG4MgZcAqZyrYbyghaKAl3oQZPebq7jaVR2UvbHx
	Dp9Tr8DfsJVZgEe7wjKk+IwDslZNi+JNKXZGDVUjZ8JyUHj5sJGyAPNw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumynhrhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5BFe027199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:11 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v4 0/8] arm64: dts: qcom: sa8295p: Enable GPU
Date: Thu, 25 Jan 2024 13:05:06 -0800
Message-ID: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALNsmUC/33NQQrCMBQE0KtI1kaS/5OmuvIe4qL9TWxA05rYo
 kjvbiq4KIrLGXgzT5Zs9Dax3erJoh198l3IQa1XjNoqnCz3Tc4MBKAEEDxVJWx1z0/9wLUk7VC
 hRUssi7pKltexCtRmE4bzOZd9tM7f3xeHY86tT7cuPt6Po5zb3+Oj5II3JTUOQBu3Nfvr4MkH2
 lB3YfPSCH80ZK1MgaCK2gCJb40frYQEXGqcv3WtlFFUOsSlnqbpBdnw/Ns5AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=2456;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=iV/VVbB+LF9A5XFalBXnJOGND1zdaRgP6KBAr1Le8EA=;
 b=ss1lZ9Y1KjKKFQnNVlo7kMLL/1yHE/RDzqFYPy22Lcc+cxOuTCbFwKfYPdNt9LN2D7j1MTt0I
 qEff8wAvj9WC1Eubct1wX7kMXAy2Xhj+SUtnXc5gMdwkD2ufi3R+Bue
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z83cXzEougnsgC3p9wuhDJwV6BG5R75t
X-Proofpoint-ORIG-GUID: z83cXzEougnsgC3p9wuhDJwV6BG5R75t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=732 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250152

Due to the different PMIC configuration found in the SA8295P platform,
compared to SC8280XP, the VDD_GFX pads are supplied by an dedicated
MAX20411 LDO.

Support for expressing the regulator supply is added to the binding, the
support for enabling the parent supply for GX is added, the missing
gfx.lvl power-domain is dropped, and the DeviceTree is wired up to
enable the GPU in this configuration.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v4:
- Updated qcom,gpucc.yaml binding check that both power-domains and
  vdd-gfx-supply isn't used together. Updated related comment as well.
- Link to v3: https://lore.kernel.org/r/20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com

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

 .../devicetree/bindings/clock/qcom,gpucc.yaml      |  9 +++
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 68 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |  3 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/qcom/gdsc.c                            | 12 +++-
 drivers/clk/qcom/gpucc-sc8280xp.c                  |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  1 -
 7 files changed, 92 insertions(+), 3 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231220-sa8295p-gpu-51c5f343e3ec

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


