Return-Path: <linux-kernel+bounces-52532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CC84995A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D5EB273A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C681B810;
	Mon,  5 Feb 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X9GPAUBe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC4A199BC;
	Mon,  5 Feb 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134299; cv=none; b=YegjzIk2OeDSlRDCbPm2zKZ/vMZisD37sDs0ghSYmY40eJh0h69D2hgHpstbxgDWxb0x8nCCqYOoZIoNQi8VaH4vLl5hl+YkjzXAFOUIgUVcateJuSpVRhGqjC9rCGDVqvznLNcr//y1VhQLINKqocg6licOYrzAM2nPik/IanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134299; c=relaxed/simple;
	bh=44KgHhEZGikIcoHlp8mDeKS+ZPaOsKiThoCZgFVuix4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo/Xd581UGQq5AS2lZyVL3yuLKAEW3lLOKgby8II72/BCAwVphKc5uNGKJHr6967dXj8mpaDxS2lXvZZT1y3e7QrpskxZ/uwBBRevRbKI/9O4FKDsGsHE17Qqv0UiNQGBx4Cg+zRgwHXC5bgibbYrPwZvJvJoKFJ7+Qm0Waq7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X9GPAUBe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4157fRe9007038;
	Mon, 5 Feb 2024 11:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UvnlmZjiQfb0kZrCekql+NdENof1V+KfJpPZJmFlXns=; b=X9
	GPAUBetCh1f+ey9WAWF47PQuHUiOEErenf0K7A9+t28REGPocVNXJWJOYSjgjxeH
	71IoxtrpyI4R3mbEFbBTgRXBhoTAm/4avoOfbTR1f63SBjBmClypxWTskK3VZt4x
	+2N9iQqSQdoSKja/7CoCLCo/Ud0zZA5VUbhWTlFVdl7rH1bxqYYdY7PhJD8DdOcg
	xZp9KPbPrlBXWxhMrNEN9MW9avu5+gUudn6+ERPAgY3jBc30fxTd5eRMH6crOeqS
	5ZmBpMSRvmY4BST+EkQod0jSQMPVVPjElRKB2ynzZ1k+u3ozD5sXm+/+21QBLvxH
	Q2yWtI6/PQnKLCigF6Iw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2t9wrk5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 11:58:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415BwEVx027924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:58:14 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 03:58:08 -0800
From: Jingyi Wang <quic_jingyw@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_jingyw@quicinc.com>, <kernel@quicinc.com>
Subject: [RFC PATCH 1/6] dt-bindings: arm: qcom: Document sm8650p soc and AIM500 AIoT board
Date: Mon, 5 Feb 2024 19:57:16 +0800
Message-ID: <20240205115721.1195336-2-quic_jingyw@quicinc.com>
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
X-Proofpoint-GUID: Zv3X-L1qqZiRCw2yWmD9goxmYlMUV78g
X-Proofpoint-ORIG-GUID: Zv3X-L1qqZiRCw2yWmD9goxmYlMUV78g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=760
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050091

Document Qualcomm SM8650P SoC and AIM500 AIoT board.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1999a5f2f254..e87ceb42853b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -88,11 +88,13 @@ description: |
         sm8450
         sm8550
         sm8650
+        sm8650p
         x1e80100
 
   The 'board' element must be one of the following strings:
 
         adp
+        aim500-aiot
         cdp
         dragonboard
         idp
@@ -1051,6 +1053,13 @@ properties:
               - qcom,sm8650-qrd
           - const: qcom,sm8650
 
+      - items:
+          - enum:
+              - qcom,sm8650p-aim500-aiot
+          - const: qcom,sm8650p-aim500
+          - const: qcom,sm8650p
+          - const: qcom,sm8650
+
       - items:
           - enum:
               - qcom,x1e80100-crd
-- 
2.25.1


