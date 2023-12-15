Return-Path: <linux-kernel+bounces-396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59CC814080
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6059A281CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765A3FE6;
	Fri, 15 Dec 2023 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpZxhHXI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6163B3;
	Fri, 15 Dec 2023 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9e2a014e8so210320b6e.2;
        Thu, 14 Dec 2023 19:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702610026; x=1703214826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrjPda46CNMHaH9SYqOgX3QPLKjlJ0qSlmrxZq+XIwQ=;
        b=TpZxhHXIAvo8EZcXiYtHjcw2O5CKKmLGJ0l7b8MbS0qwggd6nuCO0TjNKKQbbAOE0U
         3bbrDEAat+UfrtbiyObRM2RossGzTFB0AEk9l7KzuPToW47YE3/zLbpDduQLle43vQ9Z
         ciAJ38V5T/6lbTHMUNNFk7DRNZO/1pWbQmIb41bf6BgnE/TFxyTsep5U4gyMcyna6n5v
         Cna2A+WGlSuX/3xfVjREDbarVIauAeKZWO3mBDmp/LcpSNEx0oZiU9oyIQdi91Exg8Cv
         Mg02fkvgVS7FQj+v5n+vN1GuaEKaqtTsZqKTBaTs7xyGYzLjBwY/do5n3/GNrwYgQ0zQ
         5F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610026; x=1703214826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrjPda46CNMHaH9SYqOgX3QPLKjlJ0qSlmrxZq+XIwQ=;
        b=I1SJRnVivAwqogXxT+NqPwwXMCrdH1EzcGJCcvq614EOlsML97rwLrVGUZx7ITqODG
         UYBTOWWw/hAyYF0SbJ+qc9gEyfy0SYdLCowi5pJeRWa4c4Y8M4WtV6ww4CbYFMymGTK7
         4HJdLm6rwlPo5cXrq0750T6crbXxYtwSaD41ky7/R/8bnbYsKxvMsdJH4Ipju+gxN7oi
         YZx33b63PTv6+VaijbF9501HqBlZbSQtMLopnbJs/ozKrpaTKYZIwYy38sk0Pp4ifNfK
         bdPXov3h4dyr0JfojlFlCSHWM3t4djbw32nCN6L/4CQpr1a8xmVPKjwDar5sG1oLBlBp
         ucrg==
X-Gm-Message-State: AOJu0YzhgT6HP7s824eopTWmXFLbHBea0KQ/g6wJrCPyTVJY7W7xKZoD
	ghGtmKzgvdOReWuV/BOBGdOK/iTryMkhng==
X-Google-Smtp-Source: AGHT+IEC44kMzx5eGkuNrn9pITFLdJOj4jemuFr/IAUnL/5vawRr/TJNf1sTPngymub1XOrGbyVtYQ==
X-Received: by 2002:a05:6808:448b:b0:3ba:f4a:4320 with SMTP id eq11-20020a056808448b00b003ba0f4a4320mr13005960oib.46.1702610026545;
        Thu, 14 Dec 2023 19:13:46 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:5818:4019:59fb:9ed3:7477:2dc9])
        by smtp.gmail.com with ESMTPSA id v23-20020a170902e8d700b001d05fb4cf2csm13181855plg.15.2023.12.14.19.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:13:45 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
	"Conor Dooley" <conor.dooley@microchip.com>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Jeff LaBundy" <jeff@labundy.com>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH RESEND v11 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date: Fri, 15 Dec 2023 08:41:22 +0530
Message-ID: <20231215031125.284939-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds bindings for the Adafruit Seesaw Gamepad.

The gamepad functions as an i2c device with the default address of 0x50
and has an IRQ pin that can be enabled in the driver to allow for a rising
edge trigger on each button press or joystick movement.

Product page:
  https://www.adafruit.com/product/5743
Arduino driver:
  https://github.com/adafruit/Adafruit_Seesaw

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

---

Changes for v11:
- no updates

Changes for v10:
- Added interrupt-controller/irq.h header

Changes for v9:
- Added interrupt in example

Changes for v8:
- no updates

Changes for v7:
- no updates

Changes for v6:
- no updates

Changes for v5:
- Added link to the datasheet

Changes for v4:
- Fixed the URI for the id field
- Added `interrupts` property

Changes for v3:
- Updated id field to reflect updated file name from previous version
- Added `reg` property

Changes for v2:
- Renamed file to `adafruit,seesaw-gamepad.yaml`
- Removed quotes for `$id` and `$schema`
- Removed "Bindings for" from the description
- Changed node name to the generic name "joystick"
- Changed compatible to 'adafruit,seesaw-gamepad' instead of
  'adafruit,seesaw_gamepad'

Previous versions:
v11: https://lore.kernel.org/lkml/20231127161158.1651716-1-anshulusr@gmail.com/
v10: https://lore.kernel.org/lkml/20231121123409.2231115-1-anshulusr@gmail.com/
v9: https://lore.kernel.org/lkml/20231121101751.2189965-1-anshulusr@gmail.com/
v8: https://lore.kernel.org/lkml/20231108005337.45069-1-anshulusr@gmail.com/
v7: https://lore.kernel.org/lkml/20231106164134.114668-1-anshulusr@gmail.com/
v6: https://lore.kernel.org/lkml/20231027051819.81333-1-anshulusr@gmail.com/
v5: https://lore.kernel.org/lkml/20231017034356.1436677-1-anshulusr@gmail.com/
v4: https://lore.kernel.org/lkml/20231010184827.1213507-1-anshulusr@gmail.com/
v3: https://lore.kernel.org/linux-input/20231008185709.2448423-1-anshulusr@gmail.com/
v2: https://lore.kernel.org/linux-input/20231008172435.2391009-1-anshulusr@gmail.com/
v1: https://lore.kernel.org/linux-input/20231007144052.1535417-1-anshulusr@gmail.com/
---
 .../input/adafruit,seesaw-gamepad.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml

diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
new file mode 100644
index 000000000000..5e86f6de6978
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Adafruit Mini I2C Gamepad with seesaw
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+description: |
+  Adafruit Mini I2C Gamepad
+
+    +-----------------------------+
+    |   ___                       |
+    |  /   \               (X)    |
+    | |  S  |  __   __  (Y)   (A) |
+    |  \___/  |ST| |SE|    (B)    |
+    |                             |
+    +-----------------------------+
+
+  S -> 10-bit precision bidirectional analog joystick
+  ST -> Start
+  SE -> Select
+  X, A, B, Y -> Digital action buttons
+
+  Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
+  Product page: https://www.adafruit.com/product/5743
+  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
+
+properties:
+  compatible:
+    const: adafruit,seesaw-gamepad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        joystick@50 {
+            compatible = "adafruit,seesaw-gamepad";
+            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
+            reg = <0x50>;
+        };
+    };
-- 
2.43.0


