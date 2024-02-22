Return-Path: <linux-kernel+bounces-75978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF385F175
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0E1C2114A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA117BD8;
	Thu, 22 Feb 2024 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlujfPRz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3202182BE;
	Thu, 22 Feb 2024 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582957; cv=none; b=G7VguSG/hA2fbPV+wyhU43OxqQxUKD3ehU5y1390YnxV9MjTFFtLJOM5PFWUroCbZY+NV6CMppMI02IyVMkKV0yh0v+lCVP9x+yD/BIgfn5BT9XnX1jS1WTAUlwKuW2Aq+ibrIt0J8acVUIiChDIykDstKD6TLktv4e69KteVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582957; c=relaxed/simple;
	bh=vIsSLGDNtUSIiU6tl1KOY8sKDArMa+47j5IPg6SrZSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Brci+1KOXB3DeKFhaijXvKVSpYGbpr7bx9ypNlsP4gyTYcol+nIO4iyDArhIOM1+kjIF97khxKElHYDo9d7ZzECZqH3M1afdZPP9KSuUYL0IOlmfLyGPVzB8TGPwYQo/OkCcaewWMOdbDN6gps9e5VR+antw88ynbbxUcJRkyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlujfPRz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512db550e3fso451356e87.2;
        Wed, 21 Feb 2024 22:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708582953; x=1709187753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5JGI2+oNzQGJrEAe98nuh6vyQ6RUCgO7wKW8s1KZo0=;
        b=hlujfPRzdzi0RhjO+E36UzZlZZ0Fr6woxWpZPdEzt5HpS3LfkHTnzOvJMd90SRyFOQ
         nFDtvNJky14iVlSPFyz9Xs4ZIQzT3ZfMENk4jFjosBWlC5P5+QG9znyNIDf/EGsdNnKQ
         1q2oFpSKDfbCM6Ltsbt/LTmDfw+lPhqOUMLVseS1H1ISIAC80/UntgRtKoHcH4usiibS
         d205VDi8lhbXsOHgN+uWWdHoIYNcj6CfTS9hHaQdmYpdUcVnLNail+bAWDtW3Fxo2G9n
         7L+J8ubX/zbLdTzsDX9PVynmg8/R4L+2UPJm2DWvccLY6N2GHhNRT96TfG7iEyzzQSS3
         md8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708582953; x=1709187753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5JGI2+oNzQGJrEAe98nuh6vyQ6RUCgO7wKW8s1KZo0=;
        b=k3zfdLQ/8XjpHY0N+tU3FhoAWyfed/H+N4F/q/HCgxE3EheGWqepBLrdMy82F15O1V
         GMQkdAvtWBo7YGbvPbDXtcJrcFyDEADlx7zTOphxB58OtgWqSW3Z9w8xXlXqUTuIkxsu
         Xn25O3r2dEforP5AbLPwCrLuLlYWif/OD5Vwfw77Mz3EOumqzl77NiQL/kjnS7ThZv5k
         xS2fLkZ9wE3cgdSXAN64/qAUoCpD778DdyExkfIE3VUJjMkfpSoPJv3zaZY0m9ac7QVf
         2m1Dva5KTKWBDGV72Vme00DrmtFn2jM7rsJ1NJ10bpNlR7aPfvEcQVMZtef2Zo7lLmxY
         WSxg==
X-Forwarded-Encrypted: i=1; AJvYcCW+nUEJghq+8N1ndJ2XzOtoYROEIhtbNMz7ZozbJIxnOMzGl2nTyJceeYFalE22u65hKOBNWrcPXj+05mToin/cHYQCAk39P8jvZ6KbyaVGO5wS2ZrmQW/vwmXwkbMPCPXITIy/EUIfDC9+GMPIQNfka+1+SbyraEtTgiOuG7cDZrpDpHnY
X-Gm-Message-State: AOJu0YyaNKcMHxWnzd3jAuNo/W0p8VMcrPtIgnEVMBu2VHaQlD7scCZ8
	gVXQriHwtWugiQluRup/yAGc16+7NdFvTFEivB2mGH4QFpKLVD61
X-Google-Smtp-Source: AGHT+IGLAq4L6l7aLtp/2Z2lPkIlmehFEF2PUSzpmO17wYBPhCoxnotWSw+EQ8WHHy/GurR3/UK5LQ==
X-Received: by 2002:a05:6512:3a7:b0:512:b37f:a9ae with SMTP id v7-20020a05651203a700b00512b37fa9aemr5910127lfp.63.1708582952671;
        Wed, 21 Feb 2024 22:22:32 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c02:29d4:49b1:c3dc:494c])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b0051296788949sm1945574lfs.232.2024.02.21.22.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:22:30 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: media: i2c: add galaxycore,gc2145 DVP bus support
Date: Thu, 22 Feb 2024 09:22:13 +0300
Message-ID: <20240222062214.2627810-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222062214.2627810-1-andrej.skvortzov@gmail.com>
References: <20240222062214.2627810-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/i2c/galaxycore,gc2145.yaml | 65 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
index 1726ecca4c77..3ca5bb94502d 100644
--- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
@@ -61,8 +61,38 @@ properties:
         properties:
           link-frequencies: true
 
+          bus-type:
+            enum:
+              - 4 # CSI-2 D-PHY
+              - 5 # Parallel
+            default: 4
+
+          bus-width:
+            const: 8
+
+          hsync-active:
+            enum: [0, 1]
+            default: 1
+
+          vsync-active:
+            enum: [0, 1]
+            default: 1
+
+          pclk-sample:
+            enum: [0, 1]
+            default: 1
+
         required:
-          - link-frequencies
+          - bus-type
+
+        allOf:
+          - if:
+              properties:
+                bus-type:
+                  const: 4
+            then:
+              required:
+                - link-frequencies
 
     required:
       - endpoint
@@ -84,6 +114,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/media/video-interfaces.h>
     #include <dt-bindings/gpio/gpio.h>
 
     i2c {
@@ -103,6 +134,7 @@ examples:
             port {
                 endpoint {
                     remote-endpoint = <&mipid02_0>;
+                    bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
                     data-lanes = <1 2>;
                     link-frequencies = /bits/ 64 <120000000 192000000 240000000>;
                 };
@@ -110,4 +142,35 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/media/video-interfaces.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera@3c {
+            compatible = "galaxycore,gc2145";
+            reg = <0x3c>;
+            clocks = <&clk_ext_camera>;
+            iovdd-supply = <&scmi_v3v3_sw>;
+            avdd-supply = <&scmi_v3v3_sw>;
+            dvdd-supply = <&scmi_v3v3_sw>;
+            powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+            reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&parallel_from_gc2145>;
+                    bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
+                    bus-width = <8>;
+                    hsync-active = <1>;
+                    vsync-active = <1>;
+                    pclk-sample = <1>;
+                };
+            };
+        };
+    };
+
 ...
-- 
2.43.0


