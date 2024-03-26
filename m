Return-Path: <linux-kernel+bounces-118642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3C388BDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850832E6D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E091763FF;
	Tue, 26 Mar 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT4PAQH6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1175D8E1;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=oSyf9Xf9qQyo+/HXABs8/zZpzIAfRu585v2UVND8GciAHUJ3YvAhQGeWgt9A7/fhMZpJpbqeEbjajPUehcJkK/sDsXQEcJno7B1hVDBoQjLej6fDcNRVp+NKOs3DzEZkuP/t0j/ZA6Tj7Gn2iH95b5yUXmNcrE6oI/ofLheAodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=7ExsGWYEQIIInuR7uJ4VrJxxLfA/5YuhSMVK8oL9Zmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9THY5JE0OD4J9xMxl4kN5x60HbjXNuTUk48p5YTlkxMqbYhcvwHsJjoYuFk2g7+7lN4DNpS0tM7YQZsN2+BZPfDp82J3TKlLhub/csfyRQ8GYIhKFEnvZxncJAMmaC1a5CpwHdhCN4E3+dTg0V5Xg2zk1j4qDEGEGIC6kXMl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT4PAQH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E49DC3278F;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444841;
	bh=7ExsGWYEQIIInuR7uJ4VrJxxLfA/5YuhSMVK8oL9Zmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CT4PAQH6iPD0iA/LkXb8H2nlhtEKmdaoaeaZrEsB7949PRhcFuecNaI9whKRd5TXO
	 E3prgRMvBxWtF5X/P0DIopNrTKfIztiFXkpc0GubdCKWbMyZHEVjvV3TZ1Hk9pFdjp
	 F/Dek/rSYgzL80hcmFfW2UMuu1rQiJJE4OBcWaHXog6jV9+gz34q160P31YWYF2Sg7
	 vj+LzHaYx9wMiJ1gOAulVyiq1srAQaWrJpkosq7mC/KSl+DYOzUZGxj5idTKP9Y4bT
	 +dpI/Hh6PSpJuNtxueRA4s0Uf/3ofT4FfyXuKf3EzeiLa9f+WKCUu/IeAmocvsSVGz
	 1Rux7I9ljFuuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B7C6FD1F;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:37 +0300
Subject: [PATCH v9 10/38] dt-bindings: watchdog: Add Cirrus EP93x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-10-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=1622;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=oi1524pxijJgURrfk58fykAJeXaA1N46ukZR7iTBG5Q=;
 b=FpHUmegdhxnoV91FGq5qRysw2a3NDcqHZ+2Lith/TKm2MvPHozojQhycrNcAuCp/Ao2Tkj6nAbfQ
 EDnrg5TkAxRG7DB80wHcTLGYBaCphz6ixJTDSXr5ycnRWX4eS2Cu
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree bindings for the Cirrus Logic EP93xx watchdog block
used in these SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/watchdog/cirrus,ep9301-wdt.yaml       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/cirrus,ep9301-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cirrus,ep9301-wdt.yaml
new file mode 100644
index 000000000000..5dbe891c70c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep9301-wdt.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/cirrus,ep9301-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx Watchdog Timer
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-wdt
+      - items:
+          - enum:
+              - cirrus,ep9302-wdt
+              - cirrus,ep9307-wdt
+              - cirrus,ep9312-wdt
+              - cirrus,ep9315-wdt
+          - const: cirrus,ep9301-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@80940000 {
+        compatible = "cirrus,ep9301-wdt";
+        reg = <0x80940000 0x08>;
+    };

-- 
2.41.0



