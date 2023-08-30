Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D4178E03A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbjH3TOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbjH3Kgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:36:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952A1B3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:36:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so7124348a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693391788; x=1693996588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZcO54s6dPOvHTKozhAJ9zybhhO9IlHmOjEttCcJ4Fc=;
        b=C0prIXeHgKDHDYl3xGT74jVJ+7LpPwuKQ9ApXGCbHlvskrYIbeES4cXYboTamDKCMC
         bA7mmoX1Kk/fzujWZ5VfqofnorAHCPB7/qciijCBZNFGrynvnbAinPacxkx2c+MUsXYW
         sV1L0KkqQVRBjvSbnDymg/GHfIDTgp/9G69zhzrR2S0xOIvtu+x41dDbllwytpKJ4Lee
         7VCplc89rhLJHm2LohAl5Wpc04xGDlLEj57VNmaxInvKaQK7xxUv61LMGyrTODCmXO7C
         nZhHHSpt10QEoAmMCcFuscT20FcRqjNaurGZsof454w3eSxx5nohOlU2TSv6Qvd41vH4
         lcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391788; x=1693996588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZcO54s6dPOvHTKozhAJ9zybhhO9IlHmOjEttCcJ4Fc=;
        b=LMO9OTtncGDMs0iM/BbtNGzHLnyJrIKenZar5ghEN0g9sL48n63sflCIC6Bst3o8ue
         soU2mRSkdNpkCrH4NGuh+4pu8enWileWJs6a3vbp5t7u9uLNsyW+7TPdedRk+8yUgc0X
         ZnmsQXHFqcO+oHJG+zsdh0fW7oERVA2B7qgBYvkEY0K5y1yaHiVgJinV/cWeC2xBOzK5
         7H3kAXm8LArVPbaHCDM/3suhnx05QoYQUx5hDTmcsdjniJuUTKvzjjh55ZuPKnV44usZ
         vm34RpiPUe5Xd/ykirbvfBv32I0PuVZzlLi0uz9UFMv8HidbKi91fatCrPjQW3JrEtz5
         pagw==
X-Gm-Message-State: AOJu0YwkyJIeZGpCOxySxPE6wHlfuW617/3EsP0w3cpl1K2OZ8PlRh+o
        Pwlto78oVMSj3a5uo+n7GdCSYA==
X-Google-Smtp-Source: AGHT+IGiBHH+VCjnIyveBq5dLYGOcHJ2s6Xflu3d/0Pw3YF2Fpdun5D9Au3Dso27zqC14dGTODLPfQ==
X-Received: by 2002:a17:907:60c7:b0:9a5:8eab:49de with SMTP id hv7-20020a17090760c700b009a58eab49demr1376125ejc.17.1693391788390;
        Wed, 30 Aug 2023 03:36:28 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00992bea2e9d2sm7027620eja.62.2023.08.30.03.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:36:27 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Date:   Wed, 30 Aug 2023 12:36:16 +0200
Message-ID: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add the DT property 'infineon,en-pin-fixed-level' to
indicated that the chip ENABLE pin is at fixed level
or left unconnected(has internal pull-down).

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
----
Changes in V4:
- Update property name & description.
- Update commit message.
---
 .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
new file mode 100644
index 000000000000..1df40ee7454a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
+
+maintainers:
+  - Naresh Solanki <naresh.solanki@9elements.com>
+
+description: |
+  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
+  Regulator with SVID and I2C designed for Industrial use.
+
+  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
+
+properties:
+  compatible:
+    enum:
+      - infineon,tda38640
+
+  reg:
+    maxItems: 1
+
+  infineon,en-pin-fixed-level:
+    description: |
+      Indicates that the chip ENABLE pin is at fixed level or left
+      unconnected(has internal pull-down).
+    type: boolean
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
+        tda38640@40 {
+            compatible = "infineon,tda38640";
+            reg = <0x40>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 40bc475ee7e1..86c7d34f63bf 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -151,8 +151,6 @@ properties:
           - infineon,slb9645tt
             # Infineon SLB9673 I2C TPM 2.0
           - infineon,slb9673
-            # Infineon TDA38640 Voltage Regulator
-          - infineon,tda38640
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280

base-commit: 919a83d020a8dfa1411c1dc1cff23a833f0f5268
-- 
2.41.0

