Return-Path: <linux-kernel+bounces-125535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2DB8927EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438B4283C83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720113E6D4;
	Fri, 29 Mar 2024 23:50:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9C13E6C9;
	Fri, 29 Mar 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756254; cv=none; b=C0qPznrfRC32KXQII4TYlfD32qBP2rfI0+kuKN+AGQ2TneIk+sPQuJwKEIQ9iXMpTLpExDyjcMzESIFnA3VjCJ4KLZuArjbhhfNvCHUmXzJ4snTKGNON/87EH9CoCmCoRmBcxV2iUG4/9gV+XKxYdrAS7GN/R0Dx4cSLYPGV5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756254; c=relaxed/simple;
	bh=hyYwP6g43NFx0Ni3Qpcz0t9HPdP2ICztnSj/mobD4BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dru2UwiX1h/ssNvcUyxU8a1ShZYrExQjqkEZ59wbDklsxpUhgNK2WoYAXrkBusImdWxJlQo7scoUt9WISCoolp8TjDPQp00dZ82NEumK/7a+zs9jRjF2RcDk2llsU2PfLNplCktINS9yZdEWwfjhAhdZumD/WOgeLcA8k66xgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548E5FEC;
	Fri, 29 Mar 2024 16:51:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C16B3F64C;
	Fri, 29 Mar 2024 16:50:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: add boost regulator
Date: Fri, 29 Mar 2024 23:50:31 +0000
Message-Id: <20240329235033.25309-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240329235033.25309-1-andre.przywara@arm.com>
References: <20240329235033.25309-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP717 contains a boost regulator, that it meant to provide
the 5V USB VBUS voltage when the devices operates on battery.

Add the name "boost" to the regexp describing the allowed node names,
to allow the regulator to be described in the devicetree.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index b8e8db0d58e9c..14ab367fc8871 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -274,7 +274,7 @@ properties:
           Defines the work frequency of DC-DC in kHz.
 
     patternProperties:
-      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
+      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo|boost)$":
         $ref: /schemas/regulator/regulator.yaml#
         type: object
         unevaluatedProperties: false
-- 
2.35.8


