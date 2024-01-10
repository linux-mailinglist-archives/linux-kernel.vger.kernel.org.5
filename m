Return-Path: <linux-kernel+bounces-22088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597D8298FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB176285D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E34879A;
	Wed, 10 Jan 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lZGq1KKj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36348793;
	Wed, 10 Jan 2024 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AA33Bf014480;
	Wed, 10 Jan 2024 11:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=J6w8/2Uaivc+IhxWpx33fUyFHAcLJNahWcoAf86tYLU=; b=lZ
	Gq1KKj+QmNxD0sKY8WW9yn6/tRPSSwTozMn2tMp2Z4RBoTZN4Ogk0RKdQjs4uo1i
	6AZKgWjDwyHr9Dr6Hi0qwIWdlckTS2KoUEALKY59OzlwfREaY7gnMfrBvkF4yIeF
	2/3Rz1etd+LZASdOLvXZ8rxCajQd4GujDNRaluTgY6YWdLnpgl520rLkpo9ck+cM
	5O/JO4BYcYCoLpNn1CLKWfx7JzPnRjUcBfzMkMAhl/G2+4rzDQLxIHlxm5V6PiJe
	rXkJP7GAx5QRLLalL9GjVkCAjFHnMDY5QQU/EZ9PkFlvx056ZlmH6FuE8oI1aob8
	TO5nk2GaMwrz0H+Xr7wQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhs4mg634-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:24:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABOa1j018220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:24:36 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:24:33 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <quic_bjorande@quicinc.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v2] dt-bindings: mtd: avoid automatically select from mtd.yaml
Date: Wed, 10 Jan 2024 19:21:45 +0800
Message-ID: <1704885705-7486-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eVtUjBz7nsmPqilmuphc3XYpZr017eOc
X-Proofpoint-ORIG-GUID: eVtUjBz7nsmPqilmuphc3XYpZr017eOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=882
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100093

The mtd binding is always $ref'ed by other bindings, default selector
should be from other binding files which ref'ed it. Now, "$nodename" in
mtd.yaml turns into a "select" automatically such that a few binding check
issues reported because it conflicts with sram devices(eg, qcom,imem.yaml,
rules in folder sram/*)

To avoid the automatically created "select" in mtd.yaml, adding:

select: false

Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Fixes: 7bdc671822e9 ("dt-bindings: mtd: physmap: Reuse the generic definitions")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
Hi Bjorn,

As the idea is from your comment, I added "Suggested-by" you.
Please tell me if that's not suitable. Thanks.

 Documentation/devicetree/bindings/mtd/mtd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index f322290..ee442ec 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -10,6 +10,8 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
   - Richard Weinberger <richard@nod.at>
 
+select: false
+
 properties:
   $nodename:
     pattern: "^(flash|.*sram|nand)(@.*)?$"
-- 
2.7.4


