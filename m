Return-Path: <linux-kernel+bounces-93809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCE87351D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574AFB27EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6E60B9D;
	Wed,  6 Mar 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HJ2iGKjE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025260B85;
	Wed,  6 Mar 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722477; cv=none; b=oJmi4j3T/drb66UzKmuWoMVirWZvkUznQPIPUFv0PAhRlt/8dOZn2TbqXiQ5Y5hP893wAMxUPRXmo03wX/E7ZMOcA7iGN3F7l7biQz/yftYD64pte/ING4uiz5M8IJ+l2EBJ7mvn9XK6pF6Nx6xujgOqqEp86x6/stvi1v86q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722477; c=relaxed/simple;
	bh=BCOyQaski6VQlTYoUq01OxZVmiyxRSehT78bucUqV40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=E2g8xbp0OX0TAyUbhctMaEIs4HzEwOa6o7sQi9Ykmf9dEPThLMkYdl2/NsFBCkfdNW+EhdtBCZdgs0cgfbTd7udG7rsBqBxVcN3e3ULCTbFe3Jyk3UHM8AMN+wgtdoZZvmvlZMIvBzBBaPYJgLx3fns+UcqKBcCrGm6UzpY1nBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HJ2iGKjE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266jsY7031466;
	Wed, 6 Mar 2024 10:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references; s=qcppdkim1; bh=6KdBFHDx0oq3RNnkz99R68M
	tuO2GPsYXR0khb5BCPBU=; b=HJ2iGKjE7vqFN/t3yQeTVV1zpbFhFWM/SOL8O3s
	M/lRtEzryqRPcRLROL5gySnSDq6oK95tBcoJEiVucPSox3wq4c/MOsGJe4Ez5a/F
	246khxrDbEPvzDrmJeCvOns3iRKAZd/91PeQ6j8XlcvC2DC+NShPoI0ktY9Git1t
	QG1nXWux7JmX0NyYNipeaLArekg3epZ+YnhMdOZqK42dmvc2i0D+XI8NdeFZ4LJa
	KS7/O7XW0N66gDq8V5F0OTa+fC6uGq143jan0fm7gGr/s6FyOwnzp7kMjsc8a2TR
	5LKOy1beW36SauBhn46RBqJAgk3Oj51VAmMmK6jbukoHyow==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3rjha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:54:25 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 426AsAQK018102;
	Wed, 6 Mar 2024 10:54:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wkw6ktcdx-1;
	Wed, 06 Mar 2024 10:54:22 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426AsMYT018187;
	Wed, 6 Mar 2024 10:54:22 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-c-shalma-hyd.qualcomm.com [10.213.108.128])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 426AsMOh018186;
	Wed, 06 Mar 2024 10:54:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 2341845)
	id 007DC3E1F; Wed,  6 Mar 2024 16:24:20 +0530 (+0530)
From: Shalini Manjunatha <quic_c_shalma@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        Shalini Manjunatha <quic_c_shalma@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc: Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 1/1] ASoC: soc-compress: Fix and add DPCM locking
Date: Wed,  6 Mar 2024 16:23:20 +0530
Message-Id: <d985beeafdd32316eb45f20811eb7926da7a796e.1709720380.git.quic_c_shalma@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1709720380.git.quic_c_shalma@quicinc.com>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
In-Reply-To: <cover.1709720380.git.quic_c_shalma@quicinc.com>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nenwcDJD0jq7Q5O_-5RFb3qGmO7txTkn
X-Proofpoint-ORIG-GUID: nenwcDJD0jq7Q5O_-5RFb3qGmO7txTkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=997
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060086
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We find mising DPCM locking inside soc_compr_set_params_fe
before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
which cause lockdep assert for DPCM lock not held in
__soc_pcm_hw_params() and __soc_pcm_prepare()

Signed-off-by: Shalini Manjunatha <quic_c_shalma@quicinc.com>
---
 sound/soc/soc-compress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index a38fee4..e692aa3 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -385,11 +385,15 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
+	snd_soc_dpcm_mutex_lock(fe);
 	ret = dpcm_be_dai_hw_params(fe, stream);
+	snd_soc_dpcm_mutex_unlock(fe);
 	if (ret < 0)
 		goto out;
 
+	snd_soc_dpcm_mutex_lock(fe);
 	ret = dpcm_be_dai_prepare(fe, stream);
+	snd_soc_dpcm_mutex_unlock(fe);
 	if (ret < 0)
 		goto out;
 
-- 
2.7.4


