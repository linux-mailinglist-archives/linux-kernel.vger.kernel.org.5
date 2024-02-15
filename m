Return-Path: <linux-kernel+bounces-66916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69285638F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9452897B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743612F366;
	Thu, 15 Feb 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M3GR9acn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC012D756;
	Thu, 15 Feb 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001108; cv=none; b=kDWEAd9bfZmTp/6k0+3rp/hRQACxz6qrPTNfGeU3nCM6QDHJwEG3LTBKckzJ9B3nCnr1l4Ehk4rj7fMbHUaP27q13ZNOXIb4RpW7YtqznabrWmcbrSg31GI1//8HumJGbt6u/j63rnNt28s0TXHtIlkn0tPh7ILeU0iMaGC1nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001108; c=relaxed/simple;
	bh=aSSYAKXiNZ3B9g+7NCAreTP0gRzqX/zcTJJrTQGiG24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBf/QAIH7GU8YHxzfdPzjHQvjDYRvgO5lzFBtos/pssvMzVYx/rZioPzBIZF+x5tkMvcHlg1lLDNDW/RYJuxMvrHKuz4qffafdngLxSsFPy+JUSJhTpaIHj+FKolzQ9TCZ9PRT8wwu4PQodWln71Sy10ABJLQOoSNtpuqWHwfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M3GR9acn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F8xhTh026826;
	Thu, 15 Feb 2024 12:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=I6FhMe2svHVVjnm5YbUsg2AnSWJOzTgHFtU1/uId9f0=; b=M3
	GR9acn23f6Pzfb6KcsbJc8548FOW4mc5MUszSnacERV5xOkYcOwVhNDF7WeqZifC
	ISIfl2RGch3h5V+HtvFAPEZIwaYHholNyBTCxcJBq0l4F+mwz9CAJbyU60D3oqDA
	kxoB/Wr7Mnih/i4S+fS+q2rcRNTfsykv9cYlBNc4wR+ncyGh8LcKo8tSTl295cw6
	ohJu9mPaamrqU++PMrXl4tTAc5RlfPeR7eez/qLiJDQW1tvaMx4sB2Q1MauoTPSn
	p4w814Hmdu4TR8Sadppk9vOoon0UVAgTBGsWJtq5dN/UG+hJrYb36CeilLEFN1s4
	M9WG86sxnw/u70sbppqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkf8hqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FCipeT011281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:51 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 04:44:50 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Mao
 Jinlong" <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
Date: Thu, 15 Feb 2024 04:44:36 -0800
Message-ID: <20240215124439.30037-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215124439.30037-1-quic_jinlmao@quicinc.com>
References: <20240215124439.30037-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RbmXe_y5Crp_XC3XAWHkxOUgjqWMrbcs
X-Proofpoint-GUID: RbmXe_y5Crp_XC3XAWHkxOUgjqWMrbcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=864
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150100

Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
bit. There is no tpdm node in any DT as of now. Make this change before
any tpdm node is added to DT.

Fixes: 2a8d9b371566 ("dt-bindings: arm: Add support for DSB element size")
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml         | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index d0647ffaed71..8eec07d9d454 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -44,12 +44,11 @@ properties:
     minItems: 1
     maxItems: 2
 
-  qcom,dsb-element-size:
+  qcom,dsb-element-bits:
     description:
       Specifies the DSB(Discrete Single Bit) element size supported by
       the monitor. The associated aggregator will read this size before it
       is enabled. DSB element size currently only supports 32-bit and 64-bit.
-    $ref: /schemas/types.yaml#/definitions/uint8
     enum: [32, 64]
 
   qcom,cmb-element-bits:
@@ -111,7 +110,7 @@ examples:
       compatible = "qcom,coresight-tpdm", "arm,primecell";
       reg = <0x0684c000 0x1000>;
 
-      qcom,dsb-element-size = /bits/ 8 <32>;
+      qcom,dsb-element-bits = <32>;
       qcom,dsb-msrs-num = <16>;
 
       clocks = <&aoss_qmp>;
-- 
2.41.0


