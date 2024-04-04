Return-Path: <linux-kernel+bounces-131453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D789881A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0188C28F86E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BF7492;
	Thu,  4 Apr 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tJz8yK+d"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F453126F3A;
	Thu,  4 Apr 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234396; cv=none; b=fIZQYoernOzQSGop4ndLL5is6Yaz6QzI28+7iv/rBpdpDmfsIWVkDRuKMBoK96zB6/dstU4GxLpMJBQW9R+dGDTM7JZjLdD2OFUiUw/ZBQQROdatp81IKDCaDXzKvAf+nsApOBxW716OtOnkD3eJnqgen1mUxINdpZyikTtbWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234396; c=relaxed/simple;
	bh=okufumpJnE51A3NhkMnpi9oPjXpx4OXlynMO97qzAak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R02mnEaMRlRgQT26izbyHZYhhDDqhLykeMfN5Xk7BFG+d2fFljDeaso0ZdTvnNr60W6YzkJZMWgNGWvGM/MXu6XW+i/YwAVlFeYExOntlyas8cglf511fDoqj9/UUBh9GDkUjgq+vyXu3p4qTaQ934Opjt1BJvBO5OHLEXB8gxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tJz8yK+d; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712234394; x=1743770394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=okufumpJnE51A3NhkMnpi9oPjXpx4OXlynMO97qzAak=;
  b=tJz8yK+dmbef1dKfP5PG4snAjnQT9VMP/pq0ofEi+xOL2ARBlSZABwnF
   eV7mB8rH0kcX/85YcCvw8nmZLzj66vt4oWFuJ7OwzbajHPxz8fhvmeUeZ
   mjZoHE0jWXwSm8pezD707gLI1GtoG3/WLoLNCxCn+MpgPY0pq80TRCpTT
   LdOkXpNfkJ7KBE9Vdr7cXRpdTTW6lf+VGGKIGg+P2d11GYVTrjze1Kj/u
   hRQWraQP9rJAIOkTCcnQyhA4GTLgcHdF7Zb1zTQN/kRvKSpH8oWDtJCq2
   GtBf7YQWh/oJgfFwY4R+Va89egMbCMGctxQnUrb5BE3T12uktJ68T4mCK
   Q==;
X-CSE-ConnectionGUID: XiJHr4MDTzOJ0Z5CIVEelw==
X-CSE-MsgGUID: YRbT/4BIRq2+VdNKqi5y2A==
X-IronPort-AV: E=Sophos;i="6.07,179,1708412400"; 
   d="scan'208";a="19998678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 05:39:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 05:38:36 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 05:38:34 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 2/2] ARM: dts: microchip: at91-sama7g54_curiosity: Replace regulator-suspend-voltage with the valid property
Date: Thu, 4 Apr 2024 15:38:24 +0300
Message-ID: <20240404123824.19182-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123824.19182-1-andrei.simion@microchip.com>
References: <20240404123824.19182-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

By checking the pmic node with microchip,mcp16502.yaml#
'regulator-suspend-voltage' does not match any of the
regexes 'pinctrl-[0-9]+' from schema microchip,mcp16502.yaml#
which inherits regulator.yaml#. So replace regulator-suspend-voltage
with regulator-suspend-microvolt to avoid the inconsitency.

Fixes: ebd6591f8ddb ("ARM: dts: microchip: sama7g54_curiosity: Add initial device tree of the board")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
v1 -> v2:
- drop "boot" from title
- put in commit message a snippet with the warning to explain the change
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


