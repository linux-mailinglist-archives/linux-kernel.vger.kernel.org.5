Return-Path: <linux-kernel+bounces-110569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72958860B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42769B22010
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4E1350DE;
	Thu, 21 Mar 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VixaplNH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA265134759;
	Thu, 21 Mar 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046644; cv=none; b=LIeuKWog/wCqqSVQ9FMqHgJFY+U6vKZCL0f5i24wzCpmV2MnbibEV5ubxNweOzFz7HK1JOj9pFLQc+cLEcx8C0sdSaLB+eYEhcyW6+AcE+Qm5zgZFq4oMafq21vEA5E/mTr52bxmK0vklLG0gAc38JQkcA74IY/GK2gVePvioGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046644; c=relaxed/simple;
	bh=SL6IFykbfJaWw2tZ5nEHGx/wGHJSnUvcwuO85EyOS+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaD67Uw9fy6bm9zIxEW8YFWhr+pyXQiU9w+81xtPkQkyFAdxJV2KK5mWpA54UGJvwkJkYXC8hb+cRBgfzGWCL7U606TaVLxud3fYfKVuxd78fLZ+71EfdILRSZ2WO8yLvnW1PsrezSFWZsvYlJNnokpjaM1BY6ztp9ol61WDn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VixaplNH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d717269fso1703916e87.0;
        Thu, 21 Mar 2024 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046641; x=1711651441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZod9FP10mmkUa93vUHm2PRSdkHtpevTJB03xjoBD4k=;
        b=VixaplNH0IVSwsMoeNBoPVqUAgbSVyS4QQZuRWT9dzLcKtM7G4GLfttDljM5coF4vI
         LP6+DqgrGCLOBH237zOrqad3R3daUQYQIWD7j+pv8MiJYiiOAlktANV3GFqmYjQDgp0v
         hTkfiBzfncbp9vsagHnuohulT2sbPIAtr3Kgz0NBPQsK4uVrk/Y7nzfMKkWvo0XdcyRT
         JFC7lefjCiYmJ8j6hofLe8ApNLBaEx7ypkCxPXqnMzxyzDgGsIz2ZlcBalGdEWCASlbq
         NaWiv1DU2LHSILa+mb2qIA4ZQfuhqLjZGkEBPntb/8SCTOKyETx40FOSzVFN2NW6XMIK
         y4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046641; x=1711651441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZod9FP10mmkUa93vUHm2PRSdkHtpevTJB03xjoBD4k=;
        b=phByYrL29+KIFQ8c83zG3ZCNl2z80G0jbpChYnGal+Qr++n3lLMXVrSkiMPMJDRiv+
         HL43eYutfrxj5vFYBcdSMA1u+g+Icr46coMucqhh5FcxU6TFHc4SX6RbfKUSYZrrzz1N
         l3eceFvHPdvO+/tEZ0nkVjuaY2W7mO8WGc5xcQ50H9Bib+BblMrD2tZnKSMafDphQZGs
         Zx+QdScmmOdT/fzJEvgOvREtUIHIQ8G3hMAD5HCW/tyrCrPwtFg/4vav8E7RVXuGXQ1U
         yHgpzebxwbFmWXQgoyv56guSIzFk0XZJAQyJdHBEZU43xMlxkoiFT0CpbumP0RBhk71E
         OTaA==
X-Forwarded-Encrypted: i=1; AJvYcCWDfWObCXdSyh8cG+Wl+9AE2BOyo5+q32SNb/6QI+4pZ8tEh60h+26SepB5q+Yo+Isvkz8UR28UYi/ce2Ln1pHgfftWYLymbaHWb/WGWT7+5kI2gLQBk+NzVKtL3hgyQhf6hZcoRkmCkw==
X-Gm-Message-State: AOJu0YwZ6gFfgNkF+FlsO3t8qDfJ4mgFbBOdhuBT8bgt6oZi68FjYzcO
	F3oY+blPzFwFMXJbpVghbbncafNhy42aB9AERN2KKu+uDZ8wxk+Z
X-Google-Smtp-Source: AGHT+IFm+lPaPah3aU9llD7EleeYDcjEK0aQBz65oztMXNAemS6XipbJkF1x1Cl8Q/EmmxGIB6bBkQ==
X-Received: by 2002:a19:5e55:0:b0:513:c60a:5fc0 with SMTP id z21-20020a195e55000000b00513c60a5fc0mr192787lfi.0.1711046640578;
        Thu, 21 Mar 2024 11:44:00 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:44:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:43:45 +0100
Subject: [PATCH 4/5] dt-bindings: hwmon: stts751: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_dtschema-v1-4-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
In-Reply-To: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=2153;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=SL6IFykbfJaWw2tZ5nEHGx/wGHJSnUvcwuO85EyOS+w=;
 b=vuGSNmDWCGBI3R/HkrLqvea2y0JsHVO8pRszHqQINVTNy0Mz5yoK4xwonUQ5ZhBdIJrOy+5Sv
 34YVfNecs3wABT2e0Vzp0zo17fwdU9eiJP+87R2dm0QCJU/BopLOpjG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

This is a straightforward conversion with no new properties.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/st,stts751.yaml b/Documentation/devicetree/bindings/hwmon/st,stts751.yaml
new file mode 100644
index 000000000000..9c825adbed58
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,stts751.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/st,stts751.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STTS751 Thermometer
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: st,stts751
+
+  reg:
+    maxItems: 1
+
+  smbus-timeout-disable:
+    description:
+      When set, the smbus timeout function will be disabled.
+    $ref: /schemas/types.yaml#/definitions/flag
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
+        thermometer@48 {
+            compatible = "st,stts751";
+            reg = <0x48>;
+            smbus-timeout-disable;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/stts751.txt b/Documentation/devicetree/bindings/hwmon/stts751.txt
deleted file mode 100644
index 3ee1dc30e72f..000000000000
--- a/Documentation/devicetree/bindings/hwmon/stts751.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* STTS751 thermometer.
-
-Required node properties:
-- compatible: "stts751"
-- reg: I2C bus address of the device
-
-Optional properties:
-- smbus-timeout-disable: when set, the smbus timeout function will be disabled
-
-Example stts751 node:
-
-temp-sensor {
-	compatible = "stts751";
-	reg = <0x48>;
-}

-- 
2.40.1


