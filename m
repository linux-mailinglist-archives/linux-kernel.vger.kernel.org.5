Return-Path: <linux-kernel+bounces-39162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F19B83CBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C501C22651
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B51350E2;
	Thu, 25 Jan 2024 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dVno+sGy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D679EA;
	Thu, 25 Jan 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209186; cv=none; b=bHlITTMuvkRtfraLiZXBLDr7T4G4xvRjQkt+GDuSVTWwoc4qqBiZFpj7UxISDE3y1aGy1Nf6vRrGhEHwNt8dUzaNvvdnXUQAjVoXOVffsh291/IJERA6HwtKKKPnWF1b6UQoYhra9ifaqlnoKj4X4k14piWPEuBDZjBUcJ/Ckg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209186; c=relaxed/simple;
	bh=GBhUCRYOrlVRIz8+hxGXV/Txmkv0aZqDm2jzXdHY/eA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4FZXLV9kk1o0EoTLa3c+raFmZ9vebFTAE/UZE2rtYWhtKLIzfW0uhh4kshShd97cZdOnIM2pcHUEKfdQrnaOlY39s+5zYKeI3gMvp1q1XshIAVv8DtOVrMs7E7hi8zRlQZmTRUTARVEk+bC35RwgjbVU8T01YudAhNgQNDuKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dVno+sGy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PEs12i020717;
	Thu, 25 Jan 2024 18:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ev2teN+
	6tIBloVhI99FMn/AeWLQu/1QIzyrbwvxtSNc=; b=dVno+sGyQuWXrNUm6Qt1BnF
	wtwwvQLJF3KkUAcqRO4XHD9pFdFKZghxDCLraiUuoW+ib2UJCujsGLMC6UGiVszb
	0cGuBsQZNqVUHFnIp60/1N+hlQ+S7jEY0hVypFHgqKeI3Y2OzuX16Jl346mTLYNe
	uc4zMvQjENZdIyX2V+KErM/CN4BW77szSoQH+GGjpp3stt2TGs2fOiALIl+/lEGK
	sd8WxOHUecSHgRv/3mmW3JP4Tjz/Jjulzyl8w+UihD8Jwg/R7WiGGwGYTD5vrxyf
	/eCNxpi72OSLReD3QRF5M+5i8W5Z+7M7PKDsmjUgjWwUzM5WSPNGnN6vk/+sNdQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun5yhhpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 18:59:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PIxX9l009147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 18:59:33 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 10:59:30 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v3 0/4] Fix USB Interrupts on Qualcomm Platforms
Date: Fri, 26 Jan 2024 00:29:17 +0530
Message-ID: <20240125185921.5062-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qiMp2algxiMzBg0oyUD8OB4TqGf_DAvq
X-Proofpoint-ORIG-GUID: qiMp2algxiMzBg0oyUD8OB4TqGf_DAvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=235 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250137

Currently the interrupts mentioned in most of Qualcomm platforms
are partially faulty because of following reasons:

1. hs_phy_irq mentioned on QUSB2 PHY targets is actually qusb2_phy irq
2. pwr_event irq is missing for many targets
3. Actual hs_phy_irq is also missing for most of the platforms

DT changes made as per binidngs update done in [1].

Changes in v3:
Modified "interrupts-extended" property to "interrupts" in ipq6018
and ipq8074 as using warnings were not see on DTC version 1.4.0
So tested with latest DTC version now.

Changes in v2:
Didn't modify usb3 controller interrupts as they were changed to MPM
recently and I wasn't able to get my hands on missing interrupt numbres.

[1]: https://lore.kernel.org/all/20231227091951.685-1-quic_kriskura@quicinc.com/

Link to v2:
https://lore.kernel.org/all/20240120191904.15408-1-quic_kriskura@quicinc.com/

Link to v1:
https://lore.kernel.org/all/20231211121611.6765-1-quic_kriskura@quicinc.com/

Krishna Kurapati (4):
  arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
  arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332

 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 14 ++++++++-----
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 14 +++++++------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi  |  8 ++++++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi  | 13 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi  | 14 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi  |  7 +++++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi  |  8 ++++++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi  |  7 +++++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi   | 16 +++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi  |  6 ++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi   | 14 ++++++++-----
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 12 +++++++----
 arch/arm64/boot/dts/qcom/sdm630.dtsi   | 17 ++++++++++++----
 arch/arm64/boot/dts/qcom/sdm670.dtsi   | 14 ++++++++-----
 arch/arm64/boot/dts/qcom/sdm845.dtsi   | 28 +++++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm6115.dtsi   |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi   |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi   | 13 +++++++-----
 arch/arm64/boot/dts/qcom/sm6375.dtsi   | 12 ++++++-----
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 28 +++++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 28 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 28 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 12 ++++++-----
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 12 ++++++-----
 24 files changed, 238 insertions(+), 105 deletions(-)

-- 
2.42.0


