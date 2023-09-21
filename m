Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24187A9BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjIUTFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjIUTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89EEE5A1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:45:25 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76c64da0e46so53268839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695321925; x=1695926725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnKiy3ihwgd/VOoqSanohGN5ffhK+cZ/VpjdYKJUjf8=;
        b=U6AnxTaZN69Yg5XxdFZLDPrDlurYvQFWsLRVzWczhSGkzBjE+vR12yzRRlUc1skcb4
         eTOdHdLPXX+vyRtm959mPZgXaiVu2cdXlZQ5aAdj5i11oiQp8U5S63W/HQj3iL+xs+V9
         P7ntzZ08MRJXVe0+P+zII1R4/a9aXzGHPQ40I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321925; x=1695926725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnKiy3ihwgd/VOoqSanohGN5ffhK+cZ/VpjdYKJUjf8=;
        b=J4Ao/QsXHEEslVyszZre4xG7e+SuMjgZO8ZI1arRVjAKdWwXL4JQwZaSaiVdpCgk7m
         2j7quzFQGixaYl4X7O/ah5D2yLJPt/V6jzJWWT33X0CKif5yTfBhE4L+dBvJ5EH6h8OI
         k5eJccyTpOXGjFhjbNNdiKPODAb6TRDaYR4dCS/xs0GM8c4Qiek+EAN0WwzZv0BzURIq
         N6XUEfp7nkfUkOZsAGIsx70XE+wFJaKlIQ55iHd0NuWD8nHK5luUqKmLWiq48PAGX5To
         u+VreI5cWQgfeAOLPl44kaCS9zW3iwYNKOUdVqiGEMuFnSnWinC3BF48l9SwH2xSR5XL
         9Trg==
X-Gm-Message-State: AOJu0YzFF/JFqIZNZcnrp+gDdcIYu9lk65Y+Gb1un8ZFqUFSqZDprQMP
        niC3zY6FtgHPXJQ2V+/VfZCMG6ilGYUvgykw4zI=
X-Google-Smtp-Source: AGHT+IFLx+QxNqVoEsIFpwCXXYW/u8hYUS5LzSu0VrhuBFkVi/scOpz5E7kCyC+9y88eBDeWXVQ/9A==
X-Received: by 2002:a6b:7303:0:b0:787:34d:f223 with SMTP id e3-20020a6b7303000000b00787034df223mr7074088ioh.11.1695321924839;
        Thu, 21 Sep 2023 11:45:24 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a636:e615:ea83:bc42])
        by smtp.gmail.com with ESMTPSA id d26-20020a02a49a000000b004290fd3a68dsm511017jam.1.2023.09.21.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:45:24 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: Add a schema for binman
Date:   Thu, 21 Sep 2023 12:45:14 -0600
Message-ID: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

[1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
[2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
[3] https://www.spinics.net/lists/devicetree/msg626149.html

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
 .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 00000000000000..c792d5a37b700a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,50 @@
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
+  compatible:
+    const: u-boot,binman
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      binman {
+        compatible = "u-boot,binman";
+
+        u-boot {
+          size = <0xa0000>;
+        };
+
+        atf-bl31 {
+          offset = <0x100000>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
new file mode 100644
index 00000000000000..8003eb4f1a994f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
@@ -0,0 +1,61 @@
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
+  The entry node specifies a single entry in the firmware.
+
+  Entries have a specific type, such as "u-boot" or "atf-bl31". If the type
+  is missing, the name is used as the type.
+
+  Note: This definition is intended to be hierarchical, so that entries can
+  appear in other entries. Schema for that is TBD.
+
+properties:
+  $nodename:
+    pattern: "^[-a-z]+(-[0-9]+)?$"
+
+  type:
+    $ref: /schemas/types.yaml#/definitions/string
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Provides the offset of this entry from the start of its parent section.
+      If this is omitted, Binman will determine this by packing the enclosing
+      section according to alignment rules, etc.
+
+  size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Provides the size of this entry in bytes. If this is omitted, Binman will
+      use the content size, along with any alignment information, to determine
+      the size of the entry.
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      binman {
+        compatible = "u-boot,binman";
+
+        u-boot {
+          size = <0xa0000>;
+        };
+
+        second-area {
+          type = "atf-bl31";
+          offset = <0x100000>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747bd7..849fd15d085ccc 100644
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
index a4c30221eb305d..ebcbfb4292e8dc 100644
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

