Return-Path: <linux-kernel+bounces-81592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E28677F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A1B1F248B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167D129A75;
	Mon, 26 Feb 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9jeFNE+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLpYQeO3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126426E5E4;
	Mon, 26 Feb 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956806; cv=none; b=WlbwMwcFBBKmDHqU/E6SL5QTTrK0bamAZMo7ETYf8VzJUdJhhncYQBKDD5v3qMnsr2B88NSsyeY1KIrIV4C9yb2McEV47dpIzZ83E47VbcW0hq4pTlmU7OL/LsPsEtg+ZYzb0CR/LZ5m24gSlTu1EgYXsg//VQCLoUG7bxUudfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956806; c=relaxed/simple;
	bh=KxxqMEFzI/cuRkyQaEo1brjCbBcnoY1MB0TYpc2xyWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L4gkygb8hmbEFYyd3g3KmBFBKG0sa3/QDhkVZkjeF9H5hHSvS3eg0/VBN0BifvgCqfd4PZi9vfXp02b/ouqfuLf4A+V+5ED/lTdFUouakvtZhP/k2bMbXITsDp0aCDPMnvBmOcHhBLEpcKd9uR2ucG6tnRsYEKZVN8gXk+Ytj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9jeFNE+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLpYQeO3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 14:13:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708956803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1D8r4RuM60jwQbf9fJpPwR9KpOjyGBosQSQBTxaT/K0=;
	b=i9jeFNE+sO7qhXhlGc2sCLkexPjULfE2XSDiYrTO/+phyn+i0zVp0IyzoJZOfrRT0lJQAy
	P0943APHFMh5Tr66h6NpXVeE+H01rdRzy/f8p6Ief58FercKc5o5XASs6xW5EDD47mqxql
	x33lYchvuLrUiPZLVDtLE4J5gOCFj0I+VKiBnZlvsC9iqoUYXEyfuhJrhxu0NicMHQ2NtG
	yjqn7cuV3KWqCOpsH9TSebFbWW5MXgUIauu4u4QOybm8xoJ1W9ZKNIFDJZnusShFDq1t7J
	U/4gy4CMaLEZ+bf7Wi9HAiX4EedRvUzEEJHaJZ75zVhHuoIsIxQD+7nVAtB2BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708956803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1D8r4RuM60jwQbf9fJpPwR9KpOjyGBosQSQBTxaT/K0=;
	b=yLpYQeO33XCcMOOPEOaUYaKt7+3q3ELe8NoBPnbJADCxcaCLqryC5RK952QZS0HF2MEp/d
	qdwF8IVb2baI7KDQ==
From: "tip-bot2 for Changhuang Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] dt-bindings: interrupt-controller: Add starfive,jh8100-intc
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240226055025.1669223-2-changhuang.liang@starfivetech.com>
References: <20240226055025.1669223-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170895680237.398.4321467435072927437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d8c56cea725c4d46dd47fbfb4b35a37e7317ac43
Gitweb:        https://git.kernel.org/tip/d8c56cea725c4d46dd47fbfb4b35a37e7317ac43
Author:        Changhuang Liang <changhuang.liang@starfivetech.com>
AuthorDate:    Sun, 25 Feb 2024 21:50:24 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 15:09:18 +01:00

dt-bindings: interrupt-controller: Add starfive,jh8100-intc

StarFive SoCs like the JH8100 use a interrupt controller. Add a binding
for it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240226055025.1669223-2-changhuang.liang@starfivetech.com

---
 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
new file mode 100644
index 0000000..ada5788
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/starfive,jh8100-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive External Interrupt Controller
+
+description:
+  StarFive SoC JH8100 contain a external interrupt controller. It can be used
+  to handle high-level input interrupt signals. It also send the output
+  interrupt signal to RISC-V PLIC.
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-intc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: APB clock for the interrupt controller
+    maxItems: 1
+
+  resets:
+    description: APB reset for the interrupt controller
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@12260000 {
+      compatible = "starfive,jh8100-intc";
+      reg = <0x12260000 0x10000>;
+      clocks = <&syscrg_ne 76>;
+      resets = <&syscrg_ne 13>;
+      interrupts = <45>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };

