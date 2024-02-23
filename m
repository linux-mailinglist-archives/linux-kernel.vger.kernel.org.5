Return-Path: <linux-kernel+bounces-78304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2D8611A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCE6285E50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DC7E78B;
	Fri, 23 Feb 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KqX52Xbx"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C617E780;
	Fri, 23 Feb 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691946; cv=none; b=eWhqzcgiTgLBK1TmL1ijxXVHoEe8LOedBmYSUJuYTV0ZgOhK7Sofn/qf/fCsDAl7gz34wPu07mU4Iwpecp5qJ68HF3uLz/AktGFPLG8oMassfEjtZ9x69PNwmcQLDwULa5WbNrIq7VMqbCBS8rlYR3Z7meupZ96FTr3GB4qfpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691946; c=relaxed/simple;
	bh=Vu3pxfSOvU02G6kf5xYrgXdA4Nr4gnOhkhAT0KtaVio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PlylWbAmCfljiNVd6BbshFhEtgTvRrF55/LS3Q2PHYtRAPPJsUKcGxOp8X0dMFzt1YFasWPDuHAVWF6vthuG+tdPWRjAN6UlEF4H5FQ6rMcW34fsdqfaWTMSX8Tt0FPsfnVdGbyFsjR6RWe7fqvxJy0DyzFdR0AZHCRnnuJQy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KqX52Xbx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6TQdn027885;
	Fri, 23 Feb 2024 13:38:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=B/DdT1Hekue/y2cbdJTf13MdZkRgi2lmLP5jnu8Gv/8
	=; b=KqX52Xbx422s3kbIDBNVIVnin5onGlim3lEALQ0jXOmGxTV7NW2mTf8dMjs
	qoHfNORlZgV8mGHAEFea9S0xhycxfnqpHUut/UdMXJoWERTHYx0+gPS9PwDJz5EC
	cSVGaRuC9L3X2kOmWEBNvxnqDh+CtWUE0i2RR0cuE/YahB0KMciJteqeNRF5ut1s
	A9cgoClPl5jMnVruN/P+tfzMxxTMLSQ8TvEnSGLur3YfOsb72vIXtUukzgI/RekS
	jZjj3Uz/Uul63zBMMjxaCmL27oi7dDChNClUyE9KYI1RLnM/eRnvZV3RY/rqJNx0
	wzpioxPxCEmaMep4UYwmYk1ot7Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd201vx12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 13:38:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4E3C740045;
	Fri, 23 Feb 2024 13:38:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9AD4B28DDC0;
	Fri, 23 Feb 2024 13:36:54 +0100 (CET)
Received: from localhost (10.129.178.151) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 13:36:53 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 23 Feb 2024 13:36:49 +0100
Subject: [PATCH v3 2/4] ARM: dts: stm32: add LTDC pinctrl on STM32MP13x SoC
 family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-ltdc_mp13-v3-2-7f92a59ca11f@foss.st.com>
References: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
In-Reply-To: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02

Adds LTDC pinctrl support and assigns dedicated GPIO pins.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 57 +++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index 27e0c3826789..32c5d8a1e06a 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -47,6 +47,63 @@ pins {
 		};
 	};
 
+	ltdc_pins_a: ltdc-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D',  9, AF13)>, /* LCD_CLK */
+				 <STM32_PINMUX('C',  6, AF14)>, /* LCD_HSYNC */
+				 <STM32_PINMUX('G',  4, AF11)>, /* LCD_VSYNC */
+				 <STM32_PINMUX('H',  9, AF11)>, /* LCD_DE */
+				 <STM32_PINMUX('G',  7, AF14)>, /* LCD_R2 */
+				 <STM32_PINMUX('B', 12, AF13)>, /* LCD_R3 */
+				 <STM32_PINMUX('D', 14, AF14)>, /* LCD_R4 */
+				 <STM32_PINMUX('E',  7, AF14)>, /* LCD_R5 */
+				 <STM32_PINMUX('E', 13, AF14)>, /* LCD_R6 */
+				 <STM32_PINMUX('E',  9, AF14)>, /* LCD_R7 */
+				 <STM32_PINMUX('H', 13, AF14)>, /* LCD_G2 */
+				 <STM32_PINMUX('F',  3, AF14)>, /* LCD_G3 */
+				 <STM32_PINMUX('D',  5, AF14)>, /* LCD_G4 */
+				 <STM32_PINMUX('G',  0, AF14)>, /* LCD_G5 */
+				 <STM32_PINMUX('C',  7, AF14)>, /* LCD_G6 */
+				 <STM32_PINMUX('A', 15, AF11)>, /* LCD_G7 */
+				 <STM32_PINMUX('D', 10, AF14)>, /* LCD_B2 */
+				 <STM32_PINMUX('F',  2, AF14)>, /* LCD_B3 */
+				 <STM32_PINMUX('H', 14, AF11)>, /* LCD_B4 */
+				 <STM32_PINMUX('E',  0, AF14)>, /* LCD_B5 */
+				 <STM32_PINMUX('B',  6, AF7)>,  /* LCD_B6 */
+				 <STM32_PINMUX('F',  1, AF13)>; /* LCD_B7 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	ltdc_sleep_pins_a: ltdc-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D',  9, ANALOG)>, /* LCD_CLK */
+				 <STM32_PINMUX('C',  6, ANALOG)>, /* LCD_HSYNC */
+				 <STM32_PINMUX('G',  4, ANALOG)>, /* LCD_VSYNC */
+				 <STM32_PINMUX('H',  9, ANALOG)>, /* LCD_DE */
+				 <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_R2 */
+				 <STM32_PINMUX('B', 12, ANALOG)>, /* LCD_R3 */
+				 <STM32_PINMUX('D', 14, ANALOG)>, /* LCD_R4 */
+				 <STM32_PINMUX('E',  7, ANALOG)>, /* LCD_R5 */
+				 <STM32_PINMUX('E', 13, ANALOG)>, /* LCD_R6 */
+				 <STM32_PINMUX('E',  9, ANALOG)>, /* LCD_R7 */
+				 <STM32_PINMUX('H', 13, ANALOG)>, /* LCD_G2 */
+				 <STM32_PINMUX('F',  3, ANALOG)>, /* LCD_G3 */
+				 <STM32_PINMUX('D',  5, ANALOG)>, /* LCD_G4 */
+				 <STM32_PINMUX('G',  0, ANALOG)>, /* LCD_G5 */
+				 <STM32_PINMUX('C',  7, ANALOG)>, /* LCD_G6 */
+				 <STM32_PINMUX('A', 15, ANALOG)>, /* LCD_G7 */
+				 <STM32_PINMUX('D', 10, ANALOG)>, /* LCD_B2 */
+				 <STM32_PINMUX('F',  2, ANALOG)>, /* LCD_B3 */
+				 <STM32_PINMUX('H', 14, ANALOG)>, /* LCD_B4 */
+				 <STM32_PINMUX('E',  0, ANALOG)>, /* LCD_B5 */
+				 <STM32_PINMUX('B',  6, ANALOG)>, /* LCD_B6 */
+				 <STM32_PINMUX('F',  1, ANALOG)>; /* LCD_B7 */
+		};
+	};
+
 	mcp23017_pins_a: mcp23017-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G', 12, GPIO)>;

-- 
2.25.1


