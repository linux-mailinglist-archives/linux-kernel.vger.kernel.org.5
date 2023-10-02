Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9C7B599A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbjJBRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjJBRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:50:39 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F10D9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:50:36 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3528bc102adso4345ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269036; x=1696873836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LS+wV2LMgqbRwabaSq2Ufumv4REcBt1Upfkm2T5IrI=;
        b=DqkqQNHY+IYCf5HSOOaD7V6EJeYSbQtKl8QekIsJSKyuaQ/EGirQQTeIpNTXmBPoRT
         e6PRPFMHvDW2FIBrWxZvb8ZRI5ahd95e1sTG4Mh0XRyhOueMSHzFfjGUXfyjtktVFVYP
         xmzNSCnoP5/SnYP7+F9iSP1BQpclhObVYNqYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269036; x=1696873836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LS+wV2LMgqbRwabaSq2Ufumv4REcBt1Upfkm2T5IrI=;
        b=dq+cXkeNPEzkcdVu1w+IYPCoNH+30VQLqa/5AHRm1hd/qyAxPP2O8vsfKJI2oyaMYS
         l9xPbbHWH1ebASEydMdqng4GeQZC1Y9ALr2wOA2ZHXucvc8Hd/PuOUy2KHwBH/P+vyHC
         sM2O1SKjltkdo5anCH+lE/Wjqr+Ve2F6P9xK8K1eqSYg0u005YCZUqB6WHjwsGp+dwde
         yA/sbkLQ2CrRWOGYK0XAe7H0GYWXaENAEpCHKCmPbtVr7nvH1bkxSE9PhmvfV0KRf4oR
         Oi1TvLytCsoulBoDpiprVHVYAkKmSUk/WKhyCA6kCPNTud4uyOan6b2r+YyXbuKCPyPW
         sq1g==
X-Gm-Message-State: AOJu0Yz9t6InqBFmquPxU2qOt06I6j1emLe5mA+0h/M1lVUXZ8dBO/e9
        nBNb5fn52NEAdoyUwSzfG9AAMQ==
X-Google-Smtp-Source: AGHT+IEB8T0cVFcTkDZ346OUm4Ky/z+eBGTNEVGMP1RopagjT/hUSHBfrulem4VbVa2WRYXv7OLtOg==
X-Received: by 2002:a05:6e02:1d16:b0:349:3756:b1ce with SMTP id i22-20020a056e021d1600b003493756b1cemr14675384ila.2.1696269035979;
        Mon, 02 Oct 2023 10:50:35 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:63cd:2673:520:2e9])
        by smtp.gmail.com with ESMTPSA id s23-20020a02c517000000b0042b2e309f97sm6919562jam.177.2023.10.02.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:50:35 -0700 (PDT)
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
Subject: [PATCH v2 3/3] dt-bindings: mtd: binman-partitions: Add alignment properties
Date:   Mon,  2 Oct 2023 11:49:42 -0600
Message-ID: <20231002174948.1015223-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002174948.1015223-1-sjg@chromium.org>
References: <20231002174948.1015223-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add three properties for controlling alignment of partitions, aka
'entries' in binman.

For now there is no explicit mention of hierarchy, so a 'section' is
just the 'fixed-partitions' node.

These new properties are inputs to the packaging process, but are also
needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they are provided as part of
the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix 'a' typo in commit message

 .../mtd/partitions/binman-partition.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
index 406a8997d3e4..be7273a4c9ac 100644
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
         partition@100000 {
             label = "u-boot";
             reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
         };
 
         partition@200000 {
             label = "atf-bl31";
             reg = <0x200000 0x100000>;
+            align = <0x4000>;
         };
     };
-- 
2.42.0.582.g8ccd20d70d-goog

