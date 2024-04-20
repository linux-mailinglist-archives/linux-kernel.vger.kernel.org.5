Return-Path: <linux-kernel+bounces-152130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523D8AB99A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472EB1C208CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF445101CF;
	Sat, 20 Apr 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nkpiyJUU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12FC13B;
	Sat, 20 Apr 2024 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713588589; cv=none; b=dFhri1BT0isxB/ZBm3Y5AMmPvCvTIRZEKJpwjHCSDnq4lRaCpE4B5U3mx/ADx6xLPxMTrk52VsQQFU6BqQ28RdZ2WNYI4AYBsplX0EydEkqjz6TIdJehUYCRUzJb1SyyJxf0J3JhboeT2LwYeAb7tPEadR3UUpNcOVfIuNm3clM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713588589; c=relaxed/simple;
	bh=Uznc6huh5tF/lSp49m8xBnVgRC4QvoU+X9iDzrpKeok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hE2bhN05+dK+ngC6ciTPO0j81bE47oYYAZO384HORtU4Bk5sNj4owWURSc6iIO5FusPzcXqsza/LqeMRNaVmxm4pbyFGHz+SasIFqpEZNogh1sCqC0IGF/c4rEBZOEbAh4nXlZBHWmfAi/zyzkQ7qtKQZx7UBlIcj3U+q8urs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nkpiyJUU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K4TJea015659;
	Sat, 20 Apr 2024 04:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GxL+uciNPxVlCM00yAddGsMUoDCAdfEDm1e7I1JuUMA=; b=nk
	piyJUU0QixQZMnK0TU4DUDWxMgLLapLUtLu2v+tg6j/3m7Mhn45cYh4keLVwFwqI
	M4QFs6hDl+ezXCVKgxrLFwYChIZNDdBOSfZyDJRrycjZLVTfQ1ZojBDOIXqFAiiR
	UcAnhHv7X2VcyjTXzrY9puMbvLthTcNe1xt3UZjs4BbGUZVY1bguq9Hf2Rr6Z2YG
	leX1E+PETTq2cjpxlv29gPoxCQ0PA7UiMaadLUheWBVDKl4RmFFzciwJ4ZOQj7wd
	KnjLSN7fp4og0SoZPey2SXdmRMftyaA/vheQ5xWT5wg/2SXRilWwgDkTk/cAIzGS
	VjNK5f8NcmxIuQOgplMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4nug5ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 04:49:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K4nOwL001020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 04:49:24 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 21:49:18 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v21 1/9] dt-bindings: usb: Add bindings for multiport properties on DWC3 controller
Date: Sat, 20 Apr 2024 10:18:53 +0530
Message-ID: <20240420044901.884098-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420044901.884098-1-quic_kriskura@quicinc.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qPGK1HIT_P-OOAnx-dTj1dgRturT_9Zd
X-Proofpoint-GUID: qPGK1HIT_P-OOAnx-dTj1dgRturT_9Zd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_03,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404200033

Add bindings to indicate properties required to support multiport
on Synopsys DWC3 controller.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 203a1eb66691..1cd0ca90127d 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -85,15 +85,16 @@ properties:
 
   phys:
     minItems: 1
-    maxItems: 2
+    maxItems: 19
 
   phy-names:
     minItems: 1
-    maxItems: 2
-    items:
-      enum:
-        - usb2-phy
-        - usb3-phy
+    maxItems: 19
+    oneOf:
+      - items:
+          enum: [ usb2-phy, usb3-phy ]
+      - items:
+          pattern: "^usb(2-([0-9]|1[0-4])|3-[0-3])$"
 
   power-domains:
     description:
-- 
2.34.1


