Return-Path: <linux-kernel+bounces-130237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B518975CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D771F21D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74258152172;
	Wed,  3 Apr 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM83IQSW"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C918E20;
	Wed,  3 Apr 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163614; cv=none; b=IZoiXoJstKozalS8WNBefQL3gYlgQkafsqLMQs4PAd/9hv3OG0/4yCxeXRdN/ma94Vrpt46MGwC6mxXYjw/jMj30CwBuNItmgmIB5wv/iA4wdXqEeTLkZ4nUE0vjaa2cCALCwbLfQ+yCIcssKeUS6HpydDYjrlTadMkvKjc3BHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163614; c=relaxed/simple;
	bh=z3FscXihxwpOV4ROqTZ5m0E+vHpG1jkSs+uhYwvMfYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L24nVwndyTKLZ7YqaeLTOMCSfK/Mbkbjeh9GkrwS7UUnTjdhf9mWVvzoUXlhjGM71EJ60ycvK/01I8TpCrIXp1xeqbk7Xb0I/7edxhgIvjIbahAD3WLVlGiyXOAQpycxcurzkiB7aBBbZyGFACZdYtF2DW2UBe9gSp9n8f4QLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM83IQSW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e704078860so13892b3a.0;
        Wed, 03 Apr 2024 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712163612; x=1712768412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iqVZ5gA1EsiAAqdiE1q1pz002POsB1V3jfn1PcyLTU=;
        b=XM83IQSWa7qfNLPwsPoBsXpZSGMdmh0qUJvLGXx3OGN8oH+hY579EKjiZEo4UVj7tb
         52bYdnvw9tzqII5Roc6KtPLRQGbKKxK5VtXdZDcuko2B4ZuWzu+06zUup/yxqz/tmz3q
         GR99pCJuqu/rePZ9zOO/v8TBNq7Z85ml9jtUNxzt9qLLdXcciAL+oPsqyC4hRh9eEEQ7
         Ygq772lCdD/JCDeukDwTyzVaJMLLPxYFYyoON9bO20f3AUMOrKS5FUpKgYNEuRRM0L5T
         ok2Mo2awpFcQWstxbV/4YhiyOfHc1fklDHyfYSopoKfRSgCqud42Jx4q+W65lTNHKTey
         FnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163612; x=1712768412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iqVZ5gA1EsiAAqdiE1q1pz002POsB1V3jfn1PcyLTU=;
        b=oO1ybnP4Og0JMFkjNVAeeydML1t8SB1Mjubr8v9i21vMPcnq2yukX3wSKGDORIv2V1
         pnFSoVirPrc+azr3V7VzKsQcoIT96ujg94E/55WiygQRzlfje42tX0RYE7pAUq/mtdfU
         yq0AfV9t7E3Qggq0218vuGcb547WBE50C8fkCS5cbZ4uFGflqjnPf8ofLYoKIC7Pd1a0
         SvONK4hu0ayz7lSSHaJgRDbVm9lTk3hfRiEISSI8vaq4vREPebor8q886plhrl8/iRv/
         Kc4gEhGA4i2QvxxBK7vsFmOGKMkX3ISAtZR4ndSO9rVswn5Q6YjMiPZBfPt7daUcHSCz
         HsbA==
X-Forwarded-Encrypted: i=1; AJvYcCUdQy4axrM1Dv+pGjnuqUN+bRyuPAPS9d9oUANtIRp7uh54nEyMxNbbRLtXmy7LS/qwQaq6wum6dnKYzFqy6NuS+CjB0I5qgwp9Yc14zagQVzU4Ix90v/hE+5Fqlh78DoLwFjbnInDHeg==
X-Gm-Message-State: AOJu0YzuiXJdqy90SgRcObRcc5IMytWJhBFe+hzyWKVDIJE64Uq20pbu
	PSES0PTbfhA/m3CBqVHUoojWfjNWsDadRALrxo/24dJrUc5cqv6S
X-Google-Smtp-Source: AGHT+IEGnCuTqwRJlWkcslahpnxgW2v/avadB030lgfgF5175R9lm9IIeIXhMbMokkf1DfF6h9e5WA==
X-Received: by 2002:a05:6a00:21cc:b0:6ea:e31e:dc75 with SMTP id t12-20020a056a0021cc00b006eae31edc75mr121993pfj.5.1712163612561;
        Wed, 03 Apr 2024 10:00:12 -0700 (PDT)
Received: from localhost.localdomain ([203.188.229.101])
        by smtp.gmail.com with ESMTPSA id c2-20020a056a000ac200b006eaf3057352sm8891925pfl.85.2024.04.03.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 10:00:12 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: bavishimithil@gmail.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: omap-mcpdm: Convert to DT schema
Date: Wed,  3 Apr 2024 22:29:50 +0530
Message-Id: <20240403165950.75-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mighty <bavishimithil@gmail.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../devicetree/bindings/sound/omap-mcpdm.yaml | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.yaml b/Documentation/devicetree/bindings/sound/omap-mcpdm.yaml
new file mode 100644
index 000000000..8c9ff9d90
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/omap-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    description: 'Register location and size as an array:
+       <MPU access base address, size>,
+       <L3 interconnect address, size>;'
+
+  interrupts:
+    description: Interrupt number for McPDM
+
+  ti,hwmods:
+    description: Name of the hwmod associated to the McPDM
+
+  clocks:
+    description: phandle for the pdmclk provider, likely <&twl6040>
+
+  clock-names:
+    description: Must be "pdmclk"
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    mcpdm: mcpdm@40132000 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts = <0 112 0x4>;
+      interrupt-parent = <&gic>;
+      ti,hwmods = "mcpdm";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


