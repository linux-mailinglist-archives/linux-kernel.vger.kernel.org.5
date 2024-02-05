Return-Path: <linux-kernel+bounces-52262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C318984960B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE0283965
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C6B14A91;
	Mon,  5 Feb 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="C/BBR+Tb"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D813FF2;
	Mon,  5 Feb 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124066; cv=none; b=NUQeE9He0l1B1+wqFLKX8O5VeKXvcU7R+1n71Aid4DoPgOY+Flb6IjgdEnVtCemN4uy+FnUyJWMz7KiICN65825RMJzxqFWAwcBr37byJpmsAo2AB82QVS14JSaJGBpf0XPOtTv/HVqqDYTT4YTyPIOz13Hc4IL5VKSZNRzdr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124066; c=relaxed/simple;
	bh=Vu3pxfSOvU02G6kf5xYrgXdA4Nr4gnOhkhAT0KtaVio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KhLUyE9z8BWfJa72fGcmlH4/nPp58SfY+/8L49oHBgr1VqBLheqq7hrThsloWZjTZorzsj+puSSKt9xAQNNjFK1r3CcvZqVWpEpzPUTmnk8CaKPDE/KzhpFyrqL9OdU+MOeBpvc6gZ+gz8NQwX9BQ9BUdj0QEoUx5HIzUwvEesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=C/BBR+Tb; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158UuPo009671;
	Mon, 5 Feb 2024 10:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=B/DdT1Hekue/y2cbdJTf13MdZkRgi2lmLP5jnu8Gv/8
	=; b=C/BBR+TbLRcfNVyfU8TPuEtxYO6I+CZBdw9CZxz62/vQ+HwFZ7Un2Q89xhk
	AAbqXNCSNo9m38cR4gOOd3ubWu7HLGv9J3spfCmyoawX3JD+VvbGSoGBe39uEcjp
	yjWMDCbFIazhiwucD6E+gVcxmGjUjgoeSeLi9wkJL0Mp9Db4pohhdBX+aTPaToDc
	GoLBazSd4R9KAc0vSlhzCtRgJ/1pmYcV163thgKSGZx9n4cBIN1xst4jZz+lfgJm
	0mejCNnhMHqoA+z02IOHTf0NcffGYu7GIwphBAQdB4bx1i83FOJCacf0TQ/E9kl+
	J9VpsV9nUGpHnuoMXYXBXzj2Lhw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1yx3utu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:06:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4D78100064;
	Mon,  5 Feb 2024 10:06:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C966929E60E;
	Mon,  5 Feb 2024 10:06:54 +0100 (CET)
Received: from localhost (10.252.18.216) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 10:06:53 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Mon, 5 Feb 2024 10:06:52 +0100
Subject: [PATCH 2/5] ARM: dts: stm32: add LTDC pinctrl on STM32MP13x SoC
 family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-ltdc_mp13-v1-2-072d24bf1b36@foss.st.com>
References: <20240205-ltdc_mp13-v1-0-072d24bf1b36@foss.st.com>
In-Reply-To: <20240205-ltdc_mp13-v1-0-072d24bf1b36@foss.st.com>
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
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02

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


