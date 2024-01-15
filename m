Return-Path: <linux-kernel+bounces-26267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC282DDC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A1B1F224E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB517BD5;
	Mon, 15 Jan 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ixuzEPiI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CC17BB6;
	Mon, 15 Jan 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FGh86x002831;
	Mon, 15 Jan 2024 16:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=2GU9LyX
	r+wNTFXEnIuiIof23UNs/vuTcgPBQP19aeb8=; b=ixuzEPiIZ6OHrO+r6HZdTRk
	REeTmBSjqTXhb5V0EQL/b308j6a2gCwoZ5AC1rFDTWWxkEvm1E5Ak2ylkic7Ou2v
	at2Yq/3KDU6T4VvcB2hAtb9prUtgCS7E+9V11Z7zMc71rVOB9xsPQhPljLOm4hmc
	Hx4OQtopVuSjJYVwV9asXbiOMaYVvEZ+HotNi5dQXGRttAi6OyBOAMMiJMvlGJt7
	3q/w1F/FHqbKmbWkgFZMLNVZAAQ2AV4g9HuqGjOPYApQkEn9Vi86qNikOv6+63Wg
	WdM48Oo10yYTO5N8HCwST4851Ny1VNHZKlnDF4+ZWUGKIRXxZYwDj6pWw64u5zw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vmxdvs666-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:43:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FGh7OK016382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:43:07 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 08:43:06 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mathieu
 Poirier" <mathieu.poirier@linaro.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/2] coresight: core: Add device name support
Date: Mon, 15 Jan 2024 08:42:46 -0800
Message-ID: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ddBTI-DMlorVwJV8JEcDhQHSVay9zIjh
X-Proofpoint-ORIG-GUID: ddBTI-DMlorVwJV8JEcDhQHSVay9zIjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150122

With current design, the name of the non-cpu bounded coresight
component is the device type with the number. And with 'ls' command
we can get the register address of the component. But from these
information, we can't know what the HW or system the component belongs
to. Add device-name in DT to support it.

cti_sys0 -> ../../../devices/platform/soc@0/138f0000.cti/cti_sys0
cti_sys1 -> ../../../devices/platform/soc@0/13900000.cti/cti_sys1
tpdm0 -> ../../../devices/platform/soc@0/10b0d000.tpdm/tpdm0
tpdm1 -> ../../../devices/platform/soc@0/10c28000.tpdm/tpdm1
tpdm2 -> ../../../devices/platform/soc@0/10c29000.tpdm/tpdm2

Change since V1:
1. Change coresight-name to device name.
2. Add the device-name in coresight dt bindings.

Mao Jinlong (2):
  coresight: core: Add device name support
  dt-bindings: arm: Add device-name in the coresight components

 .../bindings/arm/arm,coresight-catu.yaml      |  5 +++
 .../bindings/arm/arm,coresight-cpu-debug.yaml |  5 +++
 .../bindings/arm/arm,coresight-cti.yaml       |  5 +++
 .../arm/arm,coresight-dummy-sink.yaml         |  5 +++
 .../arm/arm,coresight-dummy-source.yaml       |  5 +++
 .../arm/arm,coresight-dynamic-funnel.yaml     |  5 +++
 .../arm/arm,coresight-dynamic-replicator.yaml |  5 +++
 .../bindings/arm/arm,coresight-etb10.yaml     |  5 +++
 .../bindings/arm/arm,coresight-etm.yaml       |  5 +++
 .../arm/arm,coresight-static-funnel.yaml      |  5 +++
 .../arm/arm,coresight-static-replicator.yaml  |  5 +++
 .../bindings/arm/arm,coresight-stm.yaml       |  5 +++
 .../bindings/arm/arm,coresight-tmc.yaml       |  5 +++
 .../bindings/arm/arm,coresight-tpiu.yaml      |  5 +++
 .../bindings/arm/qcom,coresight-tpda.yaml     |  5 +++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  5 +++
 drivers/hwtracing/coresight/coresight-core.c  | 33 ++++++++++---------
 .../hwtracing/coresight/coresight-platform.c  | 31 +++++++++++++++++
 include/linux/coresight.h                     |  1 +
 19 files changed, 130 insertions(+), 15 deletions(-)

-- 
2.41.0


