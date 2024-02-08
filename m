Return-Path: <linux-kernel+bounces-58316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B534E84E48E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C771C23BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349D07CF3E;
	Thu,  8 Feb 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l08614JF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A347CF3A;
	Thu,  8 Feb 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407953; cv=none; b=HtMcajswqOX5arCpoD12NVkNwVVNFhsNJkuwG3z1RzV+CSxUJ5LsjVSiE2OC6GRwJZhHqwlARpWJVCvXSTBMSsCHQT32dQeUee0DCNYGCT8iDTsDCJeZGCz9dRo9BXD3Sb9Wy6NrSbim36whMluWCwy4atNfTajvlCmHqNARqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407953; c=relaxed/simple;
	bh=92/zBLiDqGl0yNbZXLAAVGbATRsISNLm+Yc9FNwOrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ey/PKDxjvvZRJK4322m/H8gcZEmy3EysTl/yeEITuPn3wh+63VAo0M2TcqXLwibkCsVaxlFZY+sJ3HlPULm5drZJurvH9mslPxe/Dj6pntAk6B77zRh7U8Y4bICaaYzAjzEyWFCwNL5WEXtj6wjwlA3ERve3xMBNbWdRyjWmpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l08614JF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d746856d85so15644585ad.0;
        Thu, 08 Feb 2024 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707407951; x=1708012751; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UkasknRx/MidvQOJkmoofU2A+zo1MZfchNN3vbBj50=;
        b=l08614JFOWFv9Uhz3SCYVdzVpSY87tnNGhQTwUqosj3lpT8kV4zshDaVGYcqhb/w+x
         pY/9gEUBgq3RwB04ndmIznrWcIujnyhxm6vjPJ6FRVg1xj5xY048+zB4otG67Q2jcppo
         Z+0ekM07xrPAJqn362N4ZrBe4yBAMqRRk/IwYhyhOa8EPae3FUucE2ORFsTkeNHWeuX1
         OyYTH4wG/+I/xIhMA17hYy+MFP17k+qymNM+9+Sirob1j0Jf5SdrKBeynF+PShef64Ta
         POZX5C0EyHZfi6nHZTOIR8VHRO1imPJRs+n5u7SO1Q6fVVfjj9ZOsFiKY7W3Cc0VKyGP
         GVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407951; x=1708012751;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UkasknRx/MidvQOJkmoofU2A+zo1MZfchNN3vbBj50=;
        b=ReQTFCIwO8xTyuQ5HmqVz+6jU6MK/+S4h9dAojODBJCJaIjJurLXCcM5+YjR9zU9qh
         nDVVUN3OvGyAkYd7FHoF52UAXPDNedO8JJ4UL4TvSLy62DiJRz2VVp0L+zi5DATHtk9p
         kwVr34DYxNLuHz43A8ojuYKviIhOloeUKGdnJ3JnPrXfbdsnCrS9fsSqlB3PNkWapNpU
         v/LLmHXjL6veO5qxVr70nZCImohsLf5G+9QiAKOnJnZCG1kfz74lgB8aAthMTwJM4scH
         7aMG/LBNcTV4FCgETAfjPUVmViK9X4MOxGaWF0ZUHDHvo93d16aOu7foMtLO1sklkhlq
         hBOA==
X-Gm-Message-State: AOJu0YxxLyUWdnimvSfKgtzBKXQRGJlQMy3KIuve70MySbzhTHSSWum4
	V5Z3p1FoVClt8jmToHWedD9kwVyX/4klv/yZXBil05knbm4ghn7V6vjIOgB9nRM=
X-Google-Smtp-Source: AGHT+IGm26flaODwILEs377DOWF7gf2yBRM1VJeNDFyz4e42ANl9iL6maaca5aRO6j3uV08HiDyVmA==
X-Received: by 2002:a17:902:d2c4:b0:1d9:5ef3:e5ea with SMTP id n4-20020a170902d2c400b001d95ef3e5eamr10470840plc.50.1707407951209;
        Thu, 08 Feb 2024 07:59:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnkx8QcLgJcxAcwfW2AqPOmi73QJUYw5evFy3JQJ74xZdb+LCPzzZK71yjmgughBTxzUSp2jxR2WIMgGbu9SQpP2Jk9ZcJ4Wi7qRuAXsuGD+3Kn/kTsD3jtqkyHJ7JAWjSDiJExNpxIoFCCWCZMoqB7dRHc+YJkkVN71T5Y516TP8qG9W+AcFPQjJg5mIQ/bRzyBwI2AYaSj36LAoYqAa46YjX7Ee6ALxPk5za++3Vs1RhGsKXUGUAvWagduniikxVJ45ssQ//0Q4fmZtYy7d3+RBY3Bz/dX3+BQbbvSIGvVhKb2xTebZjyG2yLxrQd2cdDEvUwD+bRcEotVqdnydzKOuDJZWDRQ==
Received: from hdebian ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id jv11-20020a170903058b00b001d9a146907dsm3557638plb.11.2024.02.08.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:59:10 -0800 (PST)
Date: Thu, 8 Feb 2024 12:58:02 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marco Felsch <m.felsch@pengutronix.de>, 
	Roland Hieber <rhi@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: MXSFB error: -ENODEV: Cannot connect bridge
Message-ID: <34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

while doing some tests with kernel v6.8-rc3 and Colibri iMX7D, we
noticed the following error:

[    0.432547] mxsfb 30730000.lcdif: error -ENODEV: Cannot connect bridge

This was introduced by commit edbbae7fba495284f72f05768696572691231558
("ARM: dts: imx7: add MIPI-DSI support"). This patch is routing the
lcdif to the mipi_dsi_in_lcdif endpoint, however we do not have the DSI
pins available in our edge connector. Instead, we use the parallel RGB
LCD interface directly with, as example, an external LVDS transmitter:

&lcdif {
..
	status = "disabled";

	port {
		lcdif_out: endpoint {
			remote-endpoint = <&lcd_panel_in>;
		};
	};
};

By applying the following patch, the issue is gone and the LVDS works
again:

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index ebf7befcc11e..9c81c6baa2d3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -834,16 +834,6 @@ lcdif: lcdif@30730000 {
 					<&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>;
 				clock-names = "pix", "axi";
 				status = "disabled";
-
-				port {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					lcdif_out_mipi_dsi: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&mipi_dsi_in_lcdif>;
-					};
-				};
 			};
 
 			mipi_csi: mipi-csi@30750000 {
@@ -895,22 +885,6 @@ mipi_dsi: dsi@30760000 {
 				samsung,esc-clock-frequency = <20000000>;
 				samsung,pll-clock-frequency = <24000000>;
 				status = "disabled";
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						mipi_dsi_in_lcdif: endpoint@0 {
-							reg = <0>;
-							remote-endpoint = <&lcdif_out_mipi_dsi>;
-						};
-					};
-				};
 			};
 		};

I would like to know your opinion about this patch before sending it,
does it makes sense for you? I understand that routing to endpoint
should be done in the SoM device tree, so we are free to rout other
endpoint without issues.

Regards,
Hiago.

