Return-Path: <linux-kernel+bounces-79313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9708620A9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DB72852F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF514DFD6;
	Fri, 23 Feb 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RRz+1KHo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B61493B4;
	Fri, 23 Feb 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731049; cv=none; b=VRism60zkad9aRcpE5oqZsZxc0P22Wu2EJgADWRQbAZ4YQqn0oS2lXkcMRap2fH9u5RC+QwBj15T5fBp7HB/qRYNAzC8KhmoN0oNxtNxe1cOxlbytP+Xp7nMA4KIGSuRGPQUdPklfcLkKJe22tSQgVLgntCa3gDbKA6Bmw2pQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731049; c=relaxed/simple;
	bh=h//bXQOfyD51HdIYvIVtiLiYBVCEnqk/Uog1+x5o+qY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9mL16iyR5JYoDSEArUQeymcbZZQ4CDsOvExfZ9msQQK9EAFG5jNQ9PLhAtD5VqHBr6xSnGJSDA9ScHTWCbLhGQXwXZBuUBCnwWnrKsRTyNvo59+pI2Q+f6pIufaS/PLV46P8tS+gAepaEmczpsH+Hyppcof+H6LE7b3vabJwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RRz+1KHo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NNRJ0Y012362;
	Fri, 23 Feb 2024 23:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=qnvioMN
	wBdhyj6o/C8/3UWTQBMHbJJsLCtGkE2QIX2A=; b=RRz+1KHo0yXWShT3T5e3JJj
	2b4swfVArGJMnb9VQ/JWvL3uY/+l2I2G27/VGGJgbQxJUtK5gsspqdNCW9UC57eW
	8XJ1/3dN/ozENcXrc0qdRw0Wnx0d7EnsHKLrQcLbadp5IsrvHeJ9yuzdpYZbmzQJ
	53HdvqAdm0MEefk+YOdDeWLiq5iBjIqxaSySbKYyLZwdsT3Nkpa+o0VhBS2B8uGl
	Y7qhMVzgYxzqLQ7zm1MJvDJJq8Lb1u3RRNke0HLdaXH3yNKx3sLgTO5lAKTBc271
	wrJA/Hmcr9XwZFI9SbLvdVTLPV9gX4ruoEvTBltH+njXCrk8JpvO8M9NbRUWTVg=
	=
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wesgg1nuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:30:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNUgJj005069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:30:42 GMT
Received: from hu-collinsd-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 15:30:42 -0800
From: David Collins <quic_collinsd@quicinc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: David Collins <quic_collinsd@quicinc.com>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraman
 Narayanamurthy" <quic_subbaram@quicinc.com>
Subject: [PATCH] dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
Date: Fri, 23 Feb 2024 15:29:55 -0800
Message-ID: <20240223232955.1907552-1-quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9fTJixCfSwsxayelcgvdFgYzjUAXUXPo
X-Proofpoint-ORIG-GUID: 9fTJixCfSwsxayelcgvdFgYzjUAXUXPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=580 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402230169

Emails to Shyam bounce (reason: 585 5.1.1 <sthella@codeaurora.org>:
Recipient address rejected: undeliverable address: No such user here.)
so change the maintainer to be me.  I work on qcom,spmi-sdam as well
as other PMIC peripheral devices.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index 068bedf5dbc9..5d7be0b34536 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. SPMI SDAM
 
 maintainers:
-  - Shyam Kumar Thella <sthella@codeaurora.org>
+  - David Collins <quic_collinsd@quicinc.com>
 
 description: |
   The SDAM provides scratch register space for the PMIC clients. This
-- 
2.25.1


