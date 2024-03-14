Return-Path: <linux-kernel+bounces-103752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A194D87C3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33D21C225AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019D75812;
	Thu, 14 Mar 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ug2nKoCB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CE7580D;
	Thu, 14 Mar 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446739; cv=none; b=TVtnjqmH7TMjo+3Z9/x04c7ekNyVgSp+9ZxR+N9dRDPV25E7qFMVRZSg6O27N1MHFWFqqyygZOLYNp5kaib92kckKOoIaDeQS+bOBgp+/SoVJgAcVHbd6a92K6jmITVbebb9oiT3Ev30dpvhr0jRjkwkeec3MCwNCm+Wk772Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446739; c=relaxed/simple;
	bh=N7a7N4RX6HsicLP5SKQiQhw6d5B7Mc0IMXbPJcjESnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZg7oRetj2iq/BP+czMgx19Xg9MSFsWTR63q81GAtPhybJlXF6ekpjXpBn7pgQu5YhIcVvWb7axoEdczRKEqxQbhLm/CQAI4ElUBjXsViblJW5UCeO6EIoWoF/n2SRfDS/V8LezH+8orX8SH9Ppiu4IdYYx/jzLNIFGeH1mzdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ug2nKoCB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E9XerA007294;
	Thu, 14 Mar 2024 20:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=CA9XRy3efsCJpYP0mYyHl2e6Jpt58bC9qNMN3y9g/Kc=; b=Ug
	2nKoCBNT3yJCBucIBO7F4PHjOisYMITZHcJ2ow25hOVazGE1HHi+xumEYRDr5Kxk
	9BegbuMwWDRV7/H1edbC3U9599Xl09TlfWmpcdwgjyClZYOFAcnowssC4b0A0/aS
	nLvAeGaOdTfRvxjDZeACTBOE3RLYUH+ZtSOrb8N5U6taT6WKj89Y+poXdV92QssX
	6bPySY1InDrnP9Ye2NhAKywEdtwhOe+Hq50jGhKVIwPFuPjDTE5R8MvHmEzq2dMY
	B9JtI/Kg0ZaZ727ix+cZ2fRYlWKIyivStNhWbfKSZ5nmldpbj6SM/7B+JsLK0UBE
	3Kb4bz+QiEb5snI0hamg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuxqchacq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EK5V3G005021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:31 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:05:31 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 3/5] gpio: pinctrl-spmi-gpio: Add support for pmxr2230
Date: Thu, 14 Mar 2024 13:04:21 -0700
Message-ID: <20240314200419.4733-8-quic_amelende@quicinc.com>
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
X-Proofpoint-GUID: dFCnm4K0yO9muW8os88tOVFUi9lEMd1I
X-Proofpoint-ORIG-GUID: dFCnm4K0yO9muW8os88tOVFUi9lEMd1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140155

From: Jishnu Prakash <quic_jprakash@quicinc.com>

Add support for pmxr2230 gpio in pinctrl-spmi-gpio driver.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index f4e2c88a7c82..b15747f1d9bf 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1253,6 +1253,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pmx55-gpio", .data = (void *) 11 },
 	{ .compatible = "qcom,pmx65-gpio", .data = (void *) 16 },
 	{ .compatible = "qcom,pmx75-gpio", .data = (void *) 16 },
+	{ .compatible = "qcom,pmxr2230-gpio", .data = (void *) 12 },
 	{ },
 };
 
-- 
2.41.0


