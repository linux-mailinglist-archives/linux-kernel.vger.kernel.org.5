Return-Path: <linux-kernel+bounces-139988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A318A0A00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0863B1F225A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94D1448E9;
	Thu, 11 Apr 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UTjv3JNd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0613E3E5;
	Thu, 11 Apr 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820893; cv=none; b=PwINdzehQewkzydCT4zJ8v+m4TXXbNEavvI0udiR3sBQW+2wL25TjV/NS6xrKs4qoAAdiFBDeU0rI/76x81wN1iOXRnYiAfE8p15SXXvbkp2OpFofr5A2BDmDyuMavIFD6/UsMYbZnNAAbVr2F6gy6igfwGUNBwd3dsj3L/irI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820893; c=relaxed/simple;
	bh=2hjCDMfqIS9F4kgK633yXyLSlSjPuy1k5AcJ8ycvSEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX96hOHCgzNqqn4PQdCUsa7CTUD5IhOAwUkfxHVgcDHiSuMR+Ao9e6uXqft1cSgUnH6bnD8aQIT+9c3JsIB1/L/Pc3ZgaMl7Mm8LYlKuK9HGHtxUWjQVsh+/51Sno9myIwRauT9Bj0OukoRMzZpCxPp0jXxgbd0D/SC4kFDA5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UTjv3JNd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820892; x=1744356892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hjCDMfqIS9F4kgK633yXyLSlSjPuy1k5AcJ8ycvSEI=;
  b=UTjv3JNdUo42EllrLT6R0SF9LXyWq0MNbJlIWuh5h49YCZEirefen2cc
   CTgZ2SRyOu8fPBCkPq13dxYEBavt6ifvW9AUz/DCwzaNGd2ycjlIzaul/
   hpbVHlkPIeHCDZFOTvikMAVGmdUkjydErHuDBvaQC2uhMWn7ro0Y4nezh
   L++x+/AG/WHfMgMCkHX87r9IQW0GyIxvEoZDALEcfFQMLT79tuqsWN98d
   XrRTVkbH06T1XlFQ6U7QbVGCRrB3lxUKSbT4cD2H1CYEv+p0lG4W6xCI2
   udf26Yu8sWXZigGAcTXJ0qVLHMnmuQKyA5MnfMpUkQoDPJ1XUiyGlHA9P
   A==;
X-CSE-ConnectionGUID: jDRmTUiXRgK//h330KmRHg==
X-CSE-MsgGUID: 3phr6HWsRi2QfW8Vk/KTEg==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="21068912"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:24 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:22 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 06/13] ARM: dts: microchip: sama5d29_curiosity: Remove the empty line 48
Date: Thu, 11 Apr 2024 10:33:46 +0300
Message-ID: <20240411073353.3831-7-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove the empty line 48 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..79836dd6faa8 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -45,7 +45,6 @@ main_xtal {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-- 
2.44.0


