Return-Path: <linux-kernel+bounces-98789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8119877F75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94AC1C21D29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C53C097;
	Mon, 11 Mar 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dqBkXuhk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BB3BB20;
	Mon, 11 Mar 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158601; cv=none; b=qZPQZP310WUhPLbeLyWFOJwaBXcR4tITppR6kCCnqCdAcYsGAiXcm0FOgQW3ayRMjS2+Kvks0+L8fWcIpjvzuDMKUl68rJmNJSrmxaKG/CisCf4iuLgEmnRo3YDb3H5Xp1rdfeIeAv+OKOnAMV4dAl8l7qFAzNluHxprWdCcQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158601; c=relaxed/simple;
	bh=FVoyIz0vprAziJk1M+feK4Zx8CNk1PI7Dhy95jNed4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVvjzs+GIXh1tv4Yjkm7y1nxq0xTDyPGbUvbecY9ZIDipv8Edb2HLpQlg9HDzdzKKFsupNVWHkQ+eNFNsRUerTBALjuer8/d2DtJyS4ipQlvXyEgHNN5WjGWyL2SomEz07pJOkZHXyTsinKZ5oxJD+GRdUXvRSLzLhCCUJIvkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dqBkXuhk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8krgu007819;
	Mon, 11 Mar 2024 12:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=q+bmEQRp5IbCTaKaUhtR2pT260+U94KEks0biEEfj1s=; b=dq
	BkXuhkPLwC5RbwqR4+t/NdhU1BXl2Bl64Uenn9YUK4tSsdX3mUeWeEyOfh+mwoVC
	khVIM1r1ibOCT8onAduQKVoFrRW3f/0/8+87QmrbjMDTDFLS/riMxenA/cKxjPRq
	z+mcG8po/pfLD5QnqWJkvUfJlaSKZ2P433Rs0pqcdvxwmaH/pAKQP5dOAfVO9hrR
	fZ/xR4AzR+vcOmbr0zc6uKBxFYPNxVRyXMrd7auX2dSJmeTdEV3FI4gITd6p09Ma
	wKRm1jroPeTMZl7ldeCHYjOt6w3aVjGCEabUrf34SMHKK/DRvwG9ve2vUr8yZ1ND
	aexabBEkUvrWXmI0JAvA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxr1rgw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:03:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BC37i7009067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:03:07 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 05:03:02 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
Date: Mon, 11 Mar 2024 17:32:12 +0530
Message-ID: <20240311120215.16845-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
References: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h7EMP2cfUyFPl9kFwl3ybukxgabAdfM5
X-Proofpoint-ORIG-GUID: h7EMP2cfUyFPl9kFwl3ybukxgabAdfM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=920 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110091

Document the compatible string for USB phy found in Qualcomm
QDU/QRU1000 SoC.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0f200e3f97a9..48afcf6ed9df 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -25,6 +25,7 @@ properties:
           - const: qcom,usb-snps-hs-5nm-phy
       - items:
           - enum:
+              - qcom,qdu1000-usb-hs-phy
               - qcom,sc7280-usb-hs-phy
               - qcom,sdx55-usb-hs-phy
               - qcom,sdx65-usb-hs-phy
--
2.42.0


