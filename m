Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4F7DB432
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjJ3HZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJ3HZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:25:19 -0400
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF68FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:25:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1698650709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhEQ1dqgKvz3w9QUVhZNxp0xbOiz8esdacL61UcOl+o=;
        b=YUTRiIDO6c4V47NTDewFxsIKZNafI3YGUUBiwbJzBLE00aC+Q2CABGQN9scYF9ig2XerDs
        /yX90oyP2rdtnu7Z25m6w+kiboDt3jhV8o6QFugs2rkFktszKNte13tyGVlHbqNJyAdJ0n
        jIfK4FcckJuDe22wj74xHJ7XAQZ4pJpHbseh4hD9TGPeGm/PbTUuv0RMlaiFqi9VZXok7q
        D2Z9kRpKfVrDUqyK/3mOocJIPlPclW6i3ijo6ODOYyivYhhUFOcnOdotZ9KYMpQb89Snn0
        5RP1WkFqwfyzKa90oKMIzklDkFoZ8m2Hi5Z8CzJpNDJ5tIUsyl31/tSWi1bcOg==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        John Watts <contact@jookia.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [RFC PATCH v4 7/7] dt-bindings: display: panel: add Fascontek FS035VG158 panel
Date:   Mon, 30 Oct 2023 18:23:38 +1100
Message-ID: <20231030072337.2341539-9-contact@jookia.org>
In-Reply-To: <20231030072337.2341539-2-contact@jookia.org>
References: <20231030072337.2341539-2-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small 3.5" 640x480 IPS LCD panel.

Signed-off-by: John Watts <contact@jookia.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/fascontek,fs035vg158.yaml   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml b/Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml
new file mode 100644
index 000000000000..d13c4bd26de4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml
@@ -0,0 +1,56 @@
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
+  spi-3wire: true
+
+required:
+  - compatible
+  - reg
+  - port
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

