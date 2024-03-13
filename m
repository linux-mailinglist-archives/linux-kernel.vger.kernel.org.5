Return-Path: <linux-kernel+bounces-101159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EE87A345
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4433E1F21F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9537168DF;
	Wed, 13 Mar 2024 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YIgvAVMY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F028EB;
	Wed, 13 Mar 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313979; cv=none; b=Q7qF6NZHc9RyQgzjhO27h/eG4sG/E5nWN0bXyk/QSqsJCVZVOfnQzLWlDjIBdrbntMDnbk/YhjfhBpRSsln012QQ2529TiN+rLPA3VPfhU2g9K4M1DjoWAP7TD4HaJHjLV8wkEWaHtO+8lrhUgwzmpGuFfP30EbOyUuRpjX0RxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313979; c=relaxed/simple;
	bh=ZyveaiiNlLHyF7E5OQy1yTq7Oc9CoWX89ouRjogpPi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCM148c8BtVagLh9j0hdPrkukPHYeGpx264NG7x6+Yw/hbhh8FxRXuQnYKGowrOUzVH10eyG4KSLl4stFjCuD6+17TegPdY2O7vX1vrZQSXIu7eXMRZWYcZ5+9csMN6h6WFu1kNuJ5f5t04BnPGalzu4nnYraU7GoiYoN1wNvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YIgvAVMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D6sXqu006901;
	Wed, 13 Mar 2024 07:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=oVfSfTY
	bU8O8CvtpN0dYojPBCj02bqycXYwinenWgXI=; b=YIgvAVMYKfeRd5f2OWfckg+
	cJJAbzYYvuXF62EzfSlYQvSkzHjkeaRKrscLOgByhiLvNZjbe/+Mg4iLSa6Cw8+2
	BQTfjwWpxqhPRg4vJ5bVbWeheburlOBueiDVdrcYk/XojEaykS6l7L6kTkb3S6/3
	VqAdklFlnSaRh1PCIcPtQtzxdkvW38nvqQEoCVHNWsxTMOBDvwwERbwaFS2fdNRd
	KZgB7G7uCm6+hlNK8v7yppG8vfHl/h0saEG7MsUkkQa3MICqviOw4YJAsqETpQb7
	dEzl+RB9Cb5BhmLXPM+n2KXyf92zeRga53mfKw3C90fShPy3xjcjtUfZOCT9luQ=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtwpus3r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 07:12:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42D7CoXK021190;
	Wed, 13 Mar 2024 07:12:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3wrgum5nru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Mar 2024 07:12:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42D7CopO021171;
	Wed, 13 Mar 2024 07:12:50 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42D7Cn7W021167;
	Wed, 13 Mar 2024 07:12:50 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id B632F50096A; Wed, 13 Mar 2024 12:42:48 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: Document rb5gen2 board
Date: Wed, 13 Mar 2024 12:42:36 +0530
Message-ID: <20240313071238.3290-2-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313071238.3290-1-quic_wasimn@quicinc.com>
References: <20240313071238.3290-1-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lXeULjmZNiqYGz6knVfl8xFEkbd9k1o0
X-Proofpoint-ORIG-GUID: lXeULjmZNiqYGz6knVfl8xFEkbd9k1o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_06,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=946
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130053

Document board bindings for Rb5gen2.
Rb5gen2 is using Rb5 gen2 SOM which is based on QCS8550 SoC.
RB5gen2 is development kit used for IOT solutions.

Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 8115088a6076..de6139db8ef6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1013,6 +1013,13 @@ properties:
           - const: qcom,qcs8550
           - const: qcom,sm8550

+      - items:
+          - enum:
+              - qcom,qcs8550-rb5gen2
+          - const: qcom,qcs8550-rb5gen2-som
+          - const: qcom,qcs8550
+          - const: qcom,sm8550
+
       - items:
           - enum:
               - qcom,sm8650-mtp
--
2.43.2


