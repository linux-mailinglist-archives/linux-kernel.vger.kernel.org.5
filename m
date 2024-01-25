Return-Path: <linux-kernel+bounces-39254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148283CD97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89243B2591A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2113B7A1;
	Thu, 25 Jan 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhnE1ePD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D313AA22;
	Thu, 25 Jan 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215048; cv=none; b=pSahgfkzxYc54yu2v6sL5S3De6INgy1VEJGdeX5iplVv+hXN9/VjQThmmNQdyvfK41mg8xI4eDI1SLb1BdJrlnIvq01qfe16by4vW+7xEkBztGWXZTOl9OK9lVPInCCf9s3S0rOPltm0E8Jiq3U9+yRef0MHAbCQKTtIg2UoZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215048; c=relaxed/simple;
	bh=VIBIOFUxPO7LgCiFnSr0vI7YWQglmyzYFWy+CroOSCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUuCuKsi7ZbSQr7swwL1rvnErIRdiXEVhgBaTQZyYQ6K+Z1i/v4wbrT7JA+kkNCeWWLpZZAkv4nrIVqL2Jqo0yHlptvpjDj/RPBZ0TcRzYJ7iDjadrXxGwoi1S8SMSV16/mQ7B73wKdDul/i9OjAn/6yddOB5Gcup+klEyi4QCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhnE1ePD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e80046264so1545e9.0;
        Thu, 25 Jan 2024 12:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215044; x=1706819844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=ZhnE1ePDCgdbSSS0p2SoyZthFld7xtCO7WljU7vUIOhEvVEjPyAvG02spg38FrHK1u
         cz7nNLOJ0ZBv5BoksKl+cqUKYiseAOwVVrAzrNx1wtH4YA3deU1zROSekwk1BLi1j1FD
         2m2DWSo3z06fLEJ2Q7IT6XQJBcgVYnVA0U/v2tSHTlAK02l//l+zOTM1GxekU9AgmBTb
         LHQ7hswe6gbiCXeePo7lPV8F6QFdIMQeK+UGuupLVMV2j5RSWJP2Lhj8FMhL1LQDV7d0
         AH16WgTv4ILAYc9bjfiQzRjIwbbWQV6bfD5HZafd3kIxkuJ/0mvFi3Y/IIkVJeSy9JPv
         EY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215044; x=1706819844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5KF7aYsnQjm8O6McJy/qfQDXWU9jFx2zhlXwRq6wUk=;
        b=fNbjryx3I1e7iQw+KNsVueKq+zwH8fPrTrqwq4PBKtAaV570Hkq8xf00Prmw4o1ggL
         w+hJs4uGpp/T7u6d+dggnetJp+/L5sAfBRrN6NNROCIXgDtz0xOqDRgv3C0UzuZVyajL
         5UY8V+eFvenCGYY/DsOfyFG8GV/k03oNt81A27YLq4JOJt3qKpqv+gHNWRvqJ8SZ1Bl7
         DLFNfkpIIGJtcwynlE7KS1y+aJJh5uHmgO6PVajZnHks/RuQmWF2h8Hcwn0/cS4CDWsx
         Y2Id8Swz1tI1uZKMLPZYw0jWscdXMKBJf4jUYEpmPTDll+y5+lus8G7xUEY0AlM3kwTe
         aJ5Q==
X-Gm-Message-State: AOJu0YxHAR0PJj3lTMA3RHQTiN9ImMtixG0+7/YCUjJ5odjAqEgfAzeC
	u8rkVKIVjzEkqEsBqg4PQQ/8SOw4HQv/Wc2gqb32VEjK1KM7V6bV
X-Google-Smtp-Source: AGHT+IHOitBxww52KhSRQ1rb0UocH8/Hm/gFoZcjrZdDVyqo9mvxX+NYCzJ3hM4RB8fZ/jx/2Ulj9g==
X-Received: by 2002:a05:600c:444a:b0:40e:d436:9644 with SMTP id v10-20020a05600c444a00b0040ed4369644mr183943wmn.117.1706215044383;
        Thu, 25 Jan 2024 12:37:24 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm3817700wms.25.2024.01.25.12.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:37:24 -0800 (PST)
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
Subject: [net-next PATCH v10 4/5] dt-bindings: net: Document QCA808x PHYs
Date: Thu, 25 Jan 2024 21:37:00 +0100
Message-ID: <20240125203702.4552-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125203702.4552-1-ansuelsmth@gmail.com>
References: <20240125203702.4552-1-ansuelsmth@gmail.com>
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


