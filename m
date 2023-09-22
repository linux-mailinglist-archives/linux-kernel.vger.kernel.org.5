Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30EB7ABA1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjIVTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIVTee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:34:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D8F94
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:34:27 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79dc081ab8dso103884439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695411267; x=1696016067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze0feaJyolx52nnGDHZNRW/aGemuWEpJCRuOORda2U0=;
        b=G0WXqrCULFj7Edu85PI16j6Jb5THUVyXYJjP0o+a9PQwYHF469/E1JrJi+9vxPuXlO
         pcR+A3bZcablFbxMuF6pT3Oz6MqAvurBYlyX5gwKpa6a8RkwLpssxzNczxVVHwRxqxHn
         gOUX7UrHd6mfLAQ4v+FaLBwEKpnVRlPoSSeyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695411267; x=1696016067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ze0feaJyolx52nnGDHZNRW/aGemuWEpJCRuOORda2U0=;
        b=kS1Z1lPbfx0T0EeTO4MUBaiTFDvWr4ufQXIBnk021E7iO3q4uA7v4OMbhIj4yru8v+
         cD7+RsbX3V9EIhAnRz0qszWEcfBA6o5M0eX0VD4OYicjWCh8oQTLSXCLw6RwTvK10zYt
         XjE5KV949m8uVHbKG8N4dsyO58LKl6AeSOSswkCbz+mOwvhoJvf+ym0FFNEQrjfA94lw
         f+0aDUIEPQuOug2PL90OsN+pEY8k6zIRx/3JfoXrb+Ngy9hx12zrPMRcHnqbTFFbJYqH
         38DJqnA1kHvfSgNGawWc2ek6X6KqRVmlfZRdzmktHDwyzMW1Auhgff9PueH5MphXSMyO
         hJQA==
X-Gm-Message-State: AOJu0YzorY0PU7aGblqqEF4+pVSBVBHz0c/UI8Kpg0n4qr066uMbzrGA
        GHrl6axrl7a3JwxZmtjMqlvdnQ==
X-Google-Smtp-Source: AGHT+IGxZot43frUtwqoFHunoT9jM8YXOXehO/Ug9V1olGsIhmVx1qXPa4/rswQ+JFb2BcqsJkZNgQ==
X-Received: by 2002:a5d:930b:0:b0:790:f866:d717 with SMTP id l11-20020a5d930b000000b00790f866d717mr342505ion.10.1695411266990;
        Fri, 22 Sep 2023 12:34:26 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9fd8:298f:4748:f9a])
        by smtp.gmail.com with ESMTPSA id b18-20020a029a12000000b0042b1297468esm1149594jal.51.2023.09.22.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:34:26 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nick Terrell <terrelln@fb.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mtd: Add a schema for binman
Date:   Fri, 22 Sep 2023 13:34:15 -0600
Message-ID: <20230922193417.1697379-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binman[1] is a tool for creating firmware images. It allows you to
combine various binaries and place them in an output file.

Binman uses a DT schema to describe an image, in enough detail that
it can be automatically built from component parts, disassembled,
replaced, listed, etc.

Images are typically stored in flash, which is why this binding is
targeted at mtd. Previous discussion is at [2] [3].

This is only a starting point, an attempt to align on the best way to
add this to the schema.

[1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
[2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
[3] https://www.spinics.net/lists/devicetree/msg626149.html

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use "binman" for compatible instead of "u-boot,binman"
- Significantly rework the patch
- Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions

 .../bindings/mtd/partitions/binman.yaml       | 59 ++++++++++++++++++
 .../mtd/partitions/binman/atf-bl31.yaml       | 43 +++++++++++++
 .../bindings/mtd/partitions/binman/entry.yaml | 62 +++++++++++++++++++
 .../mtd/partitions/binman/u-boot.yaml         | 43 +++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 6 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/atf-bl31.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/u-boot.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..31accab37055
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman firmware layout
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+select: false
+
+description: |
+  The binman node provides a layout for firmware, used when packaging firmware
+  from multiple projects. For now it just supports a very simple set of
+  features, as a starting point for discussion.
+
+  Documentation for Binman is available at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
+
+  with the current image-description format at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
+
+properties:
+  reg:
+    description: partition's offset and size within the flash
+    maxItems: 1
+
+  compatible:
+    const: binman
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    binman {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "brcm,bcm4908-firmware";
+            reg = <0x100000 0xf00000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/atf-bl31.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/atf-bl31.yaml
new file mode 100644
index 000000000000..7d28e7e1d01d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman/atf-bl31.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman/atf-bl31.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Trusted Firmware BL31
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description:
+  Holds a BL31 binary file from the ARM Trusted Firmware project.
+
+allOf:
+  - $ref: entry.yaml#
+
+properties:
+  compatible:
+    const: binman,atf-bl31
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    binman {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0xa0000>;
+            compatible = "binman,entry";
+        };
+
+        partition@100000 {
+            reg = <0x100000 0x200000>;
+            compatible = "binman,atf-bl31";
+            compression = "lz4";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
new file mode 100644
index 000000000000..9991c83aa0cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman/entry.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman entry
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  This node specifies a single, generic entry in the firmware.
+
+  Entries have a specific type, indicated by the compatible string.
+
+properties:
+  reg:
+    description: partition's offset and size within the flash
+    maxItems: 1
+
+  compression:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Compression algorithm to use, chosen from a list of well-known algorithms.
+      The contents are compressed using this algorithm.
+
+    enum:
+      - none
+      - bzip2
+      - gzip
+      - lzop
+      - lz4
+      - lzma
+      - xz
+      - zstd
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    binman {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0xa0000>;
+            compatible = "binman,entry";
+        };
+
+        partition@100000 {
+            reg = <0x100000 0x200000>;
+            compatible = "binman,entry";
+            compression = "lz4";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/u-boot.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/u-boot.yaml
new file mode 100644
index 000000000000..e5f3583f746c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman/u-boot.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman/u-boot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description:
+  Holds a binary file (u-boot.bin) from the U-Boot project.
+
+allOf:
+  - $ref: entry.yaml#
+
+properties:
+  compatible:
+    const: binman,u-boot
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    binman {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0xa0000>;
+            compatible = "binman,u-boot";
+        };
+
+        partition@100000 {
+            reg = <0x100000 0x200000>;
+            compatible = "binman,atf-bl31";
+            compression = "lz4";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..849fd15d085c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -15,6 +15,7 @@ maintainers:
 
 oneOf:
   - $ref: arm,arm-firmware-suite.yaml
+  - $ref: binman.yaml
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
   - $ref: fixed-partitions.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index a4c30221eb30..ebcbfb4292e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3505,6 +3505,11 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BINMAN
+M:	Simon Glass <sjg@chromium.org>
+S:	Supported
+F:	Documentation/devicetree/bindings/mtd/partitions/binman*
+
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-- 
2.42.0.515.g380fc7ccd1-goog

