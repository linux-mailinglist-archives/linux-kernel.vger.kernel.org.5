Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2697D765A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjJYVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjJYVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:07:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA90185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso1195215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698268019; x=1698872819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IdohqfpG/gdF3wirCpdcxePGouLjdXX9N31xMFKe2w=;
        b=Cxrl5WomlT0YHCrxWtMnpWW98T9vagBhfjWbFE/o/MfO/yH5O/qhPMEG0k+AFwAr6h
         paCPGXiPn0HE3cwhXd265qaXgK2yrQSkWFA/NUBKJ1x/KeRBcRxIObjoqqkTcBvnQeAr
         HIgx3BtvaNGwwcVx0i6KjErTWm90Sqlv7slaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698268019; x=1698872819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IdohqfpG/gdF3wirCpdcxePGouLjdXX9N31xMFKe2w=;
        b=JSSeObRouH8aX30dfvBE3uug9yzNKi39/eSIkd0IYirj5mMNF7nrycGioiNJd/XPWP
         vM6Xtl21SqaTrR1YYb63x1EcT9Zu+TRNHUle2qu8ZdyAJ4oUGLqWdiIx0wEfiGbzThTf
         tvTFGIWSxwJ6CkWhnqjGRL+Nbdwrt2mWU51idJ2MWOeLMDU1y7Z30mHRqLCo4lsHHKag
         r619apvuezpWtDCWLRQFQkps2/Glgm6svEqjzsR8TvlCmBv33pRB40zT1jfaVo3h48nj
         d8CjJOJu7hUd+h6ufmsMUG869f3zyQ9mjkaOgXaT+AnYj/7+9Bd44Yjzju2nBp9sIM5Y
         l6cw==
X-Gm-Message-State: AOJu0YyKasrXFLHTwTQS3GJzOq+BWyFzsSl/KnZb4blVrLfRWz6/yCqt
        bIjNBSBRIWgsjLpvwFHtpYWMsw==
X-Google-Smtp-Source: AGHT+IFnYu/xqKemRScJTcQjBe6USxgn3fG2r+kl8UXZa4BqRGhtLWHTLuta2cTb0ciL0LID92X1Rw==
X-Received: by 2002:a17:903:110d:b0:1c9:e508:ad43 with SMTP id n13-20020a170903110d00b001c9e508ad43mr15865350plh.8.1698268019179;
        Wed, 25 Oct 2023 14:06:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001bc5dc0cd75sm9689447plb.180.2023.10.25.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:06:58 -0700 (PDT)
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
Subject: [PATCH v6 3/3] dt-bindings: mtd: binman-partitions: Add alignment properties
Date:   Thu, 26 Oct 2023 10:06:12 +1300
Message-ID: <20231025210616.3201502-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025210616.3201502-1-sjg@chromium.org>
References: <20231025210616.3201502-1-sjg@chromium.org>
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

Changes in v6:
- Correct schema-validation errors missed due to older dt-schema
  (enum fix and reg addition)

Changes in v5:
- Add value ranges
- Consistently mention alignment must be power-of-2
- Mention that alignment refers to bytes

Changes in v2:
- Fix 'a' typo in commit message

 .../mtd/partitions/binman-partition.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
index 83222ac9aa78..2bc80c24bb9b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -33,6 +33,57 @@ properties:
     minItems: 1
     maxItems: 2
 
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
@@ -45,10 +96,13 @@ examples:
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

