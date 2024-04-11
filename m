Return-Path: <linux-kernel+bounces-139986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2BA8A09FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BF31C226A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D601448E2;
	Thu, 11 Apr 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ts6bBUGa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24913E8B5;
	Thu, 11 Apr 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820892; cv=none; b=SLUzETEZ1lreFG4yp2yFrGmH9oqhkynXgyFN2vIFskjM28USxgIkM9Bg9inrZxsT3kdGpwL4q9Hu+Zbpao5OvjfQDJPKSO2rorEDV168k6BuwNXyuqDw9Ci812uhxRsUFEVstqOYxpufQO3cBkSxoyzt6Fzwcqu00+/QBO5uf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820892; c=relaxed/simple;
	bh=TuDc+Rm4R7FNVcs0UIV7226BdvuZ1MVJx+8a8upoLLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qr+VePfg5JaXQHmt0bizXdf0B6KX0YNx6RMNau/6UMFyL9OnbHFlGmH+v1XecZt+mAimRlSTGhRgP3uNUZAeWCwhaK15hFE3/VtbsfnNwxgbZ6Ifenw24XXq8ijshxSyfrDS41cKOPrJbPM1lg4sUA/Vuk1R3T2Izc4nSoRca7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ts6bBUGa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820891; x=1744356891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TuDc+Rm4R7FNVcs0UIV7226BdvuZ1MVJx+8a8upoLLU=;
  b=ts6bBUGaQ2LrqW2J0rV1eM0rmZQDJSsfhWPntLGk9L9gFZ78zEzaF8oP
   JbPDRO7ZKy4Br80MKHCLmfNMLNx2Lylk1od3AHt3D+t9foOPsPTpcE0XN
   ax3nK6DLKsYVz2BeFZBd/HM3oA+uD73XRY234FWe8WyHgSTK525gfCK+k
   +xpTR/oqScMDxL3pk5yo7q9I0wo0RTipt3YvitFF3OOV3KNzqXsMDS0cu
   AgSwEJP8Vu+CcAzZ9xlEBozr8raiTXeI0ujpxRyUm76fyFXRmfYicNARe
   q8D/oBh/x1QVQapFEKX+9uTCUEEDs2b2avKZt4Z2uvIhUZoTSmk00i3nL
   A==;
X-CSE-ConnectionGUID: dQ5jbtg2Q1GDLCjGLtSnbQ==
X-CSE-MsgGUID: LGjnS33YRB6Q1Kew+8VPDQ==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="20534671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:34 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:32 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 10/13] ARM: dts: microchip: sama5d3_eds: Remove the empty line 24
Date: Thu, 11 Apr 2024 10:33:50 +0300
Message-ID: <20240411073353.3831-11-mihai.sain@microchip.com>
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

Remove the empty line 24 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
index c287b03d768b..094ce5751956 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
@@ -21,7 +21,6 @@ chosen {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-- 
2.44.0


