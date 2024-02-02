Return-Path: <linux-kernel+bounces-50300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2284772D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9407B2E147
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22F14D43D;
	Fri,  2 Feb 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hY/ca1PQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53664171A5;
	Fri,  2 Feb 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897516; cv=none; b=YfHbtVlRSEtmrWcTZxdULvaLPKADJi9PC9JiKWpdeQUD5ZW3PeGAO4tGbMp5GxcpRJvvdXXmqiUCpeBO0N/wZHR9D3ov4CW891Ai6+PO6C25ibvs/Bvk01GukE6RZE2K63+ON6dJ8q1HaSPtoPVIlFQOMwBr6XipqrpAqfz2/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897516; c=relaxed/simple;
	bh=DOQo6PG8tdHWNw9j/HZXDNtATHbN0Fw0rHO+quU72Ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWxkMguCj7dnCYZSWR0e44CnKAPxc1nyBia1pQdl4s/yGt8xxpukJXkJ10/xqDjosm1ULl04ORCD1wuLCMVbON7BgCQ68MSLjTAiUS25nVAH+T7giNqSWU11FvEPfmyF3yAbtJdvSDUYGVqGPLZhnqIOAvxWX0kBm7+SUyvLWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hY/ca1PQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412Hntcq009634;
	Fri, 2 Feb 2024 18:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cqOAfti
	ykg7lWOyB0qfM6AnnhzSlRRQXEIGuedibGKo=; b=hY/ca1PQ6DtRcovSEm7P7l2
	m+M34pQi2NC0ci8HLeGM1U1GwRRU+ihuGZtrBulOXIAbo+ibTmmwzxRXd1YbxPyg
	3jl7mLAqqz8qBJSDxNB5Q4AAsh4F1ZJGOj7LJUpVzqxBZ4eNK+zGEbV2E8TXwUQg
	xWj+Wwwrxue/ygAz7zX+Hr8xrQZTFEXx3PnP3sAPBKnb/SIZRmHnFowb3B5hJ6Al
	6DoKkqmvvt08+Hy0Y+Iw3f8zYuubgHWMgOC/VfHXrMYAU9C93E5G8Mim5Ok5fqZ8
	HeZ7aDJZJt92yBnSTeLWeZJArikviaVf5njL2URzgxtprCbQzhbOFoQ9sC7A4EQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w154w81dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 18:11:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412IBhCK027527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 18:11:43 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 10:11:42 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <quic_bjorande@quicinc.com>, <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_rjliao@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] dt-bindings: net: bluetooth: qualcomm: Fix bouncing @codeaurora
Date: Fri, 2 Feb 2024 11:11:22 -0700
Message-ID: <20240202181122.4118105-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y5vSqHzEUAJyL94BjJMxtxKqTy1X5dpy
X-Proofpoint-ORIG-GUID: y5vSqHzEUAJyL94BjJMxtxKqTy1X5dpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=692 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020131

The servers for the @codeaurora domain are long retired and any messages
sent there will bounce.  Update the maintainer addresses for this
binding to match the entries in .mailmap so that anyone looking in the
file for a contact will see a correct address.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..528ef3572b62 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Bluetooth Chips
 
 maintainers:
-  - Balakrishna Godavarthi <bgodavar@codeaurora.org>
-  - Rocky Liao <rjliao@codeaurora.org>
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
 
 description:
   This binding describes Qualcomm UART-attached bluetooth chips.
-- 
2.34.1


