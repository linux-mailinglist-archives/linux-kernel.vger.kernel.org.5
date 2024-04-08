Return-Path: <linux-kernel+bounces-135636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC34F89C8EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6AE286CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787FD143C5B;
	Mon,  8 Apr 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BewQ/L2y"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A0142E99;
	Mon,  8 Apr 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591604; cv=none; b=Jye4Itb0XCLJ5oGfmoIVYh/sgKoUNIx5rr+Gs3lfNAqNLdnaflE/g0y/9WfQdsWG+HUoA7rpzWCpJBACUPiNArOEvv0AOtgSoap2CVc0YoM5vyGDA4vKkezbY7b0wAAwu22QGSmykYbHXMPontRa+lKTgxqVr6XJE8+n27Z+NSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591604; c=relaxed/simple;
	bh=XuizmZ/AsI4sUrNbkhEaUlA+sS0KeXhc44fqmRoI0ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCAJ2KAxrKhaJJSS8W5QbP4dKBl6axKBPU3Hxv1iCIvYM8F7BG8PgUtki5vHRiVCEujWKIXs5yCKYpA6tM1GGTQQMRKeNBUwXTZ6di1C3ekRJxW5K2cWoe55PcsgJKrcenYEoWDuwmQ3ny3KMCbc4NGZ2Xt2mC6mH9zI2cKth3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BewQ/L2y; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so779149666b.1;
        Mon, 08 Apr 2024 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591601; x=1713196401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDBj+TCOT5An3iT1ZW/BVrmcXlQmpT8xuPifrvWWcJQ=;
        b=BewQ/L2yY5s8IF7vl2ZuDRgZpbiyj/tQFjF138TO+7orlLjiSLcOWvpH/JDQ2GGNu0
         IFCbipXCmT9VUEBOWfQ1XOg/Vdrr0zEmvAWZyiEjMzBw6KyYRFTMe2om/Zz/0VxRw8CR
         EEa+D73ymqfvt7GonO2QjBq206PvJK8aeMbU61TEqcCMmIUEb2KznChVIkZxTppShFNt
         0/lyeBPgtAsXXEhC9bmXHUNWkCN4/+uHds3+bWmEj0xD+g3md5/2RhRMjinX0SMBlaoH
         N5UqaDCVgLAd/A4K91MeRkAo1a7CGMy4V0pPRaAk/8lnrg0EY/xwald8MpyJMx5x4hgJ
         +pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591601; x=1713196401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDBj+TCOT5An3iT1ZW/BVrmcXlQmpT8xuPifrvWWcJQ=;
        b=ObO2HIC9O0REUemaTwh/QNF++GVbZcg4FhgWuMcQOeBotCgzHzZrrPjrL3M6lUohf8
         PnwTMLV+p57bEHwbaVEfPBbYgiwOxYZNNe9GegpVaJB9sqeAIaR9etX0gLne2iWpKFa2
         IjyQq/eI1/M8Ir07JCaOA7N4fPLNLSYoDbfj9YewONbPHzNj3gdULXnPKOKEuRC4GDsf
         y+LNKeT4ipIWH8v7S6JaaXp+/whwHu159TkmKEX7XRysIbjU8gnU8oto1u5Zqvb9Qpro
         XNeIf3UYCuzYYuh4qohVaNJ6XyfO+SeD9MWtRyt4dJB5vwk5nCV6q1sSa9gn/tHhnqyT
         hYGg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0dZYg7CNXCzqnI1T9lQINpF4USNGq+6doUoavf8caGnf3lcwDkwWwvJi3K4etjjJd5oQxBtpjjubrFz4Q+zi7RRnV71qxO/Mr2Uk1xjNzhMzS/bAsMXQYaaSELg7bDQdEChKbF1iFQ==
X-Gm-Message-State: AOJu0YwtK/M3hBH1ap3G87lWA7TF3yhV3rABgjpuVlH35YyMQJMVjP0R
	9sVHnghNyhiXH/Regft9oiGboQr1stfA9RSo2wJBfLyFLZ/TeXtS
X-Google-Smtp-Source: AGHT+IHo3PjOjthzlX7he+eTIQsbLTIBOyRGKiO637648HaP0Ncp071D/7W6Vx2fN1EcekWna6nuhQ==
X-Received: by 2002:a17:906:af16:b0:a51:c1f7:93 with SMTP id lx22-20020a170906af1600b00a51c1f70093mr75351ejb.13.1712591601329;
        Mon, 08 Apr 2024 08:53:21 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:06 +0200
Subject: [PATCH 6/9] dt-bindings: rtc: pxa-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-6-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
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
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=2057;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=XuizmZ/AsI4sUrNbkhEaUlA+sS0KeXhc44fqmRoI0ks=;
 b=TEcS/yNABbU+N66YYIMs81/pFUYAYXLO65ZbwiLZUk8cK0LytDNhrbnd05Bbryb15/GpV6iW2
 jf1CGGu8AmBA3oq3KEyQFN5EDyUUA0/E99wDgmrlSsZqOp61i9vtUnd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

The missing 'reg' and 'interrupts' properties have been added, taking
the 2 supported interrupts into account to fix the example.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 ++++++++++++++++++++++
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 --------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/marvell,pxa-rtc.yaml b/Documentation/devicetree/bindings/rtc/marvell,pxa-rtc.yaml
new file mode 100644
index 000000000000..43d68681a1bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/marvell,pxa-rtc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/marvell,pxa-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PXA Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: marvell,pxa-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: 1 Hz
+      - description: Alarm
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@40900000 {
+        compatible = "marvell,pxa-rtc";
+        reg = <0x40900000 0x3c>;
+        interrupts = <30>, <31>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/pxa-rtc.txt b/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
deleted file mode 100644
index 8c6672a1b7d7..000000000000
--- a/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* PXA RTC
-
-PXA specific RTC driver.
-
-Required properties:
-- compatible : Should be "marvell,pxa-rtc"
-
-Examples:
-
-rtc@40900000 {
-	compatible = "marvell,pxa-rtc";
-	reg = <0x40900000 0x3c>;
-	interrupts = <30 31>;
-};

-- 
2.40.1


