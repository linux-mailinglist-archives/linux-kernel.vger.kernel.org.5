Return-Path: <linux-kernel+bounces-119034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DB88C2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905171F6805C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490C7641B;
	Tue, 26 Mar 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfrkJScn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AF75812;
	Tue, 26 Mar 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458215; cv=none; b=dtGQl4H+2tGPXK6VHwJq4CHQbyId68WsCzMRtbCoUXeZex8Pt6qQFOanxthoYRDJxXk3vRDUtmF2iyx106M1eW2BF0SmqwfNvMkjeVLPo4CbtVgLPJfYJ/WLwZE2Ti7b+BRqVxMwbkejeDcQaQpbC/WF0n7MwAId4eE2T846fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458215; c=relaxed/simple;
	bh=032gecj1bf6Ewn/lmwcUSq4955nPfIXgJl22SGqTnbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnqpJGVjbPeppQZS9wxUPKvFYBR1qYO0mvd/xYX9sF58UufQ4jC9QKeRtcBl7ssjJfZ1/E5EIfrgSHylAyAeNbOlpPSS5M9pjePXK9dxMJyTDjH5rMQMCxZWXIuGrXD2YedjRHzQ6XT4prPSJ6/gP5q7skarTZk5/SEozKlXYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfrkJScn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4734ae95b3so526450566b.0;
        Tue, 26 Mar 2024 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711458212; x=1712063012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukrJeI0oVBwKLqKRD0fj8m30LFuXZE14/9JknKNbH5w=;
        b=AfrkJScnDcMujZpYO+lHvgwDFRHGUag2IFl9eZd7VghFsZb+AJ0Zj63U4umb0Nqchx
         hnEYpAGTiL2k4/UBkrvMngzbJMMxJ6JvGijTnu1iD2yar9d66pZZU6bGkvCCGJCZ+AMN
         qTm7wspZwJe7jNqJuox3BSqaCWw2Wn1PfM8/DjZ4W+VsP4E06Q9744jzpl08uXjMWHcX
         FS901GOyN/Kz9jGnDUvaGB9qG0O6KjPHdNLDd0NboDI1vc0DWBwhjhfcdMPRW7XB3Vwj
         0LC4rptgfLcawkbpMvvYPjyS56FeFgv9ilVT3lNqnKWv1jmbTTROmwV9G/SMdHXyDDSD
         JB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458212; x=1712063012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukrJeI0oVBwKLqKRD0fj8m30LFuXZE14/9JknKNbH5w=;
        b=rvo48o7er4sycu7iqxAhhWyhD9TdCA6eOaN4FOC7S732ksdmcnLqkTP4Cs1fAJ0b1T
         Y63cDKM/+8gjk7cGBXaOCZ7zr2FfX/dbVHKHP/lnYbrPApe0LVjPQcxXT9f4qgOkIDBq
         xnZK0KzPAjjf2gP5XoYgrGt/75/z2Z2ifk4dTcXCW8rCRoOS1V4OsIUJrYH38EKhuZ0U
         7ejWcHTU9Z6/Rgd4/Kr59YTGPDV05n99E+jRodscWe9zhOv/CnXnqMjCvAHmtVsGW8nx
         UWjmtHLaSpKGuImRIqzHISDQs5WYuSTHbK2hoeypI/wQw+m9AHjOan+I+lAUJBiX8+9n
         rBxA==
X-Forwarded-Encrypted: i=1; AJvYcCUI0zUskYWb5evHUxkiSZ+veObBq/5qq94upXC4wEzfFXXWKAv50HnlqlMA5sU23J/IXsCjMDLzE/eyLvV/a3DOcHQ90PM8d4LnitKbibpA+D92Lobtm6ay5x+6eDl+ganiFLWenhJPTw==
X-Gm-Message-State: AOJu0YwVbEvavOsinHwJwymYYfoRC/8zQ+EGxWzbFpffLVcG6JNkO35I
	fmhYyklP6H4pKvp9T9CfqdRlH8XCSI8D71mC7/8I1x0jQphIuxRNXpOfUxowr10MQQ==
X-Google-Smtp-Source: AGHT+IHn/Knqjf7MjRZFiBgpafeG4NL//Mf1ACcOlIQ2XmaevotMzB21097Ra/BvmE370+G/3JmBnw==
X-Received: by 2002:a17:906:1796:b0:a47:3b6a:a29b with SMTP id t22-20020a170906179600b00a473b6aa29bmr6130883eje.13.1711458212256;
        Tue, 26 Mar 2024 06:03:32 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b4b2-cd0d-1ebc-3c05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b4b2:cd0d:1ebc:3c05])
        by smtp.gmail.com with ESMTPSA id wg6-20020a17090705c600b00a4a3580b215sm2206279ejb.80.2024.03.26.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:03:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 26 Mar 2024 14:03:26 +0100
Subject: [PATCH v3 4/4] dt-bindings: rtc: nxp,lpc1788-rtc: convert to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-rtc-yaml-v3-4-caa430ecace7@gmail.com>
References: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
In-Reply-To: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711458204; l=2978;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=032gecj1bf6Ewn/lmwcUSq4955nPfIXgJl22SGqTnbw=;
 b=hD7Cc1UAUgTPlZrP1wYeX9VYRcD7YDp5WpVHBiAMOff/UhFkVGmJew+ev/opUQ2Xcra3cfswh
 uZcO3FxqfLCBZqqrMct2swLZMT80NiHe4tdHGo+fHcXWDJxqMMtaUHd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 58 ++++++++++++++++++++++
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
deleted file mode 100644
index 3c97bd180592..000000000000
--- a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-NXP LPC1788 real-time clock
-
-The LPC1788 RTC provides calendar and clock functionality
-together with periodic tick and alarm interrupt support.
-
-Required properties:
-- compatible	: must contain "nxp,lpc1788-rtc"
-- reg		: Specifies base physical address and size of the registers.
-- interrupts	: A single interrupt specifier.
-- clocks	: Must contain clock specifiers for rtc and register clock
-- clock-names	: Must contain "rtc" and "reg"
-  See ../clocks/clock-bindings.txt for details.
-
-Example:
-rtc: rtc@40046000 {
-	compatible = "nxp,lpc1788-rtc";
-	reg = <0x40046000 0x1000>;
-	interrupts = <47>;
-	clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
-	clock-names = "rtc", "reg";
-};
diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml
new file mode 100644
index 000000000000..e88b847a1cc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,lpc1788-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC1788 real-time clock
+
+description:
+  The LPC1788 RTC provides calendar and clock functionality
+  together with periodic tick and alarm interrupt support.
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: nxp,lpc1788-rtc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: RTC clock
+      - description: Register clock
+
+  clock-names:
+    items:
+      - const: rtc
+      - const: reg
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+
+    rtc@40046000 {
+        compatible = "nxp,lpc1788-rtc";
+        reg = <0x40046000 0x1000>;
+        clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
+        clock-names = "rtc", "reg";
+        interrupts = <47>;
+    };

-- 
2.40.1


