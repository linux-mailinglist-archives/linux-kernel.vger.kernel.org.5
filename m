Return-Path: <linux-kernel+bounces-68375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00850857969
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D4E1F2388E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EE1CF83;
	Fri, 16 Feb 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vxMg1fQI"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5311C282;
	Fri, 16 Feb 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077092; cv=none; b=FOWT1FMr8oKH8KcoE5cnFHaGDE3ia1mDSZFpyehXV+4sKl+GawQTvhn97CHluW2eybvl1YLl6B7cVD7VUAJOLD0ft09jc7T18dk1eGhynfKOqAKNPyUn+qjFVpGYhV81Y6QTmfxed/qkPhHlGesSnspYG+1BYZ0KRyUN2vGSQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077092; c=relaxed/simple;
	bh=8makX4nS6pLi7k7wsLDbsCjZPAZ3NUOghtyP+80Umw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qba5i1Bs9ZhBZc4uNgI5uN4dkc7YCaAeQW8YSoPoHNpXNbkAkmDT3zZ7gMQiUB4dR/5GFl3SAvuGaVreynFLeGiyOpVFDgFLZMhJST51787kZAEq1w41oPTfWnc0Gy0ZXtb2coBzzWFBy5bn2PEBufbWbTIHRJgPpflXzbUi91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vxMg1fQI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qA1M014068;
	Fri, 16 Feb 2024 10:51:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=71REGfTc7yoIJymQ9MkGvQ6YZAyCUgLqFHdkGlwLvK4=; b=vx
	Mg1fQIOdtedH7xLDUpV1gXXRThrWUXNlpwi7NFM00HiVpqQGJmuiG0eBP8WOq3II
	hRBWMfmzMbr40mlvapvqXpw/Le5guXK7k7sLnYJzPlafVo5b7donK1HL3hr9kFl6
	EkAKGWqg4AQJ+TpXfwx9Sx5auTnhlYROX0QGfgjQy+pv+ypXd9kx7oPsPkGZnlbb
	eFvOCe3qa8R9OZcG18TsD5eTnYHassqacLt7cgtRFXBZl5JzEvPWAN2ZCzfVJQP+
	Gkm7CIIyjWS90O+JW4EViiu0mQRMQa2xX8PM6DZgNWwBdla7RgWvkLxv0Z/i2j3B
	nh6xNGJ5u1Zv+UuMXteA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa124gycx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:51:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AD0540046;
	Fri, 16 Feb 2024 10:51:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4952022FA36;
	Fri, 16 Feb 2024 10:50:28 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:50:27 +0100
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
Subject: [PATCH 11/12] arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
Date: Fri, 16 Feb 2024 10:47:56 +0100
Message-ID: <20240216094758.916722-12-antonio.borneo@foss.st.com>
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

Update the device-tree stm32mp251.dtsi by adding the nodes for
exti1 and exti2 interrupt controllers.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 140 +++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 5c9095382cc7..4253f5bcd000 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -164,6 +164,86 @@ package_otp@1e8 {
 			};
 		};
 
+		exti1: interrupt-controller@44220000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			reg = <0x44220000 0x400>;
+
+			exti-interrupt-map {
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupt-map-mask = <0xffffffff 0>;
+				interrupt-map =
+					<0  0 &intc 0 0 GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+					<1  0 &intc 0 0 GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+					<2  0 &intc 0 0 GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+					<3  0 &intc 0 0 GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					<4  0 &intc 0 0 GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+					<5  0 &intc 0 0 GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+					<6  0 &intc 0 0 GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+					<7  0 &intc 0 0 GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+					<8  0 &intc 0 0 GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+					<9  0 &intc 0 0 GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &intc 0 0 GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &intc 0 0 GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+					<12 0 &intc 0 0 GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+					<13 0 &intc 0 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+					<14 0 &intc 0 0 GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					<15 0 &intc 0 0 GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					<16 0 &intc 0 0 GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+					<17 0 &intc 0 0 GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+					<18 0 &intc 0 0 GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					<19 0 &intc 0 0 GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+					<21 0 &intc 0 0 GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<22 0 &intc 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<23 0 &intc 0 0 GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					<24 0 &intc 0 0 GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					<25 0 &intc 0 0 GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+					<26 0 &intc 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<27 0 &intc 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<28 0 &intc 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<29 0 &intc 0 0 GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					<30 0 &intc 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<31 0 &intc 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+					<32 0 &intc 0 0 GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					<33 0 &intc 0 0 GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					<34 0 &intc 0 0 GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<36 0 &intc 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					<37 0 &intc 0 0 GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					<38 0 &intc 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<39 0 &intc 0 0 GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					<40 0 &intc 0 0 GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					<41 0 &intc 0 0 GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					<42 0 &intc 0 0 GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					<43 0 &intc 0 0 GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+					<44 0 &intc 0 0 GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+					<45 0 &intc 0 0 GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+					<46 0 &intc 0 0 GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+					<47 0 &intc 0 0 GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+					<48 0 &intc 0 0 GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+					<49 0 &intc 0 0 GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+					<50 0 &intc 0 0 GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+					<59 0 &intc 0 0 GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+					<61 0 &intc 0 0 GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+					<64 0 &intc 0 0 GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+					<67 0 &intc 0 0 GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+					<68 0 &intc 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					<70 0 &intc 0 0 GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					<72 0 &intc 0 0 GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+					<73 0 &intc 0 0 GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+					<74 0 &intc 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<75 0 &intc 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<76 0 &intc 0 0 GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					<77 0 &intc 0 0 GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+					<78 0 &intc 0 0 GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+					<79 0 &intc 0 0 GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+					<83 0 &intc 0 0 GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+					<84 0 &intc 0 0 GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		syscfg: syscon@44230000 {
 			compatible = "st,stm32mp25-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
@@ -318,5 +398,65 @@ gpioz: gpio@46200000 {
 			};
 
 		};
+
+		exti2: interrupt-controller@46230000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			reg = <0x46230000 0x400>;
+
+			exti-interrupt-map {
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupt-map-mask = <0xffffffff 0>;
+				interrupt-map =
+					<0  0 &intc 0 0 GIC_SPI 17  IRQ_TYPE_LEVEL_HIGH>,
+					<1  0 &intc 0 0 GIC_SPI 18  IRQ_TYPE_LEVEL_HIGH>,
+					<2  0 &intc 0 0 GIC_SPI 19  IRQ_TYPE_LEVEL_HIGH>,
+					<3  0 &intc 0 0 GIC_SPI 20  IRQ_TYPE_LEVEL_HIGH>,
+					<4  0 &intc 0 0 GIC_SPI 21  IRQ_TYPE_LEVEL_HIGH>,
+					<5  0 &intc 0 0 GIC_SPI 22  IRQ_TYPE_LEVEL_HIGH>,
+					<6  0 &intc 0 0 GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+					<7  0 &intc 0 0 GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+					<8  0 &intc 0 0 GIC_SPI 25  IRQ_TYPE_LEVEL_HIGH>,
+					<9  0 &intc 0 0 GIC_SPI 26  IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &intc 0 0 GIC_SPI 27  IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &intc 0 0 GIC_SPI 28  IRQ_TYPE_LEVEL_HIGH>,
+					<12 0 &intc 0 0 GIC_SPI 29  IRQ_TYPE_LEVEL_HIGH>,
+					<13 0 &intc 0 0 GIC_SPI 30  IRQ_TYPE_LEVEL_HIGH>,
+					<14 0 &intc 0 0 GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+					<15 0 &intc 0 0 GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+					<16 0 &intc 0 0 GIC_SPI 12  IRQ_TYPE_LEVEL_HIGH>,
+					<17 0 &intc 0 0 GIC_SPI 13  IRQ_TYPE_LEVEL_HIGH>,
+					<21 0 &intc 0 0 GIC_SPI 14  IRQ_TYPE_LEVEL_HIGH>,
+					<22 0 &intc 0 0 GIC_SPI 15  IRQ_TYPE_LEVEL_HIGH>,
+					<25 0 &intc 0 0 GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+					<26 0 &intc 0 0 GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					<27 0 &intc 0 0 GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					<29 0 &intc 0 0 GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+					<30 0 &intc 0 0 GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+					<31 0 &intc 0 0 GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+					<33 0 &intc 0 0 GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+					<34 0 &intc 0 0 GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+					<37 0 &intc 0 0 GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+					<40 0 &intc 0 0 GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+					<43 0 &intc 0 0 GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+					<46 0 &intc 0 0 GIC_SPI 11  IRQ_TYPE_LEVEL_HIGH>,
+					<48 0 &intc 0 0 GIC_SPI 5   IRQ_TYPE_LEVEL_HIGH>,
+					<49 0 &intc 0 0 GIC_SPI 4   IRQ_TYPE_LEVEL_HIGH>,
+					<50 0 &intc 0 0 GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,
+					<51 0 &intc 0 0 GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+					<52 0 &intc 0 0 GIC_SPI 2   IRQ_TYPE_LEVEL_HIGH>,
+					<53 0 &intc 0 0 GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+					<61 0 &intc 0 0 GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+					<62 0 &intc 0 0 GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+					<64 0 &intc 0 0 GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+					<65 0 &intc 0 0 GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+					<66 0 &intc 0 0 GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+					<67 0 &intc 0 0 GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+					<70 0 &intc 0 0 GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
 	};
 };
-- 
2.34.1


