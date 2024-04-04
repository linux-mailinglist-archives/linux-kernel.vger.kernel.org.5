Return-Path: <linux-kernel+bounces-131131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404CB898371
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700731C26B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A97580B;
	Thu,  4 Apr 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HP7T73ZH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032E74424;
	Thu,  4 Apr 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220467; cv=none; b=hpjjIZVQLYYjIqg37QPEQpsmwbxxdM4GxzPRKfNWLPhOjQDCgmnW3kERpSRiSnuNQmbm/XEAX35MFNA9zL2J9zxy4s/S4ylzvc56CZ8ba6NDfw7j+GPHW4aSG6SE8IsMeUyOg9qvUOWBtTvFTSlDq3RRtG94fdYgrEzfSrnGBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220467; c=relaxed/simple;
	bh=ojwSW/sW2WoGGE7TZjI1eVy0HyWT9DzkCVi+qOzw8Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clVBqHcemMDXr0/7HxSvkMwB5iROBScxzr0nFpATpp8mzGEkxOaMJ7IDUZ8cibnkoy/O6XmZUUHutUm45R3ep9MeNqL/5hMqM3e4X6Mc2EQLKp25t3ZnEbzuS0vPzuZuWNsgVOpsFG9eNcHWmOdIo/XSpA5VGk+RsQZknefOR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HP7T73ZH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4346xIrn013688;
	Thu, 4 Apr 2024 08:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=45cdwSGTsaDqFfoJ7Wa+n9z+LEZVRnZrTzu4BzNzm08=; b=HP
	7T73ZHowMa33YzXuIvk8ViNm8fiiJr1Eom74aZVEgKMGKK5pqLpAMszi55+14qY2
	2DpDGlNYELvzyICvewIEJ0OKevIyYCqVjO/33awBfc8CpPmn2l088X0TgGpSInsF
	W10shQs966JewPiYJCOv+q4bhgEPL8fkXaQnDUpUBhNqnqk3L/Hsgr4jb8mJc6tC
	5seKeCJJKlijOInFv1HP/fN7TKVFA6xLLcXOuc4uSvnhTcIP/kbyo7Az1juTLEHC
	99Zzxo6NdRV6+OTvGSKBSNTFLdi9u3GWMvSpZMz8u3gdmXy2wYr/jx5nIy7xS5ld
	gwqsfWvYfYG+0XPdUn3Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep3rymr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 08:47:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4348lXff004683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 08:47:33 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 01:47:29 -0700
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
Subject: [PATCH v2 2/2] ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490
Date: Thu, 4 Apr 2024 14:16:31 +0530
Message-ID: <20240404084631.417779-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404084631.417779-1-quic_mohs@quicinc.com>
References: <20240404084631.417779-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lzmaVPVA_Ah3Om7H91LxUDptQjDfJUOs
X-Proofpoint-GUID: lzmaVPVA_Ah3Om7H91LxUDptQjDfJUOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_04,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040058

Add compatibles for sound card on Qualcomm QCM6490 IDP and
QCS6490 RB3Gen2 boards.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/qcom/sc8280xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index b7fd503a1666..09c949e01479 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -169,6 +169,8 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id snd_sc8280xp_dt_match[] = {
+	{.compatible = "qcom,qcm6490-sndcard", "qcm6490"},
+	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
 	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
 	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
-- 
2.25.1


