Return-Path: <linux-kernel+bounces-68370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49385795D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D96281BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C320DF5;
	Fri, 16 Feb 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ll+ygLH8"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE00200C1;
	Fri, 16 Feb 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077027; cv=none; b=C0EDUI4cFhNkD/2Jg55a0qYUVga/9fbM9tT3prido5Y/0XK1WJ+mIzjx9T4+TflpKwNbnTUVP9LIKnO6zgyypaBRt7HJNUBJj2JQ8FhOLkrbl4fl171ve8rzprLwK88Z8sexgcTXzncKHD04gpX/py8D/S6uQMQiIm9PKjMoz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077027; c=relaxed/simple;
	bh=REP4VBqBSwWfeBkfsty6zw11hoRiR73EWJm4MfIi+6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNjsiEKhiAarX3Wumeh6MjfU69DbkWQCAsXvcnG+pPD+FeGL14MygXaMzUyUYN35lCNOs3kbNp2MMcsD2eOxUyp9HGGKvKCBiPY2UGfnCsFDzjOgetiJPLDeVd9Al8dP3wTSp37qqVb0GjQ1BL2Gatzt6yL7hXbh8xT2praDbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ll+ygLH8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qVQw017608;
	Fri, 16 Feb 2024 10:50:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=6QfjCwfoPchst587wVtUs5pgmUSIzRqIF3goqDifjF0=; b=Ll
	+ygLH8m7mL7HU44J5/hIRcuqcTMyckqwu2ypKUNdafs6bjkld72CEWD3TgorIEh+
	NYpzc+TGq6WyYiPdl3zUoJKSCX7SiENCbIaX/3WtQKKvI5kmHLcRDFvP68qlZIE3
	EYgPxx7AHNXk16uhdBWoUpEI2xu0mbxv100vG2qhrahFquuMufY7Y1JFLUSRTY1M
	4HAZlIDCgzU/odfgXcHXzbFXCO0efEgNOWNVHJ6J4uk6TzgZdHRIMhsQ+tJvi45S
	f1YSuzu0GFa28Tb5hiCJj1u7LWxIACFFzUIHoj5QfxwtrKcPu+rRVldTSi5R4sav
	Hm0unfd8jPSZgmprSlMg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa12ary7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:50:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2ED2F40046;
	Fri, 16 Feb 2024 10:50:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AAE11237D7C;
	Fri, 16 Feb 2024 10:49:24 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:49:24 +0100
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
Subject: [PATCH 09/12] ARM: dts: stm32: Use exti interrupt-map on stm32mp131
Date: Fri, 16 Feb 2024 10:47:54 +0100
Message-ID: <20240216094758.916722-10-antonio.borneo@foss.st.com>
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
By switching away from using the internal table, there is no need
anymore to use the specific compatible "st,stm32mp13-exti", which
was introduced to select the proper internal table.

Convert the driver table to interrupt-map property.
Switch the compatible string to the generic "st,stm32mp1-exti", in
place of the specific "st,stm32mp13-exti".

Older DT using compatible "st,stm32mp13-exti" will still work as
the driver remains backward compatible.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 49 +++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index b04d24c939c3..14bd1c9bedd9 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1093,10 +1093,57 @@ rcc: rcc@50000000 {
 		};
 
 		exti: interrupt-controller@5000d000 {
-			compatible = "st,stm32mp13-exti", "syscon";
+			compatible = "st,stm32mp1-exti", "syscon";
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
+					<5  0 &intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+					<6  0 &intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+					<7  0 &intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+					<8  0 &intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+					<9  0 &intc GIC_SPI 68  IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &intc GIC_SPI 41  IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &intc GIC_SPI 43  IRQ_TYPE_LEVEL_HIGH>,
+					<12 0 &intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+					<13 0 &intc GIC_SPI 78  IRQ_TYPE_LEVEL_HIGH>,
+					<14 0 &intc GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<15 0 &intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<16 0 &intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+					<19 0 &intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+					<21 0 &intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+					<22 0 &intc GIC_SPI 34  IRQ_TYPE_LEVEL_HIGH>,
+					<23 0 &intc GIC_SPI 73  IRQ_TYPE_LEVEL_HIGH>,
+					<24 0 &intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+					<25 0 &intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<26 0 &intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+					<27 0 &intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+					<28 0 &intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,
+					<29 0 &intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+					<30 0 &intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,
+					<31 0 &intc GIC_SPI 54  IRQ_TYPE_LEVEL_HIGH>,
+					<32 0 &intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+					<33 0 &intc GIC_SPI 84  IRQ_TYPE_LEVEL_HIGH>,
+					<44 0 &intc GIC_SPI 96  IRQ_TYPE_LEVEL_HIGH>,
+					<47 0 &intc GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
+					<48 0 &intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<50 0 &intc GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					<52 0 &intc GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					<53 0 &intc GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					<68 0 &intc GIC_SPI 63  IRQ_TYPE_LEVEL_HIGH>,
+					<70 0 &intc GIC_SPI 98  IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.34.1


