Return-Path: <linux-kernel+bounces-1905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E296F815591
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567DE1F25A87
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0F41850;
	Sat, 16 Dec 2023 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTNln9ZN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECCEDDDE;
	Sat, 16 Dec 2023 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so1031029f8f.0;
        Fri, 15 Dec 2023 16:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702686190; x=1703290990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6LKt+ontTXHu1XtoIYFtpLE+AnFf2w4c9A2s2xTblA=;
        b=PTNln9ZNxq47pubwHBj1zIFOaJ5+FSK4RY0IYUTONjGmDGs/cLf308TNgCs5fYsGil
         1NPUk+/XYL1s1s+B5bIR6DWMP/cEgnmjDnPXzSOhXLS9Bmhf9jW1md0tmqGgQW3Uh7xc
         UyDbx5zkp0yJCwb52WQgA3YqaLogERLHmN3hKGZ/Z5B3q/VSz1PO7cmaNQ2pveNlC0Hf
         N408/Ng3jKLemY9XvaTO6pxvkm92cU5IG8sYHXjar8b4s9gJybnhAkxwYeJ+x/I+0mmF
         d4PgahQQ8e4xHryZ2yzVQu/7kC18QprbhIT1GDMjyeClUMDiHYnXSOS4vVGdp5a2eH/c
         p7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702686190; x=1703290990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6LKt+ontTXHu1XtoIYFtpLE+AnFf2w4c9A2s2xTblA=;
        b=bxqntpN7Qr5dh83/AI5dbVUapbfXIhaiURIcnMy3xTVXqbH4eHybb20Iav6Re8Ne55
         B7Mcpvj0vhr94uwylrunbHFuLixhrAOQjWQXZODO6JN4vBiZhJZOojqX8zMlFzevVN3e
         9UR8nMb5ymqR2eLQo+b4g+F9GZGOH2mp4Bc5JYi5Z627Q9v28bjRJgpueXwyaUmmFKTI
         BNuoYyV8vNXG5Nm02XgkL9KMsVflMg6PQ+v4a4915hOStr0yY8bCEAGbBE7+W+d2IWQ2
         WfZ/iTM3uIyqSc/6RHkQCIzYQpbSJ46MPRt6P0fLo/499TG/y3tOUoXRFm3VvioTk3aB
         vdKQ==
X-Gm-Message-State: AOJu0YyysONCggvTuAkh1sXHZCAE7QxSkObKTiCwk9g0avgcPtP8HkVg
	THBvc7LKsyWbG0+r/RCYYlc=
X-Google-Smtp-Source: AGHT+IEO0rwiCNwmhPDW7n5j/1ISVzS6LcoZzZ9+6U11kTQWjyTepWNdOyQk42N8xD7EXAP8JAdumQ==
X-Received: by 2002:adf:ffcb:0:b0:336:46bf:7d95 with SMTP id x11-20020adfffcb000000b0033646bf7d95mr1372823wrs.20.1702686189689;
        Fri, 15 Dec 2023 16:23:09 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a15-20020a5d508f000000b0033330846e76sm1496191wrt.86.2023.12.15.16.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:23:09 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Cc: Rob Herring <robh@kernel.org>
Subject: [net-next PATCH v4 3/4] dt-bindings: net: Document QCA808x PHYs
Date: Fri, 15 Dec 2023 22:22:43 +0100
Message-Id: <20231215212244.1658-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215212244.1658-1-ansuelsmth@gmail.com>
References: <20231215212244.1658-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation for QCA808x PHYs for the additional LED configuration
for this PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v4:
- Add Reviewed-by tag
Changes v3:
- Use compatible instead of select
- Out of RFC
Changes v2:
- Fix License warning from checkpatch
- Drop redundant Description phrase
- Improve commit tile
- Drop special property (generalized)

 .../devicetree/bindings/net/qca,qca808x.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
new file mode 100644
index 000000000000..e2552655902a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qca,qca808x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros QCA808X PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  QCA808X PHYs can have up to 3 LEDs attached.
+  All 3 LEDs are disabled by default.
+  2 LEDs have dedicated pins with the 3rd LED having the
+  double function of Interrupt LEDs/GPIO or additional LED.
+
+  By default this special PIN is set to LED function.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id004d.d101
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id004d.d101";
+            reg = <0>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_WAN;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
-- 
2.40.1


