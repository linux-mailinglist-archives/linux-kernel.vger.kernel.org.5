Return-Path: <linux-kernel+bounces-110347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4CD885D86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C761F284B48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F918AE8;
	Thu, 21 Mar 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9ls2Ja2"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820791FA2;
	Thu, 21 Mar 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038807; cv=none; b=rsAmzCqJcruKLmYQp26RuGH76HR7W/MHYr93NzLJnmqYbXrOyrWDlHwPDLm4II1b1ZdpOgIw95gaKyKpGwn8FTyxvqXs+S9wbvJ0gU3DaA0f/T6Sj74CJKgmXQQSMZJwM/8imHlF+vBcvvwb7qsAEVI116369FQoDus617YvcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038807; c=relaxed/simple;
	bh=TjTcKKa669OKcPhVLe09wrmQ2cA8xaDIfGZNCpgTFng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbxkD5bs9444JaFaCNEJWkWjdQ34Ky2zOZOeC9gISC/Oop1ODSx08S9U8uWGnlLWAcNyYBaklZ5suyaEjbnKvCPY7fjlOOw6tKlYEt0fDSfvajsNFAyPFGFGLFr/Uulnn5xqrEFN8eJGApLEmgmFTTdexP44l3iWzh58zx6O/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9ls2Ja2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso1409439a12.3;
        Thu, 21 Mar 2024 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711038804; x=1711643604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJIJVaZ1AJVUf194+oMOU0Iy8m7xvdZB41+GUQbshIo=;
        b=I9ls2Ja2qOOWTW+P6xa3tPaAoAbgUSRePM6eKCKxqQQsS0iDYmi/BWsaIYJ+/Yb6U1
         54+O8d+p9G7WybIrje4iBBg/fM4SVHZarXjs7MEh3ad4EYirFWdi7OTH8PQZme40xdgA
         KcGag2ep6hXqjgCSrZ8aZ6GCYCPp647+r3BwjlSZeJ3c9H4esh3XlDVy5cbPMAPva9z/
         bopsJKTH2PeSplmX7WAh5qSta1kLvrxx9B3ByJjOUg8BoK22Ezj5nE+X5x0jIRFNRuCn
         FvClCN7O+VqtSWMj5MxRhykIy4O+zbYqqQb9VmD6urDmw7Ar4m9iOP2EyeyTgL1+Jmja
         gcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711038804; x=1711643604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJIJVaZ1AJVUf194+oMOU0Iy8m7xvdZB41+GUQbshIo=;
        b=k9ifYobqYjOhmw6cxG4UhyXKU2SEvfbM8pK3+vwkpgBmNe4zdZaeE82n/N/VJ2RZst
         nV0DclIQzcqP1UrBal27UkryCPwbFQOhPBHo8xTzOhDBpy1c3yBmfH6k++DKBDQcfW50
         MIompL31tV0uNRO7qfbKpQiOs6eZ1sgoRFLxXHXAHkB1iZPwYgz1x3kNmd8ucaJAK28S
         kNiFM/DtTJvDixmHrbcAoU4vNbw8GjuFKhoe0yCtZltb/U0Ujj4W9zxUXTxGZlxuV8vt
         2vVfABHSnyWg5cff+hOOWmmvEo6JwmDCLyKO6KzRWOtTtUQoSBafrBaz9ayFfquyWjKL
         qtYg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zkc5ZWyINAlC8JPWyeRB4FGd+pbji7b+G4nguaKRCt/wA3bLy5/35z1QsFlnXnIbQRDfmM3qE/6owWpZOU+QOFxEdiRZOrVQjpcjGaNO7p1ea6ttYRoIuv9laHagh9H3lDsiDmLucw==
X-Gm-Message-State: AOJu0YwtmUiDuBsqQ6PdeYKKFDEr3278kEEnt9aPaxpJ18FbKKbzTF+m
	jTq0XZxiGr3CWTOxDdoInFEBtNNhzGj+dQaenUTKsLevg1eMqg0b
X-Google-Smtp-Source: AGHT+IGrSwBUzrgbNcI8kNuWcPPtTvzZbP3s92YZZH1WbDnbeRPMFbgslUd6lcGpJXhfvH2Jwtxv0A==
X-Received: by 2002:a05:6402:3884:b0:568:d5e7:37a1 with SMTP id fd4-20020a056402388400b00568d5e737a1mr6132002edb.36.1711038803525;
        Thu, 21 Mar 2024 09:33:23 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v11-20020a056402184b00b00568e3d3337bsm50509edy.18.2024.03.21.09.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:33:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 17:33:17 +0100
Subject: [PATCH v2 1/2] dt-bindings: hwmon: lm87: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_yaml-v2-1-74fa8eb60ec9@gmail.com>
References: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
In-Reply-To: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711038801; l=3573;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TjTcKKa669OKcPhVLe09wrmQ2cA8xaDIfGZNCpgTFng=;
 b=1UN655Bn01MvGRUaVokK1uJK7I8Lr/RUMHUaakCDYIWn4jvhRGIiuoMrr1xVCPFcGUlUkOaBL
 ZLx23+GpCulDJ35EH2iXifDbY+2aQ98dv0OjIaOAxullIl2tO+FKic4
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing bindings to dtschema to support validation.

This is a straightforward conversion with no new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/lm87.txt   | 30 ----------
 .../devicetree/bindings/hwmon/ti,lm87.yaml         | 69 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/lm87.txt b/Documentation/devicetree/bindings/hwmon/lm87.txt
deleted file mode 100644
index 758ff398b67b..000000000000
--- a/Documentation/devicetree/bindings/hwmon/lm87.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-*LM87 hwmon sensor.
-
-Required properties:
-- compatible: Should be
-	"ti,lm87"
-
-- reg: I2C address
-
-optional properties:
-- has-temp3: This configures pins 18 and 19 to be used as a second
-             remote temperature sensing channel. By default the pins
-             are configured as voltage input pins in0 and in5.
-
-- has-in6: When set, pin 5 is configured to be used as voltage input
-           in6. Otherwise the pin is set as FAN1 input.
-
-- has-in7: When set, pin 6 is configured to be used as voltage input
-           in7. Otherwise the pin is set as FAN2 input.
-
-- vcc-supply: a Phandle for the regulator supplying power, can be
-              configured to measure 5.0V power supply. Default is 3.3V.
-
-Example:
-
-lm87@2e {
-	compatible = "ti,lm87";
-	reg = <0x2e>;
-	has-temp3;
-	vcc-supply = <&reg_5v0>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
new file mode 100644
index 000000000000..f553235a7321
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,lm87.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments LM87 Hardware Monitor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description: |
+  The LM87 is a serial interface system hardware monitor
+  with remote diode temperature sensing.
+
+  Datasheets:
+    https://www.ti.com/product/LM87
+
+properties:
+  compatible:
+    const: ti,lm87
+
+  reg:
+    maxItems: 1
+
+  has-temp3:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This configures pins 18 and 19 to be used as a second
+      remote temperature sensing channel. By default the pins
+      are configured as voltage input pins in0 and in5.
+
+  has-in6:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, pin 5 is configured to be used as voltage input
+      in6. Otherwise the pin is set as FAN1 input.
+
+  has-in7:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, pin 6 is configured to be used as voltage input
+      in7. Otherwise the pin is set as FAN2 input.
+
+  vcc-supply:
+    description:
+      Regulator supplying power, can be configured to measure
+      5.0V power supply. Default is 3.3V.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@2e {
+            compatible = "ti,lm87";
+            reg = <0x2e>;
+            has-temp3;
+            vcc-supply = <&reg_5v0>;
+        };
+    };

-- 
2.40.1


