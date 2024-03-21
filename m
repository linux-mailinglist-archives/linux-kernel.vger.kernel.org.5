Return-Path: <linux-kernel+bounces-110348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552FA885D89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B206282AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92936762E5;
	Thu, 21 Mar 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCQytqxP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AFF511;
	Thu, 21 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038808; cv=none; b=iTbRG9Yy9TpfN+Rdcpw0y1e2QiHRHrdDG8QeWpKVizvIuoP7HEeyeSRSGDzrsZ4t202vAaI1wNpO8SdV3fmSlTzTxjtV9EQ5s+Bm7vMvBe+7WNya3iZi+u5x4Q0WUnOBFtMADOxXe5Su7vLIoiZSL+ELk7T7MC4a9VW2694NbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038808; c=relaxed/simple;
	bh=wOKK6j/7imLrUy5tdTWjNZFsL8pPVcL7FCxPvKsQFoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tonGAzlgfcVDpx4w68RdpWYhHNqJ11Bsu9oixIuTvas78POX2/ODQD2hRkJ0DbZUA3KQ2UsueDipSbZHmJkrE+XDSY7C2AkkgAiYv0ox/faGJWwma9us0Ib+BzAXrTX+LQ1PvmBY4phXTsCLGMCSIEQ0k/T3v9k3cD9q40Xxpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCQytqxP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so1476717e87.2;
        Thu, 21 Mar 2024 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711038805; x=1711643605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+djyd44OYHisFXYcFtEHVzopuUaLOmkeahu1jyD+yQ0=;
        b=fCQytqxPudqoqBqwp+Z/VcSzGrojgE1LKSFVFDDs103vgwck0AY+paM5HKUYvWgw4t
         8ovKrZgkXTS0x7PSWlJyiHYNQnakEDxdRPNXC09bC0nWklsPa53VctXpOi2mJLTWH7JT
         ltop4In3AY4niQ+PN7pk8FK/cAT9MptJpHhEuh0cfDJ+g1pq7kHuAOYBj4a9fwAViX3J
         uB0zN8TqowRoyJG3m2CofyIioLJTa4mVt5lH466PzmFAHXecnSi0e3rVLxL31QraRlYE
         O7+TWC3VAVt9N4O9oczlRm8/HgsrYZlPEg4YWqZTpqA/K3W5fsAAx7xTV5vtx0JGTWpy
         h36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711038805; x=1711643605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+djyd44OYHisFXYcFtEHVzopuUaLOmkeahu1jyD+yQ0=;
        b=CPT2IBoeXlmMZSJSxw+vnivBR7YulYJJq34pGnQicbsIlK8Isf1hd0FgsoJ+f1EPRC
         6t8nuaYHIVg12FsYz0Y613/Q6DTp3cJCCXE1pFk2sc4+Zka+ixQX4dzgnhPVU758grqP
         0RoAUpeb+H0IGaZME7VSuVgl5xtFzHKw2PkTCncxc3kYY62RWftXrCA0x3GtGsY4pN0B
         PDzzBigVAbmnODFEcCgTmPrSKYKLkjKxvyO0JEeNbno1Jc1ed/BBnUgmX5qj2OsxX44O
         Ibo97hyW7mYo3CMQZuZaY6iBXvo8K5Gz949EeP6lo+nxGzIVQdzhRbgRf4LKwJ8h7p5Q
         1/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRLSDizIUEhihbWwx124ks6fsJsytA33YwT9SMtuHcNxke1yuVN6DN5Y0eCXAj/8Jg3EMlRTAWnmRnxRp6g4bSIXQzVHueOFZkDwM/Xgt50I+Q2E5MUueuqfou6zeHRXcziZsTA75/Xw==
X-Gm-Message-State: AOJu0YzNQbt7sO7xI6EX5hkNw/hQwT6Mhfq/aoZU1SrjWZQnQIrSY1AZ
	6pzLbb/Gl3u6xJzWohuN7Ky98Q2/iJCqttlS/evWfxzFuHuhMoc8
X-Google-Smtp-Source: AGHT+IEe3b+wxmJmEH6A9ZGYNAFbxNSHxN5TEZafLXwUKXlWANaZPIAFINhV7Db8RlHpatTu27Fejg==
X-Received: by 2002:a05:6512:2f2:b0:513:46cc:8966 with SMTP id m18-20020a05651202f200b0051346cc8966mr15506993lfq.2.1711038804746;
        Thu, 21 Mar 2024 09:33:24 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v11-20020a056402184b00b00568e3d3337bsm50509edy.18.2024.03.21.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:33:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 17:33:18 +0100
Subject: [PATCH v2 2/2] dt-bindings: hwmon: max6650: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_yaml-v2-2-74fa8eb60ec9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711038801; l=3871;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=wOKK6j/7imLrUy5tdTWjNZFsL8pPVcL7FCxPvKsQFoU=;
 b=cy6GCyLLOMPgGwA2Ql+IJ+Y8mngoKgmelzo3sEHSM6Fhee9MLlOU8G43k6GxB4jsOgYjonerZ
 T3p3Z8ASEUkCquSqL3DcdjtITcJTcXTowqjrD0CYb9GvXKg0tBMtpBU
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing bindings to dtschema to support validation.

This is a straightforward conversion with no new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
 .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 70 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 28 deletions(-)

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
index 000000000000..2c26104a5e16
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
@@ -0,0 +1,70 @@
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
+    enum: [5000000, 12000000]
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
+    maximum: 30000
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


