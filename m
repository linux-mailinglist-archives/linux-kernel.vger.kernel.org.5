Return-Path: <linux-kernel+bounces-52179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4C849504
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8012865C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2511715;
	Mon,  5 Feb 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RmxCIWub"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BA10A33;
	Mon,  5 Feb 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120256; cv=none; b=DKSFdHbfHfjsJyRZY7jLaYgMi+6oHneNdFaGRqt931plSPdvRTu7VbJsPRPevG3RYV38rQRQubBZRgjG5z75VDcc45H/Ork89YQJ8zUYByJK+bsWS0E/GED2kj+qvhWJAkF/k9QYorlnYa3C99fw3p24FPKZuC8TBS81E2jQFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120256; c=relaxed/simple;
	bh=mW4lJXfZ3GmL/xcsOJOLADEGnDCtICQQeKtW5OlqpsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7RuXdj4cxrdesRP/gb4/KJHBkkYtP3UtV3OX+ySjbiC3jm6xTnOE9T/E+rVt/BWkjX7VDkhib7DkDOVE96oGUvxRbw1Dq0L6FKyuy7xDvkoERR+c94q4nEY/2zi2vliNXdzTKK5JUEvr3Gi0OSwQXkU/gEXBUr03EJ8mPypink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RmxCIWub; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120255; x=1738656255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mW4lJXfZ3GmL/xcsOJOLADEGnDCtICQQeKtW5OlqpsQ=;
  b=RmxCIWubNXKhhkL0ujk/QtJqljC3A78q79YEvX2qIrEKg13P1wH7Ay8o
   /5GjTDg8O3nAVi4/tVtOCu+Zh3t/AWEeAMjmv6876xJj5T+3/tqI6Ssr8
   bYBiL8gE+m3gGxd6GtXhLH0I0ZP+IO8PuOycEKtzdkLcEOG/0mFvj4DsS
   ApZPt62HLbH97wX40HExbCxI/XUsfVswPe/Ul4DSQh+uuCFrd54BY01f2
   ZnmMJdiLMiJ3W0og8nOe2WXsbGvpSWEgzUmTYWi0FiBvix5SZfPd2VuID
   r7sonog4L8AijjWtQ0xGN7xHZmpcG7vkyVDu5OwrHA3VWLQ77cIMPvcUG
   A==;
X-CSE-ConnectionGUID: /sWzmiszTQ2ztYFgEFabog==
X-CSE-MsgGUID: NbmStGl9RWWTzgTuMZjRLg==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278232"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:00:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:37 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:35 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 2/8] ARM: dts: microchip: sam9x60ek: Add power-supply properties for sdmmc nodes
Date: Mon, 5 Feb 2024 10:00:20 +0200
Message-ID: <20240205080027.4565-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205080027.4565-1-mihai.sain@microchip.com>
References: <20240205080027.4565-1-mihai.sain@microchip.com>
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
The sdmmc controller from SAM9X60 MPU doesn't support the IO voltage signaling/switching required by the UHS sd-card.
In order to use the sd high-speed mode, keep vqmmc at 3V3.

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


