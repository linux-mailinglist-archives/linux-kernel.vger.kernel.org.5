Return-Path: <linux-kernel+bounces-54850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C538784B47A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243F6B24576
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B67132494;
	Tue,  6 Feb 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CnNI9GrH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B14132488;
	Tue,  6 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221045; cv=none; b=pOigkDyE/onZRnP5QUrdT4Z0e3ez4lwUE2jDUprWCKKb8HqQP7ZsqSEJFc4iBbbKa5zgtJgVntfBAwdbS+yQ1AKPMYZO7J10kDfVKImXyJFidbZqDxmzaNsYxYUgSp7F38ZOIvZmJDkHdbfiQKqRH2ExwoOQRtF22SLBflel7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221045; c=relaxed/simple;
	bh=X6l5+Qs2evycJatv5Ixx/LdwhPihrwxN901yvlO4cdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/4t2dSvDXO80tpSzFWmwoXEQ3V9r9sZEEPGidg47OHm4p+v0wfFmmpae7zSys6QeO//NJL1HQ9Oguxb06260KrWR+1RWt1lEvnMRHfKf3b5EugAuWKik4Q1L0nCHxe+xpY665uyzCnpJdWGcf0at7hs/4qeyIKz4GAnMlPhfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CnNI9GrH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221044; x=1738757044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6l5+Qs2evycJatv5Ixx/LdwhPihrwxN901yvlO4cdY=;
  b=CnNI9GrHRYVi6d7QdXifmDZfrRcyEOnt7J/2wWNVrNB6xPuihOpRXWVk
   Qkbi8D3xtCbLgHwr+GjLyhBrHk6qpgZF0+B2MJf8MBweZbF188fG+6iHM
   24vjK9lVusxoPQ7+FYQKGVV5Nn18NA4KwKLw9IcSFuDUW+TNqY1nI6TFt
   xWlvtGX6FX16hkQIZTWwOhjHnJD3yhyKrokC2M0b7xI31b9qWkcUxUjw7
   mQpbH9dqdurOXFs8rX+w/vr6rDstSafS3B3uchz4kaIpH+l95oKTdcWs9
   COGJEgVlvDrzAhtj8loOvNw1NbY6zwVc/g2p49NoZsye0/V0eng7K7gkj
   w==;
X-CSE-ConnectionGUID: /iuDP2QxSliEsbGRCUpaQw==
X-CSE-MsgGUID: +2VvTXRxSHWcLM3TzXxUtA==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="17200237"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:37 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:35 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 3/8] ARM: dts: microchip: sama5d27_som1_ek: Add power-supply properties for sdmmc nodes
Date: Tue, 6 Feb 2024 14:03:17 +0200
Message-ID: <20240206120322.88907-4-mihai.sain@microchip.com>
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
The sdmmc controller from SAMA5D2 MPU has support for
IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.

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


