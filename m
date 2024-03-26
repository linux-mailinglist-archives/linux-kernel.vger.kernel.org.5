Return-Path: <linux-kernel+bounces-119032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB25088C2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B771C343EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD06757F3;
	Tue, 26 Mar 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jINqp24Y"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7817440B;
	Tue, 26 Mar 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458212; cv=none; b=DgFFZ4EfhtJMdRAC6ameGXpHDVESLjDskbCmH3cSo+d6ND/2Ww+j9+gmN3enYn0M1Ah2jqNDS0Xeuarod87S9XTjyF8D2f5MHH0WQp2WJD4wekNnwIV+fWgoxh14vr3DC2IcVnH62fj4P9bdYIxQ1v8l44XvQgV3YoPHVmG9yTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458212; c=relaxed/simple;
	bh=wVGtBpqnSQ0yWKHruGIYnQQwxcD42XGvFVl6U3Cj6UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSVibJzAhLI8//PF0TfWVJVlfBW1TEVQLPyILt/S+ylecZV85w9HXjdm7ReT++kTi3aifYHWhfp5IN8Lx8tZjOwOi7vNOmveLrfeW0h+t1hed2dc/MhzgWevBLaDFa7iHKtHcVfilmS36XePxTn82QZMJwCMkWdGg0PkyVx4ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jINqp24Y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a468004667aso743596066b.2;
        Tue, 26 Mar 2024 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711458209; x=1712063009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UV2sux2QncSK7xl+qajqlbNGu4rD6PD8uK/Z947iCf8=;
        b=jINqp24YZMUDVblGyMD301ONRLyoSbqVtirA/yHe91GGlEexy4z8BSMmU/JxwFOBY+
         IAp6MYAtUPFP57ZnUNul1JLYD6e97oUKsrTjlihz9peZZ2tWDulIcLWv/UMxOGfJh8lM
         9w1b5b56unBPFA7j9EL48FMSAINbFKKk48ZGD/RehEy9GOpQWQM4U6pjzkekqR+REcTA
         pafb4YM0w4XQitmwvgwknvU9wfm+IeyJaJtaCcHKeZuJCukPE6obvY9UvRlQfGOtWtUO
         K54iAG5CSPZs8EBcuRbzFuMSSJucbzmDF+hFAjX3G0kvJ/+CSBDvs5TdAbPV9YwO0Z9n
         GgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458209; x=1712063009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UV2sux2QncSK7xl+qajqlbNGu4rD6PD8uK/Z947iCf8=;
        b=ExpFizjsjItKL445ukKRZAxVSYytfLGxK/99kEprk0K6SM+nvrRful7cuL3Kppet/J
         Hhuh8yUZjwps64c8fMyAsS7sGmFTst1IAfcCSGEFPBBmIuHu4H2uLz87BD7jSqdKz6xz
         B0yTivCK/7hF1IqiIhbbR0zb2d0qqpUjVdEWdj2uMVCbyxeQMSvcQPeTGDGbH4M6Pk21
         HOr+qiPZaNxZpV/Rq6rij/lCOXppHXrOARfBDQ1ezccFUXsPjl/c+p0/UpxlHfZYq9ox
         vA6pE5OapeRlNBWtrWay2PAbcGUyoXJhWpUDdMAbACnv6Jqo2/vF4JgD7YCS09l/YFHq
         KYsw==
X-Forwarded-Encrypted: i=1; AJvYcCV86N6vClKRKlAr6OqRiNsRpYJgxXqcw6E6Wid+f5yuvew3DKJ+SdlpKGlVz7dxoFpMQb0LgWy1yUAr5O6yJDSoL8xy30RHgWhOlALQPxQf4GmcvfcMyVKKs3VzC4USfE8jjuIaYv2tYA==
X-Gm-Message-State: AOJu0YxfAfSg4tMq5hetKdnbaYb2gIJ/JQHrPC/AiRRYxptUekCJjrX6
	Epk0xkM7ndBBVxrS5ngVaykGalpUmVvEGfau+aQjnwYqXRSELxnS
X-Google-Smtp-Source: AGHT+IFsjRc+wtrjl+11pRe8c+r1CXSWx4dA/uNr9SqwGTke9OyXHyQhGUZdoE22Ql/NYY9C20jx1A==
X-Received: by 2002:a17:906:1c06:b0:a4d:b0e9:efb8 with SMTP id k6-20020a1709061c0600b00a4db0e9efb8mr873984ejg.24.1711458208980;
        Tue, 26 Mar 2024 06:03:28 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b4b2-cd0d-1ebc-3c05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b4b2:cd0d:1ebc:3c05])
        by smtp.gmail.com with ESMTPSA id wg6-20020a17090705c600b00a4a3580b215sm2206279ejb.80.2024.03.26.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:03:28 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 26 Mar 2024 14:03:24 +0100
Subject: [PATCH v3 2/4] dt-bindings: rtc: alphascale,asm9260-rtc: convert
 to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-rtc-yaml-v3-2-caa430ecace7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711458204; l=2627;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=wVGtBpqnSQ0yWKHruGIYnQQwxcD42XGvFVl6U3Cj6UA=;
 b=qE/PmTQuVtj4lqNnoWbhqicVrL6kl1Df3i0zjtM5SsJAT/sg7xjsJ0Z0ZH9WRP3dlJcj2sXoK
 /kPD+ulHH0rDd7SlovfWzqpKZLU3X1fvjUl19E4mOkCW8jXfYmlU3lW
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 --------
 .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 50 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
deleted file mode 100644
index 76ebca568db9..000000000000
--- a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Alphascale asm9260 SoC Real Time Clock
-
-Required properties:
-- compatible: Should be "alphascale,asm9260-rtc"
-- reg: Physical base address of the controller and length
-       of memory mapped region.
-- interrupts: IRQ line for the RTC.
-- clocks: Reference to the clock entry.
-- clock-names: should contain:
-  * "ahb" for the SoC RTC clock
-
-Example:
-rtc0: rtc@800a0000 {
-	compatible = "alphascale,asm9260-rtc";
-	reg = <0x800a0000 0x100>;
-	clocks = <&acc CLKID_AHB_RTC>;
-	clock-names = "ahb";
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml
new file mode 100644
index 000000000000..f955a7f638ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/alphascale,asm9260-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Alphascale asm9260 SoC Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: alphascale,asm9260-rtc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ahb
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
+    #include <dt-bindings/clock/alphascale,asm9260.h>
+
+    rtc@800a0000 {
+        compatible = "alphascale,asm9260-rtc";
+        reg = <0x800a0000 0x100>;
+        clocks = <&acc CLKID_AHB_RTC>;
+        clock-names = "ahb";
+        interrupts = <2>;
+    };

-- 
2.40.1


