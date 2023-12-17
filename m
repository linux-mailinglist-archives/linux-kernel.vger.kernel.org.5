Return-Path: <linux-kernel+bounces-2603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA3815F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2143B22274
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08B44375;
	Sun, 17 Dec 2023 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="n50GR606"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAD44374;
	Sun, 17 Dec 2023 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 196CA28C344;
	Sun, 17 Dec 2023 14:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1702819236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eb9PVlKyWd9Gv3amt/ROTpeJ3I3AAA7g4+9KAFbwvF0=;
	b=n50GR606JCxk3wTlY6K8oEcsHsL5WwJN+ynH18c4+9esFAs7FIxEXCGVR/ZdMfQE65is0d
	Zd7Gc98o2TRutKx3cx8SPH0ZytCT5Vk7291TX0a3dTSd4bdgPkNXpOB/B0MuNSVqwYxjLe
	mmsYForXoLgITl62li1r9Hvd3aeWfkw=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id E960644AF99;
	Sun, 17 Dec 2023 14:20:35 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 3/5] dt-bindings: input: add entry for 88pm88x-onkey
Date: Sun, 17 Dec 2023 14:17:01 +0100
Message-ID: <20231217131838.7569-4-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM88X PMICs provide onkey functionality. Document it.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../bindings/input/marvell,88pm88x-onkey.yaml | 30 +++++++++++++++++++
 .../bindings/mfd/marvell,88pm88x.yaml         |  4 +++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml

diff --git a/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
new file mode 100644
index 000000000000..aeb7673189f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/marvell,88pm88x-onkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Onkey driver for Marvell 88PM88X PMICs.
+
+maintainers:
+  - Karel Balej <balejk@matfyz.cz>
+
+description: |
+  This module is part of the 88PM88X MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml.
+
+  The onkey controller is represented as a sub-node of the PMIC node in
+  the device tree.
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    const: marvell,88pm88x-onkey
+
+required:
+  - compatible
+
+additionalProperties: false
+...
diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
index e075729c360f..115b41c9f22c 100644
--- a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
@@ -50,6 +50,10 @@ examples:
         interrupt-parent = <&gic>;
         interrupt-controller;
         #interrupt-cells = <1>;
+
+        onkey {
+          compatible = "marvell,88pm88x-onkey";
+        };
       };
     };
 ...
-- 
2.43.0


