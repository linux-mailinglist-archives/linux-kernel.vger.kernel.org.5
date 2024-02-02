Return-Path: <linux-kernel+bounces-50305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8984773C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AE5B23F38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288514D43E;
	Fri,  2 Feb 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WTi8Ir4w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794C14C5B5;
	Fri,  2 Feb 2024 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897888; cv=none; b=i8ujXwGF9DNmmkGok1H1ZneiT/VitcF4BLFTlXeU5B7TSULvnn9W77Ggq9jmmJFbq5uT2/ngBJU+X9y9lg2v3b8fAPygGtR5fRrE7Ln04HSAwHMhJ3idkFEyuIz7bb9W8rjPZw8i3/aaxqp/NBCn3cHkIegZWMi//Wf8pCab8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897888; c=relaxed/simple;
	bh=kFgHbcFaIXN6WutITcEy9obcELc4c2Tk1d6vErbYwPg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RqyRi3KoSSQuDPnN4LRKxr9B7ILcKbAlFvRWHNioU+LBA63K6pibZtD/HaPkIiht3XBB81EIvncP00YNY42nPbeI8yUy0rYHFtxdL4v1a/l8ajdh/ocCB6VNq6nr0LPs71iRDlSbK41zm07gFtam+46DLRGPa8lpDl0++wYtNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WTi8Ir4w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412CY5iT018955;
	Fri, 2 Feb 2024 18:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=u3q8C2v
	SzhlWor710jcN311Y3ur18XVguVTF6UKuVa8=; b=WTi8Ir4wpUWqEU2jN1vUbMS
	XxfDwwgyQh1xLjvdmEss4sROHrXwyZgoxp/HlMcxdaWPp5VpqECqu1um68j09HAQ
	QnkQ3oT2YARl28HaAKZx4nFX8uK5PI4fF21hO4A1d5wSEtvNQ1SvXzsbXg52ZILF
	BMvPWIUzUgzmALDqsXq70yfLAwot6sTMLUGeSD9zd44wkFUbqd4JJZG9cLY+WlaU
	MBoOEUZYC/7y84lNw4AoZSwHJZn3PhtkuWxCg24HeKdp1bfhFJQ4JxTr+L/VUWgj
	XwTulu8KL4YLcQwwZ6Kx8QmNI9hCIb6Y20ciZ8hFP6brBoCOQMogpsxt2mVrjww=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu4j4pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 18:18:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412II1QT016615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 18:18:01 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 10:18:00 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <quic_okukatla@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
Subject: [PATCH] dt-bindings: interconnect: qcom,rpmh: Fix bouncing @codeaurora address
Date: Fri, 2 Feb 2024 11:17:48 -0700
Message-ID: <20240202181748.4124411-1-quic_jhugo@quicinc.com>
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
X-Proofpoint-GUID: yUFfJS4LZZEP_mnVMzN0pAyjpIBcY3Ma
X-Proofpoint-ORIG-GUID: yUFfJS4LZZEP_mnVMzN0pAyjpIBcY3Ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=703 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020133

The servers for the @codeaurora domain have long been retired and any
messages sent there will bounce.  Fix Odelu's address in the binding to
match the .mailmap entry so that folks see the correct address when
looking at the documentation.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 74ab080249ff..9318b845ec35 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -8,7 +8,7 @@ title: Qualcomm RPMh Network-On-Chip Interconnect
 
 maintainers:
   - Georgi Djakov <georgi.djakov@linaro.org>
-  - Odelu Kukatla <okukatla@codeaurora.org>
+  - Odelu Kukatla <quic_okukatla@quicinc.com>
 
 description: |
    RPMh interconnect providers support system bandwidth requirements through
-- 
2.34.1


