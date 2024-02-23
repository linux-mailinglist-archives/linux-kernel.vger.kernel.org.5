Return-Path: <linux-kernel+bounces-78672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C434F8616FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A1228843C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4112BF08;
	Fri, 23 Feb 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m9+GDKH5"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0D126F2D;
	Fri, 23 Feb 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704341; cv=none; b=t8U3msBaWHLpZQki5xhgK1FJ2vx9hQcIfMGdtIMzUcj9MlzV9zN93o39VGTlITGnP9tBQl3Mi1Ol87KlJzg0w7XIxvC/WmO41PLeOxoWuhDr1uLXA5nlD0zxiqdCDrK1HbUvCeYkVGm1hMepl9inZdEJmiMevIENtq+o0MaI+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704341; c=relaxed/simple;
	bh=aug1EGBO9quV8KuGNaFq1P9VzUHdgRvZNwTEI+MXNnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clszwSW2IWIFXssinEW/UVHgvY8jt5eCd1TfWzDUDd2yTNDYy2yKl6Sxzkzk/HJOkLF2n1odGkk5t6VKgsW3x/+yKpvg8g4gR/wOx/eVdKR94T6biYFf4ULhz/hOGNELa9npAI0MeQ+Q5h1vKuX3Tb/vjZOToAmmvBZ1++kDV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m9+GDKH5; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE0851C000D;
	Fri, 23 Feb 2024 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xOpzacrMjQXeUvPNnUvJ9wpAt1ylGpzt8dxUAtY2fY=;
	b=m9+GDKH5e7Qotwc5ISt6ICucycRwJmKWEts5I8vhAwxfRn/31OH0ALy0DnGj5suVNMrdUA
	gBqM3HHCfrs/8g78pNr03uyFoJm1TW9TWddCcmipAO05w8QzTqauMsa4/Fy+PMJpaEPN4H
	93Jfj+XDXBHe4z1jJV8fLiwgy7C0/ZaZxK9rRqEmZIdbCK3Y+z4tIKg5mUmfW2sv/iUtQ1
	g/EXTjiSpNO7fwZf3j1XE9oL5eqvBvMQ7A5f9XoX6VJjpqF3hilrjxeTSgVBZ1i3Ab9QWZ
	0z3t4pz/EQQ+3sLCEdO3o2Iy1F6jmBeECDpEhUgWKlROQsDvOLLF6QQvsMqNcg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:32 +0100
Subject: [PATCH v3 8/8] arm64: dts: ti: k3-j7200: use J7200-specific USB
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-8-b41c9893a130@bootlin.com>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
In-Reply-To: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

On our platform, suspend-to-idle or suspend-to-RAM turn the controller
off. This compatible triggers reset-on-resume behavior to reconfigure
the hardware.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 45ba9c2d0344..134d6e5f3b01 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -793,7 +793,7 @@ pcie1_ep: pcie-ep@2910000 {
 	};
 
 	usbss0: cdns-usb@4104000 {
-		compatible = "ti,j721e-usb";
+		compatible = "ti,j7200-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
 		dma-coherent;
 		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;

-- 
2.43.2


