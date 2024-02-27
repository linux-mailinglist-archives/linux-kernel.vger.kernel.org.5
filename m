Return-Path: <linux-kernel+bounces-84091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF386A24C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA20B2D6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7261586D8;
	Tue, 27 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6wzE7ip"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF91586C0;
	Tue, 27 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071513; cv=none; b=cTbHb9vUX8J1YN6tRw9n1W+BHlQft5wyX/oVycwIouAAW0u8vJQTs176CtTSCbd8kud0n9ZTCKNd4RMW4+dU+NPYVZtvXj3kYyOu9eyJx0YwN3FioraElP9cis8PHFSSBt0lFJz8UdgEB7Q1+i5BvLYh6sCuNqoj+BklwTOXBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071513; c=relaxed/simple;
	bh=LtJ2OGKs7LLLP+uB2gm8Tln6tjfNuxNbCBBC32JvuuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7HRt++wgoeSqwwjStvpf30V2zItQDXcRQu0nrMlLTYQrmCFE/ATwhYdoXio3BQMS9swVGUwIJibzVlr9qhm9UJy2Wz8I8G6Mru03Vn/yy/wlZPJAyHNXnt2VHL2cQ106UvFuLmrlCr8XQg+4RORvOnMVDJte6+u12TKITg7uAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6wzE7ip; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787b4d1393aso311568485a.0;
        Tue, 27 Feb 2024 14:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071510; x=1709676310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJzAJwTasiu7hDw+tfGL3rBgM8LrL2gpliyFRMRT1lo=;
        b=U6wzE7ip4l3f3GbObiO5J1/cvZqCQfkPi85FMYqjNBegk3dqyZqWAg3UbOXb9MqVsh
         PJ2GGiw2fXHDornp/RqlpssVksW/mBCoK2p1vGiM/Mw6RzZmpkRsT4SmGkMdcH3OUXeV
         Qb7X4zRgDT+oxQbgqLNqPCmwXXCSZLC3XQjx51oL8pxfkV22R989ZcnFMiSL3lUt+Sad
         WsPmXvAycxB5KAPVguQjyu5d8yWOuVgWcoYZZdTO9pxnBGkYnEUj0MsbjdWUZ1TvIogH
         Uk+yjZFDOvKKhMk66Y5kdZxarAd7PbHAs+P8HSjrEKJYr52QDQjm/tyOk9kOJRpCjqLp
         ZmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071510; x=1709676310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJzAJwTasiu7hDw+tfGL3rBgM8LrL2gpliyFRMRT1lo=;
        b=kizWQ0sbu4D+IF7a0VqJwyGgu100RanPlAwHdBtzq2CqCubZIYvbXCsuTY2rRrXe92
         f9pdJT8k+wl9gXTeaolNADG13sMBoQ+8/scyEBC0H1r+6lv9OtAmGsBuptZj9A+T2l+1
         4M/gk0TBVEAVvK4RPncgN6ka//gZv/Kwq0gtn5UrnU/nxGHVK6BGLdNuWZflOUSVFdOm
         j6xE/WZxCxfzZgcDOA0R0MD26Ff6LSOqsCGA1Yc4RIMUGGVQQExVQ4rOOOTSW+SshpTt
         EalRys7MUUlq9cmRbPggbNsaJEadTmlPXLT/BmhN7UuB1P/FWj9QMw9UZT6ynDqwLYWK
         pZtA==
X-Forwarded-Encrypted: i=1; AJvYcCVlMPUinZGRgT5+J91YSA6Unm+yqLArQgx0+3qqs3nDpdZ2F+k8bry2KVo3Y1UobLOIdomBUaLlJ+atkCRQWNWE6vrxkh/9z3uOI5WZpHT+Jv0mlzJNbr9aw8OvpN2zSd/VEPfJ4hQofg==
X-Gm-Message-State: AOJu0YyUa+ypfWecYCcIdb6MFrxZjGdJYdl1XJyWSKwPDA3SYT40Hrxd
	O8Ukx8y2YnsRl76zC5S+xCZyAXoj0diT2IKGmZe66+UTtDY3W/QV
X-Google-Smtp-Source: AGHT+IGThGbZu2ZzIC/n4MZYA5OnZJb7hsEPXN8KiMr5hmglfpCIMmZO1Irlp/eAHem49FGv4ww+5A==
X-Received: by 2002:a0c:e2c1:0:b0:68f:3126:a395 with SMTP id t1-20020a0ce2c1000000b0068f3126a395mr3046408qvl.31.1709071510382;
        Tue, 27 Feb 2024 14:05:10 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9ee3:b2ab:6ca:180d])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce14c000000b0068fc55bcf6asm4569556qvl.119.2024.02.27.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:05:10 -0800 (PST)
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
Subject: [PATCH V7 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Date: Tue, 27 Feb 2024 16:04:39 -0600
Message-ID: <20240227220444.77566-6-aford173@gmail.com>
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

This adds the DT nodes for all the peripherals that make up the
HDMI display pipeline.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V7:  Make PVI node disabled by default to avoid EPROBE_DEFER

V6:  Make LCDIF3 disabled by default

V5:  No change

V3:  Re-ordered the HDMI parts to properly come after irqstree_hdmi
     inside AIPS4.  Change size of LCDIF3 and PVI to match TRM sizes
     of 4KB.

V2:  I took this from Lucas' original submission with the following:
     Removed extra clock from HDMI-TX since it is now part of the
     power domain
     Added interrupt-parent to PVI
     Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
     Added ports to HDMI-tx
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 96 +++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 18bfa7d9aa7f..e3510fef6030 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1940,6 +1940,102 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
 				clock-names = "ipg";
 				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
 			};
+
+			hdmi_pvi: display-bridge@32fc4000 {
+				compatible = "fsl,imx8mp-hdmi-pvi";
+				reg = <0x32fc4000 0x1000>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <12>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						pvi_from_lcdif3: endpoint {
+							remote-endpoint = <&lcdif3_to_pvi>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						pvi_to_hdmi_tx: endpoint {
+							remote-endpoint = <&hdmi_tx_from_pvi>;
+						};
+					};
+				};
+			};
+
+			lcdif3: display-controller@32fc6000 {
+				compatible = "fsl,imx8mp-lcdif";
+				reg = <0x32fc6000 0x1000>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <8>;
+				clocks = <&hdmi_tx_phy>,
+					 <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>;
+				clock-names = "pix", "axi", "disp_axi";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_LCDIF>;
+				status = "disabled";
+
+				port {
+					lcdif3_to_pvi: endpoint {
+						remote-endpoint = <&pvi_from_lcdif3>;
+					};
+				};
+			};
+
+			hdmi_tx: hdmi@32fd8000 {
+				compatible = "fsl,imx8mp-hdmi-tx";
+				reg = <0x32fd8000 0x7eff>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <0>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_32K>,
+					 <&hdmi_tx_phy>;
+				clock-names = "iahb", "isfr", "cec", "pix";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_REF_266M>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
+				reg-io-width = <1>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						hdmi_tx_from_pvi: endpoint {
+							remote-endpoint = <&pvi_to_hdmi_tx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						/* Point endpoint to the HDMI connector */
+					};
+				};
+			};
+
+			hdmi_tx_phy: phy@32fdff00 {
+				compatible = "fsl,imx8mp-hdmi-phy";
+				reg = <0x32fdff00 0x100>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_24M>;
+				clock-names = "apb", "ref";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_24M>;
+				assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		pcie: pcie@33800000 {
-- 
2.43.0


