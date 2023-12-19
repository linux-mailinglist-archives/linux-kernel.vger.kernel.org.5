Return-Path: <linux-kernel+bounces-4855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3098182E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730E81C22D44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC113FFD;
	Tue, 19 Dec 2023 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoqsPakE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC7125C0;
	Tue, 19 Dec 2023 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ab37d0d1so11144265ad.0;
        Tue, 19 Dec 2023 00:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702972843; x=1703577643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOZzSaVaMqP62u8mgxMvUWOQQW2RgidzNjoPhxKi9x4=;
        b=AoqsPakEnJyEmWf4IhpN3yESVW9qftThDvo/LO3lMa+gV8W4IzCID5TYvZgm9HQFKE
         smnmABEBjFVrhvaJILaauZ53aZnPKoAXGMIQnUIfaeamUBuWgIbkZ8xs3DbmLY8jXTaO
         3U7RJ7/jZmB2JZ+R2lSyKpc0WoTY/x7Wi8fvV96PskG3geri6p4N5RkTDRBIT9BHoRXZ
         UB3Xtx20VnqXnrsvO1PaGHCrkHU6OlqvIXmqYn9byD8YeCNLKyXknWLXoyYWyXBpnvOx
         KcC4d9xDOVqSHROmNEubK1XIMVRwsNI8G03+ipwAtnN1cTqobqwVS4ldPFvjJ7tm/Aix
         SEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972843; x=1703577643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOZzSaVaMqP62u8mgxMvUWOQQW2RgidzNjoPhxKi9x4=;
        b=wE6g+pBeRsU0EDihel52WIP0DFIolQSW6Wd0MoLokrXuN6nES0ucbjkZ/TcRiWlZJY
         0sVKMhJupxg4xQfY3kR7qZLASk/c56v1+glXrCFcEqSjp6sEZMZmH5pfwc6KrqsZdc5G
         YBr8bxjh5HzfpMGERwMBdWCC/LaBeIdmQLRW1GdFVYd0WNSyWNMECFWHPbduNSdXdPSW
         /WEPVcstUDmuHNrKmiKDDqpfsLFrNkmRXpcxM9O1NxhxaGI57Q9e87GgILKWBplsll81
         ADNV8Eh2nmzOPNaSo28n7cK2o4LPyS2pCb6niA1iQ2XBn1nLai1+LV4HyISKf4D3zFlO
         fUSg==
X-Gm-Message-State: AOJu0Yx4/lKmndemOA0b6LkuMjLcDpM6sxs0WbdqjD/UZ7HldARJy/r/
	CvUNuo3JJnXOZ41eQz1ZALE=
X-Google-Smtp-Source: AGHT+IH0VvfqWms+bmMT/nn3hC6lX6XQ1orzmhbBntVAfT7H3tgAEtsA7iwQmmLCXnbugb3HBZ9FYg==
X-Received: by 2002:a17:902:e5c5:b0:1d0:90bf:cba2 with SMTP id u5-20020a170902e5c500b001d090bfcba2mr10415906plf.73.1702972843261;
        Tue, 19 Dec 2023 00:00:43 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b001d0b410271fsm20261005plb.218.2023.12.19.00.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:00:42 -0800 (PST)
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
	Bonnie_Lo@wiwynn.com
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Date: Tue, 19 Dec 2023 16:00:20 +0800
Message-Id: <20231219080021.2048889-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219080021.2048889-1-kcfeng0@nuvoton.com>
References: <20231219080021.2048889-1-kcfeng0@nuvoton.com>
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
 .../bindings/hwmon/nuvoton,nct7363.yaml       | 62 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
new file mode 100644
index 000000000000..8928e0757f24
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
@@ -0,0 +1,62 @@
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
index 9104430e148e..c4081a45445e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14838,6 +14838,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NCT736X HARDWARE MONITOR DRIVER
+M:	Ban Feng <kcfeng0@nuvoton.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
-- 
2.34.1


