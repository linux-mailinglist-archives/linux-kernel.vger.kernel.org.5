Return-Path: <linux-kernel+bounces-124226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D589141C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE90C1F22426
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687840845;
	Fri, 29 Mar 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="drAaKKW6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85943146;
	Fri, 29 Mar 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696847; cv=none; b=VV5a52zz4jWgDRp8zSdBCeuxAeeCZ3TTIai2x+0DaptArNTyWlzppa34B9Q/To+V5dc5ynez4XIn0pc1z2oKaRbU8zQWTwxQIMcXjmvj7pbkM8b7eA4hWRkIHUfDOJoMbs+Q3W0vo8d1TBXtvaMKY/OLqCrEnZpMtEg/LrY79wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696847; c=relaxed/simple;
	bh=EOuIklzbCu4SYhXJb6S0sU66ndJh6Qqco17dxM71vEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxFQnhGurDSfqe9qZd7eeHijWkQnCG2UdjA/KbNVSMuNY6oeQ/79eAY+fYGxejGlxPoq+pGnK99x7I5iOzwXzaoS+geDTBanyh60Z/SBEH5XMIgdpPEDncBWdRlErOtVv0vEYVADyi5WFjPYN35q8AWSSXCbVWneFVXhscYlEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=drAaKKW6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T3NFQv015980;
	Fri, 29 Mar 2024 07:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=f6OBHgHPmm9U/y6y2iA/1HeHk4aTNr8lDe47a56CItE=; b=dr
	AaKKW6Vq3poDz4Q8x/d9GJas6qM3BPY7Px+GHKBix9oY9NSHuZGhLConUfLJrNeE
	eQ1VtZZfSA9QdRayY7zj1M2WXfkEFLEj0cExl8jIQpSnRYkgNaNu67evYLSGn/tR
	rIgJMLb5lEWBaWIvrfeqP1UCff5YNNNZ91ktCaxZc6lzOclBUJXVws0wMEXr7CTj
	W+mZTxPH6z/mo1/UGVTxmGy67fWumHJJXQUpGj9dSt9jEC1o4fuBRa7WzxG89wbA
	3qHe8jhgvB53dR53+4wTjxLyl3B6vRLMOTgNTDWgHxXsUNQXWn2VMIhMhM5xyHp3
	jbJa0mYFMUnPNudzNuqg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5np28fp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:20:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T7KHT0005697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:20:17 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 00:20:11 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Kyle
 Tso <kyletso@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC PATCH 2/2] usb: common: usb-conn-gpio: Update ID table to add usb-c connector
Date: Fri, 29 Mar 2024 12:49:48 +0530
Message-ID: <20240329071948.3101882-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pHSnSnxLfUlZxDh6B6BA2It5B4J4S5xG
X-Proofpoint-GUID: pHSnSnxLfUlZxDh6B6BA2It5B4J4S5xG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=928 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290061

Add gpio-usb-c-connector to Device ID compatible list to be used by
QDU1000 IDP.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/common/usb-conn-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 501e8bc9738e..37b5c5a8ccd0 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -334,6 +334,7 @@ static SIMPLE_DEV_PM_OPS(usb_conn_pm_ops,
 
 static const struct of_device_id usb_conn_dt_match[] = {
 	{ .compatible = "gpio-usb-b-connector", },
+	{ .compatible = "gpio-usb-c-connector", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, usb_conn_dt_match);
-- 
2.34.1


