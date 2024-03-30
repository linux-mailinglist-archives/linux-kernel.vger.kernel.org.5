Return-Path: <linux-kernel+bounces-125808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD9892C71
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6F81C21730
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A74084A;
	Sat, 30 Mar 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U7/YWh2G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6F1E865;
	Sat, 30 Mar 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823352; cv=none; b=XkAik0H85trtEHD4q7VIp+W/IXIlWTDkl76TLxjdHMnXD6UZaW9E91jKuaoIsVz2fKhHgLGGfIbUkq72hOqnxz9moQPqBo6arRcnTRHQqmb7xDjGWVKsBbEXVRcY87n5JG3bxoDHikuf7Gzv7iF/BMSVdvSMiYWXhI/QlpYB8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823352; c=relaxed/simple;
	bh=55SM2jVlFCAKPFCdIrCTkGIUnKcgNx9f9IxmCRUYcwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ca/eKyLKqWhVefJ1f/qpDwIOVn5FjHrlQPm6TV/Wr6HSo7dzexbECEW+ItmuOSQiGeHFCAcOcky1EFNZdt3n4K5Msn5O3Mn55WMaN/TOh3KxU8a4cwcdpVQC5a2JKUDHeaO/rNSn6qdPP/uM3/nB0ylreYQnVxvkDy1DwcjtuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U7/YWh2G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42UIOVJm020255;
	Sat, 30 Mar 2024 18:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=8kqEt6M
	coEx8S9EIW8TI/UwkYJDDeKEAhw4F7hRBZ1M=; b=U7/YWh2G7B7GjG+ziWwTv8W
	HihHwx22HAu1IDuOpUJV4KiVCfiJB/pkqTnigfEjbOSvfWgOwAhsmrMVpS20xltY
	X1heaWufIaeIaPyjLIFujan8tKslR3V6wRsRl1pgFuvxPa1eeNSApDRBCCmEb9of
	gDjwvS8nf+++7aSydg63LUaZEK8QxqReqNFmVKly/n+dPZpVcF8qgH0fzblzmh+C
	trQH1DvgJwlVYiQMui0bKuldMxroXbjlLSTpwL4toHc5ov7U/SqbMFb8J9gOd19G
	KithUAKVypkgs/9zgw/O2UghpHXNywINpf4W0UK+1huIo1xpmo7AoWFXGsqkrZw=
	=
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6atwh7qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:28:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42UISrub029278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:28:53 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 11:28:48 -0700
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
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH 0/7] clk: qcom: Add support for DISPCC, CAMCC and GPUCC on SM4450
Date: Sat, 30 Mar 2024 23:58:10 +0530
Message-ID: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: sRYa_RqwOHLtIE8ntR76mUi-gpP2u1pv
X-Proofpoint-ORIG-GUID: sRYa_RqwOHLtIE8ntR76mUi-gpP2u1pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=945
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403300151

This patch series add dt-bindings and driver support for DISPCC, CAMCC and GPUCC
on QCOM SM4450 platform and also includes a fix related to LUCID EVO PLL config
issue in clk-alpha-pll driver.

Ajit Pandey (7):
  clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL
  dt-bindings: clock: qcom: Add DISPCC clocks for SM4450
  clk: qcom: Add DISPCC driver support for SM4450
  dt-bindings: clock: qcom: Add CAMCC clocks for SM4450
  clk: qcom: Add CAMCC driver support for SM4450
  dt-bindings: clock: qcom: Add GPUCC clocks for SM4450
  clk: qcom: Add GPUCC driver support for SM4450

 .../bindings/clock/qcom,sm4450-camcc.yaml     |   63 +
 .../bindings/clock/qcom,sm4450-dispcc.yaml    |   71 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml     |    2 +
 drivers/clk/qcom/Kconfig                      |   27 +
 drivers/clk/qcom/Makefile                     |    3 +
 drivers/clk/qcom/camcc-sm4450.c               | 1688 +++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c              |    2 +-
 drivers/clk/qcom/dispcc-sm4450.c              |  781 ++++++++
 drivers/clk/qcom/gpucc-sm4450.c               |  806 ++++++++
 include/dt-bindings/clock/qcom,sm4450-camcc.h |  106 ++
 .../dt-bindings/clock/qcom,sm4450-dispcc.h    |   51 +
 include/dt-bindings/clock/qcom,sm4450-gpucc.h |   62 +
 12 files changed, 3661 insertions(+), 1 deletion(-)
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


