Return-Path: <linux-kernel+bounces-120045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C588D0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4867C1C3587B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59213E04C;
	Tue, 26 Mar 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7Y1p6A4"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1E13DDB6;
	Tue, 26 Mar 2024 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492204; cv=none; b=EYIoFgr+r/T/AQ/IpYLo3luzrYCxWTeboe+ITqQG12gcUqjdwQQ7w3BQ0/yu/ogvJvncDi+XFPxVB73ElQEIE2goPE8jq+Fa3kColXuxp77tgDqtA/vDKSYk+fottMYTW58kEUIEBnlLPAfUCU8LzEzQz7eVxVYBws7dkz93iTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492204; c=relaxed/simple;
	bh=VeJKb2fk+31D3xOPMXg7kpkc3Jz8DarzPDHEXGjXkeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edpKHw6Syj0Xu1Su0WIlnWD5D/lzQCE96ZsQCXD3ftSlF0fF9foFTf24NXJO5J5MHgGfND75pxi7UNOUigE5/d8peR509gc3pvbNiH6iS5tH6ZeUP7pA5xI4HmdKSLmU7Jyx+A1kGUfUbWxaoZeHsmuEOeOp1dGa+Qb4EMFePoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7Y1p6A4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-341cf28e013so1653412f8f.3;
        Tue, 26 Mar 2024 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492201; x=1712097001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1T53gZiofVkC2dq0zi+t8YvzI14Q1dNLsQbFYj0uK0=;
        b=P7Y1p6A4T74McLTpr73gDMHs+cjyHMghbEA9gplM2KerlyCPRGXuFLXutPTne/lBYU
         nOwK2onjL0p2C7K/ziVfqW9VahaG0CpIdMK94K0YkSWJtJz0T3yZyKOSdbFwvYVF40IU
         0EvhrnR6BW0RMuKNoA8nZGC21EE49WLVugBlGIgRTytXm+ZUBDQlkky5V5g7JeLuSmTL
         vE9ksiN5Y1B2pb2uVOlGptLYcHCYlf/ovVe9Uo/BPiOqPcLfMpt3KmHHlkAcd8E3+Prl
         EWh/it2wCSth682feObP5twzZ2ZMBzNXQso5Oy+EVgHWQ2vH6HZrPprtmRbhfRchEoWS
         NRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492201; x=1712097001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1T53gZiofVkC2dq0zi+t8YvzI14Q1dNLsQbFYj0uK0=;
        b=I+JWsne57i/IH+gh9rR8XIvOBgH2gpHk/PbZ5LGuIG2hkW/PhAB1LQZOx7pdFLTvMe
         OCaqdN1FIZauBvHaE6U2fKGCbZZYZsoPuppPVnKZz5hTbCTpJG3+vnRrUfqofUQclVg1
         fw46rop0E2rrkuyucjz9bR8LoW1F7wIMM45pYYuhFD8z+UsZxBoh4ARpsCGO/kqpCC3X
         zQM/T4eqvOewSHEucMSVQeANePq0rmMV2PUnNlZXW5d1GF8n6QMHwqUEaHOfzKkWfAj4
         zJ2bCzUSntaZPZbkGvYzBpc0toksuQdRop5eQa0WHNe4nnKwggZvNnGla9U93hM1Qkso
         lZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW50A2jBBI63KF5HHI4ln/FFGODVL89alKFkSLwyFjdfNwhwXU13vjbaNhABLNn3h/tcE3BZOdLgEfqzV4w3bWO/z6whogREL7UlqLwaZy/7qWN3uH1fGmcMEUJV8CVHpvJemgfZcNzYobwSmGAhxpSZQPU237m8mgjaVoqNLeVYYoVVr8=
X-Gm-Message-State: AOJu0YzJkPWJ1onP8+LZ3rg+0oXYugaYi29DGv7ymPnoNwy1vRePJPmZ
	7DjIYfRC1TMDVI7bXl6JGuQZKTnj56tZPiL+bM6J7lO2hVQxMgZ7
X-Google-Smtp-Source: AGHT+IF6AGExfxy1qp2zfxzzfFJWrRM8pqNzivPeUgfzfLxilALD3fa6dic7sTGJ8zNnatNeoxnqRg==
X-Received: by 2002:a5d:6d86:0:b0:341:d3b0:ae7d with SMTP id l6-20020a5d6d86000000b00341d3b0ae7dmr4172985wrs.45.1711492200592;
        Tue, 26 Mar 2024 15:30:00 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:29:59 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 02/13] dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
Date: Tue, 26 Mar 2024 22:28:33 +0000
Message-Id: <20240326222844.1422948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add documentation for the pin controller found on the Renesas RZ/V2H(P)
(R9A09G057) SoC. Compared to RZ/G2L family of SoCs there are slight
differences on the RZ/V2H(P) SoC for pinmuxing.

Also add 'renesas-rzv2h,output-impedance' property. Drive strength
setting on RZ/V2H(P) depends on the different power rails which are
coming out from the PMIC (connected via i2c). These power rails
(required for drive strength) can be 1.2/1.8/3.3V.

Pin are grouped into 4 groups,

Group1: Impedance
- 150/75/38/25 ohms (at 3.3 V)
- 130/65/33/22 ohms (at 1.8 V)

Group2: Impedance
- 50/40/33/25 ohms (at 1.8 V)

Group3: Impedance
- 150/75/37.5/25 ohms (at 3.3 V)
- 130/65/33/22 ohms (at 1.8 V)

Group4: Impedance
- 110/55/30/20 ohms (at 1.8 V)
- 150/75/38/25 ohms (at 1.2 V)

'renesas-rzv2h,output-impedance' property as documented which can be
[1, 2, 4, 6] indicates x Value strength.

As the power rail information cannot be available very early in the
boot process as 'renesas-rzv2h,output-impedance' property is added
instead of reusing output-impedance-ohms property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 881e992adca3..77f4fc7f4a21 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
               - renesas,r9a08g045-pinctrl # RZ/G3S
+              - renesas,r9a09g057-pinctrl # RZ/V2H(P)
 
       - items:
           - enum:
@@ -66,10 +67,14 @@ properties:
     maxItems: 1
 
   resets:
-    items:
-      - description: GPIO_RSTN signal
-      - description: GPIO_PORT_RESETN signal
-      - description: GPIO_SPARE_RESETN signal
+    oneOf:
+      - items:
+          - description: GPIO_RSTN signal
+          - description: GPIO_PORT_RESETN signal
+          - description: GPIO_SPARE_RESETN signal
+      - items:
+          - description: PFC main reset
+          - description: Reset for the control register related to WDTUDFCA and WDTUDFFCM pins
 
 additionalProperties:
   anyOf:
@@ -111,6 +116,15 @@ additionalProperties:
         output-high: true
         output-low: true
         line-name: true
+        renesas-rzv2h,output-impedance:
+          description: |
+            Output impedance for pins on RZ/V2H(P) SoC.
+            x1: Corresponds to 0 in IOLH register.
+            x2: Corresponds to 1 in IOLH register.
+            x4: Corresponds to 2 in IOLH register.
+            x6: Corresponds to 3 in IOLH register.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [1, 2, 4, 6]
 
     - type: object
       additionalProperties:
-- 
2.34.1


