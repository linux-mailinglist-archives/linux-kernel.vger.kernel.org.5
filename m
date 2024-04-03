Return-Path: <linux-kernel+bounces-129590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BB896CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C8028B5C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A43143889;
	Wed,  3 Apr 2024 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pMqWthw/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622B143874;
	Wed,  3 Apr 2024 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140962; cv=none; b=aF0UaTPT6V7qDHAx6a3P5C8l+LXHzxp2d9LdQH7mOcRZIl7zjVQcp8AppiBRW+pXDnhqfu95D7JnFCyrGBPbVGfD/e0r6lyo+4Ij1CBxnqmZKwZ7JFJL/++Knm9nNbG883syqIf5kkQEWTAgP+uEuTeqf7eyqWk52gqAYao0rRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140962; c=relaxed/simple;
	bh=e4j6cfrHaaHCrFec1tqnvuZ8iYnYtRh9G16FJOoCfS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+1dZzh5guf2oDaUAcsTXVMSGePUbmFaFN002uw0Zu9vQ/DVznZ4SRzELqKo/uaBAFhOKSOOqWy2fhvI42PiyiwUD14JJB8Zh/Fky5GZjTUE10w25YQ5WxBT00KTPcolGzm6HjwycOL8pKH7G0tNWWoa3HrqAaxcYO8xOUAeBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pMqWthw/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43386MEr015094;
	Wed, 3 Apr 2024 10:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=JpieIyE
	kDxsw3072e1J13lEaIa/3khLxcjiUmz1Ptjg=; b=pMqWthw/72gLoncYjf2zHhj
	2V5S/GdLrWv8EKCL/Z5IgH04JVKmdeSVVkhhqXFAbDIYaeX3FxbfWQGuxnAlHux4
	gV69dFWOMT/6TdDTuKw7fX4qmLPYc6ftjFTsRNFrABwYPcWOU9nkIoZs2IwJemos
	aYtw8zg7I7Tt0Cb0Qm7ffKVdaTBGWslPfZP7NEJZqWwj3/uXqAAghGtg/NMcrEAf
	V+qWz5C3xhd847dpLoFiXrv1euPc4elhSFhPUpjqcRB5Eo7Ut1p5f2fGS1Svm8R/
	EBLui2i1pVn3tI355qYpl5OnUNmdYwyQNLDEwtkkZClgQ2pBQ7agU58S0F0QJlg=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93a5gbhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:42:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433Agapm026194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:42:36 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:42:31 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 0/5] Add interconnect driver for IPQ9574 SoC
Date: Wed, 3 Apr 2024 16:12:15 +0530
Message-ID: <20240403104220.1092431-1-quic_varada@quicinc.com>
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
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wQW29ViqT1UpRccDJglcqQ5GhGrHEc1u
X-Proofpoint-ORIG-GUID: wQW29ViqT1UpRccDJglcqQ5GhGrHEc1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1011 suspectscore=0 mlxlogscore=980
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030074

MSM platforms manage NoC related clocks and scaling from RPM.
However, in IPQ SoCs, RPM is not involved in managing NoC
related clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for the accessing the peripherals present in the
system. Hence add a minimalistic interconnect driver that
establishes a path from the processor/memory to those peripherals
and vice versa.

---
v7:	Fix macro names in dt-bindings header
	Do clock get in icc driver

v6:	Removed 'Reviewed-by: Krzysztof' from dt-bindings patch
	Remove clock get from ICC driver as suggested by Stephen Boyd
	so that the actual peripheral can do the clock get
	first_id -> icc_first_node_id
	Remove tristate from INTERCONNECT_CLK
v5:
	Split gcc-ipq9574.c and common.c changes into separate patches
	Introduce devm_icc_clk_register
	Fix error handling
v4:
gcc-ipq9574.c
	Use clk_hw instead of indices
common.c
	Do icc register in qcom_cc_probe() call stream
common.h
	Add icc clock info to qcom_cc_desc structure

v3:
qcom,ipq9574.h
	Move 'first id' define to clock driver
gcc-ipq9574.c:
	Use indexed identifiers here to avoid confusion
	Fix error messages and move code to common.c as it can be
	shared with future SoCs

v2:
qcom,ipq9574.h
	Fix license identifier
	Rename macros
qcom,ipq9574-gcc.yaml
	Include interconnect-cells
gcc-ipq9574.c
	Update commit log
	Remove IS_ENABLED(CONFIG_INTERCONNECT) and auto select it from Kconfig
ipq9574.dtsi
	Moved to separate patch
	Include interconnect-cells to clock controller node
drivers/clk/qcom/Kconfig:
	Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK

Varadarajan Narayanan (5):
  dt-bindings: interconnect: Add Qualcomm IPQ9574 support
  interconnect: icc-clk: Add devm_icc_clk_register
  clk: qcom: common: Add interconnect clocks support
  clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq9574: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
 drivers/clk/qcom/Kconfig                      |  2 +
 drivers/clk/qcom/common.c                     | 31 ++++++-
 drivers/clk/qcom/common.h                     |  3 +
 drivers/clk/qcom/gcc-ipq9574.c                | 30 +++++++
 drivers/interconnect/icc-clk.c                | 18 ++++
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 87 +++++++++++++++++++
 include/linux/interconnect-clk.h              |  2 +
 9 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

-- 
2.34.1


