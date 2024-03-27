Return-Path: <linux-kernel+bounces-120757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DAC88DC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B7B26AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF182D76;
	Wed, 27 Mar 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SwdyOGiG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197381ADD;
	Wed, 27 Mar 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539233; cv=none; b=r33yQLDr7xAKrdfArq7Lo99cYjM4wvxlQAy5C1zcLYUDE1U4xwCzD55pm1rn/JRjZ3a7Tx3gdpW9r4dmfHRF/hKZhaGjPYvNbC7V3sLWguCBHxtecHRyzs7EztBE3IFINBGZIl7jowf2ic0zowGcFaB9CYTPtlQAeD35KjG5CWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539233; c=relaxed/simple;
	bh=1uRX+LFK9ACG0P83mcxgeNcdbQe8Tg17DWd/NzG+6QY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1x3aEjq2Edg5mXG8VhRm9iBuungFakEEUyeHlqjCt4maVnJETclcXQssM+rTZm6KCBiM8W0bGZ7uDMYhUBxkt7i1APBiflLBo0HmDKqnr2qfj2f/DBYBy/WP4EyBUiHp+RiyQKPXn6FYTuaXeEVgc1aKH1TJTO1/O/hexokv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SwdyOGiG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RARiEo016204;
	Wed, 27 Mar 2024 11:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=F8nnrAY
	YD24VYxXTCTznp7ojEShAiC4FxDB9phAZKrA=; b=SwdyOGiGjpGrrRg5xTePVQP
	arOWl7FDVcEQrI5tZbSJhpTH6ooS11h4OJXxLpA0NOZGn+qbiQX5f+ql3FcRo2A9
	G0liKhRQLiQDUrYGZFC0wUeQ8BY8BQx1Yrl4E53svPNkDm/OVgKbMfkC2LfFXFTo
	cRid0bvA5AW9TTeyddG6N3k1jNWQVd9IdKDuUYv4rQ+Jst7+yWJNMeCVkPDaHv46
	WRsN33HoQamduaLqFchrsQW3Otlfd9QXJFvl4P4eezZ14j1YcwdyDL+aE8dNpK4R
	2ZJBqNP+hoTcbvLZ8JeyWXAbc8Q9K7igVWYc7XIxMlv33+mspmsnRZKHKClupHQ=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x47811jny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:33:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RBXOLf016159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:33:24 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 27 Mar 2024 04:33:20 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lgirdwood@gmail.com>, <tiwai@suse.com>, <quic_rohkumar@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v1 0/2] ASoC: qcom: add support for qcm6490 machine 
Date: Wed, 27 Mar 2024 17:02:26 +0530
Message-ID: <20240327113228.1706975-1-quic_mohs@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z3lhqVGDh-Q4A-UDq2D14sWQ0erGGnnZ
X-Proofpoint-ORIG-GUID: Z3lhqVGDh-Q4A-UDq2D14sWQ0erGGnnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=976 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270078

This patchset adds support for QCM6490 SoC machine driver.

Mohammad Rafi Shaik (2):
  ASoC: dt-bindings: qcom,qcm6490: Add qcm6490 snd qcs6490 sound card
  ASoC: qcom: qcm6490: Add machine driver for qcm6490

 .../bindings/sound/qcom,sm8250.yaml           |   2 +
 sound/soc/qcom/Kconfig                        |  13 ++
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/qcm6490.c                      | 173 ++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 sound/soc/qcom/qcm6490.c

-- 
2.25.1


