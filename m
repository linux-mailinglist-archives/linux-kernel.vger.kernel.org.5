Return-Path: <linux-kernel+bounces-52534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F5849960
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BDF1C2298C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312131B960;
	Mon,  5 Feb 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G5khtKtW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB131B94B;
	Mon,  5 Feb 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134304; cv=none; b=PDolKfiFGOPXnHwznG+gYBY0jH5iMTqmhPOEmx8u3spP03WahreP7/KdT/cmjdxubKm1V+JoBBrHqrMbBeXFff8bvuCgdP+9jyW3qUvGnvIMJNYhEdVU37aw4BArb1x+9yaK0ORWbg3A7thCaVRqQt+AAi1grlQFVJQOOA8b2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134304; c=relaxed/simple;
	bh=JsGi+GRzsCOLmVlsXOWOB3/bMFF22Lq9+IiKm4j5ACk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt79VlM12PPLw23ExzFQ1ULWbDFs/3jgsm1LKBmQLVmxt1AM7FEdMvsWyuXEIzKFLMlG3chF3/+LfDV8oxmCPWQoSLxj5KqmyhmstdjXJZbwFLWB2HiP7itgdr4l/Vkof8wAgFCXmWx4l3kIEg1Jm+xT/xZeM9DGJKwh+GipOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G5khtKtW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415BlJhO016872;
	Mon, 5 Feb 2024 11:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=WpFfdPV5necxXuXedMOPsJiGdSeo2Pf0wDYvPa1mEqw=; b=G5
	khtKtWCcckdhQ4nTaCXq7yWqkdlxc1FOch9ti5HKTemPS4Mpm5v0w4w0xZhGboUL
	AJmA51fqRMQgHG98ML7cDgbIKrGl3jiUU0wJjNncd5qP6BISiaTk3CsBOF2jUBAl
	VBbIJvNigFP1ZXnG7O6ZEE2Kse2pMtsp+MZMDs1C329ltlkJ6g5DbcZ9jxaZULSm
	qKX7HJRf/XKxTwm1yDrOn0YDmHopCrDeJyTJVRWM5NbVT5CHd59/Z/HKxCwMqzMo
	weYkbXUgnSF8WH+UvmWevp6iBTJN05+IJhLEqVSoUBxwhMRLLZGq8rxMHRqgo6YF
	0fdou+pAYfVpDy9CWq8w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2t9wrk5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 11:58:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415BwJKf007244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:58:19 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 03:58:14 -0800
From: Jingyi Wang <quic_jingyw@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_jingyw@quicinc.com>, <kernel@quicinc.com>
Subject: [RFC PATCH 3/6] soc: qcom: socinfo: Add SM8650P SoC ID table entry
Date: Mon, 5 Feb 2024 19:57:18 +0800
Message-ID: <20240205115721.1195336-4-quic_jingyw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bzhGC60bHy2XxuCqGw8BbRm-FqB5mtka
X-Proofpoint-ORIG-GUID: bzhGC60bHy2XxuCqGw8BbRm-FqB5mtka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=873
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050091

Add SoC Info support for the SM8650P platform.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 5a44ad870fb6..ee6ea575db0f 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -429,6 +429,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QDU1000) },
 	{ qcom_board_id(SM8650) },
 	{ qcom_board_id(SM4450) },
+	{ qcom_board_id(SM8650P) },
 	{ qcom_board_id(QDU1010) },
 	{ qcom_board_id(QRU1032) },
 	{ qcom_board_id(QRU1052) },
-- 
2.25.1


