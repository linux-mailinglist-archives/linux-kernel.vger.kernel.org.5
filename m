Return-Path: <linux-kernel+bounces-34900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0B838900
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A79B2305F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5375730B;
	Tue, 23 Jan 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I/VD5l7G"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696935821F;
	Tue, 23 Jan 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998772; cv=none; b=gxj2gj01y4ayaxGkdV+EmRf+w+x07VYpA7yTohr5PHlr1WgHfm1iNfhz/jnQUPMa2rHcfX1Jh64yhjG/dooXP+r/Gj48xDTP0TiU4WPAj19aq7nyNBn9MnG/bqBh0nwb1pY6LfhDcqB5Rt2oolTl8cg1KdItyZv6z5rrfUZFY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998772; c=relaxed/simple;
	bh=xSnAenXjLfacu9KzXTxgbe8KLcOoY/B7WBG5mmvr56w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNxLSj/EizlQPZFysz5c9iK6PZ9Jw5Ei58dhxi6By9Lk3kmmCu/VUaTKk/Y4MnmZQegRG9P7G/HUPBSSCsIUnp7xrnd6B3n4ghnTwikuGrCiZpBoQqVKy877YsMX2RemabKbekXf4JOS6oLVCu24rfM5v73DKEFw39VBZYkUhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I/VD5l7G; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998772; x=1737534772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSnAenXjLfacu9KzXTxgbe8KLcOoY/B7WBG5mmvr56w=;
  b=I/VD5l7GAJd2ZXdQ6Zw5OlXQ4nBt1ALvBe0bKzAHgCTzHzad9jL2+2X4
   C9dil4LZmc8FtJ218N2TYbN93UjeOZ2BnUq1ezhuwpRhq3fxl+FbrmOM9
   mVSu3Den5Y2Ejpb+Cy2p9BvbLNPqhb2gRKDupc9rIdCIVtP5qwOv3egVr
   8I1xLuOGCtH+tpbqaa4M9OSmNezDmO8mpMHAma1gVIDPdNFE3bF/Ph3mE
   zZGVSAPG6Id+YKXxva9mDPbSHgkrHxrkLllN4uig2AoLOlzlOyCKUAWZU
   lsGerPlIUsg8qj5qj+cw4zPN+mDcU977Z4mIPYQXJ1PZdydw6BeHXh3hQ
   g==;
X-CSE-ConnectionGUID: 8Z0MiRbqTTiGlgq+aKWHzg==
X-CSE-MsgGUID: LY151oPLSCe6Yk8j+RHx9w==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15154460"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:28 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:26 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/8] ARM: dts: microchip: sam9x60ek: Add power-supply properties for sdmmc nodes
Date: Tue, 23 Jan 2024 10:31:52 +0200
Message-ID: <20240123083158.7339-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123083158.7339-1-mihai.sain@microchip.com>
References: <20240123083158.7339-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 and sdmmc1 controllers are powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
index f3cbb675cea4..b19a0956dc97 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
@@ -560,6 +560,8 @@ &sdmmc0 {
 	status = "okay";
 	cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 };
 
 &sdmmc1 {
@@ -568,6 +570,8 @@ &sdmmc1 {
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	no-1-8-v;
 	non-removable;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "disabled"; /* Conflict with flx4. */
 };
 
-- 
2.43.0


