Return-Path: <linux-kernel+bounces-143766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8468A3D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4068D1F21AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EF47A52;
	Sat, 13 Apr 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrM5Zfpk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46194597E;
	Sat, 13 Apr 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021192; cv=none; b=kqdQUYmqAlnVsUJwPwwerbGppCU/DCv3xOjOYFS9laeFqBAtgC7dFviVngFOBCoTd7lPPlqfsLD+nLpo8aNlDTiqg1izleDqIQXJ3gmswG6qCu5bXQdU6opuym+k6iXWFV1ujAYqBEiwYZbyeQByFrCd5vEJV44EdqGIdra4iFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021192; c=relaxed/simple;
	bh=l4OkHsjpSQbTmXssYW2Df8eVdehQqIlHb1Z2GfhQPSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axW8OGuQ7tAcZ+zvlIpkuM+I/pkVgTgIeTAiCfDt5RhWMImqIwu5bs+TGEvBOM0uetyKJjNFpOh7fJFnLgwVuxNRi4KADWWQixdX5De+tkI0pZr9W/2tKuSAPsH0269l+lxIZgVOsq9lfRC+NPgVMO3syzyVLcL1+qk9fYvPhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrM5Zfpk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1824095a12.0;
        Sat, 13 Apr 2024 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713021189; x=1713625989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H3yNAmRll7TZn8gfKLPpJ0eOXKDcbG9K2aasqChDaM=;
        b=YrM5ZfpkQr2EZLvOje6VMzaJo0pBlweWWcnyBnzfomrlkcnmvOXtcLmxKcTCKTYNUR
         qUZmF7KdL56iL8PemP8uHykJWNwFFuyxLJveTirOj7RVvC9O9K9ZgvzlTmNOjXURrYsV
         RgmFK2MtQxVh0L8SdWxhQNT5AZfov0+YZxXgQnl0Tfy3Ghzfj/k5MsKImaN7d+5XTTyt
         HWNagSNBgi7/zIX1TWcfEk9ctvVv3VzXdVLb7aPrkrrJBI68IkfC12V6I+/2fggt/MUV
         WBymj3eAdmcN4f+n7XsO5DbaKgkepIct7EzQ/BFNjpnD3Nsdzt09mdVYjHpzsJhwjmME
         C8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021189; x=1713625989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H3yNAmRll7TZn8gfKLPpJ0eOXKDcbG9K2aasqChDaM=;
        b=wRKBcnbq+4LuyjbiaIvDmG/rBHm5efpd39RWiARbFheOD7T0+rH4MnOiJ6tyGdWQp8
         2ew0rlWgXh67NBtnJ9N/mzDg/yrkNcgPOQMZ6TaEX6/JM0QmVubKBEXiUzoOgLNkMxkm
         lgkE3Ueh3JsqWY+4ICiuJV6+JAPRGcERQ+560LCEskvKrPiw7CpArhHCBvGVuaCCBNMs
         GuIRysoKgcqARlo202m8bkawSwns8xBZbyxxPhn64HFiZZ/k1+tzE36ZNeF88IRFMwMh
         Y45Kb1a0PD8JzA2uSQxNcujjmpkJCCG9HgSKggUKC8n5cfcB55r0AheYmIgycneY2FDY
         ji0A==
X-Forwarded-Encrypted: i=1; AJvYcCWgewle0ut7hkA63m2YW5doJVOr4B/hdsUte6favR9VXdy7xlYAADC5JbjzV6jnzE3UGnIb+gl6jEQ6RBhoAl4KRO2x7ggaiZYMFsmr5VZ2XDdARkwywzfxAbTqEKLTTqy7sK6y42b4rH77kwMTwjavjK2Ks5GUI1t6/ciwpS/pZMiXsQ==
X-Gm-Message-State: AOJu0YyOEZGPvhtgHSuQIYG74Kb2PlVrQf7v/e0K0d1Peej/AGR7Z0rI
	9vELb6Vwg/Isa0JbujzNv7ohtUuDEKY5PoX+87Zugn4nyO34i5+X
X-Google-Smtp-Source: AGHT+IHNm5EcUeA+xRebq/oyVLetAsy+FqiyWj4vdPAuVvjVSd3RYbvporoNJUp2SUPudXAoVQHHKw==
X-Received: by 2002:a50:9353:0:b0:56b:dd0f:52e0 with SMTP id n19-20020a509353000000b0056bdd0f52e0mr3498732eda.18.1713021188945;
        Sat, 13 Apr 2024 08:13:08 -0700 (PDT)
Received: from spiri.. ([5.14.146.31])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2749883edv.22.2024.04.13.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:13:08 -0700 (PDT)
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
Subject: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date: Sat, 13 Apr 2024 18:11:51 +0300
Message-Id: <20240413151152.165682-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413151152.165682-1-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
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
 .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index ba506af3b73e..855f0a2d7d75 100644
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
 
@@ -104,8 +111,43 @@ required:
   - spi-cpol
   - spi-cpha
 
+patternProperties:
+  "^channel@[0-9]+$":
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
+        "^channel@[0-9]+$": false
 
 unevaluatedProperties: false
 
@@ -136,3 +178,35 @@ examples:
             adi,burnout-currents-enable;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "adi,ad7194";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7192_mclk>;
+            clock-names = "mclk";
+            interrupts = <25 0x2>;
+            interrupt-parent = <&gpio>;
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


