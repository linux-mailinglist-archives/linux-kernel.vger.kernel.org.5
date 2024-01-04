Return-Path: <linux-kernel+bounces-16554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B009E824024
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC22B239F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF72231A;
	Thu,  4 Jan 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkwODBTd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC821A10;
	Thu,  4 Jan 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33678156e27so285908f8f.1;
        Thu, 04 Jan 2024 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704366094; x=1704970894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=IkwODBTdRjfqZg5mBdsOi7bt3HyGRizBgJpmA75p6sxo2mmEmxWFkfmWY453cfpbCe
         jqZ5YIZe4olD/A3AMqDEAy7OQVYPyUkd2oSWD8UMR9cHvqU/L2CYrzDnGVysDivnnU9q
         udYXUZFnNSn5EsobihNGrKCInzaZQiaaV6B44BIHzSDC3KTGJ4yDOC74sfzc1WeGFhYo
         lougrjIsvts1Ne56BM/Mdd0i1oc1g23Mm/oo4zgkZ+mB+JQGJPuSNWkgzxazbIl/Qyx2
         kviPK1JC4Ip9fj+46vubSYNO3k6IZw1tHy41MlFGNikFJk3/hoFsG6Sj16FCNZZXRkO3
         NLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366094; x=1704970894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=NDRcs/nG+POCz8pbKDrwO6w7oAZ8HuY72zPVWaL+OjOYwXfYocFLcAEG/nW6Eiec+1
         JVVPKAIHJNyg/bYCJ9/47NEqYp6v0+9F7Ltp/L5Dhht+7LN+MOD/mezRaoZMg/iEVDuT
         IGEgLPisUchWUtWoPiOTHPbgyA/vYNj3pekShB3ko4eEpJtFJdvR9YkOTuRRFntkcR4d
         j/cKwDlHFzY+eIXj0BMMRQNadn5v9G65Yfg4eVsDdKOuP9lpGGDXewiCh6PogQF40PnP
         8NgLyz7VFrjg6YUGjwF2fbMwj5d2vv8bLS7TtdjGcDBh6pEuv4HbTUreJawX51PjX+Q0
         ImVA==
X-Gm-Message-State: AOJu0YwWFwW8IevfnONTZ1+aYH/urtexY0BGU5hLPN/t+2v/O7WEVgIg
	5HhZWbSpvD5IUEXgkFT20gU=
X-Google-Smtp-Source: AGHT+IFrHuMStHtW8JuXZPy6rtA21RRQgQwMRpG8h1qwXwbb3sXCIQ5uYc9veHRYzesH3twUMNaHng==
X-Received: by 2002:a5d:40c6:0:b0:336:71a5:443e with SMTP id b6-20020a5d40c6000000b0033671a5443emr297161wrq.7.1704366093968;
        Thu, 04 Jan 2024 03:01:33 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b003373fe3d345sm9550242wrr.65.2024.01.04.03.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:01:33 -0800 (PST)
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
Subject: [net-next PATCH v8 4/5] dt-bindings: net: Document QCA808x PHYs
Date: Thu,  4 Jan 2024 12:01:11 +0100
Message-ID: <20240104110114.2020-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104110114.2020-1-ansuelsmth@gmail.com>
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
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


