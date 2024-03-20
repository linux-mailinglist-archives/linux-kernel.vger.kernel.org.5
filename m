Return-Path: <linux-kernel+bounces-108985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC2881303
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E4528721C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E147F4D;
	Wed, 20 Mar 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ALC9CsWd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84E3D54C;
	Wed, 20 Mar 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943927; cv=none; b=mijRua6RVuapXqhaSVNSOrdtVcY+JTr2uVea06zIb6nW7S4LyfGew49DllMr5vY2D428hSvdggZI8x6BwHx92/RHe6oyC84gnjEl9ivHTTaUUOu83JmpOPEPcGMATDP5zsXY1bgvKnlsYkf8w2V4788x7qG6fSQTMKMUHR1ulXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943927; c=relaxed/simple;
	bh=/wW9qV6LAOXG8LnFEJPA92NidE+3pnPBB81s5eFrFNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mQDyQ4vdpFJqln2AsZa2kK9Reac0sE3wovdPpCzgZWd6UXfDGINKjt902XSSJxTIvwBc6be+zVuVCFRKd7c9GI8foGP/d4jyTJ4LlcDq+EWAomiVB8A+lt58VKodSRSUmXpdTutpGp3hJiO9rGgMsx4+ZSDg8LyHW4qndGQ9ZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ALC9CsWd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KBiL0n023907;
	Wed, 20 Mar 2024 14:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=uun1x6wlhePjdPPNDRFv
	nmrO5PRMdYD+vhZxiorrl3M=; b=ALC9CsWd+r6PGesaJNlJxuk+0sG4nxk6QYh9
	arOnlqJhCDWjopobaCrk2LzzaYT81O8/cTjojuajxUNi0hG39PIwSMMtRg/Ta1KA
	Sn/cz15Yj0mlQPOoomg73V7Sng9YoFflS9OACMf6134ezAMCywFEo3MA5nK2v4LT
	5UYN+LN1J4NOYk9flChWsF2kQSevwvo2L14yQiK/7Jdw6FpsOCla2fHnv26joTxE
	nsg490eh1MnawGJdKhc9ZruaeQGIRadsDOFA346zFA/UQLzqVJRnuDEwBrk571Ew
	6sONU/JkSqHH2a9gg0gQSqovG39hAZUukffnMZzB5SJavD0I9Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyqh61ar0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:11:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KEBtNO021036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:11:55 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:11:52 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/8] media: qcom: camss: Add sm8550 support
Date: Wed, 20 Mar 2024 19:41:28 +0530
Message-ID: <20240320141136.26827-1-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fagcg5QOGsoQwjwSCe13vQMrWKUl7-0F
X-Proofpoint-GUID: fagcg5QOGsoQwjwSCe13vQMrWKUl7-0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=846 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200112

V2:
- Update some commit messages
Link to V1: https://lore.kernel.org/all/20240320134227.16587-1-quic_depengs@quicinc.com/

V1:
SM8550 is a Qualcomm flagship SoC. This series adds support to
bring up the CSIPHY, CSID, VFE/RDI interfaces in SM8550.

SM8550 provides

- 3 x VFE, 3 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE
- 3 x CSID
- 2 x CSID Lite
- 8 x CSI PHY

This series is rebased based on：
https://patchew.org/linux/20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org/

The changes are verified on SM8550 AIM300 board, the base dts for AIM300 is:
https://patchew.org/linux/20231117101817.4401-1-quic._5Ftengfan@quicinc.com/

Depeng Shao (3):
  media: qcom: camss: Add new params for csid_device
  media: qcom: camss: Add CSID gen3 driver
  media: qcom: camss: Add sm8550 support

Yongsheng Li (5):
  media: qcom: camss: Add CAMSS_8550 enum
  media: qcom: camss: Add subdev notify support
  media: qcom: camss: Add new csiphy driver 2-1-2
  media: qcom: camss: Add new VFE driver for SM8550
  media: qcom: camss: Add sm8550 resources

 drivers/media/platform/qcom/camss/Makefile    |   3 +
 .../platform/qcom/camss/camss-csid-gen3.c     | 639 ++++++++++++++++++
 .../platform/qcom/camss/camss-csid-gen3.h     |  26 +
 .../media/platform/qcom/camss/camss-csid.c    |  19 +
 .../media/platform/qcom/camss/camss-csid.h    |  10 +
 .../platform/qcom/camss/camss-csiphy-2-1-2.c  | 343 ++++++++++
 .../media/platform/qcom/camss/camss-csiphy.c  |   1 +
 .../media/platform/qcom/camss/camss-csiphy.h  |   3 +
 .../media/platform/qcom/camss/camss-vfe-780.c | 455 +++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c |   7 +
 drivers/media/platform/qcom/camss/camss-vfe.h |   3 +
 .../media/platform/qcom/camss/camss-video.c   |   1 +
 drivers/media/platform/qcom/camss/camss.c     | 395 +++++++++++
 drivers/media/platform/qcom/camss/camss.h     |   8 +
 14 files changed, 1913 insertions(+)
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.h
 create mode 100644 drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-780.c

-- 
2.17.1


