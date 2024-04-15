Return-Path: <linux-kernel+bounces-145293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B68A5234
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6705F1F210C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE074421;
	Mon, 15 Apr 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qYXDNHJD"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E973186;
	Mon, 15 Apr 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189046; cv=none; b=VqqvUTQuU9Y8YIGv4wXH95Gc4KxJDXyKFkFlbWBSyecafw61MQa08MoRV7ZGJms2yWSsNQrqP6rD0xB//zQJ1PEase53WjLmDLWXZUW6Mza6FqR2+76pNhVMl6dBi67ZU0E7WPJzwDEeZj1TAW73f7HGI0uTNswmhGzOsFJoN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189046; c=relaxed/simple;
	bh=CUpypMoycNkD4YrNCNb+Rn6H9Q2jKq6gDrY8lh5Q1AE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpxTL9asegijzYOQarLf0RA94G+E6JwUD+3YNrc+/EgBmBzYYz6v7IuCdH74vXaGUH05pz2b/2FdaFW3NEQEjKacjWOdkrtFkhIAgKVx/Uhm3KaFiTclWj5aRa6+mTpyXiC9ctGKonHGiHuMf5AVvRreKF122S8oL00M3JgTwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qYXDNHJD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FCfawS003792;
	Mon, 15 Apr 2024 15:50:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=rUD78DxlX0EIa1cgMZF54Ia2DNfKJDkVjpOME48LvOs=; b=qY
	XDNHJD1VnyV84lBaDRi+vPtrskkWmXNfcqfnh/SfWu3ArmJLL0Qb2/zRcYD/TX8m
	EJNcVg2xE89Cf0kd1rsNVYxq2KFdJk2tiDHW5tn77oaeq/mzVxEUk2XoElQg9w6V
	Zj7Q/HT1hHjCv6KM6GMR8DewjPOAowDDtjsVdjoB4LfNejN75ltkfZEOAOLElyHs
	uQ+D4O2PORgjKPV4PU21aUNa6V27W9nTtCW1lihwNWitqGZFz4DprGu8RNW2Br8E
	6EwGU0Sebk4TZWvwAeYOXfyn7jUHRhJeCtBhCSEk0gwTOFU1kkwv97FQtEfWvuLp
	T84iw9qYS5EHuURabDhg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffff85un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:50:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A777940044;
	Mon, 15 Apr 2024 15:50:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02A4D218626;
	Mon, 15 Apr 2024 15:49:45 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:49:44 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 02/11] dt-bindings: interrupt-controller: stm32-exti: Add irq mapping to parent
Date: Mon, 15 Apr 2024 15:49:17 +0200
Message-ID: <20240415134926.1254428-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216094758.916722-1-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

The mapping of EXTI events to its parent interrupt controller is
both SoC and instance dependent.
The current implementation requires adding a new mapping table to
the driver's code and a new compatible for each new EXTI instance.

Use the interrupts-extended property to list, for each EXTI event,
the associated parent interrupt.

Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 .../interrupt-controller/st,stm32-exti.yaml     | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index 00c10a8258f13..9967e57b449b0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -89,8 +89,23 @@ examples:
         reg = <0x5000d000 0x400>;
     };
 
+  - |
     //Example 2
-    exti2: interrupt-controller@40013c00 {
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    exti2: interrupt-controller@5000d000 {
+        compatible = "st,stm32mp1-exti", "syscon";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x5000d000 0x400>;
+        interrupts-extended =
+            <&intc GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+            <0>,
+            <&intc GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+  - |
+    //Example 3
+    exti3: interrupt-controller@40013c00 {
         compatible = "st,stm32-exti";
         interrupt-controller;
         #interrupt-cells = <2>;
-- 
2.34.1


