Return-Path: <linux-kernel+bounces-36592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A083A388
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0277F1C292AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7117552;
	Wed, 24 Jan 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="RMUMNm7t"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF017550;
	Wed, 24 Jan 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082699; cv=none; b=m0lB5ZL6uP3+nl0oKq2CBUQHpeRcUHZhYcQufIt78pNCQxESH/sYYIZWYUo/fU/KruIpgpPimhIoTsjA7F0crxmcqHV8YQyU5a97nFf3FsLw9hQy1Uox0Kkub77WF4K3SewBgpIwScvcF8pdpboYklz94+ik2yWJ+KA0yL4TGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082699; c=relaxed/simple;
	bh=kJVxuLKP5/Z88ANSM4+a7AaBGp1c1zLFsdwtovKAask=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfdwTagEyocuuf/bzuSULfiBCyCGA2hAy1F14YV3Mmaz+B+uKoqBvDXeRMH/tTVSszRSKdnxkMey/63nCM9Z99SBZ0FAtFgUDA1vGY3J1Lm453EKx0LbF9gzXCSATiMqImjPnXAAhYQriKb4fNpM6udzCjlXgXBG7x6xav3BqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=RMUMNm7t; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rSY2p-0004kK-4v; Wed, 24 Jan 2024 02:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=Nu73J2+itShKzZjYU3N4YG8o/iU7VMkly5/BSbm9Wwc=; b=RMUMNm7tH6SGzORrmQsu
	wp799NwMnEpKOT4Z1M8rCE8d4UqnLb2WScmK59L6kLKZYxJhWQPNxuUW7J3esudnuFJ3qYDDXvTd5
	Y1GV99kAlUa+f9UZw1ya1oY8DEg/c6cbGFldtA8cRW+7pdzQ8p+ibM1gZAm19jVtO6NNRXxYi8ou0
	SOMJJUwFze+5kzFQr3uQq4zzfMXhH2XsnBCdHYk7d0XQUWlL+dWjZZ+MU8WEA4iVtVtW4J2HOpcoX
	eZJI241Z9uaGax2IIavIcc5PPvIr82SJXiqUvlGivivgf2hwiieC8L4gSfxS+bQpy7jm54qcRHHiT
	Qdc/UCrUB8wNpw==;
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
Subject: [PATCH v5 1/3] dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
Date: Wed, 24 Jan 2024 08:49:28 +0100
Message-ID: <20240124074930.26101-2-othacehe@gnu.org>
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

Add support for phyBOARD-Segin-i.MX93 board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..b6c523d02d29 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
           - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
           - const: fsl,imx93
 
+      - description: PHYTEC phyCORE-i.MX93 SoM based boards
+        items:
+          - const: phytec,imx93-phyboard-segin # phyBOARD-Segin with i.MX93
+          - const: phytec,imx93-phycore-som    # phyCORE-i.MX93 SoM
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.41.0


