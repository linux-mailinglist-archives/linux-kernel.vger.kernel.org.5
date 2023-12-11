Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69880C9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbjLKMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjLKMbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:31:10 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBED6;
        Mon, 11 Dec 2023 04:31:16 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-35d67870032so29671835ab.2;
        Mon, 11 Dec 2023 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297876; x=1702902676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGwunGJa5PSMMdSBBgJ2iR2Blfg2YE5Rj86DYV29NQs=;
        b=eWKXsBsuorYEHabM7uqM49fz5TCIJHDCuut39OAh2yC5fyOsuS4/5R2LjkGZNhE8VN
         NYeg3Bi8M1OUcAolpT+e6XzYyusc8K8uKJYBTrPbPk7oNC9httTG+WEkMzscKDHW6uum
         LiWsl4P+LnJwEcczVWAu9Ql97dnm3xDnbNzXtBpwUGKp1YZBWRw5DeSOvPkimJ0F++Ow
         ffDJcPqGNEWXFe4fJ+4L0z5+D3HcAE/NnyQ2PHPgFzokDObOSJIiarc2w11JnNyqKZJa
         olWTQpFH7qsUTqq/fD8Cr5wJgRL27Xq04GNfyK4xjxHBHYxJo/pMPsbvw89haYipGpSb
         HVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297876; x=1702902676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGwunGJa5PSMMdSBBgJ2iR2Blfg2YE5Rj86DYV29NQs=;
        b=Wmh6YhzdXoSysgZKzzI/zavvxL70XVGqeOflJuKAfSxStLY4Vs/4Bqg4UfwBnhdzor
         mZWO7KuaK5hatVciJ34ignc+It6U5Yr5F4VEIy5IWp7rrEAJ5b577x+ITOrxYKCpr1Co
         p353zOYnueP6m2IyGD4KtngYQgjd6fYFueiC77F7qSBG/B6nR7P6q/aC3/pX/waT9pqW
         azI4dTCLrUf7PyIx9VGP6MbRmPEumOwloJOWbcCaiDGcuDZoCBLE6o80AZeTX62dpqje
         VrGJJDGuYckkf4NWD5Ie5oRtN+saaf8/jpX2i1mPJEjY57DQ3AnVFbmfRjYmmcJy9Fk2
         Vmvw==
X-Gm-Message-State: AOJu0YxTiJx32YyVhOwJ2x9u8nsKXSn8Bme0VUI2eqy0JA5vEW0y6k95
        jyoUqE3oQMNWoyFdFN0X3Kg=
X-Google-Smtp-Source: AGHT+IEojdDDlZ16/tI1Zewg03VN4WKuCd+HfBRAM0E/usNSGJsIRsYMW3ov6/E91Jn7Q9+ked/ONg==
X-Received: by 2002:a05:6e02:160b:b0:35d:59a2:2b8 with SMTP id t11-20020a056e02160b00b0035d59a202b8mr8403850ilu.88.1702297875666;
        Mon, 11 Dec 2023 04:31:15 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.110.72])
        by smtp.gmail.com with ESMTPSA id k21-20020aa788d5000000b006ce79876f9csm6150925pff.82.2023.12.11.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:31:15 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li peiyu <579lpy@gmail.com>
Subject: [PATCH v6 4/4] dt-bindings: iio: humidity: Add TI HDC302x support
Date:   Mon, 11 Dec 2023 20:31:01 +0800
Message-Id: <20231211123101.9868-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211122201.9598-1-579lpy@gmail.com>
References: <20231211122201.9598-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
temperature sensors.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
changes in v6:
  - remove items before "- const: ti,hdc3020".
  - add vdd-supply to required.
changes in v4:
  - removed unnecessary example.
  - add vdd-supply to the example.
changes in v3:
  - Use a fallback compatible.
changes in v2:
  - change the maintainers to me.
  - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
  - change the node name to humidity-sensor.

 .../bindings/iio/humidity/ti,hdc3020.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
new file mode 100644
index 000000000000..7f6d0f9edc75
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
+
+maintainers:
+  - Li peiyu <579lpy@gmail.com>
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description:
+  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+
+  The HDC302x is an integrated capacitive based relative humidity (RH)
+  and temperature sensor.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,hdc3021
+              - ti,hdc3022
+          - const: ti,hdc3020
+      - const: ti,hdc3020
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  reg:
+    maxItems: 1
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
+        humidity-sensor@47 {
+            compatible = "ti,hdc3021", "ti,hdc3020";
+            reg = <0x47>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
-- 
2.34.1

