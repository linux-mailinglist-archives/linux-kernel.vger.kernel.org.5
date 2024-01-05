Return-Path: <linux-kernel+bounces-17926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17125825536
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D46B22DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D231A73;
	Fri,  5 Jan 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK553sK+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4A3173A;
	Fri,  5 Jan 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d858c56cbso18544205e9.2;
        Fri, 05 Jan 2024 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704464862; x=1705069662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=NK553sK+4uuIBdPyTolPDK+7n7ld/4RcnYm+DtHG9TqWSWO3pu5GzFj0Hr0eP3J4S3
         VUaExr+qRDAh82orSSBYcCMuXuJFityUHw3BsxO9ffEqoh4ETYBCKK8BeGpYtl788qJN
         +0psRhiXVjkaD8DWGWDQcTLadci1dB2B+I8cxyObIhKDUZ1R4FAANKj3+pElvdIZgD1a
         3YftQaJBEHQ74pavkN2R0y1RMUEIXpWccomrNLi7tlDaUwCiUhLBH2ClNoIwk0tpYfc7
         akdSHyAdDt4HG5mRSb6Yg2FAx2oz6dRqy2mbolvQ2tNgYOyvYnhzF/JGJ0wRgzoNNtJF
         C0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464862; x=1705069662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=TKs+9ZRf+rzlIS9TpuuOzLZHzxKE/0H9hfxk/6GCMBivAP/dTEISzR3P1NfHhTwqzX
         QqC5fSp6L+gzZFZuqkpYiOE0xkky4wbiyOPhz2cV8ZIpkEbeX8oTekO9y9YM5a7PWb8o
         tb7s2JZyvKEwqxzxnQvRIimocItXitY+J5blZsIodjV9cgmcbqAQ0uNLjsAFa8POOvwi
         3C36cQNfPO9XGdORO1bB/pWQOsS1nqIWq8J67ZeMGmigned94T+ZMAsN8BSdMsdPdaZB
         5dGWnB3sT4ZrxutlUr9eLBlhvXr8n1wPXVAA+b1xgAM4KEefvdkOGLIhSAixp983nOXg
         lK4A==
X-Gm-Message-State: AOJu0Yye5Iv8t4s7twydEtGZ2nhr09UTigSycIAhVy7Z2hvipA50T1wM
	zXK+H8R9z62L7Wwx/H7so1E=
X-Google-Smtp-Source: AGHT+IGGsLyPYfOv9s/YfB86lGFokEk9GtTmSNKzVc3LliaoZySXZPDYuYiN7aiPHW/bQicdcxY78w==
X-Received: by 2002:a1c:7413:0:b0:40d:6f89:a839 with SMTP id p19-20020a1c7413000000b0040d6f89a839mr1248904wmc.30.1704464862043;
        Fri, 05 Jan 2024 06:27:42 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c190a00b0040d87100733sm1721901wmq.39.2024.01.05.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:27:41 -0800 (PST)
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
Subject: [net-next PATCH v9 4/5] dt-bindings: net: Document QCA808x PHYs
Date: Fri,  5 Jan 2024 15:27:16 +0100
Message-ID: <20240105142719.11042-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105142719.11042-1-ansuelsmth@gmail.com>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
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


