Return-Path: <linux-kernel+bounces-68371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A102B85795F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A32808EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496502232C;
	Fri, 16 Feb 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Appw7fH4"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACD20DF0;
	Fri, 16 Feb 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077029; cv=none; b=Ig+UKeutMI2rl+BkVbd7X3Vtj3F9YDu57rZdnRm/ZH6KcCXmPWUw5Sj70809HWjIw356BMhC1qwxFP1nm3l2RLaUsI4Gizn5q5pDQ9V+iDMSWC2mfq9QCTUSVcHEtRf6McTEoeC3dW6MAmYBSIuJu1dY7m5gZX4AIc4JvvvoabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077029; c=relaxed/simple;
	bh=CKF19vvrEXl+K22tbPsavgofVcgBDneCNcVVkmh0WN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5eg9YhLfld2eXsHdAwhsXgo/qQ/Jn71lv5Kp0S6zRAt3Mhf4dLBG5xtReOhym9HSC1wYX4Br2b28xv7EySYh8fP3yqZzfrITZKCkhcHIvFKxyNETd/JwAIuq/0sZ26IntxAIGUnwf3DSjlRGvaUtBEADoNHUmA3JSAHMVaWd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Appw7fH4; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qPtY015733;
	Fri, 16 Feb 2024 10:50:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=+fxKXdkROzT3M+/iRky170lOst61Y8+W0nzGBLi971o=; b=Ap
	pw7fH4IJUX/c324kbwir6nOnL40h6y/qP0alnLqfIszOFG6JHz0jdTTMMWti158G
	eyMC/7WlUIbWn94woIe321T3IRDy/9LlI88eFJyeoszxvvI+JfbJhvTb6HMMCDL1
	AKckjOk3AyUPsVkWr28a73agH8PAvJ5ZnWDZYB4Iv0/PQ0wD01RBBT4I85BrpYRE
	nwnfcLVIB/61fBBlKm8Lt//WBC+Sjy1Bas5TLH7V8PJOTjcNPtjQgKKYvzb33h/q
	2aN3YNBTed9GJL5bChevjfKRSBU6O6tifA0Pfm3wqS0xdX7GdICOIiMAssudN90J
	G3j6Mj/uf+8yPSllASgA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa124gy88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:50:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B33D840048;
	Fri, 16 Feb 2024 10:50:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13158237D7B;
	Fri, 16 Feb 2024 10:49:24 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:49:23 +0100
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
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/12] ARM: dts: stm32: Use exti interrupt-map on stm32mp151
Date: Fri, 16 Feb 2024 10:47:53 +0100
Message-ID: <20240216094758.916722-9-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02

Stop using the internal table of the exti driver and use the more
flexible interrupt-map feature in DT.

Convert the driver's table for stm32mp151 to the interrupt-map
property in DT.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index fa4cbd312e5a..33c460cacb04 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -1223,7 +1223,58 @@ exti: interrupt-controller@5000d000 {
 			compatible = "st,stm32mp1-exti", "syscon";
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			#address-cells = <0>;
 			reg = <0x5000d000 0x400>;
+
+			exti-interrupt-map {
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupt-map-mask = <0xffffffff 0>;
+				interrupt-map =
+					<0  0 &intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,
+					<1  0 &intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+					<2  0 &intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+					<3  0 &intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+					<4  0 &intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+					<5  0 &intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+					<6  0 &intc GIC_SPI 64  IRQ_TYPE_LEVEL_HIGH>,
+					<7  0 &intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+					<8  0 &intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+					<9  0 &intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &intc GIC_SPI 42  IRQ_TYPE_LEVEL_HIGH>,
+					<12 0 &intc GIC_SPI 76  IRQ_TYPE_LEVEL_HIGH>,
+					<13 0 &intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+					<14 0 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<15 0 &intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+					<16 0 &intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+					<19 0 &intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+					<21 0 &intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+					<22 0 &intc GIC_SPI 33  IRQ_TYPE_LEVEL_HIGH>,
+					<23 0 &intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+					<24 0 &intc GIC_SPI 95  IRQ_TYPE_LEVEL_HIGH>,
+					<25 0 &intc GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					<26 0 &intc GIC_SPI 37  IRQ_TYPE_LEVEL_HIGH>,
+					<27 0 &intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+					<28 0 &intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+					<29 0 &intc GIC_SPI 71  IRQ_TYPE_LEVEL_HIGH>,
+					<30 0 &intc GIC_SPI 52  IRQ_TYPE_LEVEL_HIGH>,
+					<31 0 &intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,
+					<32 0 &intc GIC_SPI 82  IRQ_TYPE_LEVEL_HIGH>,
+					<33 0 &intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+					<46 0 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					<47 0 &intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+					<48 0 &intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					<50 0 &intc GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					<52 0 &intc GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					<53 0 &intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					<54 0 &intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					<61 0 &intc GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<65 0 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<68 0 &intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					<70 0 &intc GIC_SPI 62  IRQ_TYPE_LEVEL_HIGH>,
+					<73 0 &intc GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.34.1


