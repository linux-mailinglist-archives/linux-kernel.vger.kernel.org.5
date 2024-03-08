Return-Path: <linux-kernel+bounces-97373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5D8769A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B5628327D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8804CDE0;
	Fri,  8 Mar 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h3E/C7Di"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C05288D7;
	Fri,  8 Mar 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918311; cv=none; b=aKQVhljKpZUbc4G7zVNC8E8/ookUmHf+xGUWLYaGjxjE1u5U/BQ6nYL299qcjX4sUwMN6+H1u0+HFRK3sLEAjrbR/5eDLIUt2+wNASyfQL923kSIges00VqL+oAFix4ZFtMYU/hKw+gBFp3sKP4j1S2I4vF4VOnvHe0jYMSqaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918311; c=relaxed/simple;
	bh=vuFml2Tbieyo6tIWPbphQoCJOz5E27f346lkQPXpqDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtnYlOLtrLuPOL9ioUQ4IXr8YXSakUqklXNhBKvplea1dK6U/NY2QMac1lX6XWcFavlpNNFDRTvngAg1QWU0JNPAx+X2J2uFkD9Lv7LO2ddaaOZWjGv0lppGwn2LphEN10ceD3bKkdMzGK7RFw2fkb+iBE81xGdAaYWG+92QuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h3E/C7Di; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9507CC000F;
	Fri,  8 Mar 2024 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ysm4DbzpqSZj84XzesirmTyGQsD5pPgqx8ZXriQXW0=;
	b=h3E/C7DiZv3ayScQSpUCUMbOsEaJi0tFj7x8KaIcN90BYdd9nxpSxiRXZmntS4LSNK4PHq
	q3SusbJu06VlHM+zNfQ2Z8lAKnPxvqQ4gpeMCU+9e8gP6uU97BSZAXs6laQbbUJm9ykjD5
	2e9EYHeCVmfgsWuMQEMuZ+f+FML6HXXAZ0UO33XGtocDMRGDpn/6hKsLkjK4Lw7Ywcqtgh
	IByWJ3sm6vgvw6O7PdsPE6ZZc8ZkYLBbcZDnIxEgEyWDIqvl2e4Owl/x252G9ihMkFLKuj
	sGOUCcC3QLuni2IN3IAg1MVSMuFAdkrQUG90ZMvhdDLUWs/gFJ2LfIMJyLTRzQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:25 +0100
Subject: [PATCH 10/11] MIPS: mobileye: eyeq5: Add SPI-NOR controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-10-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add Cadence Quad SPI controller node to EyeQ5 SoC devicetree.
Octal is supported.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 8d4f65ec912d..1543c2b9bcb6 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -158,6 +158,21 @@ timer {
 				clocks = <&core0_clk>;
 			};
 		};
+
+		ospi: spi@2100000 {
+			compatible = "mobileye,eyeq5-ospi", "cdns,qspi-nor";
+			reg = <0 0x2100000 0x0 0x1000>,
+			      <0 0x10000000 0x0 0x8000000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clocks EQ5C_DIV_OSPI>;
+			assigned-clocks = <&clocks EQ5C_DIV_OSPI>;
+			assigned-clock-rates = <167000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x00000000>;
+		};
 	};
 };
 

-- 
2.44.0


