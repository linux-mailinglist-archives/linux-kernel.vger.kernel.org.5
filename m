Return-Path: <linux-kernel+bounces-131128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED4A898368
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83111F29AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7FA73504;
	Thu,  4 Apr 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y4kT5zBv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFE71B40;
	Thu,  4 Apr 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220463; cv=none; b=YbqAGKzQP+tVdbR3hhnn+cwuy+NCkoJk38vCmfF0EkAj4UQsVeop3P9sjBADLsfdrpTiSfe53F3wFM7lOrMj2xqHENSWnhiSqYV7gTRnaG7Kk3aruK8xY+XNk4cGqSO1VABrtqOFlWOkt2W4Pjhcmm8rK9SPP7htHSoHMkUINtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220463; c=relaxed/simple;
	bh=C0B534tETcSiSi2d2a5k3Mlzf8TIAyJoW2nw7gAaT4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nhzEGmJLOz08v+DYMfOmsRaiQz48Zba6JsZk6JQfFyzpfteKJbP43rKkSopLUTBnpXdGkgJG4EwI5V9tf+qEUVrEix17UkkWldJTkiRpBh6pE9UwvYjGsvLuCm7oaV9/Im1F4ocfqd/m8p9kX3l4Ze5BaBXPA/RzWeQkmTuWmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y4kT5zBv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4348T9K3031265;
	Thu, 4 Apr 2024 08:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ySSQu01
	uxqxgU7lEYH4fWRZQEzBl+iPrmYmI64On0hY=; b=Y4kT5zBv661yKGkgyEKI4UD
	sZ3f3OJIkqRA3x5NMigGS3kcfmFRU+SA2mzEI88R7ut91CxvOwY+v1Vvp6Zo2JJK
	jd9Jjv/jn/e9IZYUpDVIDjo41zECnY4cVuSDe8MpbbfAAJBagyPLvux02DgDVIgD
	/V+by6UYgIvgN3UAClS+srT905dAMZIAfDEtPXdtxhcmmgfaA70ehqHC/AL7Kmb2
	CLbfZg4/ScC3LEeu0vDQBw+xYIVg+GOFi7NOGh0bVn8epRgcY+hvXbo80MEC46y2
	s353P0HJKg6UYqV1TH5F47+7SCXSu26zdUykObZ2IVVIaBJiTQxAQi8T0F5VdmQ=
	=
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep3rymj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 08:47:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4348lOU5003300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 08:47:24 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 01:47:19 -0700
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
Subject: [PATCH v2 0/2] Add support for QCM6490 and QCS6490
Date: Thu, 4 Apr 2024 14:16:29 +0530
Message-ID: <20240404084631.417779-1-quic_mohs@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qEExjceD8F6__3ATV3Ifli7EUgQDJGFS
X-Proofpoint-GUID: qEExjceD8F6__3ATV3Ifli7EUgQDJGFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_04,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=662 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040058

This patchset adds support for sound card on Qualcomm QCM6490 IDP and
QCS6490 RB3Gen2 boards.

Changes since v1:
	- Use existing sc8280xp machine driver instead of separate driver.
	- Modify qcs6490 compatible name as qcs6490-rb3gen2.

Mohammad Rafi Shaik (2):
  ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd QCS6490 sound card
  ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490

 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
 sound/soc/qcom/sc8280xp.c                                | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.25.1


