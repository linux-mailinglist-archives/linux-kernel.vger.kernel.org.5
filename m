Return-Path: <linux-kernel+bounces-91649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37C8714A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90AC1F21150
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722F405F2;
	Tue,  5 Mar 2024 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duQdcEw0"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC46FB5;
	Tue,  5 Mar 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612494; cv=none; b=bXmc3XmRUpwafB12kWGq+5Hp9VGFMuUInvlVriRIyUjiK2rPnYOf80lT/TqBr7M1rNI09eOCQJdBs1JGLTKN4gjC5oM2r2prYqm+B6Tfof8yTiu6RALHl6YrdnqreftRB15iVeawiTulF8TvdOifO8DW6Bq3tgZLwJeWSvzi/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612494; c=relaxed/simple;
	bh=XNcc3M2gGhOadQxYGKri3cOK2NzoGVpParFwUbKckJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nop9iUD3UCNaEg0m84HrxdbRpKTFl0HixNJgGgNw2nDTe1hLDbC23J9t/jgQyQ58WLHjlbAqN7oZsmDRYzqT+0JJ11RQFZ2qoQ2ZaB1YTbpfljn1+WmVH6rP3mjdSn5T9XzU6Hxhdch+upimUFdmFCuvvlq1zDjbSxyQP+Y7/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duQdcEw0; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7daf957595bso1381659241.1;
        Mon, 04 Mar 2024 20:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709612490; x=1710217290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRPUWl1psjiYGTL8rKAK4A/7PYD7OjCJB+XkBQBD0Ao=;
        b=duQdcEw0IZ6Q4ACahJ+xFvQKlToUAnICFl0oDScz+ctO6pstKkwJb3Vmwuz2B30p9s
         RLHgJ77PtCF/A8aIOk2oerV/x+IO9P2rsAgg466aPtvbpqZcQ95wFM1ho8mByjWTz5fx
         feVrWgAvDI7oDtw4OYrw6gh4dGRLaaJgaQC7Cuz0Sq+b43h+9EXWHDdtRYTpNZ4XdL1G
         vq0th5Mx1yNqnmdydxsTrnOyPjJ9RhJn1MRvUHhbPEPtpZVGJ4z3WL0ApsA3WTFsuwUi
         gtKrzQZtQrzNW15phZ8m9XOQhKC1/gHh8C9IOS6Q5QCJ/eXPwHHXoUO6R08sPF+fbNDE
         k1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612490; x=1710217290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRPUWl1psjiYGTL8rKAK4A/7PYD7OjCJB+XkBQBD0Ao=;
        b=iLy2xQykWJUbomCctelAxoct0gsG7d0pL6B/6m8+ggnWRfvrYrI2h1y4UPAx5/bgwm
         gMq5DMKPz5uNVV9umZGQXoHjZGqR1sjMwoscsfTbZhlzieBuPRp0loQj6e5DOD6rhNZi
         OfeJ125ieMfw9z1hICWOwd/E5BubDiN9tP4Llzs+YQqI7wlea1McZfLdMZqwyBaAs1C/
         yoaMuoPrhe1LFcaDAd3UJ2VvWgQyApNviHWUaj6SY7UObuwTW/u/tPypTb+NYA/XVXKb
         NOFoO6AXNgGKNwLCn8+g0sLCdEodCBqsUYHA5MiWiwHlg/j6JXUgT/lPB9+lQTJ5IorS
         Vj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX89ECZB8kOz5vZQ0xW1s3vceWzy1sGqv2AVVl105/wS3vBuoqks97GuV+sudvcNQ7Y7wChPUT0HzQxPuiK0r89N6OkT3dHidd0yorCaoAaz8yezvIKFg5Vw7gleUXCelZZ8DUgo6yk6rfQwl8mKaDskJmIGXDHD62U0TDUSpwOh3PFSHg=
X-Gm-Message-State: AOJu0YwrrfjWXR0HTdPK/qOpNJ787xp5c0YRQBD4rcX7C02B5KW/MPqY
	6fN7tS/uuyHNesvwtTPOqHZ7gb3k5qtJjvD0ms7/OCfCazhoV7wsqVVRZXcqr4M=
X-Google-Smtp-Source: AGHT+IFT32809+aJZO3E4JHk/VYRjiitNr4MylvuX+RDM7mwKLtk9hToxZj2tWsABLbxlaWVvO9jcQ==
X-Received: by 2002:a05:6122:311d:b0:4d3:49db:6dd2 with SMTP id cg29-20020a056122311d00b004d349db6dd2mr873366vkb.9.1709612490375;
        Mon, 04 Mar 2024 20:21:30 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id mw10-20020a05621433ca00b0068f2b1d9415sm5796018qvb.23.2024.03.04.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:21:29 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Abdel Alkuor <alkuor@gmail.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Alice Chen <alice_chen@richtek.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: leds: Add NCP5623 multi-LED Controller
Date: Mon,  4 Mar 2024 23:20:28 -0500
Message-Id: <20240305042049.1533279-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCP5623 is DC-DC multi-LED controller which can be used for RGB
illumination or backlight LCD display.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
 - Add Reviewed-by tag
 - Link to v2: https://lore.kernel.org/all/20240217230956.630522-1-alkuor@gmail.com/

Changes in v2:
 - Fix commit subject prefix
 - drop | from the main description
 - Use const in address reg
 - Remove LEDs reg description
 - Link to v1: https://lore.kernel.org/linux-kernel/20240208130115.GM689448@google.com/T/
 .../bindings/leds/onnn,ncp5623.yaml           | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml

diff --git a/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
new file mode 100644
index 000000000000..9c9f3a682ba2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/onnn,ncp5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ON Semiconductor NCP5623 multi-LED Driver
+
+maintainers:
+  - Abdel Alkuor <alkuor@gmail.com>
+
+description:
+  NCP5623 Triple Output I2C Controlled LED Driver.
+  https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
+
+properties:
+  compatible:
+    enum:
+      - onnn,ncp5623
+
+  reg:
+    const: 0x38
+
+  multi-led:
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-2]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 2
+
+        required:
+          - reg
+          - color
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+required:
+  - compatible
+  - reg
+  - multi-led
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@38 {
+            compatible = "onnn,ncp5623";
+            reg = <0x38>;
+
+            multi-led {
+                color = <LED_COLOR_ID_RGB>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                };
+            };
+        };
+    };
-- 
2.34.1


