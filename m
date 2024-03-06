Return-Path: <linux-kernel+bounces-94088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE28739BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24EE3B20CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05213135A40;
	Wed,  6 Mar 2024 14:48:31 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05780134721;
	Wed,  6 Mar 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736510; cv=none; b=BWjAAtWZIFqjEglIy/Lr7NHCoAEZkEy/iKLQXjfeyV1fYVkCS8GI/vnBmo6owJ7z4W6A2pNTBxwFk6+7dXaHFdK2hmsaZSSOZBzd8+sk/lIYyvLXmkNpp6vXaIyS71pUMVroIdcbMn9q4MVafyn328sj4v/On/aNG78nBhiOBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736510; c=relaxed/simple;
	bh=vb9lAfGCzgdyZZPDYOO6/i/MkBRkN3itdR6S4zfZ9og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQkBDzzX084p7IuSIC2YsHo5zfzFSbbhwYbUpiR84m3aFB/vA3xu5vGIUiGZUQjQnLAHp7859BrHLLJbyEwblJ/NrSQ9EjCS1W7s/dhqpNeylhKc5sGbxCkRttchKoYkSpjt+EcokZT/TGRXxG3Je0w7JeV5sWdR+oS7ZJkzclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 00348859A7;
	Wed,  6 Mar 2024 15:40:23 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 06 Mar 2024 15:40:07 +0100
Subject: [PATCH v3 2/3] dt-bindings: input: imagis: Document touch keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-b4-imagis-keys-v3-2-2c429afa8420@skole.hr>
References: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
In-Reply-To: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
To: Markuss Broks <markuss.broks@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=vb9lAfGCzgdyZZPDYOO6/i/MkBRkN3itdR6S4zfZ9og=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBl6IBOMsGu5gvZPCCrxOUcNU6lkDKeASrpyk3a8
 bJ+kKpIQ3CJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZeiATgAKCRCaEZ6wQi2W
 4QHpD/0Xs9q3Ree2ZRF15CvMFrp4W65ui7wVR8OwxCLLxJ8rQ9fZkz2UsnfZr1Y4+EJKvypQTyM
 cW7R9Fw38PkdX7BVITCCB4mXmLCmEIoCOdRmhI4PkdBvuFaqgG4anAyrrjhmlY6lNZ+NUmI4oMp
 p6U5sXn/rieWORugLCCS08IerjrA9Pz5swhRlpAVkTwh5GEv/rDDaux7V8IQ4XQ2XHs0GiIuWbi
 K8oE7Ay9NeV4uCaHiq4VJjAdhf9sicu0cA1XaLkYKGXJWUQHL95x5a6erRClpTYPNzOCZnZzV7N
 JNv/PCrnidpoaoAm68aQTWVEfeD8bKs1/hdNqnsuZuLyb1Czm0E/TcUTe0O6L/m+bL3ozqwUjSB
 qMbkQ9b+1tJK3qX2dqi9gZ4+UKo0eVmQejpigf+COWi+sFUSYyYcm9Fsi6yrcNIv6J3quvkuGfB
 ZIErRDWqi0jzc6Cd3Uj3bd1PykY9CnHtjsTZgLabVh1qNbCq46Lq8JMM8LoSUx6wW+1baY7vpCn
 IK4MnSp5WaYwyGxGV1PG8bvNV4mERAy4g18z7j/GzdOeXF5GSIaAYcV/e1BCiqSGlKjMvrrizM6
 AbZohdcMCLFY9PqQTM69ZeEO5voaPkl/Oni5QV17sgwKp3yy5eyFHgwyrlc1k2+6TMhl1iEHxX+
 Zx0WduTMLxlmxkw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

IST3032C (and possibly some other models) has touch keys. Document this.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v3:
- Move allOf under additionalProperties and move if under allOf
- Properly define linux,keycodes
- Fix linux,keycodes constraint
- Change maximum number of keycodes to 5 in accordance with the size of
  the key status field

Changes in v2:
- Allow specifying custom keycodes and document this in binding
---
 .../bindings/input/touchscreen/imagis,ist3038c.yaml   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index 2af71cbcc97d..77ba280b3bdc 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -9,9 +9,6 @@ title: Imagis IST30XXC family touchscreen controller
 maintainers:
   - Markuss Broks <markuss.broks@gmail.com>
 
-allOf:
-  - $ref: touchscreen.yaml#
-
 properties:
   $nodename:
     pattern: "^touchscreen@[0-9a-f]+$"
@@ -34,6 +31,10 @@ properties:
   vddio-supply:
     description: Power supply regulator for the I2C bus
 
+  linux,keycodes:
+    description: Keycodes for the touch keys
+    maxItems: 5
+
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-fuzz-x: true
@@ -44,6 +45,18 @@ properties:
 
 additionalProperties: false
 
+allOf:
+  - $ref: touchscreen.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: imagis,ist3032c
+    then:
+      properties:
+        linux,keycodes: false
+
 required:
   - compatible
   - reg

-- 
2.44.0



