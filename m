Return-Path: <linux-kernel+bounces-2999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99A8165CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FEE1C2213C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179363DE;
	Mon, 18 Dec 2023 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiHBXoWc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399E63A8;
	Mon, 18 Dec 2023 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4260b657ed5so27341821cf.0;
        Sun, 17 Dec 2023 20:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702875211; x=1703480011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaTyomZwxtPir8w34v7twVd3Xf9J4c1d0y7WayfPqp4=;
        b=XiHBXoWcyb5khBc+o+EWX/b9MrYLY48yDetaQ7IbYDolPHbBQ+T0K5B7pYPWIsAm8g
         tBnQInDFWwOzkU0B6l6UVUMCWwnsBzPYvM/zwp+J2A+dH3kAFSfhyfZ4ib8WaX27az1p
         114RZEJVnx0UTMI2b8e2fY7NDmM3Cyx1AtD0nvhoIB+qd3xnDEG+8hOKEdGMWOc0tqCf
         H89N3VEA1t/WqAYYhnBTnNzNZdNenFfrwPRx/HUuY5HSOQyHUv7fg3P5lOZRQ9e42R52
         eRo1C8A/4LwkACyhyCP5zRzg/AZ6iIhrfnf57L7yC5zSDvLu67YURlcZj1We1Knui0Dn
         GpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702875211; x=1703480011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaTyomZwxtPir8w34v7twVd3Xf9J4c1d0y7WayfPqp4=;
        b=IyCpPiv8t4nmx+53hD4i0AHWTJDVP20nO8Wle3VIB9PTziC8tdXohL4CkCdNlFagHi
         PNwXNdKV6TGr1h+klOOijobqMqOevZvJH+X2McokFpThU7ZexRlx7zlzbocgYsj2WkCN
         jEY/QYR/0xGvn+S4fJV9RXzyCGDVtPfk8L4jYAa+Ctfu3jKergUYlirKkG2Sdp+1yAwY
         Igx8ubsazqSgNXeSYoIxWagB8W7wtsCSZsq7Q9JbaVcJaBK01JGX30nd5BIVYrJWTAPk
         7O7bqtUWyEd3OOzVPtJPU8Z5QfcGkSR1Dt92YyA4IGcAClj2qiKtce+xs5fiKOMO+oMV
         76uw==
X-Gm-Message-State: AOJu0Yz8DJnVAq03mrEKMSy4ElMtz3l6nc7Neh8eYdBVi9Fav1+/gbqd
	wLv0ahRmITIXHNu9xt+XFoc=
X-Google-Smtp-Source: AGHT+IHqmvmG1RooZIHAiqujufEWGIlTnBa/UR8xSxVd32Rv533h8teIaKMjcQNAJzaNQlN79U08IA==
X-Received: by 2002:ac8:5a43:0:b0:425:4043:50e9 with SMTP id o3-20020ac85a43000000b00425404350e9mr21054133qta.120.1702875211144;
        Sun, 17 Dec 2023 20:53:31 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id fv5-20020a05622a4a0500b004275e9cdf15sm716571qtb.11.2023.12.17.20.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 20:53:30 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Sun, 17 Dec 2023 23:52:27 -0500
Message-Id: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
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
Changes in v2:
  - Incorporate as6200 into lm75 bindings

 .../devicetree/bindings/hwmon/lm75.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index 0b69897f0c63..63b85a83ac18 100644
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
@@ -48,6 +49,9 @@ properties:
   vs-supply:
     description: phandle to the regulator that provides the +VS supply
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -66,3 +70,17 @@ examples:
         vs-supply = <&vs>;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@48 {
+            compatible = "ams,as6200";
+            reg = <0x48>;
+            vs-supply = <&vs>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
-- 
2.34.1


