Return-Path: <linux-kernel+bounces-155891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E48AF89D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E7E28612D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9F144315;
	Tue, 23 Apr 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLFQjipZ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384B143C5C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905574; cv=none; b=iw1zOY6XFLvnoG8xnGG4UbjYSyk+5mzZp1bzVfWdO91GZBUIlOsxUeA0QiOvgxIyH9y7ItYDJ1Mg16baPICNCgeC+gwEOmai/rDMUs82Dlbv2AgsZbVsDVFcyC00egmQ+k741OrEQ8ZZo8FKjUoxosgh2Cthn8VeCE741V96KNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905574; c=relaxed/simple;
	bh=7n2qiRxfXj0RhQJoPJ2Jx1nLhQPN1ajHcYUQIS8AbvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYmqRoAXUakYhCtGkCtLAej37mBh5rUUr7P9AV/o0MRhIf/FGg/JAhnKuSrgyrpqV0i2BuQJheJBkkvc2l127n1iGfqlrh1KQ7vH01VFNfhI4Cz/7Hucc+KXWkuqqugjjbXRKXP8mChgxtijoEna/Lb57m/vgJ9jF9TxdtuK/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kLFQjipZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346359c8785so5042084f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905571; x=1714510371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1GZJJLKOpK1Q+g+fKW1mL5kKY9CXXEvR0RLPI154Do=;
        b=kLFQjipZCU8TkamC5b5w0oFq+LEnP4Pgy2cMg+gMnlMoO0vQm13A9vMh1PNgrt8pTW
         SU7qOcQ7Ei4TfvK1h6cNirN4ZoP+eE/bXPmUopsuSux77jkC7nA2Ip8q6UCMRxbergLA
         vcNWDNZm2JwYOYwhFbTjT4MPAiRma/gD9xaMMDmkGSeqF5VWuUveTtRhEpEuavAfe1+G
         xQmqK3jKBFQHIwa562ltcn1gbaCH5qgh+qbGsDWswPOGDq2KZmBVkvfHExfXMoLd0I6C
         Mfsk4d4RjMmeAgmHeULWkRi6kz9kYvoGdJgc/IQdn+rkc+thFfXBn3Mz6H6ZtrkyZfsn
         kkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905571; x=1714510371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1GZJJLKOpK1Q+g+fKW1mL5kKY9CXXEvR0RLPI154Do=;
        b=JW1AIg9psx6lx9oPkPvjskbW6IR84Nmu4lLpmF5sjFlDahSA3eueghbFpjTKpZDxAm
         0UQvl0+U/PefeAsIDJOwHgzFY4CuO68J6GuDwgoCyEzq27SBTSrN6W1GRqlLsbq9Cb0J
         fN45Oc6xKuVqw8PpbQd191CdVz0QSN2tUn5bVRdLnhZxUs5dN/xWR5mbVxfOGc2RlOiS
         UEsGwJXOougsp/nHL2/6lp8ptLtzzvwf5SEHOHkCSTGQV0C844zJviievDovaz20WvBN
         ylMl+w9au5oCuu5++6pPmUvuMQjMY7LqOdPhB3TXdyfrmPj8jFOMmcTH5I0sVKMQvHVD
         5j4A==
X-Forwarded-Encrypted: i=1; AJvYcCXDEVht3TjAypZZ3D1nhYL3KImAKQ/h62ZlPMHcD5kuc0BzeyEh+qRYntLfj6TqJOx3jShXkbaefwXGaed++cTJgiHrULvGPHQICZeS
X-Gm-Message-State: AOJu0YydJKVce8qznuASogUjo0RoJbVVm/J4JEj0mIT8EgSBwNtGIgKk
	CjYv+OQXhETOS19vJnxZEIBMZe2dPtYxUvDjbQ5XW/lqTxJOZxyNKRGVVN02zdY=
X-Google-Smtp-Source: AGHT+IGPqJXCIDxoj6NAZw3IbNqMNkT4Uv70uq1zZQXA3Olp0L8WIOCIUWsqcEistgn+Tb18fIngGA==
X-Received: by 2002:adf:e603:0:b0:33e:c03e:62 with SMTP id p3-20020adfe603000000b0033ec03e0062mr236757wrm.40.1713905571224;
        Tue, 23 Apr 2024 13:52:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b00a51d88e6164sm7443632ejb.203.2024.04.23.13.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:52:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 21:52:48 +0100
Subject: [PATCH 1/2] arm64: dts: exynos: gs101: add USB & USB-phy nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-usb-dts-gs101-v1-1-3421b0371298@linaro.org>
References: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
In-Reply-To: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Add the USB 3.1 Dual Role Device (DRD) controller and USB-PHY nodes for
Google Tensor GS101.

The USB 3.1 DRD controller has the following features:
* compliant with both USB device 3.1 and USB device 2.0 standards
* compliant with USB host 3.1 and USB host 2.0 standards
* supports USB device 3.1 and USB device 2.0 interfaces
* supports USB host 3.1 and USB host 2.0 interfaces
* full-speed (12 Mbps) and high-speed (480 Mbps) modes with USB device
  2.0 interface
* super-speed (5 Gbps) mode with USB device 3.1 Gen1 interface
* super-speed plus (10 Gbps) mode with USB device 3.1 Gen2 interface
* single USB port which can be be used for USB 3.1 or USB 2.0
* on-chip USB PHY transceiver
* DWC3 compatible
* supports up to 16 bi-directional endpoints
* compliant with xHCI 1.1 specification

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index eddb6b326fde..b4e48ab890a6 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1247,6 +1247,47 @@ spi_13: spi@10d60000 {
 			};
 		};
 
+		usbdrd31_phy: phy@11100000 {
+			compatible = "google,gs101-usb31drd-phy";
+			reg = <0x11100000 0x0100>,
+			      <0x110f0000 0x0800>,
+			      <0x110e0000 0x2800>;
+			reg-names = "phy", "pcs", "pma";
+			clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_ACLK_PHYCTRL>,
+				 <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USB20_PHY_REFCLK_26>,
+				 <&cmu_hsi0 CLK_GOUT_HSI0_UASC_HSI0_CTRL_ACLK>,
+				 <&cmu_hsi0 CLK_GOUT_HSI0_UASC_HSI0_CTRL_PCLK>,
+				 <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USBDPPHY_SCL_APB_PCLK>;
+			clock-names = "phy", "ref", "ctrl_aclk", "ctrl_pclk", "scl_pclk";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		usbdrd31: usb@11110000 {
+			compatible = "google,gs101-dwusb3";
+			clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_BUS_CLK_EARLY>,
+				<&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_SUSPEND_CLK_26>,
+				<&cmu_hsi0 CLK_GOUT_HSI0_UASC_HSI0_LINK_ACLK>,
+				<&cmu_hsi0 CLK_GOUT_HSI0_UASC_HSI0_LINK_PCLK>;
+			clock-names = "bus_early", "susp_clk", "link_aclk", "link_pclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x11110000 0x10000>;
+			status = "disabled";
+
+			usbdrd31_dwc3: usb@0 {
+				compatible = "snps,dwc3";
+				clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_REF_CLK_40>;
+				clock-names = "ref";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
+				phys = <&usbdrd31_phy 0>, <&usbdrd31_phy 1>;
+				phy-names = "usb2-phy", "usb3-phy";
+				status = "disabled";
+			};
+		};
+
 		pinctrl_hsi1: pinctrl@11840000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x11840000 0x00001000>;

-- 
2.44.0.769.g3c40516874-goog


