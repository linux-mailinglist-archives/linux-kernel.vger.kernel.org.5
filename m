Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FCC7D5D61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbjJXVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344483AbjJXVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:41:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31910F6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:41:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so4246827b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183683; x=1698788483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aochEXBDpOVdwQRDyloN4dJAYsQ0xcQP5GM4jBPJ4+0=;
        b=d7tvpKYrzBtxtmlN0ix4M4txemIB0fozRONjstLOx6DOVdbYDjiL/ne12vpgExvIrO
         YW7Gpr/tqqLL5tRTD0zLkhjyk6N1t/TjgOjpHhw5gTGDzDeomhjWPV1rwhbReCNIFsWL
         fNvAlCnRviE3FLpQFpTrlXRTvlAANskf6PoPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183683; x=1698788483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aochEXBDpOVdwQRDyloN4dJAYsQ0xcQP5GM4jBPJ4+0=;
        b=KOWmvL56hJhrP+jCsVb/jl2biRhdHO4byXjDWWF07+GDU0gP2lYehCWGDs1G2CzbZg
         ZcoFRz74vW0WqMMrmkeA57oq4g52QS/8UwEIozgaktR7La7SQ1byBIOiA8duYsNmtQ7j
         3dZDBeoy1KhS1qCxIOjqgCdCaL6FixfkXEnD/sAwCjw0jXCysOAHkZM5tjBzV94hwdZV
         Lk8TEuhGzevo2pVsdlsUmXXiHblW8gANl62PBBmIaG6u0zGKCv/AwjzhyHgf2Jf8yYEK
         ZgLW2uv/wyKVbOXs9r08fgQX1FwUwsdOuerCucSbKQsPGNxnLP1uW+3k/Vs5HtWp3f2S
         2sxw==
X-Gm-Message-State: AOJu0Yy10K9ctcTepUmYX0IwuNI35DgJvUH2Q8+/QZhVtvNX+cdbcveR
        YX0yhXGoP/f7ce2HJLPXnS6dHw==
X-Google-Smtp-Source: AGHT+IHg7NIAL+/vq1uVaLXguXuYCzXyJKM8i2wy6dmakFvVWfsSo7C499cy58klAxaY3feF/mh9VA==
X-Received: by 2002:a05:6a21:164a:b0:151:7d4c:899c with SMTP id no10-20020a056a21164a00b001517d4c899cmr3632385pzb.25.1698183682801;
        Tue, 24 Oct 2023 14:41:22 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c21200b001c5f7e06256sm7861055pll.152.2023.10.24.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:41:22 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Michael Walle <mwalle@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] dt-bindings: mtd: binman-partitions: Add alignment properties
Date:   Wed, 25 Oct 2023 10:39:18 +1300
Message-ID: <20231024213940.3590507-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024213940.3590507-1-sjg@chromium.org>
References: <20231024213940.3590507-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three properties for controlling alignment of partitions, aka
'entries' in binman.

For now there is no explicit mention of hierarchy, so a 'section' is
just the 'binman' node.

These new properties are inputs to the packaging process, but are also
needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they are provided as part of
the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add value ranges
- Consistently mention alignment must be power-of-2
- Mention that alignment refers to bytes

Changes in v2:
- Fix 'a' typo in commit message

 .../mtd/partitions/binman-partition.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
index 37a413464b0ce5..cb1edd83ed29a9 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -29,6 +29,57 @@ properties:
         - u-boot       # u-boot.bin from U-Boot project
         - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
 
+  align:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry in bytes.
+
+      The entry offset is adjusted so that the entry starts on an aligned
+      boundary within the containing section or image. For example ‘align =
+      <16>’ means that the entry will start on a 16-byte boundary. This may
+      mean that padding is added before the entry. The padding is part of
+      the containing section but is not included in the entry, meaning that
+      an empty space may be created before the entry starts. Alignment
+      must be a power of 2. If ‘align’ is not provided, no alignment is
+      performed.
+
+  align-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry size in bytes. It must be a power
+      of 2.
+
+      For example, to ensure that the size of an entry is a multiple of 64
+      bytes, set this to 64. While this does not affect the contents of the
+      entry within binman itself (the padding is performed only when its
+      parent section is assembled), the end result is that the entry ends
+      with the padding bytes, so may grow. If ‘align-size’ is not provided,
+      no alignment is performed.
+
+  align-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment (in bytes) of the end of an entry with respect
+      to the containing section. It must be a power of 2.
+
+      Some entries require that they end on an alignment boundary,
+      regardless of where they start. This does not move the start of the
+      entry, so the contents of the entry will still start at the beginning.
+      But there may be padding at the end. While this does not affect the
+      contents of the entry within binman itself (the padding is performed
+      only when its parent section is assembled), the end result is that the
+      entry ends with the padding bytes, so may grow. If ‘align-end’ is not
+      provided, no alignment is performed.
+
 additionalProperties: false
 
 examples:
@@ -41,10 +92,13 @@ examples:
         partition@100000 {
             compatible = "u-boot";
             reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
         };
 
         partition@200000 {
             compatible = "tfa-bl31";
             reg = <0x200000 0x100000>;
+            align = <0x4000>;
         };
     };
-- 
2.42.0.758.gaed0368e0e-goog

