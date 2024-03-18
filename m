Return-Path: <linux-kernel+bounces-106615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CD87F0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239CEB21984
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75F57874;
	Mon, 18 Mar 2024 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxxrF5Ug"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98B57326;
	Mon, 18 Mar 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792738; cv=none; b=Oc0TM3vQQG4KoxqDyqabL9lYrNPEhbHgpXs3wy7LODCFy7aswwtrTZaKL4bGYfHDUrLuB0mGnimEXOrDLMcQ9L0PN9n4yKG+TBdlNN0bhXkhdCQFlLrIunZXbq5oXQgKkEuxTXmn9KIhtoLFGwp09JJb3jYHWKIus7dRS/qFYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792738; c=relaxed/simple;
	bh=A1hMBuNoMYPdTjyIiblF224rpNHmRnKAd9sG7OtUI+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QQ+Aw1giZ9mriV/w0YX5mDZHkQpzFQepKMxexP1j1SeqMqTTtyqLncmMBoVoxmFSlov09lMi11eBn6IXFHUoFiqBP0CmgNb5vR2xaBgqoSjQQIF0Dc86vvZ23slkL1pPB/QoJE+O91yBJxgMQnqyxd/ghLTJys0aRtcdsXmtZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxxrF5Ug; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41409fd8b6eso21946555e9.2;
        Mon, 18 Mar 2024 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710792735; x=1711397535; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fd9d/Eddk/+SyVZ2Xzut4rMW89ulLr6HF4jWb5kzWg=;
        b=SxxrF5Ugz0rWX9+1eqaoysuyHD+CqWrQNE0MNVoTWLkZmTnsRMArAMEnID5nj6SMTA
         U7p3VSOmEOptuGRHngGOjqEpbRn10h9drC5p/Ife2LEpcm2AipywVaheWEW9xjQGeZmi
         CmBX0h2VIFcTiYhkURqdhN9dHf/+/TiKfpJC2/KRpmEJipy5p9KIHfJOEfOnaJY5fCHD
         lM5i6/UQZIG31gbCsPvZyo7HgMA+8wKw/513ioo8koCKslY6EUnWzkPMOF/sDYilIJWu
         IUYFyNMckqMAZiod3e5cXGsFrgHutNAZtblDNRSJ6Lbln4uN9exVGZflsYJKwjHkxquS
         xGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792735; x=1711397535;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Fd9d/Eddk/+SyVZ2Xzut4rMW89ulLr6HF4jWb5kzWg=;
        b=AiAG3lFyB7vn3BMuigxA0gh3PUsa2D0Oe7QUe8XFTPmYCjhQcw0hAqT8yGrzAGcTRj
         FpaPay2OE+WHRdfN3GB3315xQrqgsZ4RgRpKwwuisp3u02SG9rsmvHMQicvJbpSs3t4m
         26WmI3QCVTpXF/TJ3I/EL2+W2LBPuvhHwnZi2I55K2+Fx2L/2zQ1+caoDL1N5Y5Fs3iq
         j4ZoNgR7BR2fmE+ijASSm/9DMMAnI9RjPOCV+80zr/6yFVcS21hZzSJlEE1Vl5WvV/wl
         oLY0r840L0nTwHcXbwVo1XkieSgQmvm+0OEcvaN7AIZKaOnuKm5GRAqW2D6EXCDtLK95
         1a+g==
X-Forwarded-Encrypted: i=1; AJvYcCWC0jwPZlQLiDGlstiF+tQTTe7CZDotsZ6GSS+gzoORTJeayH80hoBnBtk1MaSYpIfZvXTD34jaD6QQ48qYF4xHsecFxfBcKwp2n6c55V8h05f40RJHHPAsY571y90pgAEUFWmnyUWPjA==
X-Gm-Message-State: AOJu0Yz++Es8Z9dxibZqkmYxMgQaMn4X4hHs3S+fHa6+o/jExiEm7q5T
	zg6kY3NJ+xsTYDB5fTrVA4tnEt3pefS5n7oSjTkjnFzgSIVfiE+X
X-Google-Smtp-Source: AGHT+IFmlNOA+miA3dz3A9/3mRjChUg1L2C0SXf2p05e4b3/0CcPqAhCWD4DaDcTLvpqUMxkAz4LQg==
X-Received: by 2002:a05:600c:4f0d:b0:413:e19:337f with SMTP id l13-20020a05600c4f0d00b004130e19337fmr6139675wmq.22.1710792735351;
        Mon, 18 Mar 2024 13:12:15 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1df2-69df-52dd-8b59.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1df2:69df:52dd:8b59])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b00414610d9223sm1230492wmq.14.2024.03.18.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:12:14 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 18 Mar 2024 21:12:06 +0100
Subject: [PATCH] dt-bindings: hwmon: adc128d818: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-adc128d818_dtschema-v1-1-d0af2caef145@gmail.com>
X-B4-Tracking: v=1; b=H4sIABWg+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3cSUZEMjixQLQ4v4lJLi5IzU3ERdA6Mkc4u0ZCOzNDNTJaDOgqL
 UtMwKsKnRsbW1ACr7T5BlAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710792734; l=4059;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=A1hMBuNoMYPdTjyIiblF224rpNHmRnKAd9sG7OtUI+0=;
 b=oNAo8Pt+avXQVgB511Qmr+Mzmpm20yXdBgz8puWabhcxvWftFlM6OYIk6h+YshWaIrneKjmK9
 TpUiiMp76VeDizq/quYx2SjOmCyLmjbpLc2PvESVlzZJ+hMw35xPH+R
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert adc128d818 bindings to dtschema to support validation.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
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
index 000000000000..b48a9841600e
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
+    description:
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


