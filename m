Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13BF7B0D41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjI0UVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjI0UVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:21:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6181E10A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:21:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35135f69de2so25519225ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695846071; x=1696450871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/WPzSaDS9c+jiadSigu8kAq3wHnfTKelNMfiF3LTzM=;
        b=NFPIdVfVm9Cs8hzkeVsa84P9bc5aJOExpVnEr16PwbTM5gi6VTllZdBDI14c/F79th
         MaCLFOXmFm1SVOfSy0WA8RpUwNjX4/R2AP2/dUX3ZwpMc7BtoaN0qQzqkhXHodiHreQO
         I4TJllASEqF6WEezGq0r0+0ZqkUH6f4DjQ7o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695846071; x=1696450871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/WPzSaDS9c+jiadSigu8kAq3wHnfTKelNMfiF3LTzM=;
        b=mq8h/k4y7IzsYN2l7VwO4Ba2kr74ErOsBX1m+I5Tgf9+hf+2JPzMHDjPS7KpudBr4F
         tHKtO5rTNrXCOE4qVVx70m8gwn8l8h3qHu7aCkoAVuhvQ1y3qJOv0yX21Yfw+qUDSsD6
         f7pCdo96ecKi7k0Tnc6zeSRPLM9LZjOWlp4989GbytmzdDF0ISHyR/+9pGflm20ZOWc8
         ChYDR+4IOwa5qSyyXyVI4WE+90NqcxhjgrBDmeGqLc99K3HzSg2JHElvwhKYazC7TDK+
         ZI78YpSXv6ashXRZiz/7x8h3lcvGcyPAL4sHJFq3LU/eIueEfhHHfs+vl0T6M6Q0U7y9
         P5YA==
X-Gm-Message-State: AOJu0YyY06p3uld/7sctiygp8CtYY4z2xgbtPhUf7ji1nMzqcCRVWgVa
        YXxktRFydOKXA2r01bcsRH3HFhANyTj//r4/Ns0=
X-Google-Smtp-Source: AGHT+IFRbrRAe8Dnju3UVQpeWZ5Tyu9bkia5NuOv1VLGeo8FMF3tFtAq/tcjBk0rXfAM+4qlRibD1A==
X-Received: by 2002:a92:ca0b:0:b0:34c:e7a3:894 with SMTP id j11-20020a92ca0b000000b0034ce7a30894mr4107520ils.16.1695846070751;
        Wed, 27 Sep 2023 13:21:10 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
        by smtp.gmail.com with ESMTPSA id ei15-20020a05663829af00b0042fec8620e4sm4113299jab.57.2023.09.27.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 13:21:10 -0700 (PDT)
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
Subject: [PATCH 3/3] dt-bindings: mtd: binman-partitions: Add alignment properties
Date:   Wed, 27 Sep 2023 14:20:53 -0600
Message-ID: <20230927202057.3676497-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230927202057.3676497-1-sjg@chromium.org>
References: <20230927202057.3676497-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three properties for controlling alignment of partitions, aka
'entries' in binman.

For now there is no explicit mention of hierarchy, so a 'section' is
just the 'fixed-partitions' node.

These new properties are inputs to the packaging process, but are also
needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they a provided as part of the
schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../mtd/partitions/binman-partition.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
index 6ee832cb4c4c..9cd424447e76 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -27,6 +27,42 @@ properties:
         - u-boot       # u-boot.bin from U-Boot projec6t
         - atf-bl31     # bl31.bin or bl31.elf from TF-A project
 
+  align:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This sets the alignment of the entry. The entry offset is adjusted
+      so that the entry starts on an aligned boundary within the containing
+      section or image. For example ‘align = <16>’ means that the entry will
+      start on a 16-byte boundary. This may mean that padding is added before
+      the entry. The padding is part of the containing section but is not
+      included in the entry, meaning that an empty space may be created before
+      the entry starts. Alignment should be a power of 2. If ‘align’ is not
+      provided, no alignment is performed.
+
+  align-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This sets the alignment of the entry size. For example, to ensure
+      that the size of an entry is a multiple of 64 bytes, set this to 64.
+      While this does not affect the contents of the entry within binman
+      itself (the padding is performed only when its parent section is
+      assembled), the end result is that the entry ends with the padding
+      bytes, so may grow. If ‘align-size’ is not provided, no alignment is
+      performed.
+
+  align-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This sets the alignment of the end of an entry with respect to the
+      containing section. Some entries require that they end on an alignment
+      boundary, regardless of where they start. This does not move the start
+      of the entry, so the contents of the entry will still start at the
+      beginning. But there may be padding at the end. While this does not
+      affect the contents of the entry within binman itself (the padding is
+      performed only when its parent section is assembled), the end result is
+      that the entry ends with the padding bytes, so may grow. If ‘align-end’
+      is not provided, no alignment is performed.
+
 additionalProperties: false
 
 examples:
@@ -39,10 +75,13 @@ examples:
         partition-u-boot@100000 {
             label = "u-boot";
             reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
         };
 
         partition-atf-bl31t@200000 {
             label = "atf-bl31";
             reg = <0x200000 0x100000>;
+            align = <0x4000>;
         };
     };
-- 
2.42.0.515.g380fc7ccd1-goog

