Return-Path: <linux-kernel+bounces-148599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440778A84F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AC61C21151
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7E14265C;
	Wed, 17 Apr 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YgI+GsX/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B5140E3D;
	Wed, 17 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361088; cv=none; b=fgTU/209KMmAsMilLylZxJa1+5+IIuUGI6OT3+0wn7Uyoxj3Yv6xB17qCcW6t0k/KAy3G4FDodRZIf4+koYzN/2bB1et4AERbXUkP2LTw47aUdZQmkKstH2UCxkFoudRVvr0FquwTCV7fn/DnJ+0tSSFSCYyqCELfnDNxSJhuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361088; c=relaxed/simple;
	bh=8i1+qzmJSaGpXdrQbemc/0kKIu9XmUGB7FU3KXZ+cCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DdMdBsAQKFiKGD3r0EFZWQlQr8rAC3m7/lFU5VlVEf1HOQ7t72/fvwD3aqYKNhZ6ZPC8MqQsknxCsLO4hyfxmtVaknXEDLAj5EWXdlOM9skiDbkCZnB/x8ctlegoqS/okSeXWAuZJMezN5536wBFBCLwRVIDPSbBOevWdSgI1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YgI+GsX/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HDM9Ew013483;
	Wed, 17 Apr 2024 13:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=j5TozkG
	yTYsObIgFN2jEIGod+AcR5Qphiatkh5nkftw=; b=YgI+GsX/0Kp4sb2vnF4fmcz
	TTqLOFOqUs1m5gNp2tnTUM1iiXTbgCIyPBUYQD8jRqDLMjt5ei2vcvQAaWZ0L/oP
	qS0WWT8lOVhHV22HV2RlyIIIYrzKD0YDVuFO9XeTxVnjJWQ+sS5F3wLHtV2Dx++k
	MSZAeCcO4KDlyMvM0oMz2iLEKvROI/l8Eo+LjII9xtIRYAdU6uzOSlEZhbfHPXnU
	Co03PKzVsmki7bi8tMlYbv5GgZJkFJn2xWXLuRgI22Ayr/dA4eWmVdt5E+BLaQot
	wq0rpYOXUn5QNxB1OP981rlWSZYf+0cCSFgBtYH7UG9ABMGpkqcVLz/plkM+ZiA=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjf8a01a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDbi8k030695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:44 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:37:43 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <iommu@lists.linux.dev>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robdclark@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_sukadev@quicinc.com>,
        <quic_pdaly@quicinc.com>, <quic_sudaraja@quicinc.com>,
        <djakov@kernel.org>
Subject: [PATCH v8 0/7] Add support for Translation Buffer Units
Date: Wed, 17 Apr 2024 06:37:24 -0700
Message-ID: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4iGGmNen0A2LFDU6VJ2jksSSNJR2hoQN
X-Proofpoint-GUID: 4iGGmNen0A2LFDU6VJ2jksSSNJR2hoQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170093

The TCUs (Translation Control Units) and TBUs (Translation Buffer
Units) are key components of the MMU-500. Multiple TBUs are connected
to a single TCU over an interconnect. Each TBU contains a TLB that
caches page tables. The MMU-500 implements a TBU for each connected
master, and the TBU is designed, so that it is local to the master.
A common TBU DT schema is added to describe the TBUs.

The Qualcomm SDM845 and SC7280 platforms have an implementation of the
SMMU-500, that has multiple TBUs. A vendor-specific DT schema is added
to describe the resources for each TBU (register space, power-domains,
interconnects and clocks).

The TBU driver will manage the resources and allow the system to
operate the TBUs during a context fault to obtain details by doing
s1 inv, software + hardware page table walks etc. This is implemented
with ATOS/eCATs as the ATS feature is not supported. Being able to
query the TBUs is useful for debugging various hardware/software
issues on these platforms.

v8:
- Use ARM_SMMU_QCOM_DEBUG instead of a separate config option (Will)
- Replace mutex/spinlock handling with cleanup.h guard() (Konrad)
- Add missing power-domains in sdm845.dtsi (Konrad)
- Fix swapped labels in sc7280.dtsi (Konrad)

v7: https://lore.kernel.org/r/20240329210638.3647523-1-quic_c_gdjako@quicinc.com
- Pick Reviewed-by for the DT binding (Rob)
- Don't spam the log if the dts changes are not there (Konrad)

v6: https://lore.kernel.org/r/20240307190525.395291-1-quic_c_gdjako@quicinc.com/
- Use SoC-specific compatibles (Krzysztof)
- Use additionalProperties: false (Krzysztof)
- Wrap description text to 80 cols (Krzysztof)

v5: https://lore.kernel.org/r/20240226172218.69486-1-quic_c_gdjako@quicinc.com
- Drop the common TBU bindings and child nodes. These TBU functionalities
  are only Qualcomm specific and not generic. In the unmodified ARM MMU-500
  implementation there are no TBU-specific resources, so just make them
  standalone DT nodes. (Robin)
- The "qcom,stream-id-range" DT property now takes a phandle to the smmu
  and a stream ID range.

v4: https://lore.kernel.org/r/20240201210529.7728-1-quic_c_gdjako@quicinc.com/
- Create a common TBU schema. Move the vendor-specific properties into
  a separate schema that references the common one. (Rob)
- Drop unused DT labels in example, fix regex. (Rob)
- Properly rebase on latest code.

v3: https://lore.kernel.org/r/20231220060236.18600-1-quic_c_gdjako@quicinc.com
- Having a TBU is not Qualcomm specific, so allow having TBU child
  nodes with no specific constraints on properties. For some of the
  vendor compatibles however, add a schema to describe specific
  properties and allow validation. (Rob)
- Drop the useless reg-names DT property on TBUs. (Rob)
- Make the stream-id-range DT property a common one. (Rob)
- Fix the DT example. (Rob)
- Minor fixes on the TBU driver.
- Add support for SC7280 platforms.

v2: https://lore.kernel.org/r/20231118042730.2799-1-quic_c_gdjako@quicinc.com
- Improve DT binding description, add full example. (Konrad)
- Drop Qcom specific stuff from the generic binding. (Rob)
- Unconditionally try to populate subnodes. (Konrad)
- Improve TBU driver commit text, remove memory barriers. (Bjorn)
- Move TBU stuff into separate file. Make the driver builtin.
- TODO: Evaluate whether to keep TBU support as a separate driver
  or just instantiate things from qcom_smmu_impl_init()

v1: https://lore.kernel.org/r/20231019021923.13939-1-quic_c_gdjako@quicinc.com

Georgi Djakov (7):
  dt-bindings: iommu: Add Qualcomm TBU
  iommu/arm-smmu-qcom-debug: Add support for TBUs
  iommu/arm-smmu: Allow using a threaded handler for context interrupts
  iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
  arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
  iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
  arm64: dts: qcom: sc7280: Add DT nodes for the TBUs

 .../devicetree/bindings/iommu/qcom,tbu.yaml   |  69 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  89 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  73 +++
 drivers/iommu/Kconfig                         |  12 +-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 496 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  12 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   3 +
 9 files changed, 758 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml


