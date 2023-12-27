Return-Path: <linux-kernel+bounces-11919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466CE81ED8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0287628344A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DD2E63B;
	Wed, 27 Dec 2023 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8GhsFJr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F02E407;
	Wed, 27 Dec 2023 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3352b525so58334585e9.1;
        Wed, 27 Dec 2023 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667793; x=1704272593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6LKt+ontTXHu1XtoIYFtpLE+AnFf2w4c9A2s2xTblA=;
        b=P8GhsFJrg3KnxF4TjqMeADZtTChnf7D2qUx3FcRlb8LUoChinSsCvo6z9YgvytqehG
         o9J+VdoZolrFowD12HKlXPtTmcal7ojQyddltcjA9aCCly89L6MFwEpB3AKHfMQVAf6g
         FhZhnqM22ST4sExTdILcRQZbY2qrhkVqqfHcIhZrYM3a+7oApKRlFVFwzPHQsSxb1tK4
         GRV6SFTQm3LClZY/lXQxl1drETccUUKeeNEzGrKag0r5oFqVlmtpE66KV8EAHH62ssvS
         1fP43K8us0069y0MT24ARFqMG1QZdI8Q4zRwhrOeNuGJxMkVBFz9N18YUinxnX0cXVFp
         22kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667793; x=1704272593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6LKt+ontTXHu1XtoIYFtpLE+AnFf2w4c9A2s2xTblA=;
        b=wEao2nRqwouaWTEN+B1+UcA6uSMVe1qek6aNAsoZcMy/2euAEoNsEj2LTdiLqGwNXD
         eaEMqSDvcl4mXBTjwIiecJ7TFMApmG15ZsSWDFCewejVRN9tHL+I8+Xh85O1mpwVtBfS
         pFTwm8rGEEhan24FytOqck0STQ5kVND8qfUN/wci6/4C7GZuyYL+OVRyYJoZCDuK2Jy8
         i4YNAl6dV/QsCm/BMCrIe9wt39bA3e6K1OWg5FLU/CNiuJ+SWcSTOffJC4yiysvt8biF
         +g4k69iKlqIQCzfKYBTtiIWQWc6APjCI9Md0OyxdCrCm9QEmgEu76gDhSMvAoW9tpTRb
         KQ0g==
X-Gm-Message-State: AOJu0Yz1yyUA6fGVDv+1oBQSvrQUMOBUXVAqVwOOM05pvDlE/azQgOoQ
	0j9GdxwMa2GhGTTL4iAso7o=
X-Google-Smtp-Source: AGHT+IG8mHhNfgK90bB/CfsGqDGPIVH5z9muWmeD4Vnd+0RauHcX1m+CzQx0/hAokpmViinA+RwFjA==
X-Received: by 2002:a05:600c:3c90:b0:40c:2d78:c766 with SMTP id bg16-20020a05600c3c9000b0040c2d78c766mr4563795wmb.134.1703667793645;
        Wed, 27 Dec 2023 01:03:13 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm13616525wrx.15.2023.12.27.01.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:03:13 -0800 (PST)
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
Subject: [net-next PATCH v5 4/5] dt-bindings: net: Document QCA808x PHYs
Date: Wed, 27 Dec 2023 10:02:30 +0100
Message-Id: <20231227090231.4246-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227090231.4246-1-ansuelsmth@gmail.com>
References: <20231227090231.4246-1-ansuelsmth@gmail.com>
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


