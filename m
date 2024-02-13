Return-Path: <linux-kernel+bounces-63739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F048533D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B880828539A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CFB5FEE6;
	Tue, 13 Feb 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rt/TTHHM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF15F847;
	Tue, 13 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836183; cv=none; b=YWemMYz/uyq9cAx3qNm1T8J4ZzZ2p5LKiUARA7EM7hgtE69NM7JBYqhDrj8bhfQEinLlEXwXo4B4v2Xh1uO4c3vhGPcYtvA0RQR+bkChrrCvZRgQOsCV8TeE4gP22QmCiNGojrlGScWT8nMnl6ndp7OfHkpXujnqmPtVX8GF/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836183; c=relaxed/simple;
	bh=vRgH65z5u2Trf6NRHmHKRRQRgHAJG82R6v9OxBg1FGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxoGIAz6Rchlf9gwEt2MFtz0gfdlDizEs5s3+g9FHUU8SN4vlsgToCBFRKPW70w8fdOOoVBmWPToEPuyV5BmiuSeKZk8oZWBqP3kIqymTrrIw1BphTFbglDSUcUnZSUlma9QvSLk4Bxl6PHkTp0fqzncEag6yQPuAizcEtu0w1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rt/TTHHM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836181; x=1739372181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vRgH65z5u2Trf6NRHmHKRRQRgHAJG82R6v9OxBg1FGc=;
  b=rt/TTHHMoFVT3nmEE1bGxXarj6339h+GIY69PiLdJLaMrX9u/hMauWMF
   i4h7mwBW/WWCyEqEwFQtK6kjsE0MiarBTkZJOaTNby9cE2eOEFUd4pfWn
   uwSAqgq9dj9NiQCqBxOM+UIPksdQ4uladBLc5BvWmyAUEtoPGaPEYMjJl
   NVRuWST6wxjySgKnkwCojxlbuHpS5q+XUdvWCCQu6r/bwJx5MeIMqIdad
   Ie7tGb/PrIPtukxyjgirNSUWpGOcyAkxuv6NOXzzazBMxPpAgpz6Em6iD
   TOWEaKAMiX/XkrjtUhi6BlSYGdp69Juc8f8e22Rwo3qkPy56m6uD5aguK
   Q==;
X-CSE-ConnectionGUID: notrBuGtRbuSS13mA3DSPA==
X-CSE-MsgGUID: QQI5k3uVSNeuyENq3E5j2w==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="17608940"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:55:59 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:55:57 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 3/8] ARM: dts: microchip: sama5d27_som1_ek: Add power-supply properties for sdmmc nodes
Date: Tue, 13 Feb 2024 16:55:37 +0200
Message-ID: <20240213145542.23207-4-mihai.sain@microchip.com>
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
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
index f3ffb8f01d8a..255ee0640133 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
@@ -56,6 +56,8 @@ sdmmc0: sdio-host@a0000000 {
 			bus-width = <8>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
+			vmmc-supply = <&vddin_3v3>;
+			vqmmc-supply = <&vddin_3v3>;
 			status = "okay";
 		};
 
@@ -63,6 +65,8 @@ sdmmc1: sdio-host@b0000000 {
 			bus-width = <4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc1_default>;
+			vmmc-supply = <&vddin_3v3>;
+			vqmmc-supply = <&vddin_3v3>;
 			status = "okay";
 		};
 
-- 
2.43.0


