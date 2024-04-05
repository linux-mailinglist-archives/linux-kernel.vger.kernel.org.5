Return-Path: <linux-kernel+bounces-133214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0389A0B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57AD1C2205A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53C172782;
	Fri,  5 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GIQs3hGh"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492C171672;
	Fri,  5 Apr 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329347; cv=none; b=AymI9QPRinGg3y+wcG0pkG+Nft5HMhhGpsTc/TBLf6h5SA1nSLP9vSY08JpQ+7CdkBXDfxkgJvSRKnz1mTTvfs2VhwJK14fr2SVaEzSxxYn0GAtCDs4aKaQUQH/97KNgIAmEAsvzxres+ClPlpXcghqhVtHW5pdCpEo3RvGd4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329347; c=relaxed/simple;
	bh=F/9Yanst1hBH0HDc3LX9DP2jVFZb4lsc+NgoZKuU+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhatQ+LEVZIc7eS9AB6tzkK8ctWmjSef3U+NofL1VyXNkvYjP5nZJ7TKxyHyLRhsGW1QjE1hOVC6IZiS5sp1IRWLZr7WzpWRPajSdFArgihjuuISe2S+KfoNBva5i4NWMFIAZWaKsTfZgTBsDShDyXIZ+uvYFnTuzKsOSbAWPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GIQs3hGh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25F8A1BF203;
	Fri,  5 Apr 2024 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sXwCu/pnKjPhnbG0qZ+rGnft7Ztmr1z9mGamghTqGc=;
	b=GIQs3hGhLcuP+LdHR2rHZwIM/h0pDqFkngfYPjRM4qN38clW0VZH1RY71AeNvym1gp0iHF
	AdGrHLOKsX8l4ExSEN2GE+2NGIAicp/wtBPysSxWb8b7z579/6Lnp4nh95+tbESLMdHkXG
	2U6sIv86k8mLgtoH6CDFfVXFP/3qtSFA7X7+Zgj4GxNzw2+/GaV13N7j6bj54IHfzqKOQn
	3KPuyd1WiUVN7KTIgoexeLSpWMAr5iQp4SPyAkN30u7sFSsEJr3XfJxYSAG8140LeSSKL1
	FnpkfHRUXXTL3+Y0JgkPUuwHd5u7QImghRtHvkBjsgBWUJ0RUrzaus/37+rh3g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:21 +0200
Subject: [PATCH v2 11/11] MIPS: mobileye: eyeq5: add octal flash node to
 eval board DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-11-956679866d6d@bootlin.com>
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


