Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5541C7F8A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjKYL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjKYL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:56:57 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689B10E2;
        Sat, 25 Nov 2023 03:57:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50baa3e5c00so407679e87.1;
        Sat, 25 Nov 2023 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700913421; x=1701518221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1Ag/lZU/J4RpOQ38mivV2pu7u0AqFf+zI3E7pbs5ts=;
        b=c9rz3NI56yY9QpiA53qHopCAhUvMRWhAroLKDzArbe/BICgIwMcZxIVW91whZn+6fs
         CBbbgFGBsmTg7rKojo3Qgmn/hdemGwLhfOKaeUZEF2tLDKJIzlxvBYITBwa5ogVwzjlc
         +22HtUs6gK78EZ0cmqS8iKYNpZ2Sw7Jn8OOCiz3CFaCr3mVFbkh7B4HHkn1/XZ2E90d6
         CSgnz5aOZ9MNoNoe5jgLEsJpVyAePHaDBlPzpACceNuNtH1p4SAZjViseT/lU6fRu+wq
         ueF5oGF9gwAstEWOgqtGYyAMkq/K9C9HFmIUzQ3zFcJz3r5EfnQCocuAR8FQIBohsoso
         sO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700913421; x=1701518221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1Ag/lZU/J4RpOQ38mivV2pu7u0AqFf+zI3E7pbs5ts=;
        b=OWbwTJK8eA1CfsslKuTFj5hAWTNsKraeAezyvvKWEYx+qmAhXZu9RE621QrSPc22U3
         /wI1/dEbAJ/6w//JDou9XDJHoG2KLVAVtvhwHIjExbZFJGrKKs2fDE7eGfjrJzYJyVJG
         zeBtCzY4eCDgclut813PaqWRQLjGXhciH1OBVYPDdPa8TPLrIl16NjT4pjLbLD3FFiB0
         SwOMPQI0/bwAwOq2xDOx+1drI9GlmodTMe6D1Rf5if+IULoL3rEa+xupTbqTJDlEWA9M
         gAS5W86pljHTsRsCaEtO57Rioe4DRKKB3sObRAzD6TWviSEJy4EVz2RJnlpZwJ97dwY0
         um6w==
X-Gm-Message-State: AOJu0YzURF0n9EDRy7mzsgOuZiNZ+StxbbfabooXLB7qKp0bRIdK6EYO
        Q0vIQKxXP/C73PCGR0jYlazSIN6XCqIhAA==
X-Google-Smtp-Source: AGHT+IG/SgKXwFB8uSPdzpltKz+Nn/DmIiHuLIyj2TyfIKqFnQIZgk4uKDlsua89yQdJeV67tuxf4Q==
X-Received: by 2002:a19:ac47:0:b0:507:a766:ad27 with SMTP id r7-20020a19ac47000000b00507a766ad27mr4083693lfc.16.1700913420712;
        Sat, 25 Nov 2023 03:57:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3176-084d-819d-12bf.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3176:84d:819d:12bf])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906a21100b009ae57888718sm3344349ejy.207.2023.11.25.03.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 03:57:00 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sat, 25 Nov 2023 12:56:56 +0100
Subject: [PATCH v2 2/3] dt-bindings: iio: light: add support for Vishay
 VEML6075
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-veml6075-v2-2-d04efbc8bf51@gmail.com>
References: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
In-Reply-To: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700913416; l=1496;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=GoptkDW+HIGQ2dT3QJEQVbxlzN3cg47vkmL+uaSlZDo=;
 b=0/4fX5SRgm9Bmpcl80znDWf3p5fWWCLbWbi4XRAk2/kXcQ99o1WeTTYN6ohLtxc61tQMcml9g
 ZBxbXLKLyvCA8z9XJyWATQI1SB+vPp7L6tJsAD/+dcqMOdklXIU8xIB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Vishay VEML6075 is a 16-bit digital UVA and UVB sensor with I2C
interface.

Add bindings and an example for the Vishay VEML6075.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/light/vishay,veml6075.yaml        | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
new file mode 100644
index 000000000000..abee04cd126e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,veml6075.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vishay VEML6075 UVA and UVB sensor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    const: vishay,veml6075
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        uv-sensor@10 {
+            compatible = "vishay,veml6075";
+            reg = <0x10>;
+            vdd-supply = <&vdd_reg>;
+        };
+    };
+...

-- 
2.39.2

