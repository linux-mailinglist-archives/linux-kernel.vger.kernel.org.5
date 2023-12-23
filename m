Return-Path: <linux-kernel+bounces-10497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740681D50D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F4C283E18
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98748FC18;
	Sat, 23 Dec 2023 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epbYbBYF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9C412E47;
	Sat, 23 Dec 2023 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f7da00237so15226236d6.2;
        Sat, 23 Dec 2023 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703348597; x=1703953397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gN1C0/FECgYaWd9/ml0UCwKbnXOAYhuskYf//YVVLoA=;
        b=epbYbBYFD/6eyE/qP7zDAg1vODXOPpAtIaJLP5yXk1rPiq/t+pBQfponBtLOYjm42h
         4wWfkmBmdH+/W1DZCnVSzkGLvdF/TGRJ6XriSt/0MzcjlaWepUFBCG7OCZiDV7mPuxc5
         6ZQaLmWzDymKKaAgXo0ObgZwrf3eQsa4oAx1PMRZUN+0aXdOEObZCXq8pIua4IXt6iu1
         FRmjaEIDGxYvK9KssRKjmTT7rBN4r86B8HFSuMGyN94wyBzHyydM6ftmNlZfRdM0rFSQ
         tdZ0gOzcs9kV3s9I5WL5TjthOhr/A4TtAgxt8R4cNxFxNzUBY+gHxSCOlBnFu56/H2Dk
         fP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703348597; x=1703953397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN1C0/FECgYaWd9/ml0UCwKbnXOAYhuskYf//YVVLoA=;
        b=ViO+7rU361DVtGcA3Vz2zYcJIGk/ewswVj+Bxux7ym6DH2qusKdgRKNtr8cI9T7sO2
         Hg1GUrnzru/gRs9/voxanzVGoCWzTf/sSO2pWN4XZiGgql/HveeVIjKa6UUCM4mHd6Pb
         ++eB6dA6bqKCkgCbgq33oZhET2cJ1khxMT9pm+BzsjBFPPpreI/MfUhQGdeWyCZ0+txT
         kcuUj3Vi+e0PluLBmWKcw/XWlAhLZ1mJ2UFx3+WENtv3CRW6MkGsH6oD23EDijsuJVRH
         a8+5+ElUalz+Uo9cZgw+qMQBVTbKCcZQ5f8Syct6J9V4GEVN+Eupek7zCJfN5ooy3RdV
         bJ3w==
X-Gm-Message-State: AOJu0YzkO7Z67apQxEXdRp0fN8bcfOXjT3or8WHQclH9HPo9avVbSZ3/
	P+m4kGK83Apaj7Ynak6y1zQ=
X-Google-Smtp-Source: AGHT+IE3HKrZsn4TtLmV+cDv6A0B74MDSpHO9FZH9zzlKNa4S4tMBxoSfquARHXksNoXUL7Tq2Yicw==
X-Received: by 2002:ad4:5f8f:0:b0:67f:63a5:b3a6 with SMTP id jp15-20020ad45f8f000000b0067f63a5b3a6mr3702191qvb.131.1703348596902;
        Sat, 23 Dec 2023 08:23:16 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id pz11-20020ad4550b000000b0067f969a59c2sm1247116qvb.61.2023.12.23.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 08:23:16 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Abdel Alkuor <alkuor@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Sat, 23 Dec 2023 11:21:58 -0500
Message-Id: <17ba2dfdb3d25bf1b5b4ed9f858b6e28902bedbe.1703127334.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

as6200 is a temperature sensor with a range between -40°C to
125°C degrees and an accuracy of ±0.4°C degree between 0
and 65°C and ±1°C for the other ranges.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v4:
  - Add chips that support interrupt
Changes in v3:
  - Enable interrupt property conditionally based on the chips that
    support it.
  - Fix alignment for the added example
Changes in v2:
  - Incorporate as6200 into lm75 bindings

 .../devicetree/bindings/hwmon/lm75.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 0b69897f0c63..ed269e428a3d 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - adi,adt75
+      - ams,as6200
       - atmel,at30ts74
       - dallas,ds1775
       - dallas,ds75
@@ -48,10 +49,28 @@ properties:
   vs-supply:
     description: phandle to the regulator that provides the +VS supply
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ams,as6200
+                - ti,tmp100
+                - ti,tmp101
+                - ti,tmp112
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
@@ -66,3 +85,17 @@ examples:
         vs-supply = <&vs>;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      temperature-sensor@48 {
+        compatible = "ams,as6200";
+        reg = <0x48>;
+        vs-supply = <&vs>;
+        interrupt-parent = <&gpio1>;
+        interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+      };
+    };
-- 
2.34.1


