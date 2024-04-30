Return-Path: <linux-kernel+bounces-164379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2238B7CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F51F22EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853A17B500;
	Tue, 30 Apr 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fThv5Yoz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC42628C;
	Tue, 30 Apr 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494618; cv=none; b=KT8t9Tr7K5UgX0EWwgOwMXliXHvlRQh/szVyDMPedd/3mQVMPOpev7IDMLXYfINAlPxPGwFeGD+GMyc1jdBG05SyI1m3RMd328L9wvbzGgKuneOKTIyXnCPjK0pwAMmme1C+iHGbgV6nZvZhaluuX9DRxbKTRU+JuuihQlEthTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494618; c=relaxed/simple;
	bh=hPDh075JBpq3peh9Fr0V6GtyB2F0d/4Fij2IT6owDC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0lIpmwZDunoN+Pj62PL8e+8aBM7+ujt6SBEooSIKMoWTCqUhMBN5nBrbvjdPviFfIfmyL6hYi3luMcyICaaoV78iuWOoa7yNieCcQgFBOt4PD+XT4oUi98/pkO43mL+Tsg0n92iEFOygFKnJGf/87GBEMSkx5J1i+j4e9AkXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fThv5Yoz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso37084145e9.1;
        Tue, 30 Apr 2024 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494615; x=1715099415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSiIXjI+3kMzFgnCbJIBlPNQooVamTjjn6nT5fcwssI=;
        b=fThv5Yoz/bRu3dlw2AphareO3UAfSuonWE/kKz2rubkC1rOCl0dhYgQsrOP99I4Ncl
         TzLReSlWUaE2brjDjSvZjw4bbAuMliiR4oEK9tmGyrJaWK2t3tPmOtWEvjeBh+gprn14
         fH6pdBSpAvWRA41movCcuBPOlB09GIRK5fyhtvlyTpKEkszZk/tAW/skwjg0j5ziSN0n
         tjP0mCqUI6MZrum9RpcFrPPsCi6efQAYf28Z4P7+nZWqHKb2Zodc9qwXSQIMKlSCklYY
         orAmXoCduZo9XDUiOAu6uSK/4lFk8IcjyBqYiLfNgCWgkIEPUZ0+bqIBUGGEFdpUNci9
         maHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494615; x=1715099415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSiIXjI+3kMzFgnCbJIBlPNQooVamTjjn6nT5fcwssI=;
        b=hQUGQ81yVzLLaUqlBdqDzSgX+D5M0ajIp+HFck4W8YF3FroA2+O2AfwX6oXR/E2aTd
         1lI++XMtR6iIiXlv5pfzgJASWNxQeZ8nOlp0gzCACLCEI3dtRf0GXbcHCJvClT8OHef9
         Jp1LffROgeGPbpMr5gtK9kXYR3jnHogGgzX5uKUJ07NGD504Waucd/drJZHVK4izmY/7
         2G44MvdJ19CRD7QVRsJrWuQnFovqlBimzyLX6JAjYFMib4rDX/9RNHqiBennAnKMb5iB
         5mzLQ5UnW3ocRL5QJgrjBzi+moAQh6+83nA88eI+9SHHnwZlZTeWFb3B4rPRVlh70YJp
         h5aw==
X-Forwarded-Encrypted: i=1; AJvYcCWR4do/w2ANdQZnovvFuRGVfZZ/JloSvYkt56WN/C06hAicGy7R8q+7TppYKOVUulgLTKwKjhYMsr9hvXArPxPuhrFth9SpkU0V/KhLEk5JAAXI/mUnnJ7QIp06gQj6VVBfaaPA/aItV3vv+4TSI1hE9k4+icQ7gc4Fai7KSBJoeOAznQ==
X-Gm-Message-State: AOJu0YwjiQTMDgbLgTnj3FifO57TaVB7YuCwV2Vl7sHs+h1VWzMLW0Gh
	N+DPukt1idPw7W+LZMArfXp9FF5h+wUZMNksz1VgEaycUO8C5XMv
X-Google-Smtp-Source: AGHT+IEdH0D0AyA7UtxHVmWL0a4oIcy/fUNed5VMNJU6BoeJuWdxOQPWtRJEay2zJ53iNX26DEaqhw==
X-Received: by 2002:a05:600c:4e09:b0:418:df23:ae0e with SMTP id b9-20020a05600c4e0900b00418df23ae0emr18427wmq.40.1714494614655;
        Tue, 30 Apr 2024 09:30:14 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:30:14 -0700 (PDT)
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
Subject: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date: Tue, 30 Apr 2024 19:29:45 +0300
Message-Id: <20240430162946.589423-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430162946.589423-1-alisa.roman@analog.com>
References: <20240430162946.589423-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable channels. The user can
dynamically configure them in the devicetree.

Also add an example for AD7194 devicetree.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index cf5c568f140a..a03da9489ed9 100644
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
 
@@ -89,6 +96,42 @@ properties:
     description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
     type: boolean
 
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel index.
+        minimum: 0
+        maximum: 271
+
+      diff-channels:
+        description:
+          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
+          appropriate value from 1 to 16.
+        items:
+          minimum: 1
+          maximum: 16
+
+      single-channel:
+        description:
+          Positive input can be connected to pins AIN1 to AIN16 by choosing the
+          appropriate value from 1 to 16. Negative input is connected to AINCOM.
+        items:
+          minimum: 1
+          maximum: 16
+
+    oneOf:
+      - required:
+          - reg
+          - diff-channels
+      - required:
+          - reg
+          - single-channel
+
 required:
   - compatible
   - reg
@@ -103,6 +146,17 @@ required:
 
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
+        "^channel@[0-9a-f]+$": false
 
 unevaluatedProperties: false
 
@@ -133,3 +187,38 @@ examples:
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
+            channel@0 {
+                reg = <0>;
+                diff-channels = <1 6>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                single-channel = <1>;
+            };
+        };
+    };
-- 
2.34.1


