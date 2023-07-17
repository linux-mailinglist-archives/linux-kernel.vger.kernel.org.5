Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24C7565FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGQOOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGQOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:14:18 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EAF7;
        Mon, 17 Jul 2023 07:14:16 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-986d8332f50so602793866b.0;
        Mon, 17 Jul 2023 07:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603255; x=1692195255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVQUDvbd72HzDaHvGqRQhZSUCDSNH5EztpgqmZj5nDA=;
        b=iZDixxI8+iEB0Zic1xhasmqK30siTVVTEHJxunp+qjeQzq+JbIo3dtDCFjvtK3x34d
         EwHwT8EfIcJTRpzS2IN8lPq2Ct5aE+SQTGnsvv24K71+6CyDTetqQHismO075bmaET9S
         /qcgt/+34Bmk9/juC2cCq1L+remqikQX6dumcXkvLHQZpoYYtzOSGHwscylqVLESnkrP
         urojDJ6xNwyOBR8tH1me6Q+mvjC/FdoMEBUtuSB0UXDMrA3q4IpdT/jy7tQijGY/Fsoe
         YRS/GumCHHfRrFuKMMm2uc1FLlbHsyQnOF/Pf11h4J8K+2QXiugf13aVkiF35NPrPZj5
         qyBQ==
X-Gm-Message-State: ABy/qLaymNmlm2j7JsbaroI37YYue8l0R9Yjh3xK4bsDq/LRHDoWuF4e
        RKBs7opA9E4FeI1FDF9rIXw=
X-Google-Smtp-Source: APBJJlEiUt/azu00EPizNVjp4L7pGfhIMBhDaPKIATmoDXYE3E+04oQCvGeSItuttfZErZDf65VeIQ==
X-Received: by 2002:a17:906:d965:b0:992:b020:ce4 with SMTP id rp5-20020a170906d96500b00992b0200ce4mr9741129ejb.51.1689603255066;
        Mon, 17 Jul 2023 07:14:15 -0700 (PDT)
Received: from costa-tp.bos2.lab ([77.137.71.188])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906d19a00b0098e16f8c198sm9381796ejz.18.2023.07.17.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:14:14 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        loongarch@lists.linux.dev (open list:LOONGARCH)
Subject: [PATCH v2] docs: move loongarch under arch
Date:   Mon, 17 Jul 2023 17:13:13 +0300
Message-ID: <20230717141345.431342-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87mszuwt4r.fsf@meer.lwn.net>
References: <87mszuwt4r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

Changes:
- added fix of MAINTAINERS and drivers/irqchip/Kconfig 

I'll continue with the rest architectures.
Thank you.


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
 MAINTAINERS                                                   | 4 ++--
 drivers/irqchip/Kconfig                                       | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d0ccb621a660..b68512f1b65f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12282,8 +12282,8 @@ R:	WANG Xuerui <kernel@xen0n.name>
 L:	loongarch@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
-F:	Documentation/loongarch/
-F:	Documentation/translations/zh_CN/loongarch/
+F:	Documentation/arch/loongarch/
+F:	Documentation/translations/zh_CN/arch/loongarch/
 F:	arch/loongarch/
 F:	drivers/*/*loongarch*
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4b9036c6d45b..5e54032f07c6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -567,7 +567,7 @@ config IRQ_LOONGARCH_CPU
 	help
 	  Support for the LoongArch CPU Interrupt Controller. For details of
 	  irq chip hierarchy on LoongArch platforms please read the document
-	  Documentation/loongarch/irq-chip-model.rst.
+	  Documentation/arch/oongarch/irq-chip-model.rst.
 
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
-- 
2.41.0

