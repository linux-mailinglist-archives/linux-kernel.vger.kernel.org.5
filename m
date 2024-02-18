Return-Path: <linux-kernel+bounces-70190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7385948E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31561C21609
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF012E4C;
	Sun, 18 Feb 2024 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEW6lEOW"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7DF505;
	Sun, 18 Feb 2024 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229834; cv=none; b=qvIHKrXQc8wFUicby/v37Rumh4lcyrPEqolzRspXoagKWWHmBRlLPU3M4/gA5zzlOEfaHclPwIEHU4Fgj7LTEko4kxHvD/E/WF3uJ0fvXjiyujmbvhcO8OdC6CNy0M15Yyn6lgJsnQO8hCyGScSj9vTzfxEJBRY40BV9dik43jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229834; c=relaxed/simple;
	bh=aWcxpDeRXaHE7NPPmTD5QNYPTYjPv6SbnKlGsD1TNSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/em30cUG0mYILLvQNSvZn5QIBiwcpzMAXJ2KDOfC2UH7pN91QKoIWy7T1IssZNcCTiJgkCjDz/c/EmNfwaGxnZfallxys4NigmhbZf3Yy2/sl0+4skY3dDpuIAkIPgHLKBmmLEOLJazQ2Ok2mX42nxKZ2oi1GdZcIakXhClFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEW6lEOW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f51ba7043so5271516d6.3;
        Sat, 17 Feb 2024 20:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708229832; x=1708834632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/aeBIdmV1XrY4y6jgnhEUqIAA87/lYvvzwVW9/z3wo=;
        b=DEW6lEOWS8OazR0gOjb1PE5367i1/HmdDSGOKV72zQ0KW7ods+PwaFwJQfkPYtSVIO
         0eQExKynQrdo+H/ILofyCL53isr5z1OMo2rV6GiyRo85ftnqQcGZv3DFK7aWx4TtT5Am
         3t9Talg4IImosX/f5wZyOgM9JmC4Tt9yiBGMK89tsiBQWNB9YZefBMldU0IEIZ/D8qT1
         1UlipqyCz+C5nn9vK1wXD3D0HngxF5MAAecnG0Yp0kj5K+kTUKe5TNql9isP69LblE2s
         TPchg1YwEB/c/Wtq4vPKenl1CJCn3St3EEN6/0or+UyF8T4ntE/2zM4xnRAsgQQ/vgSE
         UmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708229832; x=1708834632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/aeBIdmV1XrY4y6jgnhEUqIAA87/lYvvzwVW9/z3wo=;
        b=E3DmZ6wUvtakV1tMMzVWQlek0Vvhpiv9INsmIouOLesK5TZ59zUGIIFen9JoOBqry+
         WXFFoUgzkhrFNfhn42wWVVW0V43YGWN77bmDIDOXp7evvbP1ekGTNfSCQuvicC5xF6qF
         eWFL58ZrfN1+TrM3R8FvJi8jmToxxdgLF6a8f1ga96YpiGaxt8hUMTtLTWBmT3ROd+ZL
         Op+ZQ421tD8PcYm4H8PRt0lKU2zhN68A7dl4GlfaKawgl9Krj0AUdbsU+dK6Gt/m5E5/
         n+udaEKr8fRZX2+zQw5c0NxzSv0xh5H9Tj4FHZ2d9+1WljrA8v7evetp7B2cOoGu8Ri9
         jmgA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7mPuj8PYCBXp0ox8c7WyP1D8+aIGEoLgOb4kWv2K9JXG9Xcuk1BUEXzR/5ZtSJscbVau/zxHh3cXVXkJTmqZE5y+MqhvEK/EWoR7pKNmvtfqflw9YUtQOxonXDVufePDBr4q1XfndQ==
X-Gm-Message-State: AOJu0Yz9sDSJFYBh+BOxaHlDLOvQXvzZJoMtndk2tRVDiNpj092f7HjF
	JU4c2Bis6xFIxzmmsVIp8MPYUhiP0/9aOuuHxHh4b5AEIbCIJIVS
X-Google-Smtp-Source: AGHT+IE+l1O/kUpQQgLps3SgnxzH9E9IVKxRsFX38onbawk5mnGPrRddcJb2C6Zr5PV5EEzAfT4lAQ==
X-Received: by 2002:a0c:8b1a:0:b0:68f:5901:c76a with SMTP id q26-20020a0c8b1a000000b0068f5901c76amr1396486qva.0.1708229831817;
        Sat, 17 Feb 2024 20:17:11 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:dde9:2f2d:61e4:7364])
        by smtp.gmail.com with ESMTPSA id or31-20020a056214469f00b0068eeebc4656sm1713621qvb.139.2024.02.17.20.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:17:11 -0800 (PST)
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
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Date: Sat, 17 Feb 2024 22:16:43 -0600
Message-ID: <20240218041649.1209173-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218041649.1209173-1-aford173@gmail.com>
References: <20240218041649.1209173-1-aford173@gmail.com>
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
---
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
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 94 +++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cbb15ded4a74..433ea4ae6a16 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1940,6 +1940,100 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
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


