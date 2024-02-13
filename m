Return-Path: <linux-kernel+bounces-63738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906708533D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AD01F2CDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0985FB94;
	Tue, 13 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YEXy5jrx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385085F569;
	Tue, 13 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836182; cv=none; b=LxcjpfrbHZhWmbIIaWuGhSlLLKkIB38V9cRhMa0WBq/SyZC6DDa0hPgDs7HKEFi4vVI4iZofi9yDFdpU+9LXdU8yJOFB4OEicdexhU9Uhjl1gzN1CxRLt5++BkJbYqtzgBiGAx7ta+hCB7cp+9RYUQrJGmW9z/sfCJOIEO03Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836182; c=relaxed/simple;
	bh=XSrEmtCTEoZ1BvUgmXS0alF89dCeproQKiVNavB3G9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMd42pBiUTh8fTwzNZOihQqXk8sSw/1vvprjDS2L1lc0RAqU17UetcBJEdorBhktTTPCQbMcfO0dEB4po26uAS/288MAnD5gPek+aKJ0ToWNwuU7Ix5QyAtobPISVBigAocAWwOYk2wD1TOPRqCAU96Cm655ryNQ2i+0Lw2vH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YEXy5jrx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836180; x=1739372180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XSrEmtCTEoZ1BvUgmXS0alF89dCeproQKiVNavB3G9M=;
  b=YEXy5jrxhL28HsOD8XO9WAE4fp4zuigDif42X82PFFLBwV+La5cKytKl
   zzgKZKlgqgu/ayRCz5egJtzzt4+fRAgsk04yGjaCJP292vg4qNO4QALCl
   dBz81Os5yGayz6zxhtC8VtHqX86s/B6FH1wEEVyK09OXeFIyuuOjVKovn
   5hrsBjUWYwfsKZEYp2ecLJzm5a5pgKiORjTc0l5kGQu5GnWBOYavdXB3E
   q3PuIoEXvvLyLo6g/Sosa6TeJAwGNy6RBTaqvOF6ecNGDEmhyU2wHDCv4
   o3DFxG4nKR19+AD0Mz8TPOFoci8aIpZPj4hNRcPez9G4Kf/+Uf2KCPyiq
   A==;
X-CSE-ConnectionGUID: notrBuGtRbuSS13mA3DSPA==
X-CSE-MsgGUID: onnDf4NKQra/EO/e8SYCPw==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="17608938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:55:56 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:55:54 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 2/8] ARM: dts: microchip: sam9x60ek: Add power-supply properties for sdmmc nodes
Date: Tue, 13 Feb 2024 16:55:36 +0200
Message-ID: <20240213145542.23207-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213145542.23207-1-mihai.sain@microchip.com>
References: <20240213145542.23207-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In order to use the sd high-speed mode, keep vqmmc at 3V3.
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


