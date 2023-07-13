Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363C751CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjGMJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjGMJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:07:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC31FDB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:07:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992acf67388so70559066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689239257; x=1691831257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ye7/VW9cCinL56beHP9cBXIlGvn2H6A5gltzFR9xZA=;
        b=fWiwwbxu2tZ/kId5fwzzZGDAKUkBpJD54BFOz4Y5FvfS7va+VQho01ZEaCog9vYDLO
         iMExqgohH4XqmqSSMtaoH4fwFgyz6PCIK21FYGs/IM2r4NKawCy+rcNp0UQsIYeNjTci
         5rSEReuA5FVjX8Q0ArJlSnRnFM7vtX8Ui4INJMP/ntQ4znxTd5xbgSv84cvou2UgBHL+
         tHAlJQ3dcl1E1LqxuWp61YlNabpg7PN3LE+5ZGD6XrE5PwrO2bK2t27NGUZScesXXa58
         KqmhsoFlaSAswcWnHT0MZzQRsJvRgkH8HvMEXahTfCCcwGdqR1EJ2usjoWucarcUNwC7
         F3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239257; x=1691831257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ye7/VW9cCinL56beHP9cBXIlGvn2H6A5gltzFR9xZA=;
        b=gNA15MPU89bpnCx/5k1HGMq75y6La1AoKDX9uXMHoyk2+5wEBzG8j7pFkT7MSKyTJG
         lWeI6f59swzxzJkvhLpy6il3ahVnEGPoKFq5gF67Y+9imVru2vDvAYmdw6RhpCjuPNFm
         M4a2Td4ggCEmBz7SXje7So4kvt7D4Dm0PENUmoMMcHjTfZ44gZhr5UEqBeKr8Y0swZtf
         WosxcQ51mcGA3T5Op7UhTfMlkGpmmKlNCjOfmwgZudda4lGVPSjmVL8+pDn0qJ2hr0fI
         k9g78OQtHT6Ogq26no0siog6I3t0yvXpB1o4eiSJqYvXVQqao8a7WKvX1Pzdh37CYcRp
         MLng==
X-Gm-Message-State: ABy/qLZGEwGIs1vzJ6aQwkA18rnJveYvlhPul951VfHtSFHXe5We+jWZ
        zV9ktSePB/EYev3ABLHrBkSJtA==
X-Google-Smtp-Source: APBJJlE4RWnu8UySeR+I/AnNMVTMcejh9JKrDElN0JzKyETRe5T2FP4ozbQk5XNxWaEvbyhRscqEPg==
X-Received: by 2002:a17:906:30d3:b0:982:82aa:86b1 with SMTP id b19-20020a17090630d300b0098282aa86b1mr726658ejb.43.1689239257081;
        Thu, 13 Jul 2023 02:07:37 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id p18-20020a1709060dd200b00982d0563b11sm3707352eji.197.2023.07.13.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:07:36 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 13 Jul 2023 11:07:33 +0200
Subject: [PATCH v2 1/3] dt-bindings: display: panel: add startek
 kd070fhfid015 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v2-1-87bc7bdec6e9@baylibre.com>
References: <20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com>
In-Reply-To: <20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=602in0caqHCjA6zQgFgfTHmUoHJFTSnnwXSt1PAlxS0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkr77WZ01MReGvODiP68t92SzPhhTQdaCvcjNlnSPb
 u3M9RI2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZK++1gAKCRArRkmdfjHURQ9hD/
 4+x3Yzdw7Yq66K/FsTF6eEF9ZVve4NbbN8bp6Moh35esqNZ6T6tErXTZHif+nIn16rzDxqdHfGoP9L
 m2vEMUKQMaKfoIxqKmG345Se92JawH/Rj0KJkaBXUs+p0xR4Z5tEhiHpx5DRLRKCmvA8yF7aHRPFVy
 CocZcVs044MRcJ9UQMTLDWKOAvrwPfkyQOO+3UaPMRG3MNpet1nXbDw/UsMQ9EAgztelmxKb626fmE
 7/4dOBXhpmNH0Nty3gM1jxDX+Huy0B5NOC110kQGBr3cUdKlz0DLc022Fc1rkcyoyEDBmvFY28O3dM
 78go+FAwdBH9Qkd95fVXzDEU89z7KRgF6UZmZs2FVF1exFJtcUPDdKXisBCCSms6I53BF9Y55F+R28
 plyBnZmBsv4TgNNgfSr8rx1xIpFaLKN5HBfVMwGnikvRkzX2PWrArPaaR0SCP+CltrZDy76cXdaqzF
 CPIkJjICGJPOwKHHxrrGb7Ew8k0CJaw85WtWvpw8FevYymR1/sAE8c/fV14kUB32we3tkOA2RSxZxD
 sXUxleJMcEMgA1eTEEI+AUg6CupqpU9RFjx3PnVN8OiRXvwDy2qRHRmEWQh+cDOsaFLYnD2Jf0oeVw
 RS53/G607awTAhSQSx11xeR8JVRG4Vbw/sb8i7CSTQVqVi7JnKz8CQF4Hjgw==
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

