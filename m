Return-Path: <linux-kernel+bounces-2277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0E815A71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E3A1F23ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E742EB00;
	Sat, 16 Dec 2023 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS3fJ1uY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5552E3F8;
	Sat, 16 Dec 2023 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77f35b70944so135070785a.0;
        Sat, 16 Dec 2023 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744868; x=1703349668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NwCwf2QB3Uutvy81bpqJQR2+83P/Yt/WlvDn7CJZTs=;
        b=mS3fJ1uY0IFKg1NrcJdzs8871YhjgSHfqoVGBnzrLfFzqkE6wgVRWM/CxE9I/UF6Vx
         OM57rFKJdnPN4HQykAxBLnNJlJQiFdgCIbc5FuYHMop0g3xNY7UXn4pPP4uddpyNeP8O
         cX1moE0ym0HNFY6qkwUfAb+pEa0tTidqTHssGrheEZeQx0FFQK/Zy9bMzoy8TLOvHPIh
         C3aPGrCyq859TRj7mhOngus/U50mNQWPR4umtB/3nc9tWQF0tld7LTF+gpZdG+lpgVFB
         PqNgDTWG8IVujRMSQQ06RvnpsL0Zj/HgdOnZLzLUQlvIfeZFJofufyN1CbLcMNlS6lbN
         w1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744868; x=1703349668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NwCwf2QB3Uutvy81bpqJQR2+83P/Yt/WlvDn7CJZTs=;
        b=TYTlVJh5gGQGpzKIKmFj7ChxRZggA3tLGHroKe+VnUZP/F5oaeasyQdg9CgaaBKLR6
         2jpcucZ+AP3Qut+4Dx/lvczGyaIIHYTiG4+ctSk/F1MvfJWYSKGRrqdprWrbzJbKr5hp
         lL35f7UUk5+qFQEEYAfjiiSOgaCDEUHptc961AMXgmnp5vAkO7inhRBVidMGgjcJZtJx
         aybekwrbdOSpo9miyzUxiFVFB01VaFVRFtsC4goePXGunZUv8nZt7hXSEL7bY6uywAQm
         ECVLsiYygl3bvAyyK10kpJ5XcAnuBpmlpVlXflg4A5rCv49WyfXAFVEOrP3LLwM8TTac
         62MA==
X-Gm-Message-State: AOJu0YyjusFg4mFduL62+YkIZ1rqsaYYmqfRRYrE/zHYimNS1CjmJkJc
	R7tVDvEraFKHHC+VV7CQUTU=
X-Google-Smtp-Source: AGHT+IEgmlVn6CVlNuorVY3VmCMndomp4TADgcI9mcdWQdpCflXaeCI6uiZ+Z2iLeENxc/CqIk4Xeg==
X-Received: by 2002:a05:620a:19a2:b0:77f:8f32:ffaf with SMTP id bm34-20020a05620a19a200b0077f8f32ffafmr10415652qkb.155.1702744867573;
        Sat, 16 Dec 2023 08:41:07 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c1-20020a37e101000000b0077d72f820adsm6861697qkm.115.2023.12.16.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:41:07 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdel Alkuor <alkuor@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: hwmon: Add AMS AS6200 temperature sensor
Date: Sat, 16 Dec 2023 11:39:29 -0500
Message-Id: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
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
 .../devicetree/bindings/hwmon/ams,as6200.yaml | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ams,as6200.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ams,as6200.yaml b/Documentation/devicetree/bindings/hwmon/ams,as6200.yaml
new file mode 100644
index 000000000000..01476c1a4c98
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ams,as6200.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ams,as6200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS AS6200 Temperature Sensor
+
+maintainers:
+  - Abdel Alkuor <alkuor@gmail.com>
+
+description: |
+  as6200 is a temperature sensor with a range between -40°C to
+  125°C degrees and an accuracy of ±0.4°C degree between 0
+  and 65°C and ±1°C for the other ranges.
+  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
+
+properties:
+  compatible:
+    const: ams,as6200
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@48 {
+            compatible = "ams,as6200";
+            reg = <0x48>;
+            vdd-supply = <&vdd>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
+...
-- 
2.34.1


