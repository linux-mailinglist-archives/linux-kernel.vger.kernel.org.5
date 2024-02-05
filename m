Return-Path: <linux-kernel+bounces-52173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8228494F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FF8281D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ABF111BE;
	Mon,  5 Feb 2024 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1W6pGmk3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8710A2B;
	Mon,  5 Feb 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120073; cv=none; b=BEsMCz7NI+d9kJWXHFWWUkop9zYFUdX2shFy/evzSH36EWzQmITsmW5QH10ps2F/DwybPnHx4IW527n7bTrXg8QZ0leo96F5UgZyVQFBr8X5pFtQI0DiwgM56eJhZsE3/8UWFYN7YqXNiceqr7T2epUamnkPPAPiYsBsluDh8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120073; c=relaxed/simple;
	bh=7Q4k+KbMYr9qx5BQXuGDcYEmnW+RWhVIOI4IF3WHU+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1S0AI+5ltAe3iCuhZ3DsO/eGtOKmIa+CJc9ZNNC1q2b956Bnu6TeECdXSj/UetAjKX+l0r8md6fDIH+6N201P4YZC7R4z8VS/QL+bxIxFTU9dOHtpgkGxsQesfeeeKsq6V5kxYL4gdTwMGNhHyZ1g4DlY3qR2+ql6Nv2UMazQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1W6pGmk3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120071; x=1738656071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Q4k+KbMYr9qx5BQXuGDcYEmnW+RWhVIOI4IF3WHU+k=;
  b=1W6pGmk3/pTu/V7E8qzRYlo/lNIjs3hHaWDxfyI6oEZCfNYDv5oiZ1NX
   eWhp4QLjwUy0fGfup9nTH61+4is19HQvLYIOaXvKSRyNckNCklBqP9Ui/
   9Q+9eGsxfLvr759KGOKLnWJGjEciRjsT3ocDQGKQi+6yzAcDFls9tU3A/
   nmgLTmR8tNZPwqTChNDZKXNlmstk9LXFZ0PWE0FkMsIYKuyFE3zyQh/l0
   bDq4Cwa/fI38cRiAJbzws1Feq3/ezMJQW7KunHAniFDpCxsEa8jcLOlUB
   V8MhkAMXykztAUtUbXQ3o+KD6LW2mFgfOtKj2PVL/U3iJ+xWODZUwL/Bk
   w==;
X-CSE-ConnectionGUID: x3dk9xvgTIiMUicoXpbX8Q==
X-CSE-MsgGUID: C9DbyUXCTfSuqARtpeRZng==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:01:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:52 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:50 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 8/8] ARM: dts: microchip: sama5d2_xplained: Add power-supply property for sdmmc0 node
Date: Mon, 5 Feb 2024 10:00:26 +0200
Message-ID: <20240205080027.4565-9-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205080027.4565-1-mihai.sain@microchip.com>
References: <20240205080027.4565-1-mihai.sain@microchip.com>
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
The sdmmc controller from SAMA5D2 MPU has support for IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by the UHS cards,
keep the vqmmc at 3V3 to use the sd high-speed mode.

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


