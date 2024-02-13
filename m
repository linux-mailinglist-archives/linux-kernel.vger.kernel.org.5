Return-Path: <linux-kernel+bounces-63743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616C8533E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E996EB21A59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA45FB86;
	Tue, 13 Feb 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IWsl2jP9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405760277;
	Tue, 13 Feb 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836188; cv=none; b=DPHx1RkxgcvFAFwszoWlvJvAZ12YkEx3FNmX7hc98A5iKJlJlWq+ltbqDYErTGjeJ8+v3EjL/9gupu95IC0TGBbc1MfODHv19wucTGMt+fSIbm1VFTsC+N703/nz7+jk32qwC4GBBKyDwnwgo4EebEts1vIP/fJQ8DgPSUcaVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836188; c=relaxed/simple;
	bh=SBoDFMum0CRdYaIkaabj+IssLrqtA1j8841CTgB/0vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3jboB63Z/N7F+IT1K5de/6oe4wriAQ74NJZqG9OuHyzsYvYvrxZzcqj2h5kyAHnWCzUKQw7mNtZxYxETa1eSPpMOH5mSXSxW9JcyA5kR9xduYsLdJSr6kXaO7I0jLQuFHXxTmgbIj1U17kxr2AVLcBlAa3WmZmOzEp9f+3tPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IWsl2jP9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836186; x=1739372186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SBoDFMum0CRdYaIkaabj+IssLrqtA1j8841CTgB/0vk=;
  b=IWsl2jP9/xKsl26Gp547bUtksOdNm7Sbw+nBBjgld+bIdoRiaDZXHU+K
   FqpFOIyuZQv65EmTA/kmWXbxWtnMwX8SLmDFuChiLqi3NPenjUKlxCmgk
   nye3bhf97i4ZJdLyU60L9aDbLoUmBBMOK9elc7Xz5jywryP7AyihYSVLB
   EVfx5UuG7u4T7RmAX5NqrmLTkU2WRhIcundrg0C/FbFdRuaXD7F1GghsS
   lqnCxjLXaxGOoBJ+vzi6Tl0bRy/lxAP75QT6RziFr0I584nrQhpSxbQ7b
   ex/gxtNRMz5XG9NerdpK4IX8Le4+K/d6zlMZPQ7Ss5ocSG6TPSY58W0LA
   A==;
X-CSE-ConnectionGUID: AFpWkw3+TLWONG8YtvDMdQ==
X-CSE-MsgGUID: fdZxdgzFSNWtsf6V6NCZoA==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="183438887"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:55:54 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:55:51 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 1/8] ARM: dts: microchip: sam9x60_curiosity: Add power-supply properties for sdmmc nodes
Date: Tue, 13 Feb 2024 16:55:35 +0200
Message-ID: <20240213145542.23207-2-mihai.sain@microchip.com>
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

In order to use the sd high-speed mode, keep vqmmc at 3V3.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index c6fbdd29019f..457c54dde0b7 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -452,6 +452,8 @@ &sdmmc0 {
 	pinctrl-0 = <&pinctrl_sdmmc0_default &pinctrl_sdmmc0_cd>;
 	cd-gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "okay";
 };
 
@@ -460,6 +462,8 @@ &sdmmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


