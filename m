Return-Path: <linux-kernel+bounces-98114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696787754B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBDB1F214A2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC101DFD6;
	Sun, 10 Mar 2024 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYF0x9Md"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967861BC49;
	Sun, 10 Mar 2024 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046339; cv=none; b=qk8j/0uk7WMzo04EPfNYvVdZMLFvmvlYmCZSDc/b/Xl1QRX9ki46yle3NFMljD5QmejzPf8u3qoKXS1odNYd8kKVilHI+ipqu3SrG9viGO4zF3EYFxXWZ7OGDE/H+FHBDpE3lgu7Vh55PzOL4x7C9MTLvA1uM2Viswd960x7WBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046339; c=relaxed/simple;
	bh=Lg3ikMyb6Y/X2LET7wpSXls/MYqnJ4AFCGUo2fqpRjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnPX135xM/PJtl1xz0NWTAGnmWVsilUQpQYy0lbBCz2XA+3KabBHn3tuKS5dkWeMZxLDNYfG9eEPEWzVzDa/o5g9hwa20tv4fidh3rLgugc4j0YcGRRuySz5YJGWgBS7t829Uhk3JcSJfoFJz+IwUOFxj/QGKyLtE584mLDRdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYF0x9Md; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e64647af39so3276057b3a.1;
        Sat, 09 Mar 2024 20:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710046336; x=1710651136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcSs9B8AJsk0OCQxTFxaDtnnoShMSQH+cox1ftjSnF4=;
        b=JYF0x9Md2iaFfqnIysb2T2F3xhGpDZcDL/lzs2C0NMJK0Odm8Dl+th7RErT4GN7OQW
         RJbF3mw7bcu1Cr82pOiMYWJl1m+DDFhxVGlCnTMGI8w4MVQcEPhFFm3FOkMqY0P9zizc
         KELd8teuK3fa2gyyZ1pvESgeCP+MBxS45n34DvpDWiqm+udnVQYUcybi2TkaCYh9/SK8
         EXkIOX5sw02ps/h/J0ySHeSC3+eiEwqjvR1DNuaj2sLJm/wzIx/pKTxp6zNRp4hXY3Xj
         5xqHWKNl6ngymPzleTfecKp4ufx3C8n1PoW/USY12e4TqP8k5xcynrviFBGUCedznRXD
         tyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710046336; x=1710651136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcSs9B8AJsk0OCQxTFxaDtnnoShMSQH+cox1ftjSnF4=;
        b=TUbNh2zMXt2X21APTDnnsjRew/eD36Ca9VBso90uCmFEpI2WY1TNvyW1kYfSPWzZfY
         cauoKRIREnC7JvJQJuEFZ2Bxw11cBrwv5/PDw/XmiTn0oD/Y+d0/o7r68cOw4admqGz1
         hr55vURfb3XCy67xf1K+7NfYOnan+uQY+ZMWcUDxRvhiOR7wnv2ezM3kb+/5LVcIAmxs
         43f2wnU3+xagN9TExF+wkIJiGfcdqpoe1MV8X5+PV+hQLVCHnBnr6aLhHy7aGNvBpDcX
         C4HrrzALPGs0EOTNXtyZY9V0SuOye+KVnye6M81I8o5Tj40SiQJUdhBBtJxYqia9oORw
         BJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEbjWmQqhySZNi7vH6mNzEE30vYMtaC60rNzATD7L4As4wS+GbjOE/R8aZeSYJvSJv08JhmGClC+5FhaiCddD8OE6748lRHfmH8f8WoamgYYDztKhYKk2YC+OKGTdN0gbO8jMM1GjxWg==
X-Gm-Message-State: AOJu0YxT2lNIMR/LaVi7vSqaumD4uF/TBaY2aOeJk/ryLRskLN5jZGiZ
	OP6YWAt/0rd5bTnrexBltkKb3/gRUh3JqQjffe9oEZ9Gem7eUSk7
X-Google-Smtp-Source: AGHT+IFZK4geDB+uozIuL/rNFQyyInWu8kAKb7Hxsvs6ROkg35n8eQLESZaZE/doTvOMEyVTSb4SNQ==
X-Received: by 2002:a05:6a20:b393:b0:1a1:1e8b:9044 with SMTP id eg19-20020a056a20b39300b001a11e8b9044mr3164025pzb.50.1710046335938;
        Sat, 09 Mar 2024 20:52:15 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b005dc48e56191sm1984659pgh.11.2024.03.09.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 20:52:15 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 10 Mar 2024 01:51:58 -0300
Subject: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
In-Reply-To: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=Lg3ikMyb6Y/X2LET7wpSXls/MYqnJ4AFCGUo2fqpRjs=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl7Tx2DwXtTTbtEDUXMGQQZ7Qy1ZbbDuH27e4LP
 hebubB6VvKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZe08dgAKCRC7Edu60Qc7
 ViFQCACwHVxnDIWkyLk2D14MWfEUPX7VYntTLBPmrNgpXxXRzQ2XMrEIEoYTk94OcgEP/Mw2/zj
 YwVTWzYjNQdfKsKWOjh72w2Pw5D3BxNxlK/g20bKK6NDD2PFIDJyBJHWfUjS7b/olLkTxCBZLcq
 Al7fOdirqMpk/qS5TAIAa61UB/Es3KNQl2wORY6vPR9pvbdmr6EDNRqNXE/g6U5hOejCLlECVSY
 H/Wh4LPDfH+hWdBN54cjYm63wBWKaiao6y23YHI17fOwY4/ODyFZbRZjMylXXITV+R1uGQ5PmzI
 IO8uu+GcPsrk1v5HMuxV6SZK9bBFpdzX42SUybtkoS2U4LV2
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
LED reg property will indicate its LED group.

An example of LED usage was included in an existing switch example.

Cc: devicetree@vger.kernel.org
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 .../devicetree/bindings/net/dsa/realtek.yaml       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 70b6bda3cf98..45c1656b3fae 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -108,6 +108,32 @@ properties:
       compatible:
         const: realtek,smi-mdio
 
+patternProperties:
+  '^(ethernet-)?ports$':
+    type: object
+    additionalProperties: true
+
+    patternProperties:
+      '^(ethernet-)?port@[0-6]$':
+        type: object
+        additionalProperties: true
+
+        properties:
+          leds:
+            description:
+              "LEDs associated with this port"
+
+            patternProperties:
+              '^led@[a-f0-9]+$':
+                type: object
+                additionalProperties: true
+
+                properties:
+                  reg:
+                    description:
+                      "reg indicates the LED group for this LED"
+                    enum: [0, 1, 2, 3]
+
 if:
   required:
     - reg
@@ -144,6 +170,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     platform {
@@ -190,6 +217,25 @@ examples:
                                     reg = <4>;
                                     label = "wan";
                                     phy-handle = <&phy4>;
+
+                                    leds {
+                                            #address-cells = <1>;
+                                            #size-cells = <0>;
+
+                                            led@0 {
+                                                    reg = <0>;
+                                                    color = <LED_COLOR_ID_GREEN>;
+                                                    function = LED_FUNCTION_WAN;
+                                                    default-state = "keep";
+                                            };
+
+                                            led@3 {
+                                                    reg = <3>;
+                                                    color = <LED_COLOR_ID_AMBER>;
+                                                    function = LED_FUNCTION_WAN;
+                                                    default-state = "keep";
+                                            };
+                                    };
                             };
                             port@5 {
                                     reg = <5>;

-- 
2.44.0


