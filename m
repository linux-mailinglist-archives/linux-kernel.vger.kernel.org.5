Return-Path: <linux-kernel+bounces-49908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645B847142
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC936B234EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03C46551;
	Fri,  2 Feb 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HZaaON53"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09242AB9;
	Fri,  2 Feb 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881015; cv=none; b=Sy6pR0OCkUURn7rYteLmGcUj6W66tift1Dbiw+drbBJitp3pVGWwBbYBCY1ut16xyrbWWdTWa1WJN+mKsQ5By0lV3CoIdY303x+tSOwFe07XWU4GxN0/qYl+rX6J7I15nJC9qpzSpCvS5QYEpfWrvyiVm4MefBLcgnQlc7d1Cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881015; c=relaxed/simple;
	bh=NXmNEuZ+lk7CVgF94lrr8W6BJend42DqU15RZ2Qt4SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6raUFC3GWVavZk64Ybi4K5e5LdhvDu0EehZMHtcj14+8BOTdvjxL99IxKBI4vp/oE+sCDrao/heOdebgmx9mLwCVeIHcssYOngCOk/5IDtQ7UcuYs7Qb7MFSECPCmQVnQ9/IPDO0EAX12kS9aeyzdT/ADcOvLKnegsOGSigjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HZaaON53; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4129sJ3D017314;
	Fri, 2 Feb 2024 13:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=jwi1ohA
	Hup9rpeu+6saKPHEDzHPkxr/nJPS1uNomeBw=; b=HZaaON53wKzGUCb5JYFXVjw
	fc4OE0apHjEIihFWQi5ap2tmWFcossuTYrAu7JtKTEEvkWyNeb1mlbbxnDMo+mlS
	rYC3a6iNZnx77WNniiaB3z3E7ziQ8hyA6Tr4keZ775ZDVxmedDbTvSu6Xejoy11/
	BOF6E8Fb/EaYZoZ8hecxCoW95rECnBrKGujDq2DEjtsBtg8beqpOdsroHVFhoTf4
	cZ4SqcKwCUx+XX4tIA9Gz8csnkBbZnS0EPOYUJ3hmCfZgsKCTbiFZegT6/Ds3B93
	lhJuGQ6J/RtucInwnAoRn/M+GUYQKYS13KeS0oO5sB2aBfUlmKeaJ3nZtOyxVsg=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm1fak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 13:36:49 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 412DajGk017959;
	Fri, 2 Feb 2024 13:36:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3vvtwm3wsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 02 Feb 2024 13:36:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DajPk017936;
	Fri, 2 Feb 2024 13:36:45 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 412DajwD017932;
	Fri, 02 Feb 2024 13:36:45 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id CC37050094A; Fri,  2 Feb 2024 19:06:43 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: arm: qcom: Document rb5gen2-hdk board
Date: Fri,  2 Feb 2024 19:06:36 +0530
Message-ID: <20240202133638.4720-2-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202133638.4720-1-quic_wasimn@quicinc.com>
References: <20240202133638.4720-1-quic_wasimn@quicinc.com>
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
X-Proofpoint-GUID: Yh_WYrsOcF8RSRqTVpDt1nYAp4UE53CE
X-Proofpoint-ORIG-GUID: Yh_WYrsOcF8RSRqTVpDt1nYAp4UE53CE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=724
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020098

Document board bindings for Rb5 gen2 hardware development kit.
Rb5gen2-HDK is using Rb5 gen2 SOM which is based on QCS8550 SoC.
RB5gen2-HDK is development kit used for IOT solutions.

Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 9cee874a8eae..ce5b5dfe0e46 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -104,6 +104,7 @@ description: |
         qcp
         qrd
         rb2
+        rb5gen2-hdk
         ride
         sbc
         x100
@@ -915,6 +916,14 @@ properties:
           - const: qcom,qcm8550
           - const: qcom,sm8550

+      - items:
+          - enum:
+              - qcom,qcs8550-rb5gen2-hdk
+          - const: qcom,qcs8550-rb5gen2
+          - const: qcom,qcs8550
+          - const: qcom,qcm8550
+          - const: qcom,sm8550
+
       - items:
           - enum:
               - qcom,sa8155p-adp
--
2.43.0


