Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68A7D7657
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjJYVHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjJYVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:06:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE513D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cacde97002so988455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698268013; x=1698872813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF/ordmyMYgWe1Uu/l3iCAlozeYeU+RXukpZaUtD30Y=;
        b=acVpp8kYwUMLCAZN7hRnOvpNvz85M3O4Ea+8dpWsqmFFe3Xyy581p9UbqzcsMl980K
         nR8udgeSMdxPBrZ4pD1rxXCesSy6RobyPHnLkdz++hAdcAjy+OC+gD+G7LDVKEwO7qD7
         uFqoXZf8Wi2+7qWXT9wkA1SmYQlVtW3JGFFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698268013; x=1698872813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF/ordmyMYgWe1Uu/l3iCAlozeYeU+RXukpZaUtD30Y=;
        b=Fd1aFP6C2Aqf/t1LDoLUgYEa4FGfAcyts3u04o70n/+OuUaWY0wcV5tNWrMHv9Boxh
         2X44C26lNJlTJljhxORQzIqQQITE6zCssgjVP5SHQJM9nuDPeKE+yv0qPqLN82sptJo8
         EcM1fHwuAChZJsxZ0lv20L4VeKN8TLeorhtMqtvXphL1tQYtjAJnnJRqnGly3SFCoPVJ
         gcXjSzD9RZKlEywMqTCJfkb5NiX9ZZIJ4JM3/MloJQVhn4MQz81IbLwHR+p287sjgHnJ
         AeL7nS3WPXBRhAp4A2vLNIPeg6ZG9lhzL1mQCfDafZpGaDVT5iG7PpZeej+HX+BTPHLn
         v1pA==
X-Gm-Message-State: AOJu0YxaSPxWLtyNd/Sa5Ccn2CWc2BL5v3ROBC561wycmBjLZXXkrbXV
        GPY4GQqfrr7ft5Bt4rHcKn4++Q==
X-Google-Smtp-Source: AGHT+IEYJE06QosRYGT0A1ENbZcTTEfgZ/obEURE1Bi+knZeZm3lfZ+35MZQ58edxdw31TbPoPLpDg==
X-Received: by 2002:a17:903:2342:b0:1c9:dff6:58f2 with SMTP id c2-20020a170903234200b001c9dff658f2mr16108624plh.59.1698268013528;
        Wed, 25 Oct 2023 14:06:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001bc5dc0cd75sm9689447plb.180.2023.10.25.14.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:06:53 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] dt-bindings: mtd: binman-partition: Add binman compatibles
Date:   Thu, 26 Oct 2023 10:06:11 +1300
Message-ID: <20231025210616.3201502-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025210616.3201502-1-sjg@chromium.org>
References: <20231025210616.3201502-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two compatible for binman entries, as a starting point for the
schema.

Note that, after discussion on v2, we decided to keep the existing
meaning of label so as not to require changes to existing userspace
software when moving to use binman nodes to specify the firmware
layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Add mention of why 'binman' is the vendor
- Drop  'select: false'
- Tidy up the compatible setings
- Use 'tfa-bl31' instead of 'atf-bl31'

Changes in v4:
- Correct selection of multiple compatible strings

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..83222ac9aa78
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman partition
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+  The vendor is specified as binman since there are quite a number
+  of binman-specific entry types, such as section, fill and files,
+  to be added later.
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    enum:
+      - binman,entry # generic binman entry
+      - u-boot       # u-boot.bin from U-Boot project
+      - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
+
+  reg:
+    minItems: 1
+    maxItems: 2
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
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@200000 {
+            compatible = "tfa-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.758.gaed0368e0e-goog

