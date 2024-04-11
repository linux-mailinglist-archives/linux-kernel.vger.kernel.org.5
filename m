Return-Path: <linux-kernel+bounces-139991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E18A0A05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295721C23305
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40F13E8AB;
	Thu, 11 Apr 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fa+BBpTa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184D13E04F;
	Thu, 11 Apr 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820915; cv=none; b=VBiDmdwI0H0/oXlWoGXsaygatk4dmwvHcoRGl/VpxYDUTuOUqjBHq4hieyR6X5DJv2BHFfrTR5JOvRNlCrF30yva9g9ORrGJuz4IuwKb/8vpNl5Wpg1EEbEAjuJQBZ7DGQoCB87hQPI6h1MfAnAqnqd6ie4D+shT23uI1ODN+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820915; c=relaxed/simple;
	bh=S9fmRPm9JVgx5jN05kxllFKxPu9Ixpq8cXfF4z84I9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzrwDaQbrIdXgFx7zHH0Qnldm4bXctlxebVfMaCawrtzP7DAxFQB9e6r/tYIYtMlKoS/idjNbTkY7Ed+4hdmrDEUpBlRqvPwVzj5a1c13I0Jdg7tb4UI5x2hSSXXMGGF5IXDpyt1T8fPXor2wJe08EdnRFFx0mh4gAiQroPZdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fa+BBpTa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820914; x=1744356914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9fmRPm9JVgx5jN05kxllFKxPu9Ixpq8cXfF4z84I9E=;
  b=Fa+BBpTarbVRlMuy9/GJGP4cmS7/UMG7iHzj90Y7HuvZiYhpdZwAb5/4
   zkmcIrqX2Vit+7IoxTAgboA/HSfc8wkDP52dNWFENQxaPVCwlKXxiEE3W
   ZiqxOrKZE83t4/NWKKZgUwSqwMSDN4AJFNZFj5z89C0dEQ5fgP/mXFZzc
   Z1zYB/TfLddQkrSx6KNUiPLryXQCKl7vz5LJMeZPWGGAQ7mluVYpRFF8o
   CAAIbnf6C4tYvIewp8dZ6wnPetFE+/5KOq4UiQjUfHcqpNOuRPP7Crs6a
   CUI+WmVKTGv8VjXI5C+NyMu4jvE0JycKLcTY8Nv/44xbvKKNjAQuEbf4B
   Q==;
X-CSE-ConnectionGUID: FDxI7XkyQ1S+I22CuBDFuw==
X-CSE-MsgGUID: skNTQfsaTl+YlBjnotU/2w==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="187806892"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:35:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:42 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:40 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 13/13] ARM: dts: microchip: sama5d4ek: Remove the empty line 274
Date: Thu, 11 Apr 2024 10:33:53 +0300
Message-ID: <20240411073353.3831-14-mihai.sain@microchip.com>
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

Remove the empty line 274 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d4ek.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
index 20ac775059ca..6e59315249db 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
@@ -271,7 +271,6 @@ rootfs@800000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-- 
2.44.0


