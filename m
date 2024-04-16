Return-Path: <linux-kernel+bounces-147367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136E8A7300
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F320D2841B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69F135A6A;
	Tue, 16 Apr 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQ0L3SgI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C53134425;
	Tue, 16 Apr 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291667; cv=none; b=JnNaXO5v3HCaCXKMk0xDK5H9zm8zWhUMv5rr0BUW4X3XBsJGXDpROuVP6NyBIqPe3wHu6WM8dzC0uexxyUs/+/GUTMw1Slccg47W9672YGkoZX8VfSEfhW3DgngrIJCo8YSS9IsY0BuP2kKrSRQLeHcOxSb7WEOv0lDTfJTLRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291667; c=relaxed/simple;
	bh=hODAtBoW28GRpf6eK1tEK/y5Fg0Q2GNj9a9v3pFmpPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Asdm0wIVCjnRIZsDsTFrjBsbtHq7u/g8i43Lu5v+desQW4crL+QRFl6t1G0x+8vvovIf7jvu5GXF4BO78YAgnrQHcAJgZxqa0hXTvW461fm80xtT/72bE8af/99IgHBo3vkVt6ND4ipVjsk9fuh1OqhskdIoeruFAVuG4MAVGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQ0L3SgI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GHoal3032568;
	Tue, 16 Apr 2024 18:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=JM6GINH
	US8Wl6DtWq1flatD5230ncoCZTko17XSCQR4=; b=lQ0L3SgI/Dpemq8Yp+odilZ
	N/MHGvsUWKWewcJQBR1kU5sJ5bLvNWnM5ljDEU9nu/1BWghqwz7krSwLLnOJ4lap
	EJsaBXS9DaWZ3YvsNzVWxGj/v79eziU8QMDmE67E/Ks7vExAjRvOnqZqmSDEVj/E
	QBbMRc9q2nSzVnLNbR78hpuplkcY498LlMSaoa/Ah/rHh6A6ioJHOBSI/jwfJQKg
	Jhjxa5ZH6Z1cVLj+IFzSPFGCNTsNz87A8f6HjZ/2f6Jt1d5iOqDKNlrc1CRs+gCb
	Uo57vH83qxnOESqnJG0KquRYunoJYXU3QUUAcafSnnrP2KtPh76cT0GSLax/UIg=
	=
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhx32054r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:21:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GIL1wS032561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:21:01 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 11:20:55 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 0/8] clk: qcom: Add support for DISPCC, CAMCC and GPUCC on SM4450
Date: Tue, 16 Apr 2024 23:49:57 +0530
Message-ID: <20240416182005.75422-1-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: QGfNgU7Spqn1RG8d5DTYBml_E4YlaDtM
X-Proofpoint-ORIG-GUID: QGfNgU7Spqn1RG8d5DTYBml_E4YlaDtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160115

This patch series add dt-bindings, driver and device tree support for DISPCC,
CAMCC and GPUCC on QCOM SM4450 platform and also includes a fix related to
LUCID EVO PLL config issue in clk-alpha-pll driver which is required for correct
scaling of few supported frequencies in graphics clock controllers on SM4450.

Changes in V2:
- [PATCH 1/8]: Updated commit text adding stable kernel signoff for Fixes patch
- [PATCH 2/8]: Updated commit msg and added Reviewed-by: Krzysztof Kozlowski tag
- [PATCH 4/8]: Updated commit text as per review comments in v1
- [PATCH 5/8]: Added Reviewed-by: Dmitry Baryshkov tags received in v1
- [PATCH 7/8]: Fixed duplicate reset entries warnings
- [PATCH 8/8]: New patch for adding dispcc, camcc and gpucc device-tree nodes
- Link to V1: https://lore.kernel.org/all/20240330182817.3272224-1-quic_ajipan@quicinc.com/
 

Ajit Pandey (8):
  clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL
  dt-bindings: clock: qcom: add bindings for dispcc on SM4450
  clk: qcom: Add DISPCC driver support for SM4450
  dt-bindings: clock: qcom: add bindings for camcc on SM4450
  clk: qcom: Add CAMCC driver support for SM4450
  dt-bindings: clock: qcom: add bindings for gpucc on SM4450
  clk: qcom: Add GPUCC driver support for SM4450
  arm64: dts: qcom: sm4450: add camera, display and gpu clock controller

 .../bindings/clock/qcom,sm4450-camcc.yaml     |   63 +
 .../bindings/clock/qcom,sm4450-dispcc.yaml    |   71 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml     |    2 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi          |   35 +
 drivers/clk/qcom/Kconfig                      |   27 +
 drivers/clk/qcom/Makefile                     |    3 +
 drivers/clk/qcom/camcc-sm4450.c               | 1688 +++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c              |    2 +-
 drivers/clk/qcom/dispcc-sm4450.c              |  781 ++++++++
 drivers/clk/qcom/gpucc-sm4450.c               |  805 ++++++++
 include/dt-bindings/clock/qcom,sm4450-camcc.h |  106 ++
 .../dt-bindings/clock/qcom,sm4450-dispcc.h    |   51 +
 include/dt-bindings/clock/qcom,sm4450-gpucc.h |   62 +
 13 files changed, 3695 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
 create mode 100644 drivers/clk/qcom/camcc-sm4450.c
 create mode 100644 drivers/clk/qcom/dispcc-sm4450.c
 create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-gpucc.h

-- 
2.25.1


