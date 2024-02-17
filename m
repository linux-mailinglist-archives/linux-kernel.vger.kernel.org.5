Return-Path: <linux-kernel+bounces-69558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAC858B95
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42E328C75A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A47AE4B;
	Sat, 17 Feb 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Px0rJGRG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF8537F1;
	Sat, 17 Feb 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128664; cv=none; b=Z1FT7HYsi6wS4WJzKzv2fZyOTX8ggk6UfdU4t9dE470Ue7BwX4UiAqZ1S2bBU5iUeFeGbF442wkT1yD83pirXsoolT9RMJD3msXxVNvakObSVrk5Y/4JdGz9S26WDivBgE4fmcRAaL2DZ3Ll8jNPfJ42FNVwei6g89gKjgPJWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128664; c=relaxed/simple;
	bh=5l1ZDxiiOCJBz70DKB8YoEv4oAwewH8W9SdYrKkgC5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhP2sbPFBs67SYADkGCVm7UQ7aKtagQgiNVj9mR6aw0B9yNlt6kAgQyBGD7S+Zkzcz3Tb8tmiOM2nxVVpfTTwCMXMJ0IhaHyQhLHlkV8+fSB9XDSPhxrcsi1SENl1h4U36xsPnHRB0/wBF6tWPuLi7s6dtebDplEYoD9oghyZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Px0rJGRG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41H0AaRF002185;
	Sat, 17 Feb 2024 00:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Okp2NIuxOum+UIJx68gt
	8HGPT3ztWG2atEl9RFxfZvI=; b=Px0rJGRGcqwYmQhabhUezJwQ0NR9hPU6uhsa
	RJvHEA+77bz5meGXxUzfAAXiqBaot07BheEq4Zm7R76GMwpLH6WO/FaKYnjsNZ2q
	L/pmLY/slbzngNncrYwDrm3MW/05KE7iCxgDE93L2/R1PzjQYPQN8PhOrnlNt8/N
	F+EC0a7eKH38I96UPODZx2XdgDgRtjdHej60fkvyzzsFte+BT/SO6QW0LRZBTmIs
	iT4BKjpBx/GymNpn8LLZbHAmfBz7rHp1trKaDIuyVJ25rWZa33F6Q6YkURy8DUGN
	d5tIR1hcfoL1aDIJYcHehJQgad1wNqI2KlgifaDeDgo3RlA6nQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9ytaa5ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41H0AZk6012899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:35 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 16:10:35 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v17 21/51] ASoC: qdsp6: q6afe: Increase APR timeout
Date: Fri, 16 Feb 2024 16:09:47 -0800
Message-ID: <20240217001017.29969-22-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240217001017.29969-1-quic_wcheng@quicinc.com>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y4g9aSRCqqeFYtmyXwCpakyKU8ujqzDV
X-Proofpoint-ORIG-GUID: y4g9aSRCqqeFYtmyXwCpakyKU8ujqzDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=962
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160189

For USB offloading situations, the AFE port start command will result in a
QMI handshake between the Q6DSP and the main processor.  Depending on if
the USB bus is suspended, this routine would require more time to complete,
as resuming the USB bus has some overhead associated with it.  Increase the
timeout to 3s to allow for sufficient time for the USB QMI stream enable
handshake to complete.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 948007955934..452d7e8b9b30 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -366,7 +366,7 @@
 #define AFE_API_VERSION_SLOT_MAPPING_CONFIG	1
 #define AFE_API_VERSION_CODEC_DMA_CONFIG	1
 
-#define TIMEOUT_MS 1000
+#define TIMEOUT_MS 3000
 #define AFE_CMD_RESP_AVAIL	0
 #define AFE_CMD_RESP_NONE	1
 #define AFE_CLK_TOKEN		1024

