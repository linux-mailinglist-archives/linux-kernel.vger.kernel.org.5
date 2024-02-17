Return-Path: <linux-kernel+bounces-69945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ABD85909F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD091281D64
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E27CF30;
	Sat, 17 Feb 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afZd5570"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47E7CF29;
	Sat, 17 Feb 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184730; cv=none; b=Bj4lyvWvj5eFRBxiR4flsQrIQW9Mn6W6hXAC3DdJJvU5saUuRTjXNx/1fDGjjm10Gz+PlMEGal2h39N4IuCwAbimrrg4+mOjhYzp4ShaZ+lzgy2dQgTg9yCXAeVW2Clwo3cdjcJyX2atzI3b0W5pDNk/itUvhJdYLVn9rStfIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184730; c=relaxed/simple;
	bh=LRJSEJIP8aRKuM+hbH7pznUA2w2kB4lfNNyrDXDbJPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZXOnBeF4wlAAqUvY+s62Q5EmX4woMMh1fx5x8zTw+EYPGFaXyUi6cDx6Xtnk8aPpf855ETgitCT3G8x6sT4cBc9h4nKdzMoD0cVB1XswIOENxq0uGEoco3IoshIZjd2K37MpBniIwxsm2Dhb0+z7DvgGMX9xeAcqVAm+VvZHJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afZd5570; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5118290fcd8so3746357e87.3;
        Sat, 17 Feb 2024 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708184727; x=1708789527; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2c0F2fDyumXqRJj33BJeUUEOgxgwM5bGtk5xsr/q5Z4=;
        b=afZd5570tpGa06MFmQcZaICRSF4Ueatj5zp5ccSvbZIpUa8SfFsW3xTvFc2/ujOJk8
         xFl7ayR4NYsCm3HvokN4VQVML6N5efgO8cuTQUb67By7YZI/VqlqS+QGfjm89ot/8h7V
         G3ekBHxIaqS1sfx3wnhoHGbHWW686oNMMtRju4k6OB64o1/7rZrSjqihGZreuxmgy9hR
         HvLYBR7XujFGXU/gh3P2HqOGYmnolqZa4PKIxBuk6UDtAUSPmNmlZmAOOVjmGfXST4jf
         cRuj7ZKZ5DB8TYOS37VwfGubkatvz3v9xpG58pUvtOucqUss0IeCqx0FAqfO6iLKPfr6
         P49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708184727; x=1708789527;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2c0F2fDyumXqRJj33BJeUUEOgxgwM5bGtk5xsr/q5Z4=;
        b=cLZsDMa4yyRNhbaAgfiPR4uVa+tvwh1dHkspL8lVGdtECDVq81a8xpyVAWyko1hx9z
         zutzAAHLRx/NTWXnW4GFHa6ZiPbHM18KEe/S4NGqkkK+/7pjzxzJbI1h8nnvC31pqn5l
         /c/MwtYTG6yYMNAxkTjAsYn7dbS00MaDuTZ6stffoHwIji39WwjvTHQ/oTN11QNa4WOQ
         fVYnLfRXZixpDXPiaLM/cyy3bHaJTiEQcZywrl/ud3juwQ7NmEHWDDx6HYyYe9Ryf9av
         Ncx6/mKY2r36uhOM8l/Gj/vNBUALVGFqAjiot9FworkEggJmsGjeVvsgiyjWBT12Ufl1
         pFNw==
X-Forwarded-Encrypted: i=1; AJvYcCW14R/dqH1tnNbf2DRwNCmRjya8nMwzCJO1UrceOty5JXhYC/Isbp8eSYhcISDwCSFMN1kssQW88jaaAX4uxUxjPomisHu/piWCOH39SC+Y2DfupnMxiN469jVXAzikyYatCxfkG5bBcg==
X-Gm-Message-State: AOJu0YzEd7Z5SOHQOLgYMfsHxT1LxB/xuiwIshJ4do1HIhjpki8W1FBg
	w5CJyxVcAf4gUvsGvb213MO55fte2DkRGijnI+8k608ICcpUgOPh
X-Google-Smtp-Source: AGHT+IGpQ8Bsv5FuoQtzBbD3ufZxD+6WkKIW+EH6TDhzuOWkgJqmeBBu5BnjWLJVPyNYyIWFP1eG/Q==
X-Received: by 2002:ac2:5632:0:b0:512:a8e2:e335 with SMTP id b18-20020ac25632000000b00512a8e2e335mr588029lff.64.1708184726747;
        Sat, 17 Feb 2024 07:45:26 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906e00200b00a3e1939b24csm793287ejb.208.2024.02.17.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 07:45:26 -0800 (PST)
Date: Sat, 17 Feb 2024 16:45:24 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: sprd,sp9860-wdt: convert to YAML
Message-ID: <ZdDUlGdqH7Qv3SDu@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert Spreadtrum SP9860 watchdog timer bindings to DT schema.
Adjust file name to match compatible.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/watchdog/sprd,sp9860-wdt.yaml    | 64 +++++++++++++++++++
 .../devicetree/bindings/watchdog/sprd-wdt.txt | 19 ------
 2 files changed, 64 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
new file mode 100644
index 000000000000..730d9a3a3cc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/sprd,sp9860-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SP9860 watchdog timer
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: sprd,sp9860-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: enable
+      - const: rtc_enable
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - timeout-sec
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        watchdog@40310000 {
+            compatible = "sprd,sp9860-wdt";
+            reg = <0 0x40310000 0 0x1000>;
+            interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&aon_gate CLK_APCPU_WDG_EB>, <&aon_gate CLK_AP_WDG_RTC_EB>;
+            clock-names = "enable", "rtc_enable";
+            timeout-sec = <12>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
deleted file mode 100644
index aeaf3e0caf47..000000000000
--- a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Spreadtrum SoCs Watchdog timer
-
-Required properties:
-- compatible : Should be "sprd,sp9860-wdt".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : Exactly one interrupt specifier.
-- timeout-sec : Contain the default watchdog timeout in seconds.
-- clock-names : Contain the input clock names.
-- clocks : Phandles to input clocks.
-
-Example:
-	watchdog: watchdog@40310000 {
-		compatible = "sprd,sp9860-wdt";
-		reg = <0 0x40310000 0 0x1000>;
-		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-		timeout-sec = <12>;
-		clock-names = "enable", "rtc_enable";
-		clocks = <&clk_aon_apb_gates1 8>, <&clk_aon_apb_rtc_gates 9>;
-	};
-- 
2.34.1


