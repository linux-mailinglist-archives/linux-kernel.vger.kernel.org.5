Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444747B0D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjI0UVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:21:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469C10E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:21:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso367363139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695846069; x=1696450869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kq9WoSgqEviF42jhwFTI980vH31ePAvDcikVyQPxtc=;
        b=f8G63bW0U7k/6Ocv1LYU381gT0auO5VWNBu+Q78y1TcTXuaT7TS+5kRzrKlWDr5TOs
         Hs98Gr0iD2V9OOjmsSOc9zqlfTNVNQ1jMyHCL4Bt7P3m1WhByHNEFV4+1yF2Ovy8t0Cz
         +iZDNiZUi3Ibm7jrS7Ny2ND7aaxEOgNxNJTDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695846069; x=1696450869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kq9WoSgqEviF42jhwFTI980vH31ePAvDcikVyQPxtc=;
        b=av/pqw2CgAiXs3s7Sg/jqp39k4SA1OegPm6Cqy1RV7rb2zZbD98xCCLxWq7gh4dW20
         QP9xNysvHEvJ4aXq8rHdqsGnimsy978M//dU6lTgPoCzzg+jm2xh80/ZLwHYVrLYR9UF
         r/frPcOEf8WR9axTy3UjVB12kQxc5GXDwHBOHHrOntGB306aYGnLwLg+zWKWbVLd4Z4j
         WDfb9DBFK4yYG+7si9VOzfMXMW/ZGPTg6Vm90w6cKGq5Qdm0hHpCaRqLEOnVkOAskcGK
         OsJINbZ33DrqcLQMyN4BXX67a9qDprHIiRWSm5viysY9HRDqCbgGnrQcr8mNUPEAiLyE
         HMqg==
X-Gm-Message-State: AOJu0Yxac4Hlaxnc2nYg1DkWrCvnAqd+ePXsCrljfl7xVPnFvK1I9ufv
        HvAs5mp//4WLmObUSOX/WZa/Jg==
X-Google-Smtp-Source: AGHT+IFhPJEncrLdXnOVjxjuTHH/e94XYzo89HB1tZ1pWdiwxx4ZhAkrwcRurxLK1zLwja0dnf6dQQ==
X-Received: by 2002:a5e:a610:0:b0:795:16b8:85fc with SMTP id q16-20020a5ea610000000b0079516b885fcmr2995614ioi.0.1695846069701;
        Wed, 27 Sep 2023 13:21:09 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
        by smtp.gmail.com with ESMTPSA id ei15-20020a05663829af00b0042fec8620e4sm4113299jab.57.2023.09.27.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 13:21:09 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: mtd: binman-partition: Add binman labels
Date:   Wed, 27 Sep 2023 14:20:52 -0600
Message-ID: <20230927202057.3676497-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230927202057.3676497-1-sjg@chromium.org>
References: <20230927202057.3676497-1-sjg@chromium.org>
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

Add two labels for binman entries, as a starting point for the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..6ee832cb4c4c
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
+        partition-u-boot@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition-atf-bl31t@200000 {
+            label = "atf-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.515.g380fc7ccd1-goog

