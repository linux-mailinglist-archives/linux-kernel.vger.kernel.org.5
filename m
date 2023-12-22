Return-Path: <linux-kernel+bounces-9647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF781C8EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C621C2876B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DFA17985;
	Fri, 22 Dec 2023 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MSzGikbp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014917723
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33677fb38a3so1685536f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703243843; x=1703848643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA472qIZSqNES0rFti6bcuMYBLF91YXl05BR5PTQI+4=;
        b=MSzGikbpYIs9jUBZpDsBxFVEOUVDbEshKBqBmNut2IG6eluAy8C6mKwW4ACCmOL64d
         LFd66/xNb81u85D/Zd2dxDtjC17SlpIL8HRCM8K0NMiNquzfiuZgCvKHmo79HL5xSzQH
         TlRaky02hEbYhtgj5adspPqKd8UzaVyILLskI5h9N2jbXprLAYo7ExgwNBMGZWmc2v5J
         QhCkd7UmINu/TOLgV5Et2w/T7gjCJolZuA+9vDDpSq0qWt2CkTGg865I7CwCNPxSouIE
         qRzntlWrhjHlVHvTSRyhIlrh12lQolO0Pj5jqgkOu1NEju56s9cQFU43L9WJyh9dJOpR
         s0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243843; x=1703848643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA472qIZSqNES0rFti6bcuMYBLF91YXl05BR5PTQI+4=;
        b=bRlxYw9+myuXCiMpjzAMRGDV9Sknm7ZaNPo5L7BIPWJt/mdz/iITligHcei/F69AS8
         AMz6wXToV10OZzQ6vlDJ5z/UFF64xGvyQLU0NQyElf+Bxk4sp1fWA4aB1lfxrmWy3WNL
         Q3kSw/xFeTTNAQ5zXIAYJUObRBQhWNnzjUCrhJwcAMu2mMPMXLlLbNRDMLpD/Ug6/Qlr
         gv8Qg8sY1AElNmRonmZq4w2c6Cya84Gw+MM3lkYkQKzLyVIbEpINXlNtzLk6qTYqJjBj
         31HuqzYvgCC1OKwKmjxkfzjZ1rPKkw7spWtr6ZI3kD6+XfLTZY811O5LTi1VJaEnaHgO
         sdyw==
X-Gm-Message-State: AOJu0YxTpLuo74B0WTtw6ZEIBEX6qm1cl5w5afasXgdsHpkEuV8q/U55
	Ri3UvKpLAlVWPcbcYMgcLNTBpnUgXllERg==
X-Google-Smtp-Source: AGHT+IFUXx19gskZNe9Cq9ac+YP1EY1D+E8vci2xTMzrpmh05yyMydc9GsyL60EgpOEkotuo+oR11A==
X-Received: by 2002:a05:6000:1f16:b0:336:9952:f25a with SMTP id bv22-20020a0560001f1600b003369952f25amr184175wrb.52.1703243843434;
        Fri, 22 Dec 2023 03:17:23 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c099:e596:3179:b0fa])
        by smtp.googlemail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm4054069wrs.50.2023.12.22.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:17:23 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v4 2/6] dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
Date: Fri, 22 Dec 2023 12:16:50 +0100
Message-ID: <20231222111658.832167-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222111658.832167-1-jbrunet@baylibre.com>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs,
dealing with clocks differently. This does not enable new HW. It is meant
to fix a bad DT ABI for the currently supported HW.

The original clock bindings describe which input the PWM channel
multiplexer should pick among its possible parents, which are
hard-coded in the driver. As such, it is a setting tied to the driver
implementation and does not describe the HW.

The new bindings introduce here describe the clocks input of the PWM block
as they exist.

The old compatible is deprecated but kept to maintain ABI compatibility.

The SoC specific compatibles introduced match the SoC families supported
by the original bindings.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 50 +++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index a1d382aacb82..eece390114a3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -21,23 +21,35 @@ properties:
           - amlogic,meson-g12a-ee-pwm
           - amlogic,meson-g12a-ao-pwm-ab
           - amlogic,meson-g12a-ao-pwm-cd
-          - amlogic,meson-s4-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson-gx-pwm
           - const: amlogic,meson-gxbb-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson-gx-ao-pwm
           - const: amlogic,meson-gxbb-ao-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson8-pwm
           - const: amlogic,meson8b-pwm
+        deprecated: true
+      - const: amlogic,meson8-pwm-v2
+      - items:
+          - enum:
+              - amlogic,meson8b-pwm-v2
+              - amlogic,meson-gxbb-pwm-v2
+              - amlogic,meson-axg-pwm-v2
+              - amlogic,meson-g12-pwm-v2
+          - const: amlogic,meson8-pwm-v2
+      - const: amlogic,meson-s4-pwm
 
   reg:
     maxItems: 1
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 4
 
   clock-names:
     minItems: 1
@@ -58,7 +70,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - amlogic,meson8-pwm
               - amlogic,meson8b-pwm
               - amlogic,meson-gxbb-pwm
               - amlogic,meson-gxbb-ao-pwm
@@ -68,11 +79,14 @@ allOf:
               - amlogic,meson-g12a-ao-pwm-ab
               - amlogic,meson-g12a-ao-pwm-cd
     then:
-      # Historic bindings tied to the driver implementation
+      # Obsolete historic bindings tied to the driver implementation
       # The clocks provided here are meant to be matched with the input
       # known (hard-coded) in the driver and used to select pwm clock
       # source. Currently, the linux driver ignores this.
+      # This is kept to maintain ABI backward compatibility.
       properties:
+        clocks:
+          maxItems: 2
         clock-names:
           oneOf:
             - items:
@@ -81,6 +95,27 @@ allOf:
                 - const: clkin0
                 - const: clkin1
 
+  # Newer binding where clock describe the actual clock inputs of the pwm
+  # block. These are necessary but some inputs may be grounded.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-pwm-v2
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: input clock 0 of the pwm block
+            - description: input clock 1 of the pwm block
+            - description: input clock 2 of the pwm block
+            - description: input clock 3 of the pwm block
+        clock-names: false
+      required:
+        - clocks
+
   # Newer IP block take a single input per channel, instead of 4 inputs
   # for both channels
   - if:
@@ -110,6 +145,13 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@2000 {
+      compatible = "amlogic,meson8-pwm-v2";
+      reg = <0x1000 0x10>;
+      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
+      #pwm-cells = <3>;
+    };
   - |
     pwm@1000 {
       compatible = "amlogic,meson-s4-pwm";
-- 
2.42.0


