Return-Path: <linux-kernel+bounces-9243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AC81C2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55911C24D39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9753AA;
	Fri, 22 Dec 2023 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwAyJQ/U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18B33EA;
	Fri, 22 Dec 2023 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e957e6ff50so12670537b3.0;
        Thu, 21 Dec 2023 17:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703208873; x=1703813673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVgzMXP11LrFfyI5S4+LWhcoLDmSWl1PH5/HxIr6Ztw=;
        b=gwAyJQ/U4B1Ppfe0fRf6ECbduSzm/HcDRHTQtGq2JhnrzQDHdbW/0rc0Z1/SOwcAIS
         gp6k7oK7NsTjvYb+5d0t2K07TnYK1Lytpes/ipgD+xidfTWkeRA1ZZxhTGYmGdpYYINK
         Xkn3F+8fmbEtbcmSeeAQkHjLk+pvl+K1iAtq9h25welfmr1+hA8YDt7iG3LqJmxHhT3F
         GS0bifgytrbnmjb+IN0nubPkVYqPHLOhfWSFP2xPIGeyXhEsW/1HIHwwNJ4iqienucq4
         fnjP0JZOdcEJz1m3pENM871qimrFWPcYOI0z5q+I9Ykkk6HTu+Os0jThwBGMfPS8pNq1
         ap1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208873; x=1703813673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVgzMXP11LrFfyI5S4+LWhcoLDmSWl1PH5/HxIr6Ztw=;
        b=robpYWHMeaOLDJZoKNWce9aZ9DvIqwKoej6fgjevsaY2/hjlEL6zPfx5CVKCU5xzXv
         53KguA9PrSPneTg0C2dQIIgmlcSMahULtsdCmDcsLvbDhgfNCW/iaxngY0JgCGSoVOhP
         sR7UxTt8BcCy6Wj2fQI3LiMQqYQKm6E5SyJXpnCZjmvNweI68SHUWHLeAFNOGB5Hjxln
         2jE6CPZLaDt68euJRoAnSXCZG663SbWncIbZZIV759fvYxsqgquce3xIrO/cKL8r+WbO
         UWpYJy0/CSUxFixlpqSOs26Ix/PKN/rkqN/KoTtmdeYvSQ+A2B22CgMtVgIkWDfVDLe+
         I+VA==
X-Gm-Message-State: AOJu0YzlDeZSnhY/sEVdkTqCRfFi5FbFRvft5mvh2Zgoufvrs1JVXqwd
	X1ABc2FnCnpM7cIVMcNcXL8=
X-Google-Smtp-Source: AGHT+IGJHyrDDghHjMV1+PxgJpumFV+4V/gMc+gpLKGafiPq9YwuKWa6MU4o8e5UaXu8G0QDI/oJzA==
X-Received: by 2002:a81:ad41:0:b0:5d9:1524:e315 with SMTP id l1-20020a81ad41000000b005d91524e315mr654410ywk.17.1703208872997;
        Thu, 21 Dec 2023 17:34:32 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001d3d8e718c6sm2258634plg.282.2023.12.21.17.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:34:32 -0800 (PST)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com,
	naresh.solanki@9elements.com,
	billy_tsai@aspeedtech.com
Subject: [PATCH v3 2/3] dt-bindings: hwmon: Add NCT7363Y documentation
Date: Fri, 22 Dec 2023 09:33:51 +0800
Message-Id: <20231222013352.3873689-3-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

Adding bindings for the Nuvoton NCT7363Y Fan Controller

Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../bindings/hwmon/nuvoton,nct7363.yaml       | 63 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
new file mode 100644
index 000000000000..1a9d9a5d614e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7363Y Hardware Monitoring IC
+
+maintainers:
+  - Ban Feng <kcfeng0@nuvoton.com>
+
+description: |
+  The NCT7363Y is a Fan controller which provides up to 16 independent
+  FAN input monitors, and up to 16 independent PWM output with SMBus interface.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7363
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    required:
+      - pwms
+      - tach-ch
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon: hwmon@22 {
+            compatible = "nuvoton,nct7363";
+            reg = <0x22>;
+            #pwm-cells = <2>;
+
+            fan-0 {
+                pwms = <&hwmon 0 50000>;
+                tach-ch = /bits/ 8 <0x00>;
+            };
+            fan-1 {
+                pwms = <&hwmon 1 50000>;
+                tach-ch = /bits/ 8 <0x01>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cef2d2ef8d7..53cfcc629aa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14837,6 +14837,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NCT736X HARDWARE MONITOR DRIVER
+M:	Ban Feng <kcfeng0@nuvoton.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
-- 
2.34.1


