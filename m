Return-Path: <linux-kernel+bounces-11916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ACC81ED83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBC828342A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADBB2CCD1;
	Wed, 27 Dec 2023 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuuNf1il"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFDF250F9;
	Wed, 27 Dec 2023 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336c5b5c163so934709f8f.1;
        Wed, 27 Dec 2023 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667786; x=1704272586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEHmC5iKOCQu4l12DtoKmZcnhnrMLLjw+Ox9XPLFhKQ=;
        b=TuuNf1il+1qZAXeeO4Rle/pYVzw01gNKNlnVsSEdLKJ0BCP0ofgOYFGA+xf0RP6PJp
         +muZ1vpGHS7Rb/r4aXct0ak5pqRuH110UKyMWfzVI2PgmX6REU0m6cHHVH9XyMFpGbPt
         EklsOmRAsLhj1Rup8Y8ECW3XQcxf259Q5F/kYA/xq9S9t551/OvByxSkokku53DFbQW7
         O3IpSSv8EBFZBYJQH/R7ND7D9iF6T2OafLDyIp5xtspImD8GV1fuBlsJs2yYGLPGSPUi
         CxKgObPuI1XB2b9XFSrQaHYqX783DyT7hcGzQVwhCJOKBZErDewZueAMwmjhBHkn/mx0
         mVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667786; x=1704272586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEHmC5iKOCQu4l12DtoKmZcnhnrMLLjw+Ox9XPLFhKQ=;
        b=uU0lvo1za5vuq/oymAfFLZJ4KS+Xm/Gp9YQS+WY3+qh/OBb2NRkAM5/lB14QOZ/804
         Wr0UkO0HTCKSkFQAAvhriK+UIBizt8/ndW7HEwpUMlA5lXovKCxKzwd5mXUG7OTxo2f/
         Unn7tKBhI6MZkCaMoM61gSqlmAdnpHBOUtXiSoXEpR+EqdCdy46pyM6R9LwU/TuQzaz6
         lbasVuLAB2OQFPNgDOowLR18DRfRwGE5aF8zFC0wOrTgm+muKLPreSRwnM77M1oIEvgq
         qpH3w89h0q05IBW934FGdrAJMV+G43L4FrtYTyHnav5Np4AknSHkwXv4qZgj7EROL3zw
         /neQ==
X-Gm-Message-State: AOJu0Yw5e+6Q6qRUEDkqFl8fG2XlWQ4X92I01foEZhGUJyY0x1tHXYJu
	krNW76ozJ2EvpSaIfZOBjHY=
X-Google-Smtp-Source: AGHT+IGsJLUrt/3CLFq83TJylEE3sXQAo8ZuPSwcXKHb6YUaJxdO62Bce1ZfcGgV4upAb7C6VKcX3g==
X-Received: by 2002:adf:9bcc:0:b0:336:5499:47dd with SMTP id e12-20020adf9bcc000000b00336549947ddmr4499910wrc.6.1703667786095;
        Wed, 27 Dec 2023 01:03:06 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm13616525wrx.15.2023.12.27.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:03:05 -0800 (PST)
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
Subject: [net-next PATCH v5 1/5] dt-bindings: net: phy: Make LED active-low property common
Date: Wed, 27 Dec 2023 10:02:27 +0100
Message-Id: <20231227090231.4246-2-ansuelsmth@gmail.com>
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
2.40.1


