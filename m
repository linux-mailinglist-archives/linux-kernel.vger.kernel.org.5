Return-Path: <linux-kernel+bounces-138929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4089FC24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2976828E358
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAAB17167C;
	Wed, 10 Apr 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJXbIxf9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D111E86D;
	Wed, 10 Apr 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764551; cv=none; b=k0kLfU5FYFdG0b9J+cH7jmVCoJd3F2qwG8OxG14+a6RgEdZTbLOju4YojrpVdpnYIWd3diuAOcx91JF5lYIE35TNPTozN7qJOX/8mu3BKKIn8cDIn3LHSKuDdgErTQUwflv5WLzoIFpNoSgqGr8WrHxDc7gPsF3yBhdz55bmrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764551; c=relaxed/simple;
	bh=iUosu5YsymPpKqNWdU+OWpw6XNZgSqKxxGsYBKQMjJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAFeB03qIDegzaaR1pX8fBW5DwLoC2wr0eLnOJfZYdCLKYOPkbiNuYfylGxqICH8PFfjoiPaq+EQbQKYYyzpb1rr0+6Q5WcRINNBHUjywhPM6kMSzH1PdwJ5VoX259kIaZ+3F4uQWqHSU1R2C5qSyb1ADInIl9GZvrKZZFgb//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJXbIxf9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d47ce662so9292728e87.1;
        Wed, 10 Apr 2024 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764547; x=1713369347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjWL5urfCD2suWbxASMh0ZFN/BJUloa3sSOiLzgPS7w=;
        b=VJXbIxf9eEUDYTvynCJCJUTdW2jRMpQw92u8kWh7OzZfJ5/pJkCa02aay3eNMQRXgs
         p0htsbTElrMzklbAAR4uvn+PEQ7D1zLaYxukK+wuUxh/8SpNukAYtPl+rrByo7VnX8qC
         mlQ/X/rOSujn2gsZSZxKLyyDvzVN4UfwtpvZGbk0siH+lqCiUEq9rnhkxK7gJcIxd2Nd
         axVRT+I3VpbvDQZ+xKf4z2XP2PHNyNW4lRuhNUABwpOS+030wWuqosg0w8gIQTptdNlR
         ptYdcZ5/FzQmjdmS4OmxVBtcKdqr24xLUBNoMuxZbBoc6Iy6KwuwUYJp2+/nA57IhCtv
         WiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764547; x=1713369347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjWL5urfCD2suWbxASMh0ZFN/BJUloa3sSOiLzgPS7w=;
        b=A1g14XKlFYfg3Ehnkl9267Qdr1WD7X3Cf3pvOIYQRJ5nHPC0HYYYyrh8K7Pu9A7teP
         LwY+W7aP6Jr+x1vpFfo31HZUz+Caa2b3tcsLA5o+bT5zNKCHao57vVwaykpL9+awNi/A
         Gyk8600ZRXdStjL3Png6L8/loef6P7cGryTOztIE4UvE0v6/lha78Pl45CYm/qamCsMt
         l4YXHkz+FW0GJYZ5E3rrIPJitx1Rig/RfhF+8dJ0y37JB8KmAuBvWGS8T7w5slaWUKhW
         haXhmgu9AtSE8/JsElAuMOHNvy+HZgWWBRUp+68NNdht96n11Ws9yLL9dPaZecXV0FxG
         7UKA==
X-Forwarded-Encrypted: i=1; AJvYcCUmdubV/kVRHv1eMkEA2K5xc60o0A1VnyalvAHFQRwqzPPGLsE05j7CHtz2RGZ/7y6yNPqiBH92tgP4+uWD+taNoIyv+SFGJuovloDNM94oqZANgCBWH6nAiqHK7Bg7IgP1R8MfKthL8A==
X-Gm-Message-State: AOJu0YyiUoOhgpo5bCS3LO/4GHQG+DV1SwuhgdUHpLoOw9AvNASurPqI
	PMsybm1MfKl3vM5y7i4h+T/dEtBkN3qeRQLyIF0j66j1K+wlb/HVM6G+Ln+qY810mA==
X-Google-Smtp-Source: AGHT+IEhZ1EhOuatHHJC6dOkQluG+xXK5rizjLmHKYICtQdqLLMxOuH3rslLtKvHjApmXWcEYzpUkg==
X-Received: by 2002:a05:6512:3134:b0:516:d1f0:fbf7 with SMTP id p20-20020a056512313400b00516d1f0fbf7mr2608557lfd.42.1712764546832;
        Wed, 10 Apr 2024 08:55:46 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id qw6-20020a1709066a0600b00a52172808c9sm279884ejc.56.2024.04.10.08.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 17:55:33 +0200
Subject: [PATCH v2 1/4] dt-bindings: rtc: convert trivial devices into
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-rtc_dtschema-v2-1-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
In-Reply-To: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712764543; l=7413;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=iUosu5YsymPpKqNWdU+OWpw6XNZgSqKxxGsYBKQMjJI=;
 b=owDeqWcOexlJxUWmQcrdxMqzT1gWgViU73lAqA5P6dc9IURx/jDGsvUcssKKup3YCc6xdTLiI
 NASAfe9dsp1CPuYc/hs4k29Vy67X64HKj/oHJXdRY8l2lJn5PuvMHQu
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These RTCs meet the requirements for a direct conversion into
trivial-rtc:

- orion-rtc
- google,goldfish-rtc
- maxim,ds1742
- rtc-aspped
- spear-rtc
- via,vt8500-rtc

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/rtc/google,goldfish-rtc.txt           | 17 -----------------
 .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 ------------
 .../devicetree/bindings/rtc/orion-rtc.txt          | 18 ------------------
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 ----------------------
 .../devicetree/bindings/rtc/spear-rtc.txt          | 15 ---------------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       | 16 ++++++++++++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 ---------------
 MAINTAINERS                                        |  1 -
 8 files changed, 16 insertions(+), 100 deletions(-)

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
index c9e3c5262c21..b590bf35d440 100644
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
@@ -41,10 +47,16 @@ properties:
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
@@ -67,6 +79,10 @@ properties:
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


