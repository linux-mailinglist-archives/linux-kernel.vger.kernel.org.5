Return-Path: <linux-kernel+bounces-78710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BF8617AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E98C1F21B43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43E86631;
	Fri, 23 Feb 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PZYe39Xr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF958562C;
	Fri, 23 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705257; cv=none; b=jHnE/aRhMcYmGQtHsfPcxmvlyoyyU1tYxAl7rAhsooH/PH796tl8lsJWn3zGpe1PfUb7uJgXKMbE+XnrrHqyEChQPBgBWpUmwqCAJnfrmqb7DW4M8kg3efVZ3psvssnR7Bj8ppLZeayqNNxlsrjhq6thH1u6JSboqRDlVxeZ82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705257; c=relaxed/simple;
	bh=dwWIJwGoMU5ew25YXI00QoYBkJKwcHEWsLFpy7KUq64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDKODfkd4eECESzu0xm0OJQLQjeK6n91SY+qjTYxmbY6k7kiVMSmjArCdRftjwPTBshiwOJ9WNiH3WQx39nOs33hfQ8CVAuWdaYCG+pUwL7M7l1V9SgrnWzpgr0JliV/kpJd29e8+A/z7bTzI/kuiHSTwsKDN6yaCuuERspxTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PZYe39Xr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NFLW01003973;
	Fri, 23 Feb 2024 16:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=7+lZgdm
	7GSt8ghIDF5MfQ2k86lh0IjM0BRTq/0qelZU=; b=PZYe39XrSEQYwkWXOFGd3UE
	8Ua//3vqeHRy18OVCZdf1URKWLeQC1f6NpKsKFvWOvvtxcFt2jWZwaNmh8AOtspu
	x/ifnEvLmSe1U3mU09G0Cb9z8aq/f5Qtah0uDzLLLxX9u7E2wlSuWBSEYwi0m09P
	2gLO4bOcyUoqVOKfVwvYmSW4z68028tYqSaJL/6csFlboPOmcsmOszRxhtzkOeL0
	BjI1DRUdbgTLG4j9H+4THOBcVRk4E1kiKi0kqbUgFXakR07k/MgmrKw9x41zF5vB
	OpAQdBrbSvSxj8v/fVYwWLvB/YbjZvmMkHAHdyN6T5eb5t7TXDRoBXb7cBLHSFg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wen0qhfrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:20:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NGKhhb007434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:20:43 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 08:20:41 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <quic_bjorande@quicinc.com>, <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_rjliao@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH RESEND] dt-bindings: net: bluetooth: qualcomm: Fix bouncing @codeaurora
Date: Fri, 23 Feb 2024 09:20:27 -0700
Message-ID: <20240223162027.4016065-1-quic_jhugo@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yrDevGGHGLEf47oOTWOapKsT_ZsKJ8B3
X-Proofpoint-GUID: yrDevGGHGLEf47oOTWOapKsT_ZsKJ8B3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=748 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230118

The servers for the @codeaurora domain are long retired and any messages
sent there will bounce.  Update the maintainer addresses for this
binding to match the entries in .mailmap so that anyone looking in the
file for a contact will see a correct address.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---

Rob, will you take this patch into your tree for 6.9?

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


