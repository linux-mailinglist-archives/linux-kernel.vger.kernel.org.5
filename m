Return-Path: <linux-kernel+bounces-109794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AC8855CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFCF1C210B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE356751;
	Thu, 21 Mar 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BBp4o6Mx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F756459;
	Thu, 21 Mar 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009983; cv=none; b=uSLmX44ffA817lUigpWWg9r4o89x1VUKll9sFCtONfWvUFEF4W3onNyab14LbuvCoWGujr1/DzXWT4b8ecmdonNvDUOhK4GFUT0D6XHZvGFl4bTYeUN0sDIOHXRwyEObyk5lamTuNJF/KlYBJcxMHdYLrn+/lK6vIndJ2mStc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009983; c=relaxed/simple;
	bh=841nWnVUqKhNMQuoveCUuZNcpiV05VM3UMo5I/4BTeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fL/syziepOj5lsqt+PU7U05IV0Ew9IsyTnHXcU/UUogRLVuc3zp5Q8EkoV5kF8E6P1nw0GV+EX4aCOqGEFCWzoR7AfD4n/yR3MzJjxhOPskWCIOAW5lN9CVLFqgEqOYAGW/NV4YIe5P0hnwTqu9OSPKCxJEevzWTjgkjZCA6TtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BBp4o6Mx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L5Lhot011536;
	Thu, 21 Mar 2024 08:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IKReU8ZLc37dMn5ztIry
	Pct1th7et2e4I2ZtfjUG6Ig=; b=BBp4o6MxEK0TcDUAt6EG/7Gffa8g1Caj4gsD
	ZQsPyLWdYO2tEwbXgL6Chx4adsi2mEW/0W0xQSn6yU9tl3L7dyfUi3o9zeTc5+vn
	5wMl97aIGy1hnTMB8RCzxudw5Zdu18IOOKlMKEziGxp2KIoUCD67aDO6jCHJ9QOP
	lbjkkQruccImkrQrewUYMuWUfBKfPWd1lQF1oGi13A+2FKuhuhIbTJwtvVuQy7Md
	YJSngOEmCf2TJKV4yazw0ljTuRFYqaDJ5tboPwTGEYgdL/NgNpar8UB1i9BJIDRW
	ZixV0ZmHbfHympu/KGG7U/meL2k4ecc4DH3naFj5VU8/GOLxVA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01bra3jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L8Wje6009538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:45 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 01:32:40 -0700
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH 3/4] dt-bindings: arm: qcom,coresight-tpdm: Mark tpda input port number
Date: Thu, 21 Mar 2024 16:32:06 +0800
Message-ID: <1711009927-17873-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TSXCQrsOm2P-A_BUd1bbHqhR0wWGS3-_
X-Proofpoint-ORIG-GUID: TSXCQrsOm2P-A_BUd1bbHqhR0wWGS3-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210057

Since the funnel supports multi-port output scenario, multiple
TPDMs may be connected to one TPDA. Add a new property
"qcom,tpda-input-port" to mark the input port number of the TPDA
in the device tree, TPDA driver can find out the right TPDM it needs
to search according to this new mark property.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 8eec07d9d454..383c0f5a658b 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -77,6 +77,12 @@ properties:
     minimum: 0
     maximum: 32
 
+  qcom,tpda-input-port:
+    description:
+      Specifies the number of the input port on the corresponding TPDA.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+
   clocks:
     maxItems: 1
 
@@ -112,6 +118,7 @@ examples:
 
       qcom,dsb-element-bits = <32>;
       qcom,dsb-msrs-num = <16>;
+      qcom,tpda-input-port = <0>;
 
       clocks = <&aoss_qmp>;
       clock-names = "apb_pclk";
@@ -132,6 +139,7 @@ examples:
 
       qcom,cmb-element-bits = <64>;
       qcom,cmb-msrs-num = <32>;
+      qcom,tpda-input-port = <4>;
 
       clocks = <&aoss_qmp>;
       clock-names = "apb_pclk";
-- 
2.17.1


