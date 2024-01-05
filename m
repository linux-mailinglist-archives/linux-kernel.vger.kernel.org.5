Return-Path: <linux-kernel+bounces-17923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FF982552A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4101F23C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440432E3E4;
	Fri,  5 Jan 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvlezB/r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4E2E3F0;
	Fri,  5 Jan 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e3b43173eso1099015e9.1;
        Fri, 05 Jan 2024 06:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704464853; x=1705069653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5mxLkh2hEgcMvbfMMh1KibA3U7+O5yTNHMAUzMLGy8=;
        b=SvlezB/rJzuhWENuK3qKj7gc8O7cPSpk5JRakp1FfJpzHXg/rfl5sMEta3KFfyPjJX
         CfLxtBfZ/Iq5oX1fdSyma1h3vQhfd2BKampn9TVc+VkD5rspxvftBOklEuGB4bwluhn0
         fGssLdcG49erPwQl3+q+cbKqKgHmgOcr4A+7+8eSYGSDG4NlIFhuxsrF5qNe5wdj7onf
         om83zVBjAY4wcxH+7sMufUEXqTltIx79zhaznlhouEk2ceU5NLC8hs976dfeMekGsJhp
         0t8XvLeR0Na8QT6mEOOJZJfJEZZwiIGCDju13cGDLf6HOuwVrp5LnJyYtZP9BhvWuFfD
         vYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464853; x=1705069653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5mxLkh2hEgcMvbfMMh1KibA3U7+O5yTNHMAUzMLGy8=;
        b=M9CcPf9x7OQ9W9LmE1fMxNruRGhI9tw92lth0oZ/AMSAWbt1rgh8H7cAOEt4AtfWyi
         PfJA4xysO5+XvcOgmzUBNcWTRj1xs/GCmfjP+2osRp8bUSkEb075WKVBC9GG07fH4LdT
         hJFwXse1c2Bu72jyE34K/lEH46qrcFS2WlhnewYcL1+6COITtgodX+lZrbZQNGh7vR6g
         dX1KiP86xi3TatZ06oWTQMBBqXMjtmp4w8CzwYzylKq+v8TaitDQg3U26GFH39XHr8yE
         Ono5T8yB0is0jOaq77+UtxY9qrB5h6+mLGbEZS9Iy6Bx/x9d71wIqFe5qTfDyGSgHOJg
         S7Xw==
X-Gm-Message-State: AOJu0YyHg0aqY1i0RZJFXXPXz0xTuHMVpk/NDSLt1Z/OjBS8M2W+cPZ0
	EHmwDqrriXvYI5z6cjMZaoI=
X-Google-Smtp-Source: AGHT+IEz9GBVOQGxk1aJ5m2QFZSeozJwXDn7KKH2C4BeHzGq3gIf7oMG30I+NmI6cBWTtAfk6icslg==
X-Received: by 2002:a05:600c:1f84:b0:40c:240b:f839 with SMTP id je4-20020a05600c1f8400b0040c240bf839mr804960wmb.166.1704464852908;
        Fri, 05 Jan 2024 06:27:32 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c190a00b0040d87100733sm1721901wmq.39.2024.01.05.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:27:32 -0800 (PST)
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
Subject: [net-next PATCH v9 1/5] dt-bindings: net: phy: Make LED active-low property common
Date: Fri,  5 Jan 2024 15:27:13 +0100
Message-ID: <20240105142719.11042-2-ansuelsmth@gmail.com>
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


