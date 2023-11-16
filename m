Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5752D7EE5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjKPR3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:29:08 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1396A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:29:04 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a689bd4928so57872039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700155744; x=1700760544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zObDJyyApj+o5rWei7TBUNVUgsvLA6WxzS7aiu366ig=;
        b=ljbhwOdEVK4gOjDfaVhdMjQzJkV1GSL0684P+G65/geu6qKcxxUIfa8pXDwgbbmVXJ
         nLTGKcOQYfJCLsZlKWTrIy39X2g168F/53cWCTmwP5EwaY5Qs0gXmaIFy+luzFf9nH/a
         wndqRnKjCjjMPVOj2Do4J05SZfo+llU+tllq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700155744; x=1700760544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zObDJyyApj+o5rWei7TBUNVUgsvLA6WxzS7aiu366ig=;
        b=GNYE+sMjr0TfOjaKzDJQvkT12gUPZixW1gdSaEyBbkyS+S2OvAKMiVWk0ADxknzz7b
         o2l7gxf4jEM2LI1j6Ku7XMj+khnvF7nDDksCHapqf+1NqtwOn+cXoQ85Xlnk+0MYMZ9b
         d6RJpqDeeQT3hOdKSbWBMpBnRsHS28RGAD4nvE5nYs/jGabH+Wd2WSLkvK96KcUHvXf6
         dxRVB0LuE99YfP63gqWVdmLpkgY8T0wnnxsKLxcDCj45Nuos555nLRKxeJiDZnug2UUd
         8tYG/DsALA1a4w5FvpP8N0eCQdJgPUS8FIPmrAyuXYPnsrKNxmij/+wlsjyHmMVn5PJy
         Nrfw==
X-Gm-Message-State: AOJu0YwyZUQhjA3h52VsPrig72XsPJMyPZ6H43x/30Y8FkWISRxXOSN3
        hEf095Jq+NvJvYwPNQ4YJiSxTw==
X-Google-Smtp-Source: AGHT+IFKMAplsaghNOXgzwni6uGRMOHHyXUUMlwafzZxgoUtmTxDO5K7s6Rv6XR8ipAkr/swrYO73A==
X-Received: by 2002:a05:6e02:1a0b:b0:359:3294:91a9 with SMTP id s11-20020a056e021a0b00b00359329491a9mr2835390ild.14.1700155744300;
        Thu, 16 Nov 2023 09:29:04 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id o8-20020a056e02092800b0035ab8cc4a4bsm1914348ilt.17.2023.11.16.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 09:29:04 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
Date:   Thu, 16 Nov 2023 10:28:50 -0700
Message-ID: <20231116172859.393744-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for binman, so we can extend fixed-partitions
in various ways.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Add #address/size-cells and parternProperties
- Drop $ref to fixed-partitions.yaml
- Drop 'select: false'

Changes in v4:
- Change subject line

Changes in v3:
- Drop fixed-partition additional compatible string
- Drop fixed-partitions from the example
- Mention use of compatible instead of label

Changes in v2:
- Drop mention of 'enhanced features' in fixed-partitions.yaml
- Mention Binman input and output properties
- Use plain partition@xxx for the node name

 .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 3 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..329217550a98
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,68 @@
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
+  from multiple projects. It is based on fixed-partitions, with some
+  extensions, but uses 'compatible' to indicate the contents of the node, to
+  avoid perturbing or confusing existing installations which use 'label' for a
+  particular purpose.
+
+  Binman supports properties used as inputs to the firmware-packaging process,
+  such as those which control alignment of partitions. This binding addresses
+  these 'input' properties. For example, it is common for the 'reg' property
+  (an 'output' property) to be set by Binman, based on the alignment requested
+  in the input.
+
+  Once processing is complete, input properties have mostly served their
+  purpose, at least until the firmware is repacked later, e.g. due to a
+  firmware update. The 'fixed-partitions' binding should provide enough
+  information to read the firmware at runtime, including decompression if
+  needed.
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
+    const: binman
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "^partition(-.+|@[0-9a-f]+)$":
+    $ref: partition.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
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
index b294edaf5698..8704eefe6e2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3550,6 +3550,11 @@ F:	Documentation/filesystems/bfs.rst
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
2.43.0.rc0.421.g78406f8d94-goog

