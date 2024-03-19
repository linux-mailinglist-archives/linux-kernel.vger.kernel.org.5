Return-Path: <linux-kernel+bounces-107358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6487FB67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33672282EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E607D083;
	Tue, 19 Mar 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhvnyM3I"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CE7D3FB;
	Tue, 19 Mar 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842419; cv=none; b=KStmd4emhUt6/nlZA2wHHovejl9Mvu+1Mz34d2s+TEDJNoBmRnI3ZIJI5ejxOaMWD6c3GUjYgmUcH+rDXSN5GCfMEyZLa0YpKDUz0JZu+BIHk3p1CtGi1x+Px3GMOnOlcQTeVIsXVDGrTtPJwED/wVIpXeKAEBssSrMf64BuTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842419; c=relaxed/simple;
	bh=YS6LfNbkzTPgDh+QU1D0cGkvWCvd8NnUqkDhxC1Y2G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T1/imVdZtlkhTONErNA80pbvryGbaXTeZqhpEwE2fyMlyjajPxQ0eXEyTDPS6vCYFWb6H1egRlJMOzatil7LCh4ASkO9xfZrjewLWD9huIaHLr1wy4myXxOipW5YI8dWswKB1zpxtv+UfZwP4i9Xq3p21OGN6Gc8RBT7mqzb5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhvnyM3I; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8bd9837fdso104989639f.1;
        Tue, 19 Mar 2024 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710842417; x=1711447217; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hPBanVUiv6bl/xFEDLvHWIxIkfYGh6kxsMyvNaiemA=;
        b=QhvnyM3IpEoEb60wTFdzTO51bFWCD1A6HzBaaqwLYTUu4sfuQCILq2yng+ialJhMlZ
         beBmYPlpxZmbGqih/gwG9QBu94KXZdtfONQ0CV4eUUWdtTuCCmYlc9sD5JmowK0VIyhg
         fzgVx7pXqJClFwQV9491MyfeLAYoSelNC5VHTAlKI1iRC/LZ7umMU3srCMqduf5BqjG1
         /9ZxWlJq8lsLUyWquSUpyY6PRKecfgS1KqM49xpfZZ8vKPsPFEu1JBlCexihhs4nQtdz
         Rm9srkBBnbh/bZigp628WuCiF15JoatUggS1JLA9qJxsNPCWZkIrPVS6BDry00wa5o+W
         5rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710842417; x=1711447217;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hPBanVUiv6bl/xFEDLvHWIxIkfYGh6kxsMyvNaiemA=;
        b=BG9r45tDsbFWhs/BEG0Q9ijlj1ttv3GvMu3L3iVUmPy5mGq4W+IvO/fOZEhtbDb5Rc
         pRDGtuaak6mpYDvqjbz/6UmSo1Elrr9SUDDCIZlZUJI5rFre7VDnVMmjloJhlagLEF+m
         CTdAugkFnjKYZUchlQ30UGt8NGXX87vSk3WbhatU9WTxRd1ATkJK4uW2odAnhkWh2WKD
         fFMaoUfHSiMxYlI6Nkp8iSksfb5PVhThoP65dxgPq2Z0rcSE7PqTUx2CG4xrBshlXse/
         EV4jtTIs1zbDtU80v/B0e+I4/ZKsGos0L8lXc1fhQ5m2xbeCvFcRAae0kqrVVKC1CNQR
         TGQw==
X-Forwarded-Encrypted: i=1; AJvYcCWxI/Q+/hTtyD0bgIfjvwGQDDAfwrRAF0DuTpQXdnIxTX8Y7ubX9afQrh2P+Xn394A9D24BnCnn+IgS+4j7dJ3ETYuZOVX2yrt08l+C7pA1gBKVGQdg/9iHWEIP+wx9PXSvGTcovnfO8Q==
X-Gm-Message-State: AOJu0YyAp5la4/NKb9Kma9k/ZxcL5gcq/YAUr4nCO0tesOqyj0EejUg+
	AXfyjbkPYBC5aG2wXX1JNnsf9t+QPUtxgWPMwEM9mYF0Vq9yTicM
X-Google-Smtp-Source: AGHT+IGTYHXQGX2b+BTeHbOpfcgAwsY4OiLK0Vy/KdpuI9pSD3zUUqpj3OvY8szCG0W4zjLmRL8xgw==
X-Received: by 2002:a6b:f604:0:b0:7c8:c9b5:a1cd with SMTP id n4-20020a6bf604000000b007c8c9b5a1cdmr15298792ioh.18.1710842417219;
        Tue, 19 Mar 2024 03:00:17 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d9d7-4494-41da-066c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d9d7:4494:41da:66c])
        by smtp.gmail.com with ESMTPSA id z4-20020a6b5c04000000b007cbf3d1bc67sm2305937ioh.10.2024.03.19.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:00:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 19 Mar 2024 11:00:10 +0100
Subject: [PATCH v2] dt-bindings: hwmon: adc128d818: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-adc128d818_dtschema-v2-1-0824a6d69493@gmail.com>
X-B4-Tracking: v=1; b=H4sIACli+WUC/32NQQrCMBBFr1JmbSQztjW48h5SJCaTdsC2kpSil
 Nzd2AO4fA/++xskjsIJLtUGkVdJMk8F6FCBG+zUsxJfGEhTrU9olPUOyXiD5u6X5AYerdL0OJv
 gqA1tA2X5ihzkvVdvXeFB0jLHz36y4s/+762oUHltAznLAevm2o9Wnkc3j9DlnL+XqhjvtgAAA
 A==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710842413; l=4328;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=YS6LfNbkzTPgDh+QU1D0cGkvWCvd8NnUqkDhxC1Y2G8=;
 b=0i7f/SX0ii5Am/H2bIS68d7rLbSwj0zBzZym3OMzxN28A9d5z/36npPE7JgE9+C1PU0Pb9YQQ
 CXp73IimlxZA3c2LDtTwiWMsWTKBXyXYgqmOBz4odlsXf3VvoYIMGMM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert adc128d818 bindings to dtschema to support validation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Add missing '|' to mark beginning of literal block in ti,mode
  description.
- Link to v1: https://lore.kernel.org/r/20240318-adc128d818_dtschema-v1-1-d0af2caef145@gmail.com
---
 .../devicetree/bindings/hwmon/adc128d818.txt       | 38 -------------
 .../devicetree/bindings/hwmon/ti,adc128d818.yaml   | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adc128d818.txt b/Documentation/devicetree/bindings/hwmon/adc128d818.txt
deleted file mode 100644
index d0ae46d7bac3..000000000000
--- a/Documentation/devicetree/bindings/hwmon/adc128d818.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-TI ADC128D818 ADC System Monitor With Temperature Sensor
---------------------------------------------------------
-
-Operation modes:
-
- - Mode 0:  7 single-ended voltage readings (IN0-IN6),
-            1 temperature reading (internal)
- - Mode 1:  8 single-ended voltage readings (IN0-IN7),
-            no temperature
- - Mode 2:  4 pseudo-differential voltage readings
-              (IN0-IN1, IN3-IN2, IN4-IN5, IN7-IN6),
-            1 temperature reading (internal)
- - Mode 3:  4 single-ended voltage readings (IN0-IN3),
-            2 pseudo-differential voltage readings
-              (IN4-IN5, IN7-IN6),
-            1 temperature reading (internal)
-
-If no operation mode is configured via device tree, the driver keeps the
-currently active chip operation mode (default is mode 0).
-
-
-Required node properties:
-
- - compatible:  must be set to "ti,adc128d818"
- - reg:         I2C address of the device
-
-Optional node properties:
-
- - ti,mode:     Operation mode (u8) (see above).
-
-
-Example (operation mode 2):
-
-	adc128d818@1d {
-		compatible = "ti,adc128d818";
-		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml b/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml
new file mode 100644
index 000000000000..a32035409cee
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,adc128d818.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC128D818 ADC System Monitor With Temperature Sensor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description: |
+  The ADC128D818 is a 12-Bit, 8-Channel Analog to Digital Converter (ADC)
+  with a temperature sensor and an I2C interface.
+
+  Datasheets:
+    https://www.ti.com/product/ADC128D818
+
+properties:
+  compatible:
+    const: ti,adc128d818
+
+  reg:
+    maxItems: 1
+
+  ti,mode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      Operation mode.
+      Mode 0  - 7 single-ended voltage readings (IN0-IN6), 1 temperature
+      reading (internal).
+      Mode 1 - 8 single-ended voltage readings (IN0-IN7), no temperature.
+      Mode 2 - 4 pseudo-differential voltage readings
+      (IN0-IN1, IN3-IN2, IN4-IN5, IN7-IN6), 1 temperature reading (internal).
+      Mode 3 - 4 single-ended voltage readings (IN0-IN3), 2 pseudo-differential
+      voltage readings (IN4-IN5, IN7-IN6), 1 temperature reading (internal).
+    default: 0
+
+  vref-supply:
+    description:
+      The regulator to use as an external reference. If it does not exist, the
+      internal reference will be used.
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
+        adc@1d {
+            compatible = "ti,adc128d818";
+            reg = <0x1d>;
+            vref-supply = <&vref>;
+            ti,mode = /bits/ 8 <2>;
+        };
+    };

---
base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
change-id: 20240318-adc128d818_dtschema-02b78fc26f65

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


