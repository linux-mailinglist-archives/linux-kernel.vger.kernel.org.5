Return-Path: <linux-kernel+bounces-32363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAB6835A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F41C21516
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF826AC2;
	Mon, 22 Jan 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kmU5pRZA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BF53A7;
	Mon, 22 Jan 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903046; cv=none; b=alfR6/MytvOOSOMMiSp2mWI/k708vL8omoO80icX7j+tbOBV3PS5BeIZdFcom5xkCY3Kx+HACJztkMtuftZkBDDUrtkPCPXtH26y9g0DmlzzVvdp0mMz0CrXGoqcKTagRgkn290yKgY6infMyVA9nocRmRpah3kkw7YVkl66e4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903046; c=relaxed/simple;
	bh=3/LLAsFUZz4SgBGQNxQiyLp2BznPG43zkEiReF8ojwo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=iPPtVXdGsgIgjDpSF5WCED5a7vvvgqa3XBdvZH2yX03PfyyhVLs2EhgMqsjIRwYcg2PPuUVNI7XzxOJgp3FD8dRXJkuexCPaW0qpkfqObH3346/8AZMH7QJ1T9777jdHuQcViPWLNy22C/qibapwlw5WSnVeO6JQZXQz6+oPnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kmU5pRZA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M3QhJk010489;
	Mon, 22 Jan 2024 05:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=gOkvKx6U8tNWu+
	YMf9CAloDT8sJSVldWthGeWm6dOd0=; b=kmU5pRZAbKqVLPhNcBJTryOQhUDq7j
	7UEWoGnvqeFMlyVL8P1DfZ3sqWBg5eCiNNYJviXbXpDjvhdbxxYCITtPOcyBU4hJ
	dsc9BO44oa9/0Ko9BHITaYtUbFkI8tRbOhPeKdkPO6FkwZHMxb5TLcZlQj4ahh7m
	qI2TA97ry8KaoNhjWDjgBIFRWSj812IjMnRdIe+nOU/zsQZDEYrusa/c+u1L4KDB
	G99oeIRAYvUA8V1SEX0KY/HDp0U+vPFvrzmbDofSfvsgpf/Ds674/ZNVvVNnJMYe
	93+SFMVa03IKjRjNAZ2lGq/MYv6lpGxTDgdHwpFB5HXVpmI78KfVV3Ng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5gpk2ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5v9c1019141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:09 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:03 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v4 0/8] Add NSS clock controller support for Qualcomm
 IPQ5332
Date: Mon, 22 Jan 2024 11:26:56 +0530
Message-ID: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgDrmUC/3XMywrCMBCF4VcpWRuZTC5YV76HuIhjamdhL4kGp
 fTdTQsuFFyeA98/iRQihyT21SRiyJy478owm0pQ67trkHwpWyCgVqBB8jBarVF2KRFJHzzVQVk
 Nxopihhgafq6946nsltO9j681n3F5/5WykiCdcuiRnG3AH8YHE3e0pf4mllY2H29AIf56U7yul
 QIX6p0/228/z/MbaOfc8ewAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=2637;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=3/LLAsFUZz4SgBGQNxQiyLp2BznPG43zkEiReF8ojwo=;
 b=9UD1behseRpd6SGd0URZ2kpuXJ7XO59XV7XM25z6U1SiTb1ppu2XvOuH3uzM5GTgh5VhqO8xC
 4KPJQWu9avoC8JcXOTbJWOLCcpt6XEIUNnb2mVPztNiHA2iDBOYgPJ/
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FTCAKj21xfpZ3x_D6mIz7tf-fKu1hbCs
X-Proofpoint-ORIG-GUID: FTCAKj21xfpZ3x_D6mIz7tf-fKu1hbCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220040

Add bindings, driver and devicetree node for networking sub system clock
controller on IPQ5332. Some of the nssnoc clocks present in GCC driver is
enabled by default and its RCG is configured by bootloaders, so enable
those clocks in driver probe.

The NSS clock controller driver depends on the below patchset which adds
support for multiple configurations for same frequency.
https://lore.kernel.org/linux-arm-msm/20231220221724.3822-1-ansuelsmth@gmail.com/

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in v4:
- Rebased on next-20240122
- Fixed the missing space on the nsscc node
- Link to v3: https://lore.kernel.org/linux-arm-msm/20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com/

Changes in v3:
- Collected the tags
- Dropped the dt-binding patch 3/9
- Cleaned up the header file inclusion and updated the module
  description in the driver
- Used the decimal number instead of hex in the NSSCC node
- Link to v2: https://lore.kernel.org/r/20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com

Changes in v2:
- Change logs are in respective patches
- Link to v1: https://lore.kernel.org/r/20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com

---
Kathiravan Thirumoorthy (8):
      clk: qcom: ipq5332: add const qualifier to the clk_init_data structure
      clk: qcom: ipq5332: enable few nssnoc clocks in driver probe
      dt-bindings: clock: ipq5332: add definition for GPLL0_OUT_AUX clock
      clk: qcom: ipq5332: add gpll0_out_aux clock
      dt-bindings: clock: add Qualcomm IPQ5332 NSSCC clock and reset definitions
      clk: qcom: add NSS clock Controller driver for Qualcomm IPQ5332
      arm64: dts: qcom: ipq5332: add support for the NSSCC
      arm64: defconfig: build NSS Clock Controller driver for Qualcomm IPQ5332

 .../bindings/clock/qcom,ipq5332-nsscc.yaml         |   60 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |   28 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |    7 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5332.c                     |  122 +--
 drivers/clk/qcom/nsscc-ipq5332.c                   | 1031 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h       |    1 +
 include/dt-bindings/clock/qcom,ipq5332-nsscc.h     |   86 ++
 9 files changed, 1260 insertions(+), 77 deletions(-)
---
base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
change-id: 20231030-ipq5332-nsscc-aeac9e153045

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


