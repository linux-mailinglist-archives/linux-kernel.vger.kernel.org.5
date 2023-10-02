Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699A57B59D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjJBRul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjJBRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:50:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83895C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:50:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-76c64da0e46so810139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269035; x=1696873835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2OIh/G3vvfH8cT1f+jhivcT+xHStCXj54HHC5DhSlw=;
        b=AWo5QFqi3vDLNgXtRAXU3v3ejAKlGFEYneI+WL/VuF3O37bI7rgOhwwfIddbR8TBDZ
         b9+DOJuI0NYMxPztTllcC5SGi5IQg5w7T772e9ZMNOcmwPmjtG2nz9WfFxrIOiHEQuEC
         Q3ebbxjgqIpHFCeYrZ/RRXtP4Q7yVaF1LV3ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269035; x=1696873835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2OIh/G3vvfH8cT1f+jhivcT+xHStCXj54HHC5DhSlw=;
        b=RVoGXuM1FmwimujD4oRU4SPhhZ4EPmY//cHP0LRX6g/EbijMBWkUd6/Tp29JXA6XSZ
         lJG40ddl7FWzDbO4C8UzSrdhA8rD76cidGsV3+t/JyzB8nmqtLBAGhfOuNik27nJJc1K
         Nz65nXUIycdZFHBQs/rYejQjq/y25bRmIOeHUom88wmJYl19y3l6gRqaMrIydLmGoPPq
         zoVnrCI3Mya2S+QGpo4vHUwKg8NHmfcAKQEIPNWHKuXIzuUjqYv/ZwNd4WsTOhjaQCR4
         mxEMp/nTJeCEctz/R/tjH2h1azm20/MkummvYfXwRLbYgQJGcd3H+KMT3/4OzHi2RVFJ
         GFdQ==
X-Gm-Message-State: AOJu0YxtU9UifcUrXZ5Z41IubBWZBjSTz0SpJBSjgaRBBIBzxF/TrCCC
        uYPP5Y8TIn3SNXgWJfedPAHeHg==
X-Google-Smtp-Source: AGHT+IEajo7AgZ09G/o1FHYBl5iibeG+V+B1CsR5q6ZjwznpqxMf8wOSm4wNhvKtLK5z7hs1GK8trg==
X-Received: by 2002:a5d:9cd5:0:b0:799:36c2:fa49 with SMTP id w21-20020a5d9cd5000000b0079936c2fa49mr12850092iow.15.1696269034885;
        Mon, 02 Oct 2023 10:50:34 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:63cd:2673:520:2e9])
        by smtp.gmail.com with ESMTPSA id s23-20020a02c517000000b0042b2e309f97sm6919562jam.177.2023.10.02.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:50:34 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: mtd: binman-partition: Add binman labels
Date:   Mon,  2 Oct 2023 11:49:41 -0600
Message-ID: <20231002174948.1015223-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002174948.1015223-1-sjg@chromium.org>
References: <20231002174948.1015223-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two labels for binman entries, as a starting point for the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..406a8997d3e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -0,0 +1,48 @@
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
+select: false
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  label:
+    items:
+      enum:
+        - u-boot       # u-boot.bin from U-Boot projec6t
+        - atf-bl31     # bl31.bin or bl31.elf from TF-A project
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@200000 {
+            label = "atf-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.582.g8ccd20d70d-goog

