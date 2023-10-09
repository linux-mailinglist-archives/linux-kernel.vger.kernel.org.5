Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326ED7BEB55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378576AbjJIUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjJIUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:10:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B8A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:10:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb04309dso218718739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696882215; x=1697487015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3GY1i1RwOxFPsx3r0WAP41F76rpcBgk99acMMB0WNM=;
        b=mBHh+J33A6HeXlgQPT/G6YWkrSEhSWtMiWsNYcuXUmhcj7h4k4YKzna+TynjHDxlzy
         D6WjXyyqnQPE0xB5s1lj6ogTA0llshaKdCOf0kaa8Th9C9+SP9Gz4KC6zx+kUy9Tzeuf
         GCDQ19q1xnX6DnF++M2NbwwwmgNWoSJ0Lfcs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882215; x=1697487015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3GY1i1RwOxFPsx3r0WAP41F76rpcBgk99acMMB0WNM=;
        b=lryWNAZfLigEoLd42+N5DlRX4AyXLoC/HuswnCcFxAoFDjm912Qtfr64b6Ftsj05js
         Xi4irPJYI1b57O8aTJsJDfNsuKKm62irUwtccxWqUAw3a0ENwiRHjLxUraeBwkUH1Jg1
         Iep9E4a9F1VmvoaDy+ITilwbFZzrtJHED7z1dSDYVbwKAfo9plC4E8hRhvInXW5RFQ4l
         mlCyzkN7ce+NdVuiR++wJcyy8/RJ63ezmvMGTBderHJuZ9I+JWihQ7HZTelTc4ZsO+cX
         QlW8a4C2nCRU/5ItgAUAv1weNOqmPpoYwiw0pE4P8Hi2gVEkGbTCKHkGPs1ym2Qjc1IA
         iN/A==
X-Gm-Message-State: AOJu0YximETCAAhLqcZaRAuwOY8NBjznU71zozrPv3IyHrXlD2h72ulV
        tSZZytWYRbZozPRmRNOYY2roAQ==
X-Google-Smtp-Source: AGHT+IGRVDl2QlAkPNETkpq0SUkGBPU/UdXTV3AM7x9Hs22e2Z60hPdHjcDCo4XmjZUSi77IkFoEjw==
X-Received: by 2002:a05:6602:220e:b0:786:f352:e3d4 with SMTP id n14-20020a056602220e00b00786f352e3d4mr19797645ion.7.1696882215555;
        Mon, 09 Oct 2023 13:10:15 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:138c:cf57:c18d:20f5])
        by smtp.gmail.com with ESMTPSA id q21-20020a02a315000000b0042b2df337ccsm2215294jai.76.2023.10.09.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:10:15 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
        Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman compatibles
Date:   Mon,  9 Oct 2023 14:10:00 -0600
Message-ID: <20231009201005.1964794-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231009201005.1964794-1-sjg@chromium.org>
References: <20231009201005.1964794-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..754f804524a5
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
+  compatible:
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
+            compatible = "atf-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.609.gbb76f46606-goog

