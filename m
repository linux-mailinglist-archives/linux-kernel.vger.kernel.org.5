Return-Path: <linux-kernel+bounces-86643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901EE86C849
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28351C211CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704557C6CA;
	Thu, 29 Feb 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ItMkn2Z6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713B7C0A1;
	Thu, 29 Feb 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206950; cv=none; b=IRpdJmQkz10c+LJsdy7vkH7WgtY5kKZH2riR9kk308KGJqqQmA2G0e8y1wcNchARTiTU6LgAKeqgSCQdcZ9tbu7nKo6dSvNTh/b4tyvoNsZUrdXeooB6567BSkdnpk81Oo8V9k9klTE/fsQ+exg0KTZduFU5cCc0CNA4Ta40paI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206950; c=relaxed/simple;
	bh=ZbTUZ2sytbwY3/uZ8J7MOQaQg4/G+6K17RU1C1wYXmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UWyz916dsgxMukhdC8+khittfBj5aZgP4HW9dY4RkiFyTx+M2T4yNC7ld9ESeHzuRB/GozQc/YzQJH/PttdGv7C03Kk5QJsuVdPek9TFRYnrbmF1IW0gplqieNZpy4VSauKuVLpVcNoY8lRfAyc/ad03mIe93csZZbf/hgwLLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ItMkn2Z6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709206948; x=1740742948;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZbTUZ2sytbwY3/uZ8J7MOQaQg4/G+6K17RU1C1wYXmk=;
  b=ItMkn2Z61k7rurAtlUpWCHmZT7F/Pt5PxP+ATADR96SbTtw9LP6e9SBx
   GUrQ5DGhQ/gbjjxPvp6bz9oCNDA0R6ClQ3j3zogRfUrejej1eYVC4hhJJ
   NhOfIPybmDFT9WTdPKpScuU83ApZQ4PYXXcMJkX1q09qdOVzyDvobhk/4
   YhudWlCr7wbls8L7mlhDE3pV/AatF4mDpLISuDvuRjBqjzaEQDaQmJNHF
   RmUIwFP3V7/uTIWgemW9mtb8Og7dvOQVuVxI2EY8mIPKE4DdhxtPpg8bS
   4sRvMGRKzwCZuFbGMZE9pfFzo7FHnd7KjASqzC/OSbwr8dQ8TAgPSoO78
   Q==;
X-CSE-ConnectionGUID: KYf983/NSaCGRI0KPGLdxQ==
X-CSE-MsgGUID: ZlDiA8fQTiSENQRO23TXRw==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="184277799"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 04:42:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 04:41:41 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Feb 2024 04:41:37 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Thu, 29 Feb 2024 17:09:31 +0530
Subject: [PATCH 2/3] ARM: dts: microchip: sama7g5: Move pinfunc.h headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-pio4-pinctrl-yaml-v1-2-c4d8279c083f@microchip.com>
References: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
In-Reply-To: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Linus Walleij <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.13.0

Move sama7g5-pinfunc.h into include/dt-bindings/pinctrl so that we can
include it in yaml dt-binding examples.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts                          | 2 +-
 .../dts/microchip => include/dt-bindings/pinctrl}/sama7g5-pinfunc.h     | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 217e9b96c61e..a92c37e57aaf 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -9,7 +9,7 @@
  *
  */
 /dts-v1/;
-#include "sama7g5-pinfunc.h"
+#include <dt-bindings/pinctrl/sama7g5-pinfunc.h>
 #include "sama7g5.dtsi"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/microchip/sama7g5-pinfunc.h b/include/dt-bindings/pinctrl/sama7g5-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/microchip/sama7g5-pinfunc.h
rename to include/dt-bindings/pinctrl/sama7g5-pinfunc.h

-- 
2.25.1


