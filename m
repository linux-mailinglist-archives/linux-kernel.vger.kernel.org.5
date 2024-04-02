Return-Path: <linux-kernel+bounces-127617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424C894E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465501C2152F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1733058236;
	Tue,  2 Apr 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uCAfurDR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592256B8C;
	Tue,  2 Apr 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049333; cv=none; b=pNFqd2hvUojIu3QOf0JKx0WMqlzvow3yEeSTLaqfGCJtrLvKtt6shHgGeFz+rNUtQqKjsOx8n4tQ6QRjtAIfurKLwlwqQYPmbT34Iiku6BkX86Y+6htNQ5vy9Qj4Wqr2DDpnUUJAa9J1VWvc4PZVLq+maCb/KIlc8amkwcIpVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049333; c=relaxed/simple;
	bh=UeQLeDr70a3ljkig4FVMOaSWhJyxc3bQI9tRisg44XA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zj9mOzBc4RkTizkW1caEZP8qFpNIKU506hNRoGdxiOrNVMxYrtzlnY+0ylsfBsYlkN2Q/Tw44zl1olFx4rtzO56ujbINVWEHQw3thpH0jv/FmYD0fLYFJoKEQIDoUYD9D4onF8G7Vgr9q976LyGcdzQPD4tt2vXMGhKs5Qwrs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uCAfurDR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712049332; x=1743585332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UeQLeDr70a3ljkig4FVMOaSWhJyxc3bQI9tRisg44XA=;
  b=uCAfurDR2kL48233xX2KXshxPOyg+REk9LKmSQSsVLSrm0J7WIjy+Am3
   0YNTduVQvHNRT72UhKApR+GPxGzSloTMmU+Yt0LvGkeg1JBkRoQHksqw9
   wfeBvHlgLy96YWIk3RWTtvR1VV3bDqFOvZZBsyJy83kGzzqbE2qiV++eD
   ibBXTf5ehF3yQW/KLRhC6tm9b2zjXsJ4+XPOTmyQRraomKA2pezaTMz+t
   +Y/6NTT1mCHw/h26iUYTNOqadlUUslRAqIsBrsS4YzwulFLB1hc5XEd3M
   E9pZmnmtaVWtqtH/QJpdPc5frv/pLDpe428Ju+vpfb16f2n30/db+r8/g
   Q==;
X-CSE-ConnectionGUID: zFoxbXw+T1mGEU4GLhIt2g==
X-CSE-MsgGUID: /vqn4v3ESrGT/2xXtmBRqw==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="249915458"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 02:15:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 02:14:59 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 02:14:56 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 2/2] ARM: boot: dts: microchip: at91-sama7g54_curiosity: Replace regulator-suspend-voltage with the valid property
Date: Tue, 2 Apr 2024 12:12:28 +0300
Message-ID: <20240402091228.110362-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402091228.110362-1-andrei.simion@microchip.com>
References: <20240402091228.110362-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Replace regulator-suspend-voltage with regulator-suspend-microvolt.

Fixes: ebd6591f8ddb ("ARM: dts: microchip: sama7g54_curiosity: Add initial device tree of the board")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
index 4f609e9e510e..009d2c832421 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
@@ -242,7 +242,7 @@ vddcore: VDD_CORE {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-						regulator-suspend-voltage = <1150000>;
+						regulator-suspend-microvolt = <1150000>;
 						regulator-mode = <4>;
 					};
 
@@ -263,7 +263,7 @@ vddcpu: VDD_OTHER {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-						regulator-suspend-voltage = <1050000>;
+						regulator-suspend-microvolt = <1050000>;
 						regulator-mode = <4>;
 					};
 
@@ -280,7 +280,7 @@ vldo1: LDO1 {
 					regulator-always-on;
 
 					regulator-state-standby {
-						regulator-suspend-voltage = <1800000>;
+						regulator-suspend-microvolt = <1800000>;
 						regulator-on-in-suspend;
 					};
 
@@ -296,7 +296,7 @@ vldo2: LDO2 {
 					regulator-always-on;
 
 					regulator-state-standby {
-						regulator-suspend-voltage = <3300000>;
+						regulator-suspend-microvolt = <3300000>;
 						regulator-on-in-suspend;
 					};
 
-- 
2.34.1


