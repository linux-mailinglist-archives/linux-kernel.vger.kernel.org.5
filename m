Return-Path: <linux-kernel+bounces-23478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818B82AD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B0E1C232CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205315482;
	Thu, 11 Jan 2024 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iH4S2/SP"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9414AB2;
	Thu, 11 Jan 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BA26li006046;
	Thu, 11 Jan 2024 12:25:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=vtOO3rL
	vPULyTclfcDq478t5gvzlWbVBiMnlPziMWiU=; b=iH4S2/SPZnRnWaNAMFmI8bw
	vByYHvfm+k6G9b30WT9BfCb0a+R+IceUDYWMpZv/A5DoTbOoaKcufOCGr64sHeJT
	V8fYjv/VSR2h5hSJfMZD3WpeTtpkoY372rZPL+zYHxY99XDsw0V5U7C/iK5zg2dK
	XFWDH5WqWcezB0wqNl+w6XOEcoaJCnZ6S4imi3ewwjpw6oVwgIBFZDrJwNXusLQF
	fatBt3AH37LsBjfYBz9p3WsMFi1Z+x56bsZZRl3xYtIwwd6nwTUoF2jDFzpp3c/V
	S2sFEs/eTYcBTr/pD2aGfTWS5UK8qhrs1PfDjh4Q31JARIaTt7iI3gs6C9SwKGg=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vexrcct12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 12:25:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 566EB10002A;
	Thu, 11 Jan 2024 12:25:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E9BB237D92;
	Thu, 11 Jan 2024 12:25:15 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Jan
 2024 12:25:15 +0100
From: Valentin Caron <valentin.caron@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH] dt-bindings: serial: stm32: add power-domains property
Date: Thu, 11 Jan 2024 12:24:50 +0100
Message-ID: <20240111112450.1727866-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Add "power-domains" property in stm32 serial binding to avoid:

serial@40010000: Unevaluated properties are not allowed
('power-domains' were unexpected)

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 1df8ffe95fc6..62f97da1b2fd 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -58,6 +58,9 @@ properties:
 
   wakeup-source: true
 
+  power-domains:
+    maxItems: 1
+
   rx-threshold:
     description:
       If value is set to 1, RX FIFO threshold is disabled.
-- 
2.25.1


