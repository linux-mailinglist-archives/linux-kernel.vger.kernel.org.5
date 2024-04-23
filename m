Return-Path: <linux-kernel+bounces-154833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327B38AE1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BC71C2102C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4D7EEE1;
	Tue, 23 Apr 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eYViJkpo"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320185FDDC;
	Tue, 23 Apr 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866519; cv=none; b=orS8+AbQ0rSyJmyf7a5tg68jmor8qqM7FjWuaiuOSgiwtrGrmownrNSH4WoeAV+ATVfqjaUl4wVnoRqvh+IU+xXZ3K/Et5ynPyzZ43wuX/DkLDWUqY+KSBKucGcWbL20y7xZ1Etiw/aVrFG1BTrsOcyFKcstYZxvX9Ux+ypWEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866519; c=relaxed/simple;
	bh=F/9Yanst1hBH0HDc3LX9DP2jVFZb4lsc+NgoZKuU+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNA803iXWQxwCb5k6Jl7Ve2SlM004+AYviTFsP0fMi35eGo3yu1CI2BnZ4FN78fxxWZ97/abQhZ7DX+SmLEP3fEHkuRg3BVuRPRSxAddCkWJrhDV4mRD9W2Ku8v0pAvBeVPSRB0DMF1XjRe1q/+knf1l294RVOvQSA3Zc2s1ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eYViJkpo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F07E41C0018;
	Tue, 23 Apr 2024 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sXwCu/pnKjPhnbG0qZ+rGnft7Ztmr1z9mGamghTqGc=;
	b=eYViJkpo23dM3LsyVoZzOXw7uklJUF2oG+ntLMI9K7aDcOg5zfsfgqRsPbbfKvxGM0TQYr
	6vbOyPXRAfC8Dj0I87/AKP6SK8V9HyBcvfITU3Fo4LNis7BTwLSu9qf3oCfM95W7PjzgQE
	xOVlZ4FVcRr5sx2f9QoFiMjMWTsxg1KIJUrUGaU+mc30F8/fJERj2+jnFUxa/EIIYNuF7b
	YzRH8UWmZzYeZZPBr19rzPTHeRiQ1bWDxG4/Kk52FMZ3EaL0UXKdLeSaadMad2+gQEc7Nn
	6D5/M5lP1T+1MUYRZd3gLLMLUkHN9aQdT/G1Lzp+aIFJwVwjaFPk+JzO6nbRVw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Apr 2024 12:01:45 +0200
Subject: [PATCH v4 6/6] MIPS: mobileye: eyeq5: add octal flash node to eval
 board DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-cdns-qspi-mbly-v4-6-3d2a7b535ad0@bootlin.com>
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

Add SPI-NOR octal flash node to evaluation board devicetree.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
index 6898b2d8267d..0e5fee7b680c 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
+++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
@@ -21,3 +21,18 @@ memory@0 {
 		      <0x8 0x02000000 0x0 0x7E000000>;
 	};
 };
+
+&ospi {
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* chip select */
+
+		spi-max-frequency = <40000000>;
+		spi-rx-bus-width = <8>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <400>;
+		cdns,tsd2d-ns = <400>;
+		cdns,tchsh-ns = <125>;
+		cdns,tslch-ns = <50>;
+	};
+};

-- 
2.44.0


