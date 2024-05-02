Return-Path: <linux-kernel+bounces-166173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE88B9724
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF7F1C21311
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7355C33;
	Thu,  2 May 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h0Tw1/gm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD1524D4;
	Thu,  2 May 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640646; cv=none; b=ZqxouXgMzW6Hlk205DW92mktQwfx6jTpIRXJezTSJ3rMCpPkewV+nNfvlMzYPrdimnGuW1U8BgqyolTAuigx1JpfQhLPMRbuH1FwixuRIooVn9UVv5VlE96BZQvUN2/A43t8lC5mfXsSTAduE11bBOHNv5jdg/5Bdp/9bY/K0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640646; c=relaxed/simple;
	bh=/dLzXBWO2gX67x6MrYoCiCNImnc6++eIecsIUiMMaRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKO83diD4seQLJMWV6IQpTb7qw1A/wr0htalOR070KXGLonpxHhfNvi19blg+CNBIHM+ZSzuZ3Sl2aaiC9/a3Ce9pUdi6FLEMmu8MhZn+37JClqg44WoQXQbCYZdPJ+IZYa6ChIE9Ul3nnjboHwukYU1IMqstdgyrjWul19a2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h0Tw1/gm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4427iTur005893;
	Thu, 2 May 2024 09:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=GvTyKXX
	MsPRuSwaky8m+AKhm17G0F14YTIxoxZkYJAU=; b=h0Tw1/gmHgy/rvBo7OHFxpF
	b8n+1v4j0PA9s0q1Y2u3t1k4ggLkt8KJk62GnsolQXoWz5GsBftS+1DOEiBn6ov3
	p86TWTqOkU8oxF9KEMOGfUMLqghFoE/qP7iHTojB3dFQ6v5CfD3Svdw0jCJcn315
	noVj6Q2jE624ey65TXN+XU/hbgiBUfWu6dgFcpPyjKlinMCOMcFswwxKQtS1+iH4
	DoK09RmbokgEJS28NusW4gT9rb+bth/5Ez+/ziz0QTbEba4SwuSaSxCavH/1Xllc
	2Ism02RcwiXd8i61beQuhkNjSt2kR6SGhmMgTRVBZAq4cXXfnU2hofSEk3wUlEA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv6q0r4mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:03:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44293mI4004314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 09:03:48 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 02:03:44 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_ppratap@quicinc.com>, Jack Pham
	<quic_jackp@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 0/3] Add devicetree support of USB for QDU/QRU1000
Date: Thu, 2 May 2024 14:33:23 +0530
Message-ID: <20240502090326.21489-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -E_ChrEKDEc3R7aRPsF_Ax-lbipTMZ44
X-Proofpoint-GUID: -E_ChrEKDEc3R7aRPsF_Ax-lbipTMZ44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=15 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=15
 mlxlogscore=77 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=15 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020053

This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
This is based on previously sent driver series[1].

------
Changes in v3:
* As per comments on upstream[2], to get role-switch working on QDU/QRU1000, it was recommended to
  use the actual TI switch driver. Since driver doesn't have the functionality to provide role-switch
  based on gpio, thus reverting back USB dr_mode to peripheral and removed the remote end-point nodes
  and usb-conn-gpio based role switch functionality.
* Link to v2: https://lore.kernel.org/linux-arm-msm/20240319091020.15137-1-quic_kbajaj@quicinc.com/

Changes in v2:
* Changes qmpphy node name
* Changes dr_mode to otg and added USB-B port USB role switch
* Dropped maximum-speed property from usb dwc3 node
* Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/

[1] https://lore.kernel.org/linux-arm-msm/20240502082017.13777-1-quic_kbajaj@quicinc.com/
[2] https://lore.kernel.org/all/CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com/
------

Komal Bajaj (3):
  arm64: dts: qcom: qdu1000: Add USB3 and PHY support
  arm64: dts: qcom: qdu1000-idp: enable USB nodes
  arm64: dts: qcom: qru1000-idp: enable USB nodes

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  23 +++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 120 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  23 +++++
 3 files changed, 166 insertions(+)

--
2.42.0


