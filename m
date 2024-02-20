Return-Path: <linux-kernel+bounces-73111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A585BDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE491F24FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986066A8AC;
	Tue, 20 Feb 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n/TvDHt4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270369D1D;
	Tue, 20 Feb 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437188; cv=none; b=bVbCwIuxTZ0yDrQ5xWW6EeOFxT2yA3jikdbKLBjL/1BgR6GLg2ySwRXc1dSj0d0JZHD2l7HZ+vqPeqErUkIkNGYr5GA9C2idaD2xgh4PYqKVgBRdGUw9guFjP0SNdRJTkFOAy1hJ1kPfbVo5Uu2z3TNqdSDd1qcg99bXuFBGy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437188; c=relaxed/simple;
	bh=heFc3g7/7gfo7I5atrOXHORFAPMkPY7A83Jd6oIvuAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NnZx4k+94XDDaZQsWW8StcVLAB1BB5qxGXgI0jNUjl+QIWozkWZgi0duX+mqMYADzFSRc/EgrfYdpU67BE+NBCgPFv+/uiL0PeDb+A5tkSbYxbmETw1mWZjnK+emCM6pnXK5kQc7yTFR9twcMIcIq6CaxM3Q/fSAAPlC7rK777g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n/TvDHt4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KBjMJq006158;
	Tue, 20 Feb 2024 13:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Q57xU6q
	M9jPsPG8qr9iZUr85/xQUrT3sfYvqBxHqQgE=; b=n/TvDHt4E/q3OJ8ugft+xOK
	D4aFi2L+4TiUacBB9czzAUh6oq1Qkd+FvQksYMSHwNc6BSvHk+GX+xJLikddP0Vc
	LaPh+ajLn60QxIPmskTjqPa3e73Oc0WrsQ+aov4XueVxaFLbh6dt4mOI1Oos2fA2
	wwlPrepddXWy4L1sn5/bzBT5cqjUQeQC/hyRLWKYMf2Rrdx8+LFls56pr9LOCGhQ
	ORyTtWUSvsgfvBP3iys5eTv719WH8RN8w4yumSbB4WcKRUvb5PRG9HvETVesvz5B
	O6FyAUO12QXACCyIV5ZzbHvZNmUXG9JHTbZZMfskrK4rmi/uzh+iWqV4VXm5dlQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct2sgdby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:53:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KDr1Bt026482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:53:01 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 05:52:56 -0800
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
        Jagadeesh Kona
	<quic_jkona@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>
Subject: [PATCH V2 0/6] Add support for videocc and camcc on SM8650
Date: Tue, 20 Feb 2024 19:21:15 +0530
Message-ID: <20240220135121.22578-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: MgexlH33WnSoN0_P2teTqo73yqpPq9GM
X-Proofpoint-ORIG-GUID: MgexlH33WnSoN0_P2teTqo73yqpPq9GM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200100

Add support for video and camera clock controllers on Qualcomm SM8650
platform.

Changes in v2:
 - Updated commit text for videocc dt-bindings patch as Krzysztof suggested
 - Moved videocc XO clk ares to a separate patch and added fixes tag as per
   review comments
 - Inverted the logic in videocc probe to add new SM8650 specific videocc
   clocks based on SM8650 compatible string as Dmitry suggested
 - Used module_platform_driver() for SM8650 camcc driver
 - Updated driver name from cam_cc-sm8650 to camcc-sm8650 as Bryan suggested
 - Used qcom_branch_set_clk_en() helper to enable clocks in camcc sm8650 probe
 - Added Krzysztof and Bryan Reviewed-by tags to dt-bindings and camcc patches
   received in v1
 - Link to v1: https://lore.kernel.org/linux-kernel/20240206113145.31096-1-quic_jkona@quicinc.com/T/

Jagadeesh Kona (6):
  dt-bindings: clock: qcom: Add SM8650 video clock controller
  clk: qcom: videocc-sm8550: Add support for videocc XO clk ares
  clk: qcom: videocc-sm8550: Add SM8650 video clock controller
  dt-bindings: clock: qcom: Add SM8650 camera clock controller
  clk: qcom: camcc-sm8650: Add SM8650 camera clock controller driver
  arm64: dts: qcom: sm8650: Add video and camera clock controllers

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    3 +
 .../bindings/clock/qcom,sm8450-videocc.yaml   |    4 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   28 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8650.c               | 3591 +++++++++++++++++
 drivers/clk/qcom/videocc-sm8550.c             |  154 +-
 .../dt-bindings/clock/qcom,sm8450-videocc.h   |    8 +-
 include/dt-bindings/clock/qcom,sm8650-camcc.h |  195 +
 9 files changed, 3986 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8650.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h

-- 
2.43.0


