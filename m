Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC9755C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGQHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGQHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:07:22 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA081AE;
        Mon, 17 Jul 2023 00:07:21 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so6329224a12.1;
        Mon, 17 Jul 2023 00:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689577640; x=1692169640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK34qhMsmNxAvU6AATspLEoQD1LgYJ16sQOnvySU0Tk=;
        b=L9f810MvBcRXGkxjXA+eVigVNRHFQfkIsRRuBSxKVpNDMXXplgZ3g9TBFlyHOZ8oes
         sIU3ULDI8B5Bk1qMUmyu21hxbvh5VIOV7Jkg6Gj2AkmrLx87HSzDJO1877ZkmRQJYCBI
         A+GcwdhqnhtK6dLN85kTtL3lyxIwYIX6te1MESw6gZ1cTdJLvaFpBaIiB4hdtiG+ucic
         WAhzXSCAixFvKVp5Zz/cWFltzNEXg4J1m4urdZjt1qBG772GtGrCrx95QeEU56QqkUPD
         hxYqkVvXA0ThUwa4y837Oc6waxEvgr+5MNbdht9oLfZBe6afwDVV+xjjN57Dn1c3B/76
         /G+A==
X-Gm-Message-State: ABy/qLb3YmVnjEkp8uCbJn18XsGlqYWcys+Lh0Pf7T7muvIuVGy+T/C4
        Ed9PtornbVEnlPjR3ad958g=
X-Google-Smtp-Source: APBJJlFDRZd4z0vXM1uFEVX+Tzb98q56LccSwBq3J5YUVfGWisydG4D+RmxfN/eezcIik1xYEHSjxQ==
X-Received: by 2002:a50:fc1a:0:b0:51b:fbf3:d9a7 with SMTP id i26-20020a50fc1a000000b0051bfbf3d9a7mr10667509edr.39.1689577639646;
        Mon, 17 Jul 2023 00:07:19 -0700 (PDT)
Received: from costa-tp.bos2.lab ([5.29.20.9])
        by smtp.gmail.com with ESMTPSA id a19-20020a50ff13000000b0051bed498851sm9513311edu.54.2023.07.17.00.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 00:07:19 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wu XiangCheng <bobwxc@email.cn>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        loongarch@lists.linux.dev (open list:LOONGARCH)
Subject: [PATCH] docs: move loongarch under arch
Date:   Mon, 17 Jul 2023 10:06:02 +0300
Message-ID: <20230717070643.313689-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and fix all in-tree references.

Architecture-specific documentation is being moved into Documentation/arch/
as a way of cleaning up the top-level documentation directory and making
the docs hierarchy more closely match the source hierarchy.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/arch/index.rst                                  | 2 +-
 Documentation/{ => arch}/loongarch/booting.rst                | 0
 Documentation/{ => arch}/loongarch/features.rst               | 0
 Documentation/{ => arch}/loongarch/index.rst                  | 0
 Documentation/{ => arch}/loongarch/introduction.rst           | 0
 Documentation/{ => arch}/loongarch/irq-chip-model.rst         | 0
 Documentation/translations/zh_CN/arch/index.rst               | 2 +-
 .../translations/zh_CN/{ => arch}/loongarch/booting.rst       | 4 ++--
 .../translations/zh_CN/{ => arch}/loongarch/features.rst      | 4 ++--
 .../translations/zh_CN/{ => arch}/loongarch/index.rst         | 4 ++--
 .../translations/zh_CN/{ => arch}/loongarch/introduction.rst  | 4 ++--
 .../zh_CN/{ => arch}/loongarch/irq-chip-model.rst             | 4 ++--
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename Documentation/{ => arch}/loongarch/booting.rst (100%)
 rename Documentation/{ => arch}/loongarch/features.rst (100%)
 rename Documentation/{ => arch}/loongarch/index.rst (100%)
 rename Documentation/{ => arch}/loongarch/introduction.rst (100%)
 rename Documentation/{ => arch}/loongarch/irq-chip-model.rst (100%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/booting.rst (94%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/features.rst (61%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/index.rst (78%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/introduction.rst (99%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/irq-chip-model.rst (98%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 8458b88e9b79..4b6b1beebad6 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -13,7 +13,7 @@ implementation.
    arm/index
    arm64/index
    ia64/index
-   ../loongarch/index
+   loongarch/index
    m68k/index
    ../mips/index
    nios2/index
diff --git a/Documentation/loongarch/booting.rst b/Documentation/arch/loongarch/booting.rst
similarity index 100%
rename from Documentation/loongarch/booting.rst
rename to Documentation/arch/loongarch/booting.rst
diff --git a/Documentation/loongarch/features.rst b/Documentation/arch/loongarch/features.rst
similarity index 100%
rename from Documentation/loongarch/features.rst
rename to Documentation/arch/loongarch/features.rst
diff --git a/Documentation/loongarch/index.rst b/Documentation/arch/loongarch/index.rst
similarity index 100%
rename from Documentation/loongarch/index.rst
rename to Documentation/arch/loongarch/index.rst
diff --git a/Documentation/loongarch/introduction.rst b/Documentation/arch/loongarch/introduction.rst
similarity index 100%
rename from Documentation/loongarch/introduction.rst
rename to Documentation/arch/loongarch/introduction.rst
diff --git a/Documentation/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
similarity index 100%
rename from Documentation/loongarch/irq-chip-model.rst
rename to Documentation/arch/loongarch/irq-chip-model.rst
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index 6fa0cb671009..d4c1c729dde2 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -13,7 +13,7 @@
    ../riscv/index
    openrisc/index
    parisc/index
-   ../loongarch/index
+   loongarch/index
 
 TODOList:
 
diff --git a/Documentation/translations/zh_CN/loongarch/booting.rst b/Documentation/translations/zh_CN/arch/loongarch/booting.rst
similarity index 94%
rename from Documentation/translations/zh_CN/loongarch/booting.rst
rename to Documentation/translations/zh_CN/arch/loongarch/booting.rst
index fb6440c438f0..d2f55872904e 100644
--- a/Documentation/translations/zh_CN/loongarch/booting.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/booting.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/loongarch/booting.rst
+:Original: Documentation/arch/loongarch/booting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/loongarch/features.rst b/Documentation/translations/zh_CN/arch/loongarch/features.rst
similarity index 61%
rename from Documentation/translations/zh_CN/loongarch/features.rst
rename to Documentation/translations/zh_CN/arch/loongarch/features.rst
index 3886e635ec06..82bfac180bdc 100644
--- a/Documentation/translations/zh_CN/loongarch/features.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/features.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/loongarch/features.rst
+:Original: Documentation/arch/loongarch/features.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
 .. kernel-feat:: $srctree/Documentation/features loongarch
diff --git a/Documentation/translations/zh_CN/loongarch/index.rst b/Documentation/translations/zh_CN/arch/loongarch/index.rst
similarity index 78%
rename from Documentation/translations/zh_CN/loongarch/index.rst
rename to Documentation/translations/zh_CN/arch/loongarch/index.rst
index 0273a08342f7..4bd24f5ffed1 100644
--- a/Documentation/translations/zh_CN/loongarch/index.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/loongarch/index.rst
+:Original: Documentation/arch/loongarch/index.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
 =================
diff --git a/Documentation/translations/zh_CN/loongarch/introduction.rst b/Documentation/translations/zh_CN/arch/loongarch/introduction.rst
similarity index 99%
rename from Documentation/translations/zh_CN/loongarch/introduction.rst
rename to Documentation/translations/zh_CN/arch/loongarch/introduction.rst
index 470c38ae2caf..cba04befc950 100644
--- a/Documentation/translations/zh_CN/loongarch/introduction.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/introduction.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/loongarch/introduction.rst
+:Original: Documentation/arch/loongarch/introduction.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
 =============
diff --git a/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
similarity index 98%
rename from Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
rename to Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
index fb5d23b49ed5..f1e9ab18206c 100644
--- a/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/loongarch/irq-chip-model.rst
+:Original: Documentation/arch/loongarch/irq-chip-model.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
 ==================================
-- 
2.41.0

