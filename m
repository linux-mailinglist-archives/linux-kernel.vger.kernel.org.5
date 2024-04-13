Return-Path: <linux-kernel+bounces-143864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD88A3E78
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF828205B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DD95647E;
	Sat, 13 Apr 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX48R5xU"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358155C35;
	Sat, 13 Apr 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039772; cv=none; b=NuKzQcfm6DW240JuuYAEI+nkO7VKt4mzyNfNpfQJIDlME7l+c6sjBKr5fpt6lsCwvwMmuToRUKdRG5RJPjJQHr84hD7Q2zsnEGXuceGdPgBj825yHDPVLFbqT89Y0SItxymCO+IU3qE3jLXmSKcDRJ3DMMRyN+nI38evYjncIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039772; c=relaxed/simple;
	bh=SMORReniNUS8EgdHY4G4puGMUqdzjxeYHUZ9LEa5vlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVnDDANmAG5NEGX1B+GkmNJDDloXgRxafOD7vI5z5OU1sNMFb25htGxDmghq6lC5gtueKdG+Vhs4+pSB5NWZzx6zxc0SQVN2INRnedMaJW0PCT+4zsNhBxnURg3TfB7rQNHJSGFt61oZCc69aoudiJyD/KKL+6Tv5t/43OsD8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX48R5xU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so21558081fa.0;
        Sat, 13 Apr 2024 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713039768; x=1713644568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CF0jgJLN2j7M2dqxVXyrLhXc1ekWdPc5fPyMQy60sew=;
        b=EX48R5xUjPljD0pojpWrX7BBONacXEoMXLKTAfKjhedmIc3hMdQC2PE/HBSKngWkJM
         jRYGOORoCuqgAYJSEeBErk8HzkUCfVfO5SP7Hd8MQmThi3dr9ZRXtlwyD5xOI9eJLlaB
         1ZUtYeuThWos1fGkdOPRdC1FgKwn2cMCBVszsmCoYcUZfzYkaO5ZLAzkLolW394GvzuG
         qn9rZRSsb1TnyHfvmTOE3kneM2cnFoZAsXh00giLz9sm3uqNxPlhLUQiOha1MYhmkgpv
         P4dhFH6uIQ6xvTXhgXE0bVSTdCulXWn7uTZw4SfgixzBfSHjL+iQX0U8RKEcOP9V+mDV
         akdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713039768; x=1713644568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF0jgJLN2j7M2dqxVXyrLhXc1ekWdPc5fPyMQy60sew=;
        b=NwcGtjEn6GfDDZ67Vjp2CvPoHa+4jS3NxDxcO1P2YeVAYO9Zjls5VIX7NHN9pT9rPz
         x5FZQx/xIE9qB6wLy1UN2foQjJtqX9NEf7tYhWNK4H7Ty/j+0hUmtFxgdH3rqUUxcZd/
         4Iucw3qcx2Xiw/pG6dNBTOWJPX6NdnBLsX6MRh/fPgFuZo2oizbbMPtxUftg3iZKMe1J
         mW7Lg8p+Nte4UMM9leXo5y1m4SnZbNb7sj4eKK7E+Zsb0yB6M3Z+sQIU2Cdhl+CkIMDx
         iGqn+RsKuulALlxcPSmfqhKZX9BhB+kKGgDeAC0I1yFAo6B7rfNFiFiR7jmrqk+Kxm3y
         mVFg==
X-Forwarded-Encrypted: i=1; AJvYcCWiRXpmY/Dqu0kBCmshLT3diPhb5u7KwfWEhLQaXzUv1wP1IYmwkyeW4rUaTmqMHEbuGOcU28B+lBwpi/NfT4QuXsCPwhJ4+4iZsweOEpCdnqyXFG2rN0LnmS39WNwp75PJG5NWPK0eOw==
X-Gm-Message-State: AOJu0Yx2PICmvyok0oigEtCgdzf/NrNTEbaJvZv/HPuhoiZe3uGhimhv
	DFfzwzFsRDw189eq7AYDohlAqnh4k0CiYmg4m3WQkQ9KByJitYHD
X-Google-Smtp-Source: AGHT+IHQNWJqKv41Jzxvn0wIsHmK6cmyIQ6yzwPOQYaGLP8EY7WLKlVhoMrqczp84kw65nen+gdDeg==
X-Received: by 2002:a2e:8799:0:b0:2d8:636c:b4ad with SMTP id n25-20020a2e8799000000b002d8636cb4admr3809892lji.35.1713039768192;
        Sat, 13 Apr 2024 13:22:48 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402161000b0056e2f1d9152sm2881222edv.93.2024.04.13.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 13:22:47 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 13 Apr 2024 22:22:17 +0200
Subject: [PATCH v3 2/4] dt-bindings: rtc: convert trivial devices into
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240413-rtc_dtschema-v3-2-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713039763; l=8648;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=SMORReniNUS8EgdHY4G4puGMUqdzjxeYHUZ9LEa5vlY=;
 b=Fl2XNLJxa6lw01zpCPzyEZi5S29wfcWITgmEUkQVLHUskiJSAU+3OGa5zFVmGo4QSKic660vW
 cid2ouXGKcyBMDfSDwzshAhhoqK7SSoRqGWlZKRaLsk9Cor5ExxnTQ6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These RTCs meet the requirements for a direct conversion into
trivial-rtc:

- google,goldfish-rtc
- maxim,ds1742
- lpc32xx-rtc
- orion-rtc
- rtc-aspeed
- spear-rtc
- via,vt8500-rtc

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

dt-bindings: rtc: lpc32xx-rtc: convert to dtschema

Convert existing binding to dtschema to support validation.

Add the undocumented 'clocks' property.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/rtc/google,goldfish-rtc.txt           | 17 -----------------
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 ---------------
 .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 ------------
 .../devicetree/bindings/rtc/orion-rtc.txt          | 18 ------------------
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 ----------------------
 .../devicetree/bindings/rtc/spear-rtc.txt          | 15 ---------------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       | 18 ++++++++++++++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 ---------------
 MAINTAINERS                                        |  1 -
 9 files changed, 18 insertions(+), 115 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt b/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
deleted file mode 100644
index 634312dd95ca..000000000000
--- a/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish RTC
-
-Android Goldfish RTC device used by Android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-rtc"
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_timer@9020000 {
-		compatible = "google,goldfish-rtc";
-		reg = <0x9020000 0x1000>;
-		interrupts = <0x3>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
deleted file mode 100644
index a87a1e9bc060..000000000000
--- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* NXP LPC32xx SoC Real Time Clock controller
-
-Required properties:
-- compatible: must be "nxp,lpc3220-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The RTC interrupt
-
-Example:
-
-	rtc@40024000 {
-		compatible = "nxp,lpc3220-rtc";
-		reg = <0x40024000 0x1000>;
-		interrupts = <52 0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt b/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt
deleted file mode 100644
index d0f937c355b5..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* Maxim (Dallas) DS1742/DS1743 Real Time Clock
-
-Required properties:
-- compatible: Should contain "maxim,ds1742".
-- reg: Physical base address of the RTC and length of memory
-  mapped region.
-
-Example:
-	rtc: rtc@10000000 {
-		compatible = "maxim,ds1742";
-		reg = <0x10000000 0x800>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/orion-rtc.txt b/Documentation/devicetree/bindings/rtc/orion-rtc.txt
deleted file mode 100644
index 3bf63ffa5160..000000000000
--- a/Documentation/devicetree/bindings/rtc/orion-rtc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Mvebu Real Time Clock
-
-RTC controller for the Kirkwood, the Dove, the Armada 370 and the
-Armada XP SoCs
-
-Required properties:
-- compatible : Should be "marvell,orion-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: IRQ line for the RTC.
-
-Example:
-
-rtc@10300 {
-        compatible = "marvell,orion-rtc";
-        reg = <0xd0010300 0x20>;
-        interrupts = <50>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
deleted file mode 100644
index 2e956b3dc276..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-ASPEED BMC RTC
-==============
-
-Required properties:
- - compatible: should be one of the following
-   * aspeed,ast2400-rtc for the ast2400
-   * aspeed,ast2500-rtc for the ast2500
-   * aspeed,ast2600-rtc for the ast2600
-
- - reg: physical base address of the controller and length of memory mapped
-   region
-
- - interrupts: The interrupt number
-
-Example:
-
-   rtc@1e781000 {
-           compatible = "aspeed,ast2400-rtc";
-           reg = <0x1e781000 0x18>;
-           interrupts = <22>;
-           status = "disabled";
-   };
diff --git a/Documentation/devicetree/bindings/rtc/spear-rtc.txt b/Documentation/devicetree/bindings/rtc/spear-rtc.txt
deleted file mode 100644
index fecf8e4ad4b4..000000000000
--- a/Documentation/devicetree/bindings/rtc/spear-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* SPEAr RTC
-
-Required properties:
-- compatible : "st,spear600-rtc"
-- reg : Address range of the rtc registers
-- interrupt: Should contain the rtc interrupt number
-
-Example:
-
-	rtc@fc000000 {
-		compatible = "st,spear600-rtc";
-		reg = <0xfc000000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <12>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index c9e3c5262c21..c48d0dfa28b2 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -24,6 +24,12 @@ properties:
       - abracon,abb5zes3
       # AB-RTCMC-32.768kHz-EOZ9: Real Time Clock/Calendar Module with I2C Interface
       - abracon,abeoz9
+      # ASPEED BMC ast2400 Real-time Clock
+      - aspeed,ast2400-rtc
+      # ASPEED BMC ast2500 Real-time Clock
+      - aspeed,ast2500-rtc
+      # ASPEED BMC ast2600 Real-time Clock
+      - aspeed,ast2600-rtc
       # I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
       - dallas,ds1374
       # Dallas DS1672 Real-time Clock
@@ -41,16 +47,24 @@ properties:
       - epson,rx8571
       # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
       - epson,rx8581
+      # Android Goldfish Real-time Clock
+      - google,goldfish-rtc
       # Intersil ISL1208 Low Power RTC with Battery Backed SRAM
       - isil,isl1208
       # Intersil ISL1218 Low Power RTC with Battery Backed SRAM
       - isil,isl1218
+      # Mvebu Real-time Clock
+      - marvell,orion-rtc
+      # Maxim DS1742/DS1743 Real-time Clock
+      - maxim,ds1742
       # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
       - maxim,mcp795
       # Real Time Clock Module with I2C-Bus
       - microcrystal,rv3029
       # Real Time Clock
       - microcrystal,rv8523
+      # NXP LPC32xx SoC Real-time Clock
+      - nxp,lpc3220-rtc
       # Real-time Clock Module
       - pericom,pt7c4338
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
@@ -67,6 +81,10 @@ properties:
       - ricoh,rv5c387a
       # 2-wire CMOS real-time clock
       - sii,s35390a
+      # ST SPEAr Real-time Clock
+      - st,spear600-rtc
+      # VIA/Wondermedia VT8500 Real-time Clock
+      - via,vt8500-rtc
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
       - whwave,sd3078
       # Xircom X1205 I2C RTC
diff --git a/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt b/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
deleted file mode 100644
index 3c0484c49582..000000000000
--- a/Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-VIA/Wondermedia VT8500 Realtime Clock Controller
------------------------------------------------------
-
-Required properties:
-- compatible : "via,vt8500-rtc"
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : alarm interrupt
-
-Example:
-
-	rtc@d8100000 {
-		compatible = "via,vt8500-rtc";
-		reg = <0xd8100000 0x10000>;
-		interrupts = <48>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..f24469714f1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1442,7 +1442,6 @@ F:	drivers/irqchip/irq-goldfish-pic.c
 ANDROID GOLDFISH RTC DRIVER
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 F:	drivers/rtc/rtc-goldfish.c
 
 AOA (Apple Onboard Audio) ALSA DRIVER

-- 
2.40.1


