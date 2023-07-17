Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D8756D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGQTZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:25:36 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442D1B1;
        Mon, 17 Jul 2023 12:25:32 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-403f3890a8eso4055161cf.3;
        Mon, 17 Jul 2023 12:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621931; x=1692213931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxmyMfhYMNFgB+irOERGNsRiBqoXurjZjWBXr/t1e0o=;
        b=MKc312g5viiyWrhiQEW2UsNdiXTuLhwmmCSSd5/kYkJnXDzrCSh5koVFhivdK7T1Dm
         /bcGeUgEV6sbZWBwcRnoLc3p2qtRf+5SK28O4yaDytSkzMlW8aiWgbg65XAHpaqU8MhM
         E8GPrxlPB2zv04JTaWNCV2H9ffSMoeoyB9shuhnkiTu8FudH2lUY0l0FQzWXe7YkYh3n
         5SN8T68xwsQHAb33Y83Fbc90RDOeLeYoWwEtMIoxmViG/mTbWi1MXPSesCuQ2hksBU2s
         vrJuaem4rkg8Ofg/M/Xvcoy0yQRPcn5Gl6rzLyyDzAL6+EyTyuaOICd416DpXdGJA68J
         UR/A==
X-Gm-Message-State: ABy/qLasuRO7me+/ZenF61NSXNuM0qk1WqUnvPFHeqq837N71dCslcEr
        Fs6cws04tIa0kRxwiNNlnjHLPX3oPDh68UV2
X-Google-Smtp-Source: APBJJlHIeiFlNQLQ3Oc1I7RZzdEmHwFhnwR+JIB+IskmOTGNsbQXSFVwU3c5Pln+MbqR+K1C9nZjRQ==
X-Received: by 2002:ac8:5989:0:b0:400:97c6:b40b with SMTP id e9-20020ac85989000000b0040097c6b40bmr18029663qte.48.1689621931312;
        Mon, 17 Jul 2023 12:25:31 -0700 (PDT)
Received: from costa-tp.bos2.lab ([5.29.20.9])
        by smtp.gmail.com with ESMTPSA id x14-20020ac86b4e000000b0040346ce43a5sm83026qts.44.2023.07.17.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:25:30 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wu XiangCheng <bobwxc@email.cn>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        loongarch@lists.linux.dev (open list:LOONGARCH)
Subject: [PATCH v3] docs: move loongarch under arch
Date:   Mon, 17 Jul 2023 22:24:27 +0300
Message-ID: <20230717192456.453124-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87edl6wr9p.fsf@meer.lwn.net>
References: <87edl6wr9p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes:
v3: fixed typo in drivers/irqchip/Kconfig
v2: added fix of MAINTAINERS and drivers/irqchip/Kconfig

I'll continue with the rest architectures.
Thank you.
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
index 4b9036c6d45b..f7149d0f3d45 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -567,7 +567,7 @@ config IRQ_LOONGARCH_CPU
 	help
 	  Support for the LoongArch CPU Interrupt Controller. For details of
 	  irq chip hierarchy on LoongArch platforms please read the document
-	  Documentation/loongarch/irq-chip-model.rst.
+	  Documentation/arch/loongarch/irq-chip-model.rst.
 
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
-- 
2.41.0

