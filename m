Return-Path: <linux-kernel+bounces-48854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57084626A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B7C1C23D75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAA4778B;
	Thu,  1 Feb 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ed8MIg6B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC23F8DE;
	Thu,  1 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821564; cv=none; b=CcPznXjXpZezMxGbcogcIWcl4jGOsW0f9pQPvENoSFtY2Us5Gy1b880+f8Fogst2Fdp6muAqd0QUIZnzC9ZxwrMSTJvVgZoaFKbY5LWz1Dk3CuO2Uzyctc5pyN/JXHH+VO0gN91xlbes0kMI2rV2Mh7CpQt4tZq2IUJhPii2zQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821564; c=relaxed/simple;
	bh=MBFZQjSgy8im+2QQdM4RG4Jh0x2iVlH2SEAOyVg/Wg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExViE7QkmURCtJoDN1UiUDY691ee35sM86fFzbbH/eToXvQfGh4Z/S5qPrBYbQ8283NTpwadmQzMZwYFyB88PZ1PTUpHLogNpfxyGKmCxVwHqc/TkrdVLYnUSTTcdRBm7vu9S3GJjgMjespUSe20XplqLiM22yIxiNVNo9AuNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ed8MIg6B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411AbZbk008224;
	Thu, 1 Feb 2024 21:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=pU71/J9eHXqY3uwhAN8q
	/MhXDKmdSLvdXXt7P5ddiHE=; b=Ed8MIg6BBjIb8JtQfdsjmiFsw8sc3wGuRjac
	EgmE3+EcWwOMmYYhLLN8zUze5AWR7283l3XZGNPj8rwfcZYtHUG5wKmBiwt2GjEQ
	E8ZEVBbiEvX2vDdTjwBTihNLG23CIF3FSpbz/Xwn5KsyKpDCdI9BsMk7atNLqsZD
	1XUbeEiE9/wgWXU01THTEA0ZYB4f3e18nSKmsI4YbRvY1JF2iLQt2s9fFD5W/4lq
	hVtpdKkmTVN42a19/x76v1IvD08Yec4C2osY7n2cJn803EXnF/rvKrXttVnHFcvR
	0JUzAnPtqfQWoixelEDzlYZedHMJLYqjvqEDDx8JTDHiG/gCHw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w09q69fq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5hvN028677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:44 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:43 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v4 08/10] dt-bindings: arm-smmu: Add TBU support for sc7280
Date: Thu, 1 Feb 2024 13:05:27 -0800
Message-ID: <20240201210529.7728-9-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3FFDpwZpbAHBbELrK3R6UTZD8gs6xwGb
X-Proofpoint-GUID: 3FFDpwZpbAHBbELrK3R6UTZD8gs6xwGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=812 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

Add the sc7280 SMMU to the platforms that have TBUs. This will allow
to validate the DT files against the json schema.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 537e6a2fc02b..50ee76970a79 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -330,7 +330,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,sdm845-smmu-500
+            enum:
+              - qcom,sc7280-smmu-500
+              - qcom,sdm845-smmu-500
     then:
       patternProperties:
         "^tbu@[0-9a-f]+$":

