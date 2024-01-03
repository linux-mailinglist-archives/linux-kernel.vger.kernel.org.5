Return-Path: <linux-kernel+bounces-16102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456768238FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF771C2491D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3EA208D8;
	Wed,  3 Jan 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlNGmmiM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99C208AE;
	Wed,  3 Jan 2024 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso27458255e9.3;
        Wed, 03 Jan 2024 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323101; x=1704927901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=HlNGmmiMar+TmE9+Et6dmNsoqL9+OPkjfEYDBe8zDiVTjJTRUtEjg3skgDKRaJZeL1
         /yttE9CtJ72PC0iOpYkyueOE3RJUZEzifYpH2kMvRwWf93jWzZcIXv8maZhQPPrLAFqu
         PU5KvtybRWHXZ7NvM1rhBTP4fzu3zrkIPIpjd39CTx07DTridk2FMgBcQClUMTgRGSwI
         w5T1l3DoYCSydMYa6WWvA5hNHsjo5veEQUdsdbmw8ibPYbheP/zdEiphZPf318uLw3am
         t4WKQf93QPYno4HzTs1nOfVAfJ7uAEtHRwTnM9keaks+bXn0U7NUJDY9PilqJkpxbSp+
         2opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323101; x=1704927901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=U/2ij5x2tc/IpSela3w9BjZkNtwFDKUcAFNpXzVE09Yu4b9aIvSfUQWOs1jR9sciUu
         Fpmx7HwqrKHcfXpqW9ZQqv/VOuxX+cdeMFcrhfdeOKYOZPnGDwofVr5K4dnYSxxdynBG
         r3cgfxFNRU0sttzG8ZFdtTnP0KH2cXmU5qE/Aaf4pDZX8e0Q0fDcsBTQmhlFbzy9mSUm
         +TRW8/AFuyPvfg/7pncpUCFAsOBGWEM/Fnczb7re+VDTuPEFpaw3sdskozIYpcm1yv6B
         AyPh7r2qMcTBJ5q5jC4fd/zo/BNHuOs5Lq6Z4Cg4vzdhPaOA6NazzfWDxBDISRctGo32
         4M+g==
X-Gm-Message-State: AOJu0YwtOZumY1aLbVo1wwZt6teE2ZUDf6Tdb+RLnj7CRMY6lujyeva3
	6VXr9xAsJTaOxSFH3KA/sno=
X-Google-Smtp-Source: AGHT+IGCetkBY7JdDXLA34a8G8Jldfvk5R2n/RCoreTZpFT9XQru8kaPDvSV6y2iVN9jMlHFQaTEJA==
X-Received: by 2002:a05:600c:4fc1:b0:40d:5db1:7c72 with SMTP id o1-20020a05600c4fc100b0040d5db17c72mr2780914wmq.95.1704323100808;
        Wed, 03 Jan 2024 15:05:00 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id w13-20020a05600c474d00b0040c46719966sm3740969wmo.25.2024.01.03.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:05:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Subject: [net-next PATCH v7 4/5] dt-bindings: net: Document QCA808x PHYs
Date: Wed,  3 Jan 2024 15:12:37 +0100
Message-ID: <20240103141251.23446-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103141251.23446-1-ansuelsmth@gmail.com>
References: <20240103141251.23446-1-ansuelsmth@gmail.com>
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
2.43.0


