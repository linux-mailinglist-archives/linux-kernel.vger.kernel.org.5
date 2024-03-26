Return-Path: <linux-kernel+bounces-118790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104EC88BF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B5A1C3CC29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA86BFC0;
	Tue, 26 Mar 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yw5LrYTy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE411EAF6;
	Tue, 26 Mar 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448923; cv=none; b=XKBXFFhNx7wDGn0W3FbcVpwp9yc0QCUnrCGmMUu2Zyra7qKVsd19fGi++VdC2AxT1wRP0FaNoMvs1Tdxp45Y3wMrpfNb/Tre2dBgq0xLC0MauA1aTHcn0aOJoulxIgoNHwF+8UB/2lY2+Acp/yXPT+l/C6VxgfR5nIuRgmfUVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448923; c=relaxed/simple;
	bh=ukeaZj+EJjB94scvGyBQtfYtRiuShb1IbJClhnMZurY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxLowmON3HSJAgiUkj3tmfHWXjP1BAwz5llUUrLyeevApdlWDmLjoaQzB5uershCSfR5RjNYHjLLeHKXj8+Z64Bu+wWjNBGrk46InJa7BIBkbVQOKlucHsTuhBLItOKmhW6H4Q7mHOArNhNwLPWv3mCY/tIdofyiPFl1lV9twz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yw5LrYTy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q8TZgj012515;
	Tue, 26 Mar 2024 10:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=LFRg6Eiw/Nwzjx+zDP1JorEUwmL0hSvPD3//lEJp0co=; b=Yw
	5LrYTyM8CT2XXujfPwzNkYE8Q8NkHd4+11ZYkJE0B/IQ2eRPFgCbww1EMS9KWuy9
	nDKg55J8ZdSKRcicoSNropoBEqceEtTxhvH4aMo96VtVZ/TQIyx4Gto9UX4rvYEX
	YRzKbPioJj7WVo2CUnEDLwr6ghjSJP+QB/7Fh+WNGZDjP4uVfdWg6aaGPBOFw9h3
	PFJNppN8CTWDZlXw9BVw1yh2P5ZhjaWNnvPEn5NMiUzHlkNKG9BxDdknPBKrq4dm
	3kT20pakF2Hm1G3gCIIc+eNTFffjo2ylOxASjX+5L+auZtosvqW4urD2dBivxWSK
	CRRFMp+/8jZF3aAuy8Sw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3tvy8a8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:28:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QASX1K018434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:28:33 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 03:28:28 -0700
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v17 1/9] dt-bindings: usb: Add bindings for multiport properties on DWC3 controller
Date: Tue, 26 Mar 2024 15:58:01 +0530
Message-ID: <20240326102809.2940123-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
References: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: PB9YVNsKVX5raoCTVIGlVh1LkoSXDXk9
X-Proofpoint-ORIG-GUID: PB9YVNsKVX5raoCTVIGlVh1LkoSXDXk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260071

Add bindings to indicate properties required to support multiport
on Synopsys DWC3 controller.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 203a1eb66691..bfac0a37d0e4 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -85,15 +85,16 @@ properties:
 
   phys:
     minItems: 1
-    maxItems: 2
+    maxItems: 8
 
   phy-names:
     minItems: 1
-    maxItems: 2
-    items:
-      enum:
-        - usb2-phy
-        - usb3-phy
+    maxItems: 8
+    oneOf:
+      - items:
+          enum: [ usb2-phy, usb3-phy ]
+      - items:
+          pattern: "^usb[23]-[0-3]$"
 
   power-domains:
     description:
-- 
2.34.1


