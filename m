Return-Path: <linux-kernel+bounces-36593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22F83A389
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434D91F236FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D917559;
	Wed, 24 Jan 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="gz3wVDMl"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9117551;
	Wed, 24 Jan 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082699; cv=none; b=huiVQaaQXvzBWFKr37jASGfjBzwuw9PR2FOxAuPoRQYInMT9VbsisU8FWDpu+ECaKx+uEsp5GLhDwivY1D5QmmqAF5pIhLQi8zTFyaNGnSoa28+3hFHV2/ljgpeNGZRw+b5zbGxS6vA2WRnCyIPBUoG4jFsybZoiAftA56VUWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082699; c=relaxed/simple;
	bh=yQKWOu/POmE1bUSUc18qt0yDGiHz6tD2Q/KqLKBKxss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB/aQm/ZgmMQKCbiEcnI4BOn4NpcETznoL0baRfu4Ez9YZ0LyEnKC9+Oq/ax3bbgIaUv31gZJSXI+gFB7Q77ExtLiTLLellCQSKGtawG1uR6luVa7pt6Y8/KzfxdIxVH6q7sM9fhhPFRln8FYPV5YUUru9YqkOkBSIOKSlwbhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=gz3wVDMl; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rSY2p-0004kM-9W; Wed, 24 Jan 2024 02:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=xp4LpWHmiD34VCnBD4DSzaZA18JuWBr44N4dq87RgeM=; b=gz3wVDMluNbG6UKCjbPw
	yme4KZKpfzoEEDi9UEPhbttNiI7yUv6xoe12YCnEPRgBkru7RBurT9IrQjlMkJk901PodZ+qwpydP
	MaaCcBVLKHK+Eh8koBwmMBLCDPh4Y24DeHegBl37JapjL3QSG5gE0DahIwtj5tIk6+56Z6kob7zr8
	iNGugjhMeGS94xY2ymXWRloClfm3ofpkzf89FNf1Z2WB0WhtOSCDKBnRPh4MFbt2Sw57Iv8rkJf7t
	ChNaxJ2R6Kj8VfNoLQvAHpn94Mb68cMUs/r12HxDjvd/6llZu4GNIuW70M4hzzcez6w+acaf9A3sS
	XSxJk0bxhB9TAQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/3] dt-bindings: gpio: gpio-vf610: add gpio-line-names
Date: Wed, 24 Jan 2024 08:49:29 +0100
Message-ID: <20240124074930.26101-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074930.26101-1-othacehe@gnu.org>
References: <20240124074930.26101-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe common "gpio-line-names" property to fix dtbs_check warnings
like:

/home/mathieu/linux/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dtb:
gpio@43830000: 'gpio-line-names' does not match any of the regexes:
'^.+-hog(-[0-9]+)?$', 'pinctrl-[0-9]+' from schema $id:
http://devicetree.org/schemas/gpio/gpio-vf610.yaml#

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index a27f92950257..2e01f7d47005 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -51,6 +51,8 @@ properties:
 
   gpio-controller: true
 
+  gpio-line-names: true
+
   clocks:
     items:
       - description: SoC GPIO clock
-- 
2.41.0


