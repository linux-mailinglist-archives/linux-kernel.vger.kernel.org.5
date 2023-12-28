Return-Path: <linux-kernel+bounces-12431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8481F4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4462839C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A653C0E;
	Thu, 28 Dec 2023 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BHI23pVN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1E1FDD;
	Thu, 28 Dec 2023 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BS4meGo010228;
	Thu, 28 Dec 2023 05:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=L7cHtVRr9rfR
	8SXFuOKy7X1n94uuMmjGNSVxEowJyis=; b=BHI23pVNY7g6E/JtblK2Py9pvGwz
	7VrSDSadULRuQMYMfDT+pwTN+W/nOHgXzrWSaKV/8O1ZOY4fi4z1TvADCXWguFUX
	mnPi/HwFXIEfdRTIWyUYGZkT6QJ0RgXqLX1CE879MC10bxsCt9ido/Lfzfs5ljz1
	4N7ofNxuKo8P4Iis8a0tv23gngVuunfkUs7u8VWhqvSq2QCx15l7ZGPKqJvydPez
	5Yi3rFjOSZdLnHzfdLFusrYLVV4zOR+AFtkXP7X+u9w4oOnu+j5oNGdIMIInKX4/
	lSb8buTC1imNSSoujdG3TvYf/qRreSfLLGAbqkHrkqHzemzlH755EAmRrQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v8pcxs95f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 05:42:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BS5geSu010667;
	Thu, 28 Dec 2023 05:42:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3v5rmkp3ny-1;
	Thu, 28 Dec 2023 05:42:40 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BS5gejL010662;
	Thu, 28 Dec 2023 05:42:40 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3BS5gdwf010660;
	Thu, 28 Dec 2023 05:42:40 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id BA4B756EE; Thu, 28 Dec 2023 13:42:38 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, quic_qianyu@quicinc.com
Subject: [PATCH 0/2] phy: qcom: qmp-pcie: Update PCIe PHY settings for SM8550
Date: Thu, 28 Dec 2023 13:42:35 +0800
Message-Id: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Fen_NCLlBdItntuVwUoSmQVTW-z2m6S
X-Proofpoint-ORIG-GUID: 0Fen_NCLlBdItntuVwUoSmQVTW-z2m6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=264 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280043
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Align PCIe0/PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware
Programming Guide.

Can Guo (1):
  phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550

Qiang Yu (1):
  phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550

 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c             | 20 ++++++++++++++------
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h      |  2 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h   |  2 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h        |  1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h   |  2 ++
 5 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.7.4


