Return-Path: <linux-kernel+bounces-54848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2184B46C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917911C234FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1946131E27;
	Tue,  6 Feb 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SsFesPqG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA3131740;
	Tue,  6 Feb 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221023; cv=none; b=C1Gl14/Bq7TBmUSfpQLrwIuMhQRG2JZuEBqr4IUDCGUq/ApDMN41e4AEofnFocw1Sv6IWhb2EsmuJRKBbZJxcp78qCxbrkUWvr0Ax5vLFhyWy5y0OLEyjhBBoImjz7gtSEEvVPzV4/J8wYIn3RUrRN7sfI2qAVC1WTdr3hTeMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221023; c=relaxed/simple;
	bh=VmwScpVHyOuzrgR8x+aZIK2YdHWWkhRqBsdSL/vjAe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhJgi8YcQ30AyBgRymQrYDZWlEaRL4XmGHIJXCrn+mrIohgiQouMTzkKOULWSBsWJ2XyShGEhRRqAv+YbJRueh02n0TIQOvcRV3SFP+pHDXLm9LFtVDBy/E2TOcqOaz8I08dxSUtcfLkbgOGwLIeYG0fW3PCYxaWfIsN+QKdgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SsFesPqG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221022; x=1738757022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmwScpVHyOuzrgR8x+aZIK2YdHWWkhRqBsdSL/vjAe8=;
  b=SsFesPqGV/7Q8o38d+Vn5XtIzNpuyKbvloR8DY6GbD4Zzg+JyCWqkJ4N
   y/Uo5Gy/bkW5jlhjdpW8XQHRB4h35+M+2iwSZnfgNj6eLHhBhPSNH8VAQ
   DXKUeNcLMz/GT+gm5VPyIkSiuxIxUNeCf/vT3Zgnis20siBU0O/ZQs1ug
   XJ8+O1YmMKPX83l14QC9J6PeTx4dYQoBItJ3AVZfrVW5dCKTlVXEapWIH
   eFsmoCwq5rIkjcdLQYd4ut6IoTcp/BUym/3OWJLXA0eE+Ebh6AbdC4RaO
   gd4AayM5a3mm82f20rsI/dGjLDyfYU6qrK5+K0WL5mWdejlGrnxi+6k+H
   Q==;
X-CSE-ConnectionGUID: yTxsI0ESSbahg8PzMhJ7Cg==
X-CSE-MsgGUID: A3M+K6MoTJ2txepBP4p0iw==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="183097593"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:32 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:30 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 1/8] ARM: dts: microchip: sam9x60_curiosity: Add power-supply properties for sdmmc nodes
Date: Tue, 6 Feb 2024 14:03:15 +0200
Message-ID: <20240206120322.88907-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206120322.88907-1-mihai.sain@microchip.com>
References: <20240206120322.88907-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 and sdmmc1 controllers are powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.
The sdmmc controller from SAM9X60 MPU doesn't support the
IO voltage signaling/switching required by the UHS sd-card.
In order to use the sd high-speed mode, keep vqmmc at 3V3.

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


