Return-Path: <linux-kernel+bounces-52181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AFF84950B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39781F215A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD2D125D9;
	Mon,  5 Feb 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I3LbQct9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB30111BC;
	Mon,  5 Feb 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120258; cv=none; b=OkRyYYyfJ44niAwH5PY0UdWxo/O8+nhEByFq6HQ1oSkuL/2gRoIxxHSieuhgOv2FbEYa8TlMj7VgYlk6l515sHFJRa1P2867xmXsaCwsnEQP9DWc8d46rhu66IG+MxVpSQCHP80m+ThkkS535HJGCRUvJTMujZiiVqWTgKe3Vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120258; c=relaxed/simple;
	bh=HrSglZUZ2hoVlELPp8le9uE4ed0TrBfvyUw3oAEEASY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4vvYaAIMgbeU4ieLa+wi2VOXiBISg+tL5CdOF/SmgDf5fmnvskR4uc6d7FfHm+zs954T+SZomWFjK7sdZqEeIV9L+IHN6uxYiJ5aUZdoVo/+kvKnWUMrmjTuITurlhUpbH2BGso0oozUDQ0YYcSXmMrJsx5h/BoS85mAfueZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I3LbQct9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120257; x=1738656257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HrSglZUZ2hoVlELPp8le9uE4ed0TrBfvyUw3oAEEASY=;
  b=I3LbQct9gHSHXzyfkV/inXLfdffpnzzQxmABJl53KFA73MuXPYmzTJHc
   EXhI5I75+ZDMjhy874ZjdmcLGE28DYsbE/2ScUZEps8U/by9y/tXeMGNC
   4bjMx986FrcTrXkIh0TyMcJJ+cO3K2ixJFdOn5cCTXZl6TTjO2yF5lJ5m
   K7qVjhfodyOo1I9vFtOJRdl99pb1GlPOk+HhQCcv/9dkL6watS+44qEh2
   yv93hYbAr1L0+3RJl1kVoh+vaWiGDM7sjCsO4miJpK0CTU3FxSVc6ub6s
   ZI/HSAi2JS6WSnEn/FVu0M3WSTcBTmnPhF5/Zm8llBXmYHJs29H31sMkm
   g==;
X-CSE-ConnectionGUID: /sWzmiszTQ2ztYFgEFabog==
X-CSE-MsgGUID: gizGeysATd2xk8Y1tVVfYg==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278234"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:01:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:42 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:40 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 4/8] ARM: dts: microchip: sama5d27_wlsom1: Add power-supply property for sdmmc1 node
Date: Mon, 5 Feb 2024 10:00:22 +0200
Message-ID: <20240205080027.4565-5-mihai.sain@microchip.com>
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

The sdmmc1 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc1 node.
The sdmmc controller from SAMA5D2 MPU has support for IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by the UHS cards,
keep the vqmmc at 3V3 to use the sd high-speed mode.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..96819ea24cbd 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -368,6 +368,8 @@ &sdmmc1 {
 	no-1-8-v;
 	non-removable;
 	bus-width = <4>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 
 	wilc: wifi@0 {
-- 
2.43.0


