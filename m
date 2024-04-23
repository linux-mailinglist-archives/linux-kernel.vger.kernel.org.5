Return-Path: <linux-kernel+bounces-154831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7128AE1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B89282D73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8060877;
	Tue, 23 Apr 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YuTbLg8u"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8F5FDB5;
	Tue, 23 Apr 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866515; cv=none; b=cIoBS3Umg/UdMcQj0xJXiETGaOOIG7HAvj9vV9oHIvhhvmmKKp59+zTiYZx9rRXvzbxnmHD1KGkwKuuC9iiAq3vce7PrZVXFtn+dj1imVF26mW6i6WJUdbfwtphGOtxjHe3Qjfusez+iiMdOkyp6uapi73gjr9pehabH8coM5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866515; c=relaxed/simple;
	bh=vuFml2Tbieyo6tIWPbphQoCJOz5E27f346lkQPXpqDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBMU6/oh1j1N43IeK6o7gBvgmsrJjGxPxQCGcpMIk5KCDQC/puhcoomy/fP+Iy1O/u9KYNFb7HcBQOAVAn65/Gi6XekS3Uo6cQVU/69ckOkFFBWRZrxXQuyd/iW+bolyr6/7msydM2/dGKi3QRKnmQXlg6YhNMynl+msM3yvMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YuTbLg8u; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4543D1C000D;
	Tue, 23 Apr 2024 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ysm4DbzpqSZj84XzesirmTyGQsD5pPgqx8ZXriQXW0=;
	b=YuTbLg8utCHFpsX8uzPncIZO3UoXEJ6hPAhIx9QypocJwztMd4Wvkh1lzBBdIXXLUD797z
	QLoZNrmiL89sYRd5BmaTrT3fsZI0Sx+SIAsZ9CADbFzQQDmnRFW64w7KO+8lLz8arDqtjq
	aH62QIia9RLUZPjd5i7f5IFxnf/wRq1e4cxCxKGJDzVbLfclHwxCcO1FQlfopij/JxNmx6
	6Z0lRATv5nZ/fkrTUutfwekh4b2vbxP0vEh/NAXNs34SVS9PRfEm0udQX6i06jUalbFzCv
	geM/2HajDCXmsUMqFDcxv/WjSo2IyM7TM9dhCwnMqQwKIOrWBdflhpQviRE1dA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Apr 2024 12:01:44 +0200
Subject: [PATCH v4 5/6] MIPS: mobileye: eyeq5: Add SPI-NOR controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-cdns-qspi-mbly-v4-5-3d2a7b535ad0@bootlin.com>
References: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
In-Reply-To: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
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


