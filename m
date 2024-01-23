Return-Path: <linux-kernel+bounces-34906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C483890D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF6BB23461
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B25A109;
	Tue, 23 Jan 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jU5CfT80"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2255914C;
	Tue, 23 Jan 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998777; cv=none; b=sIxAp1KTIOH8t+FOr6LEHIZTHQXJsC2U9gMTgNCx1P/s/M35C7cgmFBMh5e6bfMOBm+99J4LoDTsoHtgt7kJS/ewG+1Aqr2L5W8Gu5HZ9VwYy5Kex1wYza/4oLMlTOcJsktdUdf38/mfZYl8M8PI4jjymtQoNfWhf2xXhJMr73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998777; c=relaxed/simple;
	bh=w0dxjFqQ8zn2yUDvgz8hDY7YiqyUIy+jKDWe65fPdMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2ZWQ5s7suFKmd3746VYqf10e86Ss6Bs5pl1n5Cp70PpxEkuGeN1RYn24nrWLMgihpwgVOZzwPLlzgDtFUpIcWoaORJtdFQftLb4eR9KJEOh6G7HUNNBGTsd2e34/hui5pTL3/fZCd7Wp1vl2glGepN8UNKSuUsTezaNrKbceBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jU5CfT80; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998777; x=1737534777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0dxjFqQ8zn2yUDvgz8hDY7YiqyUIy+jKDWe65fPdMA=;
  b=jU5CfT80pvQ3H2dova4dI8ykCvdJjjv2VW1Tab3jZrqCLVGRXK6IGtTC
   u54DwoUg16UdzvivzSFaQLm/67Jv4RdYdQTsSySYlPdnuo2pCR61mCcVR
   pTtHt5ve2wnY55nfkPL6AiKR4I/o+vc+rp6MDD/LsSeoxAf+YTxjxGs3q
   CmgyyFj9Hz9J9N7u4mGHBGl+TviO1BL8H0Kh5WbdVjrJBXOWVyVIyT82Q
   H2nMvT0R54H6VUjh2PZkm6w2R8JcKjM/ZzVLAF6Cj9W3cn1XrexG9GMtQ
   CccgdEGZawmzdg2zOia88GyvnvDGRNxIV1JPjA2VjGniE2Ca8OoGp/I1p
   Q==;
X-CSE-ConnectionGUID: 8Z0MiRbqTTiGlgq+aKWHzg==
X-CSE-MsgGUID: cAO7RWtvSVamJ62rejuhUQ==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15154468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:44 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:42 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 8/8] ARM: dts: microchip: sama5d2_xplained: Add power-supply property for sdmmc0 node
Date: Tue, 23 Jan 2024 10:31:58 +0200
Message-ID: <20240123083158.7339-9-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123083158.7339-1-mihai.sain@microchip.com>
References: <20240123083158.7339-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 controller is powered from 3.3V regulator.
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


