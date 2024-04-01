Return-Path: <linux-kernel+bounces-126627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C1893A94
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE3B213B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26422625;
	Mon,  1 Apr 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bwtApY2E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA04224DE;
	Mon,  1 Apr 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970097; cv=none; b=EMQg6Hkxzlcwi/avWgIEVEt8cMbKsNO1J5plxrkbT1UtKCYp6MD1cKDEscilLKqD1GcPS+DhTRz1IQD2+qvRcSvqsSroGbmIvbBb1HDhFDOO67UvkiDdmrnWZvZAfHFxVbUHZ7yiUpPLOBM06VWtWX3O78d8B7Z/ce+Szo9MJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970097; c=relaxed/simple;
	bh=xys4v1ke4/oszfeIIr33OSYqAa4itzrFebZsOZyCm5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bBjloBRK1ydi0QaSJc4miMMe61qTXP2xJljYZc8fQwzegvdRGxpKTFYV55DUPU/1+G9dMczn2wwPaoypsgJMsxc41IVg/zigZnr44LIUvwt/qBKPqxEGkj7a+trDlLgVCEX/C05HzzN6BCMc5WOUcI/GSMi2y+IjdV05p1houAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bwtApY2E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4316oOrt028557;
	Mon, 1 Apr 2024 11:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=nX1shTxlHIZtvRURL1ZfkWjY6pwbOsLfE6t4yBrBPzo
	=; b=bwtApY2EZSJmaIXXJJSGG046TIZO0aq4zi1Ax+qsJUCXvCQfhMdbKpI/kon
	B1n0aGa1qK0kHt8bq9L6g5bNuIU5uufo+yLwGVdl2lXgE0yQuggwozzSvptm98HO
	OYDah1CG6/OKX8fHJRcoLsYgm5clNuLgK6MZHoAprDIm9jzJt18wcuJEKtHbnCkZ
	1TbgGMY2hecBtVT1KqCXA9+F+DeSnlI/PYIBnx20dKoj2fXedbTTUju+uSPIyyof
	1gwUNB26D5VAhxo4ejmDm+e6jpbj0dFMp3sFY6OcGUa4MKNw3+tEmBAwKiZX41zh
	igq6VyV7d18lcTtY+HFLK4KjwIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7r0hggd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 11:14:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431BEorm014975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 11:14:50 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Apr 2024 04:14:45 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Mon, 1 Apr 2024 16:44:23 +0530
Subject: [PATCH v2 1/2] dt-bindings: clock: qcom: Update SM8150 videocc
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240401-videocc-sm8150-dt-node-v2-1-3b87cd2add96@quicinc.com>
References: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
In-Reply-To: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KrPz2_ANDhHllWVOpypnpLV36iOuNhIm
X-Proofpoint-ORIG-GUID: KrPz2_ANDhHllWVOpypnpLV36iOuNhIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_08,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=986 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010080

Update the clocks list for SM8150 to add both AHB and XO clocks,
as it needs both of them.

Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 6999e36ace1b..68bac801adb0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -75,7 +75,6 @@ allOf:
           enum:
             - qcom,sc7180-videocc
             - qcom,sdm845-videocc
-            - qcom,sm8150-videocc
     then:
       properties:
         clocks:
@@ -101,6 +100,22 @@ allOf:
             - const: bi_tcxo
             - const: bi_tcxo_ao
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8150-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: AHB
+            - description: Board XO source
+        clock-names:
+          items:
+            - const: iface
+            - const: bi_tcxo
+
   - if:
       properties:
         compatible:

-- 
2.25.1


