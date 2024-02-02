Return-Path: <linux-kernel+bounces-50288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA31847701
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F9B1C267A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D1B14C59A;
	Fri,  2 Feb 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cK7qwIBc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D214AD35;
	Fri,  2 Feb 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897026; cv=none; b=NBAHbtLvRWlSc7lSlmGYXBcMVlja/w7CooVxgdDwwY3c2t0tsr7cA0zmFKeuaCUCJKzd8/AMzRda0tqwotab93Aez2MW5LEq9+0frAtOXmg/8KC/58DGBLEfw3pvzb34OuAkag+NMUwUeErJ8i7FJRmPdKGcRiALuLhDfcgl1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897026; c=relaxed/simple;
	bh=kzlBvr0aP/B5FRnAIbvezcL3LTjM0zwGckpQKkSHedc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dNWpjrLFDAHFCPU/mfcmljYNydcf0urH+a3Jku/8jD72jMW3h7gAu7eiifSSb4NLWh0WSCh6L2t1gaY56ELcuU5xK/kk3cAWqh9bly/d+gTtE6MTG7tGh0hcAgfDSZRAvpUHYkpJJR8AvAJgtuUHAe9jp1lr53jFfmky5HdcASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cK7qwIBc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412FPhD8023312;
	Fri, 2 Feb 2024 18:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Una
	7WlYaez5PmcWlUF1uNafCq9+QjpMwZztlXuDyaFg=; b=cK7qwIBcwzJt2qFd0yW
	qHcOvug0IQasDxrWE4APSd1eN8iRLcgjHgXY0SJg/jDSlbKWYMSByZl8aALhyc5o
	OSf1HYUsDIWt47gwTkelTFQhp4hxaCVXGbYp+cAt3rXrnLjapbbW4FEKowzdgZEa
	g8v0aHf1ituGeBFMSncs00x7cv0r5DnDj12MYVwbl1GsUvFHfilGsXtYaPyWxHyE
	x5lsUsBXf0pKQNaDZgG7KqgnzrLBKza5SeDSSeiBxD3Kn4sOGYgw2bXdtWLFsWh1
	pxi55q6Yc6JtEzHuh7r3qQPTPTFXgGSsssbnYmVddTbChx2DHvHoY5Rmy78oCLIf
	XQw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptvj269-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 18:03:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412I3QAv015830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 18:03:27 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 10:03:26 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Fri, 2 Feb 2024 10:03:11 -0800
Subject: [PATCH] dt-bindings: visionox-rm69299: Update maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240202-rm69299-maintainers-v1-1-423aa40f344f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF4uvWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIKFblGtmaWRpqZubmJlXAsSpRcW65qkGZpZp5hbGxiZpSkCdBUWpaZk
 VYFOjY2trAbVABZBlAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg
	<sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter
	<daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <quic_abhinavk@quicinc.com>, Bjorn Andersson <quic_bjorande@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706897006; l=1230;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=kzlBvr0aP/B5FRnAIbvezcL3LTjM0zwGckpQKkSHedc=;
 b=qQpgZM8HQmHnxJuQ4l4mhjgIvdWxD/GfFXRYqXUuREXsHNV8hAdSg7cOZ/Isdn/MGSIXDPM1F
 W/hcrGFTEQWBTbYgh9XnxnRBFrClocNPEaT3OFewODBb3eKw8HnXOui
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vTpHZNHFYSI8YyLMPeYrtWc4yuLnJWCN
X-Proofpoint-ORIG-GUID: vTpHZNHFYSI8YyLMPeYrtWc4yuLnJWCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=882 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020130

The current maintainer (Harigovindan P) is no longer reachable through
the listed email. Update maintainers list to be Abhinav and I.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
index fa745a6f4456c..7723990675158 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Visionox model RM69299 Panels
 
 maintainers:
-  - Harigovindan P <harigovi@codeaurora.org>
+  - Abhinav Kumar <quic_abhinavk@quicinc.com>
+  - Jessica Zhang <quic_jesszhan@quicinc.com>
 
 description: |
   This binding is for display panels using a Visionox RM692999 panel.

---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240202-rm69299-maintainers-7e069f78334f

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>


