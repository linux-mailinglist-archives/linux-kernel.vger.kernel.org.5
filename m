Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874FB79BC67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354935AbjIKVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjIKJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:03:35 -0400
Received: from out-211.mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698FCCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:03:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694423008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+17NGCWlO9ZPfr0by0avVLIVRjlYOBsfODw41O82xI=;
        b=e5n3NPR+qdfHu6HoJXg9ALnUGk/dkhRjS3SpTdMdr6uxm5Y1XcSCWd/hmyOImWSUMARX2f
        Oq82kTOx1z1Jd3del9L9FhEjogil25q2AAPIj4dDhiE+ylp4isUIvB9Q/AbGYhFNbjmHaK
        gVnfl/WRegKz2vkehk7hcHUEgnQB58Hk9Fx3nFkaIuM8YZmuP03W39wu91bhGYtEZuI1dT
        QJ7UqyXWysIex5J6RXL8X3vUkQwNaHuu9/QNhVkSu/MD5FzJxJ0vQ3/Au/9sZO1EgvbTd9
        7TV+44e3oaCoJjUH24oI9OuSRn6PXOWxe4uDhCLIX3HNOFwcOfJ+pp7zEgMuLA==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek FS035VG158 panel
Date:   Mon, 11 Sep 2023 19:02:06 +1000
Message-ID: <20230911090206.3121440-9-contact@jookia.org>
In-Reply-To: <20230911090206.3121440-1-contact@jookia.org>
References: <20230911090206.3121440-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small 3.5" 640x480 IPS LCD panel.

Signed-off-by: John Watts <contact@jookia.org>
---
 .../display/panel/fascontek,fs035vg158.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml b/Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml
new file mode 100644
index 000000000000..00d43ef8a33d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/fascontek,fs035vg158.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fascontek FS035VG158 3.5" (640x480 pixels) 24-bit IPS LCD panel
+
+maintainers:
+  - John Watts <contact@jookia.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: fascontek,fs035vg158
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+  spi-3wire: true
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "fascontek,fs035vg158";
+            reg = <0>;
+
+            spi-3wire;
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.42.0

