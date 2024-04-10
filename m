Return-Path: <linux-kernel+bounces-138932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833BA89FC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1098B1F24855
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445917555A;
	Wed, 10 Apr 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWQn15zL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B03172792;
	Wed, 10 Apr 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764555; cv=none; b=a7r6+K/v3LCp3EvCHJsBcYHk0ZtYbYTdsaII/mc8l7iJ2PfYE3W5q0crsDcGqKQW+F4Bh4n6PfdGh/fN9U4pVAJE69j6jvmlQVVY+rcKi5uK75YI7g93o6IsDHgr1a1WDqEVrbnOATS6uny2bmF6z4XuYeDTthTs+rQhuG+XzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764555; c=relaxed/simple;
	bh=BajpLIZvweL+aLqlkIOgDvaU5J35KCKUJstIeHQsxoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQdooi4cnkqcyOeYb8Q0xEuMXn/cLGgwCV4Yi+6HkH0MMg2OfjgzFXo2hX8e5WwOm5Y2gbcWZkM5qdLVwYmhPX4f7XlIcKgEdfUFoksabHevS6nbVw3zLlR88nscQu1VDNXdMBLK3E1qe4+zAfngqwKfOPs9Pt6e40vySjBMmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWQn15zL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51d3193e54so413590366b.2;
        Wed, 10 Apr 2024 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764552; x=1713369352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf5pKtth7HyQMR2CRAxRCRRYX77dJfg+HACjzgrcpPA=;
        b=WWQn15zLbrR5gE3ib7x086IA5mM+4b7ze/Apdh7KDM/OzRG+YermrqePrsjP5W36ku
         viq8OKMBpn7jvJhLFQhGfSDgV0vvkujAKQ7NlyPEvjoWmWKq0UN8Hby1QbtHeqxe4uQH
         btU10RJfP0rpLR16Iu0jKBxvvOAY/GWbNiAdxyxk+JAnqU+LyndT7Mjxu2dQb0LXK0Xz
         8T6HFrnWJzPA2Q3okPl1rLrlw17iRVZZUz8IZ5i/k8Bno8ZsykxQNjN+5EEqenqWqoVn
         TpCThESrNjwBCjxrGa70sbDy7NZJmzZ0zXT3/52BaArNCKTqqVF9shNOvu3uLWgE7Og7
         5+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764552; x=1713369352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bf5pKtth7HyQMR2CRAxRCRRYX77dJfg+HACjzgrcpPA=;
        b=RNQ8tq4llUKdv03Jj5BhTmShOyGPmJplGrnLckMzZ97vQDRoIHaqqzA+lLpZnkrTOZ
         aB5VsLpFRg/MTxk4ixhy9E2ob5nssrjY7Vv67B3mR1KIk8zKrtIef96GNntjUE4bf6SA
         pUCNn710KHF9npO4xDoID2JwK2UfOaoFKM9Z2QQNUFyq8m4RMZows9pEoDZC8R5gwHIK
         7Mk9VF7xV3kwNPJd+DckqMwH7BogGopPnwDFG+boEXZEZh8kKoMyv3V/9spacfWh6Ksk
         eNWOp5cz7aaY/HMl1dPqGpepi/wLYE6gvWX1xvKmDzA6Oselns0gfaoEb2hWf0yC3+YX
         CjDg==
X-Forwarded-Encrypted: i=1; AJvYcCXprpjCS3/+YHc8N5Puwgh75a5gqWOx2+djVAWNTZ0+YJsP+aim7DPiYiDsF+v4dC2aPLzWXydIdoIBm/BP8jdMjQnG/VSoQXTTRq7SxSnI7nFWc5O5SNUqqM6UPnvXN20ggYv3gSwNWw==
X-Gm-Message-State: AOJu0Yx4p9cbIxeOtfjF/v0vm0hnKhO8yaAkQArclqxKPBVkOiyB6gxK
	LFhFFbE91hNtJgCKmvK9+mS5vGqz0b49xlsfun4sYZybZv/eaYDNSMMgR6Pb5QEp7Q==
X-Google-Smtp-Source: AGHT+IH9ECOyJ4wkkOwf2xtDjNIpUsIMg8Pw0iVdXkQDB4YvgTtP4jNyI9hrkYj+EGDElqvho8fUmA==
X-Received: by 2002:a17:907:368e:b0:a51:d605:49e6 with SMTP id bi14-20020a170907368e00b00a51d60549e6mr2268733ejc.10.1712764551807;
        Wed, 10 Apr 2024 08:55:51 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id qw6-20020a1709066a0600b00a52172808c9sm279884ejc.56.2024.04.10.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 17:55:36 +0200
Subject: [PATCH v2 4/4] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-rtc_dtschema-v2-4-d32a11ab0745@gmail.com>
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
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712764543; l=2723;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BajpLIZvweL+aLqlkIOgDvaU5J35KCKUJstIeHQsxoU=;
 b=pHkT9z1UD5fi/tDYwREkpPZ6fWm/TGqk61RmoCGhwk+BHlwI0iLZdJFdVAqFoKOsy/rcgBj0N
 Wk7MHzYGe96AFVsO8eT0lvMCZduQXAoKHmPHQxBN9O9UBFkbRd66w35
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation and
add the undocumented compatible 'fsl,imx23-rtc'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 51 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ---------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml
new file mode 100644
index 000000000000..534de4196a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,stmp3xxx-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMP3xxx/i.MX28 Time Clock Controller
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx28-rtc
+              - fsl,imx23-rtc
+          - const: fsl,stmp3xxx-rtc
+      - const: fsl,stmp3xxx-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  stmp,crystal-freq:
+    description:
+      Override crystal frequency as determined from fuse bits.
+      Use <0> for "no crystal".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 32000, 32768]
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
+    rtc@80056000 {
+        compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
+        reg = <0x80056000 2000>;
+        interrupts = <29>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
deleted file mode 100644
index fa6a94226669..000000000000
--- a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* STMP3xxx/i.MX28 Time Clock controller
-
-Required properties:
-- compatible: should be one of the following.
-    * "fsl,stmp3xxx-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: rtc alarm interrupt
-
-Optional properties:
-- stmp,crystal-freq: override crystal frequency as determined from fuse bits.
-  Only <32000> and <32768> are possible for the hardware.  Use <0> for
-  "no crystal".
-
-Example:
-
-rtc@80056000 {
-	compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
-	reg = <0x80056000 2000>;
-	interrupts = <29>;
-};

-- 
2.40.1


