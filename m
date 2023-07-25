Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0447608B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGYEi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGYEi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:38:56 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824710D1;
        Mon, 24 Jul 2023 21:38:54 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-63d0f62705dso5912776d6.0;
        Mon, 24 Jul 2023 21:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690259934; x=1690864734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to0ZqeoMS9cOMLpLlEax7c1/5oKN+/3gMdofXFZUUPo=;
        b=V9buO518vlgvqy0QbRMypV1+GVKBUsoMT4zSYGH17v02DDGlvlvo0TZKidqz5jB2Ye
         jE2BIzNWqtJkXcRmKqXMwFPuh2cKXRVN/Rj33NeiJYIYbt5hORgd0iDDuh1Yg667YxsV
         RWNRv3nvsd1IP71QHZt2UOIPPxDM3KyR5CKW7KIAYjzudjMFHxuIhhoug8gipWXsT988
         4FYGeITxL1GexiwUDbfOzijeU4fxedfsFfgYrMnweQ3xu3iiJ1sm4yVstF6cRffU5tJw
         uc6hkwtaW653TQ4eq2+JFwY9/fWMp1+hZxFLpf7Yuvhq1UdlpP5Rl0UgfeJV1OkN1HRL
         Cghg==
X-Gm-Message-State: ABy/qLZB2qXlay0/yEDfTw/0+j9/V/wKPxarIj8XR+qvIJTJaZ0buz5T
        X6bjH2uRKfOJUmrj/RLs6jEZQs7N/FcAB4V4
X-Google-Smtp-Source: APBJJlGrshfAi/w84P5yGeLE4VeC2hEMZFXulQzp+++J2675VyHWA8Djqejqs4bRtxzxbnnkHR9Yjg==
X-Received: by 2002:a0c:f404:0:b0:631:fa2e:249f with SMTP id h4-20020a0cf404000000b00631fa2e249fmr1720031qvl.61.1690259933621;
        Mon, 24 Jul 2023 21:38:53 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id d26-20020a0caa1a000000b0063631be090csm4104445qvb.125.2023.07.24.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:38:52 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] docs: move mips under arch
Date:   Tue, 25 Jul 2023 07:38:03 +0300
Message-ID: <20230725043835.2249678-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 Documentation/{ => arch}/mips/booting.rst                     | 0
 Documentation/{ => arch}/mips/features.rst                    | 0
 Documentation/{ => arch}/mips/index.rst                       | 0
 Documentation/{ => arch}/mips/ingenic-tcu.rst                 | 0
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 2 +-
 Documentation/translations/zh_CN/arch/index.rst               | 2 +-
 Documentation/translations/zh_CN/{ => arch}/mips/booting.rst  | 4 ++--
 Documentation/translations/zh_CN/{ => arch}/mips/features.rst | 4 ++--
 Documentation/translations/zh_CN/{ => arch}/mips/index.rst    | 4 ++--
 .../translations/zh_CN/{ => arch}/mips/ingenic-tcu.rst        | 4 ++--
 MAINTAINERS                                                   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename Documentation/{ => arch}/mips/booting.rst (100%)
 rename Documentation/{ => arch}/mips/features.rst (100%)
 rename Documentation/{ => arch}/mips/index.rst (100%)
 rename Documentation/{ => arch}/mips/ingenic-tcu.rst (100%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/booting.rst (92%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/features.rst (65%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/ingenic-tcu.rst (97%)

diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index d39504fae12c..84b80255b851 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -15,7 +15,7 @@ implementation.
    ia64/index
    loongarch/index
    m68k/index
-   ../mips/index
+   mips/index
    nios2/index
    openrisc/index
    parisc/index
diff --git a/Documentation/mips/booting.rst b/Documentation/arch/mips/booting.rst
similarity index 100%
rename from Documentation/mips/booting.rst
rename to Documentation/arch/mips/booting.rst
diff --git a/Documentation/mips/features.rst b/Documentation/arch/mips/features.rst
similarity index 100%
rename from Documentation/mips/features.rst
rename to Documentation/arch/mips/features.rst
diff --git a/Documentation/mips/index.rst b/Documentation/arch/mips/index.rst
similarity index 100%
rename from Documentation/mips/index.rst
rename to Documentation/arch/mips/index.rst
diff --git a/Documentation/mips/ingenic-tcu.rst b/Documentation/arch/mips/ingenic-tcu.rst
similarity index 100%
rename from Documentation/mips/ingenic-tcu.rst
rename to Documentation/arch/mips/ingenic-tcu.rst
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 2d14610888a7..585b5f5217c4 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -8,7 +8,7 @@ title: Ingenic SoCs Timer/Counter Unit (TCU)
 
 description: |
   For a description of the TCU hardware and drivers, have a look at
-  Documentation/mips/ingenic-tcu.rst.
+  Documentation/arch/mips/ingenic-tcu.rst.
 
 maintainers:
   - Paul Cercueil <paul@crapouillou.net>
diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
index d4c1c729dde2..e3d273d7d599 100644
--- a/Documentation/translations/zh_CN/arch/index.rst
+++ b/Documentation/translations/zh_CN/arch/index.rst
@@ -8,7 +8,7 @@
 .. toctree::
    :maxdepth: 2
 
-   ../mips/index
+   mips/index
    arm64/index
    ../riscv/index
    openrisc/index
diff --git a/Documentation/translations/zh_CN/mips/booting.rst b/Documentation/translations/zh_CN/arch/mips/booting.rst
similarity index 92%
rename from Documentation/translations/zh_CN/mips/booting.rst
rename to Documentation/translations/zh_CN/arch/mips/booting.rst
index e0bbd3f20862..485b57e0ca0b 100644
--- a/Documentation/translations/zh_CN/mips/booting.rst
+++ b/Documentation/translations/zh_CN/arch/mips/booting.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/mips/booting.rst
+:Original: Documentation/arch/mips/booting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/mips/features.rst b/Documentation/translations/zh_CN/arch/mips/features.rst
similarity index 65%
rename from Documentation/translations/zh_CN/mips/features.rst
rename to Documentation/translations/zh_CN/arch/mips/features.rst
index b61dab06ceaf..da1b956e4a40 100644
--- a/Documentation/translations/zh_CN/mips/features.rst
+++ b/Documentation/translations/zh_CN/arch/mips/features.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/mips/features.rst
+:Original: Documentation/arch/mips/features.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/mips/index.rst b/Documentation/translations/zh_CN/arch/mips/index.rst
similarity index 79%
rename from Documentation/translations/zh_CN/mips/index.rst
rename to Documentation/translations/zh_CN/arch/mips/index.rst
index 192c6adbb72e..2a34217119ea 100644
--- a/Documentation/translations/zh_CN/mips/index.rst
+++ b/Documentation/translations/zh_CN/arch/mips/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/mips/index.rst
+:Original: Documentation/arch/mips/index.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst b/Documentation/translations/zh_CN/arch/mips/ingenic-tcu.rst
similarity index 97%
rename from Documentation/translations/zh_CN/mips/ingenic-tcu.rst
rename to Documentation/translations/zh_CN/arch/mips/ingenic-tcu.rst
index ddbe149c517b..3d599a36b571 100644
--- a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
+++ b/Documentation/translations/zh_CN/arch/mips/ingenic-tcu.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/mips/ingenic-tcu.rst
+:Original: Documentation/arch/mips/ingenic-tcu.rst
 
 :翻译:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c650179159f..d1d8a9745761 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14215,7 +14215,7 @@ W:	http://www.linux-mips.org/
 Q:	https://patchwork.kernel.org/project/linux-mips/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 F:	Documentation/devicetree/bindings/mips/
-F:	Documentation/mips/
+F:	Documentation/arch/mips/
 F:	arch/mips/
 F:	drivers/platform/mips/
 F:	include/dt-bindings/mips/
-- 
2.41.0

