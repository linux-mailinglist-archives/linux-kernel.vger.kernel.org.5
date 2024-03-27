Return-Path: <linux-kernel+bounces-120654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B188DB11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369CEB22587
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE44DA0D;
	Wed, 27 Mar 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yMfzIvui"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DC48CC6;
	Wed, 27 Mar 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534678; cv=none; b=DxIu5rrvrpQnioOqLSblRPL2cl5FzoP7WopzqKy6QdLD6afvvECRQwmblIff5jkInSKaI0h+g8fGzUcbLgLTvnrgJNra2KLAbHBl8Ei5f0dSHSctBaALZP7F4Zbs3y1fQGm7X637AZMTLMyugGfD0WlGlX8TYe7T+Ii5FOkaAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534678; c=relaxed/simple;
	bh=qGQzK2HQjuc3lmiDwa/yoDUO/mDYIMap2INX+scvIhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEB5ao3dFEcvtbffx25WD9cl2yFoNAI1ryEIKa9ntr9vtAFWTAiW0H/tPxchCKi6B2CqR5hFTN6RQROJTXaOEXSI+BH2KW1TfpUyPxAH4rmCDy3/4GsKs9Obqtx9LQr0LvDqsDXsEoEefN1mIQ1VN+Wfy165tfrLq+1IgDCK09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yMfzIvui; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534677; x=1743070677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGQzK2HQjuc3lmiDwa/yoDUO/mDYIMap2INX+scvIhg=;
  b=yMfzIvui247bXPx1nV1yWEcSDjhtBj/LRDDqMVdrttWfG8Ti72M8PpW8
   eskpN4y15rEqxggA4pMI7GBC0Xx/tLGgkDgtWq4LpX+lVEyCjnVv+QuLK
   t5638tADsZugKkC+PacDQB9W+w+XY9sU15OhwdWyvciH6nQHspv5X7niY
   EBZsXfrwf4n8tIdRRXnOVg96NEmoTIhjSivgXgrpfSVz6Rnnyyy+v/2b/
   d0RMUb/fyn/mR4/imt3zj81G3tKURp4OxIW1yFUMxY5VL9rm1BJmRXC2X
   w76hvs+9uD1IlRypjQ43Tz4okx/luqsqOnFi5p2sf5iiHRM/8nbqdKgJl
   Q==;
X-CSE-ConnectionGUID: b4HGw/1yQ96q2nlL3B/feQ==
X-CSE-MsgGUID: shiuTOidQVKmgZzt/ZcQTQ==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18378633"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:17:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:50 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:47 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 4/7] ARM: dts: microchip: sama7g54_curiosity: Update the node names from pmic-regulators
Date: Wed, 27 Mar 2024 12:17:21 +0200
Message-ID: <20240327101724.2982-5-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327101724.2982-1-mihai.sain@microchip.com>
References: <20240327101724.2982-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the node names from pmic-regulators in order to match
the datasheet and driver namings for buck regulators.
Using BUCK1-4 as node names is consistent with the node naming rules.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
index 4f609e9e510e..a83a6fd3f5fa 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
@@ -191,7 +191,7 @@ pmic@5b {
 			reg = <0x5b>;
 
 			regulators {
-				vdd_3v3: VDD_IO {
+				vdd_3v3: BUCK1 {
 					regulator-name = "VDD_IO";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -211,7 +211,7 @@ regulator-state-mem {
 					};
 				};
 
-				vddioddr: VDD_DDR {
+				vddioddr: BUCK2 {
 					regulator-name = "VDD_DDR";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
@@ -232,7 +232,7 @@ regulator-state-mem {
 					};
 				};
 
-				vddcore: VDD_CORE {
+				vddcore: BUCK3 {
 					regulator-name = "VDD_CORE";
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
@@ -252,7 +252,7 @@ regulator-state-mem {
 					};
 				};
 
-				vddcpu: VDD_OTHER {
+				vddcpu: BUCK4 {
 					regulator-name = "VDD_OTHER";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1250000>;
-- 
2.44.0


