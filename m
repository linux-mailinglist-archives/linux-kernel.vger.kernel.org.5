Return-Path: <linux-kernel+bounces-52856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E08849D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8932281F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38352C6A6;
	Mon,  5 Feb 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z5FvtXFN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D92C688;
	Mon,  5 Feb 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145055; cv=none; b=Hcl4nTGAXpkB9+vVh+xvfiR8rCpoVzJMYb/Ngj/6KMkSwvgmcBtQzWlLShO3MmMGu/hPee7kDkphybFQu7t51wTOVVJHPDriHJsYsX06m8hLIbHSbNvowH+u1C1f25nxfP8MkpCWtfnUxmAbSy5apmRm+I4Ud+C6UUvCuMQpzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145055; c=relaxed/simple;
	bh=RxXvJ6Oxzk/Mk4W4ObVkYG3nVDUACQ3QyEybGeMseN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KK26Urnkc4lXdHeZyLZ83t+eLGPuwOj26fTEC9bcKxp1JrAb7Z+QqXoeuGxOwcNxeT4VM9YG8EJDC+C9L4GrjZNCnP3zizKlRJ3Etaeer0K3/LxpJmo//glkivm6neYiEmcD+BOudDEkUXiyiyHaIT7xIz4UmDC+84IbG9r/EzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z5FvtXFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415ApZD2001614;
	Mon, 5 Feb 2024 14:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=+qiW1FvrZibrd0hus1IX9TpWC6Ia1DUINhu0PW690CE=; b=Z5
	FvtXFNGHuRr3YvaSvEiFSGdxkQ+5Ptq1cDKoRgaTfl47Jg1730z4BU0kuSTJDLN7
	O6h3h6TpXIWEy2G1qassDQDcnHNCt2vmDz3o3hPVgpNL/Q59A29M5dWUn0c6U0/I
	7WKeFgJ4MTBAjL7h0T5VWHMJHaAL/KJvfSX/utqNQgMkjH9EfK1PcTE9jG+7wVCj
	teKjzfJ3c77QzOY1iD6s4cAFb4b7hiHgSEkFLJvyjbMlANs2dNeByyYAyZ6T2ayO
	6Mr07q/n6x3PfAuQli5IZjsjQ50Z8+YqtAcOQJ9PInC6200pGPuKuhOScrxVVoSj
	6D79ZDrxDeqjj3qcISdw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2s07s5et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:57:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415EvNIm001748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 14:57:23 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 06:57:19 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/4] Add support for QoS configuration
Date: Mon, 5 Feb 2024 20:26:02 +0530
Message-ID: <20240205145606.16936-1-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8CuRHnaaUPPMOjkjr2nz6EityrsQmTPz
X-Proofpoint-GUID: 8CuRHnaaUPPMOjkjr2nz6EityrsQmTPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1011
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=740 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050113

This series adds QoS support for QNOC type device which can be found on 
SC7280 platform. It adds support for programming priority,
priority forward disable and urgency forwarding. This helps in
priortizing the traffic originating from different interconnect masters
at NOC(Network On Chip).

Changes in v2:
 - Updated regmap_update to make use GENMASK and FIELD_PREP.
 - Removed the regmap structure from qcom_icc_node.
 - Made qcom_icc_rpmh_configure_qos() static
 - Removed qcom_icc_rpmh_map() API, inlined the code in probe
   function.
 - Updated declarations to reverse christmas tree fashion.

Odelu Kukatla (4):
  interconnect: qcom: icc-rpmh: Add QoS configuration support
  interconnect: qcom: sc7280: enable QoS configuration
  dt-bindings: interconnect: add clock property to configure QoS on
    SC7280
  arm64: dts: qcom: sc7280: Add clocks for QoS configuration

 .../interconnect/qcom,sc7280-rpmh.yaml        |  49 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   3 +
 drivers/interconnect/qcom/icc-rpmh.c          | 161 ++++++++-
 drivers/interconnect/qcom/icc-rpmh.h          |  32 ++
 drivers/interconnect/qcom/sc7280.c            | 332 ++++++++++++++++++
 5 files changed, 573 insertions(+), 4 deletions(-)

-- 
2.17.1


