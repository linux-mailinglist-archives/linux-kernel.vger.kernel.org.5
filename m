Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF575E2A5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGWO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:28:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93039E72
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:28:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso579088a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690122526; x=1690727326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnglWu01tYHwRNOL8HHkMLLSEFA+kFYQg1Vd2bg+vtE=;
        b=aZyOQUBhQS9KKId8c3bvqlgtAedmrTKIlVb/EH9qY+3z0bgiUmcf68YDmSpMcc4X12
         ST23elE9DSDswNdPV+JFJYrZF37CLpEGL5sbMxZMLpdiCzr6coKIWe/42ZnK6Axmh4nl
         wIVEDpfSsGvj+Gc/0HAqTH/E1fVHQbRUpWPEil+mkFfsHF1ZOxcz98g7mZ/eB4bGDc89
         m2R03kuptIzHduRdEwp9x8dpyLyk+hU3L5OirGMl+tpb56MGFUfriqepvOdfk0UVUjQX
         XOSNk0hlU1skQT+uR78DcMSImG0+8y6M5Fmb2qE/PvI2iqwMiapLCfZM/H9WnVNohuVu
         ukHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690122526; x=1690727326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnglWu01tYHwRNOL8HHkMLLSEFA+kFYQg1Vd2bg+vtE=;
        b=Zu3+tAfu5Kpq2j+gYwCr3nCtd+4uxNvwk3a8uXkNoI/y0yxN9KoZfpeARyv2Ij8zr6
         nhEdUQqyAWgKNNL8Gw/p+Jl6ycxiVBAZf3jI42zY563AD2t2/d2cfELkfstF9+kE1Vsy
         ZAh7uFDpq8HbztxIT0hzeB3lmNbBgU/dwUG+nJFWtL+niyTwDXFZCSnWHQmjEDsAB7oc
         hSdq6Sjec56bEkYaiNRqITD8fXDzQDIQKH0ZeNgZsjSweUyYYh3MnLP/eoacGDuVPbxj
         m8Y6IeRuxInY6Xy2eLwtGojn2dfFFhHubANNvR/fh8BhpHtK8liJM474OS0sWCNI+Qqf
         PM6w==
X-Gm-Message-State: ABy/qLa+W7jfOC/BXyW1KmyzuryNIl6dcMi3P5IyABZEXiNCgeVGgVZV
        cY7ZwuIc203SgclY4k/qZgHttw==
X-Google-Smtp-Source: APBJJlGsft6GzVcOYUHlpDWS1vZO9h6TJLjor6mTF5Oc9u0bIh6YbPzh+jOOPYkhtRgpob9cGavFfw==
X-Received: by 2002:a17:906:5a4e:b0:982:30e3:ddcb with SMTP id my14-20020a1709065a4e00b0098230e3ddcbmr7560414ejc.65.1690122526109;
        Sun, 23 Jul 2023 07:28:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906375b00b00988f168811bsm5260805ejc.135.2023.07.23.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:28:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mfd: maxim,max77693: Add USB connector
Date:   Sun, 23 Jul 2023 16:28:42 +0200
Message-Id: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add micro-USB connector under "muic" node to properly represent the
hardware.  Deprecate also the old "max77693-muic" in favor of generic
"muic" (this is max77693, so there is no need to state it in its child
nodes).  This "muic" node is used only to instantiate MUIC driver by
compatible, thus actual Linux driver changes are needed.  Extend the
example with this new code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Put connector node in the muic node (Henrik).
2. Rename max77693-muic -> muic.
3. Extend example.

DTS change using this:
https://lore.kernel.org/linux-samsung-soc/20230723142417.97734-1-krzysztof.kozlowski@linaro.org/T/#u
---
 .../bindings/mfd/maxim,max77693.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
index 1b06a77ec798..6a6f222b868f 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
@@ -37,6 +37,7 @@ properties:
   max77693-muic:
     type: object
     additionalProperties: false
+    deprecated: true
 
     properties:
       compatible:
@@ -45,6 +46,21 @@ properties:
     required:
       - compatible
 
+  muic:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: maxim,max77693-muic
+
+      connector:
+        $ref: /schemas/connector/usb-connector.yaml#
+        unevaluatedProperties: false
+
+    required:
+      - compatible
+
   motor-driver:
     type: object
     additionalProperties: false
@@ -107,6 +123,38 @@ examples:
                 };
             };
 
+            muic {
+                compatible = "maxim,max77693-muic";
+
+                connector {
+                    compatible = "samsung,usb-connector-11pin",
+                                 "usb-b-connector";
+                    label = "micro-USB";
+                    type = "micro";
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                            reg = <0>;
+
+                            muic_to_usb: endpoint {
+                                remote-endpoint = <&usb_to_muic>;
+                            };
+                        };
+
+                        port@3 {
+                            reg = <3>;
+
+                            muic_to_mhl: endpoint {
+                                remote-endpoint = <&mhl_to_muic>;
+                            };
+                        };
+                    };
+                };
+            };
+
             motor-driver {
                 compatible = "maxim,max77693-haptic";
                 haptic-supply = <&ldo26_reg>;
-- 
2.34.1

