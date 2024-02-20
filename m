Return-Path: <linux-kernel+bounces-72960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702785BB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2480F1F21634
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8867E7E;
	Tue, 20 Feb 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="ETV3Vi0W"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98667C58;
	Tue, 20 Feb 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430250; cv=none; b=Q3gmWfnmApHnSAosybR3OTY9e9+9C7S1638PumDlMTo7cYWysSL8CGyNdBvYGOkwfIcv2Jgouvat8DSFj5/g488aDfYYSicASJtCtAozzuvuF1JeDDKr7LYC/9bw+DWP72poemmmn/t1UqIWwjFG4bW9kgI6tIBxmLTpo0eLdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430250; c=relaxed/simple;
	bh=ApiJ2S6pQ5GF5WwxHPrCGVwKlXhmPymVtb/IUGLJWjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnZ0XD7h5UapiN5rHWjFX37CtoTBMT5nhKylQSVJUKY2UuG5U+1pcVrHISP9ZcHaP2e8sSgubvMXZgOZg+ds+plynCi1TDqcZlzR6br5BmlDTGFljWioyuPbjEq0Z8eLDagdLCuPFTG8+BVBn4owY4cRwCbUJDj14wc4GJNx/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=ETV3Vi0W; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 6A0B5408D8;
	Tue, 20 Feb 2024 16:57:18 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1708430239; bh=ApiJ2S6pQ5GF5WwxHPrCGVwKlXhmPymVtb/IUGLJWjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ETV3Vi0Wg/WdSJIdxSWyrXFPpGTj+kbeIUT0LPS2Se4slN8Uo1c8DY7ijfuEQaYx9
	 CXNqk6vdiDucjrSMelc7ZmUf8BJnpyKP+ghldMskHHyp02WlWglpfNAceG5tZceo4E
	 DBFKN3RKudfj+il+xfeX325CnOVLFBn08Kryqqulos+TYdGbc2d9Rln/x0EYl2a8Kf
	 Ao7QY1hKPQmFQCJ3moCltr9JTy2ninrR56xYIqhprX7vtkSKH0HlsKQwatpfVhh2NL
	 qoK0yHwVoPKofceuY9JkC0WoHdudmcKHuKidI8anxgmQM9YykUPvo/5Pwxc+9lA3pi
	 9EHrlQ2UjORiw==
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 20 Feb 2024 16:57:12 +0500
Subject: [PATCH v3 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-aspire1-ec-v3-1-02cb139a4931@trvn.ru>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
In-Reply-To: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=ApiJ2S6pQ5GF5WwxHPrCGVwKlXhmPymVtb/IUGLJWjE=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl1JOc8rE2dI3hqLX96DfSRo6+tgB8i2jz80e1Q
 l3EkWcWQ2WJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZdSTnAAKCRBDHOzuKBm/
 dSAQD/0ckzoCZibBFoqGPVJzVznMl1JdV84XTv6BkcN6/EDTnSujDmRlVfrUVITT/UrLVS3RXU1
 X/kl5Wbkt6RsEvuiiXc0pslwwgv/rJAT/ocKbKp23kjxRDNUgdwkVXDx1iE7x2fk3ZWK+40Z89i
 lbIOYjTdIjrlXMEjd6G3xReaZ/G6+/zAWDHQ//0ymuORfcuWC7F6sUxhI8+kAdlGPHTP6is5GzF
 rncCpIUylx01nJxRrym5kkZiODUruhWY4ZY6pGuMXReNsAkyF4Vs8TrtFv/blyH97gjHxOp4Qnd
 CBnIcZprHooBWnut1aAZu4ZFkfdHWevSFhxmeagghAiT6p+gLZkm93nPu0Kb/urOAUL5FG1ewMf
 3Di85jAnYH6ADvX2xe9htgayVtPjkIeR5ulMYoGjxexh0kyT4eBVx9DuQ6MXlb+jVeTu30y0/d4
 2VODlrf4V2pB4yYM0yKmPNIMEo/ZmoOBxJF2xyw0JqIl0J1hcXRIZxycDGMKxIrFXJ7KBy53DMo
 4JlLO3h+IU63CcMGcSAu144b0qoZCKwIZi7ETjgrvBGThx8VahRo/3bJSziCoxNJ1fhjqRLHqfN
 lvVJIv79jphmg5zUYD5gO4kvf656BCu2Gv2sWxO7KA5YcbRDP8/7FgkRi+YNUd++9Ly40EmMW0L
 +IRNaA/7XMSR0Gg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Add binding for the EC found in the Acer Aspire 1 laptop.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/power/supply/acer,aspire1-ec.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
new file mode 100644
index 000000000000..984cf19cf806
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Acer Aspire 1 Embedded Controller
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+description:
+  The Acer Aspire 1 laptop uses an embedded controller to control battery
+  and charging as well as to provide a set of misc features such as the
+  laptop lid status and HPD events for the USB Type-C DP alt mode.
+
+properties:
+  compatible:
+    const: acer,aspire1-ec
+
+  reg:
+    const: 0x76
+
+  interrupts:
+    maxItems: 1
+
+  acer,fn-selects-media-keys:
+    description: Configure the keyboard layout to invert the Fn key.
+      By default the function row of the keyboard inputs media keys
+      (i.e Vol-Up) when Fn is not pressed. With this option set, pressing
+      the key without Fn would input function keys (i.e. F11). The
+      firmware may choose to add this property when user selects the fn
+      mode in the firmware setup utility.
+    type: boolean
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@76 {
+            compatible = "acer,aspire1-ec";
+            reg = <0x76>;
+
+            interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+            connector {
+                compatible = "usb-c-connector";
+
+                port {
+                    ec_dp_in: endpoint {
+                        remote-endpoint = <&mdss_dp_out>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.43.0


