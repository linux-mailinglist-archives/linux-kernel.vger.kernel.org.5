Return-Path: <linux-kernel+bounces-139979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43928A09EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AAF1C223C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2913EFE5;
	Thu, 11 Apr 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GF5Q7Y/o"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629A13E048;
	Thu, 11 Apr 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820890; cv=none; b=Mo9mwYlZ3qgIfH6pqhrU9CUggcG4V81E8fwdDK80n8L77xpbZ5Kr47waCaY47j9olhbfaQebgt5ghZcvc5bKiXy7RznnFNYY1iikLnPSIy3yk6qLDIPuocf5iGG9QdP6KpnLc7uafRQOTz8udIaFsPSIf7/ylPSr9kFT/qPV0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820890; c=relaxed/simple;
	bh=CJYoreMw6gVA+wVBe9/K95sIJF7Sqfla5VFUm40ZR/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXIq82SMnnzcs6plXKXIhuzZc5jPw1yztJ/qRxq8ekWgsGxRxTuKDqEErE+GajQG1a4L1FMDAFg8pWvhev1SmWNq8PtAJDS2QTSO7nAz/bDQFhRMvGq6AuTjFgUtDc8L4NPw3MFJujmEtqcBVyPkmxe+aFlvkgf0zwmht6EqQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GF5Q7Y/o; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820888; x=1744356888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJYoreMw6gVA+wVBe9/K95sIJF7Sqfla5VFUm40ZR/M=;
  b=GF5Q7Y/o8V76JNqvipsLItexsuP6dzhLvNLxsqBA41CntA5Jbbccs8RU
   acSEpHP/FOPDyoOqTolJAP7xo6XaNs20bQVgfpyMs3Lp3f8wmy9CH/2lu
   3w03vsSAM95BY/ASr4uNSXJLKJbdNrweHT/m5FautapeVBzou50ozUJmO
   Wn6QmvkOWYpEK9WJ+2kIGUQkasIRSM3vhtDtntIbkbUpkEY84Afms6MgE
   2sIKa5AAP7IP6jF+ud78q/2zFxPGuLAp8gX78vyXKOYLYKStXXyHR9twT
   jKTVMK/8e1A7zGcDBw1wyaPUVRyOlbQ0w7lF4MmOt4i9COjcAHOuc4S9e
   A==;
X-CSE-ConnectionGUID: dQ5jbtg2Q1GDLCjGLtSnbQ==
X-CSE-MsgGUID: TbYII98XT5SsQKq/XAjT2g==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="20534665"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:27 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:25 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 07/13] ARM: dts: microchip: sama5d2_icp: Remove the empty line 47
Date: Thu, 11 Apr 2024 10:33:47 +0300
Message-ID: <20240411073353.3831-8-mihai.sain@microchip.com>
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

Remove the empty line 47 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..6d0551925e63 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -44,7 +44,6 @@ main_xtal {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-- 
2.44.0


