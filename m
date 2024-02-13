Return-Path: <linux-kernel+bounces-63740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5608533DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DD328646C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C35FF0C;
	Tue, 13 Feb 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vDJiwtLu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A65F876;
	Tue, 13 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836184; cv=none; b=hR7Mf2vka6NNyqBSSQCgX5rzsmXJIIKNpa0NLE9XqNluHsJ+E/OKehSdODqM111FmTGDHe/NaYNZvY+Sm+Ymp8iv5ITB6wP0xB8Wi0x/4xtWYBC56ltYdDXtcEnnnvwvRXUZWDJ9T4ii47ADMHg2td6fYYXVStMS0GhapMdtNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836184; c=relaxed/simple;
	bh=RjiM0JfM2KTWhltmfpEHtF5jW8QsCCN80yWxJ+GaSxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UixqYEDGIJIJC1KVX0w3cS5jDx/GszGFgaI1aae95nB5iaKn03s/dBbrER4EQIHN3SzSeMM/xJjYcgckUcUe+tafI79aU+7tsh0yYab98Ikk7We1hNdyVrTnr96rr8eIknvosm3Rs1WJzpz0X7//Ghyklly0uvkfTZRaie8G/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vDJiwtLu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707836182; x=1739372182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RjiM0JfM2KTWhltmfpEHtF5jW8QsCCN80yWxJ+GaSxU=;
  b=vDJiwtLuzF/FcbbAQ0+oreo7+gPTzLc6lVXw65RY9YsVPeSyn/t11Vot
   hmN5p6bYrlZvQojYB1rp3xAiYNxHvd2uwXF09n2Th3dNHhtyl++H7v+b5
   /n4mz540zG8Gps1wWINJ3ZJ6q/FBlEvuiPx9edh+sT/xrv5r0rWESSLnz
   Fkm7JrjC4S+Xpqga3w2M0WErn3Sm2WsuBXar+XZH+rtxHDR+ZmBSc27MT
   HCA4P5LKDFT1LRnWOQwMTRSOwSPtpOz7kB1eIRFXu54MavuaHcEZtjKGi
   dpJ6QUTpMnShxNDAEzClt2cg/WJNbierNWhkxKhKfCG/KJUhOoM19CMen
   g==;
X-CSE-ConnectionGUID: notrBuGtRbuSS13mA3DSPA==
X-CSE-MsgGUID: 7tdOdYHBRj2WprxSrsyG9g==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="17608944"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 07:56:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 07:56:02 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 07:55:59 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 4/8] ARM: dts: microchip: sama5d27_wlsom1: Add power-supply property for sdmmc1 node
Date: Tue, 13 Feb 2024 16:55:38 +0200
Message-ID: <20240213145542.23207-5-mihai.sain@microchip.com>
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
Add vmmc-supply and vqmmc-supply properties to sdmmc1 node.

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


