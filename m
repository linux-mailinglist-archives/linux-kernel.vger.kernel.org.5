Return-Path: <linux-kernel+bounces-165077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122A8B8777
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCB0284961
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01345103E;
	Wed,  1 May 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CB7VoMDD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EA502AC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555180; cv=none; b=hgF24hIRmqNBRAHKX+mzV1gcTBZGN2YSwj9kM490d/Lpntcst+7RcxwvZL542VWROnMfNEgRTMnmfnYkVZo0a8yylhSAfhIhCleisbg0cJnCue8WYEI6gz3P75pb5//k3fCnhBo59oiIjuskRMepbJ57Yd3QFuTQ1UB9OKF2X+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555180; c=relaxed/simple;
	bh=fWuvS/YrupAs+2uDCcwTv76fh6CyTz+lWnjpdQCnTmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucQECPPDvBjD0NUo0GhnbZRTl4UvFmC0E/HoNnXRRUpKBM1HeSbykRubNQaFnpeWrQR5bxHPLhMdjDPUFOEbnaSWY9zBAnhaEuZYz6encDOKWQEVIAjoKYS6umzAY6ickXQsbvFcXbjroE/3R6TICwFWHfjaUTSb9BRDdwpw1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CB7VoMDD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58a36008ceso774263766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714555177; x=1715159977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjC0thOUO3AI+wU5orw4JxlnIQvZns1Xrbd8AZdvPQo=;
        b=CB7VoMDDGzAQ+mCP89r2PbkPl0TqBc6wek0ajpxgVSq74sbOZBv3Hhr2Zd0u6SsOJd
         ib0mRuyj8KAPkXiCW5OEJZIC2VmNYeoH+lDgB0iNHLC1F7MnsCJUM3ZLJJKppNn35BNP
         MqxYKl/u+azEjwF1hMY2x21xzotGmZ66CsvlHhTzTIk/Onq1lyreBoEf8rLwzuFpvxV5
         jfkQ8zv/twTwMKJ0T/b5frs42722txD6zJTQoYCd/LXwxtN7T/b4lKCfP62VhmSYOonW
         HZDfNyjy8B+vWQ01eQBLDaEwXDMN2rdAb30frIvelbC3FOfWcCbNHyHhBAFVZdR/V12O
         OEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555177; x=1715159977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjC0thOUO3AI+wU5orw4JxlnIQvZns1Xrbd8AZdvPQo=;
        b=VuUQpXkhCRv1Tdd8N07JgnG7oihg1u3E5Ht98FxVDiUm/l0TJfQuCnjbW2SXX+X9Tr
         zPVVwaIo66eugsRoNE3mTaLojH9O4rQthJ2N+1amm+M8seKIVCsT50TphW4YpZe26ZIg
         rDMhNJWKI9U4CBbD7qSdW+qWkKqQUbzUbZ4i9PH7iTHugtmy1MaCacfXLrnJwgJp6He+
         0ICCksLI/K2KB0nunPugk4kctJtow+lBgZP4ySSY5J9zRdFZdNT51YbclqwJoLNg6t5Z
         n4ttc0y5pfxHevRinpeeJZWJZ/pXgIuxpSZMmPLIE9SdYT0TmTcwPy8kQj8LTKKOleYG
         0u+g==
X-Forwarded-Encrypted: i=1; AJvYcCWhylqoCpOlT4JxJQhZ10wdGEO0Un3VEBJfssWLir69WSFfFPmovZJM2gWKaztgjv9noB8ky4jFTZYfrEN8kXQdJjZ1mAfSOQ95Mmmx
X-Gm-Message-State: AOJu0YxNLAdIq+607xKhoarDvZmJTwhyr+vscC5jwgBJFCpoN7Y6ZQlQ
	OyOJ2PM1q9wT2S2XGILFZxJDLddpTlJdbaawDbefbhsWCn874qtF3KWaNkMHV1c=
X-Google-Smtp-Source: AGHT+IHZcl/NwEeZn+eEz03CLh9cMSeWZJA/2KYO9UAu5/Lo5NKkHlI5Bg8SHMlhBa7fThQtTrER9w==
X-Received: by 2002:a17:906:e2ce:b0:a52:19ea:8df0 with SMTP id gr14-20020a170906e2ce00b00a5219ea8df0mr1534908ejb.66.1714555177641;
        Wed, 01 May 2024 02:19:37 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id bw13-20020a170906c1cd00b00a58de09fd92sm5425674ejb.27.2024.05.01.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:19:37 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 01 May 2024 10:19:36 +0100
Subject: [PATCH v2 1/7] dt-bindings: phy: samsung,usb3-drd-phy: add gs101
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-usb-phy-gs101-v2-1-ed9f14a1bd6d@linaro.org>
References: <20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org>
In-Reply-To: <20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, lee@kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Add a dedicated google,gs101-usb31drd-phy compatible for Google Tensor
gs101 SoC.

It needs additional clocks enabled for register access, and additional
memory regions (PCS & PMA) are required for successful configuration.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2: avoid having nested else/if, and instead change the existing 'else'
    to explicitly state the platforms using 'if'
---
 .../bindings/phy/samsung,usb3-drd-phy.yaml         | 61 +++++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 452e584d9812..f99f055ec704 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -25,6 +25,7 @@ description: |
 properties:
   compatible:
     enum:
+      - google,gs101-usb31drd-phy
       - samsung,exynos5250-usbdrd-phy
       - samsung,exynos5420-usbdrd-phy
       - samsung,exynos5433-usbdrd-phy
@@ -57,7 +58,18 @@ properties:
       the OF graph bindings specified.
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: PHY register base address.
+      - description: PCS register base address.
+      - description: PMA register base address.
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: phy
+      - const: pcs
+      - const: pma
 
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -81,6 +93,34 @@ required:
   - samsung,pmu-syscon
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-usb31drd-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Gate of main PHY clock
+            - description: Gate of PHY reference clock
+            - description: Gate of control interface AXI clock
+            - description: Gate of control interface APB clock
+            - description: Gate of SCL APB clock
+        clock-names:
+          items:
+            - const: phy
+            - const: ref
+            - const: ctrl_aclk
+            - const: ctrl_pclk
+            - const: scl_pclk
+        reg:
+          minItems: 3
+        reg-names:
+          minItems: 3
+      required:
+        - reg-names
+
   - if:
       properties:
         compatible:
@@ -100,7 +140,20 @@ allOf:
             - const: phy_utmi
             - const: phy_pipe
             - const: itp
-    else:
+        reg:
+          maxItems: 1
+        reg-names:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5250-usbdrd-phy
+              - samsung,exynos5420-usbdrd-phy
+              - samsung,exynos850-usbdrd-phy
+    then:
       properties:
         clocks:
           minItems: 2
@@ -109,6 +162,10 @@ allOf:
           items:
             - const: phy
             - const: ref
+        reg:
+          maxItems: 1
+        reg-names:
+          maxItems: 1
 
 additionalProperties: false
 

-- 
2.45.0.rc0.197.gbae5840b3b-goog


