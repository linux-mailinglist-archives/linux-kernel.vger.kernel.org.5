Return-Path: <linux-kernel+bounces-95262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C830874B79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD54B21D80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E97128361;
	Thu,  7 Mar 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="edEuJ4f6"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEB82880;
	Thu,  7 Mar 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805320; cv=none; b=mcq9CJ9o+ch9+C5VbMyHv2KJ1VhmdfpYNoyCAQT8xjpa1atHzyIF0ehFiPmDZBBK6zaNEGgrePTUvIhUn1abURmyJH0wHvuYXhgkwxslZNjq8eLydL7e3D3IAEWmeQgcS2FmvFwERPWpiZPZ70SvPZMA+LcNlbgnYsX40Nm/vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805320; c=relaxed/simple;
	bh=1wxo3NL9cihA8oLsXh0fu4ANYi/oi24/gNs9zqxECF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUhrmTDLwk5Lka5BYVNxK1+T16ApnuZgZfOaeZiEjMLEDF9sXYE4KwVbdyslVd/2C+QTEUF8l6zgZoO1bP2FZa/2FnInhB4yMKkMbf9GdfOQjANPZg3JvWOQHGhykatIOx7g0vCqps/IJzxsT34Y08RLm7auenFUuEJqvVyupbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=edEuJ4f6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDD991C0018;
	Thu,  7 Mar 2024 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kC1PY9mz+tc5NmqAdWmmc1QQ0klaL3U6KF0CqTuul0=;
	b=edEuJ4f6KZAELqYxzDFFGoSw6ohghuznupCRzUhofziUyE3O0A3TYAdnJBvGpDtvzfEiul
	q5GXMWMjotgNJD3VYCd1FKawt8VuW/+7sFx4nBOlLUzlQXrnS0ifhhomOWyWQrIbi3N7Q+
	AfeQoDXRHQSsuSIYXE6vkHK/srAa2cOf/4UjiCqEJbE9nFhWseDFDWrbKxblJACxvkdZTc
	puHm97vbSfEf/eKMnQHGlo6VZhlHkQGWjq6dipQTZku6+p18PkqTTYbIA0cOEgVf1W7Aur
	wz0mx1PYUZNYH2lPSpU2JFeCpwN6nFXWS/4ZB7FJOuQo+SgYD03V9a+n6WBKeQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Mar 2024 10:55:10 +0100
Subject: [PATCH v4 9/9] arm64: dts: ti: k3-am64: add USB fallback
 compatible to J721E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-j7200-usb-suspend-v4-9-5ec7615431f3@bootlin.com>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
In-Reply-To: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
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

USB on AM64 is the same peripheral as on J721E. It has a specific
compatible for potential integration details. Express this
relationship, matching what the dt-bindings indicate.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e348114f42e0..de04f4350a9e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -749,7 +749,7 @@ timesync_router: pinctrl@a40000 {
 	};
 
 	usbss0: cdns-usb@f900000 {
-		compatible = "ti,am64-usb";
+		compatible = "ti,am64-usb", "ti,j721e-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
 		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 161 9>, <&k3_clks 161 1>;

-- 
2.44.0


