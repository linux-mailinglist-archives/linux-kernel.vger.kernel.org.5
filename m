Return-Path: <linux-kernel+bounces-18451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF44825DC1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7300EB22EE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B315B3;
	Sat,  6 Jan 2024 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqtZuTlk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F76136F;
	Sat,  6 Jan 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3606e15d718so1108245ab.1;
        Fri, 05 Jan 2024 17:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704506065; x=1705110865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKIOfGXdhQzUhUd2ojox1sWrZO2giTBdlXUK8XhYp08=;
        b=GqtZuTlkLtzPfNH70BUT6SOzjw9083zfqibCOMt/m7cPzJ83IVsnmV9oONpl4CXhFd
         nZqKTqr/z5/KUZonhKJCqUVenRytpZHsaluAKsn0SfzkM3AXNNF/cjfLqrDVCnEXknmd
         Pd4ScQcEMWsVX8XhGNXp+jDqFO84xuWB6LDJeBj2XKeYRcl0gF5AnDO4ewLFDOBqN7pk
         3HK97KPVhV4sxZQ99g/42pOmwo4WVIkKakqtW3rGyZndd4AkKy0V15TQBk8acvcbDvx0
         lLswi+fc8tRK568haOHiTsufbeYsJwo/7U7BET3D/hka8+HmZtLIInXj763nRltOXlfL
         NnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704506065; x=1705110865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKIOfGXdhQzUhUd2ojox1sWrZO2giTBdlXUK8XhYp08=;
        b=eVXoLXcmsQEe9xYWLxjReEve9UrAtOVeBSj53yPjV9A8YJ9qkuurdHeE1R+Pi0z3LI
         UkdMaRKauVx8mxP4lUdhoNoiG/7q5TH8JjqMWXC0RAoVOi+ztF9lz38y9fGl7NSWsiKG
         rxEm1vHSu2BGEZGZ5WWtvnVMlPkM0bIvtSGHDeba/c6SPD0ZmZhgFiyuEiF5lJmeoCKf
         e+Fbx+F64NlBZJeS/SBImw5asS8GjUj0Uqpij170f7j5iymGc40lgjCngGVoe8IePCLI
         elp3xMdRTLyO8VGFd6AlS/w/JUMl8fgU1pw6jph94WyXZDBS+M7m2cdOvUqKFqPNyzUz
         FkXw==
X-Gm-Message-State: AOJu0YyBkuaIYR+OxJIYIxoL6C/vX1dr8thzNTzryhxup8brv4/0Ouas
	nA2mnfPxiEIp6u793RxuEoxBrJkPRLwdFQ==
X-Google-Smtp-Source: AGHT+IEQP+gfQWl+OFJEfVt/uhJLdkpkydjSRW5ZSvd7W2R8p1rsKAS5TWfsUOlAruIlATNMcubSCQ==
X-Received: by 2002:a05:6e02:3046:b0:35f:e71f:4c60 with SMTP id be6-20020a056e02304600b0035fe71f4c60mr579038ilb.13.1704506065229;
        Fri, 05 Jan 2024 17:54:25 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:6276:e9ca:df79:30b7:cb06:ba1f])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001cca8a01e68sm2000166plx.278.2024.01.05.17.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 17:54:24 -0800 (PST)
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
Subject: [PATCH v12 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date: Sat,  6 Jan 2024 07:20:59 +0530
Message-ID: <20240106015111.882325-1-anshulusr@gmail.com>
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

Changes for v11,12:
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
v11: https://lore.kernel.org/lkml/20231215031125.284939-1-anshulusr@gmail.com/
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


