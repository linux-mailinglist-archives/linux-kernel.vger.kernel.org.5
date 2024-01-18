Return-Path: <linux-kernel+bounces-30311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F5831CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFCFB22DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591A2D04B;
	Thu, 18 Jan 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ekV+jGLl"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F292C6A2;
	Thu, 18 Jan 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593198; cv=none; b=oBp04/YvHuUKPft5II5qgaYqI1OnsMtoN31uP8/rSNEvNn+uVg3az7frf0OoGJmyPxTklHE4ip3Yp1LEXwKIktUWm6vyfrTz4f8SFXN2Muu1JQvLqEsHT9LliHcLxnci3BLSJgZUEdI8uG6P7x8RKyMViajmWszDVA8QgSBBYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593198; c=relaxed/simple;
	bh=hVPngzLrOft4GjD0h8gcTwRge8RKvedCq7Cf1gwO4H4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=J/KQZJoE1Yjbl3VqJPKd9ONEPdaYuIVVt+fp3qlyROoFjlwXKtW/Fu/eq3BA5jaw3FOXb/W1xrf33/QcIbfWQn0onaMSjaqU4gMCU62WBk9dS5vmsBjQcOB7irUha58zgv2CpQWaCkRyo7PjWwoZPMjQ79QUfqpnL14LARqK9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ekV+jGLl; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBD761BF20C;
	Thu, 18 Jan 2024 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAEdlk7BS5XgCU2wvBwxRswc1soVVf362uPzbAszphI=;
	b=ekV+jGLlO1bw8v+J3lQFRxXdOTOStANrfR8Ug10ph9KJ0n494ZTd2SbnDEuyVVNBwQX7ve
	dCx9uu0NLE2fFJtv8J4cv12Hkj+Pz9yhsI6fHc+ulRh7QcSNpKbgZg7Izv3xDa5ASTNbz6
	5FWIqUAAZ+Tyox+tO5wUfv3p3miQJMu3mjzm6aCPole9krujrGrsmwE2ICIErQ74qKAcer
	Zyyyn7graVSugJWQY00cE0X+jXja87F0rJGs+PSCG5klOnzbUCyDOtI2Zt0uZEPVBFOEGJ
	Nk+SKkJK/GKVlvOclsMejPXnfl2I89zWi4Rmjkre7U1ClogtElTcdeDFMVj1Ng==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 10/15] dt-bindings: mfd: syscon: Document EyeQ5 OLB
Date: Thu, 18 Jan 2024 16:52:39 +0100
Message-ID: <20240118155252.397947-11-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Document Mobileye EyeQ5 compatibles for OLB registers that are
miscellaneous SoC related registers.

It is used to expose SoC specific configuration such as for example
reset, clock or pinctrl.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c2..c90633460eeca 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -55,6 +55,7 @@ properties:
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
               - mediatek,mt8365-syscfg
+              - mobileye,eyeq5-olb
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-- 
2.43.0


