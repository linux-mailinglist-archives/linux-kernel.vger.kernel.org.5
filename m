Return-Path: <linux-kernel+bounces-50542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55950847A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121DA284F40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565A981758;
	Fri,  2 Feb 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cm93/6vx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CA81735;
	Fri,  2 Feb 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905537; cv=none; b=FJPYXKmEkF1iyz6AS+FFCrsBOrX0qDLl/ArgWPTGs1LK9pP+H7aFGMUV2LA/tYW3NbI/poIFmRzKt53ExZ8MhgMelKya5S4V8QQB3s3bEW/slp/EWM8aNORvpFNgTKgZx1yEq6ooiS/zYLuujtTI3sKcCEqzklqWVrGI7K6TbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905537; c=relaxed/simple;
	bh=yz3zxHugykM9lmHHUfpsYzvgVhB64m/8uHKxj3+Yz8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLllXdDwqLjbJvfX66wV6Ig9g+dXjbl/AWSRpqsEGJ5QnbudFDb4woOezzYcL1+rcYE3TE2+ImfuRR+TBeFZwhIYkluERXX36OMgSUQXuL+igL76lJIB98hmXWfMxMI0DmVexBbf4nZpW9gyCzpfp44GjZ7bHUBnyiovL+pzDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cm93/6vx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412KMGVN028044;
	Fri, 2 Feb 2024 20:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Afo404L
	YcvCxL1GgzN5QeGathxGMm4/1sj38HK/JY0k=; b=cm93/6vxDtu87M5dB/4482a
	D2vpSE1iCnkb7xPYVxbWm2qG4oXumeW2yiBjDnGach+FMa1yh9/fRJlkxuawhLIV
	EPhLOYkxRCmH1r3WZLsGBz6UaFqFuN50mJZFyZ5LyWWoTcjAeY0RH2ZeV2sVhj7S
	WF0x5ut39bQCS68xzjvGJWQY17dF1DlAh+nHv4lKVt9OFs+q5dM9O5LVhPB6FiUa
	RcjksXjqzskyhBgAnTTV6l27HoAZewP9t/NgbOyS5q6MiT3ICtJSr0DhwAzMGEOc
	byPBXNFHu76inrdrvwNgPn2o9V00JfaXSS0jlWhPvcetRRd7nSWUZM57XI5oTTg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptxjbh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 20:25:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412KPH2p028541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 20:25:17 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 12:24:24 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <dianders@chromium.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_bjorande@quicinc.com>
CC: <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] dt-bindings: drm/bridge: ti-sn65dsi86: Fix bouncing @codeaurora address
Date: Fri, 2 Feb 2024 13:23:29 -0700
Message-ID: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Q4qoOcffb7SFd5V_Ctg6wIpmPxhMPUnM
X-Proofpoint-GUID: Q4qoOcffb7SFd5V_Ctg6wIpmPxhMPUnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020149

The servers for the @codeaurora domain are long retired and any messages
sent there bounce.  Sandeep Panda's email address is no longer valid and
should be repleaced.  However Sandeep has left the company and has not
been active sice, therefore it looks like this binding is orphaned.

Doug is listed as the reviewer for this file in MAINTAINERS and has
volunteered to be listed within the file as the binding maintainer.
Therefore replace Sandeep with Doug to make the documentation current.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 6ec6d287bff4..c93878b6d718 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SN65DSI86 DSI to eDP bridge chip
 
 maintainers:
-  - Sandeep Panda <spanda@codeaurora.org>
+  - Douglas Anderson <dianders@chromium.org>
 
 description: |
   The Texas Instruments SN65DSI86 bridge takes MIPI DSI in and outputs eDP.
-- 
2.34.1


