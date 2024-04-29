Return-Path: <linux-kernel+bounces-161967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816468B53ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6681F22050
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089A20DDB;
	Mon, 29 Apr 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eO95AKU6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC517C7B;
	Mon, 29 Apr 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382021; cv=none; b=gwT1OwFlOwIfG/+4ZSIzdign66ow44qgmYk0mfHqm7MxZvYEdoaLebiUz4Vld4rMOi0oCH+dCtGNIPI4Oy1rzeherun9w7dksL3ME9rBQcCQk1C+2hUU+bq1OjAcXvcu5oJzawRMsCz+aNkmozqblEbFTbkhS9pO/pNYNl/zmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382021; c=relaxed/simple;
	bh=K71V5vlJ0l5Mbq96TatTk0xq4Q/ldrz0Y63gizbVfqA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kUfBCbDqh4hfbdJxOs6lHknimVTV2H/Xjk+ugj0f1fmDbi4q45mmibrNZ7AJntyiclyVfux22RMEL3LH5VJ8fDIRgti965CiaHvZ55Z6HVUhrL0YzHSQvwxLxJCwC5KPXXRaM6BBZK5YtEn/6Vcd0CY453Qp60PZySNwdPnm98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eO95AKU6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T6hJn5005455;
	Mon, 29 Apr 2024 09:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=A2PJigd
	t3jsok0gJZPi5HW71LprbEkA7YcePw8ftflA=; b=eO95AKU6pVQdOUem4Nc8Di+
	qrLtZugxAYK/VGlmJOKmIsQ1IQVxeSHgoBUe/C9P2QPqDGy93AzQywcbIyHMgmw1
	Y+4f2b4QaeHAtqjFcvQtf/rGeXiQEV6uqcyi3bUabfHoXObmG+yEwcQlNYIQ0r8u
	okurbY2ZeFOVozQbMGBDIbDivKPoD59VIlyylAQD1q/AELeThYXpZhQifqCcGwXd
	iY43ScdzYDONwhz6aQXsfHcbBopN9pmguICMzsLFzxk6u5fjDTIE9weug+6B/Bpb
	0+Ywjlf9klk8PusFskd0GxRExwgQB97din6AJuxe9l/xhxr1+c7eJkbvMIvdHnw=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrtnek5ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:13:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T9DYuQ002665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:13:34 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 02:13:28 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v10 0/6] Add interconnect driver for IPQ9574 SoC
Date: Mon, 29 Apr 2024 14:43:08 +0530
Message-ID: <20240429091314.761900-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: auyb5XcgAvBiWe0FjoJ8DNh9Ki9x_ai6
X-Proofpoint-ORIG-GUID: auyb5XcgAvBiWe0FjoJ8DNh9Ki9x_ai6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=978 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290057

MSM platforms manage NoC related clocks and scaling from RPM.
However, in IPQ SoCs, RPM is not involved in managing NoC
related clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for the accessing the peripherals present in the
system. Hence add a minimalistic interconnect driver that
establishes a path from the processor/memory to those peripherals
and vice versa.

---
v10:	Set gcc-ipq9574 driver's sync_state to icc_sync_state
v9:	Squash icc-clk driver change and cbf-msm8996 change
	Remove HWS_DATA macro
v8:	Change icc-clk driver to take master and slave ids instead
	of auto generating
	Remove ICC_xxx defines from dt-bindings header
	Define MASTER/SLAVE_xxx macros from 0 .. n

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

Varadarajan Narayanan (6):
  interconnect: icc-clk: Allow user to specify master/slave ids
  dt-bindings: interconnect: Add Qualcomm IPQ9574 support
  interconnect: icc-clk: Add devm_icc_clk_register
  clk: qcom: common: Add interconnect clocks support
  clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq9574: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
 drivers/clk/qcom/Kconfig                      |  2 +
 drivers/clk/qcom/clk-cbf-8996.c               |  7 ++-
 drivers/clk/qcom/common.c                     | 35 ++++++++++-
 drivers/clk/qcom/common.h                     |  9 +++
 drivers/clk/qcom/gcc-ipq9574.c                | 33 +++++++++++
 drivers/interconnect/icc-clk.c                | 24 +++++++-
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
 include/linux/interconnect-clk.h              |  4 ++
 10 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

-- 
2.34.1


