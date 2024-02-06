Return-Path: <linux-kernel+bounces-54849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703C84B46F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F151F21281
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D413246F;
	Tue,  6 Feb 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fd7raDkZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA1131E4E;
	Tue,  6 Feb 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221040; cv=none; b=HgfjE/vUz0DmdxIfwNK/kRdJSDWEQd/Hzv9nMuGELf3qMsgvi9cf/sQY7CXCCuvLzdDlnOIkBqaUtsT5KWZuRzfmGAu3KkXQEdvjyQ3v/ZeJAH862Try7/1+fuj/v7nrF2J4C+hCld2tQKyDT9r+b2Vd3oeZgmwDPmYSMZ1INfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221040; c=relaxed/simple;
	bh=F41G1+RQ5nTNqvMXTxeVA04ZwCfN78WPkAzyLOV9cds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn4rELP+SkExWOw/OO40MVBre/vGmBzZkvySnvHWcRK5ENt5bLdVlaOOPpoT+AzbA8D0xNoOWjA4Fu/n+ihFL8svONqF47Xb5DqSpvYJQLPoAH2e9nNuFQTx7HJV9VR49AtWULvSQBDd0L4DYDqMj3ViDj5/FhAx3LvfkbmXBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fd7raDkZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221039; x=1738757039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F41G1+RQ5nTNqvMXTxeVA04ZwCfN78WPkAzyLOV9cds=;
  b=Fd7raDkZrqMsh9ojCzrbAM36HPc9T4zPAceE28TJbQf1wgTlUgp9oh0x
   ModpVSDaoyjbojsItrDgX1F7SrEKWHX6pzKkSEt2aEHqSczRQutQEZrB9
   74knbHSG3BxYXwz8joSjRC+18LZRwy4j07dJfo1rTMnKdogx1TGqf424J
   kdiHjitfMUDiRRPrd9wjH8fGpF7nyyonD5R+dAlkY71b2IBh8e5a9Q0+W
   7jveERDA1ZRpc4yJudPoSg8CrLzofHQmeoTraQmk+75v74+3EplwSkKMS
   iOLLWz3daXwGs+KYncsHKohreY680m1Y+oaACJSerGnEtNl3K2H3BZQdP
   Q==;
X-CSE-ConnectionGUID: F8QfY3NGSPaWmFcnYFQ4zw==
X-CSE-MsgGUID: kBnP/YNoQvymYWbm+zoYjw==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="15843151"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:35 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:33 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 2/8] ARM: dts: microchip: sam9x60ek: Add power-supply properties for sdmmc nodes
Date: Tue, 6 Feb 2024 14:03:16 +0200
Message-ID: <20240206120322.88907-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206120322.88907-1-mihai.sain@microchip.com>
References: <20240206120322.88907-1-mihai.sain@microchip.com>
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
The sdmmc controller from SAM9X60 MPU doesn't support the
IO voltage signaling/switching required by the UHS sd-card.
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


