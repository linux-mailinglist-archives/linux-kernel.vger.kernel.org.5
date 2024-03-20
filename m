Return-Path: <linux-kernel+bounces-109202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6C881617
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968AC1C213FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FF6A34C;
	Wed, 20 Mar 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaJtZkEq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA86A010;
	Wed, 20 Mar 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954317; cv=none; b=ZWMDdbiRRIsxYw6I3wG30YRfYJAmgsgrCgfWbtOTUg6uYq3vb8VM3LQfDj6kSer2n8ygnAdqE5VjgSDkNli1xhj3NTPq98uP9cHLlEepMNn19TqFM5719xDzkvpTl31EMvyDmdNzDz/1AIb98aMbQHJIMtbovOTI0EKcLFP/hhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954317; c=relaxed/simple;
	bh=IVOoaXTdRIOWRHqJ/jIyAtqfWU/uE5l47TaaKfbqYKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfAZIbLeK82fWqoQZ+W5BwNTmTJuQ5PrpbwN0dzJoDdANc5JyaoFrDgDCqkF2BJS5QD92MSmMls+OZtMtNLOkAbuZua53lP4GRvv3nS1gNQE975KDOxHKMyU37g7B46P6xlCYQq64rOlBQfA4XU2707kWgw/qcIBQtI/qDLBqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaJtZkEq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so214027766b.0;
        Wed, 20 Mar 2024 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954313; x=1711559113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63t1vQpfuivnFuqcHL3Yoh9775vvNNfjouC2X81BrxQ=;
        b=BaJtZkEq/igw9WzmiOsKqT3mAOs3j8PAdIJ5IN0wuEWG9MKG4dEiZNFxR5cs1L1aqi
         3Lc24sM6dFqW2zKcrl9y9BSTI3i5JnDp5vgT4dtabftIbES/h0Q6dEB2F50l4eLWG0t5
         ngLfR0Nv1A8jNzlTUD2dfwef8ByHRxv9EAB0kP8x5ps41nesLzaMx2r+iup6aZFPqG/V
         +eNYXx6PzdjCP0VXez0uAshC7eKOQGF8urytxh8wB6W7EN3V29D1jaRKoPhbQPXPK9UF
         3sr8M66A3mW2Z6/pp30xp+FWd/x4UwMVSPpT6W6bh0DjR+7yv+hcxcOq5g4x3i0Xcq88
         8KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954313; x=1711559113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63t1vQpfuivnFuqcHL3Yoh9775vvNNfjouC2X81BrxQ=;
        b=ZSU6KppWO0JUWkCyfGpKsJGMMyxdVl2+/1sn81yvy97pUI4GWNTZMBUilwuPI37UMg
         C8O+dKAX0hovBmf6qdM99TzGUs2mF++Z0iUQfMod+FXo1Q3In5Kouf/cvCj//meB6xsT
         nocBPhVHcsqrj7Umr1e8YVk7PvaGBr1CTxwbTMLQs2hAoY2wdvGmpXQCcIfv3TlXC4hu
         fI1LtIYh1a2tb0CgnfpYLlC4Uy+4MyY1zjTjSLQwy0wsXcT4jAAZGmBOMxBr67dtnpW4
         EhBSCvj0rIv79FlkrfX9kagPlclr67EQqm8N/YJSf6dFObWJrFp+7HOnaKuW8Sdpaj4X
         UQgg==
X-Forwarded-Encrypted: i=1; AJvYcCVs/wXSrkzU+x56I2S3mLddofw86giyDLHxRQTQJ2qU7InObEFTe/u+0rnu+ZhYvBB55qYPMj+vySF7Sf/IuGmqdCEFN9f28U6rSBG51xHNtghhru9zqftWcqEf+UkPcL6DPO6xu9SueA==
X-Gm-Message-State: AOJu0Yz1rfP5+Z0Bj4eK8qF0/crmAt9oI9y6BzZfteQr8rWpCzUtCcDR
	09FnBdMXRf7GZtFjF+aG3sDYPiOKEqUhBwtV77LiwHWjSJPd3z2l8qDmfgW9+DRcqQ==
X-Google-Smtp-Source: AGHT+IE4FWycV2u2wFkM4cGuD4UzYQE5/Y6WQqubh+YUUn5OYTqJkVFL1BtiMmruqGLMTIVmHwSlrw==
X-Received: by 2002:a17:906:29c7:b0:a46:ebe6:742e with SMTP id y7-20020a17090629c700b00a46ebe6742emr221889eje.23.1710954313107;
        Wed, 20 Mar 2024 10:05:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3c5a-7cb4-e12c-8223.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3c5a:7cb4:e12c:8223])
        by smtp.gmail.com with ESMTPSA id af3-20020a170906998300b00a469604c464sm5999019ejc.160.2024.03.20.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:05:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 20 Mar 2024 18:04:58 +0100
Subject: [PATCH 2/2] dt-bindings: hwmon: max6650: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-hwmon_yaml-v1-2-a349ca21ccab@gmail.com>
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
In-Reply-To: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710954308; l=3820;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=IVOoaXTdRIOWRHqJ/jIyAtqfWU/uE5l47TaaKfbqYKI=;
 b=V7vq8d/EncKKvGUZA67pruDqB8f6EAafYYYMgu8uLkGoKdUYl/VkJy4DTsyCPmurzBcCN0/h2
 EDuS4Kil6/zCaScx8t2C6N63qmVCKsmwBf79qGEM11s4OKI3N2auuYD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

 Convert existing bindings to dtschema to support validation.

 This is a straightforward conversion with no new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
 .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 68 ++++++++++++++++++++++
 2 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/max6650.txt b/Documentation/devicetree/bindings/hwmon/max6650.txt
deleted file mode 100644
index f6bd87d8e284..000000000000
--- a/Documentation/devicetree/bindings/hwmon/max6650.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Bindings for MAX6651 and MAX6650 I2C fan controllers
-
-Reference:
-[1]	https://datasheets.maximintegrated.com/en/ds/MAX6650-MAX6651.pdf
-
-Required properties:
-- compatible : One of "maxim,max6650" or "maxim,max6651"
-- reg        : I2C address, one of 0x1b, 0x1f, 0x4b, 0x48.
-
-Optional properties, default is to retain the chip's current setting:
-- maxim,fan-microvolt : The supply voltage of the fan, either 5000000 uV or
-			12000000 uV.
-- maxim,fan-prescale  : Pre-scaling value, as per datasheet [1]. Lower values
-			allow more fine-grained control of slower fans.
-			Valid: 1, 2, 4, 8, 16.
-- maxim,fan-target-rpm: Initial requested fan rotation speed. If specified, the
-			driver selects closed-loop mode and the requested speed.
-			This ensures the fan is already running before userspace
-			takes over.
-
-Example:
-	fan-max6650: max6650@1b {
-		reg = <0x1b>;
-		compatible = "maxim,max6650";
-		maxim,fan-microvolt = <12000000>;
-		maxim,fan-prescale = <4>;
-		maxim,fan-target-rpm = <1200>;
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
new file mode 100644
index 000000000000..1b33b5fb606d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max6650.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX6650 and MAX6651 I2C Fan Controllers
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description: |
+  The MAX6650 and MAX6651 regulate and monitor the speed
+  of 5VDC/12VDC burshless fans with built-in tachometers.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6650-MAX6651.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6650
+      - maxim,max6651
+
+  reg:
+    maxItems: 1
+
+  maxim,fan-microvolt:
+    description:
+      The supply voltage of the fan, either 5000000 uV or
+      12000000 uV.
+
+  maxim,fan-prescale:
+    description:
+      Pre-scaling value, as per datasheet. Lower values
+      allow more fine-grained control of slower fans.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16]
+
+  maxim,fan-target-rpm:
+    description:
+      Initial requested fan rotation speed. If specified, the
+      driver selects closed-loop mode and the requested speed.
+      This ensures the fan is already running before userspace
+      takes over.
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+        fan-controller@1b {
+            compatible = "maxim,max6650";
+            reg = <0x1b>;
+            maxim,fan-microvolt = <12000000>;
+            maxim,fan-prescale = <4>;
+            maxim,fan-target-rpm = <1200>;
+        };
+    };

-- 
2.40.1


