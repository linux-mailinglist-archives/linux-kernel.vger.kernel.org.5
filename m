Return-Path: <linux-kernel+bounces-80642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CA866AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB3284AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593BA21106;
	Mon, 26 Feb 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3A8H2uc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789BF1C29F;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932682; cv=none; b=p7Ls3wj/RvIJg+uNvXX1xJbXRvOKJIIfZ5G01i7jBnU8b5JpHJI6qIwe6kJ3ypiaRE/KUuyJndGoumdfniEdN+n13gSXkS4N5XX74nmai02PzrvqXZSTWvZVf5G9vroWvV812IqDoJUFBXDOoPmCDX3RVd/6N0VTG07lC6DZfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932682; c=relaxed/simple;
	bh=7ExsGWYEQIIInuR7uJ4VrJxxLfA/5YuhSMVK8oL9Zmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2EVHPdjW3B03iFq5vFPks5wNittXPk4l5usZGohRLFp11w3XykNJbgSc6/VgIbyrU7RGGI5JlYju21BEdfoGyvS3ET5fsaPeYk8Mq0QpVDz0/mBZUWU0gEqjVlgB3lCPucL/64K/owVgCYVjcRjmPuJFaA95uoErx9/vrNCCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3A8H2uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 534EEC32787;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932682;
	bh=7ExsGWYEQIIInuR7uJ4VrJxxLfA/5YuhSMVK8oL9Zmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u3A8H2ucFer+upo5o4YOEeynLtTC6fFvedoAWX/49uzyClKF0dAB8/niZOKGjxMOh
	 9z5tChG3Oxk+I9o3HTe1ZG4EuTxC1NhIPJ7MA5DYQS7qDur8xUTtXjlBSc0EaKsc1x
	 DMA9AM9BHPHYBf6evT3H68i2EmbrqQmLvDLm2j17YM7TUJJ3pz7Uswi7EmGfAT2jBV
	 FIb/TXGxzIM/f57O8Sg77pch185xOZBPqgPX9XPi1mRH+JZaaOWZa62iLle8T9VXyH
	 BWGL96HND3nkLgUA5IUInNEZW7ArnTlVnGSFZeveMWPZG0KIIOXziPxaaQiiF/mn9s
	 FpzYX7djcT+xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3BCC5478C;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:06 +0300
Subject: [PATCH v8 10/38] dt-bindings: watchdog: Add Cirrus EP93x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-10-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1622;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=oi1524pxijJgURrfk58fykAJeXaA1N46ukZR7iTBG5Q=; =?utf-8?q?b=3DYLcbCvc94Tce?=
 =?utf-8?q?yNU9tDxab07Bs5J6NgAYH/UHPVo1fTbt1lJFxXnM4pXw/YSQ3cWu+jxyYAcalHXr?=
 05iB2gdSBmyhYe67LPiqz0Le2H92QW09a5oelT8Oet48QyO+/RIC
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

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


