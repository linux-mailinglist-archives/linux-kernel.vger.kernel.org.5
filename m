Return-Path: <linux-kernel+bounces-155630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B88AF501
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A224284C09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A97213E408;
	Tue, 23 Apr 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCriZWAv"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8C13DDBC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891988; cv=none; b=jQ+SIcoyMWSkQif0cdrDr7QVP0gaAA0XQQYmht2vQcsWOHfWN3b+BD2OO8decirvuojJN2z/XEkzMd5x3L/oM7eySiss5HHtoxQyPAsGW+W9weQ85/e2QiU1HRFYIxljRqGgSZFLp3YKCzStLBnuZV6SEIPzebhfwZRhsX4OsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891988; c=relaxed/simple;
	bh=+/8QLPiW/Kn3ZLyskL8ldNzf7tquoUxKp1/ZVi+DCsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdO3UbzuB9QvL2vksmkgiMw4pt6oQ91RmGXHDp5K3q+t8Iqb9KXS7AedPh+rWZU6nb9PvBT8im3qs/5X88u4VNW55Vi8eXJJ5smS+5WcsV4kJixKEVUeBji1OL0SVsV/k3ppNZ5CiFFKt+u9TvAkkMtAFA4C9QKGk79YH1x/OmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCriZWAv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a52223e004dso569069266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891985; x=1714496785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmVOMAacL5XFgxZMBxM5qRIgA9vpdjsgMSXx5Z5N0AI=;
        b=ZCriZWAvTZPhbh/7kg7KWJ7J8qyqaSjbzZ1NK5nAWorVk4TRMPQaLTTqNsHFBPW9qQ
         A2nrGI7+JnK0Z31EyPDts7Zb63NomtauuN2HaZRgMt5eL7RT/sLnbDDzT+0zY2qR3mcz
         hM0ITMUS4qTBsguzjnDxm6d7OmbiHKTd+DtTM0B/8C5hx8C5cfZGJfojEbD3NVjQu+Mt
         BCrMtexuhlUAX5qDSEy36wU77pxsCJQSF6tN9epP+b6yXk+xaSsw5RdSkyRhl9Ljw1w2
         akCVRwKMcl/kbhCwsOTgnIOR5hMrv9eGWjNxI978enilHjaIEMjFANOTIhCKes+cx96a
         LUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891985; x=1714496785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmVOMAacL5XFgxZMBxM5qRIgA9vpdjsgMSXx5Z5N0AI=;
        b=wxvw7Nd0txA7sx+fP5M/Thj/NbsyoorVGPg5XEZzDMVo7UEu3Yfhvgoc1Tv7PgIP1z
         0z8cu4MaZFP3JA4VfFev/aYAjo5ZVyUrB6vFB/gRzlWdrDGd9FkIxxzKazeeVCsRFKw5
         1FgSIj7br4MZXYrqg2GHDfcalcA9aa6uYjNRb2zF6frgQ8t6q3POmcxfmSavbYjdAzIs
         jhkFeO3wZbsjem6m8HCzBLcooGylbxPCMrMc0LcUe+y6cVTeotTSFa4kYk6PTdBC6A9j
         /VeYikxFaWy/EICjqOg0brqv/SkRDn+X7r89RQ98qTyLOxn9V04TmglIKEiSGx7J9lxz
         5oeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrxMyoAblfHQopz/OWHPZvqjwL3+IEQJdABFx/mrHomhipATYV6ODShBfoBMlrfTGDn93PudNopfDLp/J6sZzCWLOyyUUgEwar8PE1
X-Gm-Message-State: AOJu0YxWdxtjiBFwJYP59P7AYQHd7c/CnxC7Eoqb+IP2dA3IM+mmy5Zj
	C5vpQpcip3cAfe5j5sG+Z9ixw2Qe65+jRyrxD+oqMn4NzbcWW+Yp7RiNgTAxN6E=
X-Google-Smtp-Source: AGHT+IHFr6sGyLI+yphYekoqsdNMAx6XjzCJoHMxUHv0NqmcqlAxDCxNlJfyBgFU/lBIG84EZQBqaw==
X-Received: by 2002:a17:906:fad4:b0:a52:3492:d168 with SMTP id lu20-20020a170906fad400b00a523492d168mr11332528ejb.50.1713891985270;
        Tue, 23 Apr 2024 10:06:25 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b00a5209dc79c1sm7351624eji.146.2024.04.23.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:06:24 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 18:06:03 +0100
Subject: [PATCH 1/7] dt-bindings: phy: samsung,usb3-drd-phy: add gs101
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-usb-phy-gs101-v1-1-ebdcb3ac174d@linaro.org>
References: <20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org>
In-Reply-To: <20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

Add a dedicated google,gs101-usb31drd-phy compatible for Google Tensor
gs101 SoC.

It needs additional clocks enabled for register access, and additional
memory regions (PCS & PMA) are required for successful configuration.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/phy/samsung,usb3-drd-phy.yaml         | 78 +++++++++++++++++-----
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 452e584d9812..db1dc4c60b72 100644
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
@@ -85,30 +97,62 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - samsung,exynos5433-usbdrd-phy
-              - samsung,exynos7-usbdrd-phy
+            const: google,gs101-usb31drd-phy
     then:
       properties:
         clocks:
-          minItems: 5
-          maxItems: 5
-        clock-names:
           items:
-            - const: phy
-            - const: ref
-            - const: phy_utmi
-            - const: phy_pipe
-            - const: itp
-    else:
-      properties:
-        clocks:
-          minItems: 2
-          maxItems: 2
+            - description: Gate of main PHY clock
+            - description: Gate of PHY reference clock
+            - description: Gate of control interface AXI clock
+            - description: Gate of control interface APB clock
+            - description: Gate of SCL APB clock
         clock-names:
           items:
             - const: phy
             - const: ref
+            - const: ctrl_aclk
+            - const: ctrl_pclk
+            - const: scl_pclk
+        reg:
+          minItems: 3
+        reg-names:
+          minItems: 3
+      required:
+        - reg-names
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - samsung,exynos5433-usbdrd-phy
+                - samsung,exynos7-usbdrd-phy
+      then:
+        properties:
+          clocks:
+            minItems: 5
+            maxItems: 5
+          clock-names:
+            items:
+              - const: phy
+              - const: ref
+              - const: phy_utmi
+              - const: phy_pipe
+              - const: itp
+          reg:
+            maxItems: 1
+      else:
+        properties:
+          clocks:
+            minItems: 2
+            maxItems: 2
+          clock-names:
+            items:
+              - const: phy
+              - const: ref
+          reg:
+            maxItems: 1
 
 additionalProperties: false
 

-- 
2.44.0.769.g3c40516874-goog


