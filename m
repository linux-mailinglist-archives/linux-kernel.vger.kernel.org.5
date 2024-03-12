Return-Path: <linux-kernel+bounces-99974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53881879017
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FD91C215F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7078270;
	Tue, 12 Mar 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="40LnakXX"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0E77A1B;
	Tue, 12 Mar 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233550; cv=none; b=u7canY37E0YuflEmGnkaWlZuDTgMlRbt0GJPnQUCWQLWCtXGERTQ44Wf4QIa/STh9ZUL6ob5m+knbNzJETs34hDqOax70Ongo4F8xRoIHjt0Nql+UfYG8CPXayhZYhmDFcTtHLy1oZVCfFV9dGkyoEJuUL5xHLfV5zyAHQWndRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233550; c=relaxed/simple;
	bh=AZYs9NLUJZIQH3UzO42Sl9JFaMkrrGJmqRQLPCW7vw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCwKmGSgB+09EjTGOvqMjJhF7L1tW50/SHceMqqa9BIltVHrnclYsBs6Hdwhr0Psv9cIeMYZkUrlcFissQhRPATrwjhb4WLL/a4WI2WT7QuFE1ie9UukQFVxtOLYH4hxJA4FZXv1yQiRp8kE4bv76i1tPy8wlSEZ277T2w95S+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=40LnakXX; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 462E740560;
	Tue, 12 Mar 2024 13:42:21 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710232941; bh=AZYs9NLUJZIQH3UzO42Sl9JFaMkrrGJmqRQLPCW7vw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=40LnakXX+9y8VLa9ColyPM6UBcm9iT45G6YLeZ7h8Qn4zOIjnmi9fcymH2r0jhSei
	 8p9NfJShxZyenOzzy+eaoLUrvPTJPTFozDAdpyWSAglWhXDz04cFGaJ4pGI74uyT9N
	 ZpJEw+IzPPYOiwYhUK6iRdw5xGF1mNWVcawac3YN2pKcQYNUV3h6HQtue/RFkz/wjZ
	 ukWTGVx04GmTuun1yQWDFYTx9hwFCkNxEjfri1mYgLHnMVU8u8hISPef2NAfzMLwzT
	 5dEHgRVXXHsrXE6qEEFW6RGYJVRW4nTK3CfA83Osb3zUDR3+pRYAEdARzT0O52AfaX
	 frXxgZUmrMfiQ==
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 12 Mar 2024 13:42:07 +0500
Subject: [PATCH v4 1/4] dt-bindings: platform: Add Acer Aspire 1 EC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-aspire1-ec-v4-1-bd8e3eea212f@trvn.ru>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
In-Reply-To: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=AZYs9NLUJZIQH3UzO42Sl9JFaMkrrGJmqRQLPCW7vw4=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl8BVqxkbYmjOOfKSPFPtSSvdwMT9L9XYasL75H
 7xHmUQPmLKJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfAVagAKCRBDHOzuKBm/
 dWWRD/9T4DJcRb8RwNH6d24DRC+kpGO4aBwP/mEVrXmH2Y5//O0nJC7GlZdr2IA4bLyCH9hcwD7
 aNCJEuLmbsrQQY7y6rifwLx+sLUZXmOvfm0IzH6Wb12rzk5YZ2M+XWMiSTmWMfVQHNF+6vuAj7B
 4VuF8GN2UEj/xsgIIY+F5IazvPtCGe4a5cOIcoxN1FbpGU/c1EsWAIBQIHRwTv/qNYyLqqBM0tD
 i3xJTIIG6j8xEW6PHAYpkBbFEDTrl03ItP5p7UngzVQC9Utpjv6ivQrTYRLDN//27+aHjHvbvMA
 Ir0HTA2EQVzEFOPEvNPVh5xt+mYRfct03LmD5H1c0lbHsu7cQs0NzdOBT0FJlNzxMG+RoUfvMlb
 qy8nfT1qpOfcZv6XHe/Ks5vONXjzWr6jFVnl2/KQRcgvD12cxSoHSVm0S5xzrXvpXL0eeYKzAH+
 oDVwJNTaKMr7zMMUMu4QPdIPZ1KFCVh3OozBC9r4Wu4yzNivuEhL5RdbmWqKmx5Ip1ddj2THWCB
 DSwShm8jeU72UK3tU8rQ5L9unJvkl3WvgShuQYQx92YmxNmO3y6OTpM+wqFCSG8Tqsax6Ho2pMu
 9lJxBaKhqAFmiTY0EG9X33AkWrIYuGjIlhiPcMhUFU5yTnO8jNoIF3NAuKkD8z1odZ+o2s96DlY
 7qxIzMflVPoyOjg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Add binding for the EC found in the Acer Aspire 1 laptop.

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
2.43.2


