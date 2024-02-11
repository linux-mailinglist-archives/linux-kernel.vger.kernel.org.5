Return-Path: <linux-kernel+bounces-60685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4580785086C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBA91F22865
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD15B1FB;
	Sun, 11 Feb 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="chTnrOBR"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860C5A783;
	Sun, 11 Feb 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644834; cv=none; b=YVjeQlIoDRJUbpwcunlEO1Dkij00XQry2cPqwDasGPaB+/uil/N0EQ8JJvoS8+m6c9S1Byz0OMQDo2Yij2j4eBnu+Aagh0wmrmm+ds6OXWbrrTBLTDDIfS2uC8BgOyDwHXUw3oujXQPEX0o04GKcQtWfbdrWvKT8RpQuy1oaixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644834; c=relaxed/simple;
	bh=qlxK3V8iY252OYXK3GmlZOxqgQ57vkFcttu1E+sNo7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUHoEPJEPE05rJk/nEd66It6W88n4N4BLB9SElz0APEJKRDHG8b2NdQfg+fvYqiYTqB7melQDU8th/oKIs1DiSg+2ISgvCKbwy+we+f6YMBQZoBcyt7KV1WZ9b00zCjCSMA8k7F2UJwaPxNoWsayal3sRD39GnkP79jnJiO7enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=chTnrOBR; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 44BD32811B8;
	Sun, 11 Feb 2024 10:47:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707644830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BguGd9R7zZ7M/zM8GgMF1+0YlSJZlEYRVRZknmzkF0=;
	b=chTnrOBR3DgIBtV2SiKOL3u3RLbtHlVFL31O1ZUfRFWovQmMynpAJ5iMPQ5nqnLGjD6cS5
	mzTWNEyUn35+kxxIlvNFHxwLCgjcI8Q4hc8G6p3J2j3D87nBBGOY0fnve6di1FiURP+QNE
	NwJ6TiW8TKtuS7y77WymcV43nat8kWE=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 20D3F457E76;
	Sun, 11 Feb 2024 10:47:10 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v2 4/6] dt-bindings: input: add entry for Marvell 88PM88X PMICs onkey
Date: Sun, 11 Feb 2024 10:35:54 +0100
Message-ID: <20240211094609.2223-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM88X PMICs provide onkey functionality -- add the bindings.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v2:
    - Add wakeup-source property and reference onkey schema from MFD.
    - Reword commit message.

 .../bindings/input/marvell,88pm88x-onkey.yaml | 32 +++++++++++++++++++
 .../bindings/mfd/marvell,88pm88x.yaml         |  8 +++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml

diff --git a/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
new file mode 100644
index 000000000000..5d3d451d0e1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
@@ -0,0 +1,32 @@
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
+  wakeup-source: true
+
+required:
+  - compatible
+
+additionalProperties: false
+...
diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
index 29ab979862d5..2507a73d4dc3 100644
--- a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
@@ -28,6 +28,9 @@ properties:
   "#interrupt-cells":
     const: 1
 
+  onkey:
+    $ref: /schemas/input/marvell,88pm88x-onkey.yaml
+
   regulators:
     $ref: /schemas/regulator/marvell,88pm88x-regulator.yaml#
 
@@ -53,6 +56,11 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
+        onkey {
+          compatible = "marvell,88pm88x-onkey";
+          wakeup-source;
+        };
+
         regulators {
           ldo2: ldo2 {
             regulator-min-microvolt = <3100000>;
-- 
2.43.0


