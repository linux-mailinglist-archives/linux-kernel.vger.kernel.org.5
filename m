Return-Path: <linux-kernel+bounces-93808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E678734FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEA81F2388C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1449608FD;
	Wed,  6 Mar 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JA8trjj6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CCE605A6;
	Wed,  6 Mar 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722474; cv=none; b=Re4vF8gvawyiAX+CA01gFYnnuTo5TRl2rY0Gk5Msn7XmeEPAddZLnrwd5HY4i9CnIGg8py34GHnn02yqPd07sueKGn9ojWJRZToe3Zq9gb72kFwmQzbsvb2hRl1ns3tU3ar2Z8AbfQuQplRA6DO+s4P1JtDsf13NpCV9GRg9X78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722474; c=relaxed/simple;
	bh=un6WSCrH0nwZRCvTfsywl316B66p1DBPStSLUvF7JXU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KL8+xIkjc1ink8Iii8we8uTTJQ8KNgDfl/IaRNys0FrXPs6HtMT9BB6vkvC49t7XCEfZBqK+nFWj7f55LxkTbROPHHjWhoIStgx/d83cHSNLVfFRLvPOw4silG5kcfC66tftZAK2KiEzCqEa+3OVUP1t16KT91Eyffpd/B6M2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JA8trjj6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4268ewkp028060;
	Wed, 6 Mar 2024 10:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=5TxhWqAJYi09
	OyiGMAl/JFGwe7rxA4G2XCalQeFYGwU=; b=JA8trjj6fAuoQ8I7X9XmYP/VcjEA
	QjMquurDrnzhKc6NG69xBfR0mCrDhLrdNRvTwFP0QUByqZiOBzH6Thin2NyRw+UI
	OtHC/eA6T011vev+Gf0uHAM/ho1UQahIWPrcNLPu5a2KOv6l3qk0C1ygLLiGUeVD
	wX4SWAtb2ijXde3LglpqRveSpDAV54MV9kPSgUpkrJNIx8C2ivGsqblJMoU7X1rC
	CWtpCAjnfpwEjjKzg6z1iylEQBo5GCXVC+7d7xTfLGYHvSaxhALPaLIFvCREyYU5
	AEnwJvcsYT8mi3xWv5WDPsuEX5tWI7Akijuj7ymiIXAD1ubBrRYdx5KTcQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpbav1eu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:54:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 426AsA4m018092;
	Wed, 6 Mar 2024 10:54:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wkw6ktcbx-1;
	Wed, 06 Mar 2024 10:54:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426AsAcU018078;
	Wed, 6 Mar 2024 10:54:10 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-c-shalma-hyd.qualcomm.com [10.213.108.128])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 426AsApF018077;
	Wed, 06 Mar 2024 10:54:10 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 2341845)
	id C4DE13E1F; Wed,  6 Mar 2024 16:24:08 +0530 (+0530)
From: Shalini Manjunatha <quic_c_shalma@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        Shalini Manjunatha <quic_c_shalma@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc: Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 0/1] ASoC: soc-compress: Fix and add missing DPCM locking
Date: Wed,  6 Mar 2024 16:23:19 +0530
Message-Id: <cover.1709720380.git.quic_c_shalma@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OD4E1X52YD1L7EZ0FIIHkkEBesBmaHjP
X-Proofpoint-ORIG-GUID: OD4E1X52YD1L7EZ0FIIHkkEBesBmaHjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=868 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060086
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We find mising DPCM locking inside soc_compr_set_params_fe()
before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
which cause lockdep assert for DPCM lock not held in
__soc_pcm_hw_params() and __soc_pcm_prepare() in above flow
when ever we play compress offload audio playback use case.

To fix this issue added DPCM lock and unlock in both places of
above code flow mentioned.

Shalini Manjunatha (1):
  ASoC: soc-compress: Fix and add DPCM locking

 sound/soc/soc-compress.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.7.4


