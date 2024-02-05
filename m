Return-Path: <linux-kernel+bounces-52263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19A84960D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A642871CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272918037;
	Mon,  5 Feb 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ha4lGeLJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F913FFB;
	Mon,  5 Feb 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124066; cv=none; b=AoEq5Bnj7G3SKL57qK9NJFkJIiilSQhvKeC77jFLvSqE/ztE+ggpYwAdbPF2S463GX8vXWjmU5ne9hrFsVoDRH3MP0CE053cn21uljf4gPtiWAPmVTL6536jTca4ooTS7Yb2tgvQfOlDyhH9a3MlR8XKcbAd+xrCNdGUPpuYh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124066; c=relaxed/simple;
	bh=/PC3cwCnH2K8/ch3GGJtdAHUfyOeBPVZZUZYOfJ9cjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V0o5bnEvPVQ3Oy9StGuZ8QDENmldQsGnim59DPyynTdoAot45XGkYr74XJ+L9jaum4xGgCxIeCDHB4okKSIPnP3KSmrB9HqZW1KXHg3HONdDE0vkWG8PazfXTfk/yMyw129OfqP+EZ6Dzxk7h0sqKcniskrr4ewzxQiJ129PGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ha4lGeLJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158QGPd010843;
	Mon, 5 Feb 2024 10:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=0b38tedRyxz1wugMy9qAGe9nstQPcZ6cdawHN0/CbEE
	=; b=ha4lGeLJMAyMUexImqMbKQl4r/g+pV2RPCto7FtbIm7bY/+I+gTfoBzFxou
	B84aZqtcQRYeUMCKhEMqygX7Tz0y0ZcVS+GePA7QAh8rZskYVSXbzOIkMMrD6GyP
	1gHEmuKevzlVJWbEj+JD8eMKNPdHy4KFLHJeFNkeG5SMCNsBiFTlT9ZxFML3mbS7
	8sXLuiGnEzPYdikHQM6TmUi3yCKlhB8ewKeVWPwUr2FdG25xKj8ZunzGydk5KXxe
	yscM6vY76+d22E6928GZ8Zq9NArm4ADTKoNONZJUKffpZCwK6klXGsMkWJ17Vhdt
	lBTYzDg4eJIBQzx9uLNRn+FPZFw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1eyp60u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:06:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C02E010003B;
	Mon,  5 Feb 2024 10:06:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB8CB29E60A;
	Mon,  5 Feb 2024 10:06:53 +0100 (CET)
Received: from localhost (10.252.18.216) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 10:06:53 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Mon, 5 Feb 2024 10:06:51 +0100
Subject: [PATCH 1/5] ARM: dts: stm32: add LTDC support for STM32MP13x SoC
 family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240205-ltdc_mp13-v1-1-072d24bf1b36@foss.st.com>
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
	<raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02

STM32MP13x SoC family embeds a new version of LTDC (Liquid crystal
display - Thin film transistor) Display Controller.

It provides a parallel digital RGB (red, green, blue) and signals for
horizontal, vertical synchronization, pixel clock and data enable as
output to interface directly to a variety of LCD-TFT panels.

Main features
  * 2 input layers blended together to compose the display
  * Cropping of layers from any input size and location
  * Multiple input pixel formats:
    – Predefined ARGB, with 7 formats: ARGB8888, ABGR8888, RGBA8888,
    BGRA8888, RGB565, BGR565, RGB888packed.
    – Flexible ARGB, allowing any width and location for A,R,G,B
    components.
    – Predefined YUV, with 3 formats: YUV422-1L (FourCC: YUYV,
    Interleaved), YUV420-2L (FourCC: NV12, semi planar), YUV420-3L
    (FourCC: Yxx, full planar) with some flexibility on the sequence of
    the component.
  * Color look-up table (CLUT) up to 256 colors (256x24 bits) per layer
  * Color transparency keying
  * Composition with flexible window position and size versus output
  display
  * Blending with flexible layer order and alpha value (per pixel or
  constant)
  * Background underlying color
  * Gamma with non-linear configurable table
  * Dithering for output with less bits per component (pseudo-random on
  2 bits)
  * Polarity inversion for HSync, VSync, and DataEnable outputs
  * Output as RGB888 24 bpp or YUV422 16 bpp
  * Secure layer (using Layer2) capability, with grouped regs and
  additional interrupt set
  * Interrupts based on 7 different events
  * AXI master interface with long efficient bursts (64 or 128 bytes)

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135.dtsi b/arch/arm/boot/dts/st/stm32mp135.dtsi
index 68d32f9f5314..834a4d545fe4 100644
--- a/arch/arm/boot/dts/st/stm32mp135.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp135.dtsi
@@ -19,5 +19,16 @@ dcmipp: dcmipp@5a000000 {
 			port {
 			};
 		};
+
+		ltdc: display-controller@5a001000 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x5a001000 0x400>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc LTDC_PX>;
+			clock-names = "lcd";
+			resets = <&scmi_reset RST_SCMI_LTDC>;
+			status = "disabled";
+		};
 	};
 };

-- 
2.25.1


