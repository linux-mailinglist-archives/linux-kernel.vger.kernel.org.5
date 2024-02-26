Return-Path: <linux-kernel+bounces-80655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93AE866AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907961F21919
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7D4F5FE;
	Mon, 26 Feb 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDQjC5yZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFCD1CABE;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932683; cv=none; b=Oypst1ZfP7rVp1brKfDCw9U5WdSG3JKK53jbABB3DPFziiUYk051anug3hgW+rNBgf06zj2aXUcuyiq0kut9rv5c22s1Vc+XA0n7tgrVR+gX5b7RVz6H3ORLGAW+FU1pWjIPNxNeZQnC4e54a3qWfOjYmunAYJOTaOx/QujXDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932683; c=relaxed/simple;
	bh=VZtwCtv7tOsROgurA3MD2nAvcBs73kPEENCk7foe470=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ye2NJpcKXF+FN8WbwvWo1RQmc65KyPGoR5Ih/cxV4ZiCcr1T6jieU9X94PF0fMpXep8Dmy8YeAF1Lo9qTKzCi4ewVMHZOcANRl0rYGs4R8VKKtMjOoQYl1NzNYKfSt6S/I7Ym457MQTRDVmPMirZ+F1XGTWUatnxBsEfj72wJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDQjC5yZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0300CC43143;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932683;
	bh=VZtwCtv7tOsROgurA3MD2nAvcBs73kPEENCk7foe470=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cDQjC5yZuZBeJNApZBxThCc9vASF1uWm2bP2Pf+QsIKDsU8x9doWXTO0Poj8rBkaO
	 6fuFrNxgnh9da+4AG3auoJEVvxXJ5YreFLZ4VEDqI2S1ciT+bJSIQcnYAuBcmOuBrn
	 FgWbeGyuu0/8rwNwGz3niuzU8r+J/F5JfEKxDbyNZbDTazfhlIuU3qttasHqMOES6U
	 mfiDSMn0whtxkc7bAGRf+ce7/xh62coBFWwe3hB7V8kbLjzRJroiGggM15FNx1KF/a
	 fDXAoKNejIzIOmOmqiloj8J1acHYX5RyyGEK7eGHi7QUofPDe7P1hluUXaE9fe65rn
	 x+DCCk6tHg4AA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26CDC54E4F;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:16 +0300
Subject: [PATCH v8 20/38] dt-bindings: ata: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-20-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1576;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=Li9/TOkn8mbBPPXaTcEctnQvcEznaH6L6jCP3u/Msyk=; =?utf-8?q?b=3DEEt1c/eRkIAm?=
 =?utf-8?q?LjlK/U1sm4M3oHENHcOUbp8Ezh6zBGubdKNKw6KW8ckFbzaNrug+TggEq1C06Wg4?=
 gnPin58NAS/xke9GA2SBOL7qqoo//me4pKtZ7dA+63JzQ2mrmkEX
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC PATA.

Acked-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/ata/cirrus,ep9312-pata.yaml           | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
new file mode 100644
index 000000000000..8130923fdc72
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cirrus,ep9312-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP9312 PATA controller
+
+maintainers:
+  - Damien Le Moal <dlemoal@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9312-pata
+      - items:
+          - const: cirrus,ep9315-pata
+          - const: cirrus,ep9312-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ide@800a0000 {
+        compatible = "cirrus,ep9312-pata";
+        reg = <0x800a0000 0x38>;
+        interrupt-parent = <&vic1>;
+        interrupts = <8>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ide_default_pins>;
+    };

-- 
2.41.0


