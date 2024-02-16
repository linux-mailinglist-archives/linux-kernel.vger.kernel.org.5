Return-Path: <linux-kernel+bounces-67997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5250857439
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BEE1F24557
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46917C61;
	Fri, 16 Feb 2024 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YV4RVe47"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BCFC0E;
	Fri, 16 Feb 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055999; cv=none; b=sXz88JSlRkNqIfxAC9Y2FoAGAMTyPqTUmdC2ntWHx4RoBBHTg6Co0jPhxBtVw5sGsrW6HBdeZqJxZKVs/UZzaBO1hApFY7/w6y12GV41dvWIJHE4IGlh/cyqwmQ2YgXDASiIwOuWdQesxOWek5MLBgZgCVy4mrJVuabzG5UV0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055999; c=relaxed/simple;
	bh=uWdsP0VyycH/n8zmf6AQqzJb6t7PzWmOegvqgqIcCFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPXoGk3YuyYpkOGmaPnCPeW6l4YymtazpjVKELUq03Xfgl7G9tlBH3wJRqd7Ofj+KIhfeCJd6lqivEXHUhOLfS3kGk+d+wPZJkYXu6OWdYzbKEz962IIKwqxb1qZ22RYqpbK56+KnsFM7BKk/LZQc/DUbOP3272t1S9ceO+nrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YV4RVe47; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3vjsF010183;
	Fri, 16 Feb 2024 03:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=j/mbxZDLW7St5pSq9lQb
	IaK8wjTL9VKFVOo/l1cNXjo=; b=YV4RVe47T6q7wM/IAbM49lz4kJX8GaSw0Uu8
	5EBmsInmiKQ9wL4Jca8mgIlgPbTpyKdBesB5qFSrXSCA9QHEpsU84TAj2z1cUfXs
	3QydMfPv3GT1NmgVTN3OxfO5rFAd4x+DG1frHFsu8K7uksVhHe+KQ3PRvxe3YXY6
	VRebzTPTzfDi1R3cqq1SHSXbEpUf6xgk6wFCEWBEn9kZIdvP7c8upkjgWyRVCbi1
	ehodLsHiTwQ3jTmHTDszubSna3HXDy437rKNZ6dNT+NxSDBcj/2EH+kUP+czfXYz
	L1ILtCVFh5XSVbE5/HuBf7KNxzEjq7a8nmhbtOnQfkCfrY4XEA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xv9g3w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xfKU029662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:41 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:41 -0800
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
Subject: [PATCH v16 32/50] ASoC: qcom: qdsp6: Ensure PCM format is supported by USB audio device
Date: Thu, 15 Feb 2024 19:59:05 -0800
Message-ID: <20240216035923.23392-33-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XamplLW9Sf0GNvsa0qkQ6Beqo2uVa0ep
X-Proofpoint-GUID: XamplLW9Sf0GNvsa0qkQ6Beqo2uVa0ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160031

Check for if the PCM format is supported during the hw_params callback.  If
the profile is not supported then the userspace ALSA entity will receive an
error, and can take further action.

Change-Id: I141caa1c7e149f7d5b9f8e120475d8ecaf75e297
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 00cba1021dc6..833a57deb321 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -46,7 +46,11 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	return 0;
+	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+	int direction = substream->stream;
+
+	return snd_soc_usb_find_format(data->active_usb_chip_idx, params,
+					direction);
 }
 
 static const struct snd_soc_dai_ops q6usb_ops = {

