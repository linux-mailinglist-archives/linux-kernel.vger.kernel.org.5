Return-Path: <linux-kernel+bounces-157355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620ED8B1052
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2130BB247D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06F16C872;
	Wed, 24 Apr 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FwQHUaSq"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234813DBB2;
	Wed, 24 Apr 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977683; cv=none; b=WPjVYpU7v/oEuJVzcusmZMknd+l3SmHmWX3mlwDicJQ+UME+TfLRZO3ieP6sBr6rgnW9/u+Nu2lwQwSdnmcd8SKf4lk29ual1PFD3Lwl3rpb11BpXddIJdzzU7s4hOFcG7QPLTKdXtOEyACMy2nM6vj/Xe7NqmxhIDl3/6Rmnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977683; c=relaxed/simple;
	bh=f8+Vhy66DDQFtee9KLIEvyKZAjipJGkZ9oFccLAqwlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHROlAQRks5yu4OYclmDupWg0MuwrPxqgHU0ueQyb6QRWS2QzGaKuWnd3rW64+zF07IcJEtREQ5XbQKfMIHSk76L96GWHCDZhjjWGJ3bfz8uCD1xnsCsFHwv1LRjKmo32SUovQwsLQ+mN2QhkIUbyPC3ELeBZ8PrtXJlHVecCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FwQHUaSq; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OC0pKr029735;
	Wed, 24 Apr 2024 18:54:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=b4ZqEhQ
	7kItR8vjg6dUUgTLhYwcdolxQKmBrC6jANS8=; b=FwQHUaSqJ0SM/eojlhopY4Z
	bqe778jpKQACSqSoq7FPWJSML8ytQeh3XmK/wlgZURQGmS104HK2QS2qln2WevU7
	mfYupWhefB+uQ2Pq1V1NJ1OcHvhIF+76PwbJUdLsn0tkiSZTzkkXu1s/bTEJIZbV
	ExSgC/YtjLzs6Malit9PPbwN2P93UyQUYKKG5LnU4h3AnUFAUh4tgM5jrBB3x1cY
	9y79r1g+lkRYFjTk6l6M5FJnr+lYtkXBRfHMIXvzZZFJ50ZeLzHTDPdMRFA4Nu7M
	mbIwgLy/6g52y+hgQ2zPj75G3yGTJs5hb+sDjaq+o7nUJ+cR5QdWslfY8lQM+Ug=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnj6pnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 18:54:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0149D40044;
	Wed, 24 Apr 2024 18:54:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1714D2283A8;
	Wed, 24 Apr 2024 18:53:51 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 18:53:50 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] arm64: dts: st: correct masks for GIC PPI interrupts on stm32mp25
Date: Wed, 24 Apr 2024 18:53:44 +0200
Message-ID: <20240424185329.1.I0e240ebf31af03c7c5b932e36d1d34a5fad576d2@changeid>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02

Using GIC_CPU_MASK_SIMPLE(x), x should reflect the number of CPUs.
STM32MP251 is a single core Cortex A35, STM32MP253 is a dual core CA35.

Fixes: 5d30d03aaf78 ("arm64: dts: st: introduce stm32mp25 SoCs family")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm64/boot/dts/st/stm32mp251.dtsi | 8 ++++----
 arch/arm64/boot/dts/st/stm32mp253.dtsi | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index af1444bf9442..ee29c838900b 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -109,10 +109,10 @@ psci {
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&intc>;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 		always-on;
 	};
 
diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
index af48e82efe8a..029f88981961 100644
--- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
@@ -20,4 +20,11 @@ arm-pmu {
 			     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
+
+	timer {
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
 };
-- 
2.25.1


