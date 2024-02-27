Return-Path: <linux-kernel+bounces-84090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91086A21D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C810D28A3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858C157E9B;
	Tue, 27 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuTYcOcI"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669D15697D;
	Tue, 27 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071510; cv=none; b=itjofuIakmxHXol0XTsEiKrq7C4pxjh6N5LtaTfmuJQ6fAY7ML9FijGgyDWPuWBbxojUgAxMzWu+Fflxk+FO55MewsM71A7i1mKX1S3zBBwW6OpJ3YPxm/LT2pni7mRIG0YBPqp2zoerZaMo5cJVXzf0ug/oZIDp39z1iH8A8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071510; c=relaxed/simple;
	bh=ELvNOGdyWujRqFlgFnplgvQfFBySmgvbj61MCodDqJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLgS8kVckI9oayUMk4n09VouHUOvzsXS83+T6EyabEeh6TY1yLTvUv2txLpP5NU2nAIsFEDxd1isZWGjBIx+y/VTv+ALa0Fneg/0frLoM0mwyvzToazAlRz3qyiFmXn8PwRincm5ndD73AGnqbw7pHwPdPOnJMraLM74MDZoHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuTYcOcI; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a03f90d1c1so2247022eaf.1;
        Tue, 27 Feb 2024 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071508; x=1709676308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFej3XRK1im9Jtb1YXeIJeL5LA98qLbzr4AabBMlz7o=;
        b=LuTYcOcIuKTb6gjz2QO6WnX2D+rGnmN40jOYyKsQobJf4Zzdk/8SZquUx8LybKk11E
         qnpAB7X1y60cxUvA4LeWuEqch4CaY67cP20tT9OLlIYNWDR2HEvRXY89uWpBrqTAS4W6
         bgx0AHh2s6y9Ydpv9sdU+z+wGI4K3b+8rP/hPY+W0rN8VxrsjCbwVbaAuBzHbN6MhGIx
         7VDLIIo74OcOGLiTDQVSkFs5H8cvLuh8ybLISscM5gXQqXXj35GXDAGMLMxUHR94d2nV
         zwX9ctoOW5F8xkOSH/0eYQJlUZJOE8mn9Kwmwr/XHCop+vkeaTwUL/spNSqoQVCfBeZi
         7PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071508; x=1709676308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFej3XRK1im9Jtb1YXeIJeL5LA98qLbzr4AabBMlz7o=;
        b=TbxpZS1TBjQebABnBzsvmFn5yg8IP5SVIHUeto1f7evkXpAATGHZfwgaERTkOBJu7s
         wEeuGC1oqYrVs4sLWFdrJWoUzhbXlWiD4vUcjs06rnStFHIJ2Nk8874fi1pbU2Rrprb3
         FWkcqTicwpKPyfoLnP9eZplxc5p1R97L5lXncS7Y0MyTipawI1WTZi4ajQqcka+Xb6OH
         Y9juBH1/OQS3Qmhs3C4ChM2L7+7TENqQFV95msiTqgbp+A11q8FnJzR6pIJxvg6UjPb/
         a2kbruB+lKmoX6na5UoAvl2YcuXU3Ph51DNieV8VfLhPH8/tQa8lMEBADIadCN0PyxMA
         Ei1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+yRxaMM0w0+byBVNRG3o72xLloOfQTNbBvM1O7FgGmCRE84+V80KzLnymW8lb2CJh0R1fZJsxYWsCfJk+qj9ej5rU74FalCBZbDdRHAl8kMoSTqiNZ3XRcglQxxhCSMtNNiezS3u1bw==
X-Gm-Message-State: AOJu0YzNN//oenhYk4dw0wMU9okRK596By/jircxg0ZWAhj7pzI1hGcB
	gtCIpSf7W07g6gbQHFadHJQfemFVXUVRzlS6uavMVsP7/khcv6Oy
X-Google-Smtp-Source: AGHT+IGWgaFRlZ2IfQsw+GCY/j+lRL8LaS2tBzQxUKTZJT76SVV2NR6kEFyuRlrSS1jgmD6sVOd+Rw==
X-Received: by 2002:a05:6358:94a2:b0:17b:521f:b2ae with SMTP id i34-20020a05635894a200b0017b521fb2aemr15918125rwb.14.1709071508117;
        Tue, 27 Feb 2024 14:05:08 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9ee3:b2ab:6ca:180d])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce14c000000b0068fc55bcf6asm4569556qvl.119.2024.02.27.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:05:07 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 4/6] arm64: dts: imx8mp: add HDMI irqsteer
Date: Tue, 27 Feb 2024 16:04:38 -0600
Message-ID: <20240227220444.77566-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227220444.77566-1-aford173@gmail.com>
References: <20240227220444.77566-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

The HDMI irqsteer is a secondary interrupt controller within the HDMI
subsystem that maps all HDMI peripheral IRQs into a single upstream
IRQ line.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V6:  No Change

V5:  Increase size to 4KB to match the ref manual

V2:  Add my (Adam) s-o-b and re-order position under AIPS4
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9bcb6641de7..18bfa7d9aa7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1927,6 +1927,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "hdcp", "hrv";
 				#power-domain-cells = <1>;
 			};
+
+			irqsteer_hdmi: interrupt-controller@32fc2000 {
+				compatible = "fsl,imx-irqsteer";
+				reg = <0x32fc2000 0x1000>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				fsl,channel = <1>;
+				fsl,num-irqs = <64>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>;
+				clock-names = "ipg";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
+			};
 		};
 
 		pcie: pcie@33800000 {
-- 
2.43.0


