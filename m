Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B82755766
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGPV0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGPV0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:26:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A51B4;
        Sun, 16 Jul 2023 14:26:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso537517166b.0;
        Sun, 16 Jul 2023 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689542808; x=1692134808;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APPv+d1DbloXHDIvVEbhOHUKmDx0jHjjotRFz0ftnQY=;
        b=XF+45GoL101Ld7PMOX8zpN40ZWzz9qJLepdGA13JUYlloLlV+CSsLycyPYiK6sIE77
         GQYyG2F6OcaVbu54BOW9INXbRoJw0GLa1cGHYULVW9G545lxKk0wUhacZ+6As0akODFT
         xL30c5kFdDXVjPE08rwaNUc+XbLkfr6luv1ARdgnrh9i1AvjtkY3QLssTaD+OWx3EKHZ
         5jumAMVyrNG/jOKRVrzhoZ5RQc1hqS7MRTqOINpqhvMrq8bQFw/TXnsHqqhWdQh4oogD
         ynAjVrHKs3hTdj4a8+GlaQni8q14NSwlqMrYmnODRXGAWtteY62KzuCAM6QOld/c/RAT
         3JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542808; x=1692134808;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APPv+d1DbloXHDIvVEbhOHUKmDx0jHjjotRFz0ftnQY=;
        b=l+h51NIixNs8BWQ7/UV+JahNcAsKDurKWZ8VivWw0vu6jnhhqONh0N1PaOQycf3Cke
         4w0+6kQqJuzAosIbScX3gFOI9uvkaDKOK8GYdzcs4h9zRBRDdW+6bKAMGejl6WVCitng
         Qd0hcLc2+APyeXFslymrMYGCI00pJxxhqVxMwrPR/AnHPYPiBT82s2nEPfT6K5+DZbr4
         5/VAvJSPPP66VP/ZTQFY7jWTsu4YCmEeljwGI5besTOIUQGGs+GEGvGDh/CaxoM5otaH
         BqQAWlsGo3CNTFMhfROUXAlvnPloepPERkCi4Fpr0AhikMGFXNb4tWlyExFuAX0mr8lc
         KCHA==
X-Gm-Message-State: ABy/qLa4crL5tdJ8FloF4FBZlUHcVaMwdtrOvdIh/PxX2QnZHiV2aZ2B
        bI/E91lX+7hhrFlwOdljYUQ=
X-Google-Smtp-Source: APBJJlGfUMuHKwCNl994BCNhsCzI/LkN6v/CfxapWsxfFxw6hV+MZCNo5vtulFSGz9o9eL18mGwFig==
X-Received: by 2002:a17:907:3e1b:b0:98e:7a7:60b0 with SMTP id hp27-20020a1709073e1b00b0098e07a760b0mr12280335ejc.65.1689542807718;
        Sun, 16 Jul 2023 14:26:47 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906271900b009786c8249d6sm8473610ejc.175.2023.07.16.14.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 14:26:47 -0700 (PDT)
Message-ID: <a7d5154b-baca-5cef-586e-a1fc211d7202@gmail.com>
Date:   Sun, 16 Jul 2023 23:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrea Collamati <andrea.collamati@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: add mcp4728.yaml
References: <cover.1689541455.git.andrea.collamati@gmail.com>
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrea.collamati@gmail.com" <andrea.collamati@gmail.com>
In-Reply-To: <cover.1689541455.git.andrea.collamati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for mcp4728

Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp4728.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
new file mode 100644
index 000000000000..c971d34794db
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip mcp4728 DAC
+
+maintainers:
+  - Andrea Collamati <andrea.collamati@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4728
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Provides both power and acts as the reference supply on the mcp4728
+      when Internal Vref is not selected.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mcp4728@60 {
+            compatible = "microchip,mcp4728";
+            reg = <0x60>;
+            vdd-supply = <&vdac_vdd>;
+        };
+    };
-- 
2.34.1


