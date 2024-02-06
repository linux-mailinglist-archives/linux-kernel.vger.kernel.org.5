Return-Path: <linux-kernel+bounces-54780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79184B39B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7181F22945
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE5130AEE;
	Tue,  6 Feb 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kc/eAhyA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD6130AC9;
	Tue,  6 Feb 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219137; cv=none; b=eJ7iraAJsAYlQh6KR9C7HUP8kDwx6CIEaCtAipipFaLUxoM1mgic8TgRH9E7OJbP1PIwThB7cXPIg/nOlpLab9g3POC969VD5V7/GNeFEoFU8lSKkKo8HuqMyo/zsQW/w85bgo8+a17XsNeUgmvISTVRlhahqx6rMKx3cPqqSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219137; c=relaxed/simple;
	bh=RgiiVTkv2UIw5nxUPD/uiphokqDs+9ojkYcvt1/ntAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EC4JPBN7IKPYc0RtaIj6s90H0uefTv3SsNsx6xQB9uHMAIKuNxBKgLB+AMboeBq/BcZZRi1OLFPWT6qzCDPRREGIluTY3IPIvl5r9yiTQZTAptCzRVyzzejaruiU0MOo56D9khK2lrYyHekaEocmR0e93xKpAhUDI1CREThonBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kc/eAhyA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416AcWYD007766;
	Tue, 6 Feb 2024 11:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=CVHcz0b
	NbywadoMU6fGB649MjS2WWGGq8j42V2DdIMU=; b=Kc/eAhyA+0VMqJkwEehQkM4
	bi9lULZt1Q3S+gsmtU60Rk0AJ/BVkF1tbtZTXZGtsRx/nydJ0XEENpWoWzWoiky2
	U5/s6r2HCy2iA5prjPMCS2V/SMX3fTApPlQDhIaguPsqgfcw5+ZM0WmXOC4Cu5YI
	Dgli6S/V4bvIL2NYdtkQ0LESDWv4uwYgXrfyGl4IRfqDb9aIxk6Ta8Wz3j+dC/ae
	7Ir12dFLPUuPG4DNvtYQfX+txemJLaEV0PQKKg2S4M8Xe1O2Rx/L279wKuxZVE8u
	/5Ayyf7tHI2pfJ7OJxOAwrZ+iLOCNSDQACzMeTx26c8sncvS5+HO4pMpJdRI3bg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3k6g83jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:32:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416BWAxW000920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:32:10 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:32:05 -0800
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Jagadeesh Kona
	<quic_jkona@quicinc.com>
Subject: [PATCH 0/5] Add support for videocc and camcc on SM8650
Date: Tue, 6 Feb 2024 17:01:40 +0530
Message-ID: <20240206113145.31096-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: TMnJ34t1gw1M_8IL81zplxQuv_hO_cma
X-Proofpoint-GUID: TMnJ34t1gw1M_8IL81zplxQuv_hO_cma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=608
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402060081

Add support for video and camera clock controllers on Qualcomm
SM8650 platform.

Jagadeesh Kona (5):
  dt-bindings: clock: qcom: Add video clock bindings for SM8650
  clk: qcom: videocc-sm8550: Add support for SM8650 videocc
  dt-bindings: clock: qcom: Add SM8650 camera clock controller
  clk: qcom: camcc-sm8650: Add camera clock controller driver for SM8650
  arm64: dts: qcom: sm8650: Add video and camera clock controllers

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    3 +
 .../bindings/clock/qcom,sm8450-videocc.yaml   |    4 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   28 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8650.c               | 3601 +++++++++++++++++
 drivers/clk/qcom/videocc-sm8550.c             |  160 +-
 .../dt-bindings/clock/qcom,sm8450-videocc.h   |    8 +-
 include/dt-bindings/clock/qcom,sm8650-camcc.h |  195 +
 9 files changed, 4002 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8650.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h

-- 
2.43.0


