Return-Path: <linux-kernel+bounces-63741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030A8533DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623611C26FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBBB60251;
	Tue, 13 Feb 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WOfX8vgp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93F5FBA0;
	Tue, 13 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836185; cv=none; b=U6IUzb+S/13AEHF/4fyWIrfT3vkSkeuCF4Aq5P8FYvsuYdIDCGKt328NC4KRayvORX6JrrRXaAdzqeJ4yGh+xmsAWOwBK3vvbG+Y1KVCLEhEHil6+b0QLKbXG/fR8oZxExtKl1FhOXN7Z0CYDF0lH3lXgwOQz/1sOAEeVP2a4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836185; c=relaxed/simple;
	bh=h/0Y6hhs8r2cySXKaO2xRMwKwZQAS3k9mKn9rJOs92o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTjW1HizLtF+5Z/qv7XnE1505VCZYpxJaFErrKk1YVt7ct8GdLl+AHUbGE8QZAEgyELpDt6IgluOAt2A3HiOI/Dc9IrtmbMCRC0d2191ZnFmu6ndmITvvErp3SggcN3Rt0ZLSRjxyy8WJwlKAhB1A6FbpkTtnc9vlQButEj5oPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WOfX8vgp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836183; x=1739372183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/0Y6hhs8r2cySXKaO2xRMwKwZQAS3k9mKn9rJOs92o=;
  b=WOfX8vgpacC1dUWV//ZOhoUAvmfJb0Vd/5R7ruUXCOEDeWixSNdPatrX
   mHixht3fHntHMRtVaA76LdXYonW2WShFSYOUhXPM/oJnANAPqUz/f6DiK
   grm5MkZDDGQF9vLAz7lXN1Rv6UIpQVEFKXBuVhggMeJDvvovD4gJfYRAq
   8/vKt+Xl8jVYKqXyG864lheEJNLdvD+cK6aLz/lC2tZmm/X0KFzKAAYJ7
   BMXYzS2uQnty8+lTmxvujzqo7dwgTcjTxKMCcLSN1ox6cmGt7tLKoKri/
   kP+uOSSqNu0RZW4FkIMs8UOJpJRT9jfReh1c6LDTGPCiMUBun4++z5IZk
   Q==;
X-CSE-ConnectionGUID: notrBuGtRbuSS13mA3DSPA==
X-CSE-MsgGUID: +k0tQL8IRSyaBENpR/NdFQ==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="17608948"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:56:13 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:56:11 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 8/8] ARM: dts: microchip: sama5d2_xplained: Add power-supply property for sdmmc0 node
Date: Tue, 13 Feb 2024 16:55:42 +0200
Message-ID: <20240213145542.23207-9-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 6680031387e8..9b7e56790a5a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -67,6 +67,8 @@ sdmmc0: sdio-host@a0000000 {
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
 			non-removable;
 			mmc-ddr-3_3v;
+			vmmc-supply = <&vdd_3v3_reg>;
+			vqmmc-supply = <&vdd_3v3_reg>;
 			status = "okay";
 		};
 
-- 
2.43.0


