Return-Path: <linux-kernel+bounces-51230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150C848820
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD382B23F90
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285D5FB9D;
	Sat,  3 Feb 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faooK+5M"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B445FB93;
	Sat,  3 Feb 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983177; cv=none; b=er1Gc373C8S83UcqSzV2w06etjEjhuSkaLnY4HVpFTQrV/BdeM4wEFHOKAAGiW+4kh6Q28EFZUvtNpWG9tVCz405krhSMbR4Cy0kKpROa6RloP3hpfTblx/bs1nbXyQvLvyt8MAp5YX7kqabCiCFAci0i/nfs06fWSxHr1e9v/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983177; c=relaxed/simple;
	bh=X0dqCHCvUsMmvnWQGBzFcr3usyZ6WnvrLHaRlsO2s18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laz0j/l1yaERwMuUGagUUQOX8VXrXZYH7SBlgC5HFqblk/np57LrMfjMrxC5kG1rUYONRMVcPlgYt3sxE+C4nd0ccIGxOUhip/2RxCtTkiSjutkCwG6MhMcWyWasEdWZQe4iswocM1vVcNdmuCp8raHJneTdqQtN+YhMl9D8PeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faooK+5M; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so2963029276.0;
        Sat, 03 Feb 2024 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706983174; x=1707587974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRBDbN6U4RNOWRCFFzR1XAeOjrhAG1s6gIx4tBv+f5Y=;
        b=faooK+5MdzXXYg50izQ71D4q4XrTSOvH1e7sOhmWlD2gEWkHyPuPSY/1PNu/CA1/mR
         NAjBEGxDWG6/dNTw/38ThQ4pXmdUXPrFxHKZzyEr/vHMttFCLxdeacy9wNtVpuCJ7/Bp
         Ufwhd2+gbR28rJ+Gmwx75brK+OvsoWaSA+konxjEayBX2V02beHDEQd5fqL5HKrbR4bz
         3B3WQnGOimjcPl0IJZAERXA2yl1+8mEm7NckH4vrOUGmX8h6c6GlAd+BYyIU6XveDZWG
         dhj4uCj2enE9rvmtnZGw37gm6chSK1N+KHTijzNuy1HjtShzUS6i8RKHMCZ/x72KCsIP
         1xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706983174; x=1707587974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRBDbN6U4RNOWRCFFzR1XAeOjrhAG1s6gIx4tBv+f5Y=;
        b=Fs5lDqGC/ShJX3zhrauotytquKsuJzkBHjn8QhSPT3/HsFxG74Mv5aHDRMzjB7emVN
         teZwsw0njBf8u+/p9D0Sg6VzwwdE2jrafms2MpV1NZizMYA/mRhnco35oE90+/8V9exS
         D0E8vyUN1771BoxOYw4PfBuv/+KeQ2UENmRkOlZqJtpi1oX88suUYdmsviZ51oGCKFP/
         x1D0ym+DMdaH3sy1RCbrkTb9qAKXNAfzTYxy8A5DM0x8XXJ507tzjQrNvcbXV6nupbsC
         ZOnzudGTY7/gt+0Zr5RDjM1ur1hezkZLLdrqRzMqzWfNtqYrn4M2yLH1XL9Txrl6FqL6
         lOJg==
X-Gm-Message-State: AOJu0Yzmt0W8P7j7CXJ6EynmepKjEeDCNMxDO/G1aWZuR+cnrFfgh9Hh
	4pmv+mWbBSGXdpFX4sFXrsXX/5BEgCo43g+YG4UH0+3C6wJbRyKX
X-Google-Smtp-Source: AGHT+IHUEdZa/TTw+JQpuX2tYyD4YRkVEUHFXJpvroCk+OcF+l21qgDIKvuqTkDBIlCgtMXaZ0iLpA==
X-Received: by 2002:a25:ada1:0:b0:dc2:2d59:512c with SMTP id z33-20020a25ada1000000b00dc22d59512cmr12137169ybi.22.1706983173860;
        Sat, 03 Feb 2024 09:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWI5zqLiyZNm2TH9ntV4Rh8+96YK2R6/8LV1N/9bvowr3btsoNouQkB5jEx6X3PjTKYMtrRUz7dG1I/tpL6FtFKHxeawmMK4L9boIx8zY7+96lv11IMZkQyKufabjO3uGFgdC/5/TyZtGHB0OtLIk9up+fFjTN74VXSuM75BRBah23uIOT3DXjCLJqUUQCtua/9KyOgdn7UrNGHxkZnb+fO+ygBAPrktBC4n3fdMV236wJJF31vSiP1qsaoEfbThJ9MtHFdEFfP44qDfrfBM5mN3CZUPgnhm5IhTq4/Cz6sKOopTMiOApLmPiTMUlMKsqwAdyLaWQF2pZHK8ZiVgawNsb9be8VlYnsMAY5dI56slmN2V/1JejXnubgzJfgn9aFfCYWf1RXFua3EBZV3WiDfQzmeiARcItcKksoBwqTnDkEgk0HZmRmOjfvxgA3yTqRgk3JYZ9LhbtpylcxmhyJj16PC/jGBtmt6NUCzvq6zJLElneMPtW64ZA==
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id kf1-20020a056214524100b006879b82e6f0sm782639qvb.38.2024.02.03.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 09:59:33 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abdel Alkuor <alkuor@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Alice Chen <alice_chen@richtek.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt: bindings: leds: Add NCP5623 multi-LED Controller
Date: Sat,  3 Feb 2024 12:58:51 -0500
Message-Id: <20240203175910.301099-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCP5623 is DC-DC multi-LED controller which can be used for
RGB illumination or backlight LCD display. NCP5623
provides 94% peak efficiency.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 .../bindings/leds/onnn,ncp5623.yaml           | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml

diff --git a/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
new file mode 100644
index 000000000000..696bc7d8c8f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
@@ -0,0 +1,98 @@
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
+description: |
+  NCP5623 Triple Output I2C Controlled LED Driver.
+  https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
+
+properties:
+  compatible:
+    enum:
+      - onnn,ncp5623
+
+  reg:
+    enum:
+      - 0x38
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
+            description: Index of the LED.
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


