Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD07EC32A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjKONA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbjKONAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:00:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124211D;
        Wed, 15 Nov 2023 05:00:19 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5306397a12.1;
        Wed, 15 Nov 2023 05:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053218; x=1700658018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSgLEiacSTK1nlXU5ESAjkt0zHh/T+kLWeSwZ58MCmk=;
        b=LafvcVFTtt4spzSgWfxS/+65CZaY3NsO1pQg1AVi5TbCY9Mi0jW6hxovib3BQ4AUeX
         c5C/tpMEownjHe9pFGtQOuXFDzn8TmM8RWLBPqD9lRHBoPpl1R5kemkFD/dx/bPTQtCN
         PUEZgFa+vkYBp6cp1feBsYKdI5G7vpEZbzQx/huKK5Xb0cgiw6wxxEe2JCd5BYprWlLh
         aQJ4C58ixJ3Z4agSZFXYlyaTJqF+IouIQfgezVQnB3vIjdhbiAxZorhg/TmYn1iEbXZU
         GIxZQWN9FeJjzImDoF/MJl44p8paJabmbEQ3Zoelwp1ijCo7Zst3S7jDpZgxnD5u6mVd
         zpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053218; x=1700658018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSgLEiacSTK1nlXU5ESAjkt0zHh/T+kLWeSwZ58MCmk=;
        b=gi+HKpYy1Pi8rh2gQgVcMNT/J+HsFHeUoeKV6jAeY3j5IwArQ9/izBKrlV0wk0kb69
         83cJl8Y8ZYJxoZ8b+PKf+uT2QM2pXU8opmkloF8ZqsUyJ1RBLZ9WVLnzeoaMcVBtnbzb
         GaFW4rIND0GoNdL2fP4nUKIqeY9HYuMlZgAfg+I3yXbqdN5TFFc/AJNHh0rmWrFtupZi
         365fua29Oh78m6TcfZ1WgbsatJBOSco2RKxIp5EK1IWr3tU1BSQ7/ZMajkSIKBH4Y8NN
         UxiQsnzjc5HqZlsvs2OHD++XSZSgpMr6UTJJ6LoLCrtxM7N09v8ikMaeGgaT1KbUlIQQ
         vbvQ==
X-Gm-Message-State: AOJu0YyHZCUzVslNJyLdHDFQK1jNHe5oN00YfunF29OTe4dKUEuwVH6B
        biu+t8gV77fS77GW+ddi7WU3UoghJNTW7A==
X-Google-Smtp-Source: AGHT+IEB3HkUt0kuClIyGcyxmuuwyVWGHuf6jlIwovd8wEjdCAC4O6BE3n+d1PDNS9dMndhgntvhsg==
X-Received: by 2002:a05:6a20:158c:b0:15d:e68d:a850 with SMTP id h12-20020a056a20158c00b0015de68da850mr14124970pzj.29.1700053217925;
        Wed, 15 Nov 2023 05:00:17 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id fh42-20020a056a00392a00b006c4d128b71esm2812867pfb.98.2023.11.15.05.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:00:17 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: trivial-devices: add aosong,ags02ma
Date:   Wed, 15 Nov 2023 18:28:07 +0530
Message-ID: <20231115125810.1394854-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115125810.1394854-1-anshulusr@gmail.com>
References: <20231115125810.1394854-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Aosong AGS02MA TVOC sensor.

The sensor communicates over i2c with the default address 0x1a.
TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.

Datasheet:
  https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
Product-Page:
  http://www.aosong.com/m/en/products-33.html

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v2:
- Removed device from trivial-devices
- Added standalone binding with vdd-supply property
---
 .../bindings/iio/chemical/aosong,ags02ma.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
new file mode 100644
index 000000000000..4a0278c6318c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aosong AGS02MA VOC Sensor
+
+description: |
+  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with default
+  address of 0x1a.
+
+  Datasheet:
+    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - aosong,ags02ma
+      - asair,ags02ma
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@1a {
+            compatible = "aosong,ags02ma";
+            reg = <0x1a>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.42.0

