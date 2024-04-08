Return-Path: <linux-kernel+bounces-134787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB389B6E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823731C20AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9814287;
	Mon,  8 Apr 2024 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BhFaME95"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA6747F;
	Mon,  8 Apr 2024 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550340; cv=none; b=RJWJfZKloErgUwwoE1QVn7gyaJQ5OgZ150FZfnzKxu31jh0W56yN4nOThoq9XdTI+md/AHB4DeBPSb8LCkz8/wB5waEt44jIPTZPBxbj3a1DRQBO0dVsnkN4kVhxRth+j/E2n5BaTql872oOtaOMV8+IpdZlBaTcHBK2DnnzAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550340; c=relaxed/simple;
	bh=Z4CsF2281mZmL7xf7ynNJXP+RNbaJ8x8o9H19nrf1V8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKZ7wwW/jrmzOnteRDcbNX5TsX1ZRWI/GjMznl268Axh1l6PWFdAI9M79V6xqEvb5KT8ZoKeSYjro08u/8SKO7aoFAL4nZdkBzebLBA83sS10/BUeh7dPehWMVxsneLd9r9m2wN4+BFPc9jy77yV2XMIFMvTAhOwADipS0yc8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BhFaME95; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43840ENc012334;
	Mon, 8 Apr 2024 04:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6naomMVvQqPbfJJOQtxuDorZsTKMcpI7bZfiKtjJCgM=; b=Bh
	FaME95INVlRnsXxHXEPxX/gca3zoc6GK08+tigqoYKhO1ZFgBY9poMAk0APHYAca
	TL9gGn95LTZ0LneGpLfRk19v/4oPHekxQqavlz+dXOSV9ItvaniByiDKmhCtTYda
	pKUwOunhpMCJd5jT4QsTAXp62Siwin15P5/GGwHXKeN8EOd87iZQ6lgOywOI8sbM
	nbdvznLJUUfhbjTl9A+/sj3dcP1udoKGrq/njZ4rc3F46FnQMASrAq9bRghd3f1n
	/+3FH1i91mY6jB0wNefSyQ+qoVnxzVpvJIADL757j1GEWTcUOymc+whnR4Gfkp/o
	WLmQpMXet/aX0k+FY5eA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xawqpjnde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 04:25:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4384PQsp000600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 04:25:26 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 21:25:21 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC: <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        "Mohammad Rafi
 Shaik" <quic_mohs@quicinc.com>
Subject: [RESEND v3 2/2] ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490
Date: Mon, 8 Apr 2024 09:53:31 +0530
Message-ID: <20240408042331.403103-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408042331.403103-1-quic_mohs@quicinc.com>
References: <20240408042331.403103-1-quic_mohs@quicinc.com>
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
X-Proofpoint-GUID: HvRBedq2qORahbEhczr0KgIdfGpeQdl5
X-Proofpoint-ORIG-GUID: HvRBedq2qORahbEhczr0KgIdfGpeQdl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=982 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080032

Add compatibles for sound card on Qualcomm QCM6490 IDP and
QCS6490 RB3Gen2 boards.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/qcom/sc8280xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index b7fd503a1666..878bd50ad4a7 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -169,6 +169,8 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id snd_sc8280xp_dt_match[] = {
+	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
+	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
 	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
 	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
-- 
2.25.1


