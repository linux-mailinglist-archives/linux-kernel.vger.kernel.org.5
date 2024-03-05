Return-Path: <linux-kernel+bounces-92817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09325872674
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3A1F27953
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A018C1A;
	Tue,  5 Mar 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lT/B6qj3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46314286;
	Tue,  5 Mar 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662937; cv=none; b=HI2Zx8rGkfC2oWFeynJAieLATqNzZZJ/S0z5XP16LM9fcMr/Vkp9w3TBvDTjtjz7hmxv8SE72PNv/Lv3mQXXSR5E0woZBbELMRdZKm7lzfAcULpXMPZb07jcBN2wqD86ogApz23SFpR7a40rbOWD4sU9xvAXz6KswwphetDujFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662937; c=relaxed/simple;
	bh=DunzDSheC1QVauFsaz+y90vKEQ5+YpBFlR3DIbfUBtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pehjm0+ukvUMLgrIsjGv6kLNNVCBBW0p4wGHg/qLONg63YxjHsoTPDyrecw/TtZvzoIMUuNFCdVMa6lHnReKBoDhomZqxXHsKTM04iJArf3tFiCNJa8pL+ULp/Pi5uQBLGrZKYGsG367aL3j4jng/nCaphLbmFLN0b1krl9xoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lT/B6qj3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425HteBo029937;
	Tue, 5 Mar 2024 18:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=tg6r9u1YZHJ8zMudPTb3XcQGncnx6dHC0bGI84goXXQ=; b=lT
	/B6qj3419Edb/JxeM0FPkCmgx5RMdwht/lQrvnqD6TBBY2RHhEUCtSJ9DqZn4O1a
	EBSBL20Wquyuk6qtrUE0T9pGEc+U07+Z+GF5u3TuAw/r/5WMykmwecoUeVhJlHF/
	cuG51/XG1LAZK/eIOnhbI3z5NwTUR7leuTGC9i1BBnNyjKbyipisQViWeOPS27eZ
	+JF5q56vdfktvfyGjTBB2O2sWN6BKHg5wifRKkLX2U5vO4QVvfBzow54qKZ8Z3k9
	u8ZFWu84FB91a3FXGMEezyPvTpmeb7odZJlgCGN/9SPqxb/tBex3qxi+eGutXWGm
	72J5yB0z6R5Bh0ZuQhmg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp2bprxrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 18:21:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425ILhxv025641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 18:21:43 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 10:21:40 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] dt-bindings: nvmem: Add compatible for sm8450, sm8550 and sm8650
Date: Tue, 5 Mar 2024 23:51:09 +0530
Message-ID: <1709662869-10569-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3IVtK--I29bI8HitMrHsnjGAnXOlQJLf
X-Proofpoint-ORIG-GUID: 3IVtK--I29bI8HitMrHsnjGAnXOlQJLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=836
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050147

Document QFPROM compatible for sm8450, sm8550 and sm8650 SoCs.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8c8f05d9eaf1..aed90aff3593 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -42,6 +42,9 @@ properties:
           - qcom,sm6375-qfprom
           - qcom,sm8150-qfprom
           - qcom,sm8250-qfprom
+          - qcom,sm8450-qfprom
+          - qcom,sm8550-qfprom
+          - qcom,sm8650-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.7.4


