Return-Path: <linux-kernel+bounces-166108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B998B964A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87111F23C83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AEF3B2BD;
	Thu,  2 May 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oi/AB/7b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF7200A0;
	Thu,  2 May 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638057; cv=none; b=gDqzWJ/s68zaZRcAm4/KstiBuDkg9+Z3r4+07t5hIEoOC/0iRB2f2NYbMdhuXNoVfhpvSyWikwemn9FiZ6xyPBaib0ICIta4ujGvEGPRIcsclXOfu58XeEmjfHGEXSGLXrjV7hQkj/DkBaIWACaSbDBpLMr2n38E/ZWza++SpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638057; c=relaxed/simple;
	bh=JRP1C4tqQlxK4NLWWPLJvI/cQ8Kj8zg8QmQoKw9MykQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ns1M8JPSsYTkZf7sXkWh5K/2ZPwMEDjQ5ygy83Urs/g9xJ7WoI3NI1zZERkXn2Aobll/TQyZci48TQHiwUzdCDguS9AjRCGacd9KP88PEQSjFYwueZ0VdPrlQTSCDWUCT5seDxwcosFfx3lxxveqePmIhUm0xB4SUwJS8SaG20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oi/AB/7b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44279je0026169;
	Thu, 2 May 2024 08:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=hwjiGiF
	W4B0QrctQsPizBFbOT8HPimNZ3ywMU1YKCDk=; b=oi/AB/7b6fb3DW7ZfAaUKsy
	JKVPXwDyE6CvUYt1n3/IAP8Y2IHtxJG0FcIvLdPLWQsUEW6spM9O8bVKfzvhI1Bv
	XlZkqjjH1uvTJeFMjnHCV6wSYdzcF0lYyCSRPOa5AGdO7jCm6skkutcO7m04zMTl
	V5xD0T13uMXxUVAKBrRzSmN46Mjgioe07rxk0C1dd2lZhEkM/I56wnjVYR0RvKfn
	qbJYACk0f0tXnnH0OixtQ1NO2TQVHv0uAOCZA0Gqpkc6M4HCB2pOAZ+pAjAASsGu
	099lRJFiVKLXUfTua5D2VKKMOBpiWnXh8eOIYzGWYUrCroU1378OKTZH9RonMyA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu71jbddm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 08:20:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4428KerY007755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 08:20:40 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 01:20:34 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Mantas Pucka <mantas@8devices.com>, Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>, <quic_ppratap@quicinc.com>,
        Jack Pham
	<quic_jackp@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 0/4] Add USB Support on Qualcomm's QDU/QRU1000 Platform
Date: Thu, 2 May 2024 13:50:13 +0530
Message-ID: <20240502082017.13777-1-quic_kbajaj@quicinc.com>
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
X-Proofpoint-GUID: Alqeo4YeGFiNkuwSa-v7rUG0pV7cr2nM
X-Proofpoint-ORIG-GUID: Alqeo4YeGFiNkuwSa-v7rUG0pV7cr2nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=589 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405020049

This series adds support of USB3 PHY support for Qualcomm's QDU/QRU1000 Platform.

---------
Changes in v3:
* Rebased on linux-next
* Link to v2: https://lore.kernel.org/linux-arm-msm/20240319090729.14674-1-quic_kbajaj@quicinc.com/

Changes in v2:
* Dropped extra lines
* Sorted the tables alphabetically
* Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/

Komal Bajaj (4):
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
  dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
  dt-bindings: usb: dwc3: Add QDU1000 compatible
  phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  2 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |  1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 47 +++++++++++++++++++
 4 files changed, 53 insertions(+)

--
2.42.0


