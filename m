Return-Path: <linux-kernel+bounces-124225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A2891419
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E32286D62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990F40BEA;
	Fri, 29 Mar 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lyt32vQ6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE23FB8C;
	Fri, 29 Mar 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696838; cv=none; b=eYG8ZsJwUINVeGE2WwweqeE0mHy6yxMqr3ftFq3JUGSuqcfa4I4idN6YSW1lIfY//+kfMWqn3nmZV+gBzamWnQJVps5yg1NsS3Soqxl+Dwsa0Q9Q5vCstOk/768PwrafoHvvMsazgiAZtTyDeBm+qoboC4sVsxAT1BsCToy5qAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696838; c=relaxed/simple;
	bh=UQ/uIjMw7GaphpwHt+3f7fxPqkuzXIkUELCfPBb4Jqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ezvPyOr6CRBCl4nogo4pxG18xhw5LmM9KdM7S9RSWcM/wAj0PCOYkicueoAeJGmDV1uRt9uay2BrCtW0Pt97fpbYvTGPSrNyT3SAHdIKThMfxBcuu7C3p4Rc7U6YKzdtxzEYWSyNxOjoprKGnudqJCQ1x8Te2L2Wc9dbgVCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lyt32vQ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T5OHo3020680;
	Fri, 29 Mar 2024 07:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=47jeGuoYfhufc++Lr97xf5ISelMK9i89ElgWazRMeQA=; b=Ly
	t32vQ6nlw6/b4AqEhMVLq0KIWA4mQ7GLMfqLaOzmWVL8bmnHukRL4xKhEnidMHon
	BXgUfVlM2mubaodJU99sbbEjNm9K0vl98ZSxXqstpvSHY0qJlo1jLStNlwMZIHnP
	ngZEbAKRKiwD5NyQHFd+pKGIDtt5+BeekHSDq7CCmxiaSf1it20OyPtAZ2gryEyu
	3CQ7tiFNt1FCKGcv43pMT2Ln4UmzFASInwMNlMHl5WGTaqea+UXWKT892KMGbHVt
	DTTkTxN4zEimvbKDUmPoKK7PnGDKP2/NmSTe6R05Ht4GPfshQKNgBtfQnQsQxgPp
	YCItWS2h9lwizrl8Jbng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fs895px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:20:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T7KAAL017377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:20:10 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 00:20:04 -0700
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
Subject: [RFC PATCH 1/2] dt-bindings: connector: Add gpio-usb-c-connector compatible
Date: Fri, 29 Mar 2024 12:49:47 +0530
Message-ID: <20240329071948.3101882-2-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: rGzgeO5JSGRAafrXM23pPuHwc1wVJ0MX
X-Proofpoint-ORIG-GUID: rGzgeO5JSGRAafrXM23pPuHwc1wVJ0MX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=776 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290061

QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
However it relies on usb-conn-gpio driver to read the vbus and id
gpio's and provide role switch. However the driver currently has
only gpio-b-connector compatible present in ID table. Adding that
in DT would mean that the device supports Type-B connector and not
Type-c connector.

Add gpio-usb-c-connector compatible to the driver to support such
cases.

[1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quicinc.com/

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index fb216ce68bb3..2af27793c639 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -30,6 +30,9 @@ properties:
           - const: samsung,usb-connector-11pin
           - const: usb-b-connector
 
+      - items:
+          - const: gpio-usb-c-connector
+
   reg:
     maxItems: 1
 
-- 
2.34.1


