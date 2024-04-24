Return-Path: <linux-kernel+bounces-157192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F48B0E58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C341F2305B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48B168B02;
	Wed, 24 Apr 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APDXodnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB415FA68;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972570; cv=none; b=gFSzsfeqKXP7BPyXPnIcBjxKSOTOg/Uo3nhkch9lRmOh9ZX+WgAWAQWNtRfVD9TQ74Qw2/I27XhhDj333Jf8QWWre16KKIiX9D0UUkLFRsieN/b7Jt8IJWHyS+5OoA1Q+CUEOZf7dG/4gPa8JL87HT6nqRc+pV8w/kox+Hb5YmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972570; c=relaxed/simple;
	bh=cbHOmS0lgBg4knwMev0Ajy7JVpTSAYRj97U/f4kgL3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+VnXPWkRrW0ugfRBzvXxRnvF9M1RsLMc9tc6s/8OOR9UQD4Rajs84b3k3x8ugxTNJyUbV7eWApQuUIcj8jEhuUk12pkpbDKhtyvz1KP/3hfmN5miN9vz9sc5rzCi2etarjDwx4Pow4YxIgpZiDrNl5vZjrL9lBdppaLIEqAIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APDXodnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D2E5C4AF08;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972570;
	bh=cbHOmS0lgBg4knwMev0Ajy7JVpTSAYRj97U/f4kgL3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=APDXodnpRzqcY/HNmhM7Lyr4vX5vlpQk54oY6e2LZW3UYjUMBJ6muMZamlhC4X3P1
	 j2tS8TFZzWqESdZL9mhb1fMMsmb2tG7UuDuUAE6GLRrceBetu4BhR4jY2JTRZ4I3t8
	 oaezMzVOfQYIRp80Sjfw0WrGQw10+N1IpbpnghJo9Uq8LTQsG2a4SlPu+FnKbnjX+t
	 584aC2wi94dpFpc8h2JzTLJfIjQhYGUNEiiJHCmosatQ9KvS9fZ4WMlA3ZAPFm5Un0
	 EA4DyT1MSdjzjgjCbLOgtmyZ98eDXycLjbgxJcJ9qZzDTialDl5eaBnKg6i5YrSz8D
	 Vsuk6jiwzRzOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B709C10F15;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
From: Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date: Wed, 24 Apr 2024 23:29:08 +0800
Subject: [PATCH 03/10] dt-bindings: display: panel: Add Synaptics TD4328
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ayn-odin2-initial-v1-3-e0aa05c991fd@gmail.com>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
In-Reply-To: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Molly Sophia <mollysophia379@gmail.com>, Junhao Xie <bigfoot@classfun.cn>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713972563; l=2025;
 i=wuxilin123@gmail.com; s=20240424; h=from:subject:message-id;
 bh=0VK+Kj9m0jq5c+1jyByVu388zTnbuAfKwi30ATqYDLI=;
 b=AweMBhEqEuTCc4enzY9h7GdeI8XUuiwF9MDWxLyD+4cgpmTUAoig7/9l8o0WgxW1VxR4gHORU
 cYNQ8NATvgzA6BG+EfLmVbx9tD6Qq3ybWio/Y940cWK+I6rFS9he+gk
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20240424 with
 auth_id=157
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: wuxilin123@gmail.com

From: Xilin Wu <wuxilin123@gmail.com>

Synaptics TD4328 is a display driver IC used to drive LCD DSI panels.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 .../bindings/display/panel/synaptics,td4328.yaml   | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml
new file mode 100644
index 000000000000..216f2fb22b88
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/synaptics,td4328.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics TD4328-based DSI display panels
+
+maintainers:
+  - Xilin Wu <wuxilin123@gmail.com>
+
+description:
+  The Synaptics TD4328 is a generic DSI Panel IC used to control
+  LCD panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: syna,td4328
+
+  vdd-supply:
+    description: Digital voltage rail
+
+  vddio-supply:
+    description: Digital I/O voltage rail
+
+  reg: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - vddio-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "syna,td4328";
+            reg = <0>;
+
+            backlight = <&backlight>;
+            reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+            vdd-supply = <&vdd_lcm_2p8>;
+            vddio-supply = <&vreg_l12b_1p8>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.44.0



