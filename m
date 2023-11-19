Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226FB7F0463
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjKSE6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjKSE6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:58:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE011D;
        Sat, 18 Nov 2023 20:58:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e1021dbd28so456097566b.3;
        Sat, 18 Nov 2023 20:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700369895; x=1700974695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fplaLSYQTnlodH8FfQYQ5jvqJcl6qluHMzbsHoMOv78=;
        b=DzI4BCEI6T9zet0NYyJeqS3snfNZJtfE4HUbZqztVByg2Oncxg62hrQd0oFW1jcDGX
         RugmSVyBsgkfOlLb+f5YN6iVw8HRt0dyBNh2acHyKOOs90fRbKGDiZ8SzamEOUKynTk/
         qGLFhNFgivcngQ8KUN9oliDLrvDvQPqjjX3HCbk5uWGloFo3rJyP/u4NT9t7olATM2Gj
         oMcJKUo5GW2rIIgDMQ8DpSmkDw4UnKKAl7CDLb+lNj3xdQoz9R3UA3LSTUo6ophE8ca0
         tCRP1LM2sLEAqvzCxO/U4hev/U6fDkvIjZuW4dgy9gmY40W27l8CXPWzvlwqcVVti1PZ
         ESEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700369895; x=1700974695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fplaLSYQTnlodH8FfQYQ5jvqJcl6qluHMzbsHoMOv78=;
        b=kdGBH3zGG78WUxcn/UeI9BBpA05v97zsHnejghq9fwpwlskkLgkmujhW/Dt3xrdz55
         Rhjh9IQoWXSzm8cyuyn+6oWKuS3TDyy5X2xOvQT0/pcS3n0XpHCVjw1Dt4PnhUN+eCvn
         VyZRDftoBDEcjZq2B6FJs+2l6RoovHb/FrBd1OlIubjf4oYQd/URyAI41QqyCBo2qdyb
         X9YkEk2+c/LoSg/2i3xVKX8bFD1aC8aoV64P2jHrqD1clJwxI9cU4q7z4vBp/ZHBJusS
         VjucRJuFnjWSVORRO3xUJOANe5iq2XP3vIBC2JgswuSYQ62vvPFsFtwJOoyDO6WWEoBH
         i7Wg==
X-Gm-Message-State: AOJu0Yza1YENzrWWJdOSMH3zyDIplvvWj+9RlOenNguVwaWxC6FSXcbB
        jOvVabKVyVQ3HgdmS6TySlI=
X-Google-Smtp-Source: AGHT+IHWDETWIINVAMoAfeD0sI4G7Z1GlcBzH8XX50y1rsq0701rmOy5UvWKW5dbBNBGFL6SWkXQrw==
X-Received: by 2002:a17:906:3652:b0:9fc:fd2a:55d with SMTP id r18-20020a170906365200b009fcfd2a055dmr441623ejb.34.1700369894773;
        Sat, 18 Nov 2023 20:58:14 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-9fcd-7897-f205-6e36.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9fcd:7897:f205:6e36])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b009f5b7b6f3c8sm2504220eji.56.2023.11.18.20.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 20:58:14 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sun, 19 Nov 2023 05:58:04 +0100
Subject: [PATCH 2/2] dt-bindings: iio: light: add support for Vishay
 VEML6075
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-veml6075-v1-2-354b3245e14a@gmail.com>
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
In-Reply-To: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700369889; l=1487;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=OUGiCOAJxrWsDYARNYQq1T/CNh7W00rLbeJhW/Ev090=;
 b=3jeclC1PoYN1EtHlmytVuJaSl8lMjl2m/geBDnnv7YQl+jhAkk5ueXOXD10PXGe5+ATul3Yu2
 FVW2e+4yFlqDzDe2n7WTca/rGDDjeJZlBWtU/HvFoy2gEFyTa0HcuEE
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
---
 .../bindings/iio/light/vishay,veml6075.yaml        | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
new file mode 100644
index 000000000000..f8e2db29af42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -0,0 +1,40 @@
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
+  vdd-supply:
+    description: Regulator that provides power to the sensor
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

