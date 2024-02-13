Return-Path: <linux-kernel+bounces-63735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E28533CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6963A1F2CDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1685F494;
	Tue, 13 Feb 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r0WkNnOU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5865EE7C;
	Tue, 13 Feb 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836179; cv=none; b=DzRCa1fmKp2PP9IG1RaEXMTb6qQ+a3nDKk52KbwcEvcvE8dyil4xIg/4n8M70WoZGR8RMv7tl4XtGU4Hrt+wU1zM45tzHQet4Z4IQ6qrHyYuM/gzCHJ9eheutMb3BgKcW7ac1/wFmvQdOtxZa+VFCCaYYwDxDWsyNptdxUKaRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836179; c=relaxed/simple;
	bh=4GHGNBpN50CmynGXCsPvcgdJAlAH6pJHR8epQc++XaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icFZqkuvGpRpNFvTA1NLwCHzT7IRuOa1QrLegRIskN3U306qd2Styv3LIFdVcYTHLxwKlPtUHMNBq+t2T2Wrool0cUG6VZ3BawzNipI+pwIZa0lPovs7hLYU+fBCWVEJIgIkGXSFND/7jQCUKrZGyaa/JrrA9GzqirJnjFYwLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r0WkNnOU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836178; x=1739372178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4GHGNBpN50CmynGXCsPvcgdJAlAH6pJHR8epQc++XaI=;
  b=r0WkNnOUBGlA6meObJ2sD8B1ta//7OuwCVXG5NXFcUW2wrGcKRr4A7in
   KV17GEiWsAj61qWuaUifkfSLsygk3ESTHevRk+k1PSQvNlBzP/m5WBlBN
   0v3VAy4TKDySQplvmo6xoYIilRTaF/bYIkCIutlrvBfCoYdBRkkdtMEmt
   pJSUB72DWly/GiGs2MGz7zCYhyE6kJNAXKNKHQ2e0ClZZMReLOv0J5jbk
   jfz7fxF08yKRIgcUAVg3hjMrBS5kJTDjzxhNIgSIj1eOqQdC1y1Gre1oR
   8GI/U06mqms0UfcL2RZQyniYvqUcGx4TEg+qvwOw12UddnYOMSToMKgSW
   Q==;
X-CSE-ConnectionGUID: 1b1+m5inQImh9toRpU0rhA==
X-CSE-MsgGUID: ePTa0T8jSBa+f3Q8oIUgGQ==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="16174935"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:56:05 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:56:02 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 5/8] ARM: dts: microchip: sama5d27_wlsom1_ek: Add power-supply property for sdmmc0 node
Date: Tue, 13 Feb 2024 16:55:39 +0200
Message-ID: <20240213145542.23207-6-mihai.sain@microchip.com>
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

In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.
Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..7b36e1970bb7 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -199,6 +199,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


