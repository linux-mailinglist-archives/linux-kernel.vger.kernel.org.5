Return-Path: <linux-kernel+bounces-16551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD1824017
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90509B23972
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4521352;
	Thu,  4 Jan 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yly/GkvZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96F210EE;
	Thu,  4 Jan 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so292487f8f.0;
        Thu, 04 Jan 2024 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704366087; x=1704970887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5mxLkh2hEgcMvbfMMh1KibA3U7+O5yTNHMAUzMLGy8=;
        b=Yly/GkvZwZddKhucgdNEYmCXR+7gFKBeryDF4QEimxcHWHSNXT1K4CjxM/MaarNT9M
         HJuQNW3W+1g+iBeko6oY5+0jZHa7Ytykt8EoRFO6EQQgzR58LTGjnel8Tm+TwG+NP3GH
         beXWK9hs0c1xlAYodYqb+7NAJJlv62xYZdM9VY6N9iIp0b5ryPL+Ey8l2fF8lqCDIzgF
         IfFXXQsF4vUjg9ovwRKjMzEpijrIIxfTLu5XxJtJh0iHiK3DkjUo/s1T/v0rwbB7hbwQ
         33URza2ccUasDS9i3F9oDIlWDfazzIHEBbX/0j1jQYngTu0e+8UlkRNEW4GORjE76haW
         DbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366087; x=1704970887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5mxLkh2hEgcMvbfMMh1KibA3U7+O5yTNHMAUzMLGy8=;
        b=aigLEUJwoMC4pgyHsLQy8UzYMJYHtKNNs6ObNKER/+FGA+wAPWEwfPkLzJOBLe02O9
         Cg61hNsEvuJYBIiLIwXl9NFiU7AWAQ/yIwaVA7HKuzJQcSdEyoMyg55A2M8tbLWi1Hly
         +a6fMELVvdJ+/jHqujFBAhqxBRFXgHdIkW1A7DFMHugyqmNv19RU2+iGfzbHncgMXv8Y
         CNk27dYp1bfgNR8FVe7hteNKKnmO2C71YKTCw+HZaFWWSW3PvpMYJiZTN/90HdWAGLRj
         XnA3EwgMjf7ric3dIWmC8akK66XZgjHdF61IkVkLuhVVFJ2UQj9oyPHr2ieSGAD2dZKN
         oLog==
X-Gm-Message-State: AOJu0YzouND/zQsT+R015Bi017sOEvqFDryhuYfGdUyDXxWhnZ5csMim
	h4Q63uNUB4uZrir0hhqOskQ=
X-Google-Smtp-Source: AGHT+IFgM921wyMTaIEK6tB2WeVRkLLjFFl9rS5Stm9t7E8Fr5Ne03cfdh3ooWRH2i/yGy8ml56o/w==
X-Received: by 2002:a5d:560e:0:b0:337:3ee4:9435 with SMTP id l14-20020a5d560e000000b003373ee49435mr251268wrv.77.1704366086745;
        Thu, 04 Jan 2024 03:01:26 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b003373fe3d345sm9550242wrr.65.2024.01.04.03.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:01:26 -0800 (PST)
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
Subject: [net-next PATCH v8 1/5] dt-bindings: net: phy: Make LED active-low property common
Date: Thu,  4 Jan 2024 12:01:08 +0100
Message-ID: <20240104110114.2020-2-ansuelsmth@gmail.com>
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

Move LED active-low property to common.yaml. This property is currently
defined multiple times by bcm LEDs. This property will now be supported
in a generic way for PHY LEDs with the use of a generic function.

With active-low bool property not defined, active-high is always
assumed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v5:
- Make active-low generic
Changes v4:
- Drop support for global active-low
- Rework to polarity option (for marvell10g series support)
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 Documentation/devicetree/bindings/leds/common.yaml          | 6 ++++++
 Documentation/devicetree/bindings/leds/leds-bcm63138.yaml   | 4 ----
 Documentation/devicetree/bindings/leds/leds-bcm6328.yaml    | 4 ----
 Documentation/devicetree/bindings/leds/leds-bcm6358.txt     | 2 --
 .../devicetree/bindings/leds/leds-pwm-multicolor.yaml       | 4 ----
 Documentation/devicetree/bindings/leds/leds-pwm.yaml        | 5 -----
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index c8d0ba5f2327..f5b40df6b421 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -200,6 +200,12 @@ properties:
       #trigger-source-cells property in the source node.
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  active-low:
+    type: boolean
+    description:
+      Makes LED active low. To turn the LED ON, line needs to be
+      set to low voltage instead of high.
+
   # Required properties for flash LED child nodes:
   flash-max-microamp:
     description:
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml b/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml
index 52252fb6bb32..bb20394fca5c 100644
--- a/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml
@@ -52,10 +52,6 @@ patternProperties:
         maxItems: 1
         description: LED pin number
 
-      active-low:
-        type: boolean
-        description: Makes LED active low
-
     required:
       - reg
 
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml b/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
index 51cc0d82c12e..f3a3ef992929 100644
--- a/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
@@ -78,10 +78,6 @@ patternProperties:
           - maximum: 23
         description: LED pin number (only LEDs 0 to 23 are valid).
 
-      active-low:
-        type: boolean
-        description: Makes LED active low.
-
       brcm,hardware-controlled:
         type: boolean
         description: Makes this LED hardware controlled.
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm6358.txt b/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
index 6e51c6b91ee5..211ffc3c4a20 100644
--- a/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
+++ b/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
@@ -25,8 +25,6 @@ LED sub-node required properties:
 
 LED sub-node optional properties:
   - label : see Documentation/devicetree/bindings/leds/common.txt
-  - active-low : Boolean, makes LED active low.
-    Default : false
   - default-state : see
     Documentation/devicetree/bindings/leds/common.txt
   - linux,default-trigger : see
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index bd6ec04a8727..5edfbe347341 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -41,10 +41,6 @@ properties:
 
           pwm-names: true
 
-          active-low:
-            description: For PWMs where the LED is wired to supply rather than ground.
-            type: boolean
-
           color: true
 
         required:
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.yaml b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
index 7de6da58be3c..113b7c218303 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
@@ -34,11 +34,6 @@ patternProperties:
           Maximum brightness possible for the LED
         $ref: /schemas/types.yaml#/definitions/uint32
 
-      active-low:
-        description:
-          For PWMs where the LED is wired to supply rather than ground.
-        type: boolean
-
     required:
       - pwms
       - max-brightness
-- 
2.43.0


