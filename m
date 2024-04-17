Return-Path: <linux-kernel+bounces-148962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A048A89BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82FB1F21F66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C19177983;
	Wed, 17 Apr 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0RtsMps"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781317335E;
	Wed, 17 Apr 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373285; cv=none; b=hV8Q4i5Iqa7mI3zyKfDPR5r6DgnkTyqaY/+o57JqmARvZGQwRDcV2bLMyIdkPx0y8hKgpxSF9AEyw6oF1xxgl+Y1iehS4BR0hnd/ckt7c/nk4qsHkykHdslkQ/q5T8Gbek1wqZKJkcrQqtYoeVt4Jpzdnq2ArBQVS1ELIm823IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373285; c=relaxed/simple;
	bh=HeNgvg0merXOvICLIdduBoIju+D5EL2ctk64FGZpyuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ho1vqW6eIQJXKBnjEetySVnEcsAHmFB+HH0zdWf+euD+jaZlFO3aQAnhITunk8nhxcJxhy48fkq+1hr/SLKfGQljzZP41i2OlkIdxQtp9ZhI24IW5JvHuGhzGgaTxemUnk55GqRkGUJdYBYLkSfWImYGLIuqbViiD1DkRXNGkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0RtsMps; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-418a2de4d8fso11595705e9.2;
        Wed, 17 Apr 2024 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373280; x=1713978080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtgVF9SCtDu/QsYS3bPqYpnMCKPhrvap137EfB1aKuE=;
        b=a0RtsMpsrUh2zAUX6MJ5ufdDEzL43jCPMctCkN5xMFv9L8nFUvKedJJEi7WLxuGDan
         dFFQkSGlfMpAlNqXcuSzn2PLEekQeDrVviQ1JorW4bQECJ/c0YU0V11sRaU9s0B6y+yX
         Cj9oaoqhV8Kj3V2DuN281RB17Jss1oOBP6RLtau7db+h0laXWxkl9F/Wo6w4JaTu+RlF
         S0namDm0tIUoKsJx2g24stS2rk2HG/VQRFppmYDLBY55DgSHroRwqsAcpvhK048LP4QB
         OMeuYAwCh1l9fJvTYtD45iXI80hPIpKJUlw6nAwKJAlDwSDHmLottUg9LKCJ++4nfgaR
         G7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373280; x=1713978080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtgVF9SCtDu/QsYS3bPqYpnMCKPhrvap137EfB1aKuE=;
        b=ht2ezmIe7Wc+9iCiQ62hmfmc/AAnx4CE6JqWdK9yhdHuqP3XjEBuXU8aFk+HLyw+Wh
         9o2zWYoFPqV+L/2oe6CtnM2b7vz5DJZeRM0yPel660fVmzwj2cEazS7fzjKdlKKO+ApK
         EdYjzk5eqMCpe/GASw/x5ZYafb/W97xu1yX+1UWqSxzw3by9Ck2BrCK5e3llNN0HzoTe
         tko0pJVua/QxvML6wTsm/JSD7OAbv21E7g6x+lz8vsP5K4bzuDxsVhdEOk5CWwolNxX4
         4RTPcAuJWcyHxZsSwRWNtHWgYvcIzaPhYBET3a1lXamrVTj5EmetZIT/UUgl40xHuHaL
         IfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM4/D39v6dqvUfLzOlIW6o8qjT87qGbPToG201prC7rxpMyP277VqFbmHWlsBLf0VpW4MNfO5rYGbTszJ4a13BQRpqSToyq12ZQTrtpq6/Rnfm2XcADJTzRZ9iZvBtdVjuZu96Es+jzZZhp7WI3GNnPKELciPC+1TuqGPrv1BWaxASXg==
X-Gm-Message-State: AOJu0YzUnagBu/PUPD8vv1XoBJgREs7bd0553zngoHb8PmplNtt5YO0Y
	oZ5vaRpoHedLuzAHk443rTUAl8utTCOKh7zcSa/0b0U4v/3bsYOX
X-Google-Smtp-Source: AGHT+IFh/7u4KRBpvpRx47rZgfcnINcUca+nHPyvqq/eTvyQmNyronxH89zYvQXR+PZvwpsDTwbbMw==
X-Received: by 2002:adf:b35c:0:b0:349:bd11:1bea with SMTP id k28-20020adfb35c000000b00349bd111beamr1792268wrd.11.1713373280427;
        Wed, 17 Apr 2024 10:01:20 -0700 (PDT)
Received: from spiri.. ([86.124.122.31])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm17949441wrp.49.2024.04.17.10.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:01:20 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v6 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date: Wed, 17 Apr 2024 20:00:53 +0300
Message-Id: <20240417170054.140587-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417170054.140587-1-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The user can dynamically configure them in the devicetree.

Also add an example for AD7194 devicetree.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index cf5c568f140a..7e4e15e4e648 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -21,8 +21,15 @@ properties:
       - adi,ad7190
       - adi,ad7192
       - adi,ad7193
+      - adi,ad7194
       - adi,ad7195
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -89,6 +96,30 @@ properties:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
+patternProperties:
+  "^channel@[0-9a-z]+$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel index.
+        minimum: 1
+        maximum: 256
+
+      diff-channels:
+        description: |
+          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
+          appropriate value from 1 to 16.
+        items:
+          minimum: 1
+          maximum: 16
+
+    required:
+      - reg
+      - diff-channels
+
 required:
   - compatible
   - reg
@@ -103,6 +134,17 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7190
+            - adi,ad7192
+            - adi,ad7193
+            - adi,ad7195
+    then:
+      patternProperties:
+        "^channel@[0-9a-z]+$": false
 
 unevaluatedProperties: false
 
@@ -133,3 +175,38 @@ examples:
             adi,burnout-currents-enable;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7194";
+            reg = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7192_mclk>;
+            clock-names = "mclk";
+            interrupts = <25 0x2>;
+            interrupt-parent = <&gpio>;
+            aincom-supply = <&aincom>;
+            dvdd-supply = <&dvdd>;
+            avdd-supply = <&avdd>;
+            vref-supply = <&vref>;
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <1 6>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                diff-channels = <16 5>;
+            };
+        };
+    };
-- 
2.34.1


