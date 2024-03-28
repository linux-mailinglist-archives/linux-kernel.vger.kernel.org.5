Return-Path: <linux-kernel+bounces-122724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C388FC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BA429917F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3E7BB1F;
	Thu, 28 Mar 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VMZTHzrQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F142657DF;
	Thu, 28 Mar 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619479; cv=none; b=Tlde+PuWpI/nEQP5w1PGN330R/QvgPAn+NQO6Qx/DvSIFCaxwFWnZaZC8oIorqRGGfYeE/8TRamfgiOPqk0+2xcLz8LlcjaLRYRBm2zqBFox3X63o2n0l59Xyup6LOObSdLk+VLR54H1VGFaoK05U/AWJnl3zfub0j8pEg3H8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619479; c=relaxed/simple;
	bh=dmJQuzuTv7qtd0Egsch88hhsMYO6t/lsMl5eID3n1+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MqgIWdyo9Fj8OkA8I1tXptV2m48X2UBgH/FSEEqnffP09TQOX7G05c3Yxwzi+Zr+hLUQv97yQvCBVAgzYqqn5UgRZlo7VkSfXnnjpPKthAlarkPKgE4yP6AfYZkzRvCVOUUGid4e9kC26ndUbDPRDjtFLKvZISw91yuhtHCe7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VMZTHzrQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9pAES020942;
	Thu, 28 Mar 2024 09:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=STjd2lI
	jolqXQuuf3EMmg2wIG0RNi33p443oS4piWuU=; b=VMZTHzrQ8z/nvm5iBiMe/RD
	aUjKpv0NI4qTccXB8ku2BMbu0W6X2e6pKL5HInIHbh4K31nodb07fKvRLs3dBFIb
	MVFXFGQYdFx9nii2y3ryAjR1TbeoS8oVu0H1619EDrfNKbyQnCfE2YUgif05gGGK
	Gz2xxvk2FOjKFlnJFIwqML7NHMfg2hXBDeJZd8oMjzPx7W4Oi4ARZNvGSr31dr0T
	BvpUUPt2hNRaC4KPos9atJ7H+L5JA9pu8B5PsKKsHIdCkkvTT2dONa+QNSPxL6sl
	gPbEpfoUJcWsfYUfo+qCIdGDLDZIm8NyxFzqfwPUri21md0FMZneNl7mCNQQkBw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wtss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S9p9sd019991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:09 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 02:51:03 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH 0/5] qcom: x1e80100: Enable CPUFreq
Date: Thu, 28 Mar 2024 15:20:39 +0530
Message-ID: <20240328095044.2926125-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: g_SSgvyePb39rRVbz_AVB0TjYAj_pQG_
X-Proofpoint-GUID: g_SSgvyePb39rRVbz_AVB0TjYAj_pQG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=982
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280066

This series enables CPUFreq support on the X1E SoC using the SCMI perf
protocol. This was originally part of the RFC: firmware: arm_scmi:
Qualcomm Vendor Protocol [1]. I've split it up so that this part can
land earlier.

RFC:
* Use x1e80100 as the fallback for future SoCs using the cpucp-mbox
  controller. [Krzysztoff/Konrad/Rob]
* Use chan->lock and chan->cl to detect if the channel is no longer
  Available. [Dmitry]
* Use BIT() instead of using manual shifts. [Dmitry]
* Don't use integer as a pointer value. [Dmitry]
* Allow it to default to of_mbox_index_xlate. [Dmitry]
* Use devm_of_iomap. [Dmitry]
* Use module_platform_driver instead of module init/exit. [Dmitry]
* Get channel number using mailbox core (like other drivers) and
  further simplify the driver by dropping setup_mbox func.

[1]: https://lore.kernel.org/lkml/20240117173458.2312669-1-quic_sibis@quicinc.com/#r

Other relevant Links:
https://lore.kernel.org/lkml/be2e475a-349f-4e98-b238-262dd7117a4e@linaro.org/

Sibi Sankar (5):
  dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
  mailbox: Add support for QTI CPUCP mailbox controller
  arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
  arm64: dts: qcom: x1e80100: Add cpucp mailbox and sram nodes
  arm64: dts: qcom: x1e80100: Enable cpufreq

 .../bindings/mailbox/qcom,cpucp-mbox.yaml     |  49 +++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        |  55 ++++-
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c             | 205 ++++++++++++++++++
 5 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c

-- 
2.34.1


