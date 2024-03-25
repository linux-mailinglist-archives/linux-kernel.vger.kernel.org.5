Return-Path: <linux-kernel+bounces-118014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2CD88B25D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249401F66550
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1506EB67;
	Mon, 25 Mar 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp+kwBAr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA106CDA8;
	Mon, 25 Mar 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401017; cv=none; b=gSf3wVFc6gRGAHdZQoBnWKjEitjl6LkWQ5JqwZKN8b0TmArE+HYz6h2uSMeWRZuRPM0bQFsFiVPray4R/KYajjaqLa8xIETBLqn3Kz3d2Pb9+jiuDSQo5w31R3zWvnYyiFYvnRwVHYxA0ndO/Q/rfdiW/k9DKLu61ZyfkqI/FpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401017; c=relaxed/simple;
	bh=0C/hR+vVhndJOu79cHPpybTGkc1nbQxrekpod8eDOmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyHoyQGPgGDlrzRKBnxiPg/GzvZ58zNattLIUyltxOSiiG58KcFNtPF+SPnLerk1ttU0+IUSOm314t7UjVcAXluQh/230N1QiibbAY18jxxTEjyvXp/kVKYKcDczgFl10z291ETUtMdRyPk5wVUBA7xZ18z+69DiC27aGPWCHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp+kwBAr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4148c72db39so3356825e9.0;
        Mon, 25 Mar 2024 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711401014; x=1712005814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRRl07fZIHfDCqnd0K822LHVNKrOqa1cW7Ay0SRBZXw=;
        b=Yp+kwBAr/PS7JLcy+Hz4xDLvqmghQCQQKMVmuCyVolU+0DKIPQpB3FfVHwoDMdKjCg
         CL34/tE7qlFdoG0fHpr7OWpDdBZv8a4I8FizihRjSJxQeVNj3e0oU5UHd0HYhJj4B1uE
         LqzVwtzLO4wZVoVlF7D3n2KNHUL24lsbFywtsASdwDxX4Au4yjMrYHZ/3jwBiO7dkZSh
         tv4ELwWZjBRHx8bjzoUfojfNGlFbMRelDyUBnYrkNMHwTCdeDZUSKECZMw/Ws2Bz9SDI
         5EOZvixuLTtCnAwnRt0Dawmf7eM2FusUvMPtcatEXOWigqnzrPwieRI6wWyGf9y0JG81
         kl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401014; x=1712005814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRRl07fZIHfDCqnd0K822LHVNKrOqa1cW7Ay0SRBZXw=;
        b=jabMuToVsTBYzb34CJIbz4xxDpq28zwrNfj/oH6WQSfDBfKzEOTpEoBD+rjxi5e0y9
         WNHgq+FD3WTzwI2R3VInPSUYA0NyHtUyTuJ05MKRNM9GScCobAEtWpW3uRdIABj6WTCV
         dJW3X2GRZpZkcFmI6WlwJ5vk4TSPdBz6kXLg38Fm+EdzCqzY3G0sHk6oQuls8ybwp/9H
         Tom/NS23COUtzkgddYsP1qAO571EfnvDJz5ZWvd2LElbWGqxEIjLrg8oL1/2fXSyxkeu
         w8CXTV7s/ZXl77DIrZmDgrVyflpCbf9DZNlqvhwAfvU7JlGoArZd/Xg+PFeoqJxUxyNe
         JowQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFY5NvTWtr0q5hLVBpMB1QF3aZdrhYNf/qfPqkRcLpWstVZfDQHkDaBu9VYV4V5lnOU/eiT/SSRixMc2szJAquw044XSlYbKYLLwQR0icC7jaqQPq7TzROP73TxE95+AlfR9QEgY3kPw==
X-Gm-Message-State: AOJu0YwS0tNj7o6FH9PVoOkyhG7tSS8f1VfazLz+OD8vlL87UMHSM9M9
	lHMYLnqf31hzTnfCCmHdx1o2JPL7PbGMjdt5vr9USD+p5sL2v1Ah
X-Google-Smtp-Source: AGHT+IHq9CrOgsEnBBN/g58fr3moUJu0SexNpXg5h0vnwzQuZ8+txKDnVtGwuK8QOKdzpvMID0nfGw==
X-Received: by 2002:a5d:4805:0:b0:33e:7650:24c8 with SMTP id l5-20020a5d4805000000b0033e765024c8mr5028183wrq.12.1711401014171;
        Mon, 25 Mar 2024 14:10:14 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-36af-6d49-8348-9a76.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:36af:6d49:8348:9a76])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b004148c3685ffsm1520768wmr.3.2024.03.25.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:10:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Mar 2024 22:10:09 +0100
Subject: [PATCH v2 2/4] dt-bindings: rtc: alphascale,asm9260-rtc: convert
 to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-rtc-yaml-v2-2-ff9f68f43dbc@gmail.com>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
In-Reply-To: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711401010; l=2635;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=0C/hR+vVhndJOu79cHPpybTGkc1nbQxrekpod8eDOmI=;
 b=EK8aPneZBYu0oOePBXm4GjMabT28GtlGNOzXbr9dEypprIvX5zuZ3G/pgb06KlBUKPcajjuon
 3UNvfJyW7AGC6tyHlAV8WRiusTeVRxtS+D4b0/sVSEY4dkGDCyXJ7gO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

This is a direct conversion with no additions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 --------
 .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 52 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 19 deletions(-)

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
index 000000000000..8acd5e94fd58
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.yaml
@@ -0,0 +1,52 @@
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
+    description:
+      Base address and length of the register region.
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


