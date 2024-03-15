Return-Path: <linux-kernel+bounces-104466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032B87CE57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101B9B213D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCE376FD;
	Fri, 15 Mar 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="xxy8kxYf"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016F2E418;
	Fri, 15 Mar 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510718; cv=none; b=Y8rrhplqIv6VbVJ/BF9k3MVJgKUh6RMhK8pOkr1PweAmexF0DIhm3jlwNC8ci38CF8mUO604E2ckz8838OqlH0tgzUPbpz5LbZBZdBHo2ljRRyMjxvmiPW3ypoc+EJx36W2YLIaER+0MA0rrwktCw7OR05kISk904xrdpoLpOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510718; c=relaxed/simple;
	bh=MMLcHJokdcrZX5tapxsxk9MOEOCy6mrRPWqgEtSNWMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/QJltDIDD625Mt5kYTdAYaxe39QpTSvexx0BfNVKUxZfdOH4jTNfxhoK8Cef+GciGXmwkm0pZhjaSWxE3dghy5lYxXjAgx+y+vuSdl72nrp12Z3vTx7GwR5qxvJY3fxAKc8BPEe95GahyadGv4qQEytNpYYaxLhKSrM4DITBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=xxy8kxYf; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 1DE5641EF0;
	Fri, 15 Mar 2024 18:51:36 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710510696; bh=MMLcHJokdcrZX5tapxsxk9MOEOCy6mrRPWqgEtSNWMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xxy8kxYfOlFEgkH3P8TxNY3RDMXTysILsaQWb+Aet//GgUcok+/VK8cAgTOLGjjt4
	 LxJBG8YqYi3s7u4QX98/WK0PorCNMFLQ5AV9EMs7Wxgyy60BSoClu223p02B3uS8F1
	 /6vxH89PubvjWOZ799UXq2kI0TjX7xa5mCYiFmcptr5MSjTsdMMPRloNc+tgRP43t5
	 8mYm5RnGokca/SPDxg40JyQREgs6DWQBVfJz68lkiPB6i2Um4Cj1GKS90YlyxbN/Pb
	 V0+QlliAgqqnIvX4AeqAFTQTUb2sRQpw8qyR0l2kAf39GZJF3v7Vq989lnwCzF5alj
	 GQJS73soSJBDQ==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 15 Mar 2024 18:51:15 +0500
Subject: [PATCH v5 1/4] dt-bindings: platform: Add Acer Aspire 1 EC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-aspire1-ec-v5-1-f93381deff39@trvn.ru>
References: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
In-Reply-To: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=MMLcHJokdcrZX5tapxsxk9MOEOCy6mrRPWqgEtSNWMA=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl9FJl1s0w28vFfb5wmB5kcBEPkAABTgUxBJiuu
 ReEcYhF0OCJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfRSZQAKCRBDHOzuKBm/
 dbCuD/4gBu5TlOhWt45gMihtRlgK1dbDires315S9k7yIeRikQwTXjp0u/AVTyeJXPJiGLJcJbs
 B+Yc9n1OfInJ3gqs0j0NW7G5n+1ucEZ1tOyCP+FsXiCIuCbM78RNjJcmi/GBfzstpEIM6RXsLN+
 eFRk2NKafGEV9dh4fykIl6TWMuanl4yup/R+/vJtxNhJd38witTzAi7AH9S9FKENB5hZFR4r5eD
 Rb4BC6XYJAktomTRbdFdFVsVefRJ23+CubU3NjvfvIrSkXYdYWkpEUsEPlzquevdAr+GT1nsoTV
 GHoIbSNgpOMMMLb6icCLRJCEYfIIjMtiySRvkmwF9nhiLAhAxUWPiZcyKs17sonzzasUfX4b4Gk
 Yfbx4TUsiaAO+kWvmavGHGaeBOVEfGRhWBhUk80lVENq+3fa0/fEhRDNGrQ+MmmoEaZ0EPLl3yL
 wVkdztzKqFtJlkfHPk5ssszse+822i9svd/kwxwrmtcxBZ557tx9RegiYEfgKEjpQTdXy4pGLE5
 ae7/oKrW3ecbJwMhcnQjyEb8Uf+U/Rhk+Ugd63soN5tSGINYPruj639ayxKRhkAlXnz2+QSyfNq
 KN5shnDr0v0v79hPtqsaLhW9yvnOsiVQXiuDKwKilZg2lYJwMg+jA/E61FEpjddLL4TrGyRXAOQ
 gu0K+XPHOcje+rg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Add binding for the EC found in the Acer Aspire 1 laptop.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/platform/acer,aspire1-ec.yaml         | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
new file mode 100644
index 000000000000..7cb0134134ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/platform/acer,aspire1-ec.yaml#
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
+  - |
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
2.44.0


