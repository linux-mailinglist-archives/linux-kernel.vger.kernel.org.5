Return-Path: <linux-kernel+bounces-103754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12D87C403
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E71C22834
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DC763FF;
	Thu, 14 Mar 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PLy/v9NK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B2768ED;
	Thu, 14 Mar 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446752; cv=none; b=hUSsHHDvTXS/rJir6uBe0CGCftCBQOPjtyiqeFiOdo3ssOfNIzGZf01AwPtFacfaxGHX5jD8HYP67rYI5j4m6HUxRQ0nLaUARvdy98N9iCQkSRGDnnT8d7VmJ+EH0NeAopp3gQSN0qbQPUzvKmb4JiPBHrzgyzNTlX7VVIA+Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446752; c=relaxed/simple;
	bh=bfbInkB/y9wev/ii7nfCygHk7JEr/hAGL0uXm/lU2Hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRUznc3ps45fDAnW/34GCyImIepkFYC20KBb1ZW8S74dWqshgGMjCVJJ2tPWEHAccB6PwhXvPzIUivJXqtJC9kIZcuDGmQx1QJaqQ3EcOqn5ZEPZ/mU8JU2WBU2tYuP26e89fcsJjPiurpVZ1A7QivVk4Z+SAoLVLWx6078qclw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PLy/v9NK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECt8Yt020772;
	Thu, 14 Mar 2024 20:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=99Zae2BxOCsN94FOQOx5wNoY9BJy+DkkGXudGVOW/g4=; b=PL
	y/v9NK1/MkxUtO5PgNvIrKhTcm9j6xswBZ+xRdlVz8KyZ/udII12a/MaL1ZLoX6T
	3TSqGlMfUm3OLx1MfwX5MAGcotOjbr4wKt6y65dQB42ZpHf8IzC/rQO4xwlQJGDV
	p5j+50loHcXij/BVGe9jNXdvxKzX6rnCrjp4ew/zakftj98T1ysvTs6lohNlYq+G
	GXu/wfHwxmhLsQ2yg2nrVtkUKDFBTc/52Cv3yQ4Wlmjl8DYGMHMZkuxnf58TowYy
	4yN2bfYJ+ib6TOvUikZ4O2NxtrmzedES9TLnaIsDwaSAd9Mo6Xrv5ccBhOkzCn8f
	DJo1SiOI609lGO1JWK9A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv1njrxsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EK5klT007866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:46 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:05:45 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 5/5] pinctrl: qcom: spmi-gpio: Add support for pmih010x and pmd802x
Date: Thu, 14 Mar 2024 13:04:25 -0700
Message-ID: <20240314200419.4733-12-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240314200419.4733-2-quic_amelende@quicinc.com>
References: <20240314200419.4733-2-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: we9mOisYeT53EY9L51bcseXQO7G7Wpru
X-Proofpoint-GUID: we9mOisYeT53EY9L51bcseXQO7G7Wpru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=994 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140155

Add support for qcom,pmih010x-gpio and qcom,pmd802x-gpio.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 54ffb7e1189a..c7ed35cce13e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1235,10 +1235,12 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8994-gpio", .data = (void *) 22 },
 	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
 	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },
+	{ .compatible = "qcom,pmd802x-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmi632-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pmi8950-gpio", .data = (void *) 2 },
 	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },
+	{ .compatible = "qcom,pmih010x-gpio", .data = (void *) 18 },
 	{ .compatible = "qcom,pmk8350-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmk8550-gpio", .data = (void *) 6 },
 	{ .compatible = "qcom,pmm8155au-gpio", .data = (void *) 10 },
-- 
2.41.0


