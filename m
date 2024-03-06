Return-Path: <linux-kernel+bounces-93429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F4872F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6786D2884E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387925C906;
	Wed,  6 Mar 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TnIrw/2H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284F179BF;
	Wed,  6 Mar 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710246; cv=none; b=tevZK5tv65e/YaPa8zNL5867RGxEcFBbgZo5bG0TI4soeyqTWbc/2qktsQUbAD7UVBCey91DrzZhobwiUE2txYiZnZLyZGVvEGGrjK4xTnmuR2eA34KaOAi7VgobF77tco4rMGH4QeLS/yBcDCUXuisn6Al3ig1Q3cEcX5kBxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710246; c=relaxed/simple;
	bh=6q5uA0GAwycbAH8Lnrl1xYpzxrxn3OajUQval+uTsoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dCW3WgFhQcIE3ci+xUHcn4zSSRQZol7zM4CR0oJywgLtoZln/6jYUdR/YGHRatieriA7hj8kS7yEgd/CL0napvtcIgR4E5/pbVOVqQMii05WrtsF7ueuE5fjv0NIZ8DLC1lBCtJC1lqQGnjyIGgUECv7GAHYKej+ahBcWFtwSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TnIrw/2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266Cswc026368;
	Wed, 6 Mar 2024 07:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=6jE+7DI4Z/+mUo2eFwCdooyjM8NPLVjM8BsLoV6q+lQ=; b=Tn
	Irw/2HphdgD5+4FTGg5UB3nS4wFgaku6Wlt6gvf3c2ywEJ8Woyh8sjqS5ax9w4pQ
	ordJH5jl2sFlJ0bp1hRHmjL3SXludfqe3CSknjNY9L+ysz+6AuL3XKqAOKpL9lqB
	WukjEpdMB0jSIz6+E/XRSfdmmoeStoIOKrN57agJEsSlfkvTVFjils/60w4tbp9u
	e15R5k0Qzl0NX0FLV9b48q97mEDyj4SCJBcr6BrkhQxLRfmzlPQHjBmzZTATjuLZ
	I0nFUIlxGSY/Tk+2VSPl70VFB9Ve71VF5jBPLxi+TJFjXvuC9iYGw+ztJ5YsTD76
	4VID0U08PKHkJAfRV1wQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp2bptc7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 07:30:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4267Ud1i003736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 07:30:39 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 23:30:34 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
Subject: [PATCH v3 0/4] Add support for QoS configuration
Date: Wed, 6 Mar 2024 13:00:12 +0530
Message-ID: <20240306073016.2163-1-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aaNk1uEvHlCnHBztBJlXLYPtecOwAze1
X-Proofpoint-ORIG-GUID: aaNk1uEvHlCnHBztBJlXLYPtecOwAze1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=883
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060058

This series adds QoS support for QNOC type device which can be found on
SC7280 platform. It adds support for programming priority,
priority forward disable and urgency forwarding. This helps in
priortizing the traffic originating from different interconnect masters
at NOC(Network On Chip).

Changes in v3:
 - Skip QoS programming incase regmap failse and continue with probe.
 - Defined all the qos structures as const.
 - Fixed compilation issue occurring with arm-linux-gnueabi- toolchain.
 - Removed enable_qos_deps() and disable_qos_deps() as no explicit
   voting is needed for BCM before sync_state.

Odelu Kukatla (4):
  interconnect: qcom: icc-rpmh: Add QoS configuration support
  interconnect: qcom: sc7280: enable QoS programming
  dt-bindings: interconnect: add clock property to enable QOS on SC7280
  arm64: dts: qcom: sc7280: Add clocks for QOS configuration

 .../interconnect/qcom,sc7280-rpmh.yaml        |  49 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   3 +
 drivers/interconnect/qcom/icc-rpmh.c          | 105 ++++++
 drivers/interconnect/qcom/icc-rpmh.h          |  32 ++
 drivers/interconnect/qcom/sc7280.c            | 332 ++++++++++++++++++
 5 files changed, 521 insertions(+)

-- 
2.17.1


