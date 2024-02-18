Return-Path: <linux-kernel+bounces-70326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5385961A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA821C2162E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1D1CFB9;
	Sun, 18 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GqUch005"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51821CF98;
	Sun, 18 Feb 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249441; cv=none; b=BWdGJaMsBp0B8if8k5FSbz8IGvNpfWqPjQi43tXyVytCo8mfMx8kkCc7tti/VmTfbeaZtYRQn686JVXkpfYTwEs+MZYANq22wIFEtTCyfx4uBrUi+Gu+yz21prccRjyZSeeXc4Pi/phNOyCMxRSgJlkeWzO2ynb/zQIK2vgXzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249441; c=relaxed/simple;
	bh=aSSYAKXiNZ3B9g+7NCAreTP0gRzqX/zcTJJrTQGiG24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqJF4xs2VblUmsBGdSvjWwmo4rWgBR0bmwZ1+diAlqHuX2hPzMiRLUY2UaIaT9NOGn/H+Vb3pBJ/08VL6Ma3xvPlw1b2j6Bt8x7n/73WherVXBw5zAY/caVAprSSOppTgFjko5ODJIlaaWsdHMsR9085OLLVtQ7eBWvaOmmXdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GqUch005; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I9ehfF013317;
	Sun, 18 Feb 2024 09:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=I6FhMe2svHVVjnm5YbUsg2AnSWJOzTgHFtU1/uId9f0=; b=Gq
	Uch0050zvS52uXzHME4nFmOxgN0GS/GBUBW1aFYkZkXXP+c+HEnKB/uqepovJ7Ua
	0ceYl+S8ODLyMhiurp4HbdOJcYUIW6E8h+O7s2PDgiq4SPg42C1CEIndaWZjVvhC
	IzYYFS+DrQjUrH34E27idTk7blvhXjt9EPg0y1AbCPB4I2X5Y4xSObNARAGhGiCl
	+1HtiBRUxYZ79zm3oK5cwDQxsrwlh29BrcIug4cXX7rIGUDFS663RfLrYtTvA+vs
	04ru/kWcROOJ1PQdOxxGQrdZU9zDqKW82bCGdbEKBHkGy71+wmlIGdRw41o9ukss
	QNJnT1xUc1q6I/E4WSeg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waktcsp2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:43:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41I9hk9W022450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:43:46 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 01:43:46 -0800
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
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
Date: Sun, 18 Feb 2024 01:43:19 -0800
Message-ID: <20240218094322.22470-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
References: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xlUXZiqKJrL5z87HpcIp1MVdpiXfESS5
X-Proofpoint-ORIG-GUID: xlUXZiqKJrL5z87HpcIp1MVdpiXfESS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=984 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180073

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


