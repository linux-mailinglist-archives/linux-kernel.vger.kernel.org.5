Return-Path: <linux-kernel+bounces-107927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F299A8803A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5D1F25E75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985B2B9DE;
	Tue, 19 Mar 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z2iuhMlu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B19282F1;
	Tue, 19 Mar 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870020; cv=none; b=Ur6gu2NrWKkIqzNQG9tcxpcB6gmg3hO5DHxJ0wSjZg9d19qOd09L03oGHFQAmgHqhhdQDgTmcgJ4cmzAC3bXjogjEJX0BSsOk4YkdYzGMP4ODfZwYsVuugLSeCi1XFewpia3OANa+/40jRJMXcOHmELAKJ3B0fYffOuh32QgrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870020; c=relaxed/simple;
	bh=PXmc3xm8yJuDKeUvCkuWoKuZ3eFrtghrllkI4BT/VtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rAkJJOGf5km9kvkjjbI/PEFkj2VK1xIktYbKRTL5qzcolGLMCVn/JXu0xQLC5WZqBUqVqhYHeJWwtiZoZ4Jy/LrYNokjLhExZ+VQfn9rjL3hXgKLKpsa7X1ILmemjF4oJpUEDTKDbN8OyHbjKkqRUOXNxoltT/IBsOWm3TtDyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z2iuhMlu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGrSr016655;
	Tue, 19 Mar 2024 17:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IW03d6U
	f3DPQ9Z3IECrWzmryivfQS8a63fgm/D5fmX0=; b=Z2iuhMlukNYAC4CdSoX6XId
	x0e9RIoAlABYut7pavUP/K43dH9pQlbhZu5Q8v6fiV+kPcbMP8vDGDtPHTev6xBC
	EdxJeJ908fPEONzoExo+HLcV5b0/dpbysLdq5ITED9PfiSQDw7vHrow+TtmtpiTP
	Pt27NvwtzJVREyPONVgHhvSwgMYnIeUTcCkS4y86MzzGtc6AKbE2NEfStmEmRQ9P
	TuJ9QdF+XU+0P3BMZyYrOffXoVjoR4IRN8sMUQ6nj8O8l1dp1aUgcq82LzSPOcGM
	reGAc9TiidsybdHN20d0CIGClIKWmIfiqtYh9lrkqjdmr2KwKw0Ck6cAmoYDw8A=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy553hmjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JHe2rf020876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:02 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 10:39:59 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v2 0/8] Move camss version related defs in to resources
Date: Tue, 19 Mar 2024 19:39:27 +0200
Message-ID: <20240319173935.481-1-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w9Wgpilii3joODpCsU05lAoFiAGB0WtN
X-Proofpoint-ORIG-GUID: w9Wgpilii3joODpCsU05lAoFiAGB0WtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_07,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190131

The different resources required for different camss soc versions are
split in to two groups:

1. Camss device related. In this group are all resources described
in the device tree, clocks, regulators etc.

2. Sub-device specific resources. In the initialization
of the each sub-device, the version of camss is passed.
Based on this version the sub-device adds: hw layer support,
per pad formats, number of dma's etc.

The code for "1" group lives in camss.c. However the "2" group
is spread across all sub-device implementations including video device.

This kind of separation is not very convenient when adding new camss soc
version. The reason is that you need to add support in all sub-device
implementations.

There were some improvements in this direction where some of the
hw version related definitions were moved in to the "1". One
example is attaching of the hw operations.

This series aim to improve the things more and add additional definitions
in to the "1".

What is included:

- Remove all format definitions from camss video. The will be passed
  by the parent sub-device

- Make camss generic format definition mapping, containing mbus to
  v4l2 mapping, mbus bpp and other required fields used by the
  sub-device and video node.

- Add per sub-device type union in the resources, different
  sub-devices are using different resources, as an example: is_lite flag.

- Move camss link operation in to the resources. Currently one
  function supports different topologies depending of the number
  of devices. As hw version support increases this is not good
  way of supporting different topologies.

- Add parent device ops in to the resources. This resolves
  inter-dependencies of vfe and csid. Csid requests the clocks
  regulators etc from parent device instead calling directly vfe
  functions.

- Some cleanups in csid code for split the configuration of
  RX and testgen and RDI.

Changes in V2:
- Rebased on top of sc8280xp v6.
- The change "Designate lite subdevices in resources" was dropped,
  it was already merged in previous series.

Atanas Filipov (1):
  media: qcom: camss: Decompose register and link operations

Milen Mitkov (2):
  media: qcom: camss: Split testgen, RDI and RX for CSID 170
  media: qcom: camss: Decouple VFE from CSID

Radoslav Tsvetkov (5):
  media: qcom: camss: Add per sub-device type resources
  media: qcom: camss: Attach formats to VFE resources
  media: qcom: camss: Attach formats to CSID resources
  media: qcom: camss: Attach formats to CSIPHY resources
  media: qcom: camss: Move format related functions

 drivers/media/platform/qcom/camss/Makefile    |   1 +
 .../platform/qcom/camss/camss-csid-4-1.c      | 132 +---
 .../platform/qcom/camss/camss-csid-4-7.c      | 160 +---
 .../platform/qcom/camss/camss-csid-gen2.c     | 410 ++++------
 .../media/platform/qcom/camss/camss-csid.c    | 512 ++++++++++++-
 .../media/platform/qcom/camss/camss-csid.h    |  32 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  74 +-
 .../media/platform/qcom/camss/camss-csiphy.h  |  23 +-
 .../media/platform/qcom/camss/camss-format.c  |  98 +++
 .../media/platform/qcom/camss/camss-format.h  |  67 ++
 .../media/platform/qcom/camss/camss-vfe-17x.c |  10 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   4 +-
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   6 +-
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   6 +-
 .../platform/qcom/camss/camss-vfe-gen1.c      |   8 +-
 drivers/media/platform/qcom/camss/camss-vfe.c | 483 +++++++-----
 drivers/media/platform/qcom/camss/camss-vfe.h |  22 +-
 .../media/platform/qcom/camss/camss-video.c   | 295 +-------
 .../media/platform/qcom/camss/camss-video.h   |   5 +-
 drivers/media/platform/qcom/camss/camss.c     | 709 +++++++++++++-----
 drivers/media/platform/qcom/camss/camss.h     |  28 +-
 21 files changed, 1747 insertions(+), 1338 deletions(-)
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.h

-- 
2.17.1


