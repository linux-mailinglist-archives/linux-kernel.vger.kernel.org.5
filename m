Return-Path: <linux-kernel+bounces-14718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6A822123
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F07284434
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B715AFD;
	Tue,  2 Jan 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIiyHFkA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25615AD0;
	Tue,  2 Jan 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so35635645e9.3;
        Tue, 02 Jan 2024 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220731; x=1704825531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5mxLkh2hEgcMvbfMMh1KibA3U7+O5yTNHMAUzMLGy8=;
        b=mIiyHFkAZSeLvbdRw0aBSAk3y7Q9t107uwbZZL871oaD8gwitroJODxkDhQh0cpnBs
         uvG13M+uijbUIst94WQqvHGYc48mT5pPo/SzKWc39pRxuDqD5+u5HmBd4PAyOY9nxjO7
         CnsXosJ/W2GAXnDfAiE03vksic0YlcBbsii620WDZalBVY5H2W3diMQbu2wIO8hO9+az
         jMaN8uNA1/owpuWJQ+5H17pInlz6VHIRhzfuAAvQpCwuZu6wv4/UBuM4/160mWlai4wP
         EnA/GOihP8Icy6ea3XBnNqjVKlNB/iqj3Thxpu9PfAIqtCtcdb367UoM4RSLdGaMP3kF
         rcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220731; x=1704825531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5mxLkh2hEgcMvbfMMh1KibA3U7+O5yTNHMAUzMLGy8=;
        b=rSUj0SuV9KwkUGpXLd/7cWDhPIS6O+Vu4iBLyLBToGE2FCUa0yh85f+eCfxTmMxep+
         WPxMLsT0+j0gKx7avmuRbhxN3d3WIUe/eaEw6IgYtbvuOyu/I9Cy3UePLeUod0HNlga3
         LxG2/3E4mfjaacApTI2aKPDhr9DuKgNXIbK6ggmA1KBH9lbMqP/I9g8YStkzrAUEjm1X
         f9FMWsprz3av+c1Wd3r1KeVVpbFg7owxMk6iVbdW/SuRaGuN6Srq9CS2cccNOG8XMuwo
         2xOuQYLWEapc8CvbGLvTsFmyWDnBb/p2QrCy+ZyHJ8bznKpszljYC9cU/ASjHehaV4+I
         dieg==
X-Gm-Message-State: AOJu0YwnLKILRVqiYcAc13jTUO/TX5kIMzkVyuTtuARhbCRaorjb1g4l
	6FOiyP6rORFXRxq0R/Br4tY=
X-Google-Smtp-Source: AGHT+IG2YkzosgUEjDO2bC0ZEksjlJs0IOHRfPu530055c2xs6lJjollTZOpGXKl1j5DgVX4GvWTGQ==
X-Received: by 2002:a05:600c:1310:b0:40c:366a:598a with SMTP id j16-20020a05600c131000b0040c366a598amr9575508wmf.107.1704220731564;
        Tue, 02 Jan 2024 10:38:51 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id p15-20020a05600c468f00b0040d4e1393dcsm37963071wmo.20.2024.01.02.10.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:38:51 -0800 (PST)
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
Subject: [net-next PATCH v6 1/5] dt-bindings: net: phy: Make LED active-low property common
Date: Tue,  2 Jan 2024 19:38:30 +0100
Message-ID: <20240102183835.5332-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102183835.5332-1-ansuelsmth@gmail.com>
References: <20240102183835.5332-1-ansuelsmth@gmail.com>
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


