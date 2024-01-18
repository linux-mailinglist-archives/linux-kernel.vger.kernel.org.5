Return-Path: <linux-kernel+bounces-29862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD783149C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56011F21A81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0829CED;
	Thu, 18 Jan 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQHFIS2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C38134C3;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=B2kAlTLzLRPlwipwpO0vREOsHbuPWDDKP/7GTdQGYFddDqSy3mCrfoX/944CdyHRACUlHgVEGwTEBAhRyE8aD1eQZ5aTGWMEgEzq1pchaxD2hqwPo/t8fhqkimGjm5A+lAqm+q+RJZ9ZxQ7SHGPL8RRQoF3ZCHnQt1MXqVsZTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=7ExsGWYEQIIInuR7uJ4VrJxxLfA/5YuhSMVK8oL9Zmk=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=f/KG8I+iX1LJw5N95ljK8sc1g8qo4TOMYjSWWoTFJYMAVpBoIlC9X4EcTsTrhlNSf/PsbYwx0Z5tP9lCuNlPWb+aicM0waabolth4mZ1BcO5BdNKLDEBzDYVyUOtzwhPAQ+XFqp6VIDEh3gatWr4/SetF89oY9q1YdEG2dROzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQHFIS2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41DC7C32784;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=7ExsGWYEQIIInuR7uJ4VrJxxLfA/5YuhSMVK8oL9Zmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kQHFIS2QWwUXGe8tpgZ7h55fSUOhH/KLh3cTaeYsd/GNSQ5YmQZOnEdBtuDXjw4lF
	 1p7OkeVuJGbH+viDLDKNt2feyhFeqS9DWXOHVNvbtPTRxaDffT7sOzu45VsAhw7Mda
	 MpvjbqD7hzisI0xDd8bHILZS7yK9vrV34JI/gfy9byM/HnMfOLTgQBgYCf4B0PhdVQ
	 Q7Fp+4hWOvxJGIkMQ6vBvXi7PF3Nw6A8gVNkHEdC94qq84QHjp2wnI4cQmahwWZ9Uz
	 327yAECl5N2XlhJjc+Bnc1I1HS6htpik6RH5PmsDnVGJORp6nzm2itCth1xPSfW57F
	 ZSUuSgW6XhJNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E9C4707B;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:54 +0300
Subject: [PATCH v7 11/39] dt-bindings: watchdog: Add Cirrus EP93x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-11-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=1622;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=oi1524pxijJgURrfk58fykAJeXaA1N46ukZR7iTBG5Q=; =?utf-8?q?b=3D6fwLfHQ1CLeQ?=
 =?utf-8?q?uMjOw2JiupwPVTAvO30vAHJEFVnzSykzd+actCxIA850wTFkpeO3h/DiqsINg/MX?=
 qbT7vwMzDYbP5h3Ba38eJl/9UdKE0KCgT/hSYgNkH5WR4L/5qyGW
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


