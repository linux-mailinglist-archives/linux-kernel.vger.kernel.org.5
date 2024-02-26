Return-Path: <linux-kernel+bounces-82451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF68684BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BF91F239FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D6137C23;
	Mon, 26 Feb 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJHHDtMD"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5913666A;
	Mon, 26 Feb 2024 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991150; cv=none; b=AjH8iERELCkwHlcyMYLKTZvYeJ6UWSxCUnoX3KEWos67X2tF3qyvE0Ow+PPrZ0cvmX+R/07WekSe0N3fYOBx9LN2NiKbHtcxG7ytsSu8QE0aKfdZjISIiYRB8+9U8fRbiAe1VDbO2697h6cDXsNi86MYerlHmH9+THqFMkv+UTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991150; c=relaxed/simple;
	bh=PPE9aCDp/+ayfS9rSy6PpNNiR+5t57T1PNn5XAsD9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTAMWvttwaDXhaa45SGqB5QJiminmKQlfIUrwY7nvrFTLthlD2rFazpqe6xLtZBbBNofzKWwiTiUeyZATYjghy/84uATkPalfATxdKsc8sL0sFTwwYB3si4nZecmpuU1j75IuDG72rzIXkh+S7Of+NJYo7dXSI1Lj/pzB31qwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJHHDtMD; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c785dda899so174442539f.2;
        Mon, 26 Feb 2024 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991148; x=1709595948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+UTK+fYQopdu7vZsorElcS4oD1Blt+73sP9Ns4GZME=;
        b=XJHHDtMD+NvsJDVDvmpIO8pvFadmc5dyGfObVS1IRpu4mPU5XEBzuAKj0MRfvjmIoT
         otHpJqKOZ+WPmFQsCsXT5UaRJ4SMiXDtuk8axS+GBQp8tbrjem0KocmoTKkzSX2muF6n
         mcwSVCIj6wun1ji5KsoJYCLOhvGKs3AtcaCJYDlhCtkuRiFD8Sc8XSzCuR0gl2YlnUH9
         1z1cdnDCsB1t4FdtqHi2gzdex71bVlOgB9YFXnOiT/ZiN4uW2CkJwU7lqw/bUcAz3eX5
         SIHnB+1HLESEq+21ql8VoVAqwUZlhm9vPBUe3YeTI07vV6UYboretI6RPnYaqCSJ3gSc
         FtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991148; x=1709595948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+UTK+fYQopdu7vZsorElcS4oD1Blt+73sP9Ns4GZME=;
        b=VK7bxYuvdxFsxisgw66cPU8GWppnU123v0vPd6JxvMGUTupcxpm8+GflNOei9q58R9
         YDqPHlUfHO8AXZxAsjMG52WOBpN921lWmT60WY+NbqISCUHQUi2f35MxoYIdmNyxAYvV
         wWPgEnk/17mcqV1hB2aSSiBILcMtqFmMYFB3aOiHsIJUpAj974jYo8NOIITpZ5vyCrBy
         qWjzivwKOqNSS74EcS3R4u1g/hL2pHodfEsJ5Rga0KsOyBTZ24mIC/i8tZE9WbU89ypI
         qiiYNRsreMePt7bP6NtJt5cf9Iihz3Hi1C0axFBGCKSLHnvmMaOMBltCx8PVm/ZDH7kF
         SQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2bc4GZS1A3skyDgM4M0B4a9/c9LAoeXLWvxiG74Jl5sWzIIs395hP5pVm+f2Ns7Fb3C4JpmimOWzT3nL54QWZ1nBeggqDP7ij8i7Kg+cBXi7dN0muXaW7eKHdd7td7Jjwn6vMcHXSNQ==
X-Gm-Message-State: AOJu0YykkB+Ms/SjWzPseZUv1o4rW8cKYWWkT6DtqK3g9DBAWv935xZb
	+JexQT/nOS5cXyixPBa8DfZ6sqcQA5Nv6lUAF04is8uAQHMS+C/K
X-Google-Smtp-Source: AGHT+IH4PaNCs1oHhwDvHwYDXOUqRvUfkRTRMpFd8hzKTc/5GYjGQxmXNKxJUe7EDuGGjgMMUDElWw==
X-Received: by 2002:a6b:ec08:0:b0:7c7:968b:25b5 with SMTP id c8-20020a6bec08000000b007c7968b25b5mr9757511ioh.3.1708991147676;
        Mon, 26 Feb 2024 15:45:47 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9c95:d061:819a:2ab2])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b004741cf1e95esm1545317jae.11.2024.02.26.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:45:47 -0800 (PST)
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
Subject: [PATCH V6 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Date: Mon, 26 Feb 2024 17:45:16 -0600
Message-ID: <20240226234532.80114-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226234532.80114-1-aford173@gmail.com>
References: <20240226234532.80114-1-aford173@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 95 +++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 18bfa7d9aa7f..637b0265b0f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1940,6 +1940,101 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
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


