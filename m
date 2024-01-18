Return-Path: <linux-kernel+bounces-29870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC318314A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64CA1F24B83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9D12D619;
	Thu, 18 Jan 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+ewpRq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E1D1D523;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566180; cv=none; b=WusmlIl+j2ox0ZTs/6plpm4tZOy5VP/gr6JjZuoFcEgJo7W+XYn0HCH5uM2wqf3iuGHalvW6AItB6E5FAe8kKGjl0tMlp1qUhuyqawIFjNYSR23234AU4wWekh/32SnhpfR2mFHyO+Y5LBRO+4p8lJPSY6tTauEEjBq1l1Zp6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566180; c=relaxed/simple;
	bh=VNwPggiAWASAvwqtJd7Wj3ItapLp0dhIgz2LnHUWvFk=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=ArmRXcMXJs8ZvE0VCWvUIhLfmHJDcniGA1IkBwjvrFWyus9Lud4LTcg3H2JGQ1PL73S9aSrItP41X2m4N1+jKS7QBiNELtB4j4zYCJigMhS+EbmGc3lBWpWUo8Cp/tUNydCKN6jS2eh05vEz1OGtAlPeloMctZfef2wKZWY5A90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+ewpRq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 629AFC32788;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=VNwPggiAWASAvwqtJd7Wj3ItapLp0dhIgz2LnHUWvFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D+ewpRq6K8wILjZfFINR6hAdifU2HaoAq1iXuVPcWEXN9WA0+3+v2TnGpjUwxpdIC
	 JXPY5xGRCuBYYAnm/oDBaKLR4AVlv2PJ3ufnpsiGnTy/ENkmi+CSvfyXnXNw9XuSCW
	 kme8j2QwJ5xifH8nfDr5v7YWnVbnKGfTAMNQohj6uemh3eEVdNklUy464/vhftdP2b
	 EH1dJ/h5NPN4Z/z66J3MWLWlnVbvKMUBLv0PkhZoR0fvOYJh0Zu8YqN9mqiXSmZkj3
	 w5bI5UDkFRwCBrzowJIAqASAfbk7Ll83ENty4A9vNs2SMMdwt+kaUz6yWaQ5MnCSQ/
	 bdP0d55/X3Z4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D6C47DBA;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:58 +0300
Subject: [PATCH v7 15/39] dt-bindings: spi: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-15-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=2297;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=eohxXtWd+HuVJyaYSL1l5VkylPnLSM7yKMq6Kko41cI=; =?utf-8?q?b=3DmQEAzOl0farN?=
 =?utf-8?q?UBOtQn1oFUwbsWSBvXpWyIzo2LRm1bY+NQ44RN23AdgDMS4sHHq6raOv6H7eGnBD?=
 u+2WVGUeC2wEmOduj6HYui1r6p4DawPP2QkRJ3WPS4qdrqN0tRXf
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC SPI.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml b/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml
new file mode 100644
index 000000000000..73980a27dc00
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cirrus,ep9301-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EP93xx SoC SPI controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-spi
+      - items:
+          - enum:
+              - cirrus,ep9302-spi
+              - cirrus,ep9307-spi
+              - cirrus,ep9312-spi
+              - cirrus,ep9315-spi
+          - const: cirrus,ep9301-spi
+
+  reg:
+    items:
+      - description: SPI registers region
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI Controller reference clock source
+
+  dmas:
+    items:
+      - description: rx DMA channel
+      - description: tx DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    spi@808a0000 {
+        compatible = "cirrus,ep9301-spi";
+        reg = <0x808a0000 0x18>;
+        interrupt-parent = <&vic1>;
+        interrupts = <21>;
+        clocks = <&syscon EP93XX_CLK_SPI>;
+        dmas = <&dma1 10 2>, <&dma1 10 1>;
+        dma-names = "rx", "tx";
+        cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+    };

-- 
2.41.0


