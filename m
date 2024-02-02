Return-Path: <linux-kernel+bounces-50224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA68475FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6214EB274C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A214A4DD;
	Fri,  2 Feb 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G+/MD08j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DB1420A4;
	Fri,  2 Feb 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894381; cv=none; b=qfyh48QD3RMG9B0MS+myps8hx0Z0r07c+B9G92zcQx/Gvzifm8pkng1hOPlVqvghY1BKJQMT73EsBTySATsHepCLO9UWx7w5KGS/ckqFW1rKUuMxuVzzEKW87/L4UwcxM5ft2s56xDYo7ZCXlKv8bZdMQG9GFopasmnMYpp2c6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894381; c=relaxed/simple;
	bh=tc/H3cE6aOg2akGtqlufzRlVEUi7dZgg0jTn47lX3Zc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHwysGQlCt1zBdGv2lNSepMQ4UqwmcxIAuQc5zStai/wsWcYdaEG/SO9pXtr2pONvNjKeLRCJ5jnhM/zuOTZVlCLjR9pPBpCfl5WeAiuhWPFDKWdLqnWfMm9uF24AYKMAMBzpeqLD4TqoGethp9/lxN26/h5uJ1Y1mw8LTiBN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G+/MD08j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412HEAXX020339;
	Fri, 2 Feb 2024 17:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=15c9nbq
	JheROjqA7qKcVMJWn/7rwUepjgl9U7MZxvjU=; b=G+/MD08j4UGU7bcgur3GPZt
	82VyhA1TfjYaB3qFAZooEXyFmY6uuPbDpZ2I3C61wB252XW9XWA6Bx2RhPztD7hK
	0GPLA7dMz4uofoQkjvRoWrwAkkHTE2rZOIclnA9SSABJ2KU1qKn5notJK+ovP3np
	0kOAf7Ae1k/B9vXkrBHtTSH8XVFyB604KMTaLBpPwFIjQHIh3AGDgPru3jhOVmCQ
	5RTISmD40NWYF4fdbxAdYtURY7iZ3Dod9zV2OkDS6yIh12Z/+0t30yuw7tadTiP/
	lbvkgjL2PURuiMFtSfdPnAirDEAAOa6GuTPq3RL+n/vyCLJQvcHTOzaM0mFNA9g=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwc1xa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:19:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412HJYMs005638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:19:34 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 09:19:33 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
Subject: [PATCH] dt-bindings: clock: qcom: Fix @codeaurora email in Q6SSTOP
Date: Fri, 2 Feb 2024 10:19:15 -0700
Message-ID: <20240202171915.4101842-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: tLd5zrOf45gRUkyhEWyLLzfEYwn_xy1c
X-Proofpoint-ORIG-GUID: tLd5zrOf45gRUkyhEWyLLzfEYwn_xy1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=807 clxscore=1011
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020124

The servers for the @codeaurora domain are long retired and any messages
addressed there will bounce.  Govind Singh has left the company which
appears to leave the Q6SSTOP clock controller binding unmaintained.

Move maintenance of the binding to the Qualcomm Clock Drivers maintainer
as suggested by Bjorn Andersson.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml b/Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml
index 03fa30fe9253..e0f4d692728c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Q6SSTOP clock Controller
 
 maintainers:
-  - Govind Singh <govinds@codeaurora.org>
+  - Bjorn Andersson <andersson@kernel.org>
 
 properties:
   compatible:
-- 
2.34.1


