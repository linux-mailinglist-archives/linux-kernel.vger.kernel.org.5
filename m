Return-Path: <linux-kernel+bounces-74974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183AC85E0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3762D1C2302B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDFB80628;
	Wed, 21 Feb 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aR0TQKxh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F27FBBF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528333; cv=none; b=oxSJe/Ou/vbnsE6T4bZRQVlYN7x1k4rpTL9XsJWJBnciWoJqG+X+2co5sefQlRqQ/67kZHPzqtQyBm9ZXUybmJnddqh/BlwScxVDTcd9cxrgg4EGPnsNDuiYCzW+CynRKGgLEAjQgzbef5wzhoqFMNmoJjUgBjoNV7y9VSZFtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528333; c=relaxed/simple;
	bh=rM63ExwsBaOHEgSpHl10244P2WDwbbjheLQSfUe6erE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7f4+eTmVPdAPwXJxGhAJ0r3d7Wj9sxiCBnEinAeFqvyGjqYxvJCy+v8nFi0btzIvSw8X6t9v1FZJe+JgXsrHF8zDQ7K5vD6YkgbZkEg/5kaPo4WU2a1yboub7ATZVHuUNvYSTIIZskGbyPcTW4wxNRzQA0NCTGdkEv6zummHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aR0TQKxh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d509c5706so2108463f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708528328; x=1709133128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeb8+16ljSlEDFuGSbXwGh3NoqLN08Y0bLt4DyDQDqU=;
        b=aR0TQKxhrjo775Ggr4P64dNue4qKA99NcsFEHeIxJAYWOYj7phgtVjpPPz2BSm+tE/
         BnndTgkg7/le5M3ZxTzsVPje9+bL8mObswOiEImSei/rgrNEKI1CCab5f7J7njMqFrey
         6W04cpXOS4GF8ahHgF/4FHivksvCHSZ7SIC+OYc+XCID/MfKp5F30b4xsfEBUw0I60Cb
         q0vlNHuuLCjBTCyPc1PB3vf4NNPq2lAKDgvKlFlYfl2pKZMVXamzuXD5gWrRaxeZGk+E
         0d0lmTS+ZmRpa79MT+rl1sWUdXOcj9x1MCaQhnC/P+TGoVX/akrU9VpL4sI/YEMEa7G3
         rAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528328; x=1709133128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeb8+16ljSlEDFuGSbXwGh3NoqLN08Y0bLt4DyDQDqU=;
        b=pjXRunmDT6mdZDzHOQjQKSR9YDrjAtVm+GT5bJtrmyX6ZwaJeg8pxSsx4fQ0Xm+OO+
         lRNie46ztHm51+5Yar6wGvXxqBRh97Wl0vMI2MdkgN3Dq1C9trb8EIxEEkdkEkGhOmWf
         kYcejdCDHgAfi9Zs1SYwelb6Fh4AyhUKlJIYvv9/wtNb4maI44sL3BcNZPCR7a7tFhAV
         lJLYU9+Qmxe/Z9Gm1tBeL+k0f4pqO72GVNgw7CsJZH4XLd/KXNJ6AyuHCDTKPKJ8jthg
         v253ItYEr06DPP3DpCZKh0pSBnecD+apLw2bp6/BIOP6LZri31BBlm6y0JXKwx1jX4CS
         RBsA==
X-Forwarded-Encrypted: i=1; AJvYcCW4811P5LoDZkG2Bra5vEu7sZ1vltr8Srq/C5fDbpKHwt8dZYThwCUJrfh+dUnV6rhAznzRCdm7dRWrYEptXNJwIkt5AKlx/UKMssg4
X-Gm-Message-State: AOJu0YymjmRycXUBO26UuQFHgAJsxVBQDFo1BvxmjrL37bL7e2Zxuxdy
	hloB4l6u0GmltxoEc6dZyP/23ZPXxbB2hhtjSLTOOQFJ/uZXlRw9C+ZANZeqfsQ=
X-Google-Smtp-Source: AGHT+IGm2sH+dRd6PnvO83tJQa9VL0HTxHwYnaY9gzdZI6rvajQdxVWVttPfM8ui1jJcxYYhGdzRnQ==
X-Received: by 2002:adf:ffc5:0:b0:33d:3f21:c38b with SMTP id x5-20020adfffc5000000b0033d3f21c38bmr6021597wrs.25.1708528328489;
        Wed, 21 Feb 2024 07:12:08 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1b1a:d907:d735:9f9e])
        by smtp.googlemail.com with ESMTPSA id bg22-20020a05600c3c9600b0040fc56712e8sm18725342wmb.17.2024.02.21.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:12:08 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
	JunYi Zhao <junyi.zhao@amlogic.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/5] dt-bindings: pwm: amlogic: fix s4 bindings
Date: Wed, 21 Feb 2024 16:11:47 +0100
Message-ID: <20240221151154.26452-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221151154.26452-1-jbrunet@baylibre.com>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

s4 has been added to the compatible list while converting the Amlogic PWM
binding documentation from txt to yaml.

However, on the s4, the clock bindings have different meaning compared to
the previous SoCs.

On the previous SoCs the clock bindings used to describe which input the
PWM channel multiplexer should pick among its possible parents.

This is very much tied to the driver implementation, instead of describing
the HW for what it is. When support for the Amlogic PWM was first added,
how to deal with clocks through DT was not as clear as it nowadays.
The Linux driver now ignores this DT setting, but still relies on the
hard-coded list of clock sources.

On the s4, the input multiplexer is gone. The clock bindings actually
describe the clock as it exists, not a setting. The property has a
different meaning, even if it is still 2 clocks and it would pass the check
when support is actually added.

Also the s4 cannot work if the clocks are not provided, so the property is
no longer optional.

Finally, for once it makes sense to see the input as being numbered
somehow. No need to bother with clock-names on the s4 type of PWM.

Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 67 ++++++++++++++++---
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 527864a4d855..a1d382aacb82 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -9,9 +9,6 @@ title: Amlogic PWM
 maintainers:
   - Heiner Kallweit <hkallweit1@gmail.com>
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -43,12 +40,8 @@ properties:
     maxItems: 2
 
   clock-names:
-    oneOf:
-      - items:
-          - enum: [clkin0, clkin1]
-      - items:
-          - const: clkin0
-          - const: clkin1
+    minItems: 1
+    maxItems: 2
 
   "#pwm-cells":
     const: 3
@@ -57,6 +50,55 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-pwm
+              - amlogic,meson8b-pwm
+              - amlogic,meson-gxbb-pwm
+              - amlogic,meson-gxbb-ao-pwm
+              - amlogic,meson-axg-ee-pwm
+              - amlogic,meson-axg-ao-pwm
+              - amlogic,meson-g12a-ee-pwm
+              - amlogic,meson-g12a-ao-pwm-ab
+              - amlogic,meson-g12a-ao-pwm-cd
+    then:
+      # Historic bindings tied to the driver implementation
+      # The clocks provided here are meant to be matched with the input
+      # known (hard-coded) in the driver and used to select pwm clock
+      # source. Currently, the linux driver ignores this.
+      properties:
+        clock-names:
+          oneOf:
+            - items:
+                - enum: [clkin0, clkin1]
+            - items:
+                - const: clkin0
+                - const: clkin1
+
+  # Newer IP block take a single input per channel, instead of 4 inputs
+  # for both channels
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson-s4-pwm
+    then:
+      properties:
+        clocks:
+          items:
+            - description: input clock of PWM channel A
+            - description: input clock of PWM channel B
+        clock-names: false
+      required:
+        - clocks
+
 additionalProperties: false
 
 examples:
@@ -68,3 +110,10 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@1000 {
+      compatible = "amlogic,meson-s4-pwm";
+      reg = <0x1000 0x10>;
+      clocks = <&pwm_src_a>, <&pwm_src_b>;
+      #pwm-cells = <3>;
+    };
-- 
2.43.0


