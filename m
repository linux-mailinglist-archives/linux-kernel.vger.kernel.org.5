Return-Path: <linux-kernel+bounces-145305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C28A5259
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BB21C22942
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CC74BE2;
	Mon, 15 Apr 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4dPP61s8"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065673510;
	Mon, 15 Apr 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189178; cv=none; b=eWXLf9gmN0hHbmeltuHMvc81qy+jxgmwFs7EkRrcZK/TiyxZ9j7H3/E9sZerX7hC526MacZi/ID3ZZtfsI9Xcjjf7DmMZIvIDaeWKf8xIxFyRoTz8oVZE41k1YZvDljm6IaTTNGxAiMBGzsS+fM3n/DAdkauZNaQDB40/n+aquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189178; c=relaxed/simple;
	bh=x2yJWv2mQjsgthNw/yzyjrCzabquq7XJW7nHTQIP4vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r26Lp8qhVCrpmx0fsrYy5syI7JUHxqeGGuXQU4PPt+g1sOphb+OyXRoDH4gfuDVZyE1OZIKDDKpAlXTYIF1bi3XQ0IKDNfEyddytSs7cTeqGMxzCjXt1DscITIV+XcUx69r9sXWzg75VJ2ALUtTVD/iRwDVnMHByR63p8FwqGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4dPP61s8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FC6d2L010871;
	Mon, 15 Apr 2024 15:52:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=TpAagzTiObNTvJYrl3JMELELrVdEgi940QNq4JM9qzI=; b=4d
	PP61s8Wk474nWsj8XeFANZt+6HjFEZerfXcklueD9HWkWdi+Di1KWogpLPy4Ue8Y
	lVkoeBVeEcCyT0PjxDyPoHoK9BUTbctrvRdT/K+GaixLAfd+/nYYHXrsvb1RZhDg
	tUoh+kdmter76q8QLLo/hpohuLct1FsIqPmtyJkuGpnFbppbeAOPZA2cjHCR1YIf
	TYl+YyX8MlgECD5JnTq9qipgVUwlS8xjwnSrLYlu939p03MRbnHAGz7AKkfLbE9f
	ivPtdGaxjAUJmvFZhOYI2Fka3hE4CC4EsEyMt3jMv5xaG7r/ESQb4YcxvtW8pcSa
	AU1LVh57rsMvGX58Xc9A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50hngb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:52:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B71414002D;
	Mon, 15 Apr 2024 15:52:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DBD9212316;
	Mon, 15 Apr 2024 15:51:54 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:51:53 +0200
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
Subject: [PATCH v2 10/11] arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
Date: Mon, 15 Apr 2024 15:49:25 +0200
Message-ID: <20240415134926.1254428-11-antonio.borneo@foss.st.com>
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

Update the device-tree stm32mp251.dtsi by adding the nodes for
exti1 and exti2 interrupt controllers.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 172 +++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 5dd4f3580a60f..1426446ca1b11 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -168,6 +168,99 @@ package_otp@1e8 {
 			};
 		};
 
+		exti1: interrupt-controller@44220000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x44220000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+				<&intc GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+				<0>,
+				<&intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_80 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		syscfg: syscon@44230000 {
 			compatible = "st,stm32mp25-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
@@ -322,5 +415,84 @@ gpioz: gpio@46200000 {
 			};
 
 		};
+
+		exti2: interrupt-controller@46230000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x46230000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 17  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 18  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 19  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 20  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 21  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 22  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 25  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 26  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 27  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 28  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 29  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 30  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 12  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 13  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 14  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 15  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 11  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 5   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 4   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 2   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
+		};
 	};
 };
-- 
2.34.1


