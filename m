Return-Path: <linux-kernel+bounces-32675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A2C835EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4071C209D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23F39FEA;
	Mon, 22 Jan 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Zw7wu0me"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85C39FC3;
	Mon, 22 Jan 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917217; cv=none; b=GgRPbmNqhG9XPUCViNRCGwWjhwk3VWUPQMwZdPZ2VgJNwx0UxTtK91w7wwdvKVnN932sri/RntzmaYab7CJr3WXpYq2dDQxWPsPVpQVO8LQTvT53iK48vq+J80LdTKVlcqWzdAZ6h2fzVkr2dWwnf2zEq29/fqQX/L64YSg+iII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917217; c=relaxed/simple;
	bh=sfyh7/gLKYxxuboiK3zT/5XmqYjrJvczBUlpB/LH6q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guqx3ximy11B7NW7eJIZXxojFhiIt6pHIQLeSbCX8ZeWBNjFPsdZjayuu7ZNu61Nj4LHhQk4WB+FkwhOE14ql3+oeNxV2WqjYfHsx4XQ1Q781ofJmQ7DwQpFNmXOicLhC+PAHlIppBYpBx1RjU8qUglbrF+OcTTPaYUfUmsLaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=Zw7wu0me; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rRqzn-00048O-8D; Mon, 22 Jan 2024 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=sMwcexRbUI9Js5cFPJsZsAgHJicXn+z+DkE8WWA9a/g=; b=Zw7wu0me4vCUwPXsjsVs
	YLBOyhkRe9C0I32Fqn02h4uOh5g9qknT9vbq7hqpOyquylOOUPqA2y79IrNcTK4oh+iMTb40DKijs
	bYaPXlpXKXpCvTpljk4WEuDlKGlCwwZk25H35m/Fc64yyqULm7t0nrBYMmGK4A4Iyj6rKBLNEHbCq
	8AT87FQ6m/+pb2umrevBa/waWlt0plR9sGXchz+W8WLBCj+/LUUHIxx9LNKSitCzQDy17iIfxieu5
	iCA002RJ7Ps+n2gWIKdLvRrUNLO+4HMEgn06Z589V/7vorrUe6GhU/Pj/+wCt1CHf7ByZtRL+zOEY
	BLO10UrVVFCC8g==;
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
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v4 2/3] dt-bindings: gpio: gpio-vf610: add gpio-line-names
Date: Mon, 22 Jan 2024 10:53:05 +0100
Message-ID: <20240122095306.14084-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122095306.14084-1-othacehe@gnu.org>
References: <20240122095306.14084-1-othacehe@gnu.org>
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

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index a27f92950257..7230ba1a386a 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -50,6 +50,7 @@ properties:
     const: 2
 
   gpio-controller: true
+  gpio-line-names: true
 
   clocks:
     items:
-- 
2.41.0


