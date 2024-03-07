Return-Path: <linux-kernel+bounces-96056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF48756A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A56281415
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9991386B3;
	Thu,  7 Mar 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oHnfl1CB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14273137C26;
	Thu,  7 Mar 2024 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838361; cv=none; b=ubDRUV6MqQ0ybhg7Z+Zoyh3f/lt4PneKZKDLs3ciyI2ONrdM4+yHmgy1ImpT4A3I7cdFusZtVudrDbT2+j/0QeuxZHYl/aV7z+HwAvQOxllfiz4+E3ffMuRcVnc4AJ5VNoYLvC1od0to7uympuo3/Nk8KwG8cutK21A6OoRU/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838361; c=relaxed/simple;
	bh=jL+0TE/sTC+jJgISDbUZ+39FzYgDfAvGp+1jjEaOf2o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKMLLb+bLr7BXv/x5MoznLx3cuSah3Ej8nDfZC6XVQjYQR+WlZzd2TukFdRj3NWNEzNt564vc+MB2uU9Qn0Uh2DhJxt6Q7M1Lkb6P0Ppp889sUTiCIsp1+JkFeEfKAEnBdJAlFOmQZheIGo7LhwXs8xsmGLFoS2NtkiGVA5Ep1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oHnfl1CB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427Fx3x9015930;
	Thu, 7 Mar 2024 19:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=aDyfSt6
	DL18qcLL2NYzKLrV8n95+Q4a2EksRu1hGb30=; b=oHnfl1CBnKA9YlfyDhltRwz
	SSOV2TOXBUIBDXWPUcQtNwnhFdMk0Lh0pzwJSNHMa8Nf7fwaayV+txjxGi/wiYyq
	SozSBJdesPmr5yrCpnn1jt+afH/9A5J3Lq2uKOJzbWWmAMyesuLuaHFAIeO7j1bs
	p75bRba7LX0qQjYsycAg5QCSrzcR6n8SSvaPVp8Qv1vTWfH9cd8c//1YkdJtwGly
	ub/LStF6nJNvg2e2UyQ8dWeL/A5W9pdvOtgFXw7bg6SNgabm+waqzCOQvfq+GRnI
	5JkgKO083pXLzAmLbPRnpJ8R8yBYCer9xpIBKW1wuHouwr15p0IxKAUO8ypA4sw=
	=
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq588hrw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:05:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427J5iN3011224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 19:05:44 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 11:05:43 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v6 0/7] Add support for Translation Buffer Units
Date: Thu, 7 Mar 2024 11:05:18 -0800
Message-ID: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o2yFfdr-1_NR-ShVIYrOIkH5uuc7kzcv
X-Proofpoint-ORIG-GUID: o2yFfdr-1_NR-ShVIYrOIkH5uuc7kzcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070133

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

v6:
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
  iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
  iommu/arm-smmu: Allow using a threaded handler for context interrupts
  iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
  arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
  iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
  arm64: dts: qcom: sc7280: Add DT nodes for the TBUs

 .../devicetree/bindings/iommu/qcom,tbu.yaml   |  69 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  89 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  70 +++
 drivers/iommu/Kconfig                         |   9 +
 drivers/iommu/arm/arm-smmu/Makefile           |   1 +
 .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 496 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  12 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   3 +
 10 files changed, 757 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c


