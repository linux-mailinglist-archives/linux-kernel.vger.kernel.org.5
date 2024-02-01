Return-Path: <linux-kernel+bounces-48855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2284626C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97751B238E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC44779C;
	Thu,  1 Feb 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lb4Xniqi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67793F8DA;
	Thu,  1 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821564; cv=none; b=mGwZyzLIjAj+dj1SAvYSt/kaHYLmFC+Iq/kqWwTDu+p+OGOh7KA9eoCwPpw+suftmo4OdObiD7xXnBxnBsufWbZ/cT2tvB6P0hnrOREt8mrzGzWUvg6tWm92tpjbpyMMVz+/Pvh1Tiiclf31QOPXfvRmW1qXpIT/CAJGunB5n6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821564; c=relaxed/simple;
	bh=y1AnCu9zWxeUIp1ma8tIEwTxd+5oNbsFOZxKsVfI8Ko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BetxVYH3hOox0+meVIpIbdlglVmbwlmM6xHJlXz184sr0+is4o+LYRSj5Ea3nWePP7XfEUoDRsibVi5K/kADAIGbW/ipx6HPsMogpEKpQajmgydtHat5s/83xJK2PLanKfNxHEkwAQsCKKZ94Q4VJY7DTzKYp/tUM54JNB0pzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lb4Xniqi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KYpWk019205;
	Thu, 1 Feb 2024 21:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=36Hbbfy6eg9N9AdxGGFvD7+B/EgUhDiCcepj2PUN84c=; b=lb
	4XniqiUasFiGTD67aM3E8dXjQLgP7kmiUxaFr58DmPHTe1gH/cx0cpFCEGHQWogy
	m48MjNeZo9y4DGgPWwVHflv4Q+3aRwm2vITO6LN7UoLhuvKPamFzT8ehs9KRbEyX
	ZtLvZKMOLyBYd05K6MxQK5mmIm65JpdNYXWN5Tfau84mqxdooNCREt/ZkTI4wDJV
	eJgVmI1vn+prlzrnpPXLEFyP2coXD7Tc9np0DfT5pXT0c8gsFdM825p85Y+fKR+f
	AmpEy4Z4XS6ECIqjEw2oxDjoNGRS7yBSqzDCOK3+kTJFhzO/xWarqhTXNYfk0eq6
	j87A0g94hgfhjZQU1z4A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0619j7k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5dWg008946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:39 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:38 -0800
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
Subject: [PATCH v4 00/10] Add support for Translation Buffer Units
Date: Thu, 1 Feb 2024 13:05:19 -0800
Message-ID: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wcoKPkfDzTblpkFnSgghzmqvNVXeKkwL
X-Proofpoint-ORIG-GUID: wcoKPkfDzTblpkFnSgghzmqvNVXeKkwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=801 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

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

v4: 
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

Georgi Djakov (10):
  dt-bindings: iommu: Add Translation Buffer Unit bindings
  dt-bindings: iommu: Add Qualcomm TBU bindings
  iommu/arm-smmu-qcom: Add support for TBUs
  iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
  iommu/arm-smmu: Allow using a threaded handler for context interrupts
  iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
  arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
  dt-bindings: arm-smmu: Add TBU support for sc7280
  iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
  arm64: dts: qcom: sc7280: Add DT nodes for the TBUs

 .../devicetree/bindings/iommu/arm,smmu.yaml   |  26 +
 .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    |  71 +++
 .../devicetree/bindings/iommu/tbu-common.yaml |  28 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  97 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  74 +++
 drivers/iommu/Kconfig                         |   8 +
 drivers/iommu/arm/arm-smmu/Makefile           |   1 +
 .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 496 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |  17 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  12 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |   3 +
 12 files changed, 836 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
 create mode 100644 Documentation/devicetree/bindings/iommu/tbu-common.yaml
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c


