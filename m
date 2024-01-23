Return-Path: <linux-kernel+bounces-34901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D21838903
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D421128CC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7058AB0;
	Tue, 23 Jan 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y5KIZMf6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4256B9C;
	Tue, 23 Jan 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998774; cv=none; b=FQ+nXaYQx2Kd1dHKj42InQGbbxZRlnlITYfl9cQMTrjOkJvhAyx7XZL+8G55dPS36J4HwinKkMbSzxRPb8bMy8fd3+PJ+zj/wLuG9BVpBRV9LLS6WrlwI5IfhdSrHzD9kXQpG1mIN9kgMhFT8T2Nlcs3Pz5yGHpAA7eJZhz82Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998774; c=relaxed/simple;
	bh=ChWIh4zFj/VU/lfwD0i0RC4p2o1gvX7c5gjovcHKGkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9IoiSKBM48E2gqMByeFzferuHFC76WEOSCsfWEebcAny0I78tg2nR9kjdVw0zTrwSJw6Ukid582ZCVsneQ2TIwEhgdcvNFlH6tUfZ44WKsh000zOKPU64lC+YJw7KgpQq09bdqZXeAIFxKTAbI7yVrkQhR9J/wXXUg8T7JcTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y5KIZMf6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998774; x=1737534774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChWIh4zFj/VU/lfwD0i0RC4p2o1gvX7c5gjovcHKGkE=;
  b=y5KIZMf6uZJ8PK/4IzfOU1IYUX/Vv1ndlf/x7J3hbMscaFYSbSL9sXHy
   E/R88jRU7ybHBmqkDpUJL298FMUdokDEjKSzAg+JHRsYXFj2umkWg7her
   tbbMai2OancbWfbHUNk59/gj0HYjUtlNEtCYCD7jGQUtZ/09VFlObNUiW
   zjRSUkrihJW16NPY8Ez9iB6oJFQNiIpUpdhGmx1pS5tiH2lqj3yItQEK/
   sheC2uVTXYFH9lP4DJxOXnPsSCmJJkHxKE6tFzHt3BnCsX5be1v9aPK/q
   LyXGRjzcAH2yhT+5QB6bKzQ9j8zxTshFHJUtLqRl2FHqo4STRayuibMvv
   A==;
X-CSE-ConnectionGUID: 8Z0MiRbqTTiGlgq+aKWHzg==
X-CSE-MsgGUID: NXlaDv9RTM+95oqmGR1owg==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15154461"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:31 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:29 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 3/8] ARM: dts: microchip: sama5d27_som1_ek: Add power-supply properties for sdmmc nodes
Date: Tue, 23 Jan 2024 10:31:53 +0200
Message-ID: <20240123083158.7339-4-mihai.sain@microchip.com>
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

The sdmmc0 and sdmmc1 controllers are powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.

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


