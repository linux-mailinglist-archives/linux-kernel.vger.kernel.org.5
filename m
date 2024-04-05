Return-Path: <linux-kernel+bounces-133213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1989A09E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A35E28768E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327716F84A;
	Fri,  5 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i9FHPIFB"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB4171665;
	Fri,  5 Apr 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329346; cv=none; b=Eb1IVYMOA10zuyoB1E9DWK5Gw8meNXKg6TO/JuvvzZCclq47N5IXW4y1TqUSVK530qVX9Xh2rzVBBNMDGbMkTQQnUcajPmDObGMrwoXWmQ6e5Ub6KzGzXLlAPm2hVOkf4G3lAxxtabSOXaDqUSd1FIv+nDlrHgDpd8Mr3eASun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329346; c=relaxed/simple;
	bh=vuFml2Tbieyo6tIWPbphQoCJOz5E27f346lkQPXpqDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItGpp8SNbEDxowHN9H/PvFNYnNy1yf60dl9zlL200205TS9571qI9Walng5i02+0xxer8c4A7TLH6mk4lGEhws1XiUqcMb0961dXvKOUTASGRiqODCJUZFQg2B6b6vUddxpn35q/M94PIgKLI9CfYxKgBxBFU0CEGct5tfWKTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i9FHPIFB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 911331BF20D;
	Fri,  5 Apr 2024 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ysm4DbzpqSZj84XzesirmTyGQsD5pPgqx8ZXriQXW0=;
	b=i9FHPIFB1bOTuAZcGIoU/ftnZ1SVa2TEZ4z60oYsvn9aHVv/Uk4SbpUmrq1vaMA8ZmrVtJ
	LU6OEAASLKMZu8HWnEztddFvjSLGMUJ5nEvF/SegcCPd4tYZd+GP1bN/OV0jwEVOxhiWG5
	g+judT4b4OySqJnJBIYLbaDgHcEG0O7Al9MDknvb7npfUcN2pfUskWYfoVKg7LHJ4Wr8Ia
	5xpKHPgynaNhpZrfvygj3Uzzg0+/NQJV6JL9xpPg2oR80MCFtGZpKEMznlXnD3zoEwUZzo
	UauH5cs5bCB8SWHnDVQ6qN6FHh3SpBXn1hGonj7YtDH//eWGJLEI4OZ3YPkXDg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:20 +0200
Subject: [PATCH v2 10/11] MIPS: mobileye: eyeq5: Add SPI-NOR controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-10-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
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


