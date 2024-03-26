Return-Path: <linux-kernel+bounces-119031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1788C2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72391C2FDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B274BE5;
	Tue, 26 Mar 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFDJRRb/"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2D70CBA;
	Tue, 26 Mar 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458211; cv=none; b=jq30E/Z2wcFeODSIyfk7d09D0hlPbTcGpGmE4nxX6h7ZPDVo1Js2PXiFbJdq026BRbwO7GR52/H8vNjeZa7ATHcwYsrvmamkD/vjkBcbSlR6VURpIqzV8xr5vmUsTiF904lho8Ryho9/96jTdsIw+atezs08MhIrtN+vTBROUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458211; c=relaxed/simple;
	bh=y/h9r7NFUTzcI7Q+8rrEH8zrSjp8JvhTnSX645n/aXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKwlMeJYMVDzC4rUQFZ5vPQgMAZyXn2Fee9pO/Qqxnmwf481nUeA9oKOfVMyyg++WCJ/PLxEylgKwI7yGloUSd2Cuhk2+6DIIeHGoCrWKGCJMVkShSi8iz171lnvzW3CL0ArbHQRwC1Bj7wIPvghjMh6qMds273FVHn1oPRrgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFDJRRb/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d485886545so95703781fa.2;
        Tue, 26 Mar 2024 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711458208; x=1712063008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6N43O76PWF7Rd134qi3Sj/Jiz8Q3AnOJJYGd71yv1U4=;
        b=TFDJRRb/WNXJkjCanfLPdbPInh1/4W+xruGHpnGUDoCP+H+oCe2sXduXtrK34Bw6OW
         bg9yBJjcp1UN6QRkmAEXsmUOMyOkUs5eeSUTyitVODYgqBlz51giZs9KiVQdvvXKJQoa
         JHKaY95EkGTpz0XNsRTqE42z84iF0pV0Q2apPAirkDHCWKnQFwy0xOWlQqIFKr5p8zs3
         LEMphDayOYaqozkR72tyVymMrxLa9vymmY0Tw5iRdSy7mPZeMcvgwBUqskGl304ys1yy
         el5iR+GjLMhG4ymygXSD+Fg4Quwiln6AZ9r84Ti86fguIDrFXG8oau2uS75P7nwQ++De
         ZyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458208; x=1712063008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N43O76PWF7Rd134qi3Sj/Jiz8Q3AnOJJYGd71yv1U4=;
        b=qlVFcoIUews5lvfJdbGmHm8Kb1F0OGWlm3/xHD9k0LkvGEcMd0ci49ZGYrGtTlB5HY
         4cTrApL6MH7hHeQkNwPa1rGGtg+ftSW2oeuH70vYI/FrnLnSKezCiBaP1CKl/jcxnnM3
         9kWASd6kh0uiiCYAGbpN30LWI+EteQlNW6w5oLsyoaVf1JClcj1AoOUaJCDxtRi9RnYo
         kREqf/XwHUlenWspU2d3bVJuLnPZLmn1z4qCakuOU6bKBqsvZmAmUQoR/I8E3/ouudIJ
         jaAIAuy8z/Nr539r8A4P2yxTmz0NAN6F1hIfwgyCDVmcskqIRfMRTcks46cQHc1QDs0W
         yyXA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8mAnzCnlhhGvSgr6px/P9DYkeheU4/BSNU3pIHDcoaY/chAUVdkVCTMijWQiRHOtM4kttUVbuykdZ4AgBqU96E7JIHVSNwc7w53DSLpln7cD022NazKs0UigNx4mELzskugi/2BALQ==
X-Gm-Message-State: AOJu0YyaG2KFRheN+2Yyj6jX7BK4itOEHkuQL2mYdvdHyp8b1qiZZmmy
	eNGnwNJGOq74ucP+hOlaaZS1y49JoVAPn7NIm2MNbAEzTkOQuhx7
X-Google-Smtp-Source: AGHT+IFA9vWoLm7GaLGN/blnkCuoP3Gnm6r4UiczI7LSP99sIDL9oD4NiJAXjH1QCnl4uBOFXmBWzQ==
X-Received: by 2002:a2e:918c:0:b0:2d2:ea18:bcc7 with SMTP id f12-20020a2e918c000000b002d2ea18bcc7mr7988521ljg.23.1711458207396;
        Tue, 26 Mar 2024 06:03:27 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b4b2-cd0d-1ebc-3c05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b4b2:cd0d:1ebc:3c05])
        by smtp.gmail.com with ESMTPSA id wg6-20020a17090705c600b00a4a3580b215sm2206279ejb.80.2024.03.26.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:03:26 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 26 Mar 2024 14:03:23 +0100
Subject: [PATCH v3 1/4] dt-bindings: rtc: armada-380-rtc: convert to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-rtc-yaml-v3-1-caa430ecace7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711458204; l=2981;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=y/h9r7NFUTzcI7Q+8rrEH8zrSjp8JvhTnSX645n/aXk=;
 b=liAKRWfW3jeVzCOA2UFnpAb5x+6Rm2hplEM/BFOBYRJWl3AaUoAMFMqt2tkrVeDlMExbCln88
 pTQxdy45mePCfVX289c2MI/5esMAyy12aksy7+DttZFkvLr2hXenXh2
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 ----------
 .../bindings/rtc/marvell,armada-380-rtc.yaml       | 51 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
deleted file mode 100644
index c3c9a1226f9a..000000000000
--- a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Real Time Clock of the Armada 38x/7K/8K SoCs
-
-RTC controller for the Armada 38x, 7K and 8K SoCs
-
-Required properties:
-- compatible : Should be one of the following:
-	"marvell,armada-380-rtc" for Armada 38x SoC
-	"marvell,armada-8k-rtc" for Aramda 7K/8K SoCs
-- reg: a list of base address and size pairs, one for each entry in
-  reg-names
-- reg names: should contain:
-  * "rtc" for the RTC registers
-  * "rtc-soc" for the SoC related registers and among them the one
-    related to the interrupt.
-- interrupts: IRQ line for the RTC.
-
-Example:
-
-rtc@a3800 {
-	compatible = "marvell,armada-380-rtc";
-	reg = <0xa3800 0x20>, <0x184a0 0x0c>;
-	reg-names = "rtc", "rtc-soc";
-	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
new file mode 100644
index 000000000000..adf3ba0cd09f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/marvell,armada-380-rtc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/marvell,armada-380-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTC controller for the Armada 38x, 7K and 8K SoCs
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-380-rtc
+      - marvell,armada-8k-rtc
+
+  reg:
+    items:
+      - description: RTC base address size
+      - description: Base address and size of SoC related registers
+
+  reg-names:
+    items:
+      - const: rtc
+      - const: rtc-soc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtc@a3800 {
+        compatible = "marvell,armada-380-rtc";
+        reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+        reg-names = "rtc", "rtc-soc";
+        interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.40.1


