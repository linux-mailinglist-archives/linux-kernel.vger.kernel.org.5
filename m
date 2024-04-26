Return-Path: <linux-kernel+bounces-160208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058C8B3A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F127B2867D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907501494A1;
	Fri, 26 Apr 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sC2BzoKI"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281CA14884A;
	Fri, 26 Apr 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143994; cv=none; b=HMffYL0C9Ry9cpwnSyS9wFqvgzPqst7a4VpB2DTC2wuOF+FSiSvYCh+XCQzzY7msceyqvBw8XutxwU9SPAys5PlOW/2aqo4c3W/keMdtdJyj4mUJaePIRupDD8KMS/XiMiD0n080oxJAENGAZItqy8WGzQR+RWYLygPBrKYIfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143994; c=relaxed/simple;
	bh=BD0Qf9WPkKr4zJhWMWsk8v9xQAGHzENC8wnnzn1rEdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gg80RIuUzi8cY/HakergsM/1anu0KrtR+Uj/duBYF6+4ky8NO6a5MWics/fa3o3ssFyP5ATZU//92qbp9FTCZotng5K9MGIdtr8d6KVlAgi3luqUBVfg+Jv88IcuDKGB+8h9OweRgZe+XINVKp5RATYBZxxRVp9Qe04yHKOtOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sC2BzoKI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QDIZP5016364;
	Fri, 26 Apr 2024 17:06:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=6YrMkwdcMEba37Dr4YOcNaLg4oy1sj3dUWUmxDd/7wk=; b=sC
	2BzoKIkHpJdQTjnxheJTalipPcLhbYTN9/qNL8iPlXaFUpR8QYz8qLR15zn/8Qqb
	DDaEA/pkjM63L4D2Vxt4VVbo+0aOJSjz5CFL1ytQF1CNWyWidtaHO5s7e2TR06HL
	U0sTcHF5wdnwl4S5eqLQ4KwM8At/4/vVJtrrD3+ThGfxziejWNEI+vuKt1ORRl6M
	9Y+im2/WE8cgAITckTAuARg2Gs2KCvXFtLdwT041KJXBWq9zptgNxXfWmBfu2vmZ
	t3RA/VeJwagJ7rft976bpShCAwMK3X+FQ7DZC7OiREHGunMmaPyAgfcFh0gCJjan
	iARO/LT3Rgg4ADT5C6Ww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmq910mhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 17:06:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CE5904002D;
	Fri, 26 Apr 2024 17:06:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 625C4227F06;
	Fri, 26 Apr 2024 17:05:41 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 17:05:41 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Alain Volmat <alain.volmat@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: dts: stm32: add DCMIPP pinctrl on STM32MP13x SoC family
Date: Fri, 26 Apr 2024 17:05:24 +0200
Message-ID: <20240426150526.3094607-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426150526.3094607-1-alain.volmat@foss.st.com>
References: <20240426150526.3094607-1-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Adds DCMIPP pinctrl support and assigns dedicated GPIO pins.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index 32c5d8a1e06a..b423d182aefd 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -13,6 +13,39 @@ pins {
 		};
 	};
 
+	dcmipp_pins_a: dcmi-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H',  8,  AF13)>,/* DCMI_HSYNC */
+				 <STM32_PINMUX('G',  9,  AF13)>,/* DCMI_VSYNC */
+				 <STM32_PINMUX('B',  7,  AF14)>,/* DCMI_PIXCLK */
+				 <STM32_PINMUX('A',  9,  AF13)>,/* DCMI_D0 */
+				 <STM32_PINMUX('D',  0,  AF13)>,/* DCMI_D1 */
+				 <STM32_PINMUX('G', 10,  AF13)>,/* DCMI_D2 */
+				 <STM32_PINMUX('E',  4,  AF13)>,/* DCMI_D3 */
+				 <STM32_PINMUX('D', 11,  AF14)>,/* DCMI_D4 */
+				 <STM32_PINMUX('D',  3,  AF13)>,/* DCMI_D5 */
+				 <STM32_PINMUX('B',  8,  AF13)>,/* DCMI_D6 */
+				 <STM32_PINMUX('E', 14,  AF13)>;/* DCMI_D7 */
+			bias-disable;
+		};
+	};
+
+	dcmipp_sleep_pins_a: dcmi-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H',  8,  ANALOG)>,/* DCMI_HSYNC */
+				 <STM32_PINMUX('G',  9,  ANALOG)>,/* DCMI_VSYNC */
+				 <STM32_PINMUX('B',  7,  ANALOG)>,/* DCMI_PIXCLK */
+				 <STM32_PINMUX('A',  9,  ANALOG)>,/* DCMI_D0 */
+				 <STM32_PINMUX('D',  0,  ANALOG)>,/* DCMI_D1 */
+				 <STM32_PINMUX('G', 10,  ANALOG)>,/* DCMI_D2 */
+				 <STM32_PINMUX('E',  4,  ANALOG)>,/* DCMI_D3 */
+				 <STM32_PINMUX('D', 11,  ANALOG)>,/* DCMI_D4 */
+				 <STM32_PINMUX('D',  3,  ANALOG)>,/* DCMI_D5 */
+				 <STM32_PINMUX('B',  8,  ANALOG)>,/* DCMI_D6 */
+				 <STM32_PINMUX('E', 14,  ANALOG)>;/* DCMI_D7 */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.34.1


