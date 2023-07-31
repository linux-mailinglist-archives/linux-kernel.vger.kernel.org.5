Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3F76998D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGaOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGaOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:31:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54411C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:31:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3177163aa97so4843429f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690813914; x=1691418714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ye7/VW9cCinL56beHP9cBXIlGvn2H6A5gltzFR9xZA=;
        b=igQzoWr1vYjzOo46/BtQNE9CysTmQlLyhA+/wst+Od/HFtUmVc0mepBRDzGu13F8e5
         2wxL+oPNEspqPtR6ZgY2c+3TxCWIyCYw88iEKJHUq7zma8cLlZfyZvRwA5VhCelcWUpR
         BXxGB4DqWIjhQNA7PYZh17iAd387hEXRX7q1nInTgHUdlS2D3SmvhPvGEAoT6mTF/K5O
         5f/QXcLp4E3KmjdoF8ApC7VR5lQp2VXbVFaqW5dVwzhtqLrpqiTazilca5Nbt/x2lB2Q
         oRKh1wVwtf1ohzgPHYm8M8+SeAqcFMekDfMvAs022PeDR9OMtAKUMG0NoEOD1sfT7Q6T
         AdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813914; x=1691418714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ye7/VW9cCinL56beHP9cBXIlGvn2H6A5gltzFR9xZA=;
        b=MXw7dJBPkdFJ5hDaDFYJa8Hv2FoAmE4YXiYkxOW9UuuZvxN/iPl4sB7uiwF6ecHmtD
         f0aiCX3ClNU3PAGarcPruYyj2yCzyxexRRwNYr9cK+9AiZckmzdZxN7bHmM5MANf7nlc
         vDGHxv2bFa15K/rwChl9d2qsqc732GqjF9OiR/SfW4hmCdMwsoefTZbPlrUhANsQ8ZW/
         oX94vyEHaD9iiTspU8a77/Opz53ejifmo7vtpmEHD5O20ju1vG9A/vncI2k26SPuKbAu
         rwg5SZtPsNfrAzItWjeAeCDUgm8yCgsJgSfUvPBaaTSUNvoYDUugSqDXgWXEB/XzALyx
         dVIQ==
X-Gm-Message-State: ABy/qLb5+NAUBBY3eAx8HTvJawuFqCjkkn7DglP35PyRpsm6rZyL6OVF
        6dFHtZCiPMDoizMutpUjgLLScQ==
X-Google-Smtp-Source: APBJJlG6QJgGCbwJCPNmuvbi4+G/7ZFPi+htK//Xdcz865dxC4Te6P8Ta3huIlfE8MlCZ5g+O00GdQ==
X-Received: by 2002:adf:ec05:0:b0:313:ded8:f346 with SMTP id x5-20020adfec05000000b00313ded8f346mr10488wrn.22.1690813914111;
        Mon, 31 Jul 2023 07:31:54 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i8-20020adfefc8000000b0030ada01ca78sm13301675wrp.10.2023.07.31.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:31:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 31 Jul 2023 16:31:45 +0200
Subject: [PATCH v3 1/3] dt-bindings: display: panel: add startek
 kd070fhfid015 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v3-1-dc847e6b359b@baylibre.com>
References: <20230711-startek_display-v3-0-dc847e6b359b@baylibre.com>
In-Reply-To: <20230711-startek_display-v3-0-dc847e6b359b@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=602in0caqHCjA6zQgFgfTHmUoHJFTSnnwXSt1PAlxS0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkx8XXBqSOiQ0tkYiNDhu8PeKrtLIX65043CaAnJZj
 VN49SnWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMfF1wAKCRArRkmdfjHURUuNEA
 C1gf11Elqe8ZepmWNfS9E98JTgyvI1jalaJ5lcSb2p2XdHS0Jn2/dZnnt4pe6zuL0R/9hYDjXcph3l
 AFwoQ+klfWI3cW5+cAuU2uGuUiibDieL6C0AswvKlda4YAZbu1cetpdj8IDpC3DmiQKwzZsFFIKY8d
 NZ2BychTi9BgN7WJ9oNcCghPQuwjX7ifPLWPry1lcyJVMlQJPbLuc0/KQyg6JloCFjD7x2fNt9QM8e
 KXLTGNDiqScKrtnjpbdie5JEMXUhSoz3Dy+LYvWGZlol3IWWmSV5bmTb5N8Mly4Ygxt3UzuWA4QT0m
 tSVAkrqhkMWcbQCvIElFwVbSAVakDt3pqTANb0BChDEv7200nKesg8teq7dPcvs+bTYJo4TKA9GxMY
 D5vK3VuUtzJrsa5+fOCmYwk9rpXnoD4r3xeh04yrIvqh4i0MUaaq+6xYtgXVqUZsJzYizZP/97scOf
 P3OuxUUjKP86hyPXW5RsBphs8zUfQ8EE+1SMbPZ0ylufkM0aeYWWu1jRorRHwdLM1IMUR+jFDQC45R
 aKt+nhkEMmwWzY9tKpjI0gV55NEzhVpVB77W4E9YJfmRkRXp3Cj9AOQuRuQIwGnhXsicnXgqBmk0iJ
 FBUOGMqAMeilL53CbvnOUnGnYa33dP/RgvrjT3GWKasSdgxarEygRvlAjQNA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Startek KD070FHFID015 is a 7-inch TFT LCD display with a resolution
of 1024 x 600 pixels.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../display/panel/startek,kd070fhfid015.yaml       | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
new file mode 100644
index 000000000000..d817f998cddc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/startek,kd070fhfid015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Startek Electronic Technology Co. kd070fhfid015 7 inch TFT LCD panel
+
+maintainers:
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: startek,kd070fhfid015
+
+  enable-gpios: true
+
+  iovcc-supply:
+    description: Reference to the regulator powering the panel IO pins.
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  reset-gpios: true
+
+  port: true
+
+  power-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - enable-gpios
+  - iovcc-supply
+  - reg
+  - reset-gpios
+  - port
+  - power-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "startek,kd070fhfid015";
+            reg = <0>;
+            enable-gpios = <&pio 67 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&pio 20 GPIO_ACTIVE_HIGH>;
+            iovcc-supply = <&mt6357_vsim1_reg>;
+            power-supply = <&vsys_lcm_reg>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.25.1

