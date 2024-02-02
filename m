Return-Path: <linux-kernel+bounces-50257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C2C847679
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57D7283A69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149414C5AE;
	Fri,  2 Feb 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ox/DJBfx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17514533A;
	Fri,  2 Feb 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895821; cv=none; b=GUJDJZdfmef0BcCuw5BCIG7sed3V/oHeo8tMlQs8Q5cFFafzlAP426HiOhMRAJUSJQUAO1PGhaCYZy+g4N6bOogYsEp4HLSZYFEj90lOYTsFCqEsHF4+lYnZtuJzxuk3IQKyeUq5QsBtmHpSJgRHVgD4DhrozZpAzqnb/KdUQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895821; c=relaxed/simple;
	bh=LLN9y61AoFj7+BGhIcNuEpEgy1jM9vokgbzH/7xzzEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+xZ++ZaG2HpmUEjDi5QUHCXWMRP/SEGW3lM5XADlauFNhQa0YC9DbKQwG09Hwi9ZOKSaw6VGWMHkkLXEDPRKfUXMoxyM5I5AAoNZdB7Lt/dIgxImw9JyzSTfsmfd6PjxwlWWkHOBnoF2S9Qtmp6gaM+H9EnG8321J0cAF/Q+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ox/DJBfx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412GOZ3A012362;
	Fri, 2 Feb 2024 17:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=w9TDcpG
	+ViqU0k0LnHjATuGvwzj+eqaumBwSjgdKJyc=; b=Ox/DJBfxa++at7M+Vhk90Qb
	y/y6BnhhEY/OSBnxjxhoDHIXdqbLbXnjJHSMN97jKXubolDTvtebAZBYDCkh0Ao2
	w6kR88FuvFihPufCk2c8BhqHsT4tELAL20qD/VOu7w88EwFgNVNuGn2XXdG07xpm
	MZaGo6iieIodWFOjlTZabcg/DefXvuNCZBuCfgSTWfeZlzwKRdtr7TCLRpJ4W0pk
	+j5tSVC19Uuk4HmNeov/vXe0kr3bOVnJ9R0TNb5scFrAN5KJfhEmRzWsUl32/0nB
	77d92Oex1w6SllexGjJb0645aAD6rCxQt5uIsbRZQGqBFcZwF9RzuyuMFr/wcZw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptvj0q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:43:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412HhX0i001484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:43:33 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 09:43:32 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <judyhsiao@chromium.org>, <quic_bjorande@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
Subject: [PATCH] ASoC: dt-bindings: google,sc7280-herobrine: Drop bouncing @codeaurora
Date: Fri, 2 Feb 2024 10:43:13 -0700
Message-ID: <20240202174313.4113670-1-quic_jhugo@quicinc.com>
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
X-Proofpoint-GUID: x0I-X33R-5sBKvv7YPz6LWqnJl2RaALZ
X-Proofpoint-ORIG-GUID: x0I-X33R-5sBKvv7YPz6LWqnJl2RaALZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=550 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020128

The servers for the @codeaurora domain have long been retired and any
messages sent there bounce.  Srinivasa Rao Mandadapu has left the
company and there does not appear to be an updated address to suggest,
so drop Srinivasa as maintainer of the binding.  The binding still
appears to be maintined as Judy is listed.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 .../devicetree/bindings/sound/google,sc7280-herobrine.yaml       | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
index ec4b6e547ca6..cdcd7c6f21eb 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Google SC7280-Herobrine ASoC sound card driver
 
 maintainers:
-  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
   - Judy Hsiao <judyhsiao@chromium.org>
 
 description:
-- 
2.34.1


