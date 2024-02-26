Return-Path: <linux-kernel+bounces-80646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D8866AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6A41F21414
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7F381C7;
	Mon, 26 Feb 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk6dZav7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D21C68F;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932682; cv=none; b=MdAM2l5EtrlWTAa9kQ5ZKb+hHZSZO8SjnYymO1IkA5WiSoPfuC97fQZuYdUOvC7AWfio1CdDS6FAgzmMd3yMpJDs/Kibeqq8LB7o7fvEErhcRaP1BY2RFSwe6gFEQ62q9E5LvJF5Slfb/GEa/5qFUlkYwJoMClB4pTuqPvmml2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932682; c=relaxed/simple;
	bh=a/cZdGJuuVrU9Ek8D9oilewhzZsfNMnr7caWbQucbUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KW1nWNRYhAR+ZzzxtJuxVzNcI2GblUjM3VeN2N4nYKkQTS0Eo/oqqeGJNt6vZSJubzjfrEkQ/s+q+KTVbtF0NXQXRYZ1wJbN/9+/Iy6JS2uCyWjYfU4wSyY2sgrXxtWboOWmOeppOJGD7IQ/p1Ru1pdtBTNq8GXRtjzJ2ekce74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk6dZav7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7613BC32788;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932682;
	bh=a/cZdGJuuVrU9Ek8D9oilewhzZsfNMnr7caWbQucbUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qk6dZav7s+A4d4CFww9p6Nr/0MUU5i+MkPflCQdHaNEZrQmjwQFMJRzcE1oXjN3V/
	 OEvb8Q5craw+cu0aRdy6nbdLoTe8RQmwW6cH5r+cNnifcftX7/m7633sm673KH3r16
	 JKkEflbYrZlQKbh3ZbDBwp5jWm2lSRLJ0D7YftLJ5NPtbKXNf/w+x+7nZI/w6AeFVu
	 9RFQ8jI4zSxj1eyGXlZdJFGpI5qhjk49HKyOHfSCa2TFIpaeExP/k1yJi6MtSyRj3k
	 bNSSxlgVDdhFxWTxfbQT6haNbvA4r2/ELKysoeJ+YPJc1VGLn0KV21gej/r7eGl637
	 nLUvhR1v97vNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F1EC48BF6;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:08 +0300
Subject: [PATCH v8 12/38] dt-bindings: pwm: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-ep93xx-v8-12-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=yiCeIO46pBt38m6arFX6dYafL64TrLSuKy+InISqKkU=; =?utf-8?q?b=3D/ooglb4B595l?=
 =?utf-8?q?y1L082Ry8IkNCo2FqMyYUuZBjAA4pBKqQuMeqXfwyaDAqC2zLCdk67XIZ0r7Jza2?=
 bx0wekPRCzRkP5IVJgjj/p3YFFBPCcoQazlGDwGnviUNI/OWl5ha
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC PWM.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
new file mode 100644
index 000000000000..903210ef9c31
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/cirrus,ep9301-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic ep93xx PWM controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-pwm
+      - items:
+          - enum:
+              - cirrus,ep9302-pwm
+              - cirrus,ep9307-pwm
+              - cirrus,ep9312-pwm
+              - cirrus,ep9315-pwm
+          - const: cirrus,ep9301-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC PWM clock
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    pwm@80910000 {
+        compatible = "cirrus,ep9301-pwm";
+        reg = <0x80910000 0x10>;
+        clocks = <&syscon EP93XX_CLK_PWM>;
+        #pwm-cells = <3>;
+    };

-- 
2.41.0


