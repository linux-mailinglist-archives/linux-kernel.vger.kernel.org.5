Return-Path: <linux-kernel+bounces-40592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC583E2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208391C237A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C31249FA;
	Fri, 26 Jan 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mAjcZJyi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152124B59;
	Fri, 26 Jan 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298480; cv=none; b=Q5ZztUcHKF1IgzijMVn5dx9IuI18yAlnRF7xNnkpJQ22V6RaAU1D6Vuen6ti0BDODkSg111+YuYxUyVL1Iex+SntXpVMf9KbEHdcmX5k8Zk4Ub3KrgPoYw04ZAXZ/1X1LNLmdpI7NwkyLRt3QFmFt4/CQJoPghCMDhcGrAnKKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298480; c=relaxed/simple;
	bh=k5TyF1744UaDOuPsN82/PvIaoVIGPpKBEa4ZNpZujGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzJoY3gKUeb1ou+maH4DgK3pUjBb1l34SpK25eQWqyMhvybVzEZ8j5quLxOTY1v/xIy25F227tWE67AjkGqnxlmMmcsZwtTBPzPJ6wAv3wE6RFn+WLQaRJjOADWvCnVfBvCbLnPU+qu4kOx8ojnfditB8l6KpFGDMUQW8VQd2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mAjcZJyi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QIgL55001327;
	Fri, 26 Jan 2024 19:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ZNUZgyx
	kTNx3LFgkjba+Pr84I8sZQmpGaG9mPUncjAw=; b=mAjcZJyiq5Ty3QPW4NlNTPt
	Z/yQ03jED+s8T7Rel71Cys5IlnQ92hY8fhzGVpPyQy8GkBZXAla4+gjjy9/IHmor
	ZhERrvkoDuUrLGxfXw61FL2jghdvfViWqfg7exxt0NYUCKgXyI9t6MlW7HWB7Hii
	kSUrhHHXdiz7tAL50ueAPhEBW9Dj1TgNlw4hsSkv6JwhMsFIiE4KLQW/4PzILz+v
	AsdgLjqOmUv+rMMcEdgDkhZxaBS8GTtcKnk7jkbBA2PfEwn+TXGKrInqcBwvqk0j
	uqJGbcM0UuulZ/hxWMuQiqkQLapfBNwRcUXMTcnB9YKQpPWZJcvnHOEqx9hVtuw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvhxyr5fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QJlX75025109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:33 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 11:47:31 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH 0/5] LLCC: Support for Broadcast_AND region
Date: Fri, 26 Jan 2024 11:47:16 -0800
Message-ID: <cover.1706296015.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x8enHPR4isMfNleeDMo1RVmxiGHW0e1-
X-Proofpoint-ORIG-GUID: x8enHPR4isMfNleeDMo1RVmxiGHW0e1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=498 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260146

This series adds:
1. Device tree register mapping for Broadcast_AND region in SM8450,
SM8550, SM8650.
2. LLCC driver updates to reflect addition of Broadcast_AND regmap.

To support CSR programming, a broadcast interface is used to program all
channels in a single command. Until SM8450 there was only one broadcast
region (Broadcast_OR) used to broadcast write and check for status bit
0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
added which checks for status bit 1.

This series updates the device trees from SM8450 onwards to have a
mapping to this Broadcast_AND region. It also updates the llcc_drv_data
structure with a regmap for Broadcast_AND region and corrects the
broadcast region used to check for status bit 1.

Merging strategy
----------------

All patches should be merged due to LLCC DeviceTree/driver dependency.

Unnathi Chalicheemala (5):
  dt-bindings: arm: msm: Add llcc Broadcast_AND register region
  arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8550: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8650: Add mapping to llcc Broadcast_AND region
  soc: qcom: llcc: Add regmap for Broadcast_AND region

 .../devicetree/bindings/cache/qcom,llcc.yaml  | 27 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  5 ++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  6 +++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  6 +++--
 drivers/soc/qcom/llcc-qcom.c                  | 12 ++++++++-
 include/linux/soc/qcom/llcc-qcom.h            |  4 ++-
 6 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.25.1

Best Regards,
Unnathi

