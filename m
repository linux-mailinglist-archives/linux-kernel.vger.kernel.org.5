Return-Path: <linux-kernel+bounces-54412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6F84AEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559D428B7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738112B15A;
	Tue,  6 Feb 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b1Vr2Cn6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2B12AAD8;
	Tue,  6 Feb 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203850; cv=none; b=QyagKG23uRwqPcto9N4NuYcgxKRCP4OX4faqhti8c1rM8117cX4vJvmZVsQaJjx32OSnIUdPvSUALqZUq9KBy0PSAV/i9ahJOg7Ot7A06Xhfu3PK0F35X4pKb6rs+gzoX5bMOKW6gaEgDoNu44LXJc6+AGIKXXNvnTOlXqfEuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203850; c=relaxed/simple;
	bh=EtcLDayWCkPfodstSxThsuB25ZuHsnyYIYyOlSaLTT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hy6aJE9ugSoK7bCsxZt0OX8CBitAZoEcsSPAJ00GAq9emyT9PPMzVkscC3OV1POMzOZHKEedM9bqygYWwn5NHFhM97KgmgGSxvoNn7wsTGC1QksOG4X3JDfDBEWmr5jJ+9saxp5fGe6+ydMJanQaUsjccrosmLXFQT8dK0UADk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b1Vr2Cn6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164GHep028546;
	Tue, 6 Feb 2024 07:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=nAdYovX
	QIW5SI0hxYNNUbjNIe55mFtvUva5+Xl0gms0=; b=b1Vr2Cn6qo/QkI2cIwvWeqi
	Ww7o6jAeH9Ae7ekOoARC/HkbWBsXbVo8kIhNRVzoZGFiPnKNLxU+260zn0KpMXTB
	BniL4reGsW8KkroCenB/C0VHvUKAC1ZraihGI5FV9NeVfpv8ja5uI21rErywCzAp
	Y4oqEVsOkEhbIBIuqW2l6iS/q8t2jfQe7E8n0//4iK4kgiwEwkcLXUikW5pQLvq3
	a89ZCQrO5BfwRb/lwvFsIm+sL9nZ5ebYt3QpZjzyBaE4CA9gvESsbbRbwQHw+9gV
	CuH48WIqZWh3qrfVZ8Zsxfz8MbtQMPMLo0ZjgMVr3ReJt9KHiC0J2/GS2OUsBkg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w399ersep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:17:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4167G9xm009524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 07:16:09 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 23:16:05 -0800
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
Subject: [PATCH v2 0/5] LLCC: Support for Broadcast_AND region
Date: Mon, 5 Feb 2024 23:15:51 -0800
Message-ID: <cover.1707202761.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uDzwu_uprw3DES_iY8_Iel-EBgJ57jRt
X-Proofpoint-ORIG-GUID: uDzwu_uprw3DES_iY8_Iel-EBgJ57jRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=468
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060049

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

Changes in v2:
- Added an additional check in the case old DT files are used for
above mentioned chipsets for backwards compatibility
- Moved addition of if check in llcc_update_act_ctrl() to a separate
"Fixes" patch; not part of this series

Link to v1: https://lore.kernel.org/all/cover.1706296015.git.quic_uchalich@quicinc.com/

Unnathi Chalicheemala (5):
  dt-bindings: arm: msm: Add llcc Broadcast_AND register region
  arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8550: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8650: Add mapping to llcc Broadcast_AND region
  soc: qcom: llcc: Add regmap for Broadcast_AND region

 .../devicetree/bindings/cache/qcom,llcc.yaml  | 41 +++++++++++++++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  5 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  6 ++-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  6 ++-
 drivers/soc/qcom/llcc-qcom.c                  | 22 ++++++++--
 include/linux/soc/qcom/llcc-qcom.h            |  4 +-
 6 files changed, 66 insertions(+), 18 deletions(-)

-- 
2.25.1


