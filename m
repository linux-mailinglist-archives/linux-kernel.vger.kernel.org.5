Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3137ACF72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjIYFXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:23:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF0B3;
        Sun, 24 Sep 2023 22:23:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-690d2441b95so4140643b3a.1;
        Sun, 24 Sep 2023 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695619412; x=1696224212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTpXPSlaMWh7L1UhsC5ZBhwtKqw9NXEiyiTmp0Bz6VY=;
        b=bIb5LkSr4FRxOS01fybq0ZYmYoaI0mfBmF+BRrVo+EOpYncFdHXt1OXbQlZGA0dqvT
         f2JeIN6xHTtPGSMAR0yTnsVWonme2/cU9N82AqGLqlKhUO9kzo8W9yudt1L7kyEAp/5c
         tKjyDmKttu7mCmPTDxu6O7jrV0M1aKjAquazoxh4lleSOdeT3VeAVYx9C4ck3UFyLl/m
         4QkZLeKHC7D27PGg1ofDCQnAh96jeEKLjiFWXztVg9q5jtgYPengTxHAh+ihRt1LzIwU
         +qCMeVDyabvcRs8OrBnGrN1TekDD3b7RJQqnGsW1/b06QqbbRXy7axI+BiZ8tRy2eVuC
         aICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695619412; x=1696224212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTpXPSlaMWh7L1UhsC5ZBhwtKqw9NXEiyiTmp0Bz6VY=;
        b=VpauFsF4IBiWK20+JcPyL2dYutBmKdOqFEY37rBMvBiivbo3AiBOcCv2ONqnGlR+WJ
         yNjX5uxfPLrL9V9irTuhmp+a6jUE9Gx1fgfm+NqUnTzko+XewuJgS3gCeLzYmJEpyECB
         vxhIvXhOS7m5+OF0rnoFkHgVQK3B8cHHBXTlJ7Gby9BxJOxWNajHOQZh07k+XgF0CIDC
         vp5CGzZJq2D4T7EpDEbAp97cPnFqNn+qAo2C4fVsFNvNlqE50zsdvYPFjHTeDXD+lTpo
         NUgrIdY2LHgAhkcd/gqPu+iO9LH0s2OJsP8ObD4RBahif4iyAO2QVNMCfKMGDePJrTP2
         3LaQ==
X-Gm-Message-State: AOJu0YzjoDVl/dT/HDwR9dCQPbBtN8M/mzAODXduWlapZxF1xUsgR1Ge
        sKXGdyv/P4ih2cfawnj4ogOsjmFGE4jsOLnu/RI=
X-Google-Smtp-Source: AGHT+IGjkQZxvNDTc4u8TvNrhYdbHaeCQ/TQ6NpcONrybLzmso577sgnG8b2z73FAzQxQjVCSE3JMA==
X-Received: by 2002:a05:6a20:f3a2:b0:15e:f2a1:dae with SMTP id qr34-20020a056a20f3a200b0015ef2a10daemr2573539pzb.27.1695619409872;
        Sun, 24 Sep 2023 22:23:29 -0700 (PDT)
Received: from localhost.localdomain ([111.52.6.74])
        by smtp.gmail.com with ESMTPSA id d20-20020a637354000000b00578bb0066b6sm5874343pgn.71.2023.09.24.22.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 22:23:27 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] docs/zh_TW: update contents for zh_TW
Date:   Mon, 25 Sep 2023 13:23:11 +0800
Message-Id: <20230925052311.20992-1-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of zh_TW was too outdated comparing to the original files.
Consequently carry out improvements in order to both keep track of sources
and fix several grammatical mistakes in traditional Chinese.

This is a thorough rewrite of the previous patch:
    https://lore.kernel.org/linux-doc/20230807120006.6361-1-src.res.211@gmail.com/
in order to get rid of text damage and merging errors, created based on
linux-next (date: Sept. 15, 2023).

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 .../translations/zh_TW/admin-guide/README.rst | 164 ++--
 .../zh_TW/admin-guide/bootconfig.rst          | 294 +++++++
 .../zh_TW/admin-guide/bug-bisect.rst          |  10 +-
 .../zh_TW/admin-guide/bug-hunting.rst         |  38 +-
 .../zh_TW/admin-guide/clearing-warn-once.rst  |   4 +-
 .../zh_TW/admin-guide/cpu-load.rst            |   8 +-
 .../zh_TW/admin-guide/cputopology.rst         |  97 +++
 .../translations/zh_TW/admin-guide/index.rst  | 138 ++--
 .../translations/zh_TW/admin-guide/init.rst   |  38 +-
 .../zh_TW/admin-guide/lockup-watchdogs.rst    |  67 ++
 .../zh_TW/admin-guide/mm/damon/index.rst      |  30 +
 .../zh_TW/admin-guide/mm/damon/lru_sort.rst   | 264 ++++++
 .../zh_TW/admin-guide/mm/damon/reclaim.rst    | 229 ++++++
 .../zh_TW/admin-guide/mm/damon/start.rst      | 125 +++
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 592 ++++++++++++++
 .../zh_TW/admin-guide/mm/index.rst            |  50 ++
 .../translations/zh_TW/admin-guide/mm/ksm.rst | 199 +++++
 .../zh_TW/admin-guide/reporting-issues.rst    | 727 +++++++++--------
 .../admin-guide/reporting-regressions.rst     | 371 +++++++++
 .../zh_TW/admin-guide/security-bugs.rst       |  26 +-
 .../translations/zh_TW/admin-guide/sysrq.rst  | 281 +++++++
 .../zh_TW/admin-guide/tainted-kernels.rst     |  84 +-
 .../zh_TW/admin-guide/unicode.rst             |  10 +-
 .../translations/zh_TW/arch/arm/Booting       | 176 ++++
 .../zh_TW/arch/arm/kernel_user_helpers.txt    | 285 +++++++
 .../translations/zh_TW/arch/arm64/amu.rst     |   6 +-
 .../translations/zh_TW/arch/arm64/booting.txt |  28 +-
 .../zh_TW/arch/arm64/elf_hwcaps.rst           |  10 +-
 .../zh_TW/arch/arm64/legacy_instructions.txt  |  14 +-
 .../translations/zh_TW/arch/arm64/memory.txt  |  16 +-
 .../translations/zh_TW/arch/arm64/perf.rst    |   2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt       |  28 +-
 .../zh_TW/arch/arm64/tagged-pointers.txt      |  10 +-
 .../translations/zh_TW/arch/index.rst         |  30 +
 .../zh_TW/arch/loongarch/booting.rst          |  49 ++
 .../zh_TW/arch/loongarch/features.rst         |   9 +
 .../zh_TW/arch/loongarch/index.rst            |  28 +
 .../zh_TW/arch/loongarch/introduction.rst     | 354 ++++++++
 .../zh_TW/arch/loongarch/irq-chip-model.rst   | 158 ++++
 .../translations/zh_TW/arch/mips/booting.rst  |  35 +
 .../translations/zh_TW/arch/mips/features.rst |  14 +
 .../translations/zh_TW/arch/mips/index.rst    |  30 +
 .../zh_TW/arch/mips/ingenic-tcu.rst           |  73 ++
 .../zh_TW/arch/openrisc/index.rst             |  33 +
 .../zh_TW/arch/openrisc/openrisc_port.rst     | 128 +++
 .../translations/zh_TW/arch/openrisc/todo.rst |  24 +
 .../zh_TW/arch/parisc/debugging.rst           |  46 ++
 .../translations/zh_TW/arch/parisc/index.rst  |  32 +
 .../zh_TW/arch/parisc/registers.rst           | 157 ++++
 .../translations/zh_TW/cpu-freq/core.rst      |  38 +-
 .../zh_TW/cpu-freq/cpu-drivers.rst            | 158 ++--
 .../zh_TW/cpu-freq/cpufreq-stats.rst          |  52 +-
 .../translations/zh_TW/cpu-freq/index.rst     |  13 +-
 .../zh_TW/filesystems/debugfs.rst             |  40 +-
 .../translations/zh_TW/filesystems/index.rst  |   2 +-
 .../translations/zh_TW/filesystems/sysfs.txt  |  14 +-
 .../translations/zh_TW/filesystems/tmpfs.rst  |  32 +-
 .../zh_TW/filesystems/virtiofs.rst            |   8 +-
 Documentation/translations/zh_TW/index.rst    |   5 +-
 .../translations/zh_TW/process/1.Intro.rst    |  78 +-
 .../translations/zh_TW/process/2.Process.rst  | 130 +--
 .../zh_TW/process/3.Early-stage.rst           |  44 +-
 .../translations/zh_TW/process/4.Coding.rst   | 102 +--
 .../translations/zh_TW/process/5.Posting.rst  |  66 +-
 .../zh_TW/process/6.Followthrough.rst         |  46 +-
 .../zh_TW/process/7.AdvancedTopics.rst        |  56 +-
 .../zh_TW/process/8.Conclusion.rst            |  10 +-
 .../code-of-conduct-interpretation.rst        |  52 +-
 .../zh_TW/process/code-of-conduct.rst         |  18 +-
 .../zh_TW/process/coding-style.rst            | 405 ++++++----
 .../zh_TW/process/development-process.rst     |   2 +-
 .../zh_TW/process/email-clients.rst           | 279 ++++---
 .../process/embargoed-hardware-issues.rst     |  74 +-
 .../translations/zh_TW/process/howto.rst      | 142 ++--
 .../translations/zh_TW/process/index.rst      |   5 +-
 .../zh_TW/process/kernel-driver-statement.rst |   3 +-
 .../process/kernel-enforcement-statement.rst  |  14 +-
 .../zh_TW/process/license-rules.rst           |  54 +-
 .../zh_TW/process/magic-number.rst            |   1 +
 .../zh_TW/process/management-style.rst        |  60 +-
 .../zh_TW/process/stable-api-nonsense.rst     |  86 +-
 .../zh_TW/process/stable-kernel-rules.rst     |  36 +-
 .../zh_TW/process/submit-checklist.rst        |  92 ++-
 .../zh_TW/process/submitting-patches.rst      | 755 +++++++++---------
 .../process/volatile-considered-harmful.rst   |  32 +-
 85 files changed, 6540 insertions(+), 2085 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bootconfig.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/cputopology.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/lockup-watchdogs.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/index.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/lru_sort.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/reclaim.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/index.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/ksm.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/sysrq.rst
 create mode 100644 Documentation/translations/zh_TW/arch/arm/Booting
 create mode 100644 Documentation/translations/zh_TW/arch/arm/kernel_user_helpers.txt
 create mode 100644 Documentation/translations/zh_TW/arch/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/booting.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/features.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/introduction.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/irq-chip-model.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/booting.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/features.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/ingenic-tcu.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/todo.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/debugging.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/registers.rst

diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
index 7fc56e1e3348..e132993abce6 100644
--- a/Documentation/translations/zh_TW/admin-guide/README.rst
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -9,16 +9,16 @@
  吳想成 Wu XiangCheng <bobwxc@email.cn>
  胡皓文 Hu Haowen <src.res.211@gmail.com>
 
-Linux內核5.x版本 <http://kernel.org/>
+Linux內核6.x版本 <http://kernel.org/>
 =========================================
 
-以下是Linux版本5的發行註記。仔細閱讀它們，
+以下是Linux版本6的發行註記。仔細閱讀它們，
 它們會告訴你這些都是什麼，解釋如何安裝內核，以及遇到問題時該如何做。
 
 什麼是Linux？
 ---------------
 
-  Linux是Unix作業系統的克隆版本，由Linus Torvalds在一個鬆散的網絡黑客
+  Linux是Unix操作系統的克隆版本，由Linus Torvalds在一個鬆散的網絡黑客
   （Hacker，無貶義）團隊的幫助下從頭開始編寫。它旨在實現兼容POSIX和
   單一UNIX規範。
 
@@ -28,7 +28,7 @@ Linux內核5.x版本 <http://kernel.org/>
 
   Linux在GNU通用公共許可證，版本2（GNU GPLv2）下分發，詳見隨附的COPYING文件。
 
-它能在什麼樣的硬體上運行？
+它能在什麼樣的硬件上運行？
 -----------------------------
 
   雖然Linux最初是爲32位的x86 PC機（386或更高版本）開發的，但今天它也能運行在
@@ -40,16 +40,16 @@ Linux內核5.x版本 <http://kernel.org/>
   單元（PMMU）和一個移植的GNU C編譯器（gcc；GNU Compiler Collection，GCC的一
   部分）。Linux也被移植到許多沒有PMMU的體系架構中，儘管功能顯然受到了一定的
   限制。
-  Linux也被移植到了其自己上。現在可以將內核作爲用戶空間應用程式運行——這被
+  Linux也被移植到了其自己上。現在可以將內核作爲用戶空間應用程序運行——這被
   稱爲用戶模式Linux（UML）。
 
 文檔
 -----
-網際網路上和書籍上都有大量的電子文檔，既有Linux專屬文檔，也有與一般UNIX問題相關
+因特網上和書籍上都有大量的電子文檔，既有Linux專屬文檔，也有與一般UNIX問題相關
 的文檔。我建議在任何Linux FTP站點上查找LDP（Linux文檔項目）書籍的文檔子目錄。
 本自述文件並不是關於系統的文檔：有更好的可用資源。
 
- - 網際網路上和書籍上都有大量的（電子）文檔，既有Linux專屬文檔，也有與普通
+ - 因特網上和書籍上都有大量的（電子）文檔，既有Linux專屬文檔，也有與普通
    UNIX問題相關的文檔。我建議在任何有LDP（Linux文檔項目）書籍的Linux FTP
    站點上查找文檔子目錄。本自述文件並不是關於系統的文檔：有更好的可用資源。
 
@@ -58,33 +58,33 @@ Linux內核5.x版本 <http://kernel.org/>
    :ref:`Documentation/process/changes.rst <changes>` 文件，它包含了升級內核
    可能會導致的問題的相關信息。
 
-安裝內核原始碼
+安裝內核源代碼
 ---------------
 
- - 如果您要安裝完整的原始碼，請把內核tar檔案包放在您有權限的目錄中（例如您
+ - 如果您要安裝完整的源代碼，請把內核tar檔案包放在您有權限的目錄中（例如您
    的主目錄）並將其解包::
 
-     xz -cd linux-5.x.tar.xz | tar xvf -
+     xz -cd linux-6.x.tar.xz | tar xvf -
 
-   將「X」替換成最新內核的版本號。
+   將“X”替換成最新內核的版本號。
 
-   【不要】使用 /usr/src/linux 目錄！這裡有一組庫頭文件使用的內核頭文件
+   【不要】使用 /usr/src/linux 目錄！這裏有一組庫頭文件使用的內核頭文件
    （通常是不完整的）。它們應該與庫匹配，而不是被內核的變化搞得一團糟。
 
- - 您還可以通過打補丁在5.x版本之間升級。補丁以xz格式分發。要通過打補丁進行
-   安裝，請獲取所有較新的補丁文件，進入內核原始碼（linux-5.x）的目錄並
+ - 您還可以通過打補丁在6.x版本之間升級。補丁以xz格式分發。要通過打補丁進行
+   安裝，請獲取所有較新的補丁文件，進入內核源代碼（linux-6.x）的目錄並
    執行::
 
-     xz -cd ../patch-5.x.xz | patch -p1
+     xz -cd ../patch-6.x.xz | patch -p1
 
-   請【按順序】替換所有大於當前原始碼樹版本的「x」，這樣就可以了。您可能想要
+   請【按順序】替換所有大於當前源代碼樹版本的“x”，這樣就可以了。您可能想要
    刪除備份文件（文件名類似xxx~ 或 xxx.orig)，並確保沒有失敗的補丁（文件名
    類似xxx# 或 xxx.rej）。如果有，不是你就是我犯了錯誤。
 
-   與5.x內核的補丁不同，5.x.y內核（也稱爲穩定版內核）的補丁不是增量的，而是
-   直接應用於基本的5.x內核。例如，如果您的基本內核是5.0，並且希望應用5.0.3
-   補丁，則不應先應用5.0.1和5.0.2的補丁。類似地，如果您運行的是5.0.2內核，
-   並且希望跳轉到5.0.3，那麼在應用5.0.3補丁之前，必須首先撤銷5.0.2補丁
+   與6.x內核的補丁不同，6.x.y內核（也稱爲穩定版內核）的補丁不是增量的，而是
+   直接應用於基本的6.x內核。例如，如果您的基本內核是6.0，並且希望應用6.0.3
+   補丁，則不應先應用6.0.1和6.0.2的補丁。類似地，如果您運行的是6.0.2內核，
+   並且希望跳轉到6.0.3，那麼在應用6.0.3補丁之前，必須首先撤銷6.0.2補丁
    （即patch -R）。更多關於這方面的內容，請閱讀
    :ref:`Documentation/process/applying-patches.rst <applying_patches>` 。
 
@@ -93,7 +93,7 @@ Linux內核5.x版本 <http://kernel.org/>
 
      linux/scripts/patch-kernel linux
 
-   上面命令中的第一個參數是內核原始碼的位置。補丁是在當前目錄應用的，但是
+   上面命令中的第一個參數是內核源代碼的位置。補丁是在當前目錄應用的，但是
    可以將另一個目錄指定爲第二個參數。
 
  - 確保沒有過時的 .o 文件和依賴項::
@@ -101,30 +101,30 @@ Linux內核5.x版本 <http://kernel.org/>
      cd linux
      make mrproper
 
-   現在您應該已經正確安裝了原始碼。
+   現在您應該已經正確安裝了源代碼。
 
-軟體要求
+軟件要求
 ---------
 
-   編譯和運行5.x內核需要各種軟體包的最新版本。請參考
+   編譯和運行6.x內核需要各種軟件包的最新版本。請參考
    :ref:`Documentation/process/changes.rst <changes>`
-   來了解最低版本要求以及如何升級軟體包。請注意，使用過舊版本的這些包可能會
+   來了解最低版本要求以及如何升級軟件包。請注意，使用過舊版本的這些包可能會
    導致很難追蹤的間接錯誤，因此不要以爲在生成或操作過程中出現明顯問題時可以
    只更新包。
 
 爲內核建立目錄
 ---------------
 
-   編譯內核時，默認情況下所有輸出文件都將與內核原始碼放在一起。使用
+   編譯內核時，默認情況下所有輸出文件都將與內核源代碼放在一起。使用
    ``make O=output/dir`` 選項可以爲輸出文件（包括 .config）指定備用位置。
    例如::
 
-     kernel source code: /usr/src/linux-5.x
+     kernel source code: /usr/src/linux-6.x
      build directory:    /home/name/build/kernel
 
    要配置和構建內核，請使用::
 
-     cd /usr/src/linux-5.x
+     cd /usr/src/linux-6.x
      make O=/home/name/build/kernel menuconfig
      make O=/home/name/build/kernel
      sudo make O=/home/name/build/kernel modules_install install
@@ -136,7 +136,7 @@ Linux內核5.x版本 <http://kernel.org/>
 
    即使只升級一個小版本，也不要跳過此步驟。每個版本中都會添加新的配置選項，
    如果配置文件沒有按預定設置，就會出現奇怪的問題。如果您想以最少的工作量
-   將現有配置升級到新版本，請使用 ``makeoldconfig`` ，它只會詢問您新配置
+   將現有配置升級到新版本，請使用 ``make oldconfig`` ，它只會詢問您新配置
    選項的答案。
 
  - 其他配置命令包括::
@@ -164,17 +164,17 @@ Linux內核5.x版本 <http://kernel.org/>
      "make ${PLATFORM}_defconfig"
                         使用arch/$arch/configs/${PLATFORM}_defconfig中
                         的默認選項值創建一個./.config文件。
-                        用「makehelp」來獲取您體系架構中所有可用平台的列表。
+                        用“make help”來獲取您體系架構中所有可用平臺的列表。
 
      "make allyesconfig"
-                        通過儘可能將選項值設置爲「y」，創建一個
+                        通過儘可能將選項值設置爲“y”，創建一個
                         ./.config文件。
 
      "make allmodconfig"
-                        通過儘可能將選項值設置爲「m」，創建一個
+                        通過儘可能將選項值設置爲“m”，創建一個
                         ./.config文件。
 
-     "make allnoconfig" 通過儘可能將選項值設置爲「n」，創建一個
+     "make allnoconfig" 通過儘可能將選項值設置爲“n”，創建一個
                         ./.config文件。
 
      "make randconfig"  通過隨機設置選項值來創建./.config文件。
@@ -182,7 +182,7 @@ Linux內核5.x版本 <http://kernel.org/>
      "make localmodconfig" 基於當前配置和加載的模塊（lsmod）創建配置。禁用
                            已加載的模塊不需要的任何模塊選項。
 
-                           要爲另一台計算機創建localmodconfig，請將該計算機
+                           要爲另一臺計算機創建localmodconfig，請將該計算機
                            的lsmod存儲到一個文件中，並將其作爲lsmod參數傳入。
 
                            此外，通過在參數LMC_KEEP中指定模塊的路徑，可以將
@@ -200,9 +200,10 @@ Linux內核5.x版本 <http://kernel.org/>
      "make localyesconfig" 與localmodconfig類似，只是它會將所有模塊選項轉換
                            爲內置（=y）。你可以同時通過LMC_KEEP保留模塊。
 
-     "make kvmconfig"   爲kvm客體內核支持啓用其他選項。
+     "make kvm_guest.config"
+                        爲kvm客戶機內核支持啓用其他選項。
 
-     "make xenconfig"   爲xen dom0客體內核支持啓用其他選項。
+     "make xen.config"  爲xen dom0客戶機內核支持啓用其他選項。
 
      "make tinyconfig"  配置儘可能小的內核。
 
@@ -218,10 +219,10 @@ Linux內核5.x版本 <http://kernel.org/>
       這種情況下，數學仿真永遠不會被使用。內核會稍微大一點，但不管
       是否有數學協處理器，都可以在不同的機器上工作。
 
-    - 「kernel hacking」配置細節通常會導致更大或更慢的內核（或兩者
+    - “kernel hacking”配置細節通常會導致更大或更慢的內核（或兩者
       兼而有之），甚至可以通過配置一些例程來主動嘗試破壞壞代碼以發現
       內核問題，從而降低內核的穩定性（kmalloc()）。因此，您可能應該
-      用於研究「開發」、「實驗」或「調試」特性相關問題。
+      用於研究“開發”、“實驗”或“調試”特性相關問題。
 
 編譯內核
 ---------
@@ -229,10 +230,8 @@ Linux內核5.x版本 <http://kernel.org/>
  - 確保您至少有gcc 5.1可用。
    有關更多信息，請參閱 :ref:`Documentation/process/changes.rst <changes>` 。
 
-   請注意，您仍然可以使用此內核運行a.out用戶程序。
-
  - 執行 ``make`` 來創建壓縮內核映像。如果您安裝了lilo以適配內核makefile，
-   那麼也可以進行 ``makeinstall`` ，但是您可能需要先檢查特定的lilo設置。
+   那麼也可以進行 ``make install`` ，但是您可能需要先檢查特定的lilo設置。
 
    實際安裝必須以root身份執行，但任何正常構建都不需要。
    無須徒然使用root身份。
@@ -242,8 +241,8 @@ Linux內核5.x版本 <http://kernel.org/>
  - 詳細的內核編譯/生成輸出：
 
    通常，內核構建系統在相當安靜的模式下運行（但不是完全安靜）。但是有時您或
-   其他內核開發人員需要看到編譯、連結或其他命令的執行過程。爲此，可使用
-   「verbose（詳細）」構建模式。
+   其他內核開發人員需要看到編譯、鏈接或其他命令的執行過程。爲此，可使用
+   “verbose（詳細）”構建模式。
    向 ``make`` 命令傳遞 ``V=1`` 來實現，例如::
 
      make V=1 all
@@ -255,15 +254,15 @@ Linux內核5.x版本 <http://kernel.org/>
    與工作內核版本號相同的新內核，請在進行 ``make modules_install`` 安裝
    之前備份modules目錄。
 
-   或者，在編譯之前，使用內核配置選項「LOCALVERSION」向常規內核版本附加
-   一個唯一的後綴。LOCALVERSION可以在「General Setup」菜單中設置。
+   或者，在編譯之前，使用內核配置選項“LOCALVERSION”向常規內核版本附加
+   一個唯一的後綴。LOCALVERSION可以在“General Setup”菜單中設置。
 
  - 爲了引導新內核，您需要將內核映像（例如編譯後的
    .../linux/arch/x86/boot/bzImage）複製到常規可引導內核的位置。
 
  - 不再支持在沒有LILO等啓動裝載程序幫助的情況下直接從軟盤引導內核。
 
-   如果從硬碟引導Linux，很可能使用LILO，它使用/etc/lilo.conf文件中
+   如果從硬盤引導Linux，很可能使用LILO，它使用/etc/lilo.conf文件中
    指定的內核映像文件。內核映像文件通常是/vmlinuz、/boot/vmlinuz、
    /bzImage或/boot/bzImage。使用新內核前，請保存舊映像的副本，並複製
    新映像覆蓋舊映像。然後您【必須重新運行LILO】來更新加載映射！否則，
@@ -284,68 +283,13 @@ Linux內核5.x版本 <http://kernel.org/>
 若遇到問題
 -----------
 
- - 如果您發現了一些可能由於內核缺陷所導致的問題，請檢查MAINTAINERS（維護者）
-   文件看看是否有人與令您遇到麻煩的內核部分相關。如果無人在此列出，那麼第二
-   個最好的方案就是把它們發給我（torvalds@linux-foundation.org），也可能發送
-   到任何其他相關的郵件列表或新聞組。
-
- - 在所有的缺陷報告中，【請】告訴我們您在說什麼內核，如何復現問題，以及您的
-   設置是什麼的（使用您的常識）。如果問題是新的，請告訴我；如果問題是舊的，
-   請嘗試告訴我您什麼時候首次注意到它。
-
- - 如果缺陷導致如下消息::
-
-     unable to handle kernel paging request at address C0000010
-     Oops: 0002
-     EIP:   0010:XXXXXXXX
-     eax: xxxxxxxx   ebx: xxxxxxxx   ecx: xxxxxxxx   edx: xxxxxxxx
-     esi: xxxxxxxx   edi: xxxxxxxx   ebp: xxxxxxxx
-     ds: xxxx  es: xxxx  fs: xxxx  gs: xxxx
-     Pid: xx, process nr: xx
-     xx xx xx xx xx xx xx xx xx xx
-
-   或者類似的內核調試信息顯示在屏幕上或在系統日誌里，請【如實】複製它。
-   可能對你來說轉儲（dump）看起來不可理解，但它確實包含可能有助於調試問題的
-   信息。轉儲上方的文本也很重要：它說明了內核轉儲代碼的原因（在上面的示例中，
-   是由於內核指針錯誤）。更多關於如何理解轉儲的信息，請參見
-   Documentation/admin-guide/bug-hunting.rst。
-
- - 如果使用 CONFIG_KALLSYMS 編譯內核，則可以按原樣發送轉儲，否則必須使用
-   ``ksymoops`` 程序來理解轉儲（但通常首選使用CONFIG_KALLSYMS編譯）。
-   此實用程序可從
-   https://www.kernel.org/pub/linux/utils/kernel/ksymoops/ 下載。
-   或者，您可以手動執行轉儲查找：
-
- - 在調試像上面這樣的轉儲時，如果您可以查找EIP值的含義，這將非常有幫助。
-   十六進位值本身對我或其他任何人都沒有太大幫助：它會取決於特定的內核設置。
-   您應該做的是從EIP行獲取十六進位值（忽略 ``0010:`` ），然後在內核名字列表
-   中查找它，以查看哪個內核函數包含有問題的地址。
-
-   要找到內核函數名，您需要找到與顯示症狀的內核相關聯的系統二進位文件。就是
-   文件「linux/vmlinux」。要提取名字列表並將其與內核崩潰中的EIP進行匹配，
-   請執行::
-
-     nm vmlinux | sort | less
-
-   這將爲您提供一個按升序排序的內核地址列表，從中很容易找到包含有問題的地址
-   的函數。請注意，內核調試消息提供的地址不一定與函數地址完全匹配（事實上，
-   這是不可能的），因此您不能只「grep」列表：不過列表將爲您提供每個內核函數
-   的起點，因此通過查找起始地址低於你正在搜索的地址，但後一個函數的高於的
-   函數，你會找到您想要的。實際上，在您的問題報告中加入一些「上下文」可能是
-   一個好主意，給出相關的上下幾行。
-
-   如果您由於某些原因無法完成上述操作（如您使用預編譯的內核映像或類似的映像），
-   請儘可能多地告訴我您的相關設置信息，這會有所幫助。有關詳細信息請閱讀
-   『Documentation/admin-guide/reporting-issues.rst』。
-
- - 或者，您可以在正在運行的內核上使用gdb（只讀的；即不能更改值或設置斷點）。
-   爲此，請首先使用-g編譯內核；適當地編輯arch/x86/Makefile，然後執行 ``make
-   clean`` 。您還需要啓用CONFIG_PROC_FS（通過 ``make config`` ）。
-
-   使用新內核重新啓動後，執行 ``gdb vmlinux /proc/kcore`` 。現在可以使用所有
-   普通的gdb命令。查找系統崩潰點的命令是 ``l *0xXXXXXXXX`` （將xxx替換爲EIP
-   值）。
-
-   用gdb無法調試一個當前未運行的內核是由於gdb（錯誤地）忽略了編譯內核的起始
-   偏移量。
+如果您發現了一些可能由於內核缺陷所導致的問題，請參閱：
+Documentation/translations/zh_TW/admin-guide/reporting-issues.rst 。
+
+想要理解內核錯誤報告，請參閱：
+Documentation/translations/zh_TW/admin-guide/bug-hunting.rst 。
+
+更多用GDB調試內核的信息，請參閱：
+Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst
+和 Documentation/dev-tools/kgdb.rst 。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/bootconfig.rst b/Documentation/translations/zh_TW/admin-guide/bootconfig.rst
new file mode 100644
index 000000000000..abac5aa60f67
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/bootconfig.rst
@@ -0,0 +1,294 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/bootconfig.rst
+
+:譯者: 吳想成 Wu XiangCheng <bobwxc@email.cn>
+
+========
+引導配置
+========
+
+:作者: Masami Hiramatsu <mhiramat@kernel.org>
+
+概述
+====
+
+引導配置擴展了現有的內核命令行，以一種更有效率的方式在引導內核時進一步支持
+鍵值數據。這允許管理員傳遞一份結構化關鍵字的配置文件。
+
+配置文件語法
+============
+
+引導配置文件的語法採用非常簡單的鍵值結構。每個關鍵字由點連接的單詞組成，鍵
+和值由 ``=`` 連接。值以分號（ ``;`` ）或換行符（ ``\n`` ）結尾。數組值中每
+個元素由逗號（ ``,`` ）分隔。::
+
+  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
+
+與內核命令行語法不同，逗號和 ``=`` 周圍允許有空格。
+
+關鍵字只允許包含字母、數字、連字符（ ``-`` ）和下劃線（ ``_`` ）。值可包含
+可打印字符和空格，但分號（ ``;`` ）、換行符（ ``\n`` ）、逗號（ ``,`` ）、
+井號（ ``#`` ）和右大括號（ ``}`` ）等分隔符除外。
+
+如果你需要在值中使用這些分隔符，可以用雙引號（ ``"VALUE"`` ）或單引號
+（ ``'VALUE'`` ）括起來。注意，引號無法轉義。
+
+鍵的值可以爲空或不存在。這些鍵用於檢查該鍵是否存在（類似布爾值）。
+
+鍵值語法
+--------
+
+引導配置文件語法允許用戶通過大括號合併鍵名部分相同的關鍵字。例如::
+
+ foo.bar.baz = value1
+ foo.bar.qux.quux = value2
+
+也可以寫成::
+
+ foo.bar {
+    baz = value1
+    qux.quux = value2
+ }
+
+或者更緊湊一些，寫成::
+
+ foo.bar { baz = value1; qux.quux = value2 }
+
+在這兩種樣式中，引導解析時相同的關鍵字都會自動合併。因此可以追加類似的樹或
+鍵值。
+
+相同關鍵字的值
+--------------
+
+禁止兩個或多個值或數組共享同一個關鍵字。例如::
+
+ foo = bar, baz
+ foo = qux  # !錯誤! 我們不可以重定義相同的關鍵字
+
+如果你想要更新值，必須顯式使用覆蓋操作符 ``:=`` 。例如::
+
+ foo = bar, baz
+ foo := qux
+
+這樣 ``foo`` 關鍵字的值就變成了 ``qux`` 。這對於通過添加（部分）自定義引導
+配置來覆蓋默認值非常有用，免於解析默認引導配置。
+
+如果你想對現有關鍵字追加值作爲數組成員，可以使用 ``+=`` 操作符。例如::
+
+ foo = bar, baz
+ foo += qux
+
+這樣， ``foo`` 關鍵字就同時擁有了 ``bar`` ， ``baz`` 和 ``qux`` 。
+
+此外，父關鍵字下可同時存在值和子關鍵字。
+例如，下列配置是可行的。::
+
+ foo = value1
+ foo.bar = value2
+ foo := value3 # 這會更新foo的值。
+
+注意，裸值不能直接放進結構化關鍵字中，必須在大括號外定義它。例如::
+
+ foo {
+     bar = value1
+     bar {
+         baz = value2
+         qux = value3
+     }
+ }
+
+同時，關鍵字下值節點的順序是固定的。如果值和子關鍵字同時存在，值永遠是該關
+鍵字的第一個子節點。因此如果用戶先指定子關鍵字，如::
+
+ foo.bar = value1
+ foo = value2
+
+則在程序（和/proc/bootconfig）中，它會按如下顯示::
+
+ foo = value2
+ foo.bar = value1
+
+註釋
+----
+
+配置語法接受shell腳本風格的註釋。註釋以井號（ ``#`` ）開始，到換行符
+（ ``\n`` ）結束。
+
+::
+
+ # comment line
+ foo = value # value is set to foo.
+ bar = 1, # 1st element
+       2, # 2nd element
+       3  # 3rd element
+
+會被解析爲::
+
+ foo = value
+ bar = 1, 2, 3
+
+注意你不能把註釋放在值和分隔符（ ``,`` 或 ``;`` ）之間。如下配置語法是錯誤的::
+
+ key = 1 # comment
+       ,2
+
+
+/proc/bootconfig
+================
+
+/proc/bootconfig是引導配置的用戶空間接口。與/proc/cmdline不同，此文件內容以
+鍵值列表樣式顯示。
+每個鍵值對一行，樣式如下::
+
+ KEY[.WORDS...] = "[VALUE]"[,"VALUE2"...]
+
+
+用引導配置引導內核
+==================
+
+用引導配置引導內核有兩種方法：將引導配置附加到initrd鏡像或直接嵌入內核中。
+
+*initrd: initial RAM disk，初始內存磁盤*
+
+將引導配置附加到initrd
+----------------------
+
+由於默認情況下引導配置文件是用initrd加載的，因此它將被添加到initrd（initramfs）
+鏡像文件的末尾，其中包含填充、大小、校驗值和12字節幻數，如下所示::
+
+ [initrd][bootconfig][padding][size(le32)][checksum(le32)][#BOOTCONFIG\n]
+
+大小和校驗值爲小端序存放的32位無符號值。
+
+當引導配置被加到initrd鏡像時，整個文件大小會對齊到4字節。空字符（ ``\0`` ）
+會填補對齊空隙。因此 ``size`` 就是引導配置文件的長度+填充的字節。
+
+Linux內核在內存中解碼initrd鏡像的最後部分以獲取引導配置數據。由於這種“揹負式”
+的方法，只要引導加載器傳遞了正確的initrd文件大小，就無需更改或更新引導加載器
+和內核鏡像本身。如果引導加載器意外傳遞了更長的大小，內核將無法找到引導配置數
+據。
+
+Linux內核在tools/bootconfig下提供了 ``bootconfig`` 命令來完成此操作，管理員
+可以用它從initrd鏡像中刪除或追加配置文件。你可以用以下命令來構建它::
+
+ # make -C tools/bootconfig
+
+要向initrd鏡像添加你的引導配置文件，請按如下命令操作（舊數據會自動移除）::
+
+ # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
+
+要從鏡像中移除配置，可以使用-d選項::
+
+ # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
+
+然後在內核命令行上添加 ``bootconfig`` 告訴內核去initrd文件末尾尋找內核配置。
+
+將引導配置嵌入內核
+------------------
+
+如果你不能使用initrd，也可以通過Kconfig選項將引導配置文件嵌入內核中。在此情
+況下，你需要用以下選項重新編譯內核::
+
+ CONFIG_BOOT_CONFIG_EMBED=y
+ CONFIG_BOOT_CONFIG_EMBED_FILE="/引導配置/文件/的/路徑"
+
+``CONFIG_BOOT_CONFIG_EMBED_FILE`` 需要從源碼樹或對象樹開始的引導配置文件的
+絕對/相對路徑。內核會將其嵌入作爲默認引導配置。
+
+與將引導配置附加到initrd一樣，你也需要在內核命令行上添加 ``bootconfig`` 告訴
+內核去啓用內嵌的引導配置。
+
+注意，即使你已經設置了此選項，仍可用附加到initrd的其他引導配置覆蓋內嵌的引導
+配置。
+
+通過引導配置傳遞內核參數
+========================
+
+除了內核命令行，引導配置也可以用於傳遞內核參數。所有 ``kernel`` 關鍵字下的鍵
+值對都將直接傳遞給內核命令行。此外， ``init`` 下的鍵值對將通過命令行傳遞給
+init進程。參數按以下順序與用戶給定的內核命令行字符串相連，因此命令行參數可以
+覆蓋引導配置參數（這取決於子系統如何處理參數，但通常前面的參數將被後面的參數
+覆蓋）::
+
+ [bootconfig params][cmdline params] -- [bootconfig init params][cmdline init params]
+
+如果引導配置文件給出的kernel/init參數是::
+
+ kernel {
+   root = 01234567-89ab-cdef-0123-456789abcd
+ }
+ init {
+  splash
+ }
+
+這將被複制到內核命令行字符串中，如下所示::
+
+ root="01234567-89ab-cdef-0123-456789abcd" -- splash
+
+如果用戶給出的其他命令行是::
+
+ ro bootconfig -- quiet
+
+則最後的內核命令行如下::
+
+ root="01234567-89ab-cdef-0123-456789abcd" ro bootconfig -- splash quiet
+
+
+配置文件的限制
+==============
+
+當前最大的配置大小是32KB，關鍵字總數（不是鍵值條目）必須少於1024個節點。
+注意：這不是條目數而是節點數，條目必須消耗超過2個節點（一個關鍵字和一個值）。
+所以從理論上講最多512個鍵值對。如果關鍵字平均包含3個單詞，則可有256個鍵值對。
+在大多數情況下，配置項的數量將少於100個條目，小於8KB，因此這應該足夠了。如果
+節點數超過1024，解析器將返回錯誤，即使文件大小小於32KB。（請注意，此最大尺寸
+不包括填充的空字符。）
+無論如何，因爲 ``bootconfig`` 命令在附加啓動配置到initrd映像時會驗證它，用戶
+可以在引導之前注意到它。
+
+
+引導配置API
+===========
+
+用戶可以查詢或遍歷鍵值對，也可以查找（前綴）根關鍵字節點，並在查找該節點下的
+鍵值。
+
+如果您有一個關鍵字字符串，則可以直接使用 xbc_find_value() 查詢該鍵的值。如果
+你想知道引導配置裏有哪些關鍵字，可以使用 xbc_for_each_key_value() 迭代鍵值對。
+請注意，您需要使用 xbc_array_for_each_value() 訪問數組的值，例如::
+
+ vnode = NULL;
+ xbc_find_value("key.word", &vnode);
+ if (vnode && xbc_node_is_array(vnode))
+    xbc_array_for_each_value(vnode, value) {
+      printk("%s ", value);
+    }
+
+如果您想查找具有前綴字符串的鍵，可以使用 xbc_find_node() 通過前綴字符串查找
+節點，然後用 xbc_node_for_each_key_value() 迭代前綴節點下的鍵。
+
+但最典型的用法是獲取前綴下的命名值或前綴下的命名數組，例如::
+
+ root = xbc_find_node("key.prefix");
+ value = xbc_node_find_value(root, "option", &vnode);
+ ...
+ xbc_node_for_each_array_value(root, "array-option", value, anode) {
+    ...
+ }
+
+這將訪問值“key.prefix.option”的值和“key.prefix.array-option”的數組。
+
+鎖是不需要的，因爲在初始化之後配置只讀。如果需要修改，必須複製所有數據和關鍵字。
+
+
+函數與結構體
+============
+
+相關定義的kernel-doc參見：
+
+ - include/linux/bootconfig.h
+ - lib/bootconfig.c
+
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
index b448dbf5ac87..3f10a9f8f223 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
@@ -17,14 +17,14 @@
 引言
 =====
 
-始終嘗試由來自kernel.org的原始碼構建的最新內核。如果您沒有信心這樣做，請將
+始終嘗試由來自kernel.org的源代碼構建的最新內核。如果您沒有信心這樣做，請將
 錯誤報告給您的發行版供應商，而不是內核開發人員。
 
 找到缺陷（bug）並不總是那麼容易，不過仍然得去找。如果你找不到它，不要放棄。
-儘可能多的向相關維護人員報告您發現的信息。請參閱MAINTAINERS文件以了解您所
+儘可能多的向相關維護人員報告您發現的信息。請參閱MAINTAINERS文件以瞭解您所
 關注的子系統的維護人員。
 
-在提交錯誤報告之前，請閱讀「Documentation/admin-guide/reporting-issues.rst」。
+在提交錯誤報告之前，請閱讀“Documentation/admin-guide/reporting-issues.rst”。
 
 設備未出現（Devices not appearing）
 ====================================
@@ -38,7 +38,7 @@
 
 操作步驟：
 
-- 從git原始碼構建內核
+- 從git源代碼構建內核
 - 以此開始二分 [#f1]_::
 
 	$ git bisect start
@@ -76,7 +76,7 @@
 如需進一步參考，請閱讀：
 
 - ``git-bisect`` 的手冊頁
-- `Fighting regressions with git bisect（用git bisect解決回歸）
+- `Fighting regressions with git bisect（用git bisect解決迴歸）
   <https://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html>`_
 - `Fully automated bisecting with "git bisect run"（使用git bisect run
   來全自動二分） <https://lwn.net/Articles/317154>`_
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
index 9a3de3bff5e7..631fd2650929 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
@@ -48,8 +48,8 @@
 	 [<c1549f43>] ? sysenter_past_esp+0x40/0x6a
 	---[ end trace 6ebc60ef3981792f ]---
 
-這樣的堆棧跟蹤提供了足夠的信息來識別內核原始碼中發生錯誤的那一行。根據問題的
-嚴重性，它還可能包含 **「Oops」** 一詞，比如::
+這樣的堆棧跟蹤提供了足夠的信息來識別內核源代碼中發生錯誤的那一行。根據問題的
+嚴重性，它還可能包含 **“Oops”** 一詞，比如::
 
 	BUG: unable to handle kernel NULL pointer dereference at   (null)
 	IP: [<c06969d4>] iret_exc+0x7d0/0xa59
@@ -58,17 +58,17 @@
 	...
 
 儘管有 **Oops** 或其他類型的堆棧跟蹤，但通常需要找到出問題的行來識別和處理缺
-陷。在本章中，我們將參考「Oops」來了解需要分析的各種堆棧跟蹤。
+陷。在本章中，我們將參考“Oops”來了解需要分析的各種堆棧跟蹤。
 
 如果內核是用 ``CONFIG_DEBUG_INFO`` 編譯的，那麼可以使用文件：
 `scripts/decode_stacktrace.sh` 。
 
-連結的模塊
+鏈接的模塊
 -----------
 
-受到汙染或正在加載/卸載的模塊用「（…）」標記，汙染標誌在
-`Documentation/admin-guide/tainted-kernels.rst` 文件中進行了描述，「正在被加
-載」用「+」標註，「正在被卸載」用「-」標註。
+受到污染或正在加載/卸載的模塊用“（…）”標記，污染標誌在
+`Documentation/admin-guide/tainted-kernels.rst` 文件中進行了描述，“正在被加
+載”用“+”標註，“正在被卸載”用“-”標註。
 
 
 Oops消息在哪？
@@ -81,19 +81,19 @@ syslog文件，通常是 ``/var/log/messages`` （取決於 ``/etc/syslog.conf``
 
 有時 ``klogd`` 會掛掉，這種情況下您可以運行 ``dmesg > file`` 從內核緩衝區
 讀取數據並保存它。或者您可以 ``cat /proc/kmsg > file`` ，但是您必須適時
-中斷以停止傳輸，因爲 ``kmsg`` 是一個「永無止境的文件」。
+中斷以停止傳輸，因爲 ``kmsg`` 是一個“永無止境的文件”。
 
-如果機器嚴重崩潰，無法輸入命令或磁碟不可用，那還有三個選項：
+如果機器嚴重崩潰，無法輸入命令或磁盤不可用，那還有三個選項：
 
 (1) 手動複製屏幕上的文本，並在機器重新啓動後輸入。很難受，但這是突然崩潰下
-    唯一的選擇。或者你可以用數位相機拍下屏幕——雖然不那麼好，但總比什麼都沒
-    有好。如果消息滾動超出控制台頂部，使用更高解析度（例如 ``vga=791`` ）
-    引導啓動將允許您閱讀更多文本。（警告：這需要 ``vesafb`` ，因此對「早期」
+    唯一的選擇。或者你可以用數碼相機拍下屏幕——雖然不那麼好，但總比什麼都沒
+    有好。如果消息滾動超出控制檯頂部，使用更高分辨率（例如 ``vga=791`` ）
+    引導啓動將允許您閱讀更多文本。（警告：這需要 ``vesafb`` ，因此對“早期”
     的Oppses沒有幫助）
 
 (2) 從串口終端啓動（參見
     :ref:`Documentation/admin-guide/serial-console.rst <serial_console>` ），
-    在另一台機器上運行數據機然後用你喜歡的通信程序捕獲輸出。
+    在另一臺機器上運行調制解調器然後用你喜歡的通信程序捕獲輸出。
     Minicom運行良好。
 
 (3) 使用Kdump（參閱 Documentation/admin-guide/kdump/kdump.rst ），使用
@@ -103,7 +103,7 @@ syslog文件，通常是 ``/var/log/messages`` （取決於 ``/etc/syslog.conf``
 找到缺陷位置
 -------------
 
-如果你能指出缺陷在內核原始碼中的位置，則報告缺陷的效果會非常好。這有兩種方法。
+如果你能指出缺陷在內核源代碼中的位置，則報告缺陷的效果會非常好。這有兩種方法。
 通常來說使用 ``gdb`` 會比較容易，不過內核需要用調試信息來預編譯。
 
 gdb
@@ -187,7 +187,7 @@ GNU 調試器（GNU debugger， ``gdb`` ）是從 ``vmlinux`` 文件中找出OOP
 objdump
 ^^^^^^^^
 
-要調試內核，請使用objdump並從崩潰輸出中查找十六進位偏移，以找到有效的代碼/匯
+要調試內核，請使用objdump並從崩潰輸出中查找十六進制偏移，以找到有效的代碼/匯
 編行。如果沒有調試符號，您將看到所示例程的彙編程序代碼，但是如果內核有調試
 符號，C代碼也將可見（調試符號可以在內核配置菜單的hacking項中啓用）。例如::
 
@@ -197,7 +197,7 @@ objdump
 
    您需要處於內核樹的頂層以便此獲得您的C文件。
 
-如果您無法訪問原始碼，仍然可以使用以下方法調試一些崩潰轉儲（如Dave Miller的
+如果您無法訪問源代碼，仍然可以使用以下方法調試一些崩潰轉儲（如Dave Miller的
 示例崩潰轉儲輸出所示）::
 
      EIP is at 	+0x14/0x4c0
@@ -234,9 +234,9 @@ objdump
 報告缺陷
 ---------
 
-一旦你通過定位缺陷找到了其發生的地方，你可以嘗試自己修復它或者向上游報告它。
+一旦你通過定位缺陷找到了其發生的地方，你可以嘗試自己修復它或者向上遊報告它。
 
-爲了向上游報告，您應該找出用於開發受影響代碼的郵件列表。這可以使用 ``get_maintainer.pl`` 。
+爲了向上遊報告，您應該找出用於開發受影響代碼的郵件列表。這可以使用 ``get_maintainer.pl`` 。
 
 
 例如，您在gspca的sonixj.c文件中發現一個缺陷，則可以通過以下方法找到它的維護者::
@@ -251,7 +251,7 @@ objdump
 
 請注意它將指出：
 
-- 最後接觸原始碼的開發人員（如果這是在git樹中完成的）。在上面的例子中是Tejun
+- 最後接觸源代碼的開發人員（如果這是在git樹中完成的）。在上面的例子中是Tejun
   和Bhaktipriya（在這個特定的案例中，沒有人真正參與這個文件的開發）；
 - 驅動維護人員（Hans Verkuil）；
 - 子系統維護人員（Mauro Carvalho Chehab）；
diff --git a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
index bd0c08aab8ea..6961006b4a2d 100644
--- a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
+++ b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
@@ -7,10 +7,10 @@
 清除 WARN_ONCE
 --------------
 
-WARN_ONCE / WARN_ON_ONCE / printk_once 僅僅列印一次消息.
+WARN_ONCE / WARN_ON_ONCE / printk_once 僅僅打印一次消息.
 
 echo 1 > /sys/kernel/debug/clear_warn_once
 
-可以清除這種狀態並且再次允許列印一次告警信息，這對於運行測試集後重現問題
+可以清除這種狀態並且再次允許打印一次告警信息，這對於運行測試集後重現問題
 很有用。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
index 9e04aeac1a5c..cc046f3b7ffa 100644
--- a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
+++ b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
@@ -20,13 +20,13 @@ Linux通過``/proc/stat``和``/proc/uptime``導出各種信息，用戶空間工
 
     ...
 
-這裡系統認爲在默認採樣周期內有10.01%的時間工作在用戶空間，2.92%的時
+這裏系統認爲在默認採樣週期內有10.01%的時間工作在用戶空間，2.92%的時
 間用在系統空間，總體上有81.63%的時間是空閒的。
 
 大多數情況下``/proc/stat``的信息幾乎真實反映了系統信息，然而，由於內
 核採集這些數據的方式/時間的特點，有時這些信息根本不可靠。
 
-那麼這些信息是如何被搜集的呢？每當時間中斷觸發時，內核查看此刻運行的
+那麼這些信息是如何被蒐集的呢？每當時間中斷觸發時，內核查看此刻運行的
 進程類型，並增加與此類型/狀態進程對應的計數器的值。這種方法的問題是
 在兩次時間中斷之間系統（進程）能夠在多種狀態之間切換多次，而計數器只
 增加最後一種狀態下的計數。
@@ -34,7 +34,7 @@ Linux通過``/proc/stat``和``/proc/uptime``導出各種信息，用戶空間工
 舉例
 ---
 
-假設系統有一個進程以如下方式周期性地占用cpu::
+假設系統有一個進程以如下方式週期性地佔用cpu::
 
      兩個時鐘中斷之間的時間線
     |-----------------------|
@@ -46,7 +46,7 @@ Linux通過``/proc/stat``和``/proc/uptime``導出各種信息，用戶空間工
 在上面的情況下，根據``/proc/stat``的信息（由於當系統處於空閒狀態時，
 時間中斷經常會發生）系統的負載將會是0
 
-大家能夠想像內核的這種行爲會發生在許多情況下，這將導致``/proc/stat``
+大家能夠想象內核的這種行爲會發生在許多情況下，這將導致``/proc/stat``
 中存在相當古怪的信息::
 
 	/* gcc -o hog smallhog.c */
diff --git a/Documentation/translations/zh_TW/admin-guide/cputopology.rst b/Documentation/translations/zh_TW/admin-guide/cputopology.rst
new file mode 100644
index 000000000000..5c46d1b3b065
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/cputopology.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/cputopology.rst
+
+:翻譯:
+
+  唐藝舟 Tang Yizhou <tangyeechou@gmail.com>
+
+==========================
+如何通過sysfs將CPU拓撲導出
+==========================
+
+CPU拓撲信息通過sysfs導出。顯示的項（屬性）和某些架構的/proc/cpuinfo輸出相似。它們位於
+/sys/devices/system/cpu/cpuX/topology/。請閱讀ABI文件：
+Documentation/ABI/stable/sysfs-devices-system-cpu。
+
+drivers/base/topology.c是體系結構中性的，它導出了這些屬性。然而，die、cluster、book、
+draw這些層次結構相關的文件僅在體系結構提供了下文描述的宏的條件下被創建。
+
+對於支持這個特性的體系結構，它必須在include/asm-XXX/topology.h中定義這些宏中的一部分::
+
+	#define topology_physical_package_id(cpu)
+	#define topology_die_id(cpu)
+	#define topology_cluster_id(cpu)
+	#define topology_core_id(cpu)
+	#define topology_book_id(cpu)
+	#define topology_drawer_id(cpu)
+	#define topology_sibling_cpumask(cpu)
+	#define topology_core_cpumask(cpu)
+	#define topology_cluster_cpumask(cpu)
+	#define topology_die_cpumask(cpu)
+	#define topology_book_cpumask(cpu)
+	#define topology_drawer_cpumask(cpu)
+
+``**_id macros`` 的類型是int。
+``**_cpumask macros`` 的類型是 ``(const) struct cpumask *`` 。後者和恰當的
+``**_siblings`` sysfs屬性對應（除了topology_sibling_cpumask()，它和thread_siblings
+對應）。
+
+爲了在所有體系結構上保持一致，include/linux/topology.h提供了上述所有宏的默認定義，以防
+它們未在include/asm-XXX/topology.h中定義:
+
+1) topology_physical_package_id: -1
+2) topology_die_id: -1
+3) topology_cluster_id: -1
+4) topology_core_id: 0
+5) topology_book_id: -1
+6) topology_drawer_id: -1
+7) topology_sibling_cpumask: 僅入參CPU
+8) topology_core_cpumask: 僅入參CPU
+9) topology_cluster_cpumask: 僅入參CPU
+10) topology_die_cpumask: 僅入參CPU
+11) topology_book_cpumask:  僅入參CPU
+12) topology_drawer_cpumask: 僅入參CPU
+
+此外，CPU拓撲信息由/sys/devices/system/cpu提供，包含下述文件。輸出對應的內部數據源放在
+方括號（"[]"）中。
+
+    =========== ==================================================================
+    kernel_max: 內核配置允許的最大CPU下標值。[NR_CPUS-1]
+
+    offline:    由於熱插拔移除或者超過內核允許的CPU上限（上文描述的kernel_max）
+                導致未上線的CPU。[~cpu_online_mask + cpus >= NR_CPUS]
+
+    online:     在線的CPU，可供調度使用。[cpu_online_mask]
+
+    possible:   已被分配資源的CPU，如果它們CPU實際存在，可以上線。
+                [cpu_possible_mask]
+
+    present:    被系統識別實際存在的CPU。[cpu_present_mask]
+    =========== ==================================================================
+
+上述輸出的格式和cpulist_parse()兼容[參見 <linux/cpumask.h>]。下面給些例子。
+
+在本例中，系統中有64個CPU，但是CPU 32-63超過了kernel_max值，因爲NR_CPUS配置項是32，
+取值範圍被限制爲0..31。此外注意CPU2和4-31未上線，但是可以上線，因爲它們同時存在於
+present和possible::
+
+     kernel_max: 31
+        offline: 2,4-31,32-63
+         online: 0-1,3
+       possible: 0-31
+        present: 0-31
+
+在本例中，NR_CPUS配置項是128，但內核啓動時設置possible_cpus=144。系統中有4個CPU，
+CPU2被手動設置下線（也是唯一一個可以上線的CPU）::
+
+     kernel_max: 127
+        offline: 2,4-127,128-143
+         online: 0-1,3
+       possible: 0-127
+        present: 0-3
+
+閱讀Documentation/core-api/cpu_hotplug.rst可瞭解開機參數possible_cpus=NUM，同時還
+可以瞭解各種cpumask的信息。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/index.rst b/Documentation/translations/zh_TW/admin-guide/index.rst
index 2804d619201d..926807a15618 100644
--- a/Documentation/translations/zh_TW/admin-guide/index.rst
+++ b/Documentation/translations/zh_TW/admin-guide/index.rst
@@ -3,13 +3,15 @@
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :doc:`../../../admin-guide/index`
-:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+             胡皓文 Hu Haowen <src.res.211@gmail.com>
+
 
 Linux 內核用戶和管理員指南
 ==========================
 
 下面是一組隨時間添加到內核中的面向用戶的文檔的集合。到目前爲止，還沒有一個
-整體的順序或組織 - 這些材料不是一個單一的，連貫的文件！幸運的話，情況會隨著
+整體的順序或組織 - 這些材料不是一個單一的，連貫的文件！幸運的話，情況會隨着
 時間的推移而迅速改善。
 
 這個初始部分包含總體信息，包括描述內核的README， 關於內核參數的文檔等。
@@ -21,15 +23,15 @@ Linux 內核用戶和管理員指南
 
 Todolist:
 
-   kernel-parameters
-   devices
-   sysctl/index
+*   kernel-parameters
+*   devices
+*   sysctl/index
 
 本節介紹CPU漏洞及其緩解措施。
 
 Todolist:
 
-   hw-vuln/index
+*   hw-vuln/index
 
 下面的一組文檔，針對的是試圖跟蹤問題和bug的用戶。
 
@@ -37,6 +39,7 @@ Todolist:
    :maxdepth: 1
 
    reporting-issues
+   reporting-regressions
    security-bugs
    bug-hunting
    bug-bisect
@@ -45,18 +48,17 @@ Todolist:
 
 Todolist:
 
-   reporting-bugs
-   ramoops
-   dynamic-debug-howto
-   kdump/index
-   perf/index
+*   ramoops
+*   dynamic-debug-howto
+*   kdump/index
+*   perf/index
 
-這是應用程式開發人員感興趣的章節的開始。可以在這裡找到涵蓋內核ABI各個
+這是應用程序開發人員感興趣的章節的開始。可以在這裏找到涵蓋內核ABI各個
 方面的文檔。
 
 Todolist:
 
-   sysfs-rules
+*   sysfs-rules
 
 本手冊的其餘部分包括各種指南，介紹如何根據您的喜好配置內核的特定行爲。
 
@@ -64,67 +66,67 @@ Todolist:
 .. toctree::
    :maxdepth: 1
 
+   bootconfig
    clearing-warn-once
    cpu-load
+   cputopology
+   lockup-watchdogs
    unicode
+   sysrq
+   mm/index
 
 Todolist:
 
-   acpi/index
-   aoe/index
-   auxdisplay/index
-   bcache
-   binderfs
-   binfmt-misc
-   blockdev/index
-   bootconfig
-   braille-console
-   btmrvl
-   cgroup-v1/index
-   cgroup-v2
-   cifs/index
-   cputopology
-   dell_rbu
-   device-mapper/index
-   edid
-   efi-stub
-   ext4
-   nfs/index
-   gpio/index
-   highuid
-   hw_random
-   initrd
-   iostats
-   java
-   jfs
-   kernel-per-CPU-kthreads
-   laptops/index
-   lcd-panel-cgram
-   ldm
-   lockup-watchdogs
-   LSM/index
-   md
-   media/index
-   mm/index
-   module-signing
-   mono
-   namespaces/index
-   numastat
-   parport
-   perf-security
-   pm/index
-   pnp
-   rapidio
-   ras
-   rtc
-   serial-console
-   svga
-   sysrq
-   thunderbolt
-   ufs
-   vga-softcursor
-   video-output
-   xfs
+*   acpi/index
+*   aoe/index
+*   auxdisplay/index
+*   bcache
+*   binderfs
+*   binfmt-misc
+*   blockdev/index
+*   braille-console
+*   btmrvl
+*   cgroup-v1/index
+*   cgroup-v2
+*   cifs/index
+*   dell_rbu
+*   device-mapper/index
+*   edid
+*   efi-stub
+*   ext4
+*   nfs/index
+*   gpio/index
+*   highuid
+*   hw_random
+*   initrd
+*   iostats
+*   java
+*   jfs
+*   kernel-per-CPU-kthreads
+*   laptops/index
+*   lcd-panel-cgram
+*   ldm
+*   LSM/index
+*   md
+*   media/index
+*   module-signing
+*   mono
+*   namespaces/index
+*   numastat
+*   parport
+*   perf-security
+*   pm/index
+*   pnp
+*   rapidio
+*   ras
+*   rtc
+*   serial-console
+*   svga
+*   thunderbolt
+*   ufs
+*   vga-softcursor
+*   video-output
+*   xfs
 
 .. only::  subproject and html
 
diff --git a/Documentation/translations/zh_TW/admin-guide/init.rst b/Documentation/translations/zh_TW/admin-guide/init.rst
index db3fdf611080..e355638d0eac 100644
--- a/Documentation/translations/zh_TW/admin-guide/init.rst
+++ b/Documentation/translations/zh_TW/admin-guide/init.rst
@@ -1,5 +1,3 @@
-.. SPDX-License-Identifier: GPL-2.0
-
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :doc:`../../../admin-guide/init`
@@ -9,8 +7,8 @@
  吳想成 Wu XiangCheng <bobwxc@email.cn>
  胡皓文 Hu Haowen <src.res.211@gmail.com>
 
-解釋「No working init found.」啓動掛起消息
-==========================================
+解釋“No working init found.”啓動掛起消息
+=========================================
 
 :作者:
 
@@ -18,41 +16,41 @@
 
  Cristian Souza <cristianmsbr at gmail period com>
 
-本文檔提供了加載初始化二進位（init binary）失敗的一些高層級原因（大致按執行
+本文檔提供了加載初始化二進制（init binary）失敗的一些高層級原因（大致按執行
 順序列出）。
 
-1) **無法掛載根文件系統Unable to mount root FS** ：請設置「debug」內核參數（在
+1) **無法掛載根文件系統Unable to mount root FS** ：請設置“debug”內核參數（在
    引導加載程序bootloader配置文件或CONFIG_CMDLINE）以獲取更詳細的內核消息。
 
-2) **初始化二進位不存在於根文件系統上init binary doesn't exist on rootfs** ：
+2) **初始化二進制不存在於根文件系統上init binary doesn't exist on rootfs** ：
    確保您的根文件系統類型正確（並且 ``root=`` 內核參數指向正確的分區）；擁有
-   所需的驅動程序，例如SCSI或USB等存儲硬體；文件系統（ext3、jffs2等）是內建的
+   所需的驅動程序，例如SCSI或USB等存儲硬件；文件系統（ext3、jffs2等）是內建的
    （或者作爲模塊由initrd預加載）。
 
-3) **控制台設備損壞Broken console device** ： ``console= setup`` 中可能存在
-   衝突 --> 初始控制台不可用（initial console unavailable）。例如，由於串行
-   IRQ問題（如缺少基於中斷的配置）導致的某些串行控制台不可靠。嘗試使用不同的
+3) **控制檯設備損壞Broken console device** ： ``console= setup`` 中可能存在
+   衝突 --> 初始控制檯不可用（initial console unavailable）。例如，由於串行
+   IRQ問題（如缺少基於中斷的配置）導致的某些串行控制檯不可靠。嘗試使用不同的
    ``console= device`` 或像 ``netconsole=`` 。
 
-4) **二進位存在但依賴項不可用Binary exists but dependencies not available** ：
-   例如初始化二進位的必需庫依賴項，像 ``/lib/ld-linux.so.2`` 丟失或損壞。使用
+4) **二進制存在但依賴項不可用Binary exists but dependencies not available** ：
+   例如初始化二進制的必需庫依賴項，像 ``/lib/ld-linux.so.2`` 丟失或損壞。使用
    ``readelf -d <INIT>|grep NEEDED`` 找出需要哪些庫。
 
-5) **無法加載二進位Binary cannot be loaded** ：請確保二進位的體系結構與您的
-   硬體匹配。例如i386不匹配x86_64，或者嘗試在ARM硬體上加載x86。如果您嘗試在
-   此處加載非二進位文件（shell腳本？），您應該確保腳本在其工作頭（shebang
+5) **無法加載二進制Binary cannot be loaded** ：請確保二進制的體系結構與您的
+   硬件匹配。例如i386不匹配x86_64，或者嘗試在ARM硬件上加載x86。如果您嘗試在
+   此處加載非二進制文件（shell腳本？），您應該確保腳本在其工作頭（shebang
    header）行 ``#!/...`` 中指定能正常工作的解釋器（包括其庫依賴項）。在處理
-   腳本之前，最好先測試一個簡單的非腳本二進位文件，比如 ``/bin/sh`` ，並確認
+   腳本之前，最好先測試一個簡單的非腳本二進制文件，比如 ``/bin/sh`` ，並確認
    它能成功執行。要了解更多信息，請將代碼添加到 ``init/main.c`` 以顯示
    kernel_execve()的返回值。
 
-當您發現新的失敗原因時，請擴展本解釋（畢竟加載初始化二進位是一個 **關鍵** 且
+當您發現新的失敗原因時，請擴展本解釋（畢竟加載初始化二進制是一個 **關鍵** 且
 艱難的過渡步驟，需要儘可能無痛地進行），然後向LKML提交一個補丁。
 
 待辦事項：
 
 - 通過一個可以存儲 ``kernel_execve()`` 結果值的結構體數組實現各種
-  ``run_init_process()`` 調用，並在失敗時通過疊代 **所有** 結果來記錄一切
+  ``run_init_process()`` 調用，並在失敗時通過迭代 **所有** 結果來記錄一切
   （非常重要的可用性修復）。
-- 試著使實現本身在一般情況下更有幫助，例如在受影響的地方提供額外的錯誤消息。
+- 試着使實現本身在一般情況下更有幫助，例如在受影響的地方提供額外的錯誤消息。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/lockup-watchdogs.rst b/Documentation/translations/zh_TW/admin-guide/lockup-watchdogs.rst
new file mode 100644
index 000000000000..f65b0c96e8e3
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/lockup-watchdogs.rst
@@ -0,0 +1,67 @@
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/lockup-watchdogs.rst
+:Translator: Hailong Liu <liu.hailong6@zte.com.cn>
+
+.. _tw_lockup-watchdogs:
+
+
+=================================================
+Softlockup與hardlockup檢測機制(又名:nmi_watchdog)
+=================================================
+
+Linux中內核實現了一種用以檢測系統發生softlockup和hardlockup的看門狗機制。
+
+Softlockup是一種會引發系統在內核態中一直循環超過20秒（詳見下面“實現”小節）導致
+其他任務沒有機會得到運行的BUG。一旦檢測到'softlockup'發生，默認情況下系統會打
+印當前堆棧跟蹤信息並進入鎖定狀態。也可配置使其在檢測到'softlockup'後進入panic
+狀態；通過sysctl命令設置“kernel.softlockup_panic”、使用內核啓動參數
+“softlockup_panic”（詳見Documentation/admin-guide/kernel-parameters.rst）以及使
+能內核編譯選項“BOOTPARAM_SOFTLOCKUP_PANIC”都可實現這種配置。
+
+而'hardlockup'是一種會引發系統在內核態一直循環超過10秒鐘（詳見"實現"小節）導致其
+他中斷沒有機會運行的缺陷。與'softlockup'情況類似，除了使用sysctl命令設置
+'hardlockup_panic'、使能內核選項“BOOTPARAM_HARDLOCKUP_PANIC”以及使用內核參數
+"nmi_watchdog"(詳見:”Documentation/admin-guide/kernel-parameters.rst“)外，一旦檢
+測到'hardlockup'默認情況下系統打印當前堆棧跟蹤信息，然後進入鎖定狀態。
+
+這個panic選項也可以與panic_timeout結合使用（這個panic_timeout是通過稍具迷惑性的
+sysctl命令"kernel.panic"來設置），使系統在panic指定時間後自動重啓。
+
+實現
+====
+
+Softlockup和hardlockup分別建立在hrtimer(高精度定時器)和perf兩個子系統上而實現。
+這也就意味着理論上任何架構只要實現了這兩個子系統就支持這兩種檢測機制。
+
+Hrtimer用於週期性產生中斷並喚醒watchdog線程；NMI perf事件則以”watchdog_thresh“
+(編譯時默認初始化爲10秒，也可通過”watchdog_thresh“這個sysctl接口來進行配置修改)
+爲間隔週期產生以檢測 hardlockups。如果一個CPU在這個時間段內沒有檢測到hrtimer中
+斷髮生，'hardlockup 檢測器'(即NMI perf事件處理函數)將會視系統配置而選擇產生內核
+警告或者直接panic。
+
+而watchdog線程本質上是一個高優先級內核線程，每調度一次就對時間戳進行一次更新。
+如果時間戳在2*watchdog_thresh(這個是softlockup的觸發門限)這段時間都未更新,那麼
+"softlocup 檢測器"(內部hrtimer定時器回調函數)會將相關的調試信息打印到系統日誌中，
+然後如果系統配置了進入panic流程則進入panic，否則內核繼續執行。
+
+Hrtimer定時器的週期是2*watchdog_thresh/5，也就是說在hardlockup被觸發前hrtimer有
+2~3次機會產生時鐘中斷。
+
+如上所述,內核相當於爲系統管理員提供了一個可調節hrtimer定時器和perf事件週期長度
+的調節旋鈕。如何通過這個旋鈕爲特定使用場景配置一個合理的週期值要對lockups檢測的
+響應速度和lockups檢測開銷這二者之間進行權衡。
+
+默認情況下所有在線cpu上都會運行一個watchdog線程。不過在內核配置了”NO_HZ_FULL“的
+情況下watchdog線程默認只會運行在管家(housekeeping)cpu上，而”nohz_full“啓動參數指
+定的cpu上則不會有watchdog線程運行。試想，如果我們允許watchdog線程在”nohz_full“指
+定的cpu上運行，這些cpu上必須得運行時鐘定時器來激發watchdog線程調度；這樣一來就會
+使”nohz_full“保護用戶程序免受內核干擾的功能失效。當然，副作用就是”nohz_full“指定
+的cpu即使在內核產生了lockup問題我們也無法檢測到。不過，至少我們可以允許watchdog
+線程在管家(non-tickless)核上繼續運行以便我們能繼續正常的監測這些cpus上的lockups
+事件。
+
+不論哪種情況都可以通過sysctl命令kernel.watchdog_cpumask來對沒有運行watchdog線程
+的cpu集合進行調節。對於nohz_full而言,如果nohz_full cpu上有異常掛住的情況，通過
+這種方式打開這些cpu上的watchdog進行調試可能會有所作用。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/index.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/index.rst
new file mode 100644
index 000000000000..a472eb3c708b
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/index.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/mm/damon/index.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+:校譯:
+
+============
+監測數據訪問
+============
+
+:doc:`DAMON </mm/damon/index>` 允許輕量級的數據訪問監測。使用DAMON，
+用戶可以分析他們系統的內存訪問模式，並優化它們。
+
+.. toctree::
+   :maxdepth: 2
+
+   start
+   usage
+   reclaim
+   lru_sort
+
+
+
+
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/lru_sort.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/lru_sort.rst
new file mode 100644
index 000000000000..1ffc4b6b1d12
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/lru_sort.rst
@@ -0,0 +1,264 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/mm/damon/lru_sort.rst
+
+:翻譯:
+
+ 臧雷剛 Leigang Zang <zangleigang@hisilicon.com>
+
+:校譯:
+
+==================
+基於DAMON的LRU排序
+==================
+
+基於DAMON的LRU排序是一個靜態的內核模塊，旨在用於以主動的、輕量級的數據訪問模型
+爲基礎的頁面優先級處理的LRU鏈表上，以使得LRU上的數據訪問模型更爲可信。
+
+哪裏需要主動的LRU排序
+=====================
+
+在一個大型系統中，以頁爲粒度的訪問檢測會有比較顯著的開銷，LRU通常不會主動去排序，
+而是對部分特殊事件進行部分的、響應式的排序，例如：特殊的用戶請求，系統調用或者
+內存壓力。這導致，在有些場景下，LRU不能夠完美的作爲一個可信的數據訪問模型，比如
+在內存壓力下對目標內存進行回收。
+
+因爲DAMON能夠儘可能準確的識別數據訪問模型，同時只引起用戶指定範圍的開銷，主動的
+執行DAMON_LRU_SORT讓LRU變得更爲可信是有益的，而且這隻需要較少和可控的開銷。
+
+這是如何工作的
+==============
+
+DAMON_LRU_SORT使用DAMON尋找熱頁（範圍內的頁面訪問頻率高於用戶指定的閾值）和冷頁
+（範圍內的頁面在超過用戶指定的時間無訪問），並提高熱頁和降低冷頁在LRU中的優先級。
+爲了避免在排序過程佔用更多的CPU計算資源，可以設置一個CPU佔用時間的約束值。在約
+束下，分別提升或者降低更多的熱頁和冷頁。系統管理員也可以配置三個內存水位以控制
+在何種條件下自動激活或者停止這種機制。
+
+冷熱閾值和CPU約束的默認值是比較保守的。這意味着，在默認參數下，模塊可以廣泛且無
+負作用的使用在常見環境中，同時在只消耗一小部分CPU時間的情況下，給有內存壓力的系
+統提供一定水平的冷熱識別。
+
+接口：模塊參數
+==============
+
+使用此特性，你首先需要確認你的系統中運行的內核在編譯時啓用了
+``CONFIG_DAMON_LRU_SORT=y``.
+
+爲了讓系統管理員打開或者關閉並且調節指定的系統，DAMON_LRU_SORT設計了模塊參數。
+這意味着，你可以添加 ``damon_lru_sort.<parameter>=<value>`` 到內核的啓動命令行
+參數，或者在 ``/sys/modules/damon_lru_sort/parameters/<parameter>`` 寫入正確的
+值。
+
+下邊是每個參數的描述
+
+enabled
+-------
+
+打開或者關閉DAMON_LRU_SORT.
+
+你可以通過設置這個參數爲 ``Y`` 來打開DAMON_LRU_SORT。設置爲 ``N`` 關閉
+DAMON_LRU_SORT。注意，在基於水位的激活的情況下，DAMON_LRU_SORT有可能不會真正去
+監測或者做LRU排序。對這種情況，參考下方關於水位的描述。
+
+commit_inputs
+-------------
+
+讓DAMON_LRU_SORT再次讀取輸入參數，除了 ``enabled`` 。
+
+在DAMON_LRU_SORT運行時，新的輸入參數默認不會被應用。一旦這個參數被設置爲 ``Y``
+，DAMON_LRU_SORT會再次讀取除了 ``enabled`` 之外的參數。讀取完成後，這個參數會被
+設置爲 ``N`` 。如果在讀取時發現有無效參數，DAMON_LRU_SORT會被關閉。
+
+hot_thres_access_freq
+---------------------
+
+熱點內存區域的訪問頻率閾值，千分比。
+
+如果一個內存區域的訪問頻率大於等於這個值，DAMON_LRU_SORT把這個區域看作熱區，並
+在LRU上把這個區域標記爲已訪問，因些在內存壓力下這部分內存不會被回收。默認爲50%。
+
+cold_min_age
+------------
+
+用於識別冷內存區域的時間閾值，單位是微秒。
+
+如果一個內存區域在這個時間內未被訪問過，DAMON_LRU_SORT把這個區域看作冷區，並在
+LRU上把這個區域標記爲未訪問，因此在內存壓力下這些內存會首先被回收。默認值爲120
+秒。
+
+quota_ms
+--------
+
+嘗試LRU鏈表排序的時間限制，單位是毫秒。
+
+DAMON_LRU_SORT在一個時間窗口內（quota_reset_interval_ms）內最多嘗試這麼長時間來
+對LRU進行排序。這個可以用來作爲CPU計算資源的約束。如果值爲0，則表示無限制。
+
+默認10毫秒。
+
+quota_reset_interval_ms
+-----------------------
+
+配額計時重置週期，毫秒。
+
+配額計時重置週期。即，在quota_reset_interval_ms毫秒內，DAMON_LRU_SORT對LRU進行
+排序不會超過quota_ms或者quota_sz。
+
+默認1秒。
+
+wmarks_interval
+---------------
+
+水位的檢查週期，單位是微秒。
+
+當DAMON_LRU_SORT使能但是由於水位而不活躍時檢查水位前最小的等待時間。默認值5秒。
+
+wmarks_high
+-----------
+
+空閒內存高水位，千分比。
+
+如果空閒內存水位高於這個值，DAMON_LRU_SORT停止工作，不做任何事，除了週期性的檢
+查水位。默認200(20%)。
+
+wmarks_mid
+----------
+
+空閒內存中間水位，千分比。
+
+如果空閒內存水位在這個值與低水位之間，DAMON_LRU_SORT開始工作，開始檢測並對LRU鏈
+表進行排序。默認150(15%)。
+
+wmarks_low
+----------
+
+空閒內存低水位，千分比。
+
+如果空閒內存小於這個值，DAMON_LRU_SORT不再工作，不做任何事，除了週期性的檢查水
+線。默認50(5%)。
+
+sample_interval
+---------------
+
+監測的採樣週期，微秒。
+
+DAMON對冷內存監測的採樣週期。更多細節請參考DAMON文檔 (:doc:`usage`) 。默認5
+毫秒。
+
+aggr_interval
+-------------
+
+監測的收集週期，微秒。
+
+DAMON對冷內存進行收集的時間週期。更多細節請參考DAMON文檔 (:doc:`usage`) 。默認
+100毫秒。
+
+min_nr_regions
+--------------
+
+最小監測區域數量。
+
+對冷內存區域監測的最小數量。這個值可以作爲監測質量的下限。不過，這個值設置的過
+大會增加開銷。更多細節請參考DAMON文檔 (:doc:`usage`) 。默認值爲10。
+
+max_nr_regions
+--------------
+
+最大監測區域數量。
+
+對冷內存區域監測的最大數量。這個值可以作爲監測質量的上限。然而，這個值設置的過
+低會導致監測結果變差。更多細節請參考DAMON文檔 (:doc:`usage`) 。默認值爲1000。
+
+monitor_region_start
+--------------------
+
+目標內存區域的起始物理地址。
+
+DAMON_LRU_SORT要處理的目標內存區域的起始物理地址。默認，使用系統最大內存。
+
+monitor_region_end
+------------------
+
+目標內存區域的結束物理地址。
+
+DAMON_LRU_SORT要處理的目標內存區域的結束物理地址。默認，使用系統最大內存。
+
+kdamond_pid
+-----------
+
+DAMON線程的PID。
+
+如果DAMON_LRU_SORT是使能的，這個表示任務線程的PID。其它情況爲-1。
+
+nr_lru_sort_tried_hot_regions
+-----------------------------
+
+被嘗試進行LRU排序的熱內存區域的數量。
+
+bytes_lru_sort_tried_hot_regions
+--------------------------------
+
+被嘗試進行LRU排序的熱內存區域的大小（字節）。
+
+nr_lru_sorted_hot_regions
+-------------------------
+
+成功進行LRU排序的熱內存區域的數量。
+
+bytes_lru_sorted_hot_regions
+----------------------------
+
+成功進行LRU排序的熱內存區域的大小（字節）。
+
+nr_hot_quota_exceeds
+--------------------
+
+熱區域時間約束超過限制的次數。
+
+nr_lru_sort_tried_cold_regions
+------------------------------
+
+被嘗試進行LRU排序的冷內存區域的數量。
+
+bytes_lru_sort_tried_cold_regions
+---------------------------------
+
+被嘗試進行LRU排序的冷內存區域的大小（字節）。
+
+nr_lru_sorted_cold_regions
+--------------------------
+
+成功進行LRU排序的冷內存區域的數量。
+
+bytes_lru_sorted_cold_regions
+-----------------------------
+
+成功進行LRU排序的冷內存區域的大小（字節）。
+
+nr_cold_quota_exceeds
+---------------------
+
+冷區域時間約束超過限制的次數。
+
+Example
+=======
+
+如下是一個運行時的命令示例，使DAMON_LRU_SORT查找訪問頻率超過50%的區域並對其進行
+LRU的優先級的提升，同時降低那些超過120秒無人訪問的內存區域的優先級。優先級的處
+理被限制在最多1%的CPU以避免DAMON_LRU_SORT消費過多CPU時間。在系統空閒內存超過50%
+時DAMON_LRU_SORT停止工作，並在低於40%時重新開始工作。如果DAMON_RECLAIM沒有取得
+進展且空閒內存低於20%，再次讓DAMON_LRU_SORT停止工作，以此回退到以LRU鏈表爲基礎
+以頁面爲單位的內存回收上。 ::
+
+    # cd /sys/modules/damon_lru_sort/parameters
+    # echo 500 > hot_thres_access_freq
+    # echo 120000000 > cold_min_age
+    # echo 10 > quota_ms
+    # echo 1000 > quota_reset_interval_ms
+    # echo 500 > wmarks_high
+    # echo 400 > wmarks_mid
+    # echo 200 > wmarks_low
+    # echo Y > enabled
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/reclaim.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/reclaim.rst
new file mode 100644
index 000000000000..efed29c40e44
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/reclaim.rst
@@ -0,0 +1,229 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/mm/damon/reclaim.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+:校譯:
+
+===============
+基於DAMON的回收
+===============
+
+基於DAMON的回收（DAMON_RECLAIM）是一個靜態的內核模塊，旨在用於輕度內存壓力下的主動和輕
+量級的回收。它的目的不是取代基於LRU列表的頁面回收，而是有選擇地用於不同程度的內存壓力和要
+求。
+
+哪些地方需要主動回收？
+======================
+
+在一般的內存超量使用（over-committed systems，虛擬化相關術語）的系統上，主動回收冷頁
+有助於節省內存和減少延遲高峯，這些延遲是由直接回收進程或kswapd的CPU消耗引起的，同時只產
+生最小的性能下降 [1]_ [2]_ 。
+
+基於空閒頁報告 [3]_ 的內存過度承諾的虛擬化系統就是很好的例子。在這樣的系統中，客戶機
+向主機報告他們的空閒內存，而主機則將報告的內存重新分配給其他客戶。因此，系統的內存得到了充
+分的利用。然而，客戶可能不那麼節省內存，主要是因爲一些內核子系統和用戶空間應用程序被設計爲
+使用盡可能多的內存。然後，客戶機可能只向主機報告少量的內存是空閒的，導致系統的內存利用率下降。
+在客戶中運行主動回收可以緩解這個問題。
+
+它是如何工作的？
+================
+
+DAMON_RECLAIM找到在特定時間內沒有被訪問的內存區域並分頁。爲了避免它在分頁操作中消耗過多
+的CPU，可以配置一個速度限制。在這個速度限制下，它首先分頁出那些沒有被訪問過的內存區域。系
+統管理員還可以配置在什麼情況下這個方案應該自動激活和停用三個內存壓力水位。
+
+接口: 模塊參數
+==============
+
+要使用這個功能，你首先要確保你的系統運行在一個以 ``CONFIG_DAMON_RECLAIM=y`` 構建的內
+核上。
+
+爲了讓系統管理員啓用或禁用它，併爲給定的系統進行調整，DAMON_RECLAIM利用了模塊參數。也就
+是說，你可以把 ``damon_reclaim.<parameter>=<value>`` 放在內核啓動命令行上，或者把
+適當的值寫入 ``/sys/module/damon_reclaim/parameters/<parameter>`` 文件。
+
+下面是每個參數的描述。
+
+enabled
+-------
+
+啓用或禁用DAMON_RECLAIM。
+
+你可以通過把這個參數的值設置爲 ``Y`` 來啓用DAMON_RCLAIM，把它設置爲 ``N`` 可以禁用
+DAMON_RECLAIM。注意，由於基於水位的激活條件，DAMON_RECLAIM不能進行真正的監測和回收。
+這一點請參考下面關於水位參數的描述。
+
+min_age
+-------
+
+識別冷內存區域的時間閾值，單位是微秒。
+
+如果一個內存區域在這個時間或更長的時間內沒有被訪問，DAMON_RECLAIM會將該區域識別爲冷的，
+並回收它。
+
+默認爲120秒。
+
+quota_ms
+--------
+
+回收的時間限制，以毫秒爲單位。
+
+DAMON_RECLAIM 試圖在一個時間窗口（quota_reset_interval_ms）內只使用到這個時間，以
+嘗試回收冷頁。這可以用來限制DAMON_RECLAIM的CPU消耗。如果該值爲零，則該限制被禁用。
+
+默認爲10ms。
+
+quota_sz
+--------
+
+回收的內存大小限制，單位爲字節。
+
+DAMON_RECLAIM 收取在一個時間窗口（quota_reset_interval_ms）內試圖回收的內存量，並
+使其不超過這個限制。這可以用來限制CPU和IO的消耗。如果該值爲零，則限制被禁用。
+
+默認情況下是128 MiB。
+
+quota_reset_interval_ms
+-----------------------
+
+時間/大小配額收取重置間隔，單位爲毫秒。
+
+時間（quota_ms）和大小（quota_sz）的配額的目標重置間隔。也就是說，DAMON_RECLAIM在
+嘗試回收‘不’超過quota_ms毫秒或quota_sz字節的內存。
+
+默認爲1秒。
+
+wmarks_interval
+---------------
+
+當DAMON_RECLAIM被啓用但由於其水位規則而不活躍時，在檢查水位之前的最小等待時間。
+
+wmarks_high
+-----------
+
+高水位的可用內存率（每千字節）。
+
+如果系統的可用內存（以每千字節爲單位）高於這個數值，DAMON_RECLAIM就會變得不活躍，所以
+它什麼也不做，只是定期檢查水位。
+
+wmarks_mid
+----------
+
+中間水位的可用內存率（每千字節）。
+
+如果系統的空閒內存（以每千字節爲單位）在這個和低水位線之間，DAMON_RECLAIM就會被激活，
+因此開始監測和回收。
+
+wmarks_low
+----------
+
+低水位的可用內存率（每千字節）。
+
+如果系統的空閒內存（以每千字節爲單位）低於這個數值，DAMON_RECLAIM就會變得不活躍，所以
+它除了定期檢查水位外什麼都不做。在這種情況下，系統會退回到基於LRU列表的頁面粒度回收邏輯。
+
+sample_interval
+---------------
+
+監測的採樣間隔，單位是微秒。
+
+DAMON用於監測冷內存的採樣間隔。更多細節請參考DAMON文檔 (:doc:`usage`) 。
+
+aggr_interval
+-------------
+
+監測的聚集間隔，單位是微秒。
+
+DAMON對冷內存監測的聚集間隔。更多細節請參考DAMON文檔 (:doc:`usage`)。
+
+min_nr_regions
+--------------
+
+監測區域的最小數量。
+
+DAMON用於冷內存監測的最小監測區域數。這可以用來設置監測質量的下限。但是，設
+置的太高可能會導致監測開銷的增加。更多細節請參考DAMON文檔 (:doc:`usage`) 。
+
+max_nr_regions
+--------------
+
+監測區域的最大數量。
+
+DAMON用於冷內存監測的最大監測區域數。這可以用來設置監測開銷的上限值。但是，
+設置得太低可能會導致監測質量不好。更多細節請參考DAMON文檔 (:doc:`usage`) 。
+
+monitor_region_start
+--------------------
+
+目標內存區域的物理地址起點。
+
+DAMON_RECLAIM將對其進行工作的內存區域的起始物理地址。也就是說，DAMON_RECLAIM
+將在這個區域中找到冷的內存區域並進行回收。默認情況下，該區域使用最大系統內存區。
+
+monitor_region_end
+------------------
+
+目標內存區域的結束物理地址。
+
+DAMON_RECLAIM將對其進行工作的內存區域的末端物理地址。也就是說，DAMON_RECLAIM將
+在這個區域內找到冷的內存區域並進行回收。默認情況下，該區域使用最大系統內存區。
+
+kdamond_pid
+-----------
+
+DAMON線程的PID。
+
+如果DAMON_RECLAIM被啓用，這將成爲工作線程的PID。否則，爲-1。
+
+nr_reclaim_tried_regions
+------------------------
+
+試圖通過DAMON_RECLAIM回收的內存區域的數量。
+
+bytes_reclaim_tried_regions
+---------------------------
+
+試圖通過DAMON_RECLAIM回收的內存區域的總字節數。
+
+nr_reclaimed_regions
+--------------------
+
+通過DAMON_RECLAIM成功回收的內存區域的數量。
+
+bytes_reclaimed_regions
+-----------------------
+
+通過DAMON_RECLAIM成功回收的內存區域的總字節數。
+
+nr_quota_exceeds
+----------------
+
+超過時間/空間配額限制的次數。
+
+例子
+====
+
+下面的運行示例命令使DAMON_RECLAIM找到30秒或更長時間沒有訪問的內存區域並“回收”？
+爲了避免DAMON_RECLAIM在分頁操作中消耗過多的CPU時間，回收被限制在每秒1GiB以內。
+它還要求DAMON_RECLAIM在系統的可用內存率超過50%時不做任何事情，但如果它低於40%時
+就開始真正的工作。如果DAMON_RECLAIM沒有取得進展，因此空閒內存率低於20%，它會要求
+DAMON_RECLAIM再次什麼都不做，這樣我們就可以退回到基於LRU列表的頁面粒度回收了::
+
+    # cd /sys/module/damon_reclaim/parameters
+    # echo 30000000 > min_age
+    # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
+    # echo 1000 > quota_reset_interval_ms
+    # echo 500 > wmarks_high
+    # echo 400 > wmarks_mid
+    # echo 200 > wmarks_low
+    # echo Y > enabled
+
+.. [1] https://research.google/pubs/pub48551/
+.. [2] https://lwn.net/Articles/787611/
+.. [3] https://www.kernel.org/doc/html/latest/mm/free_page_reporting.html
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
new file mode 100644
index 000000000000..1822956be0e0
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/mm/damon/start.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+:校譯:
+
+========
+入門指南
+========
+
+本文通過演示DAMON的默認用戶空間工具，簡要地介紹瞭如何使用DAMON。請注意，爲了簡潔
+起見，本文檔只描述了它的部分功能。更多細節請參考該工具的使用文檔。
+`doc <https://github.com/awslabs/damo/blob/next/USAGE.md>`_ .
+
+
+前提條件
+========
+
+內核
+----
+
+首先，你要確保你當前系統中跑的內核構建時選定了這個功能選項 ``CONFIG_DAMON_*=y``.
+
+
+用戶空間工具
+------------
+
+在演示中，我們將使用DAMON的默認用戶空間工具，稱爲DAMON Operator（DAMO）。它可以在
+https://github.com/awslabs/damo找到。下面的例子假設DAMO在你的$PATH上。當然，但
+這並不是強制性的。
+
+因爲DAMO使用了DAMON的sysfs接口（詳情請參考:doc:`usage`），你應該確保
+:doc:`sysfs </filesystems/sysfs>` 被掛載。
+
+記錄數據訪問模式
+================
+
+下面的命令記錄了一個程序的內存訪問模式，並將監測結果保存到文件中。 ::
+
+    $ git clone https://github.com/sjp38/masim
+    $ cd masim; make; ./masim ./configs/zigzag.cfg &
+    $ sudo damo record -o damon.data $(pidof masim)
+
+命令的前兩行下載了一個人工內存訪問生成器程序並在後臺運行。生成器將重複地逐一訪問兩個
+100 MiB大小的內存區域。你可以用你的真實工作負載來代替它。最後一行要求 ``damo`` 將
+訪問模式記錄在 ``damon.data`` 文件中。
+
+
+將記錄的模式可視化
+==================
+
+你可以在heatmap中直觀地看到這種模式，顯示哪個內存區域（X軸）何時被訪問（Y軸）以及訪
+問的頻率（數字）。::
+
+    $ sudo damo report heats --heatmap stdout
+    22222222222222222222222222222222222222211111111111111111111111111111111111111100
+    44444444444444444444444444444444444444434444444444444444444444444444444444443200
+    44444444444444444444444444444444444444433444444444444444444444444444444444444200
+    33333333333333333333333333333333333333344555555555555555555555555555555555555200
+    33333333333333333333333333333333333344444444444444444444444444444444444444444200
+    22222222222222222222222222222222222223355555555555555555555555555555555555555200
+    00000000000000000000000000000000000000288888888888888888888888888888888888888400
+    00000000000000000000000000000000000000288888888888888888888888888888888888888400
+    33333333333333333333333333333333333333355555555555555555555555555555555555555200
+    88888888888888888888888888888888888888600000000000000000000000000000000000000000
+    88888888888888888888888888888888888888600000000000000000000000000000000000000000
+    33333333333333333333333333333333333333444444444444444444444444444444444444443200
+    00000000000000000000000000000000000000288888888888888888888888888888888888888400
+    [...]
+    # access_frequency:  0  1  2  3  4  5  6  7  8  9
+    # x-axis: space (139728247021568-139728453431248: 196.848 MiB)
+    # y-axis: time (15256597248362-15326899978162: 1 m 10.303 s)
+    # resolution: 80x40 (2.461 MiB and 1.758 s for each character)
+
+你也可以直觀地看到工作集的大小分佈，按大小排序。::
+
+    $ sudo damo report wss --range 0 101 10
+    # <percentile> <wss>
+    # target_id     18446632103789443072
+    # avr:  107.708 MiB
+      0             0 B |                                                           |
+     10      95.328 MiB |****************************                               |
+     20      95.332 MiB |****************************                               |
+     30      95.340 MiB |****************************                               |
+     40      95.387 MiB |****************************                               |
+     50      95.387 MiB |****************************                               |
+     60      95.398 MiB |****************************                               |
+     70      95.398 MiB |****************************                               |
+     80      95.504 MiB |****************************                               |
+     90     190.703 MiB |*********************************************************  |
+    100     196.875 MiB |***********************************************************|
+
+在上述命令中使用 ``--sortby`` 選項，可以顯示工作集的大小是如何按時間順序變化的。::
+
+    $ sudo damo report wss --range 0 101 10 --sortby time
+    # <percentile> <wss>
+    # target_id     18446632103789443072
+    # avr:  107.708 MiB
+      0       3.051 MiB |                                                           |
+     10     190.703 MiB |***********************************************************|
+     20      95.336 MiB |*****************************                              |
+     30      95.328 MiB |*****************************                              |
+     40      95.387 MiB |*****************************                              |
+     50      95.332 MiB |*****************************                              |
+     60      95.320 MiB |*****************************                              |
+     70      95.398 MiB |*****************************                              |
+     80      95.398 MiB |*****************************                              |
+     90      95.340 MiB |*****************************                              |
+    100      95.398 MiB |*****************************                              |
+
+
+數據訪問模式感知的內存管理
+==========================
+
+以下三個命令使每一個大小>=4K的內存區域在你的工作負載中沒有被訪問>=60秒，就會被換掉。 ::
+
+    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > test_scheme
+    $ echo "4K        max      0       0       60s     max     pageout" >> test_scheme
+    $ damo schemes -c test_scheme <pid of your workload>
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
new file mode 100644
index 000000000000..6dee719a32ea
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
@@ -0,0 +1,592 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/mm/damon/usage.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+:校譯:
+
+========
+詳細用法
+========
+
+DAMON 爲不同的用戶提供了下面這些接口。
+
+- *DAMON用戶空間工具。*
+  `這 <https://github.com/awslabs/damo>`_ 爲有這特權的人， 如系統管理員，希望有一個剛好
+  可以工作的人性化界面。
+  使用它，用戶可以以人性化的方式使用DAMON的主要功能。不過，它可能不會爲特殊情況進行高度調整。
+  它同時支持虛擬和物理地址空間的監測。更多細節，請參考它的 `使用文檔
+  <https://github.com/awslabs/damo/blob/next/USAGE.md>`_。
+- *sysfs接口。*
+  :ref:`這 <sysfs_interface>` 是爲那些希望更高級的使用DAMON的特權用戶空間程序員準備的。
+  使用它，用戶可以通過讀取和寫入特殊的sysfs文件來使用DAMON的主要功能。因此，你可以編寫和使
+  用你個性化的DAMON sysfs包裝程序，代替你讀/寫sysfs文件。  `DAMON用戶空間工具
+  <https://github.com/awslabs/damo>`_ 就是這種程序的一個例子  它同時支持虛擬和物理地址
+  空間的監測。注意，這個界面只提供簡單的監測結果 :ref:`統計 <damos_stats>`。對於詳細的監測
+  結果，DAMON提供了一個:ref:`跟蹤點 <tracepoint>`。
+- *debugfs interface.*
+  :ref:`這 <debugfs_interface>` 幾乎與:ref:`sysfs interface <sysfs_interface>` 接
+  口相同。這將在下一個LTS內核發佈後被移除，所以用戶應該轉移到
+  :ref:`sysfs interface <sysfs_interface>`。
+- *內核空間編程接口。*
+  :doc:`這 </mm/damon/api>` 這是爲內核空間程序員準備的。使用它，用戶可以通過爲你編寫內
+  核空間的DAMON應用程序，最靈活有效地利用DAMON的每一個功能。你甚至可以爲各種地址空間擴展DAMON。
+  詳細情況請參考接口 :doc:`文件 </mm/damon/api>`。
+
+sysfs接口
+=========
+DAMON的sysfs接口是在定義 ``CONFIG_DAMON_SYSFS`` 時建立的。它在其sysfs目錄下創建多
+個目錄和文件， ``<sysfs>/kernel/mm/damon/`` 。你可以通過對該目錄下的文件進行寫入和
+讀取來控制DAMON。
+
+對於一個簡短的例子，用戶可以監測一個給定工作負載的虛擬地址空間，如下所示::
+
+    # cd /sys/kernel/mm/damon/admin/
+    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
+    # echo vaddr > kdamonds/0/contexts/0/operations
+    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
+    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
+    # echo on > kdamonds/0/state
+
+文件層次結構
+------------
+
+DAMON sysfs接口的文件層次結構如下圖所示。在下圖中，父子關係用縮進表示，每個目錄有
+``/`` 後綴，每個目錄中的文件用逗號（","）分開。 ::
+
+    /sys/kernel/mm/damon/admin
+    │ kdamonds/nr_kdamonds
+    │ │ 0/state,pid
+    │ │ │ contexts/nr_contexts
+    │ │ │ │ 0/operations
+    │ │ │ │ │ monitoring_attrs/
+    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
+    │ │ │ │ │ │ nr_regions/min,max
+    │ │ │ │ │ targets/nr_targets
+    │ │ │ │ │ │ 0/pid_target
+    │ │ │ │ │ │ │ regions/nr_regions
+    │ │ │ │ │ │ │ │ 0/start,end
+    │ │ │ │ │ │ │ │ ...
+    │ │ │ │ │ │ ...
+    │ │ │ │ │ schemes/nr_schemes
+    │ │ │ │ │ │ 0/action
+    │ │ │ │ │ │ │ access_pattern/
+    │ │ │ │ │ │ │ │ sz/min,max
+    │ │ │ │ │ │ │ │ nr_accesses/min,max
+    │ │ │ │ │ │ │ │ age/min,max
+    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
+    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
+    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ │ tried_regions/
+    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
+    │ │ │ │ │ │ │ │ ...
+    │ │ │ │ │ │ ...
+    │ │ │ │ ...
+    │ │ ...
+
+根
+--
+
+DAMON sysfs接口的根是 ``<sysfs>/kernel/mm/damon/`` ，它有一個名爲 ``admin`` 的
+目錄。該目錄包含特權用戶空間程序控制DAMON的文件。擁有根權限的用戶空間工具或deamons可以
+使用這個目錄。
+
+kdamonds/
+---------
+
+與監測相關的信息包括請求規格和結果被稱爲DAMON上下文。DAMON用一個叫做kdamond的內核線程
+執行每個上下文，多個kdamonds可以並行運行。
+
+在 ``admin`` 目錄下，有一個目錄，即``kdamonds``，它有控制kdamonds的文件存在。在開始
+時，這個目錄只有一個文件，``nr_kdamonds``。向該文件寫入一個數字（``N``），就會創建名爲
+``0`` 到 ``N-1`` 的子目錄數量。每個目錄代表每個kdamond。
+
+kdamonds/<N>/
+-------------
+
+在每個kdamond目錄中，存在兩個文件（``state`` 和 ``pid`` ）和一個目錄( ``contexts`` )。
+
+讀取 ``state`` 時，如果kdamond當前正在運行，則返回 ``on`` ，如果沒有運行則返回 ``off`` 。
+寫入 ``on`` 或 ``off`` 使kdamond處於狀態。向 ``state`` 文件寫 ``update_schemes_stats`` ，
+更新kdamond的每個基於DAMON的操作方案的統計文件的內容。關於統計信息的細節，請參考
+:ref:`stats section <sysfs_schemes_stats>`. 將 ``update_schemes_tried_regions`` 寫到
+``state`` 文件，爲kdamond的每個基於DAMON的操作方案，更新基於DAMON的操作方案動作的嘗試區域目錄。
+將`clear_schemes_tried_regions`寫入`state`文件，清除kdamond的每個基於DAMON的操作方案的動作
+嘗試區域目錄。 關於基於DAMON的操作方案動作嘗試區域目錄的細節，請參考:ref:tried_regions 部分
+<sysfs_schemes_tried_regions>`。
+
+如果狀態爲 ``on``，讀取 ``pid`` 顯示kdamond線程的pid。
+
+``contexts`` 目錄包含控制這個kdamond要執行的監測上下文的文件。
+
+kdamonds/<N>/contexts/
+----------------------
+
+在開始時，這個目錄只有一個文件，即 ``nr_contexts`` 。向該文件寫入一個數字( ``N`` )，就會創
+建名爲``0`` 到 ``N-1`` 的子目錄數量。每個目錄代表每個監測背景。目前，每個kdamond只支持
+一個上下文，所以只有 ``0`` 或 ``1`` 可以被寫入文件。
+
+contexts/<N>/
+-------------
+
+在每個上下文目錄中，存在一個文件(``operations``)和三個目錄(``monitoring_attrs``,
+``targets``, 和 ``schemes``)。
+
+DAMON支持多種類型的監測操作，包括對虛擬地址空間和物理地址空間的監測。你可以通過向文件
+中寫入以下關鍵詞之一，並從文件中讀取，來設置和獲取DAMON將爲上下文使用何種類型的監測操作。
+
+ - vaddr: 監測特定進程的虛擬地址空間
+ - paddr: 監視系統的物理地址空間
+
+contexts/<N>/monitoring_attrs/
+------------------------------
+
+用於指定監測屬性的文件，包括所需的監測質量和效率，都在 ``monitoring_attrs`` 目錄中。
+具體來說，這個目錄下有兩個目錄，即 ``intervals`` 和 ``nr_regions`` 。
+
+在 ``intervals`` 目錄下，存在DAMON的採樣間隔(``sample_us``)、聚集間隔(``aggr_us``)
+和更新間隔(``update_us``)三個文件。你可以通過寫入和讀出這些文件來設置和獲取微秒級的值。
+
+在 ``nr_regions`` 目錄下，有兩個文件分別用於DAMON監測區域的下限和上限（``min`` 和 ``max`` ），
+這兩個文件控制着監測的開銷。你可以通過向這些文件的寫入和讀出來設置和獲取這些值。
+
+關於間隔和監測區域範圍的更多細節，請參考設計文件 (:doc:`/mm/damon/design`)。
+
+contexts/<N>/targets/
+---------------------
+
+在開始時，這個目錄只有一個文件 ``nr_targets`` 。向該文件寫入一個數字(``N``)，就可以創建
+名爲 ``0`` 到 ``N-1`` 的子目錄的數量。每個目錄代表每個監測目標。
+
+targets/<N>/
+------------
+
+在每個目標目錄中，存在一個文件(``pid_target``)和一個目錄(``regions``)。
+
+如果你把 ``vaddr`` 寫到 ``contexts/<N>/operations`` 中，每個目標應該是一個進程。你
+可以通過將進程的pid寫到 ``pid_target`` 文件中來指定DAMON的進程。
+
+targets/<N>/regions
+-------------------
+
+當使用 ``vaddr`` 監測操作集時（ ``vaddr`` 被寫入 ``contexts/<N>/operations`` 文
+件），DAMON自動設置和更新監測目標區域，這樣就可以覆蓋目標進程的整個內存映射。然而，用戶可
+能希望將初始監測區域設置爲特定的地址範圍。
+
+相反，當使用 ``paddr`` 監測操作集時，DAMON不會自動設置和更新監測目標區域（ ``paddr``
+被寫入 ``contexts/<N>/operations`` 中）。因此，在這種情況下，用戶應該自己設置監測目標
+區域。
+
+在這種情況下，用戶可以按照自己的意願明確設置初始監測目標區域，將適當的值寫入該目錄下的文件。
+
+開始時，這個目錄只有一個文件， ``nr_regions`` 。向該文件寫入一個數字(``N``)，就可以創
+建名爲 ``0`` 到  ``N-1`` 的子目錄。每個目錄代表每個初始監測目標區域。
+
+regions/<N>/
+------------
+
+在每個區域目錄中，你會發現兩個文件（ ``start``  和  ``end`` ）。你可以通過向文件寫入
+和從文件中讀出，分別設置和獲得初始監測目標區域的起始和結束地址。
+
+每個區域不應該與其他區域重疊。 目錄“N”的“結束”應等於或小於目錄“N+1”的“開始”。
+
+contexts/<N>/schemes/
+---------------------
+
+對於一版的基於DAMON的數據訪問感知的內存管理優化，用戶通常希望系統對特定訪問模式的內存區
+域應用內存管理操作。DAMON從用戶那裏接收這種形式化的操作方案，並將這些方案應用於目標內存
+區域。用戶可以通過讀取和寫入這個目錄下的文件來獲得和設置這些方案。
+
+在開始時，這個目錄只有一個文件，``nr_schemes``。向該文件寫入一個數字(``N``)，就可以
+創建名爲``0``到``N-1``的子目錄的數量。每個目錄代表每個基於DAMON的操作方案。
+
+schemes/<N>/
+------------
+
+在每個方案目錄中，存在五個目錄(``access_pattern``、``quotas``、``watermarks``、
+``stats`` 和 ``tried_regions``)和一個文件(``action``)。
+
+``action`` 文件用於設置和獲取你想應用於具有特定訪問模式的內存區域的動作。可以寫入文件
+和從文件中讀取的關鍵詞及其含義如下。
+
+ - ``willneed``: 對有 ``MADV_WILLNEED`` 的區域調用 ``madvise()`` 。
+ - ``cold``: 對具有 ``MADV_COLD`` 的區域調用 ``madvise()`` 。
+ - ``pageout``: 爲具有 ``MADV_PAGEOUT`` 的區域調用 ``madvise()`` 。
+ - ``hugepage``: 爲帶有 ``MADV_HUGEPAGE`` 的區域調用 ``madvise()`` 。
+ - ``nohugepage``: 爲帶有 ``MADV_NOHUGEPAGE`` 的區域調用 ``madvise()``。
+ - ``lru_prio``: 在其LRU列表上對區域進行優先排序。
+ - ``lru_deprio``: 對區域的LRU列表進行降低優先處理。
+ - ``stat``: 什麼都不做，只計算統計數據
+
+schemes/<N>/access_pattern/
+---------------------------
+
+每個基於DAMON的操作方案的目標訪問模式由三個範圍構成，包括以字節爲單位的區域大小、每個
+聚合區間的監測訪問次數和區域年齡的聚合區間數。
+
+在 ``access_pattern`` 目錄下，存在三個目錄（ ``sz``, ``nr_accesses``, 和 ``age`` ），
+每個目錄有兩個文件（``min`` 和 ``max`` ）。你可以通過向  ``sz``, ``nr_accesses``, 和
+``age``  目錄下的 ``min`` 和 ``max`` 文件分別寫入和讀取來設置和獲取給定方案的訪問模式。
+
+schemes/<N>/quotas/
+-------------------
+
+每個 ``動作`` 的最佳 ``目標訪問模式`` 取決於工作負載，所以不容易找到。更糟糕的是，將某些動作
+的方案設置得過於激進會造成嚴重的開銷。爲了避免這種開銷，用戶可以爲每個方案限制時間和大小配額。
+具體來說，用戶可以要求DAMON儘量只使用特定的時間（``時間配額``）來應用動作，並且在給定的時間間
+隔（``重置間隔``）內，只對具有目標訪問模式的內存區域應用動作，而不使用特定數量（``大小配額``）。
+
+當預計超過配額限制時，DAMON會根據 ``目標訪問模式`` 的大小、訪問頻率和年齡，對找到的內存區域
+進行優先排序。爲了進行個性化的優先排序，用戶可以爲這三個屬性設置權重。
+
+在 ``quotas`` 目錄下，存在三個文件（``ms``, ``bytes``, ``reset_interval_ms``）和一個
+目錄(``weights``)，其中有三個文件(``sz_permil``, ``nr_accesses_permil``, 和
+``age_permil``)。
+
+你可以設置以毫秒爲單位的 ``時間配額`` ，以字節爲單位的 ``大小配額`` ，以及以毫秒爲單位的 ``重
+置間隔`` ，分別向這三個文件寫入數值。你還可以通過向 ``weights`` 目錄下的三個文件寫入數值來設
+置大小、訪問頻率和年齡的優先權，單位爲千分之一。
+
+schemes/<N>/watermarks/
+-----------------------
+
+爲了便於根據系統狀態激活和停用每個方案，DAMON提供了一個稱爲水位的功能。該功能接收五個值，稱爲
+``度量`` 、``間隔`` 、``高`` 、``中`` 、``低`` 。``度量值`` 是指可以測量的系統度量值，如
+自由內存比率。如果系統的度量值 ``高`` 於memoent的高值或 ``低`` 於低值，則該方案被停用。如果
+該值低於 ``中`` ，則該方案被激活。
+
+在水位目錄下，存在五個文件(``metric``, ``interval_us``,``high``, ``mid``, and ``low``)
+用於設置每個值。你可以通過向這些文件的寫入來分別設置和獲取這五個值。
+
+可以寫入 ``metric`` 文件的關鍵詞和含義如下。
+
+ - none: 忽略水位
+ - free_mem_rate: 系統的自由內存率（千分比）。
+
+``interval`` 應以微秒爲單位寫入。
+
+schemes/<N>/stats/
+------------------
+
+DAMON統計每個方案被嘗試應用的區域的總數量和字節數，每個方案被成功應用的區域的兩個數字，以及
+超過配額限制的總數量。這些統計數據可用於在線分析或調整方案。
+
+可以通過讀取 ``stats`` 目錄下的文件(``nr_tried``, ``sz_tried``, ``nr_applied``,
+``sz_applied``, 和 ``qt_exceeds``)）分別檢索這些統計數據。這些文件不是實時更新的，所以
+你應該要求DAMON sysfs接口通過在相關的 ``kdamonds/<N>/state`` 文件中寫入一個特殊的關鍵字
+``update_schemes_stats`` 來更新統計信息的文件內容。
+
+schemes/<N>/tried_regions/
+--------------------------
+
+當一個特殊的關鍵字 ``update_schemes_tried_regions`` 被寫入相關的 ``kdamonds/<N>/state``
+文件時，DAMON會在這個目錄下創建從 ``0`` 開始命名的整數目錄。每個目錄包含的文件暴露了關於每個
+內存區域的詳細信息，在下一個 :ref:`聚集區間 <sysfs_monitoring_attrs>`，相應的方案的 ``動作``
+已經嘗試在這個目錄下應用。這些信息包括地址範圍、``nr_accesses`` 以及區域的 ``年齡`` 。
+
+當另一個特殊的關鍵字 ``clear_schemes_tried_regions`` 被寫入相關的 ``kdamonds/<N>/state``
+文件時，這些目錄將被刪除。
+
+tried_regions/<N>/
+------------------
+
+在每個區域目錄中，你會發現四個文件(``start``, ``end``, ``nr_accesses``, and ``age``)。
+讀取這些文件將顯示相應的基於DAMON的操作方案 ``動作`` 試圖應用的區域的開始和結束地址、``nr_accesses``
+和 ``年齡`` 。
+
+用例
+~~~~
+
+下面的命令應用了一個方案：”如果一個大小爲[4KiB, 8KiB]的內存區域在[10, 20]的聚合時間間隔內
+顯示出每一個聚合時間間隔[0, 5]的訪問量，請分頁該區域。對於分頁，每秒最多隻能使用10ms，而且每
+秒分頁不能超過1GiB。在這一限制下，首先分頁出具有較長年齡的內存區域。另外，每5秒鐘檢查一次系統
+的可用內存率，當可用內存率低於50%時開始監測和分頁，但如果可用內存率大於60%，或低於30%，則停
+止監測。“ ::
+
+    # cd <sysfs>/kernel/mm/damon/admin
+    # # populate directories
+    # echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
+    # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
+    # cd kdamonds/0/contexts/0/schemes/0
+    # # set the basic access pattern and the action
+    # echo 4096 > access_pattern/sz/min
+    # echo 8192 > access_pattern/sz/max
+    # echo 0 > access_pattern/nr_accesses/min
+    # echo 5 > access_pattern/nr_accesses/max
+    # echo 10 > access_pattern/age/min
+    # echo 20 > access_pattern/age/max
+    # echo pageout > action
+    # # set quotas
+    # echo 10 > quotas/ms
+    # echo $((1024*1024*1024)) > quotas/bytes
+    # echo 1000 > quotas/reset_interval_ms
+    # # set watermark
+    # echo free_mem_rate > watermarks/metric
+    # echo 5000000 > watermarks/interval_us
+    # echo 600 > watermarks/high
+    # echo 500 > watermarks/mid
+    # echo 300 > watermarks/low
+
+請注意，我們強烈建議使用用戶空間的工具，如 `damo <https://github.com/awslabs/damo>`_ ，
+而不是像上面那樣手動讀寫文件。以上只是一個例子。
+
+debugfs接口
+===========
+
+.. note::
+
+  DAMON debugfs接口將在下一個LTS內核發佈後被移除，所以用戶應該轉移到
+  :ref:`sysfs接口<sysfs_interface>`。
+
+DAMON導出了八個文件, ``attrs``, ``target_ids``, ``init_regions``,
+``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` 和
+``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
+
+
+屬性
+----
+
+用戶可以通過讀取和寫入 ``attrs`` 文件獲得和設置 ``採樣間隔`` 、 ``聚集間隔`` 、 ``更新間隔``
+以及監測目標區域的最小/最大數量。要詳細瞭解監測屬性，請參考 `:doc:/mm/damon/design` 。例如，
+下面的命令將這些值設置爲5ms、100ms、1000ms、10和1000，然後再次檢查::
+
+    # cd <debugfs>/damon
+    # echo 5000 100000 1000000 10 1000 > attrs
+    # cat attrs
+    5000 100000 1000000 10 1000
+
+
+目標ID
+------
+
+一些類型的地址空間支持多個監測目標。例如，虛擬內存地址空間的監測可以有多個進程作爲監測目標。用戶
+可以通過寫入目標的相關id值來設置目標，並通過讀取 ``target_ids`` 文件來獲得當前目標的id。在監
+測虛擬地址空間的情況下，這些值應該是監測目標進程的pid。例如，下面的命令將pid爲42和4242的進程設
+爲監測目標，並再次檢查::
+
+    # cd <debugfs>/damon
+    # echo 42 4242 > target_ids
+    # cat target_ids
+    42 4242
+
+用戶還可以通過在文件中寫入一個特殊的關鍵字 "paddr\n" 來監測系統的物理內存地址空間。因爲物理地
+址空間監測不支持多個目標，讀取文件會顯示一個假值，即 ``42`` ，如下圖所示::
+
+    # cd <debugfs>/damon
+    # echo paddr > target_ids
+    # cat target_ids
+    42
+
+請注意，設置目標ID並不啓動監測。
+
+
+初始監測目標區域
+----------------
+
+在虛擬地址空間監測的情況下，DAMON自動設置和更新監測的目標區域，這樣就可以覆蓋目標進程的整個
+內存映射。然而，用戶可能希望將監測區域限制在特定的地址範圍內，如堆、棧或特定的文件映射區域。
+或者，一些用戶可以知道他們工作負載的初始訪問模式，因此希望爲“自適應區域調整”設置最佳初始區域。
+
+相比之下，DAMON在物理內存監測的情況下不會自動設置和更新監測目標區域。因此，用戶應該自己設置
+監測目標區域。
+
+在這種情況下，用戶可以通過在 ``init_regions`` 文件中寫入適當的值，明確地設置他們想要的初
+始監測目標區域。輸入應該是一個由三個整數組成的隊列，用空格隔開，代表一個區域的形式如下::
+
+    <target idx> <start address> <end address>
+
+目標idx應該是 ``target_ids`` 文件中目標的索引，從 ``0`` 開始，區域應該按照地址順序傳遞。
+例如，下面的命令將設置幾個地址範圍， ``1-100`` 和 ``100-200`` 作爲pid 42的初始監測目標
+區域，這是 ``target_ids`` 中的第一個（索引 ``0`` ），另外幾個地址範圍， ``20-40`` 和
+``50-100`` 作爲pid 4242的地址，這是 ``target_ids`` 中的第二個（索引 ``1`` ）::
+
+    # cd <debugfs>/damon
+    # cat target_ids
+    42 4242
+    # echo "0   1       100 \
+            0   100     200 \
+            1   20      40  \
+            1   50      100" > init_regions
+
+請注意，這只是設置了初始的監測目標區域。在虛擬內存監測的情況下，DAMON會在一個 ``更新間隔``
+後自動更新區域的邊界。因此，在這種情況下，如果用戶不希望更新的話，應該把 ``更新間隔`` 設
+置得足夠大。
+
+
+方案
+----
+
+對於通常的基於DAMON的數據訪問感知的內存管理優化，用戶只是希望系統對特定訪問模式的內存區域應用內
+存管理操作。DAMON從用戶那裏接收這種形式化的操作方案，並將這些方案應用到目標進程中。
+
+用戶可以通過讀取和寫入 ``scheme`` debugfs文件來獲得和設置這些方案。讀取該文件還可以顯示每個
+方案的統計數據。在文件中，每一個方案都應該在每一行中以下列形式表示出來::
+
+    <target access pattern> <action> <quota> <watermarks>
+
+你可以通過簡單地在文件中寫入一個空字符串來禁用方案。
+
+目標訪問模式
+~~~~~~~~~~~~
+
+``<目標訪問模式>`` 是由三個範圍構成的，形式如下::
+
+    min-size max-size min-acc max-acc min-age max-age
+
+具體來說，區域大小的字節數（ `min-size` 和 `max-size` ），訪問頻率的每聚合區間的監測訪問次
+數（ `min-acc` 和 `max-acc` ），區域年齡的聚合區間數（ `min-age` 和 `max-age` ）都被指定。
+請注意，這些範圍是封閉區間。
+
+動作
+~~~~
+
+``<action>`` 是一個預定義的內存管理動作的整數，DAMON將應用於具有目標訪問模式的區域。支持
+的數字和它們的含義如下::
+
+ - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``
+ - 1: Call ``madvise()`` for the region with ``MADV_COLD``
+ - 2: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
+ - 3: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
+ - 4: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - 5: Do nothing but count the statistics
+
+配額
+~~~~
+
+每個 ``動作`` 的最佳 ``目標訪問模式`` 取決於工作負載，所以不容易找到。更糟糕的是，將某個
+動作的方案設置得過於激進會導致嚴重的開銷。爲了避免這種開銷，用戶可以通過下面表格中的 ``<quota>``
+來限制方案的時間和大小配額::
+
+    <ms> <sz> <reset interval> <priority weights>
+
+這使得DAMON在 ``<reset interval>`` 毫秒內，儘量只用 ``<ms>`` 毫秒的時間對 ``目標訪
+問模式`` 的內存區域應用動作，並在 ``<reset interval>`` 內只對最多<sz>字節的內存區域應
+用動作。將 ``<ms>`` 和 ``<sz>`` 都設置爲零，可以禁用配額限制。
+
+當預計超過配額限制時，DAMON會根據 ``目標訪問模式`` 的大小、訪問頻率和年齡，對發現的內存
+區域進行優先排序。爲了實現個性化的優先級，用戶可以在 ``<優先級權重>`` 中設置這三個屬性的
+權重，具體形式如下::
+
+    <size weight> <access frequency weight> <age weight>
+
+水位
+~~~~
+
+有些方案需要根據系統特定指標的當前值來運行，如自由內存比率。對於這種情況，用戶可以爲該條
+件指定水位。::
+
+    <metric> <check interval> <high mark> <middle mark> <low mark>
+
+``<metric>`` 是一個預定義的整數，用於要檢查的度量。支持的數字和它們的含義如下。
+
+ - 0: 忽視水位
+ - 1: 系統空閒內存率 (千分比)
+
+每隔 ``<檢查間隔>`` 微秒檢查一次公制的值。
+
+如果該值高於 ``<高標>`` 或低於 ``<低標>`` ，該方案被停用。如果該值低於 ``<中標>`` ，
+該方案將被激活。
+
+統計數據
+~~~~~~~~
+
+它還統計每個方案被嘗試應用的區域的總數量和字節數，每個方案被成功應用的區域的兩個數量，以
+及超過配額限制的總數量。這些統計數據可用於在線分析或調整方案。
+
+統計數據可以通過讀取方案文件來顯示。讀取該文件將顯示你在每一行中輸入的每個 ``方案`` ，
+統計的五個數字將被加在每一行的末尾。
+
+例子
+~~~~
+
+下面的命令應用了一個方案：”如果一個大小爲[4KiB, 8KiB]的內存區域在[10, 20]的聚合時間
+間隔內顯示出每一個聚合時間間隔[0, 5]的訪問量，請分頁出該區域。對於分頁，每秒最多隻能使
+用10ms，而且每秒分頁不能超過1GiB。在這一限制下，首先分頁出具有較長年齡的內存區域。另外，
+每5秒鐘檢查一次系統的可用內存率，當可用內存率低於50%時開始監測和分頁，但如果可用內存率
+大於60%，或低於30%，則停止監測“::
+
+    # cd <debugfs>/damon
+    # scheme="4096 8192  0 5    10 20    2"  # target access pattern and action
+    # scheme+=" 10 $((1024*1024*1024)) 1000" # quotas
+    # scheme+=" 0 0 100"                     # prioritization weights
+    # scheme+=" 1 5000000 600 500 300"       # watermarks
+    # echo "$scheme" > schemes
+
+
+開關
+----
+
+除非你明確地啓動監測，否則如上所述的文件設置不會產生效果。你可以通過寫入和讀取 ``monitor_on``
+文件來啓動、停止和檢查監測的當前狀態。寫入 ``on`` 該文件可以啓動對有屬性的目標的監測。寫入
+``off`` 該文件則停止這些目標。如果每個目標進程被終止，DAMON也會停止。下面的示例命令開啓、關
+閉和檢查DAMON的狀態::
+
+    # cd <debugfs>/damon
+    # echo on > monitor_on
+    # echo off > monitor_on
+    # cat monitor_on
+    off
+
+請注意，當監測開啓時，你不能寫到上述的debugfs文件。如果你在DAMON運行時寫到這些文件，將會返
+回一個錯誤代碼，如 ``-EBUSY`` 。
+
+
+監測線程PID
+-----------
+
+DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以通過讀取 ``kdamond_pid`` 文件獲
+得該線程的 ``pid`` 。當監測被 ``關閉`` 時，讀取該文件不會返回任何信息::
+
+    # cd <debugfs>/damon
+    # cat monitor_on
+    off
+    # cat kdamond_pid
+    none
+    # echo on > monitor_on
+    # cat kdamond_pid
+    18594
+
+
+使用多個監測線程
+----------------
+
+每個監測上下文都會創建一個 ``kdamond`` 線程。你可以使用 ``mk_contexts`` 和 ``rm_contexts``
+文件爲多個 ``kdamond`` 需要的用例創建和刪除監測上下文。
+
+將新上下文的名稱寫入 ``mk_contexts`` 文件，在 ``DAMON debugfs`` 目錄上創建一個該名稱的目錄。
+該目錄將有該上下文的 ``DAMON debugfs`` 文件::
+
+    # cd <debugfs>/damon
+    # ls foo
+    # ls: cannot access 'foo': No such file or directory
+    # echo foo > mk_contexts
+    # ls foo
+    # attrs  init_regions  kdamond_pid  schemes  target_ids
+
+如果不再需要上下文，你可以通過把上下文的名字放到 ``rm_contexts`` 文件中來刪除它和相應的目錄::
+
+    # echo foo > rm_contexts
+    # ls foo
+    # ls: cannot access 'foo': No such file or directory
+
+注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on`` 文件只在根目錄下。
+
+
+監測結果的監測點
+================
+
+DAMON通過一個tracepoint ``damon:damon_aggregated`` 提供監測結果.  當監測開啓時，你可
+以記錄追蹤點事件，並使用追蹤點支持工具如perf顯示結果。比如說::
+
+    # echo on > monitor_on
+    # perf record -e damon:damon_aggregated &
+    # sleep 5
+    # kill 9 $(pidof perf)
+    # echo off > monitor_on
+    # perf script
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/index.rst b/Documentation/translations/zh_TW/admin-guide/mm/index.rst
new file mode 100644
index 000000000000..0b04d925b68c
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/index.rst
@@ -0,0 +1,50 @@
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original:   Documentation/admin-guide/mm/index.rst
+
+:翻譯:
+
+  徐鑫 xu xin <xu.xin16@zte.com.cn>
+
+
+========
+內存管理
+========
+
+Linux內存管理子系統，顧名思義，是負責系統中的內存管理。它包括了虛擬內存與請求
+分頁的實現，內核內部結構和用戶空間程序的內存分配、將文件映射到進程地址空間以
+及許多其他很酷的事情。
+
+Linux內存管理是一個具有許多可配置設置的複雜系統, 且這些設置中的大多數都可以通
+過 ``/proc`` 文件系統獲得，並且可以使用 ``sysctl`` 進行查詢和調整。這些API接
+口被描述在Documentation/admin-guide/sysctl/vm.rst文件和 `man 5 proc`_ 中。
+
+.. _man 5 proc: http://man7.org/linux/man-pages/man5/proc.5.html
+
+Linux內存管理有它自己的術語，如果你還不熟悉它，請考慮閱讀下面參考：
+Documentation/admin-guide/mm/concepts.rst.
+
+在此目錄下，我們詳細描述瞭如何與Linux內存管理中的各種機制交互。
+
+.. toctree::
+   :maxdepth: 1
+
+   damon/index
+   ksm
+
+Todolist:
+* concepts
+* cma_debugfs
+* hugetlbpage
+* idle_page_tracking
+* memory-hotplug
+* nommu-mmap
+* numa_memory_policy
+* numaperf
+* pagemap
+* soft-dirty
+* swap_numa
+* transhuge
+* userfaultfd
+* zswap
+
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/ksm.rst b/Documentation/translations/zh_TW/admin-guide/mm/ksm.rst
new file mode 100644
index 000000000000..1b4944b3cf61
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/ksm.rst
@@ -0,0 +1,199 @@
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/mm/ksm.rst
+
+:翻譯:
+
+  徐鑫 xu xin <xu.xin16@zte.com.cn>
+
+
+============
+內核同頁合併
+============
+
+
+概述
+====
+
+KSM是一種能節省內存的數據去重功能，由CONFIG_KSM=y啓用，並在2.6.32版本時被添
+加到Linux內核。詳見 ``mm/ksm.c`` 的實現，以及http://lwn.net/Articles/306704
+和https://lwn.net/Articles/330589
+
+KSM最初目的是爲了與KVM（即著名的內核共享內存）一起使用而開發的，通過共享虛擬機
+之間的公共數據，將更多虛擬機放入物理內存。但它對於任何會生成多個相同數據實例的
+應用程序都是很有用的。
+
+KSM的守護進程ksmd會定期掃描那些已註冊的用戶內存區域，查找內容相同的頁面，這些
+頁面可以被單個寫保護頁面替換（如果進程以後想要更新其內容，將自動複製）。使用：
+引用:`sysfs intraface  <ksm_sysfs>` 接口來配置KSM守護程序在單個過程中所掃描的頁
+數以及兩個過程之間的間隔時間。
+
+KSM只合並匿名（私有）頁面，從不合並頁緩存（文件）頁面。KSM的合併頁面最初只能被
+鎖定在內核內存中，但現在可以就像其他用戶頁面一樣被換出（但當它們被交換回來時共
+享會被破壞: ksmd必須重新發現它們的身份並再次合併）。
+
+以madvise控制KSM
+================
+
+KSM僅在特定的地址空間區域時運行，即應用程序通過使用如下所示的madvise(2)系統調
+用來請求某塊地址成爲可能的合併候選者的地址空間::
+
+    int madvise(addr, length, MADV_MERGEABLE)
+
+應用程序當然也可以通過調用::
+
+    int madvise(addr, length, MADV_UNMERGEABLE)
+
+來取消該請求，並恢復爲非共享頁面：此時KSM將去除合併在該範圍內的任何合併頁。注意：
+這個去除合併的調用可能突然需要的內存量超過實際可用的內存量-那麼可能會出現EAGAIN
+失敗，但更可能會喚醒OOM killer。
+
+如果KSM未被配置到正在運行的內核中，則madvise MADV_MERGEABLE 和 MADV_UNMERGEABLE
+的調用只會以EINVAL 失敗。如果正在運行的內核是用CONFIG_KSM=y方式構建的，那麼這些
+調用通常會成功：即使KSM守護程序當前沒有運行，MADV_MERGEABLE 仍然會在KSM守護程序
+啓動時註冊範圍，即使該範圍不能包含KSM實際可以合併的任何頁面，即使MADV_UNMERGEABLE
+應用於從未標記爲MADV_MERGEABLE的範圍。
+
+如果一塊內存區域必須被拆分爲至少一個新的MADV_MERGEABLE區域或MADV_UNMERGEABLE區域，
+當該進程將超過 ``vm.max_map_count`` 的設定，則madvise可能返回ENOMEM。（請參閱文檔
+Documentation/admin-guide/sysctl/vm.rst）。
+
+與其他madvise調用一樣，它們在用戶地址空間的映射區域上使用：如果指定的範圍包含未
+映射的間隙（儘管在中間的映射區域工作），它們將報告ENOMEM，如果沒有足夠的內存用於
+內部結構，則可能會因EAGAIN而失敗。
+
+KSM守護進程sysfs接口
+====================
+
+KSM守護進程可以由``/sys/kernel/mm/ksm/`` 中的sysfs文件控制，所有人都可以讀取，但
+只能由root用戶寫入。各接口解釋如下：
+
+
+pages_to_scan
+        ksmd進程進入睡眠前要掃描的頁數。
+        例如， ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``
+
+        默認值：100（該值被選擇用於演示目的）
+
+sleep_millisecs
+        ksmd在下次掃描前應休眠多少毫秒
+        例如， ``echo 20 > /sys/kernel/mm/ksm/sleep_millisecs``
+
+        默認值：20（該值被選擇用於演示目的）
+
+merge_across_nodes
+        指定是否可以合併來自不同NUMA節點的頁面。當設置爲0時，ksm僅合併在物理上位
+        於同一NUMA節點的內存區域中的頁面。這降低了訪問共享頁面的延遲。在有明顯的
+        NUMA距離上，具有更多節點的系統可能受益於設置該值爲0時的更低延遲。而對於
+        需要對內存使用量最小化的較小系統來說，設置該值爲1（默認設置）則可能會受
+        益於更大共享頁面。在決定使用哪種設置之前，您可能希望比較系統在每種設置下
+        的性能。 ``merge_across_nodes`` 僅當系統中沒有ksm共享頁面時，才能被更改設
+        置：首先將接口`run` 設置爲2從而對頁進行去合併，然後在修改
+        ``merge_across_nodes`` 後再將‘run’又設置爲1，以根據新設置來重新合併。
+
+        默認值：1（如早期的發佈版本一樣合併跨站點）
+
+run
+        * 設置爲0可停止ksmd運行，但保留合併頁面，
+        * 設置爲1可運行ksmd，例如， ``echo 1 > /sys/kernel/mm/ksm/run`` ，
+        * 設置爲2可停止ksmd運行，並且對所有目前已合併的頁進行去合併，但保留可合併
+          區域以供下次運行。
+
+        默認值：0（必須設置爲1才能激活KSM，除非禁用了CONFIG_SYSFS）
+
+use_zero_pages
+        指定是否應當特殊處理空頁（即那些僅含zero的已分配頁）。當該值設置爲1時，
+        空頁與內核零頁合併，而不是像通常情況下那樣空頁自身彼此合併。這可以根據
+        工作負載的不同，在具有着色零頁的架構上可以提高性能。啓用此設置時應小心，
+        因爲它可能會降低某些工作負載的KSM性能，比如，當待合併的候選頁面的校驗和
+        與空頁面的校驗和恰好匹配的時候。此設置可隨時更改，僅對那些更改後再合併
+        的頁面有效。
+
+        默認值：0（如同早期版本的KSM正常表現）
+
+max_page_sharing
+        單個KSM頁面允許的最大共享站點數。這將強制執行重複數據消除限制，以避免涉
+        及遍歷共享KSM頁面的虛擬映射的虛擬內存操作的高延遲。最小值爲2，因爲新創
+        建的KSM頁面將至少有兩個共享者。該值越高，KSM合併內存的速度越快，去重
+        因子也越高，但是對於任何給定的KSM頁面，虛擬映射的最壞情況遍歷的速度也會
+        越慢。減慢了這種遍歷速度就意味着在交換、壓縮、NUMA平衡和頁面遷移期間，
+        某些虛擬內存操作將有更高的延遲，從而降低這些虛擬內存操作調用者的響應能力。
+        其他任務如果不涉及執行虛擬映射遍歷的VM操作，其任務調度延遲不受此參數的影
+        響，因爲這些遍歷本身是調度友好的。
+
+stable_node_chains_prune_millisecs
+        指定KSM檢查特定頁面的元數據的頻率（即那些達到過時信息數據去重限制標準的
+        頁面）單位是毫秒。較小的毫秒值將以更低的延遲來釋放KSM元數據，但它們將使
+        ksmd在掃描期間使用更多CPU。如果還沒有一個KSM頁面達到 ``max_page_sharing``
+        標準，那就沒有什麼用。
+
+KSM與MADV_MERGEABLE的工作有效性體現於 ``/sys/kernel/mm/ksm/`` 路徑下的接口：
+
+pages_shared
+        表示多少共享頁正在被使用
+pages_sharing
+        表示還有多少站點正在共享這些共享頁，即節省了多少
+pages_unshared
+        表示有多少頁是唯一的，但被反覆檢查以進行合併
+pages_volatile
+        表示有多少頁因變化太快而無法放在tree中
+full_scans
+        表示所有可合併區域已掃描多少次
+stable_node_chains
+        達到 ``max_page_sharing`` 限制的KSM頁數
+stable_node_dups
+        重複的KSM頁數
+
+比值 ``pages_sharing/pages_shared`` 的最大值受限制於 ``max_page_sharing``
+的設定。要想增加該比值，則相應地要增加 ``max_page_sharing`` 的值。
+
+監測KSM的收益
+=============
+
+KSM可以通過合併相同的頁面來節省內存，但也會消耗額外的內存，因爲它需要生成一些rmap_items
+來保存每個掃描頁面的簡要rmap信息。其中有些頁面可能會被合併，但有些頁面在被檢查幾次
+後可能無法被合併，這些都是無益的內存消耗。
+
+1) 如何確定KSM在全系統範圍內是節省內存還是消耗內存？這裏有一個簡單的近似計算方法供參考::
+
+       general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
+                         sizeof(rmap_item);
+
+   其中all_rmap_items可以通過對 ``pages_sharing`` 、 ``pages_shared`` 、 ``pages_unshared``
+   和 ``pages_volatile`` 的求和而輕鬆獲得。
+
+2) 單一進程中KSM的收益也可以通過以下近似的計算得到::
+
+       process_profit =~ ksm_merging_pages * sizeof(page) -
+                         ksm_rmap_items * sizeof(rmap_item).
+
+   其中ksm_merging_pages顯示在 ``/proc/<pid>/`` 目錄下，而ksm_rmap_items
+   顯示在 ``/proc/<pid>/ksm_stat`` 。
+
+從應用的角度來看， ``ksm_rmap_items`` 和 ``ksm_merging_pages`` 的高比例意
+味着不好的madvise-applied策略，所以開發者或管理員必須重新考慮如何改變madvis策
+略。舉個例子供參考，一個頁面的大小通常是4K，而rmap_item的大小在32位CPU架構上分
+別是32B，在64位CPU架構上是64B。所以如果 ``ksm_rmap_items/ksm_merging_pages``
+的比例在64位CPU上超過64，或者在32位CPU上超過128，那麼應用程序的madvise策略應
+該被放棄，因爲ksm收益大約爲零或負值。
+
+監控KSM事件
+===========
+
+在/proc/vmstat中有一些計數器，可以用來監控KSM事件。KSM可能有助於節省內存，這是
+一種權衡，因爲它可能會在KSM COW或複製中的交換上遭受延遲。這些事件可以幫助用戶評估
+是否或如何使用KSM。例如，如果cow_ksm增加得太快，用戶可以減少madvise(, , MADV_MERGEABLE)
+的範圍。
+
+cow_ksm
+        在每次KSM頁面觸發寫時拷貝（COW）時都會被遞增，當用戶試圖寫入KSM頁面時，
+        我們必須做一個拷貝。
+
+ksm_swpin_copy
+        在換入時，每次KSM頁被複制時都會被遞增。請注意，KSM頁在換入時可能會被複
+        制，因爲do_swap_page()不能做所有的鎖，而需要重組一個跨anon_vma的KSM頁。
+
+--
+Izik Eidus,
+Hugh Dickins, 2009年11月17日。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
index ea51342879c0..ff2d406ab4d5 100644
--- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
@@ -1,13 +1,6 @@
 .. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
-..
-   If you want to distribute this text under CC-BY-4.0 only, please use 'The
-   Linux kernel developers' for author attribution and link this as source:
-   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
-..
-   Note: Only the content of this RST file as found in the Linux kernel sources
-   is available under CC-BY-4.0, as versions of this text that were processed
-   (for example by the kernel's build system) might contain content taken from
-   files which use a more restrictive license.
+.. See the bottom of this file for additional redistribution information.
+
 
 .. include:: ../disclaimer-zh_TW.rst
 
@@ -26,14 +19,16 @@
 簡明指南（亦即 太長不看）
 ==========================
 
-您面臨的是否爲同系列穩定版或長期支持內核的普通內核的回歸？是否仍然受支持？
+您面臨的是否爲同系列穩定版或長期支持內核的普通內核的迴歸？是否仍然受支持？
 請搜索 `LKML內核郵件列表 <https://lore.kernel.org/lkml/>`_ 和
 `Linux穩定版郵件列表 <https://lore.kernel.org/stable/>`_ 存檔中匹配的報告並
 加入討論。如果找不到匹配的報告，請安裝該系列的最新版本。如果它仍然出現問題，
-報告給穩定版郵件列表（stable@vger.kernel.org）。
+請報告給穩定版郵件列表（stable@vger.kernel.org）並抄送回歸郵件列表
+（regressions@lists.linux.dev）；理想情況下，還可以抄送維護者和相關子系統的
+郵件列表。
 
 在所有其他情況下，請儘可能猜測是哪個內核部分導致了問題。查看MAINTAINERS文件，
-了解開發人員希望如何得知問題，大多數情況下，報告問題都是通過電子郵件和抄送
+瞭解開發人員希望如何得知問題，大多數情況下，報告問題都是通過電子郵件和抄送
 相關郵件列表進行的。檢查報告目的地的存檔中是否已有匹配的報告；也請搜索
 `LKML <https://lore.kernel.org/lkml/>`_ 和網絡。如果找不到可加入的討論，請
 安裝 `最新的主線內核 <https://kernel.org/>`_ 。如果仍存在問題，請發送報告。
@@ -45,21 +40,22 @@
 
 **通用提醒** ：當安裝和測試上述內核時，請確保它是普通的（即：沒有補丁，也沒
 有使用附加模塊）。還要確保它是在一個正常的環境中構建和運行，並且在問題發生
-之前沒有被汙染（tainted）。
+之前沒有被污染（tainted）。
 
-在編寫報告時，要涵蓋與問題相關的所有信息，如使用的內核和發行版。在碰見回歸時，
-嘗試給出引入它的更改的提交ID，二分可以找到它。如果您同時面臨Linux內核的多個
-問題，請分別報告每個問題。
+當你同時面臨Linux內核的多個問題時，請分別報告。在編寫報告時，要涵蓋與問題
+相關的所有信息，如使用的內核和發行版。如果碰見迴歸，請把報告抄送回歸郵件列表
+（regressions@lists.linux.dev）。也請試試用二分法找出源頭；如果成功找到，請
+在報告中寫上它的提交ID並抄送sign-off-by鏈中的所有人。
 
 一旦報告發出，請回答任何出現的問題，並儘可能地提供幫助。這包括通過不時重新
-測試新版本並發送狀態更新來推動進展。
+測試新版本併發送狀態更新來推動進展。
 
 
 如何向內核維護人員報告問題的逐步指南
 =====================================
 
-上面的簡明指南概述了如何向Linux內核開發人員報告問題。對於已經熟悉向自由和開
-源軟體（FLOSS）項目報告問題的人來說，這可能是他們所需要的全部內容。對於其他
+上面的簡明指南概述瞭如何向Linux內核開發人員報告問題。對於已經熟悉向自由和開
+源軟件（FLOSS）項目報告問題的人來說，這可能是他們所需要的全部內容。對於其他
 人，本部分更爲詳細，並一步一步地描述。爲了便於閱讀，它仍然儘量簡潔，並省略
 了許多細節；這些在逐步指南後的參考章節中進行了描述，該章節更詳細地解釋了每
 個步驟。
@@ -68,16 +64,16 @@
 儘早意識到看起來像Linux內核毛病的問題可能實際上是由其他原因引起的。這些步驟
 可以確保你最終不會覺得在這一過程中投入的時間是浪費：
 
- * 您是否面臨硬體或軟體供應商提供的Linux內核的問題？那麼基本上您最好停止閱讀
+ * 您是否面臨硬件或軟件供應商提供的Linux內核的問題？那麼基本上您最好停止閱讀
    本文檔，轉而向您的供應商報告問題，除非您願意自己安裝最新的Linux版本。尋找
    和解決問題往往需要後者。
 
- * 使用您喜愛的網絡搜尋引擎對現有報告進行粗略搜索；此外，請檢查
+ * 使用您喜愛的網絡搜索引擎對現有報告進行粗略搜索；此外，請檢查
    `Linux內核郵件列表（LKML） <https://lore.kernel.org/lkml/>`_ 的存檔。如果
    找到匹配的報告，請加入討論而不是發送新報告。
 
- * 看看你正在處理的問題是否爲回歸問題、安全問題或非常嚴重的問題：這些都是需
-   要在接下來的一些步驟中特別處理的「高優先級問題」。
+ * 看看你正在處理的問題是否爲迴歸問題、安全問題或非常嚴重的問題：這些都是需
+   要在接下來的一些步驟中特別處理的“高優先級問題”。
 
  * 確保不是內核環境導致了您面臨的問題。
 
@@ -86,15 +82,15 @@
  * 確保您的系統不會通過動態構建額外的內核模塊來增強其內核，像DKMS這樣的解決
    方案可能在您不知情的情況下就在本地進行了這樣的工作。
 
- * 當問題發生時，檢查您的內核是否被「汙染」，因爲使內核設置這個標誌的事件可能
+ * 當問題發生時，檢查您的內核是否被“污染”，因爲使內核設置這個標誌的事件可能
    會導致您面臨的問題。
 
  * 粗略地寫下如何重現這個問題。如果您同時處理多個問題，請爲每個問題單獨寫注
    釋，並確保它們在新啓動的系統上獨立出現。這是必要的，因爲每個問題都需要分
    別報告給內核開發人員，除非它們嚴重糾纏在一起。
 
- * 如果您正面臨穩定版或長期支持版本線的回歸（例如從5.10.4更新到5.10.5時出現
-   故障），請查看後文「報告穩定版和長期支持內核線的回歸」小節。
+ * 如果您正面臨穩定版或長期支持版本線的迴歸（例如從5.10.4更新到5.10.5時出現
+   故障），請查看後文“報告穩定版和長期支持內核線的迴歸”小節。
 
  * 定位可能引起問題的驅動程序或內核子系統。找出其開發人員期望的報告的方式和
    位置。注意：大多數情況下不會是 bugzilla.kernel.org，因爲問題通常需要通
@@ -105,61 +101,62 @@
 
 在完成這些準備之後，你將進入主要部分：
 
- * 除非您已經在運行最新的「主線」Linux內核，否則最好在報告流程前安裝它。在某些
-   情況下，使用最新的「穩定版」Linux進行測試和報告也是可以接受的替代方案；在
+ * 除非您已經在運行最新的“主線”Linux內核，否則最好在報告流程前安裝它。在某些
+   情況下，使用最新的“穩定版”Linux進行測試和報告也是可以接受的替代方案；在
    合併窗口期間，這實際上可能是最好的方法，但在開發階段最好還是暫停幾天。無論
-   你選擇什麼版本，最好使用「普通」構建。忽略這些建議會大大增加您的報告被拒絕
+   你選擇什麼版本，最好使用“普通”構建。忽略這些建議會大大增加您的報告被拒絕
    或忽略的風險。
 
- * 確保您剛剛安裝的內核在運行時不會「汙染」自己。
+ * 確保您剛剛安裝的內核在運行時不會“污染”自己。
 
  * 在您剛剛安裝的內核中復現這個問題。如果它沒有出現，請查看下方只發生在
    穩定版和長期支持內核的問題的說明。
 
- * 優化你的筆記：試著找到並寫出最直接的復現問題的方法。確保最終結果包含所有
+ * 優化你的筆記：試着找到並寫出最直接的復現問題的方法。確保最終結果包含所有
    重要的細節，同時讓第一次聽說的人容易閱讀和理解。如果您在此過程中學到了一
    些東西，請考慮再次搜索關於該問題的現有報告。
 
- * 如果失敗涉及「panic」、「Oops」、「warning」或「BUG」，請考慮解碼內核日誌以查找觸
+ * 如果失敗涉及“panic”、“Oops”、“warning”或“BUG”，請考慮解碼內核日誌以查找觸
    發錯誤的代碼行。
 
- * 如果您的問題是回歸問題，請儘可能縮小引入問題時的範圍。
+ * 如果您的問題是迴歸問題，請儘可能縮小引入問題時的範圍。
 
  * 通過詳細描述問題來開始編寫報告。記得包括以下條目：您爲復現而安裝的最新內
    核版本、使用的Linux發行版以及關於如何復現該問題的說明。如果可能，將內核
-   構建配置（.config）和 ``dmesg`` 的輸出放在網上的某個地方，並連結到它。包
+   構建配置（.config）和 ``dmesg`` 的輸出放在網上的某個地方，並鏈接到它。包
    含或上傳所有其他可能相關的信息，如Oops的輸出/截圖或來自 ``lspci`` 的輸出
    。一旦你寫完了這個主要部分，請在上方插入一個正常長度的段落快速概述問題和
    影響。再在此之上添加一個簡單描述問題的句子，以得到人們的閱讀。現在給出一
    個更短的描述性標題或主題。然後就可以像MAINTAINERS文件告訴你的那樣發送或
-   提交報告了，除非你在處理一個「高優先級問題」：它們需要按照下面「高優先級問
-   題的特殊處理」所述特別關照。
+   提交報告了，除非你在處理一個“高優先級問題”：它們需要按照下面“高優先級問
+   題的特殊處理”所述特別關照。
 
  * 等待別人的反應，繼續推進事情，直到你能夠接受這樣或那樣的結果。因此，請公
    開和及時地回應任何詢問。測試提出的修復。積極地測試：至少重新測試每個新主
    線版本的首個候選版本（RC），並報告你的結果。如果出現拖延，就友好地提醒一
-   下。如果你沒有得到任何幫助或者未能滿意，請試著自己幫助自己。
+   下。如果你沒有得到任何幫助或者未能滿意，請試着自己幫助自己。
 
 
-報告穩定版和長期支持內核線的回歸
+報告穩定版和長期支持內核線的迴歸
 ----------------------------------
 
-如果您發現了穩定版或長期支持內核版本線中的回歸問題並按上述流程跳到這裡，那麼
+如果您發現了穩定版或長期支持內核版本線中的迴歸問題並按上述流程跳到這裏，那麼
 請閱讀本小節。即例如您在從5.10.4更新到5.10.5時出現了問題（從5.9.15到5.10.5則
-不是）。開發人員希望儘快修復此類回歸，因此有一個簡化流程來報告它們：
+不是）。開發人員希望儘快修復此類迴歸，因此有一個簡化流程來報告它們：
 
  * 檢查內核開發人員是否仍然維護你關心的Linux內核版本線：去 `kernel.org 的首頁
-   <https://kernel.org/>`_ ，確保此特定版本線的最新版沒有「[EOL]」標記。
+   <https://kernel.org/>`_ ，確保此特定版本線的最新版沒有“[EOL]”標記。
 
  * 檢查 `Linux穩定版郵件列表 <https://lore.kernel.org/stable/>`_ 中的現有報告。
 
- * 從特定的版本線安裝最新版本作爲純淨內核。確保這個內核沒有被汙染，並且仍然
-   存在問題，因爲問題可能已經在那裡被修復了。如果您第一次發現供應商內核的問題，
+ * 從特定的版本線安裝最新版本作爲純淨內核。確保這個內核沒有被污染，並且仍然
+   存在問題，因爲問題可能已經在那裏被修復了。如果您第一次發現供應商內核的問題，
    請檢查已知最新版本的普通構建是否可以正常運行。
 
- * 向Linux穩定版郵件列表發送一個簡短的問題報告(stable@vger.kernel.org)。大致
-   描述問題，並解釋如何復現。講清楚首個出現問題的版本和最後一個工作正常的版本。
-   然後等待進一步的指示。
+ * 向Linux穩定版郵件列表發送一個簡短的問題報告（stable@vger.kernel.org）並抄送
+   Linux迴歸郵件列表（regressions@lists.linux.dev）；如果你懷疑是由某子系統
+   引起的，請抄送其維護人員和子系統郵件列表。大致描述問題，並解釋如何復現。
+   講清楚首個出現問題的版本和最後一個工作正常的版本。然後等待進一步的指示。
 
 下面的參考章節部分詳細解釋了這些步驟中的每一步。
 
@@ -167,14 +164,14 @@
 報告只發生在較舊內核版本線的問題
 ----------------------------------
 
-若您嘗試了上述的最新主線內核，但未能在那裡復現問題，那麼本小節適用於您；以下
+若您嘗試了上述的最新主線內核，但未能在那裏復現問題，那麼本小節適用於您；以下
 流程有助於使問題在仍然支持的穩定版或長期支持版本線，或者定期基於最新穩定版或
 長期支持內核的供應商內核中得到修復。如果是這種情況，請執行以下步驟：
 
  * 請做好準備，接下來的幾個步驟可能無法在舊版本中解決問題：修復可能太大或太
-   冒險，無法移植到那裡。
+   冒險，無法移植到那裏。
 
- * 執行前節「報告穩定版和長期支持內核線的回歸」中的前三個步驟。
+ * 執行前節“報告穩定版和長期支持內核線的迴歸”中的前三個步驟。
 
  * 在Linux內核版本控制系統中搜索修復主線問題的更改，因爲它的提交消息可能會
    告訴你修復是否已經計劃好了支持。如果你沒有找到，搜索適當的郵件列表，尋找
@@ -219,14 +216,14 @@
 確保您使用的是上游Linux內核
 ----------------------------
 
-   *您是否面臨硬體或軟體供應商提供的Linux內核的問題？那麼基本上您最好停止閱
+   *您是否面臨硬件或軟件供應商提供的Linux內核的問題？那麼基本上您最好停止閱
    讀本文檔，轉而向您的供應商報告問題，除非您願意自己安裝最新的Linux版本。
    尋找和解決問題往往需要後者。*
 
-與大多數程式設計師一樣，Linux內核開發人員不喜歡花時間處理他們維護的原始碼中根本
-不會發生的問題的報告。這只會浪費每個人的時間，尤其是你的時間。不幸的是，當
+與大多數程序員一樣，Linux內核開發人員不喜歡花時間處理他們維護的源代碼中根本
+不會發生的問題的報告。這隻會浪費每個人的時間，尤其是你的時間。不幸的是，當
 涉及到內核時，這樣的情況很容易發生，並且常常導致雙方氣餒。這是因爲幾乎所有預
-裝在設備（台式機、筆記本電腦、智慧型手機、路由器等）上的Linux內核，以及大多數
+裝在設備（臺式機、筆記本電腦、智能手機、路由器等）上的Linux內核，以及大多數
 由Linux發行商提供的內核，都與由kernel.org發行的官方Linux內核相距甚遠：從Linux
 開發的角度來看，這些供應商提供的內核通常是古老的或者經過了大量修改，通常兩點
 兼具。
@@ -235,19 +232,19 @@
 可能已經由Linux內核開發人員在數月或數年前修復；此外，供應商的修改和增強可能
 會導致您面臨的問題，即使它們看起來很小或者完全不相關。這就是爲什麼您應該向
 供應商報告這些內核的問題。它的開發者應該查看報告，如果它是一個上游問題，直接
-於上游修復或將報告轉發到那裡。在實踐中，這有時行不通。因此，您可能需要考慮
+於上游修復或將報告轉發到那裏。在實踐中，這有時行不通。因此，您可能需要考慮
 通過自己安裝最新的Linux內核內核來繞過供應商。如果如果您選擇此方法，那麼本指
 南後面的步驟將解釋如何在排除了其他可能導致您的問題的原因後執行此操作。
 
-注意前段使用的詞語是「大多數」，因爲有時候開發人員實際上願意處理供應商內核出現
+注意前段使用的詞語是“大多數”，因爲有時候開發人員實際上願意處理供應商內核出現
 的問題報告。他們是否這麼做很大程度上取決於開發人員和相關問題。如果發行版只
 根據最近的Linux版本對內核進行了較小修改，那麼機會就比較大；例如對於Debian
 GNU/Linux Sid或Fedora Rawhide所提供的主線內核。一些開發人員還將接受基於最新
 穩定內核的發行版內核問題報告，只要它改動不大；例如Arch Linux、常規Fedora版本
 和openSUSE Turboweed。但是請記住，您最好使用主線Linux，並避免在此流程中使用
-穩定版內核，如「安裝一個新的內核進行測試」一節中所詳述。
+穩定版內核，如“安裝一個新的內核進行測試”一節中所詳述。
 
-當然，您可以忽略所有這些建議，並向上游Linux開發人員報告舊的或經過大量修改的
+當然，您可以忽略所有這些建議，並向上遊Linux開發人員報告舊的或經過大量修改的
 供應商內核的問題。但是注意，這樣的報告經常被拒絕或忽視，所以自行小心考慮一下。
 不過這還是比根本不報告問題要好：有時候這樣的報告會直接或間接地幫助解決之後的
 問題。
@@ -256,64 +253,61 @@ GNU/Linux Sid或Fedora Rawhide所提供的主線內核。一些開發人員還
 搜索現有報告（第一部分）
 -------------------------
 
-    *使用您喜愛的網絡搜尋引擎對現有報告進行粗略搜索；此外，請檢查Linux內核
+    *使用您喜愛的網絡搜索引擎對現有報告進行粗略搜索；此外，請檢查Linux內核
     郵件列表（LKML）的存檔。如果找到匹配的報告，請加入討論而不是發送新報告。*
 
 報告一個別人已經提出的問題，對每個人來說都是浪費時間，尤其是作爲報告人的你。
 所以徹底檢查是否有人已經報告了這個問題，這對你自己是有利的。在流程中的這一步，
-可以只執行一個粗略的搜索：一旦您知道您的問題需要報告到哪裡，稍後的步驟將告訴
+可以只執行一個粗略的搜索：一旦您知道您的問題需要報告到哪裏，稍後的步驟將告訴
 您如何詳細搜索。儘管如此，不要倉促完成這一步，它可以節省您的時間和減少麻煩。
 
-只需先用你最喜歡的搜尋引擎在網際網路上搜索。然後再搜索Linux內核郵件列表（LKML）
+只需先用你最喜歡的搜索引擎在互聯網上搜索。然後再搜索Linux內核郵件列表（LKML）
 存檔。
 
-如果搜索結果實在太多，可以考慮讓你的搜尋引擎將搜索時間範圍限制在過去的一個
-月或一年。而且無論你在哪裡搜索，一定要用恰當的搜索關鍵詞；也要變化幾次關鍵
-詞。同時，試著從別人的角度看問題：這將幫助你想出其他的關鍵詞。另外，一定不
+如果搜索結果實在太多，可以考慮讓你的搜索引擎將搜索時間範圍限制在過去的一個
+月或一年。而且無論你在哪裏搜索，一定要用恰當的搜索關鍵詞；也要變化幾次關鍵
+詞。同時，試着從別人的角度看問題：這將幫助你想出其他的關鍵詞。另外，一定不
 要同時使用過多的關鍵詞。記住搜索時要同時嘗試包含和不包含內核驅動程序的名稱
-或受影響的硬體組件的名稱等信息。但其確切的品牌名稱（比如說「華碩紅魔 Radeon
-RX 5700 XT Gaming OC」）往往幫助不大，因爲它太具體了。相反，嘗試搜索術語，如
-型號（Radeon 5700 或 Radeon 5000）和核心代號（「Navi」或「Navi10」），以及包含
-和不包含其製造商（「AMD」）。
+或受影響的硬件組件的名稱等信息。但其確切的品牌名稱（比如說“華碩紅魔 Radeon
+RX 5700 XT Gaming OC”）往往幫助不大，因爲它太具體了。相反，嘗試搜索術語，如
+型號（Radeon 5700 或 Radeon 5000）和核心代號（“Navi”或“Navi10”），以及包含
+和不包含其製造商（“AMD”）。
 
 如果你發現了關於你的問題的現有報告，請加入討論，因爲你可能會提供有價值的額
 外信息。這一點很重要，即使是在修復程序已經準備好或處於最後階段，因爲開發人
-員可能會尋找能夠提供額外信息或測試建議修復程序的人。跳到「發布報告後的責任」
-一節，了解有關如何正確參與的細節。
+員可能會尋找能夠提供額外信息或測試建議修復程序的人。跳到“發佈報告後的責任”
+一節，瞭解有關如何正確參與的細節。
 
 注意，搜索 `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ 網站可能
 也是一個好主意，因爲這可能會提供有價值的見解或找到匹配的報告。如果您發現後者，
-請記住：大多數子系統都希望在不同的位置報告，如下面「你需要將問題報告到何處」
+請記住：大多數子系統都希望在不同的位置報告，如下面“你需要將問題報告到何處”
 一節中所述。因此本應處理這個問題的開發人員甚至可能不知道bugzilla的工單。所以
 請檢查工單中的問題是否已經按照本文檔所述得到報告，如果沒有，請考慮這樣做。
 
 高優先級的問題？
 -----------------
 
-    *看看你正在處理的問題是否是回歸問題、安全問題或非常嚴重的問題：這些都是
-    需要在接下來的一些步驟中特別處理的「高優先級問題」。*
+    *看看你正在處理的問題是否是迴歸問題、安全問題或非常嚴重的問題：這些都是
+    需要在接下來的一些步驟中特別處理的“高優先級問題”。*
 
 Linus Torvalds和主要的Linux內核開發人員希望看到一些問題儘快得到解決，因此在
-報告過程中有一些「高優先級問題」的處理略有不同。有三種情況符合條件:回歸、安全
+報告過程中有一些“高優先級問題”的處理略有不同。有三種情況符合條件:迴歸、安全
 問題和非常嚴重的問題。
 
-如果在舊版本的Linux內核中工作的東西不能在新版本的Linux內核中工作，或者某種
-程度上在新版本的Linux內核中工作得更差，那麼你就需要處理「回歸」。因此，當一個
-在Linux 5.7中表現良好的WiFi驅動程序在5.8中表現不佳或根本不能工作時，這是一
-種回歸。如果應用程式在新的內核中出現不穩定的現象，這也是一種回歸，這可能是
-由於內核和用戶空間之間的接口（如procfs和sysfs）發生不兼容的更改造成的。顯著
-的性能降低或功耗增加也可以稱爲回歸。但是請記住:新內核需要使用與舊內核相似的
-配置來構建（參見下面如何實現這一點）。這是因爲內核開發人員在實現新特性時有
-時無法避免不兼容性；但是爲了避免回歸，這些特性必須在構建配置期間顯式地啓用。
+如果某個應用程序或實際用例在原先的Linux內核上運行良好，但在使用類似配置編譯的
+較新版本上效果更差、或者根本不能用，那麼你就需要處理迴歸問題。
+Documentation/admin-guide/reporting-regressions.rst 對此進行了更詳細的解釋。
+它還提供了很多你可能想知道的關於迴歸的其他信息；例如，它解釋瞭如何將您的問題
+添加到迴歸跟蹤列表中，以確保它不會被忽略。
 
 什麼是安全問題留給您自己判斷。在繼續之前，請考慮閱讀
-「Documentation/translations/zh_TW/admin-guide/security-bugs.rst」，
-因爲它提供了如何最恰當地處理安全問題的額外細節。
+Documentation/translations/zh_TW/admin-guide/security-bugs.rst ，
+因爲它提供瞭如何最恰當地處理安全問題的額外細節。
 
-當發生了完全無法接受的糟糕事情時，此問題就是一個「非常嚴重的問題」。例如，
-Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核突然顯示錯誤消息
-（「kernel panic」）並停止工作，或者根本沒有任何停止信息時，您也在處理一個嚴重
-的問題。注意：不要混淆「panic」（內核停止自身的致命錯誤）和「Oops」（可恢復錯誤），
+當發生了完全無法接受的糟糕事情時，此問題就是一個“非常嚴重的問題”。例如，
+Linux內核破壞了它處理的數據或損壞了它運行的硬件。當內核突然顯示錯誤消息
+（“kernel panic”）並停止工作，或者根本沒有任何停止信息時，您也在處理一個嚴重
+的問題。注意：不要混淆“panic”（內核停止自身的致命錯誤）和“Oops”（可恢復錯誤），
 因爲顯示後者之後內核仍然在運行。
 
 
@@ -325,22 +319,22 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核
 看起來很像內核問題的問題有時是由構建或運行時環境引起的。很難完全排除這種問
 題，但你應該儘量減少這種問題：
 
- * 構建內核時，請使用經過驗證的工具，因爲編譯器或二進位文件中的錯誤可能會導
+ * 構建內核時，請使用經過驗證的工具，因爲編譯器或二進制文件中的錯誤可能會導
    致內核出現錯誤行爲。
 
  * 確保您的計算機組件在其設計規範內運行；這對處理器、內存和主板尤爲重要。因
    此，當面臨潛在的內核問題時，停止低電壓或超頻。
 
- * 儘量確保不是硬體故障導致了你的問題。例如，內存損壞會導致大量的問題，這些
+ * 儘量確保不是硬件故障導致了你的問題。例如，內存損壞會導致大量的問題，這些
    問題會表現爲看起來像內核問題。
 
  * 如果你正在處理一個文件系統問題，你可能需要用 ``fsck`` 檢查一下文件系統，
    因爲它可能會以某種方式被損壞，從而導致無法預期的內核行爲。
 
- * 在處理回歸問題時，要確保沒有在更新內核的同時發生了其他變化。例如，這個問
-   題可能是由同時更新的其他軟體引起的。也有可能是在你第一次重啓進入新內核時，
-   某個硬體巧合地壞了。更新系統 BIOS 或改變 BIOS 設置中的某些內容也會導致
-   一些看起來很像內核回歸的問題。
+ * 在處理迴歸問題時，要確保沒有在更新內核的同時發生了其他變化。例如，這個問
+   題可能是由同時更新的其他軟件引起的。也有可能是在你第一次重啓進入新內核時，
+   某個硬件巧合地壞了。更新系統 BIOS 或改變 BIOS 設置中的某些內容也會導致
+   一些看起來很像內核迴歸的問題。
 
 
 爲緊急情況做好準備
@@ -349,8 +343,8 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核
     *創建一個全新的備份，並將系統修復和還原工具放在手邊*
 
 我得提醒您，您正在和計算機打交道，計算機有時會出現意想不到的事情，尤其是當
-您折騰其作業系統的內核等關鍵部件時。而這就是你在這個過程中要做的事情。因此，
-一定要創建一個全新的備份；還要確保你手頭有修復或重裝作業系統的所有工具，
+您折騰其操作系統的內核等關鍵部件時。而這就是你在這個過程中要做的事情。因此，
+一定要創建一個全新的備份；還要確保你手頭有修復或重裝操作系統的所有工具，
 以及恢復備份所需的一切。
 
 
@@ -366,67 +360,67 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核
 的任何模塊。然後重新啓動再繼續。
 
 注意，你可能不知道你的系統正在使用這些解決方案之一：當你安裝 Nvidia 專有圖
-形驅動程序、VirtualBox 或其他需要 Linux 內核以外的模塊支持的軟體時，它們通
-常會靜默設置。這就是爲什麼你可能需要卸載這些軟體的軟體包，以擺脫任何第三方
+形驅動程序、VirtualBox 或其他需要 Linux 內核以外的模塊支持的軟件時，它們通
+常會靜默設置。這就是爲什麼你可能需要卸載這些軟件的軟件包，以擺脫任何第三方
 內核模塊。
 
 
-檢測「汙染」標誌
+檢查“污染”標誌
 ----------------
 
-    *當問題發生時，檢查您的內核是否被「汙染」，因爲使內核設置這個標誌的事件可
+    *當問題發生時，檢查您的內核是否被“污染”，因爲使內核設置這個標誌的事件可
     能會導致您面臨的問題。*
 
-當某些可能會導致看起來完全不相關的後續錯誤的事情發生時，內核會用「汙染
-（taint）」標誌標記自己。如果您的內核受到汙染，那麼您面臨的可能是這樣的錯誤。
+當某些可能會導致看起來完全不相關的後續錯誤的事情發生時，內核會用“污染
+（taint）”標誌標記自己。如果您的內核受到污染，那麼您面臨的可能是這樣的錯誤。
 因此在投入更多時間到這個過程中之前，儘早排除此情況可能對你有好處。這是這個
-步驟出現在這裡的唯一原因，因爲這個過程稍後會告訴您安裝最新的主線內核；然後
-您將需要再次檢查汙染標誌，因爲當它出問題的時候內核報告會關注它。
+步驟出現在這裏的唯一原因，因爲這個過程稍後會告訴您安裝最新的主線內核；然後
+您將需要再次檢查污染標誌，因爲當它出問題的時候內核報告會關注它。
 
-在正在運行的系統上檢查內核是否汙染非常容易：如果 ``cat /proc/sys/kernel/tainted``
-返回「0」，那麼內核沒有被汙染，一切正常。在某些情況下無法檢查該文件；這就是
-爲什麼當內核報告內部問題（「kernel bug」）、可恢復錯誤（「kernel Oops」）或停止
-操作前不可恢復的錯誤（「kernel panic」）時，它也會提到汙染狀態。當其中一個錯
-誤發生時，查看列印的錯誤消息的頂部，搜索以「CPU:」開頭的行。如果發現問題時內
-核未被汙染，那麼它應該以「Not infected」結束；如果你看到「Tainted:」且後跟一些
-空格和字母，那就被汙染了。
+在正在運行的系統上檢查內核是否污染非常容易：如果 ``cat /proc/sys/kernel/tainted``
+返回“0”，那麼內核沒有被污染，一切正常。在某些情況下無法檢查該文件；這就是
+爲什麼當內核報告內部問題（“kernel bug”）、可恢復錯誤（“kernel Oops”）或停止
+操作前不可恢復的錯誤（“kernel panic”）時，它也會提到污染狀態。當其中一個錯
+誤發生時，查看打印的錯誤消息的頂部，搜索以“CPU:”開頭的行。如果發現問題時內
+核未被污染，那麼它應該以“Not infected”結束；如果你看到“Tainted:”且後跟一些
+空格和字母，那就被污染了。
 
-如果你的內核被汙染了，請閱讀「Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst」
-以找出原因。設法消除汙染因素。通常是由以下三種因素之一引起的：
+如果你的內核被污染了，請閱讀 Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
+以找出原因。設法消除污染因素。通常是由以下三種因素之一引起的：
 
- 1. 發生了一個可恢復的錯誤（「kernel Oops」），內核汙染了自己，因爲內核知道在
+ 1. 發生了一個可恢復的錯誤（“kernel Oops”），內核污染了自己，因爲內核知道在
     此之後它可能會出現奇怪的行爲錯亂。在這種情況下，檢查您的內核或系統日誌，
     並尋找以下列文字開頭的部分::
 
        Oops: 0000 [#1] SMP
 
-    如方括號中的「#1」所示，這是自啓動以來的第一次Oops。每個Oops和此後發生的
+    如方括號中的“#1”所示，這是自啓動以來的第一次Oops。每個Oops和此後發生的
     任何其他問題都可能是首個Oops的後續問題，即使這兩個問題看起來完全不相關。
     通過消除首個Oops的原因並在之後復現該問題，可以排除這種情況。有時僅僅
     重新啓動就足夠了，有時更改配置後重新啓動可以消除Oops。但是在這個流程中
     不要花費太多時間在這一點上，因爲引起Oops的原因可能已經在您稍後將按流程
     安裝的新Linux內核版本中修復了。
 
- 2. 您的系統使用的軟體安裝了自己的內核模塊，例如Nvidia的專有圖形驅動程序或
-    VirtualBox。當內核從外部源（即使它們是開源的）加載此類模塊時，它會汙染
+ 2. 您的系統使用的軟件安裝了自己的內核模塊，例如Nvidia的專有圖形驅動程序或
+    VirtualBox。當內核從外部源（即使它們是開源的）加載此類模塊時，它會污染
     自己：它們有時會在不相關的內核區域導致錯誤，從而可能導致您面臨的問題。
     因此，當您想要向Linux內核開發人員報告問題時，您必須阻止這些模塊加載。
-    大多數情況下最簡單的方法是：臨時卸載這些軟體，包括它們可能已經安裝的任
+    大多數情況下最簡單的方法是：臨時卸載這些軟件，包括它們可能已經安裝的任
     何模塊。之後重新啓動。
 
- 3. 當內核加載駐留在Linux內核原始碼staging樹中的模塊時，它也會汙染自身。這
+ 3. 當內核加載駐留在Linux內核源代碼staging樹中的模塊時，它也會污染自身。這
     是一個特殊的區域，代碼（主要是驅動程序）還沒有達到正常Linux內核的質量
-    標準。當您報告此種模塊的問題時，內核受到汙染顯然是沒有問題的；只需確保
-    問題模塊是造成汙染的唯一原因。如果問題發生在一個不相關的區域，重新啓動
+    標準。當您報告此種模塊的問題時，內核受到污染顯然是沒有問題的；只需確保
+    問題模塊是造成污染的唯一原因。如果問題發生在一個不相關的區域，重新啓動
     並通過指定 ``foo.blacklist=1`` 作爲內核參數臨時阻止該模塊被加載（用有
-    問題的模塊名替換「foo」）。
+    問題的模塊名替換“foo”）。
 
 
 記錄如何重現問題
 ------------------
 
     *粗略地寫下如何重現這個問題。如果您同時處理多個問題，請爲每個問題單獨寫
-    注釋，並確保它們在新啓動的系統上獨立出現。這是必要的，因爲每個問題都需
+    註釋，並確保它們在新啓動的系統上獨立出現。這是必要的，因爲每個問題都需
     要分別報告給內核開發人員，除非它們嚴重糾纏在一起。*
 
 如果你同時處理多個問題，必須分別報告每個問題，因爲它們可能由不同的開發人員
@@ -438,20 +432,20 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核
 
 注意：報告只發生過一次的問題往往是沒有結果的，因爲它們可能是由於宇宙輻射導
 致的位翻轉。所以你應該嘗試通過重現問題來排除這種情況，然後再繼續。如果你有
-足夠的經驗來區分由於硬體故障引起的一次性錯誤和難以重現的罕見內核問題，可以
+足夠的經驗來區分由於硬件故障引起的一次性錯誤和難以重現的罕見內核問題，可以
 忽略這個建議。
 
 
-穩定版或長期支持內核的回歸？
+穩定版或長期支持內核的迴歸？
 -----------------------------
 
-    *如果您正面臨穩定版或長期支持版本線的回歸（例如從5.10.4更新到5.10.5時出現
-    故障），請查看後文「報告穩定版和長期支持內核線的回歸」小節。*
+    *如果您正面臨穩定版或長期支持版本線的迴歸（例如從5.10.4更新到5.10.5時出現
+    故障），請查看後文“報告穩定版和長期支持內核線的迴歸”小節。*
 
-穩定版和長期支持內核版本線中的回歸是Linux開發人員非常希望解決的問題，這樣的
-問題甚至比主線開發分支中的回歸更不應出現，因爲它們會很快影響到很多人。開發人員
-希望儘快了解此類問題，因此有一個簡化流程來報告這些問題。注意，使用更新內核版
-本線的回歸（比如從5.9.15切換到5.10.5時出現故障）不符合條件。
+穩定版和長期支持內核版本線中的迴歸是Linux開發人員非常希望解決的問題，這樣的
+問題甚至比主線開發分支中的迴歸更不應出現，因爲它們會很快影響到很多人。開發人員
+希望儘快瞭解此類問題，因此有一個簡化流程來報告這些問題。注意，使用更新內核版
+本線的迴歸（比如從5.9.15切換到5.10.5時出現故障）不符合條件。
 
 
 你需要將問題報告到何處
@@ -462,9 +456,9 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬體。當內核
     過郵件發送給維護人員和公共郵件列表。*
 
 將報告發送給合適的人是至關重要的，因爲Linux內核是一個大項目，大多數開發人員
-只熟悉其中的一小部分。例如，相當多的程式設計師只關心一個驅動程序，比如一個WiFi
-晶片驅動程序；它的開發人員可能對疏遠的或不相關的「子系統」（如TCP堆棧、
-PCIe/PCI子系統、內存管理或文件系統）的內部知識了解很少或完全不了解。
+只熟悉其中的一小部分。例如，相當多的程序員只關心一個驅動程序，比如一個WiFi
+芯片驅動程序；它的開發人員可能對疏遠的或不相關的“子系統”（如TCP堆棧、
+PCIe/PCI子系統、內存管理或文件系統）的內部知識瞭解很少或完全不瞭解。
 
 問題在於：Linux內核缺少一個，可以簡單地將問題歸檔並讓需要了解它的開發人員了
 解它的，中心化缺陷跟蹤器。這就是爲什麼你必須找到正確的途徑來自己報告問題。
@@ -476,10 +470,10 @@ PCIe/PCI子系統、內存管理或文件系統）的內部知識了解很少或
 
 爲了說明如何使用 :ref:`MAINTAINERS <maintainers>` 文件，讓我們假設您的筆記
 本電腦中的WiFi在更新內核後突然出現了錯誤行爲。這種情況下可能是WiFi驅動的問
-題。顯然，它也可能由於驅動基於的某些代碼，但除非你懷疑有這樣的東西會附著在
-驅動程序上。如果真的是其他的問題，驅動程序的開發人員會讓合適的人參與進來。
+題。顯然，它也可能由於驅動基於的某些代碼，但除非你懷疑有這樣的東西會附着在
+驅動程序上。如果真的是其他的問題，驅動程序的開發人員會讓合適的人蔘與進來。
 
-遺憾的是，沒有通用且簡單的辦法來檢查哪個代碼驅動了特定硬體組件。
+遺憾的是，沒有通用且簡單的辦法來檢查哪個代碼驅動了特定硬件組件。
 
 在WiFi驅動出現問題的情況下，你可能想查看 ``lspci -k`` 的輸出，因爲它列出了
 PCI/PCIe總線上的設備和驅動它的內核模塊::
@@ -492,19 +486,19 @@ PCI/PCIe總線上的設備和驅動它的內核模塊::
          Kernel modules: ath10k_pci
        [...]
 
-但如果你的WiFi晶片通過USB或其他內部總線連接，這種方法就行不通了。在這種情況
+但如果你的WiFi芯片通過USB或其他內部總線連接，這種方法就行不通了。在這種情況
 下，您可能需要檢查您的WiFi管理器或 ``ip link`` 的輸出。尋找有問題的網絡接口
-的名稱，它可能類似於「wlp58s0」。此名稱可以用來找到驅動它的模塊::
+的名稱，它可能類似於“wlp58s0”。此名稱可以用來找到驅動它的模塊::
 
        [user@something ~]$ realpath --relative-to=/sys/module//sys/class/net/wlp58s0/device/driver/module
        ath10k_pci
 
 如果這些技巧不能進一步幫助您，請嘗試在網上搜索如何縮小相關驅動程序或子系統
-的範圍。如果你不確定是哪一個：試著猜一下，即使你猜得不好，也會有人會幫助你
+的範圍。如果你不確定是哪一個：試着猜一下，即使你猜得不好，也會有人會幫助你
 的。
 
 一旦您知道了相應的驅動程序或子系統，您就希望在MAINTAINERS文件中搜索它。如果
-是「ath10k_pci」，您不會找到任何東西，因爲名稱太具體了。有時你需要在網上尋找
+是“ath10k_pci”，您不會找到任何東西，因爲名稱太具體了。有時你需要在網上尋找
 幫助；但在此之前，請嘗試使用一個稍短或修改過的名稱來搜索MAINTAINERS文件，因
 爲這樣你可能會發現類似這樣的東西::
 
@@ -516,23 +510,23 @@ PCI/PCIe總線上的設備和驅動它的內核模塊::
        SCM:           git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        Files:         drivers/net/wireless/ath/ath10k/
 
-注意：如果您閱讀在Linux原始碼樹的根目錄中找到的原始維護者文件，則行描述將是
-縮寫。例如，「Mail:（郵件）」將是「M:」，「Mailing list:（郵件列表）」將是「L」，
-「Status:（狀態）」將是「S:」。此文件頂部有一段解釋了這些和其他縮寫。
+注意：如果您閱讀在Linux源代碼樹的根目錄中找到的原始維護者文件，則行描述將是
+縮寫。例如，“Mail:（郵件）”將是“M:”，“Mailing list:（郵件列表）”將是“L”，
+“Status:（狀態）”將是“S:”。此文件頂部有一段解釋了這些和其他縮寫。
 
-首先查看「Status」狀態行。理想情況下，它應該得到「Supported（支持）」或
-「Maintained（維護）」。如果狀態爲「Obsolete（過時的）」，那麼你在使用一些過時的
-方法，需要轉換到新的解決方案上。有時候，只有在感到有動力時，才會有人爲代碼
-提供「Odd Fixes」。如果碰見「Orphan」，你就完全不走運了，因爲再也沒有人關心代碼
-了，只剩下這些選項:準備好與問題共存，自己修復它，或者找一個願意修復它的程式設計師。
+首先查看“Status”狀態行。理想情況下，它應該得到“Supported（支持）”或
+“Maintained（維護）”。如果狀態爲“Obsolete（過時的）”，那麼你在使用一些過時的
+方法，需要轉換到新的解決方案上。有時候，只有在感到有動力時，纔會有人爲代碼
+提供“Odd Fixes”。如果碰見“Orphan”，你就完全不走運了，因爲再也沒有人關心代碼
+了，只剩下這些選項:準備好與問題共存，自己修復它，或者找一個願意修復它的程序員。
 
-檢查狀態後，尋找以「bug:」開頭的一行：它將告訴你在哪裡可以找到子系統特定的缺
+檢查狀態後，尋找以“bug:”開頭的一行：它將告訴你在哪裏可以找到子系統特定的缺
 陷跟蹤器來提交你的問題。上面的例子沒有此行。大多數部分都是這樣，因爲 Linux
 內核的開發完全是由郵件驅動的。很少有子系統使用缺陷跟蹤器，且其中只有一部分
 依賴於 bugzilla.kernel.org。
 
-在這種以及其他很多情況下，你必須尋找以「Mail:」開頭的行。這些行提到了特定代碼
-的維護者的名字和電子郵件地址。也可以查找以「Mailing list:」開頭的行，它告訴你
+在這種以及其他很多情況下，你必須尋找以“Mail:”開頭的行。這些行提到了特定代碼
+的維護者的名字和電子郵件地址。也可以查找以“Mailing list:”開頭的行，它告訴你
 開發代碼的公共郵件列表。你的報告之後需要通過郵件發到這些地址。另外，對於所有
 通過電子郵件發送的問題報告，一定要抄送 Linux Kernel Mailing List（LKML）
 <linux-kernel@vger.kernel.org>。在以後通過郵件發送問題報告時，不要遺漏任何
@@ -544,8 +538,8 @@ PCI/PCIe總線上的設備和驅動它的內核模塊::
 ~~~~~~~~~~~~~~~~~~~~
 
 對於手頭有Linux源碼的人來說，有第二個可以找到合適的報告地點的選擇：腳本
-「scripts/get_maintainer.pl」，它嘗試找到所有要聯繫的人。它會查詢MAINTAINERS
-文件，並需要用相關原始碼的路徑來調用。對於編譯成模塊的驅動程序，經常可以用
+“scripts/get_maintainer.pl”，它嘗試找到所有要聯繫的人。它會查詢MAINTAINERS
+文件，並需要用相關源代碼的路徑來調用。對於編譯成模塊的驅動程序，經常可以用
 這樣的命令找到::
 
        $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
@@ -561,13 +555,13 @@ PCI/PCIe總線上的設備和驅動它的內核模塊::
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
        linux-kernel@vger.kernel.org (open list)
 
-不要把你的報告發給所有的人。發送給維護者，腳本稱之爲「supporter:」；另外抄送
+不要把你的報告發給所有的人。發送給維護者，腳本稱之爲“supporter:”；另外抄送
 代碼最相關的郵件列表，以及 Linux 內核郵件列表（LKML）。在此例中，你需要將報
-告發送給 「Some Human <shuman@example.com>」 ，並抄送
-「ath10k@lists.infradead.org」和「linux-kernel@vger.kernel.org」。
+告發送給 “Some Human <shuman@example.com>” ，並抄送
+“ath10k@lists.infradead.org”和“linux-kernel@vger.kernel.org”。
 
-注意：如果你用 git 克隆了 Linux 原始碼，你可能需要用--git 再次調用
-get_maintainer.pl。腳本會查看提交歷史，以找到最近哪些人參與了相關代碼的編寫，
+注意：如果你用 git 克隆了 Linux 源代碼，你可能需要用--git 再次調用
+get_maintainer.pl。腳本會查看提交歷史，以找到最近哪些人蔘與了相關代碼的編寫，
 因爲他們可能會提供幫助。但要小心使用這些結果，因爲它很容易讓你誤入歧途。
 例如，這種情況常常會發生在很少被修改的地方（比如老舊的或未維護的驅動程序）：
 有時這樣的代碼會在樹級清理期間被根本不關心此驅動程序的開發者修改。
@@ -580,73 +574,74 @@ get_maintainer.pl。腳本會查看提交歷史，以找到最近哪些人參與
     如果找到匹配的報告，請加入討論而不是發送新報告。*
 
 如前所述：報告一個別人已經提出的問題，對每個人來說都是浪費時間，尤其是作爲報告
-人的你。這就是爲什麼你應該再次搜索現有的報告。現在你已經知道問題需要報告到哪裡。
+人的你。這就是爲什麼你應該再次搜索現有的報告。現在你已經知道問題需要報告到哪裏。
 如果是郵件列表，那麼一般在 `lore.kernel.org <https://lore.kernel.org/>`_ 可以
 找到相應存檔。
 
 但有些列表運行在其他地方。例如前面步驟中當例子的ath10k WiFi驅動程序就是這種
-情況。但是你通常可以在網上很容易地找到這些列表的檔案。例如搜索「archive
-ath10k@lists.infradead.org」，將引導您到ath10k郵件列表的信息頁，該頁面頂部連結
+情況。但是你通常可以在網上很容易地找到這些列表的檔案。例如搜索“archive
+ath10k@lists.infradead.org”，將引導您到ath10k郵件列表的信息頁，該頁面頂部鏈接
 到其 `列表存檔 <https://lists.infradead.org/pipermail/ath10k/>`_ 。遺憾的是，
-這個列表和其他一些列表缺乏搜索其存檔的功能。在這種情況下可以使用常規的網際網路
-搜尋引擎，並添加類似「site:lists.infadead.org/pipermail/ath10k/」這
-樣的搜索條件，這會把結果限制在該連結中的檔案。
+這個列表和其他一些列表缺乏搜索其存檔的功能。在這種情況下可以使用常規的互聯網
+搜索引擎，並添加類似“site:lists.infadead.org/pipermail/ath10k/”這
+樣的搜索條件，這會把結果限制在該鏈接中的檔案。
 
-也請進一步搜索網絡、LKML和bugzilla.kernel.org網站。
+也請進一步搜索網絡、LKML和bugzilla.kernel.org網站。如果你的報告需要發送到缺陷
+跟蹤器中，那麼您可能還需要檢查子系統的郵件列表存檔，因爲可能有人只在那裏報告了它。
 
-有關如何搜索以及在找到匹配報告時如何操作的詳細信息，請參閱上面的「搜索現有報告
-（第一部分）」。
+有關如何搜索以及在找到匹配報告時如何操作的詳細信息，請參閱上面的“搜索現有報告
+（第一部分）”。
 
-不要急著完成報告過程的這一步：花30到60分鐘甚至更多的時間可以爲你和其他人節省 /
+不要急着完成報告過程的這一步：花30到60分鐘甚至更多的時間可以爲你和其他人節省 /
 減少相當多的時間和麻煩。
 
 
 安裝一個新的內核進行測試
 --------------------------
 
-    *除非您已經在運行最新的「主線」Linux內核，否則最好在報告流程前安裝它。在
-    某些情況下，使用最新的「穩定版」Linux進行測試和報告也是可以接受的替代方案；
+    *除非您已經在運行最新的“主線”Linux內核，否則最好在報告流程前安裝它。在
+    某些情況下，使用最新的“穩定版”Linux進行測試和報告也是可以接受的替代方案；
     在合併窗口期間，這實際上可能是最好的方法，但在開發階段最好還是暫停幾天。
-    無論你選擇什麼版本，最好使用「普通」構建。忽略這些建議會大大增加您的報告
+    無論你選擇什麼版本，最好使用“普通”構建。忽略這些建議會大大增加您的報告
     被拒絕或忽略的風險。*
 
-正如第一步的詳細解釋中所提到的：與大多數程式設計師一樣，與大多數程式設計師一樣，Linux
-內核開發人員不喜歡花時間處理他們維護的原始碼中根本不會發生的問題的報告。這隻
+正如第一步的詳細解釋中所提到的：與大多數程序員一樣，與大多數程序員一樣，Linux
+內核開發人員不喜歡花時間處理他們維護的源代碼中根本不會發生的問題的報告。這隻
 會浪費每個人的時間，尤其是你的時間。這就是爲什麼在報告問題之前，您必須先確認
 問題仍然存在於最新的上游代碼中，這符合每個人的利益。您可以忽略此建議，但如前
 所述：這樣做會極大地增加問題報告被拒絕或被忽略的風險。
 
-內核「最新上游」的範圍通常指：
+內核“最新上游”的範圍通常指：
 
  * 安裝一個主線內核；最新的穩定版內核也可以是一個選擇，但大多數時候都最好避免。
-   長期支持內核（有時稱爲「LTS內核」）不適合此流程。下一小節將更詳細地解釋所有
+   長期支持內核（有時稱爲“LTS內核”）不適合此流程。下一小節將更詳細地解釋所有
    這些。
 
  * 下一小節描述獲取和安裝這樣一個內核的方法。它還指出了使用預編譯內核是可以的，
-   但普通的內核更好，這意味著：它是直接使用從 `kernel.org <https://kernel.org/>`_
-   獲得的Linux原始碼構建並且沒有任何方式修改或增強。
+   但普通的內核更好，這意味着：它是直接使用從 `kernel.org <https://kernel.org/>`_
+   獲得的Linux源代碼構建並且沒有任何方式修改或增強。
 
 
 選擇適合測試的版本
 ~~~~~~~~~~~~~~~~~~~~
 
-前往 `kernel.org <https://kernel.org/>`_ 來決定使用哪個版本。忽略那個寫著
-「Latest release最新版本」的巨大黃色按鈕，往下看有一個表格。在表格的頂部，你會
-看到一行以「mainline」開頭的字樣，大多數情況下它會指向一個版本號類似「5.8-rc2」
-的預發布版本。如果是這樣的話，你將需要使用這個主線內核進行測試。不要讓「rc」
-嚇到你，這些「開發版內核」實際上非常可靠——而且你已經按照上面的指示做了備份，
+前往 `kernel.org <https://kernel.org/>`_ 來決定使用哪個版本。忽略那個寫着
+“Latest release最新版本”的巨大黃色按鈕，往下看有一個表格。在表格的頂部，你會
+看到一行以“mainline”開頭的字樣，大多數情況下它會指向一個版本號類似“5.8-rc2”
+的預發佈版本。如果是這樣的話，你將需要使用這個主線內核進行測試。不要讓“rc”
+嚇到你，這些“開發版內核”實際上非常可靠——而且你已經按照上面的指示做了備份，
 不是嗎？
 
-大概每九到十周，「mainline」可能會給你指出一個版本號類似「5.7」的正式版本。如果
-碰見這種情況，請考慮暫停報告過程，直到下一個版本的第一個預發布（5.8-rc1）出
-現在 `kernel.org <https://kernel.org/>`_ 上。這是因爲 Linux 的開發周期正在
-兩周的「合併窗口」內。大部分的改動和所有干擾性的改動都會在這段時間內被合併到
+大概每九到十週，“mainline”可能會給你指出一個版本號類似“5.7”的正式版本。如果
+碰見這種情況，請考慮暫停報告過程，直到下一個版本的第一個預發佈（5.8-rc1）出
+現在 `kernel.org <https://kernel.org/>`_ 上。這是因爲 Linux 的開發週期正在
+兩週的“合併窗口”內。大部分的改動和所有干擾性的改動都會在這段時間內被合併到
 下一個版本中。在此期間使用主線是比較危險的。內核開發者通常也很忙，可能沒有
 多餘的時間來處理問題報告。這也是很有可能在合併窗口中應用了許多修改來修復你
-所面臨的問題；這就是爲什麼你很快就得用一個新的內核版本重新測試，就像下面「發
-布報告後的責任」一節中所述的那樣。
+所面臨的問題；這就是爲什麼你很快就得用一個新的內核版本重新測試，就像下面“發
+布報告後的責任”一節中所述的那樣。
 
-這就是爲什麼要等到合併窗口結束後才去做。但是如果你處理的是一些不應該等待的
+這就是爲什麼要等到合併窗口結束後纔去做。但是如果你處理的是一些不應該等待的
 東西，則無需這樣做。在這種情況下，可以考慮通過 git 獲取最新的主線內核（見下
 文），或者使用 kernel.org 上提供的最新穩定版本。如果 mainline 因爲某些原因
 不無法正常工作，那麼使用它也是可以接受的。總的來說：用它來重現問題也比完全
@@ -657,7 +652,7 @@ ath10k@lists.infradead.org」，將引導您到ath10k郵件列表的信息頁，
 需要先在主線修復，然後才能得到回傳，這可能需要幾天或幾周。另一個原因是：您
 希望的修復對於回傳來說可能太難或太冒險；因此再次報告問題不太可能改變任何事情。
 
-這些方面也部分表明了爲什麼長期支持內核（有時稱爲「LTS內核」）不適合報告流程：
+這些方面也部分表明了爲什麼長期支持內核（有時稱爲“LTS內核”）不適合報告流程：
 它們與當前代碼的距離太遠。因此，先去測試主線，然後再按流程走：如果主線沒有
 出現問題，流程將指導您如何在舊版本線中修復它。
 
@@ -669,31 +664,31 @@ ath10k@lists.infradead.org」，將引導您到ath10k郵件列表的信息頁，
 
 **使用預編譯的內核** ：這往往是最快速、最簡單、最安全的方法——尤其是在你不熟
 悉 Linux 內核的情況下。問題是：發行商或附加存儲庫提供的大多數版本都是從修改
-過的Linux原始碼構建的。因此它們不是普通的，通常不適合於測試和問題報告：這些
+過的Linux源代碼構建的。因此它們不是普通的，通常不適合於測試和問題報告：這些
 更改可能會導致您面臨的問題或以某種方式影響問題。
 
 但是如果您使用的是流行的Linux發行版，那麼您就很幸運了：對於大部分的發行版，
 您可以在網上找到包含最新主線或穩定版本Linux內核包的存儲庫。使用這些是完全可
-以的，只要從存儲庫的描述中確認它們是普通的或者至少接近普通。此外，請確保軟體
-包包含kernel.org上提供的最新版本內核。如果這些軟體包的時間超過一周，那麼它們
-可能就不合適了，因爲新的主線和穩定版內核通常至少每周發布一次。
+以的，只要從存儲庫的描述中確認它們是普通的或者至少接近普通。此外，請確保軟件
+包包含kernel.org上提供的最新版本內核。如果這些軟件包的時間超過一週，那麼它們
+可能就不合適了，因爲新的主線和穩定版內核通常至少每週發佈一次。
 
 請注意，您以後可能需要手動構建自己的內核：有時這是調試或測試修復程序所必需的，
 如後文所述。還要注意，預編譯的內核可能缺少在出現panic、Oops、warning或BUG時
-解碼內核列印的消息所需的調試符號；如果您計劃解碼這些消息，最好自己編譯內核
-（有關詳細信息，請參閱本小節結尾和「解碼失敗信息」小節）。
+解碼內核打印的消息所需的調試符號；如果您計劃解碼這些消息，最好自己編譯內核
+（有關詳細信息，請參閱本小節結尾和“解碼失敗信息”小節）。
 
 **使用git** ：熟悉 git 的開發者和有經驗的 Linux 用戶通常最好直接從
 `kernel.org 上的官方開發倉庫
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
-中獲取最新的 Linux 內核原始碼。這些很可能比最新的主線預發布版本更新一些。不
-用擔心：它們和正式的預發布版本一樣可靠，除非內核的開發周期目前正處於合併窗
+中獲取最新的 Linux 內核源代碼。這些很可能比最新的主線預發佈版本更新一些。不
+用擔心：它們和正式的預發佈版本一樣可靠，除非內核的開發週期目前正處於合併窗
 口中。不過即便如此，它們也是相當可靠的。
 
 **常規方法** ：不熟悉 git 的人通常最好從 `kernel.org <https://kernel.org/>`_
 下載源碼的tar 存檔包。
 
-如何實際構建一個內核並不在這裡描述，因爲許多網站已經解釋了必要的步驟。如果
+如何實際構建一個內核並不在這裏描述，因爲許多網站已經解釋了必要的步驟。如果
 你是新手，可以考慮按照那些建議使用 ``make localmodconfig`` 來做，它將嘗試獲
 取你當前內核的配置，然後根據你的系統進行一些調整。這樣做並不能使編譯出來的
 內核更好，但可以更快地編譯。
@@ -702,19 +697,19 @@ ath10k@lists.infradead.org」，將引導您到ath10k郵件列表的信息頁，
 啓用 CONFIG_KALLSYMS 選項。此外，還可以啓用 CONFIG_DEBUG_KERNEL 和
 CONFIG_DEBUG_INFO；後者是相關選項，但只有啓用前者才能開啓。請注意，
 CONFIG_DEBUG_INFO 會需要更多儲存空間來構建內核。但這是值得的，因爲這些選項將
-允許您稍後精確定位觸發問題的確切代碼行。下面的「解碼失敗信息」一節對此進行了更
+允許您稍後精確定位觸發問題的確切代碼行。下面的“解碼失敗信息”一節對此進行了更
 詳細的解釋。
 
 但請記住：始終記錄遇到的問題，以防難以重現。發送未解碼的報告總比不報告要好。
 
 
-檢查「汙染」標誌
+檢查“污染”標誌
 ----------------
 
-    *確保您剛剛安裝的內核在運行時不會「汙染」自己。*
+    *確保您剛剛安裝的內核在運行時不會“污染”自己。*
 
 正如上面已經詳細介紹過的：當發生一些可能會導致一些看起來完全不相關的後續錯
-誤的事情時，內核會設置一個「汙染」標誌。這就是爲什麼你需要檢查你剛剛安裝的內
+誤的事情時，內核會設置一個“污染”標誌。這就是爲什麼你需要檢查你剛剛安裝的內
 核是否有設置此標誌。如果有的話，幾乎在任何情況下你都需要在報告問題之前先消
 除它。詳細的操作方法請看上面的章節。
 
@@ -729,43 +724,43 @@ CONFIG_DEBUG_INFO 會需要更多儲存空間來構建內核。但這是值得
 可以考慮使用此版本線，放棄報告問題。但是請記住，只要它沒有在 `kernel.org
 <https://kernel.org/>`_ 的穩定版和長期版（以及由這些版本衍生出來的廠商內核）
 中得到修復，其他用戶可能仍然會受到它的困擾。如果你喜歡使用其中的一個，或
-者只是想幫助它們的用戶，請前往下面的「報告只發生在較舊內核版本線的問題」一節。
+者只是想幫助它們的用戶，請前往下面的“報告只發生在較舊內核版本線的問題”一節。
 
 
 優化復現問題的描述
 --------------------
 
-    *優化你的筆記：試著找到並寫出最直接的復現問題的方法。確保最終結果包含所
+    *優化你的筆記：試着找到並寫出最直接的復現問題的方法。確保最終結果包含所
     有重要的細節，同時讓第一次聽說的人容易閱讀和理解。如果您在此過程中學到
     了一些東西，請考慮再次搜索關於該問題的現有報告。*
 
 過於複雜的報告會讓別人很難理解。因此請儘量找到一個可以直接描述、易於以書面
 形式理解的再現方法。包含所有重要的細節，但同時也要儘量保持簡短。
 
-在這在前面的步驟中，你很可能已經了解了一些關於你所面臨的問題的點。利用這些
+在這在前面的步驟中，你很可能已經瞭解了一些關於你所面臨的問題的點。利用這些
 知識，再次搜索可以轉而加入的現有報告。
 
 
 解碼失敗信息
 -------------
 
-    *如果失敗涉及「panic」、「Oops」、「warning」或「BUG」，請考慮解碼內核日誌以查找
+    *如果失敗涉及“panic”、“Oops”、“warning”或“BUG”，請考慮解碼內核日誌以查找
     觸發錯誤的代碼行。*
 
-當內核檢測到內部問題時，它會記錄一些有關已執行代碼的信息。這使得在原始碼中精
+當內核檢測到內部問題時，它會記錄一些有關已執行代碼的信息。這使得在源代碼中精
 確定位觸發問題的行並顯示如何調用它成爲可能。但只有在配置內核時啓用了
 CONFIG_DEBUG_INFO 和 CONFIG_KALLSYMS選項時，這種方法才起效。如果已啓用此選項，
-請考慮解碼內核日誌中的信息。這將使我們更容易理解是什麼導致了「panic」、「Oops」、
-「warning」或「BUG」，從而增加了有人提供修復的機率。
+請考慮解碼內核日誌中的信息。這將使我們更容易理解是什麼導致了“panic”、“Oops”、
+“warning”或“BUG”，從而增加了有人提供修復的幾率。
 
-解碼可以通過Linux原始碼樹中的腳本來完成。如果您運行的內核是之前自己編譯的，
+解碼可以通過Linux源代碼樹中的腳本來完成。如果您運行的內核是之前自己編譯的，
 這樣這樣調用它::
 
 	[user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
 	/usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/kernels/5.10.10-4.1.x86_64/
 
 如果您運行的是打包好的普通內核，則可能需要安裝帶有調試符號的相應包。然後按以下
-方式調用腳本（如果發行版未打包，則可能需要從Linux原始碼獲取）::
+方式調用腳本（如果發行版未打包，則可能需要從Linux源代碼獲取）::
 
 	[user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh \
 	/usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/kernels/5.10.10-4.1.x86_64/
@@ -778,10 +773,10 @@ CONFIG_DEBUG_INFO 和 CONFIG_KALLSYMS選項時，這種方法才起效。如果
 
 	[   68.387301] RIP: 0010:test_module_init (/home/username/linux-5.10.5/test-module/test-module.c:16) test_module
 
-在本例中，執行的代碼是從文件「~/linux-5.10.5/test-module/test-module.c」構建的，
+在本例中，執行的代碼是從文件“~/linux-5.10.5/test-module/test-module.c”構建的，
 錯誤出現在第16行的指令中。
 
-該腳本也會如此解碼以「Call trace」開頭的部分中提到的地址，該部分顯示出現問題的
+該腳本也會如此解碼以“Call trace”開頭的部分中提到的地址，該部分顯示出現問題的
 函數的路徑。此外，腳本還會顯示內核正在執行的代碼部分的彙編輸出。
 
 注意，如果你沒法做到這一點，只需跳過這一步，並在報告中說明原因。如果你幸運的
@@ -790,60 +785,60 @@ CONFIG_DEBUG_INFO 和 CONFIG_KALLSYMS選項時，這種方法才起效。如果
 別擔心，如果您碰到的情況需要這樣做，開發人員會告訴您該怎麼做。
 
 
-對回歸的特別關照
+對迴歸的特別關照
 -----------------
 
-    *如果您的問題是回歸問題，請儘可能縮小引入問題時的範圍。*
+    *如果您的問題是迴歸問題，請儘可能縮小引入問題時的範圍。*
 
 Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這就是爲什麼他
-認爲回歸是不可接受的，並希望看到它們被迅速修復。這就是爲什麼引入了回歸的改
-動導致的問題若無法通過其他方式快速解決，通常會被迅速撤銷。因此，報告回歸有
-點像「王炸」，會迅速得到修復。但要做到這一點，需要知道導致回歸的變化。通常情
+認爲迴歸是不可接受的，並希望看到它們被迅速修復。這就是爲什麼引入了迴歸的改
+動導致的問題若無法通過其他方式快速解決，通常會被迅速撤銷。因此，報告迴歸有
+點像“王炸”，會迅速得到修復。但要做到這一點，需要知道導致迴歸的變化。通常情
 況下，要由報告者來追查罪魁禍首，因爲維護者往往沒有時間或手頭設置不便來自行
 重現它。
 
-有一個叫做「二分」的過程可以來尋找變化，這在
-「Documentation/translations/zh_TW/admin-guide/bug-bisect.rst」文檔中進行了詳細
+有一個叫做“二分”的過程可以來尋找變化，這在
+Documentation/translations/zh_TW/admin-guide/bug-bisect.rst 文檔中進行了詳細
 的描述，這個過程通常需要你構建十到二十個內核鏡像，每次都嘗試在構建下一個鏡像
-之前重現問題。是的，這需要花費一些時間，但不用擔心，它比大多數人想像的要快得多。
-多虧了「binary search二進位搜索」，這將引導你在原始碼管理系統中找到導致回歸的提交。
+之前重現問題。是的，這需要花費一些時間，但不用擔心，它比大多數人想象的要快得多。
+多虧了“binary search二分搜索”，這將引導你在源代碼管理系統中找到導致迴歸的提交。
 一旦你找到它，就在網上搜索其主題、提交ID和縮短的提交ID（提交ID的前12個字符）。
 如果有的話，這將引導您找到關於它的現有報告。
 
 需要注意的是，二分法需要一點竅門，不是每個人都懂得訣竅，也需要相當多的努力，
 不是每個人都願意投入。儘管如此，還是強烈建議自己進行一次二分。如果你真的
-不能或者不想走這條路，至少要找出是哪個主線內核引入的回歸。比如說從 5.5.15
+不能或者不想走這條路，至少要找出是哪個主線內核引入的迴歸。比如說從 5.5.15
 切換到 5.8.4 的時候出現了一些問題，那麼至少可以嘗試一下相近的所有的主線版本
 （5.6、5.7 和 5.8）來檢查它是什麼時候出現的。除非你想在一個穩定版或長期支持
-內核中找到一個回歸，否則要避免測試那些編號有三段的版本（5.6.12、5.7.8），因
-爲那會使結果難以解釋，可能會讓你的測試變得無用。一旦你找到了引入回歸的主要
+內核中找到一個迴歸，否則要避免測試那些編號有三段的版本（5.6.12、5.7.8），因
+爲那會使結果難以解釋，可能會讓你的測試變得無用。一旦你找到了引入迴歸的主要
 版本，就可以放心地繼續報告了。但請記住：在不知道罪魁禍首的情況下，開發人員
 是否能夠提供幫助取決於手頭的問題。有時他們可能會從報告中確認是什麼出現了問
 題，並能修復它；有時他們可能無法提供幫助，除非你進行二分。
 
-當處理回歸問題時，請確保你所面臨的問題真的是由內核引起的，而不是由其他東西
+當處理迴歸問題時，請確保你所面臨的問題真的是由內核引起的，而不是由其他東西
 引起的，如上文所述。
 
-在整個過程中，請記住：只有當舊內核和新內核的配置相似時，問題才算回歸。最好
-的方法是：把配置文件（``.config``）從舊的工作內核直接複製到你嘗試的每個新內
-核版本。之後運行 ``make oldnoconfig`` 來調整它以適應新版本的需要，而不啓用
-任何新的功能，因爲那些功能也可能導致回歸。
+在整個過程中，請記住：只有當舊內核和新內核的配置相似時，問題纔算迴歸。這可以
+通過 ``make olddefconfig`` 來實現，詳細解釋參見
+Documentation/admin-guide/reporting-regressions.rst ；它還提供了大量其他您
+可能希望瞭解的有關回歸的信息。
 
 
-撰寫並發送報告
+撰寫併發送報告
 ---------------
 
     *通過詳細描述問題來開始編寫報告。記得包括以下條目：您爲復現而安裝的最新
     內核版本、使用的Linux發行版以及關於如何復現該問題的說明。如果可能，將內
-    核構建配置（.config）和 ``dmesg`` 的輸出放在網上的某個地方，並連結到它。
+    核構建配置（.config）和 ``dmesg`` 的輸出放在網上的某個地方，並鏈接到它。
     包含或上傳所有其他可能相關的信息，如Oops的輸出/截圖或來自 ``lspci``
     的輸出。一旦你寫完了這個主要部分，請在上方插入一個正常長度的段落快速概
     述問題和影響。再在此之上添加一個簡單描述問題的句子，以得到人們的閱讀。
     現在給出一個更短的描述性標題或主題。然後就可以像MAINTAINERS文件告訴你的
-    那樣發送或提交報告了，除非你在處理一個「高優先級問題」：它們需要按照下面
-    「高優先級問題的特殊處理」所述特別關照。*
+    那樣發送或提交報告了，除非你在處理一個“高優先級問題”：它們需要按照下面
+    “高優先級問題的特殊處理”所述特別關照。*
 
-現在你已經準備好了一切，是時候寫你的報告了。上文前言中連結的三篇文檔對如何
+現在你已經準備好了一切，是時候寫你的報告了。上文前言中鏈接的三篇文檔對如何
 寫報告做了部分解釋。這就是爲什麼本文將只提到一些基本的內容以及 Linux 內核特
 有的東西。
 
@@ -855,7 +850,7 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 每份報告都應提及的事項
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-詳細描述你的問題是如何發生在你安裝的新純淨內核上的。試著包含你之前寫的和優
+詳細描述你的問題是如何發生在你安裝的新純淨內核上的。試着包含你之前寫的和優
 化過的分步說明，概述你和其他人如何重現這個問題；在極少數無法重現的情況下，
 儘量描述你做了什麼來觸發它。
 
@@ -864,19 +859,19 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 
  * ``cat /proc/version`` 的輸出，其中包含 Linux 內核版本號和構建時的編譯器。
 
- * 機器正在運行的 Linux 發行版（ ``hostnamectl | grep 「Operating System「`` ）
+ * 機器正在運行的 Linux 發行版（ ``hostnamectl | grep “Operating System“`` ）
 
- * CPU 和作業系統的架構（ ``uname -mi`` ）
+ * CPU 和操作系統的架構（ ``uname -mi`` ）
 
- * 如果您正在處理回歸，並進行了二分，請提及導致回歸的變更的主題和提交ID。
+ * 如果您正在處理迴歸，並進行了二分，請提及導致迴歸的變更的主題和提交ID。
 
-許多情況下，讓讀你報告的人多了解兩件事也是明智之舉：
+許多情況下，讓讀你報告的人多瞭解兩件事也是明智之舉：
 
- * 用於構建 Linux 內核的配置（「.config」文件）
+ * 用於構建 Linux 內核的配置（“.config”文件）
 
- * 內核的信息，你從 ``dmesg`` 得到的信息寫到一個文件里。確保它以像「Linux
+ * 內核的信息，你從 ``dmesg`` 得到的信息寫到一個文件裏。確保它以像“Linux
    version 5.8-1 (foobar@example.com) (gcc (GCC) 10.2.1, GNU ld version
-   2.34) #1 SMP Mon Aug 3 14:54:37 UTC 2020」這樣的行開始，如果沒有，那麼第
+   2.34) #1 SMP Mon Aug 3 14:54:37 UTC 2020”這樣的行開始，如果沒有，那麼第
    一次啓動階段的重要信息已經被丟棄了。在這種情況下，可以考慮使用
    ``journalctl -b 0 -k`` ；或者你也可以重啓，重現這個問題，然後調用
    ``dmesg`` 。
@@ -887,39 +882,39 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 
  * 將文件上傳到某個公開的地方（你的網站，公共文件粘貼服務，在
    `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ 上創建的工單……），
-   並在你的報告中放上連結。理想情況下請使用允許這些文件保存很多年的地方，因
+   並在你的報告中放上鍊接。理想情況下請使用允許這些文件保存很多年的地方，因
    爲它們可能在很多年後對別人有用；例如 5 年或 10 年後，一個開發者正在修改
    一些代碼，而這些代碼正是爲了修復你的問題。
 
- * 把文件放在一邊，然後說明你會在他人回復時再單獨發送。只要記得報告發出去後，
+ * 把文件放在一邊，然後說明你會在他人回覆時再單獨發送。只要記得報告發出去後，
    真正做到這一點就可以了。;-)
 
 提供這些東西可能是明智的
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-根據問題的不同，你可能需要提供更多的背景數據。這裡有一些關於提供什麼比較好
+根據問題的不同，你可能需要提供更多的背景數據。這裏有一些關於提供什麼比較好
 的建議：
 
- * 如果你處理的是內核的「warning」、「OOPS」或「panic」，請包含它。如果你不能複製
-   粘貼它，試著用netconsole網絡終端遠程跟蹤或者至少拍一張屏幕的照片。
+ * 如果你處理的是內核的“warning”、“OOPS”或“panic”，請包含它。如果你不能複製
+   粘貼它，試着用netconsole網絡終端遠程跟蹤或者至少拍一張屏幕的照片。
 
- * 如果問題可能與你的電腦硬體有關，請說明你使用的是什麼系統。例如，如果你的
-   顯卡有問題，請提及它的製造商，顯卡的型號，以及使用的晶片。如果是筆記本電
-   腦，請提及它的型號名稱，但儘量確保意義明確。例如「戴爾 XPS 13」就不很明確，
+ * 如果問題可能與你的電腦硬件有關，請說明你使用的是什麼系統。例如，如果你的
+   顯卡有問題，請提及它的製造商，顯卡的型號，以及使用的芯片。如果是筆記本電
+   腦，請提及它的型號名稱，但儘量確保意義明確。例如“戴爾 XPS 13”就不很明確，
    因爲它可能是 2012 年的那款，那款除了看起來和現在銷售的沒有什麼不同之外，
    兩者沒有任何共同之處。因此，在這種情況下，要加上準確的型號，例如 2019
-   年內推出的 XPS 13 型號爲「9380」或「7390」。像「聯想 Thinkpad T590」這樣的名字
+   年內推出的 XPS 13 型號爲“9380”或“7390”。像“聯想 Thinkpad T590”這樣的名字
    也有些含糊不清：這款筆記本有帶獨立顯卡和不帶的子型號，所以要儘量找到準確
    的型號名稱或註明主要部件。
 
- * 說明正在使用的相關軟體。如果你在加載模塊時遇到了問題，你要說明正在使用的
+ * 說明正在使用的相關軟件。如果你在加載模塊時遇到了問題，你要說明正在使用的
    kmod、systemd 和 udev 的版本。如果其中一個 DRM 驅動出現問題，你要說明
    libdrm 和 Mesa 的版本；還要說明你的 Wayland 合成器或 X-Server 及其驅動。
    如果你有文件系統問題，請註明相應的文件系統實用程序的版本（e2fsprogs,
    btrfs-progs, xfsprogs……）。
 
  * 從內核中收集可能有用的額外信息。例如， ``lspci -nn`` 的輸出可以幫助別人
-   識別你使用的硬體。如果你的硬體有問題，你甚至可以給出 ``sudo lspci -vvv``
+   識別你使用的硬件。如果你的硬件有問題，你甚至可以給出 ``sudo lspci -vvv``
    的結果，因爲它提供了組件是如何配置的信息。對於一些問題，可能最好包含
    ``/proc/cpuinfo`` ， ``/proc/ioports`` ， ``/proc/iomem`` ，
    ``/proc/modules`` 或 ``/proc/scsi/scsi`` 等文件的內容。一些子系統還提
@@ -936,7 +931,7 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 ~~~~~~~~~~~~~~~~~~~~~~
 
 現在你已經準備好了報告的詳細部分，讓我們進入最重要的部分：開頭幾句。現在到
-報告的最前面，在你剛才寫的部分之前加上類似「The detailed description:」（詳細
+報告的最前面，在你剛纔寫的部分之前加上類似“The detailed description:”（詳細
 描述）這樣的內容，並在最前面插入兩個新行。現在寫一個正常長度的段落，大致概
 述這個問題。去掉所有枯燥的細節，把重點放在讀者需要知道的關鍵部分，以讓人了
 解這是怎麼回事；如果你認爲這個缺陷影響了很多用戶，就提一下這點來吸引大家關
@@ -946,10 +941,10 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 要更加抽象，爲報告寫一個更短的主題/標題。
 
 現在你已經寫好了這部分，請花點時間來優化它，因爲它是你的報告中最重要的部分：
-很多人會先讀這部分，然後才會決定是否值得花時間閱讀其他部分。
+很多人會先讀這部分，然後纔會決定是否值得花時間閱讀其他部分。
 
 現在就像 :ref:`MAINTAINERS <maintainers>` 維護者文件告訴你的那樣發送或提交
-報告，除非它是前面概述的那些「高優先級問題」之一：在這種情況下，請先閱讀下一
+報告，除非它是前面概述的那些“高優先級問題”之一：在這種情況下，請先閱讀下一
 小節，然後再發送報告。
 
 高優先級問題的特殊處理
@@ -960,11 +955,19 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 **非常嚴重的缺陷** ：確保在主題或工單標題以及第一段中明顯標出 severeness
 （非常嚴重的）。
 
-**回歸** ：如果問題是一個回歸，請在郵件的主題或缺陷跟蹤器的標題中添加
-[REGRESSION]。如果您沒有進行二分，請至少註明您測試的最新主線版本（比如 5.7）
-和出現問題的最新版本（比如 5.8）。如果您成功地進行了二分，請註明導致回歸
-的提交ID和主題。也請添加該變更的作者到你的報告中；如果您需要將您的缺陷提交
-到缺陷跟蹤器中，請將報告以私人郵件的形式轉發給他，並註明報告提交地點。
+**迴歸** ：報告的主題應以“[REGRESSION]”開頭。
+
+如果您成功用二分法定位了問題，請使用引入迴歸之更改的標題作爲主題的第二部分。
+請在報告中寫明“罪魁禍首”的提交ID。如果未能成功二分，請在報告中講明最後一個
+正常工作的版本（例如5.7）和最先發生問題的版本（例如5.8-rc1）。
+
+通過郵件發送報告時，請抄送Linux迴歸郵件列表（regressions@lists.linux.dev）。
+如果報告需要提交到某個web追蹤器，請繼續提交；並在提交後，通過郵件將報告轉發
+至迴歸列表；抄送相關子系統的維護人員和郵件列表。請確保報告是內聯轉發的，不要
+把它作爲附件。另外請在頂部添加一個簡短的說明，在那裏寫上工單的網址。
+
+在郵寄或轉發報告時，如果成功二分，需要將“罪魁禍首”的作者添加到收件人中；同時
+抄送signed-off-by鏈中的每個人，您可以在提交消息的末尾找到。
 
 **安全問題** ：對於這種問題，你將必須評估：如果細節被公開披露，是否會對其他
 用戶產生短期風險。如果不會，只需按照所述繼續報告問題。如果有此風險，你需要
@@ -972,47 +975,47 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 
  * 如果 MAINTAINERS 文件指示您通過郵件報告問題，請不要抄送任何公共郵件列表。
 
- * 如果你應該在缺陷跟蹤器中提交問題，請確保將工單標記爲「私有」或「安全問題」。
+ * 如果你應該在缺陷跟蹤器中提交問題，請確保將工單標記爲“私有”或“安全問題”。
    如果缺陷跟蹤器沒有提供保持報告私密性的方法，那就別想了，把你的報告以私人
    郵件的形式發送給維護者吧。
 
-在這兩種情況下，都一定要將報告發到 MAINTAINERS 文件中「安全聯絡」部分列出的
+在這兩種情況下，都一定要將報告發到 MAINTAINERS 文件中“安全聯絡”部分列出的
 地址。理想的情況是在發送報告的時候直接抄送他們。如果您在缺陷跟蹤器中提交了
-報告，請將報告的文本轉發到這些地址；但請在報告的頂部加上注釋，表明您提交了
-報告，並附上工單連結。
+報告，請將報告的文本轉發到這些地址；但請在報告的頂部加上註釋，表明您提交了
+報告，並附上工單鏈接。
 
-更多信息請參見「Documentation/translations/zh_TW/admin-guide/security-bugs.rst」。
+更多信息請參見 Documentation/translations/zh_TW/admin-guide/security-bugs.rst 。
 
 
-發布報告後的責任
+發佈報告後的責任
 ------------------
 
     *等待別人的反應，繼續推進事情，直到你能夠接受這樣或那樣的結果。因此，請
     公開和及時地回應任何詢問。測試提出的修復。積極地測試：至少重新測試每個
     新主線版本的首個候選版本（RC），並報告你的結果。如果出現拖延，就友好地
-    提醒一下。如果你沒有得到任何幫助或者未能滿意，請試著自己幫助自己。*
+    提醒一下。如果你沒有得到任何幫助或者未能滿意，請試着自己幫助自己。*
 
 如果你的報告非常優秀，而且你真的很幸運，那麼某個開發者可能會立即發現導致問
 題的原因；然後他們可能會寫一個補丁來修復、測試它，並直接發送給主線集成，同
-時標記它以便以後回溯到需要它的穩定版和長期支持內核。那麼你需要做的就是回復
-一句「Thank you very much」（非常感謝），然後在發布後換上修復好的版本。
+時標記它以便以後回溯到需要它的穩定版和長期支持內核。那麼你需要做的就是回覆
+一句“Thank you very much”（非常感謝），然後在發佈後換上修復好的版本。
 
-但這種理想狀況很少發生。這就是爲什麼你把報告拿出來之後工作才開始。你要做的
-事情要視情況而定，但通常會是下面列出的事情。但在深入研究細節之前，這裡有幾
+但這種理想狀況很少發生。這就是爲什麼你把報告拿出來之後工作纔開始。你要做的
+事情要視情況而定，但通常會是下面列出的事情。但在深入研究細節之前，這裏有幾
 件重要的事情，你需要記住這部分的過程。
 
 
 關於進一步互動的一般建議
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-**總是公開回復** ：當你在缺陷跟蹤器中提交問題時，一定要在那裡回復，不要私下
-聯繫任何開發者。對於郵件報告，在回復您收到的任何郵件時，總是使用「全部回復」
+**總是公開回復** ：當你在缺陷跟蹤器中提交問題時，一定要在那裏回覆，不要私下
+聯繫任何開發者。對於郵件報告，在回覆您收到的任何郵件時，總是使用“全部回覆”
 功能。這包括帶有任何你可能想要添加到你的報告中的額外數據的郵件：進入郵件應
-用程序「已發送」文件夾，並在郵件上使用「全部回復」來回復報告。這種方法可以確保
-公共郵件列表和其他所有參與者都能及時了解情況；它還能保持郵件線程的完整性，
+用程序“已發送”文件夾，並在郵件上使用“全部回覆”來回復報告。這種方法可以確保
+公共郵件列表和其他所有參與者都能及時瞭解情況；它還能保持郵件線程的完整性，
 這對於郵件列表將所有相關郵件歸爲一類是非常重要的。
 
-只有兩種情況不適合在缺陷跟蹤器或「全部回復」中發表評論：
+只有兩種情況不適合在缺陷跟蹤器或“全部回覆”中發表評論：
 
  * 有人讓你私下發東西。
 
@@ -1022,32 +1025,32 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 
 **在請求解釋或幫助之前先研究一下** ：在這部分過程中，有人可能會告訴你用尚未
 掌握的技能做一些事情。例如你可能會被要求使用一些你從未聽說過的測試工具；或
-者你可能會被要求在 Linux 內核原始碼上應用一個補丁來測試它是否有幫助。在某些
-情況下，發個回復詢問如何做就可以了。但在走這條路之前，儘量通過在網際網路上搜
+者你可能會被要求在 Linux 內核源代碼上應用一個補丁來測試它是否有幫助。在某些
+情況下，發個回覆詢問如何做就可以了。但在走這條路之前，儘量通過在互聯網上搜
 索自行找到答案；或者考慮在其他地方詢問建議。比如詢問朋友，或者到你平時常去
 的聊天室或論壇發帖諮詢。
 
 **要有耐心** ：如果你真的很幸運，你可能會在幾個小時內收到對你的報告的答覆。
 但大多數情況下會花費更多的時間，因爲維護者分散在全球各地，因此可能在不同的
-時區——在那裡他們已經享受著遠離鍵盤的夜晚。
+時區——在那裏他們已經享受着遠離鍵盤的夜晚。
 
 一般來說，內核開發者需要一到五個工作日來回復報告。有時會花費更長的時間，因
 爲他們可能正忙於合併窗口、其他工作、參加開發者會議，或者只是在享受一個漫長
 的暑假。
 
-「高優先級的問題」（見上面的解釋）例外：維護者應該儘快解決這些問題；這就是爲
+“高優先級的問題”（見上面的解釋）例外：維護者應該儘快解決這些問題；這就是爲
 什麼你應該最多等待一個星期（如果是緊急的事情，則只需兩天），然後再發送友好
 的提醒。
 
-有時維護者可能沒有及時回復；有時候可能會出現分歧，例如一個問題是否符合回歸
+有時維護者可能沒有及時回覆；有時候可能會出現分歧，例如一個問題是否符合迴歸
 的條件。在這種情況下，在郵件列表上提出你的顧慮，並請求其他人公開或私下回復
 如何繼續推進。如果失敗了，可能應該讓更高級別的維護者介入。如果是 WiFi 驅動，
 那就是無線維護者；如果沒有更高級別的維護者，或者其他一切努力都失敗了，那
 這可能是一種罕見的、可以讓 Linus Torvalds 參與進來的情況。
 
-**主動測試** ：每當一個新的主線內核版本的第一個預發布版本（rc1）發布的時候，
+**主動測試** ：每當一個新的主線內核版本的第一個預發佈版本（rc1）發佈的時候，
 去檢查一下這個問題是否得到了解決，或者是否有什麼重要的變化。在工單中或在
-回復報告的郵件中提及結果（確保所有參與討論的人都被抄送）。這將表明你的承諾
+回覆報告的郵件中提及結果（確保所有參與討論的人都被抄送）。這將表明你的承諾
 和你願意幫忙。如果問題持續存在，它也會提醒開發者確保他們不會忘記它。其他一
 些不定期的重新測試（例如用rc3、rc5 和最終版本）也是一個好主意，但只有在相關
 的東西發生變化或者你正在寫什麼東西的時候才報告你的結果。
@@ -1057,10 +1060,10 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 查詢和測試請求
 ~~~~~~~~~~~~~~~
 
-如果你的報告得到了回復則需履行以下責任：
+如果你的報告得到了回覆則需履行以下責任：
 
 **檢查與你打交道的人** ：大多數情況下，會是維護者或特定代碼區域的開發人員對
-你的報告做出回應。但由於問題通常是公開報告的，所以回復的可能是任何人——包括
+你的報告做出回應。但由於問題通常是公開報告的，所以回覆的可能是任何人——包括
 那些想要幫忙的人，但最後可能會用他們的問題或請求引導你完全偏離軌道。這很少
 發生，但這是快速上網搜搜看你正在與誰互動是明智之舉的許多原因之一。通過這樣
 做，你也可以知道你的報告是否被正確的人聽到，因爲如果討論沒有導致滿意的問題
@@ -1086,63 +1089,63 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 報告到達時，維護者剛剛離開鍵盤一段時間，或者有更重要的事情要處理。在寫提醒
 信的時候，要善意地問一下，是否還需要你這邊提供什麼來讓事情推進下去。如果報
 告是通過郵件發出來的，那就在郵件的第一行回覆你的初始郵件（見上文），其中包
-括下方的原始報告的完整引用：這是少數幾種情況下，這樣的「TOFU」（Text Over,
+括下方的原始報告的完整引用：這是少數幾種情況下，這樣的“TOFU”（Text Over,
 Fullquote Under文字在上，完整引用在下）是正確的做法，因爲這樣所有的收件人都
 會以適當的順序立即讓細節到手頭上來。
 
-在提醒之後，再等三周的回覆。如果你仍然沒有得到適當的反饋，你首先應該重新考
+在提醒之後，再等三週的回覆。如果你仍然沒有得到適當的反饋，你首先應該重新考
 慮你的方法。你是否可能嘗試接觸了錯誤的人？是不是報告也許令人反感或者太混亂，
 以至於人們決定完全遠離它？排除這些因素的最好方法是：把報告給一兩個熟悉
 FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於如何繼續推進的建議。
-這可能意味著：準備一份更好的報告，讓這些人在你發出去之前對它進行審查。這樣
+這可能意味着：準備一份更好的報告，讓這些人在你發出去之前對它進行審查。這樣
 的方法完全可以；只需說明這是關於這個問題的第二份改進的報告，並附上第一份報
-告的連結。
+告的鏈接。
 
 如果報告是恰當的，你可以發送第二封提醒信；在其中詢問爲什麼報告沒有得到任何
-回復。第二封提醒郵件的好時機是在新 Linux 內核版本的首個預發布版本（'rc1'）
-發布後不久，因爲無論如何你都應該在那個時候重新測試並提供狀態更新（見上文）。
+回覆。第二封提醒郵件的好時機是在新 Linux 內核版本的首個預發佈版本（'rc1'）
+發佈後不久，因爲無論如何你都應該在那個時候重新測試並提供狀態更新（見上文）。
 
-如果第二次提醒的結果又在一周內沒有任何反應，可以嘗試聯繫上級維護者詢問意見：
+如果第二次提醒的結果又在一週內沒有任何反應，可以嘗試聯繫上級維護者詢問意見：
 即使再忙的維護者在這時候也至少應該發過某種確認。
 
 記住要做好失望的準備：理想狀況下維護者最好對每一個問題報告做出回應，但他們
-只有義務解決之前列出的「高優先級問題」。所以，如果你得到的回覆是「謝謝你的報告，
-我目前有更重要的問題要處理，在可預見的未來沒有時間去研究這個問題」，那請不
+只有義務解決之前列出的“高優先級問題”。所以，如果你得到的回覆是“謝謝你的報告，
+我目前有更重要的問題要處理，在可預見的未來沒有時間去研究這個問題”，那請不
 要太沮喪。
 
 也有可能在缺陷跟蹤器或列表中進行了一些討論之後，什麼都沒有發生，提醒也無助
 於激勵大家進行修復。這種情況可能是毀滅性的，但在 Linux 內核開發中確實會發生。
-這些和其他得不到幫助的原因在本文結尾處的「爲什麼有些問題在被報告後沒有得到
-任何回應或者仍然沒有修復」中進行了解釋。
+這些和其他得不到幫助的原因在本文結尾處的“爲什麼有些問題在被報告後沒有得到
+任何回應或者仍然沒有修復”中進行了解釋。
 
 如果你沒有得到任何幫助或問題最終沒有得到解決，不要沮喪：Linux 內核是 FLOSS，
-因此你仍然可以自己幫助自己。例如，你可以試著找到其他受影響的人，和他們一
+因此你仍然可以自己幫助自己。例如，你可以試着找到其他受影響的人，和他們一
 起合作來解決這個問題。這樣的團隊可以一起準備一份新的報告，提到團隊有多少人，
 爲什麼你們認爲這是應該得到解決的事情。也許你們還可以一起縮小確切原因或引
-入回歸的變化，這往往會使修復更容易。而且如果運氣好的話，團隊中可能會有懂點
-編程的人，也許能寫出一個修複方案。
+入迴歸的變化，這往往會使修復更容易。而且如果運氣好的話，團隊中可能會有懂點
+編程的人，也許能寫出一個修復方案。
 
 
 
-「報告穩定版和長期支持內核線的回歸」的參考
+“報告穩定版和長期支持內核線的迴歸”的參考
 ------------------------------------------
 
-本小節提供了在穩定版和長期支持內核線中面對回歸時需要執行的步驟的詳細信息。
+本小節提供了在穩定版和長期支持內核線中面對迴歸時需要執行的步驟的詳細信息。
 
 確保特定版本線仍然受支持
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
     *檢查內核開發人員是否仍然維護你關心的Linux內核版本線：去 kernel.org 的
-    首頁，確保此特定版本線的最新版沒有「[EOL]」標記。*
+    首頁，確保此特定版本線的最新版沒有“[EOL]”標記。*
 
 大多數內核版本線只支持三個月左右，因爲延長維護時間會帶來相當多的工作。因此，
 每年只會選擇一個版本來支持至少兩年（通常是六年）。這就是爲什麼你需要檢查
 內核開發者是否還支持你關心的版本線。
 
-注意，如果 `kernel.org <https://kernel.org/>`_ 在首頁上列出了兩個「穩定」版本，
+注意，如果 `kernel.org <https://kernel.org/>`_ 在首頁上列出了兩個“穩定”版本，
 你應該考慮切換到較新的版本，而忘掉較舊的版本：對它的支持可能很快就會結束。
-然後，它將被標記爲「生命周期結束」（EOL）。達到這個程度的版本線仍然會在
-`kernel.org <https://kernel.org/>`_ 首頁上被顯示一兩周，但不適合用於測試和
+然後，它將被標記爲“生命週期結束”（EOL）。達到這個程度的版本線仍然會在
+`kernel.org <https://kernel.org/>`_ 首頁上被顯示一兩週，但不適合用於測試和
 報告。
 
 搜索穩定版郵件列表
@@ -1158,57 +1161,63 @@ FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於
 用最新版本復現問題
 ~~~~~~~~~~~~~~~~~~~
 
-    *從特定的版本線安裝最新版本作爲純淨內核。確保這個內核沒有被汙染，並且仍
-    然存在問題，因爲問題可能已經在那裡被修復了。*
+    *從特定的版本線安裝最新版本作爲純淨內核。確保這個內核沒有被污染，並且仍
+    然存在問題，因爲問題可能已經在那裏被修復了。*
 
 在投入更多時間到這個過程中之前，你要檢查這個問題是否在你關注的版本線的最新
-版本中已經得到了修復。這個內核需要是純淨的，在問題發生之前不應該被汙染，正
+版本中已經得到了修復。這個內核需要是純淨的，在問題發生之前不應該被污染，正
 如上面已經在測試主線的過程中詳細介紹過的一樣。
 
-您是否是第一次注意到供應商內核的回歸？供應商的更改可能會發生變化。你需要重新
+您是否是第一次注意到供應商內核的迴歸？供應商的更改可能會發生變化。你需要重新
 檢查排除來這個問題。當您從5.10.4-vendor.42更新到5.10.5-vendor.43時，記錄損壞
 的信息。然後在測試了前一段中所述的最新5.10版本之後，檢查Linux 5.10.4的普通版本
-是否也可以正常工作。如果問題在那裡出現，那就不符合上游回歸的條件，您需要切換
+是否也可以正常工作。如果問題在那裏出現，那就不符合上游迴歸的條件，您需要切換
 回主逐步指南來報告問題。
 
-報告回歸
+報告迴歸
 ~~~~~~~~~~
 
-    *向Linux穩定版郵件列表發送一個簡短的問題報告(stable@vger.kernel.org)。
-    大致描述問題，並解釋如何復現。講清楚首個出現問題的版本和最後一個工作正常
-    的版本。然後等待進一步的指示。*
+    *向Linux穩定版郵件列表發送一個簡短的問題報告(stable@vger.kernel.org)並
+    抄送Linux迴歸郵件列表（regressions@lists.linux.dev）；如果你懷疑是由某
+    子系統引起的，請抄送其維護人員和子系統郵件列表。大致描述問題，並解釋如
+    何復現。講清楚首個出現問題的版本和最後一個工作正常的版本。然後等待進一
+    步的指示。*
 
-當報告在穩定版或長期支持內核線內發生的回歸（例如在從5.10.4更新到5.10.5時），
-一份簡短的報告足以快速報告問題。因此只需要粗略的描述。
+當報告在穩定版或長期支持內核線內發生的迴歸（例如在從5.10.4更新到5.10.5時），
+一份簡短的報告足以快速報告問題。因此只需向穩定版和迴歸郵件列表發送粗略的描述；
+不過如果你懷疑某子系統導致此問題的話，請一併抄送其維護人員和子系統郵件列表，
+這會加快進程。
 
-但是請注意，如果您能夠指明引入問題的確切版本，這將對開發人員有很大幫助。因此
-如果有時間的話，請嘗試使用普通內核找到該版本。讓我們假設發行版發布Linux內核
+請注意，如果您能夠指明引入問題的確切版本，這將對開發人員有很大幫助。因此
+如果有時間的話，請嘗試使用普通內核找到該版本。讓我們假設發行版發佈Linux內核
 5.10.5到5.10.8的更新時發生了故障。那麼按照上面的指示，去檢查該版本線中的最新
 內核，比如5.10.9。如果問題出現，請嘗試普通5.10.5，以確保供應商應用的補丁不會
 干擾。如果問題沒有出現，那麼嘗試5.10.7，然後直到5.10.8或5.10.6（取決於結果）
 找到第一個引入問題的版本。在報告中寫明這一點，並指出5.10.9仍然存在故障。
 
-前一段基本粗略地概述了「二分」方法。一旦報告出來，您可能會被要求做一個正確的
+前一段基本粗略地概述了“二分”方法。一旦報告出來，您可能會被要求做一個正確的
 報告，因爲它允許精確地定位導致問題的確切更改（然後很容易被恢復以快速修復問題）。
-因此如果時間允許，考慮立即進行適當的二分。有關如何詳細信息，請參閱「對回歸的
-特別關照」部分和文檔「Documentation/translations/zh_TW/admin-guide/bug-bisect.rst」。
+因此如果時間允許，考慮立即進行適當的二分。有關如何詳細信息，請參閱“對迴歸的
+特別關照”部分和文檔 Documentation/translations/zh_TW/admin-guide/bug-bisect.rst 。
+如果成功二分的話，請將“罪魁禍首”的作者添加到收件人中；同時抄送所有在
+signed-off-by鏈中的人，您可以在提交消息的末尾找到。
 
 
-「報告僅在舊內核版本線中發生的問題」的參考
-------------------------------------------
+“報告僅在舊內核版本線中發生的問題”的參考
+----------------------------------------
 
-本節詳細介紹了如果無法用主線內核重現問題，但希望在舊版本線（又稱穩定版內核和
+本節詳細介紹瞭如果無法用主線內核重現問題，但希望在舊版本線（又稱穩定版內核和
 長期支持內核）中修復問題時需要採取的步驟。
 
 有些修復太複雜
 ~~~~~~~~~~~~~~~
 
     *請做好準備，接下來的幾個步驟可能無法在舊版本中解決問題：修復可能太大或
-    太冒險，無法移植到那裡。*
+    太冒險，無法移植到那裏。*
 
 即使是微小的、看似明顯的代碼變化，有時也會帶來新的、完全意想不到的問題。穩
 定版和長期支持內核的維護者非常清楚這一點，因此他們只對這些內核進行符合
-「Documentation/translations/zh_TW/process/stable-kernel-rules.rst」中所列出的
+Documentation/translations/zh_TW/process/stable-kernel-rules.rst 中所列出的
 規則的修改。
 
 複雜或有風險的修改不符合條件，因此只能應用於主線。其他的修復很容易被回溯到
@@ -1220,7 +1229,7 @@ FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於
 通用準備
 ~~~~~~~~~~
 
-    *執行上面「報告僅在舊內核版本線中發生的問題」一節中的前三個步驟。*
+    *執行上面“報告僅在舊內核版本線中發生的問題”一節中的前三個步驟。*
 
 您需要執行本指南另一節中已經描述的幾個步驟。這些步驟將讓您：
 
@@ -1242,21 +1251,21 @@ FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於
 在許多情況下，你所處理的問題會發生在主線上，但已在主線上得到了解決。修正它
 的提交也需要被回溯才能解決這個問題。這就是爲什麼你要搜索它或任何相關討論。
 
- * 首先嘗試在存放 Linux 內核原始碼的 Git 倉庫中找到修復。你可以通過
+ * 首先嚐試在存放 Linux 內核源代碼的 Git 倉庫中找到修復。你可以通過
    `kernel.org 上的網頁
    <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
    或 `GitHub 上的鏡像 <https://github.com/torvalds/linux>`_ 來實現；如果你
    有一個本地克隆，你也可以在命令行用 ``git log --grep=<pattern>`` 來搜索。
 
-   如果你找到了修復，請查看提交消息的尾部是否包含了類似這樣的「穩定版標籤」：
+   如果你找到了修復，請查看提交消息的尾部是否包含了類似這樣的“穩定版標籤”：
 
           Cc: <stable@vger.kernel.org> # 5.4+
 
    像上面這行，開發者標記了安全修復可以回傳到 5.4 及以後的版本。大多數情況
-   下，它會在兩周內被應用到那裡，但有時需要更長的時間。
+   下，它會在兩週內被應用到那裏，但有時需要更長的時間。
 
  * 如果提交沒有告訴你任何東西，或者你找不到修復，請再找找關於這個問題的討論。
-   用你最喜歡的搜尋引擎搜索網絡，以及 `Linux kernel developers mailing
+   用你最喜歡的搜索引擎搜索網絡，以及 `Linux kernel developers mailing
    list 內核開發者郵件列表 <https://lore.kernel.org/lkml/>`_ 的檔案。也可以
    閱讀上面的 `定位導致問題的內核區域` 一節，然後按照說明找到導致問題的子系
    統：它的缺陷跟蹤器或郵件列表存檔中可能有你要找的答案。
@@ -1286,41 +1295,41 @@ FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於
 爲什麼有些問題在報告後沒有任何回應或仍未解決？
 ===============================================
 
-當向 Linux 開發者報告問題時，要注意只有「高優先級的問題」（回歸、安全問題、嚴
+當向 Linux 開發者報告問題時，要注意只有“高優先級的問題”（迴歸、安全問題、嚴
 重問題）才一定會得到解決。如果維護者或其他人都失敗了，Linus Torvalds 他自己
 會確保這一點。他們和其他內核開發者也會解決很多其他問題。但是要知道，有時他
 們也會不能或不願幫忙；有時甚至沒有人發報告給他們。
 
 最好的解釋就是那些內核開發者常常是在業餘時間爲 Linux 內核做出貢獻。內核中的
-不少驅動程序都是由這樣的程式設計師編寫的，往往只是因爲他們想讓自己的硬體可以在
-自己喜歡的作業系統上使用。
+不少驅動程序都是由這樣的程序員編寫的，往往只是因爲他們想讓自己的硬件可以在
+自己喜歡的操作系統上使用。
 
-這些程式設計師大多數時候會很樂意修復別人報告的問題。但是沒有人可以強迫他們這樣
+這些程序員大多數時候會很樂意修復別人報告的問題。但是沒有人可以強迫他們這樣
 做，因爲他們是自願貢獻的。
 
 還有一些情況下，這些開發者真的很想解決一個問題，但卻不能解決：有時他們缺乏
-硬體編程文檔來解決問題。這種情況往往由於公開的文檔太簡陋，或者驅動程序是通
+硬件編程文檔來解決問題。這種情況往往由於公開的文檔太簡陋，或者驅動程序是通
 過逆向工程編寫的。
 
-業餘開發者遲早也會不再關心某驅動。也許他們的測試硬體壞了，被更高級的玩意取
-代了，或者是太老了以至於只能在計算機博物館裡找到。有時開發者根本就不關心他
+業餘開發者遲早也會不再關心某驅動。也許他們的測試硬件壞了，被更高級的玩意取
+代了，或者是太老了以至於只能在計算機博物館裏找到。有時開發者根本就不關心他
 們的代碼和 Linux 了，因爲在他們的生活中一些不同的東西變得更重要了。在某些情
 況下，沒有人願意接手維護者的工作——也沒有人可以被強迫，因爲對 Linux 內核的貢
 獻是自願的。然而被遺棄的驅動程序仍然存在於內核中：它們對人們仍然有用，刪除
-它們可能導致回歸。
+它們可能導致迴歸。
 
 對於那些爲 Linux 內核工作而獲得報酬的開發者來說，情況並沒有什麼不同。這些人
 現在貢獻了大部分的變更。但是他們的僱主遲早也會停止關注他們的代碼或者讓程序
-員專注於其他事情。例如，硬體廠商主要通過銷售新硬體來賺錢；因此，他們中的不
+員專注於其他事情。例如，硬件廠商主要通過銷售新硬件來賺錢；因此，他們中的不
 少人並沒有投入太多時間和精力來維護他們多年前就停止銷售的東西的 Linux 內核驅
 動。企業級 Linux 發行商往往持續維護的時間比較長，但在新版本中往往會把對老舊
-和稀有硬體的支持放在一邊，以限制範圍。一旦公司拋棄了一些代碼，往往由業餘貢
+和稀有硬件的支持放在一邊，以限制範圍。一旦公司拋棄了一些代碼，往往由業餘貢
 獻者接手，但正如上面提到的：他們遲早也會放下代碼。
 
 優先級是一些問題沒有被修復的另一個原因，因爲維護者相當多的時候是被迫設置這
 些優先級的，因爲在 Linux 上工作的時間是有限的。對於業餘時間或者僱主給予他們
 的開發人員用於上游內核維護工作的時間也是如此。有時維護人員也會被報告淹沒，
-即使一個驅動程序幾乎完美地工作。爲了不被完全纏住，程式設計師可能別無選擇，只能
+即使一個驅動程序幾乎完美地工作。爲了不被完全纏住，程序員可能別無選擇，只能
 對問題報告進行優先級排序而拒絕其中的一些報告。
 
 不過這些都不用太過擔心，很多驅動都有積極的維護者，他們對儘可能多的解決問題
@@ -1330,8 +1339,32 @@ FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於
 結束語
 =======
 
-與其他免費/自由&開源軟體（Free/Libre & Open Source Software，FLOSS）相比，
-向 Linux 內核開發者報告問題是很難的：這個文檔的長度和複雜性以及字裡行間的內
+與其他免費/自由&開源軟件（Free/Libre & Open Source Software，FLOSS）相比，
+向 Linux 內核開發者報告問題是很難的：這個文檔的長度和複雜性以及字裏行間的內
 涵都說明了這一點。但目前就是這樣了。這篇文字的主要作者希望通過記錄現狀來爲
 以後改善這種狀況打下一些基礎。
 
+
+..
+   end-of-content
+..
+   This English version of this document is maintained by Thorsten Leemhuis
+   <linux@leemhuis.info>. If you spot a typo or small mistake, feel free to
+   let him know directly and he'll fix it. For translation problems, please
+   contact with translators. You are free to do the same in a mostly informal
+   way if you want to contribute changes to the text, but for copyright
+   reasons please CC linux-doc@vger.kernel.org and "sign-off" your
+   contribution as Documentation/process/submitting-patches.rst outlines in
+   the section "Sign your work - the Developer's Certificate of Origin".
+..
+   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
+   of the file. If you want to distribute this text under CC-BY-4.0 only,
+   please use "The Linux kernel developers" for author attribution and link
+   this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
+
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst b/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
new file mode 100644
index 000000000000..38149b0f6493
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
@@ -0,0 +1,371 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+.. 【重分發信息參見本文件結尾】
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/reporting-regressions.rst
+
+:譯者:
+
+ 吳想成 Wu XiangCheng <bobwxc@email.cn>
+
+
+============
+報告迴歸問題
+============
+
+“*我們拒絕出現迴歸*”是Linux內核開發的首要規則；Linux的發起者和領軍開發者Linus
+Torvalds立下了此規則並確保它被落實。
+
+本文檔描述了這條規則對用戶的意義，以及Linux內核開發模型如何確保解決所有被報告
+的迴歸；關於內核開發者如何處理的方面參見 Documentation/process/handling-regressions.rst 。
+
+
+本文重點（亦即“太長不看”）
+==========================
+
+#. 如果某程序在原先的Linux內核上運行良好，但在較新版本上效果更差、或者根本不
+   能用，那麼你就碰見迴歸問題了。注意，新內核需要使用類似配置編譯；更多相關細
+   節參見下方。
+
+#. 按照 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst 中
+   所說的報告你的問題，該文檔已經包含了所有關於迴歸的重要方面，爲了方便起見也
+   複製到了下面。兩個重點：在報告主題中使用“[REGRESSION]”開頭並抄送或轉發到
+   `迴歸郵件列表 <https://lore.kernel.org/regressions/>`_
+   （regressions@lists.linux.dev）。
+
+#. 可選但是建議：在發送或轉發報告時，指明該回歸發生的起點，以便Linux內核迴歸
+   追蹤機器人“regzbot”可以追蹤此問題::
+
+       #regzbot introduced v5.13..v5.14-rc1
+
+
+與用戶相關的所有Linux內核迴歸細節
+=================================
+
+
+基本重點
+--------
+
+
+什麼是“迴歸”以及什麼是“無迴歸規則”？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+如果某程序/實例在原先的Linux內核上運行良好，但在較新版本上效果更差、或者根本
+不能用，那麼你就碰見迴歸問題了。“無迴歸規則”不允許出現這種情況。如果偶然發
+生了，導致問題的開發者應當迅速修復問題。
+
+也就是說，若Linux 5.13中的WiFi驅動程序運行良好，但是在5.14版本上卻不能用、速
+度明顯變慢或出現錯誤，那就出現了迴歸。如果某正常工作的應用程序突然在新內核上
+出現不穩定，這也是迴歸；這些問題可能是由於procfs、sysfs或Linux提供給用戶空間
+軟件的許多其他接口之一的變化。但請記住，前述例子中的5.14需要使用類似於5.13的
+配置構建。這可以用 ``make olddefconfig`` 實現，詳細解釋見下。
+
+注意本節第一句話中的“實例”：即使開發者需要遵循“無迴歸”規則，但仍可自由地改
+變內核的任何方面，甚至是導出到用戶空間的API或ABI，只要別破壞現有的應用程序或
+用例。
+
+還需注意，“無迴歸”規則只限制內核提供給用戶空間的接口。它不適用於內核內部接
+口，比如一些外部開發的驅動程序用來插入鉤子到內核的模塊API。
+
+如何報告迴歸？
+~~~~~~~~~~~~~~
+
+只需按照 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst 中
+所說的報告你的問題，該文檔已經包含了要點。下面幾點概述了一下只在迴歸中重要的
+方面：
+
+ * 在檢查可加入討論的現有報告時，別忘了搜索 `Linux迴歸郵件列表
+   <https://lore.kernel.org/regressions/>`_ 和 `regzbot網頁界面
+   <https://linux-regtracking.leemhuis.info/regzbot/>`_ 。
+
+ * 在報告主題的開頭加上“[REGRESSION]”。
+
+ * 在你的報告中明確最後一個正常工作的內核版本和首個出問題的版本。如若可能，
+   用二分法嘗試找出導致迴歸的變更，更多細節見下。
+
+ * 記得把報告發到Linux迴歸郵件列表（regressions@lists.linux.dev）。
+
+   * 如果通過郵件報告迴歸，請抄送回歸列表。
+
+   * 如果你使用某些缺陷追蹤器報告迴歸，請通過郵件轉發已提交的報告到迴歸列表，
+     並抄送維護者以及出問題的相關子系統的郵件列表。
+
+   如果是穩定版或長期支持版系列（如v5.15.3…v5.15.5）的迴歸，請記得抄送
+   `Linux穩定版郵件列表 <https://lore.kernel.org/stable/>`_ （stable@vger.kernel.org）。
+
+  如果你成功地執行了二分，請抄送肇事提交的信息中所有簽了“Signed-off-by:”的人。
+
+在抄送你的報告到列表時，也請記得通知前述的Linux內核迴歸追蹤機器人。只需在郵件
+中包含如下片段::
+
+       #regzbot introduced: v5.13..v5.14-rc1
+
+Regzbot會就將你的郵件視爲在某個特定版本區間的迴歸報告。上例中即linux v5.13仍
+然正常，而Linux 5.14-rc1是首個您遇到問題的版本。如果你執行了二分以查找導致回
+歸的提交，請使用指定肇事提交的id代替::
+
+       #regzbot introduced: 1f2e3d4c5d
+
+添加這樣的“regzbot命令”對你是有好處的，它會確保報告不會被忽略。如果你省略了
+它，Linux內核的迴歸跟蹤者會把你的迴歸告訴regzbot，只要你發送了一個副本到迴歸
+郵件列表。但是迴歸跟蹤者只有一個人，有時不得不休息或甚至偶爾享受可以遠離電腦
+的時光（聽起來很瘋狂）。因此，依賴此人手動將回歸添加到 `已追蹤且尚未解決的
+Linux內核迴歸列表 <https://linux-regtracking.leemhuis.info/regzbot/>`_ 和
+regzbot發送的每週迴歸報告，可能會出現延遲。 這樣的延誤會導致Linus Torvalds
+在決定“繼續開發還是發佈新版本？”時忽略嚴重的迴歸。
+
+真的修復了所有的迴歸嗎？
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+幾乎所有都是，只要引起問題的變更（肇事提交）被可靠定位。也有些迴歸可以不用這
+樣，但通常是必須的。
+
+誰需要找出迴歸的根本原因？
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+受影響代碼區域的開發者應該自行嘗試定位問題所在。但僅靠他們的努力往往是不可
+能做到的，很多問題只發生在開發者的無法接觸的其他特定外部環境中——例如特定的
+硬件平臺、固件、Linux發行版、系統的配置或應用程序。這就是爲什麼最終往往是報
+告者定位肇事提交；有時用戶甚至需要再運行額外測試以查明確切的根本原因。開發
+者應該提供建議和可能的幫助，以使普通用戶更容易完成該流程。
+
+如何找到罪魁禍首？
+~~~~~~~~~~~~~~~~~~
+
+如 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst （簡要）
+和 Documentation/translations/zh_TW/admin-guide/bug-bisect.rst （詳細）中所
+述，執行二分。聽起來工作量很大，但大部分情況下很快就能找到罪魁禍首。如果這很
+困難或可靠地重現問題很耗時，請考慮與其他受影響的用戶合作，一起縮小搜索範圍。
+
+當出現迴歸時我可以向誰尋求建議？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+發送郵件到迴歸郵件列表（regressions@lists.linux.dev）同時抄送Linux內核的迴歸
+跟蹤者（regressions@leemhuis.info）;如果問題需要保密處理，可以省略列表。
+
+
+關於迴歸的更多細節
+------------------
+
+
+“無迴歸規則”的目標是什麼？
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+用戶應該放心升級內核版本，而不必擔心有程序可能崩潰。這符合內核開發者的利益，
+可以使更新有吸引力：他們不希望用戶停留在停止維護或超過一年半的穩定/長期Linux
+版本系列上。這也符合所有人的利益，因爲 `那些系列可能含有已知的缺陷、安全問題
+或其他後續版本已經修復的問題
+<http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/>`_ 。
+此外，內核開發者希望使用戶測試最新的預發行版或常規發行版變得簡單而有吸引力。
+這同樣符合所有人的利益，如果新版本出來後很快就有相關報告，會使追蹤和修復問題
+更容易。
+
+實際中“無迴歸”規則真的可行嗎？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+這不是句玩笑話，請見Linux創建者和主要開發人員Linus Torvalds在郵件列表中的許
+多發言，其中一些在 Documentation/process/handling-regressions.rst 中被引用。
+
+此規則的例外情況極爲罕見；之前當開發者認爲某個特定的情況有必要援引例外時，
+基本都被證明錯了。
+
+誰來確保“無迴歸”被落實？
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+照看和支撐樹的子系統維護者應該關心這一點——例如，Linus Torvalds之於主線，
+Greg Kroah-Hartman等人之於各種穩定/長期系列。
+
+他們都得到了別人的幫助，以確保迴歸報告不會被遺漏。其中之一是Thorsten
+Leemhuis，他目前擔任Linux內核的“迴歸跟蹤者”；爲了做好這項工作，他使用了
+regzbot——Linux內核迴歸跟蹤機器人。所以這就是爲什麼要抄送或轉發你的報告到
+迴歸郵件列表來通知這些人，已經最好在你的郵件中包含“regzbot命令”來立即追蹤它。
+
+迴歸通常多久能修復？
+~~~~~~~~~~~~~~~~~~~~
+
+開發者應該儘快修復任何被報告的迴歸，以提供及時爲受影響的用戶提供解決方案，並
+防止更多用戶遇到問題；然而，開發人員需要花足夠的時間和注意力確保迴歸修復不會
+造成額外的損害。
+
+因此，答案取決於各種因素，如迴歸的影響、存在時長或出現於哪個Linux版本系列。
+但最終，大多數的迴歸應該在兩週內修復。
+
+當問題可以通過升級某些軟件解決時，是迴歸嗎？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+基本都是。如果開發人員告訴您其他情況，請諮詢上述迴歸跟蹤者。
+
+當新內核變慢或能耗增加，是迴歸嗎？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+是的，但有一些差別。在微型基準測試中變慢5%不太可能被視爲迴歸，除非它也會對
+廣泛基準測試的結果產生超過1%的影響。如果有疑問，請尋求建議。
+
+當更新Linux時外部內核模塊崩潰了，是迴歸嗎？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+不，因爲“無迴歸”規則僅限於Linux內核提供給用戶空間的接口和服務。因此，它不包括
+構建或運行外部開發的內核模塊，因爲它們在內核空間中運行與掛進內核使用的內部接
+口偶爾會變化。
+
+如何處理安全修復引起的迴歸？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+在極爲罕見的情況下，安全問題無法在不引起迴歸的情況下修復；這些修復都被放棄了，
+因爲它們終究會引起問題。幸運的是這種兩難境地基本都可以避免，受影響區域的主要
+開發者以及Linus Torvalds本人通常都會努力在不引入迴歸的情況下解決安全問題。
+
+如果你仍然面臨此種情況，請查看郵件列表檔案是否有人盡力避免過迴歸。如果沒有，
+請報告它；如有疑問，請如上所述尋求建議。
+
+當修復迴歸時不可避免會引入另一個，如何處理？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+很遺憾這種事確實會出現，但幸運的是並不經常出現；如果發生了，受影響代碼區的資
+深開發者應當調查該問題以找到避免迴歸的解決方法，至少避免它們的影響。如果你遇
+到這樣的情況，如上所述：檢查之前的討論是否有人已經盡了最大努力，如有疑問請尋
+求建議。
+
+小提示：如果人們在每個開發週期中定期給出主線預發佈（即v5.15-rc1或-rc3）以供
+測試，則可以避免這種情況。爲了更好地解釋，可以設想一個在Linux v5.14和v5.15-rc1
+之間集成的更改，該更改導致了迴歸，但同時是應用於5.15-rc1的其他改進的強依賴。
+如果有人在5.15發佈之前就發現並報告了這個問題，那麼所有更改都可以直接撤銷，從
+而解決迴歸問題。而就在幾天或幾周後，此解決方案變成了不可能，因爲一些軟件可能
+已經開始依賴於後續更改之一：撤銷所有更改將導致上述用戶軟件出現迴歸，這是不可
+接受的。
+
+若我所依賴的功能在數月前被移除了，是迴歸嗎？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+是的，但如前節所述，通常很難修復此類迴歸。因此需要逐案處理。這也是定期測試主
+線預發佈對所有人有好處的另一個原因。
+
+如果我似乎是唯一受影響的人，是否仍適用“無迴歸”規則？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+適用，但僅限於實際使用：Linux開發人員希望能夠自由地取消那些只能在閣樓和博物
+館中找到的硬件的支持。
+
+請注意，有時爲了取得進展，不得不出現迴歸——後者也是防止Linux停滯不前所必需
+的。因此如果迴歸所影響的用戶很少，那麼爲了他們和其他人更大的利益，還是讓事情
+過去吧。尤其是存在某種規避迴歸的簡單方法，例如更新一些軟件或者使用專門爲此目
+的創建的內核參數。
+
+迴歸規則是否也適用於staging樹中的代碼？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+不，參見 `適用於所有staging代碼配置選項的幫助文本
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/Kconfig>`_ ，
+其早已聲明::
+
+       請注意：這些驅動正在積極開發中，可能無法正常工作，並可能包含會在不久的
+       將來發生變化的用戶接口。
+
+雖然staging開發人員通常堅持“無迴歸”的原則，但有時爲了取得進展也會違背它。這就
+是爲什麼當staging樹的WiFi驅動被基本推倒重來時，有些用戶不得不處理迴歸（通常可
+以忽略）。
+
+爲什麼較新版本必須“使用相似配置編譯”？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+因爲Linux內核開發人員有時會集成已知的會導致迴歸的變更，但使它們成爲可選的，並
+在內核的默認配置下禁用它們。這一技巧允許進步，否則“無迴歸”規則將導致停滯。
+
+例如，試想一個新的可以阻止惡意軟件濫用某個內核的接口的安全特性，同時又需要滿足
+另一個很罕見的應用程序。上述的方法可使兩方都滿意：使用這些應用程序的人可以關閉
+新的安全功能，而其他不會遇到麻煩的人可以啓用它。
+
+如何創建與舊內核相似的配置？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+用一個已知良好的內核啓動機器，並用 ``make olddefconfig`` 配置新版的Linux。這
+會讓內核的構建腳本從正在運行的內核中摘錄配置文件（“.config”文件），作爲即將編
+譯的新版本的基礎配置；同時將所有新的配置選項設爲默認值，以禁用可能導致迴歸的
+新功能。
+
+如何報告在預編譯的普通內核中發現的迴歸？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+您需要確保新的內核是用與舊版相似的配置編譯（見上文），因爲那些構建它們的人可
+能啓用了一些已知的與新內核不兼容的特性。如有疑問，請向內核的提供者報告問題並
+尋求建議。
+
+
+用“regzbot”追蹤迴歸的更多信息
+-----------------------------
+
+什麼是迴歸追蹤？爲啥我需要關心它？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+像“無迴歸”這樣的規則需要有人來確保它們被遵守，否則會被有意/無意打破。歷史證
+明瞭這一點對於Linux內核開發也適用。這就是爲什麼Linux內核的迴歸跟蹤者Thorsten
+Leemhuis，，和另一些人盡力關注所有的迴歸直到他們解決。他們從未爲此獲得報酬，
+因此這項工作是在盡最大努力的基礎上完成的。
+
+爲什麼/如何使用機器人追蹤Linux內核迴歸？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+由於Linux內核開發過程的分佈式和鬆散結構，完全手動跟蹤迴歸已經被證明是相當困難
+的。因此Linux內核的迴歸跟蹤者開發了regzbot來促進這項工作，其長期目標是儘可能爲
+所有相關人員自動化迴歸跟蹤。
+
+Regzbot通過監視跟蹤的迴歸報告的回覆來工作。此外，它還查找用“Link:”標籤引用這
+些報告的補丁；對這些補丁的回覆也會被跟蹤。結合這些數據，可以很好地瞭解當前修
+復過程的狀態。
+
+如何查看regzbot當前追蹤的迴歸？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+參見 `regzbot在線 <https://linux-regtracking.leemhuis.info/regzbot/>`_ 。
+
+何種問題可以由regzbot追蹤？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+該機器人只爲了跟蹤迴歸，因此請不要讓regzbot涉及常規問題。但是對於Linux內核的
+迴歸跟蹤者來說，讓regzbot跟蹤嚴重問題也可以，如有關掛起、損壞數據或內部錯誤
+（Panic、Oops、BUG（）、warning…）的報告。
+
+如何修改被追蹤迴歸的相關信息？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+在直接或間接回復報告郵件時使用“regzbot命令”即可。最簡單的方法是：在“已發送”文
+件夾或郵件列表存檔中找到報告，然後使用郵件客戶端的“全部回覆”功能對其進行回覆。
+在該郵件中的獨立段落中可使用以下命令之一（即使用空行將這些命令中的一個或多個與
+其餘郵件文本分隔開）。
+
+ * 更新迴歸引入起點，例如在執行二分之後::
+
+       #regzbot introduced: 1f2e3d4c5d
+
+ * 設置或更新標題::
+
+       #regzbot title: foo
+
+ * 監視討論或bugzilla.kernel.org上有關討論或修復的工單::
+
+       #regzbot monitor: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+       #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=123456789
+
+ * 標記一個有更多相關細節的地方，例如有關但主題不同的郵件列表帖子或缺陷追蹤器中的工單::
+
+       #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=123456789
+
+ * 標記迴歸已失效::
+
+       #regzbot invalid: wasn't a regression, problem has always existed
+
+Regzbot還支持其他一些主要由開發人員或迴歸追蹤人員使用的命令。命令的更多細節請
+參考 `入門指南 <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md>`_
+和 `參考手冊 <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md>`_ 。
+
+..
+   正文結束
+..
+   如本文件開頭所述，本文以GPL-2.0+或CC-BY-4.0許可發行。如您想僅在CC-BY-4.0許
+   可下重分發本文，請用“Linux內核開發者”作爲作者，並用如下鏈接作爲來源：
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
+..
+   注意：本RST文件內容只有在來自Linux內核源代碼時是使用CC-BY-4.0許可的，因爲經
+   過處理的版本（如經內核的構建系統）可能包含來自使用更嚴格許可證的文件的內容。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
index 65c8dd24c96d..a2e196b3ad6a 100644
--- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -19,17 +19,17 @@ Linux內核開發人員非常重視安全性。因此我們想知道何時發現
 -----
 
 可以通過電子郵件<security@kernel.org>聯繫Linux內核安全團隊。這是一個安全人員
-的私有列表，他們將幫助驗證錯誤報告並開發和發布修復程序。如果您已經有了一個
+的私有列表，他們將幫助驗證錯誤報告並開發和發佈修復程序。如果您已經有了一個
 修復，請將其包含在您的報告中，這樣可以大大加快進程。安全團隊可能會從區域維護
-人員那裡獲得額外的幫助，以理解和修復安全漏洞。
+人員那裏獲得額外的幫助，以理解和修復安全漏洞。
 
 與任何缺陷一樣，提供的信息越多，診斷和修復就越容易。如果您不清楚哪些信息有用，
-請查看「Documentation/translations/zh_TW/admin-guide/reporting-issues.rst」中
+請查看“Documentation/translations/zh_TW/admin-guide/reporting-issues.rst”中
 概述的步驟。任何利用漏洞的攻擊代碼都非常有用，未經報告者同意不會對外發布，除
 非已經公開。
 
-請儘可能發送無附件的純文本電子郵件。如果所有的細節都藏在附件里，那麼就很難對
-一個複雜的問題進行上下文引用的討論。把它想像成一個
+請儘可能發送無附件的純文本電子郵件。如果所有的細節都藏在附件裏，那麼就很難對
+一個複雜的問題進行上下文引用的討論。把它想象成一個
 :doc:`常規的補丁提交 <../process/submitting-patches>` （即使你還沒有補丁）：
 描述問題和影響，列出復現步驟，然後給出一個建議的解決方案，所有這些都是純文本的。
 
@@ -38,15 +38,15 @@ Linux內核開發人員非常重視安全性。因此我們想知道何時發現
 
 安全列表不是公開渠道。爲此，請參見下面的協作。
 
-一旦開發出了健壯的補丁，發布過程就開始了。對公開的缺陷的修復會立即發布。
+一旦開發出了健壯的補丁，發佈過程就開始了。對公開的缺陷的修復會立即發佈。
 
-儘管我們傾向於在未公開缺陷的修復可用時即發布補丁，但應報告者或受影響方的請求，
-這可能會被推遲到發布過程開始後的7日內，如果根據缺陷的嚴重性需要更多的時間，
-則可額外延長到14天。推遲發布修復的唯一有效原因是爲了適應QA的邏輯和需要發布
+儘管我們傾向於在未公開缺陷的修復可用時即發佈補丁，但應報告者或受影響方的請求，
+這可能會被推遲到發佈過程開始後的7日內，如果根據缺陷的嚴重性需要更多的時間，
+則可額外延長到14天。推遲發佈修復的唯一有效原因是爲了適應QA的邏輯和需要發佈
 協調的大規模部署。
 
 雖然可能與受信任的個人共享受限信息以開發修復，但未經報告者許可，此類信息不會
-與修復程序一起發布或發布在任何其他披露渠道上。這包括但不限於原始錯誤報告和
+與修復程序一起發佈或發佈在任何其他披露渠道上。這包括但不限於原始錯誤報告和
 後續討論（如有）、漏洞、CVE信息或報告者的身份。
 
 換句話說，我們唯一感興趣的是修復缺陷。提交給安全列表的所有其他資料以及對報告
@@ -57,10 +57,10 @@ Linux內核開發人員非常重視安全性。因此我們想知道何時發現
 
 對敏感缺陷（例如那些可能導致權限提升的缺陷）的修復可能需要與私有郵件列表
 <linux-distros@vs.openwall.org>進行協調，以便分發供應商做好準備，在公開披露
-上游補丁時發布一個已修復的內核。發行版將需要一些時間來測試建議的補丁，通常
-會要求至少幾天的限制，而供應商更新發布更傾向於周二至周四。若合適，安全團隊
+上游補丁時發佈一個已修復的內核。發行版將需要一些時間來測試建議的補丁，通常
+會要求至少幾天的限制，而供應商更新發布更傾向於週二至週四。若合適，安全團隊
 可以協助這種協調，或者報告者可以從一開始就包括linux發行版。在這種情況下，請
-記住在電子郵件主題行前面加上「[vs]」，如linux發行版wiki中所述：
+記住在電子郵件主題行前面加上“[vs]”，如linux發行版wiki中所述：
 <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>。
 
 CVE分配
diff --git a/Documentation/translations/zh_TW/admin-guide/sysrq.rst b/Documentation/translations/zh_TW/admin-guide/sysrq.rst
new file mode 100644
index 000000000000..4a08db00a495
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/sysrq.rst
@@ -0,0 +1,281 @@
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/admin-guide/sysrq.rst
+
+:翻譯:
+
+ 黃軍華 Junhua Huang <huang.junhua@zte.com.cn>
+
+:校譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_admin-guide_sysrq:
+
+Linux 魔法系統請求鍵駭客
+========================
+
+針對 sysrq.c 的文檔說明
+
+什麼是魔法 SysRq 鍵？
+~~~~~~~~~~~~~~~~~~~~~
+
+它是一個你可以輸入的具有魔法般的組合鍵。
+無論內核在做什麼，內核都會響應 SysRq 鍵的輸入，除非內核完全卡死。
+
+如何使能魔法 SysRq 鍵？
+~~~~~~~~~~~~~~~~~~~~~~~
+
+在配置內核時，我們需要設置 'Magic SysRq key (CONFIG_MAGIC_SYSRQ)' 爲 'Y'。
+當運行一個編譯進 sysrq 功能的內核時，/proc/sys/kernel/sysrq 控制着被
+SysRq 鍵調用的功能許可。這個文件的默認值由 CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE
+配置符號設定，文件本身默認設置爲 1。以下是 /proc/sys/kernel/sysrq 中可能的
+值列表：
+
+   -  0 - 完全不使能 SysRq 鍵
+   -  1 - 使能 SysRq 鍵的全部功能
+   - >1 - 對於允許的 SysRq 鍵功能的比特掩碼（參見下面更詳細的功能描述）::
+
+          2 =   0x2 - 使能對控制檯日誌記錄級別的控制
+          4 =   0x4 - 使能對鍵盤的控制 (SAK, unraw)
+          8 =   0x8 - 使能對進程的調試導出等
+         16 =  0x10 - 使能同步命令
+         32 =  0x20 - 使能重新掛載只讀
+         64 =  0x40 - 使能對進程的信號操作 (term, kill, oom-kill)
+        128 =  0x80 - 允許重啓、斷電
+        256 = 0x100 - 允許讓所有實時任務變普通任務
+
+你可以通過如下命令把值設置到這個文件中::
+
+    echo "number" >/proc/sys/kernel/sysrq
+
+這裏被寫入的 number 可以是 10 進制數，或者是帶着 0x 前綴的 16 進制數。
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE 必須是以 16 進制數寫入。
+
+注意，``/proc/sys/kernel/sysrq`` 的值隻影響通過鍵盤觸發 SySRq 的調用，對於
+通過 ``/proc/sysrq-trigger`` 的任何操作調用都是允許的
+（通過具有系統權限的用戶）。
+
+如何使用魔法 SysRq 鍵？
+~~~~~~~~~~~~~~~~~~~~~~~
+
+在 x86 架構上
+	你可以按下鍵盤組合鍵 :kbd:`ALT-SysRq-<command key>`。
+
+	.. note::
+	   一些鍵盤可能沒有標識 'SySRq' 鍵。'SySRq' 鍵也被當做 'Print Screen'鍵。
+	   同時有些鍵盤無法處理同時按下這麼多鍵，因此你可以先按下鍵盤 :kbd:`Alt` 鍵，
+	   然後按下鍵盤 :kbd:`SysRq` 鍵，再釋放鍵盤 :kbd:`SysRq` 鍵，之後按下鍵盤上命令鍵
+	   :kbd:`<command key>`，最後釋放所有鍵。
+
+在 SPARC 架構上
+	你可以按下鍵盤組合鍵 :kbd:`ALT-STOP-<command key>` 。
+
+在串行控制檯（只針對 PC 類型的標準串口）
+        你可以發一個 ``BREAK`` ，然後在 5 秒內發送一個命令鍵，
+	發送 ``BREAK`` 兩次將被翻譯爲一個正常的 BREAK 操作。
+
+在 PowerPC 架構上
+	按下鍵盤組合鍵 :kbd:`ALT - Print Screen` （或者 :kbd:`F13`） - :kbd:`<命令鍵>` 。
+        :kbd:`Print Screen` （或者 :kbd:`F13`） - :kbd:`<命令鍵>` 或許也能實現。
+
+在其他架構上
+	如果你知道其他架構的組合鍵，請告訴我，我可以把它們添加到這部分。
+
+在所有架構上
+	寫一個字符到 /proc/sysrq-trigger 文件，例如::
+
+		echo t > /proc/sysrq-trigger
+
+這個命令鍵 :kbd:`<command key>` 是區分大小寫的。
+
+什麼是命令鍵？
+~~~~~~~~~~~~~~
+
+=========== ================================================================
+命令鍵	    功能
+=========== ================================================================
+``b``	    將立即重啓系統，不會同步或者卸載磁盤。
+
+``c``	    將執行系統 crash，如果配置了系統 crashdump，將執行 crashdump。
+
+``d``	    顯示所有持有的鎖。
+
+``e``	    發送 SIGTERM 信號給所有進程，除了 init 進程。
+
+``f``	    將調用 oom killer 殺掉一個過度佔用內存的進程，如果什麼任務都沒殺，
+            也不會 panic。
+
+``g``	    kgdb 使用（內核調試器）。
+
+``h``	    將會顯示幫助。（實際上除了這裏列舉的鍵，其他的都將顯示幫助，
+	    但是 ``h`` 容易記住）:-)
+
+``i``	    發送 SIGKILL 給所有進程，除了 init 進程。
+
+``j``	    強制性的 “解凍它” - 用於被 FIFREEZE ioctl 操作凍住的文件系統。
+
+``k``	    安全訪問祕鑰(SAK)殺掉在當前虛擬控制檯的所有程序，注意：參考
+            下面 SAK 節重要論述。
+
+``l``	    顯示所有活動 cpu 的棧回溯。
+
+``m``	    將導出當前內存信息到你的控制檯。
+
+``n``	    用於使所有實時任務變成普通任務。
+
+``o``	    將關閉系統（如果配置和支持的話）。
+
+``p``	    將導出當前寄存器和標誌位到控制檯。
+
+``q``	    將導出每個 cpu 上所有已裝備的高精度定時器（不是完整的
+            time_list 文件顯示的 timers）和所有時鐘事件設備的詳細信息。
+
+``r``	    關閉鍵盤的原始模式，設置爲轉換模式。
+
+``s``	    將嘗試同步所有的已掛載文件系統。
+
+``t``	    將導出當前所有任務列表和它們的信息到控制檯。
+
+``u``	    將嘗試重新掛載已掛載文件系統爲只讀。
+
+``v``	    強制恢復幀緩存控制檯。
+``v``	    觸發 ETM 緩存導出 [ARM 架構特有]
+
+``w``	    導出處於不可中斷狀態（阻塞）的任務。
+
+``x``	    在 ppc/powerpc 架構上用於 xmon 接口。
+            在 sparc64 架構上用於顯示全局的 PMU（性能監控單元）寄存器。
+            在 MIPS 架構上導出所有的 tlb 條目。
+
+``y``	    顯示全局 cpu 寄存器 [SPARC-64 架構特有]
+
+``z``	    導出 ftrace 緩存信息
+
+``0``-``9`` 設置控制檯日誌級別，該級別控制什麼樣的內核信息將被打印到你的
+	    控制檯。（比如 ``0`` ，將使得只有緊急信息，像 PANICs or OOPSes
+	    才能到你的控制檯。）
+=========== ================================================================
+
+好了，我能用他們做什麼呢？
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+嗯，當你的 X 服務端或者 svgalib 程序崩潰，unraw(r) 非原始模式命令鍵是非常
+方便的。
+
+sak(k)（安全訪問祕鑰）在你嘗試登陸的同時，又想確保當前控制檯沒有可以獲取你的
+密碼的特洛伊木馬程序運行時是有用的。它會殺掉給定控制檯的所有程序，這樣你
+就可以確認當前的登陸提示程序是實際來自 init 進程的程序，而不是某些特洛伊
+木馬程序。
+
+.. important::
+
+   在其實際的形式中，在兼容 C2 安全標準的系統上，它不是一個真正的 SAK，
+   它也不應該誤認爲此。
+
+似乎其他人發現其可以作爲（系統終端聯機鍵）當你想退出一個程序，
+同時不會讓你切換控制檯的方法。（比如，X 服務端或者 svgalib 程序）
+
+``reboot(b)`` 是個好方法，當你不能關閉機器時，它等同於按下"復位"按鈕。
+
+``crash(c)`` 可以用於手動觸發一個 crashdump，當系統卡住時。
+注意當 crashdump 機制不可用時，這個只是觸發一個內核 crash。
+
+``sync(s)`` 在拔掉可移動介質之前，或者在使用不提供優雅關機的
+救援 shell 之後很方便 -- 它將確保你的數據被安全地寫入磁盤。注意，在你看到
+屏幕上出現 "OK" 和 "Done" 之前，同步還沒有發生。
+
+``umount(u)`` 可以用來標記文件系統正常卸載，從正在運行的系統角度來看，它們將
+被重新掛載爲只讀。這個重新掛載動作直到你看到 "OK" 和 "Done" 信息出現在屏幕上
+纔算完成。
+
+日誌級別 ``0`` - ``9`` 用於當你的控制檯被大量的內核信息衝擊，你不想看見的時候。
+選擇 ``0`` 將禁止除了最緊急的內核信息外的所有的內核信息輸出到控制檯。（但是如果
+syslogd/klogd 進程是運行的，它們仍將被記錄。）
+
+``term(e)`` 和 ``kill(i)`` 用於當你有些有點失控的進程，你無法通過其他方式殺掉
+它們的時候，特別是它正在創建其他進程。
+
+"just thaw ``it(j)`` " 用於當你的系統由於一個 FIFREEZE ioctl 調用而產生的文件
+系統凍結，而導致的不響應時。
+
+有的時候 SysRq 鍵在使用它之後，看起來像是“卡住”了，我能做些什麼？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+這也會發生在我這，我發現輕敲鍵盤兩側的 shift、alt 和 control 鍵，然後再次敲擊
+一個無效的 SysRq 鍵序列可以解決問題。（比如，像鍵盤組合鍵 :kbd:`alt-sysrq-z` ）
+切換到另一個虛擬控制檯（鍵盤操作 :kbd:`ALT+Fn` ），然後再切回來應該也有幫助。
+
+我敲擊了 SysRq 鍵，但像是什麼都沒發生，發生了什麼錯誤？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+有一些鍵盤對於 SysRq 鍵設置了不同的鍵值，而不是提前定義的 99
+(查看在 ``include/uapi/linux/input-event-codes.h`` 文件中 ``KEY_SYSRQ`` 的定義)
+或者就根本沒有 SysRq 鍵。在這些場景下，執行 ``showkey -s`` 命令來找到一個合適
+的掃描碼序列，然後使用 ``setkeycodes <sequence> 99`` 命令映射這個序列值到通用
+的 SysRq 鍵編碼上（比如 ``setkeycodes e05b 99`` ）。最好將這個命令放在啓動腳本
+中。
+哦，順便說一句，你十秒鐘不輸入任何東西就將退出 “showkey”。
+
+我想添加一個 SysRq 鍵事件到一個模塊中，如何去做呢？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+爲了註冊一個基礎函數到這個表中，首先你必須包含 ``include/linux/sysrq.h`` 頭
+文件，這個頭文件定義了你所需要的所有東西。然後你必須創建一個 ``sysrq_key_op``
+結構體，然後初始化它，使用如下內容，A） 你將使用的這個鍵的處理函數， B） 一個
+help_msg 字符串，在 SysRq 鍵打印幫助信息時將打印出來，C） 一個 action_msg 字
+符串，就在你的處理函數調用前打印出來。你的處理函數必須符合在 'sysrq.h' 文件中
+的函數原型。
+
+在 ``sysrq_key_op`` 結構體被創建後，你可以調用內核函數
+``register_sysrq_key(int key, const struct sysrq_key_op *op_p);``，
+該函數在表中的 'key' 對應位置內容是空的情況下，將通過 ``op_p`` 指針註冊這個操作
+函數到表中 'key' 對應位置上。在模塊卸載的時候，你必須調用
+``unregister_sysrq_key(int key, const struct sysrq_key_op *op_p)`` 函數，該函數
+只有在當前該鍵對應的處理函數被註冊到了 'key' 對應位置時，纔會移除 'op_p' 指針
+對應的鍵值操作函數。這是爲了防止在你註冊之後，該位置被改寫的情況。
+
+魔法 SysRq 鍵系統的工作原理是將鍵對應操作函數註冊到鍵的操作查找表，
+該表定義在 'drivers/tty/sysrq.c' 文件中。
+該鍵表有許多在編譯時候就註冊進去的操作函數，但是是可變的。
+並且有兩個函數作爲操作該表的接口被導出::
+
+	register_sysrq_key 和 unregister_sysrq_key.
+
+當然，永遠不要在表中留下無效指針，即，當你的模塊存在調用 register_sysrq_key()
+函數，它一定要調用 unregister_sysrq_key() 來清除它使用過的 SysRq 鍵表條目。
+表中的空指針是安全的。:)
+
+如果對於某種原因，在 handle_sysrq 調用的處理函數中，你認爲有必要調用
+handle_sysrq 函數時，你必須意識到當前你處於一個鎖中（你同時也處於一箇中斷處理
+函數中，這意味着不能睡眠）。所以這時你必須使用 ``__handle_sysrq_nolock`` 替代。
+
+當我敲擊一個 SysRq 組合鍵時，只有標題打印出現在控制檯？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+SysRq 鍵的輸出和所有其他控制檯輸出一樣，受制於控制檯日誌級別控制。
+這意味着，如果內核以發行版內核中常見的 "quiet" 方式啓動，則輸出可能不會出現在實際
+的控制檯上，即使它會出現在 dmesg 緩存中，也可以通過 dmesg 命令和 ``/proc/kmsg``
+文件的消費訪問到。作爲一個特例，來自 sysrq 命令的標題行將被傳遞給所有控制檯
+使用者，就好像當前日誌級別是最大的一樣。如果只發出標題頭，則幾乎可以肯定內核日誌
+級別太低。如果你需要控制檯上的輸出，那麼你將需要臨時提高控制檯日誌級別，通過使用
+鍵盤組合鍵 :kbd:`alt-sysrq-8` 或者::
+
+    echo 8 > /proc/sysrq-trigger
+
+在觸發了你感興趣的 SysRq 鍵命令後，記得恢復日誌級別到正常情況。
+
+我有很多問題時，可以請教誰？
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+請教在內核郵件列表上的人，郵箱：
+	linux-kernel@vger.kernel.org
+
+致謝
+~~~~
+
+- Mydraal <vulpyne@vulpyne.net> 撰寫了該文件
+- Adam Sulmicki <adam@cfar.umd.edu> 進行了更新
+- Jeremy M. Dolan <jmd@turbogeek.org> 在 2001/01/28 10:15:59 進行了更新
+- Crutcher Dunnavant <crutcher+kernel@datastacks.com> 添加鍵註冊部分
+
diff --git a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
index ebe3812ead82..47629f6b05de 100644
--- a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
+++ b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
@@ -9,27 +9,27 @@
  吳想成 Wu XiangCheng <bobwxc@email.cn>
  胡皓文 Hu Haowen <src.res.211@gmail.com>
 
-受汙染的內核
+受污染的內核
 -------------
 
-當發生一些在稍後調查問題時可能相關的事件時，內核會將自己標記爲「受汙染
-（tainted）」的。不用太過擔心，大多數情況下運行受汙染的內核沒有問題；這些信息
-主要在有人想調查某個問題時才有意義的，因爲問題的真正原因可能是導致內核受汙染
-的事件。這就是爲什麼來自受汙染內核的缺陷報告常常被開發人員忽略，因此請嘗試用
-未受汙染的內核重現問題。
+當發生一些在稍後調查問題時可能相關的事件時，內核會將自己標記爲“受污染
+（tainted）”的。不用太過擔心，大多數情況下運行受污染的內核沒有問題；這些信息
+主要在有人想調查某個問題時纔有意義的，因爲問題的真正原因可能是導致內核受污染
+的事件。這就是爲什麼來自受污染內核的缺陷報告常常被開發人員忽略，因此請嘗試用
+未受污染的內核重現問題。
 
-請注意，即使在您消除導致汙染的原因（亦即卸載專有內核模塊）之後，內核仍將保持
-汙染狀態，以表示內核仍然不可信。這也是爲什麼內核在注意到內部問題（「kernel
-bug」）、可恢復錯誤（「kernel oops」）或不可恢復錯誤（「kernel panic」）時會列印
-受汙染狀態，並將有關此的調試信息寫入日誌 ``dmesg`` 輸出。也可以通過
-``/proc/`` 中的文件在運行時檢查受汙染的狀態。
+請注意，即使在您消除導致污染的原因（亦即卸載專有內核模塊）之後，內核仍將保持
+污染狀態，以表示內核仍然不可信。這也是爲什麼內核在注意到內部問題（“kernel
+bug”）、可恢復錯誤（“kernel oops”）或不可恢復錯誤（“kernel panic”）時會打印
+受污染狀態，並將有關此的調試信息寫入日誌 ``dmesg`` 輸出。也可以通過
+``/proc/`` 中的文件在運行時檢查受污染的狀態。
 
 
-BUG、Oops或Panics消息中的汙染標誌
+BUG、Oops或Panics消息中的污染標誌
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-在頂部以「CPU:」開頭的一行中可以找到受汙染的狀態；內核是否受到汙染和原因會顯示
-在進程ID（「PID:」）和觸發事件命令的縮寫名稱（「Comm:」）之後::
+在頂部以“CPU:”開頭的一行中可以找到受污染的狀態；內核是否受到污染和原因會顯示
+在進程ID（“PID:”）和觸發事件命令的縮寫名稱（“Comm:”）之後::
 
 	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 	Oops: 0002 [#1] SMP PTI
@@ -38,27 +38,27 @@ BUG、Oops或Panics消息中的汙染標誌
 	RIP: 0010:my_oops_init+0x13/0x1000 [kpanic]
 	[...]
 
-如果內核在事件發生時沒有被汙染，您將在那裡看到「Not-tainted:」；如果被汙染，那
-麼它將是「Tainted:」以及字母或空格。在上面的例子中，它看起來是這樣的::
+如果內核在事件發生時沒有被污染，您將在那裏看到“Not-tainted:”；如果被污染，那
+麼它將是“Tainted:”以及字母或空格。在上面的例子中，它看起來是這樣的::
 
 	Tainted: P        W  O
 
 下表解釋了這些字符的含義。在本例中，由於加載了專有模塊（ ``P`` ），出現了
 警告（ ``W`` ），並且加載了外部構建的模塊（ ``O`` ），所以內核早些時候受到
-了汙染。要解碼其他字符，請使用下表。
+了污染。要解碼其他字符，請使用下表。
 
 
-解碼運行時的汙染狀態
+解碼運行時的污染狀態
 ~~~~~~~~~~~~~~~~~~~~~
 
-在運行時，您可以通過讀取 ``cat /proc/sys/kernel/tainted`` 來查詢受汙染狀態。
-如果返回 ``0`` ，則內核沒有受到汙染；任何其他數字都表示受到汙染的原因。解碼
+在運行時，您可以通過讀取 ``cat /proc/sys/kernel/tainted`` 來查詢受污染狀態。
+如果返回 ``0`` ，則內核沒有受到污染；任何其他數字都表示受到污染的原因。解碼
 這個數字的最簡單方法是使用腳本  ``tools/debugging/kernel-chktaint`` ，您的
 發行版可能會將其作爲名爲 ``linux-tools`` 或 ``kernel-tools`` 的包的一部分提
 供；如果沒有，您可以從
 `git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_
 網站下載此腳本並用 ``sh kernel-chktaint`` 執行，它會在上面引用的日誌中有類似
-語句的機器上列印這樣的內容::
+語句的機器上打印這樣的內容::
 
 	Kernel is Tainted for following reasons:
 	 * Proprietary module was loaded (#0)
@@ -69,19 +69,19 @@ BUG、Oops或Panics消息中的汙染標誌
 	 a more details explanation of the various taint flags.
 	Raw taint value as int/string: 4609/'P        W  O     '
 
-你也可以試著自己解碼這個數字。如果內核被汙染的原因只有一個，那麼這很簡單，
+你也可以試着自己解碼這個數字。如果內核被污染的原因只有一個，那麼這很簡單，
 在本例中您可以通過下表找到數字。如果你需要解碼有多個原因的數字，因爲它是一
-個位域（bitfield），其中每個位表示一個特定類型的汙染的存在或不存在，最好讓
+個位域（bitfield），其中每個位表示一個特定類型的污染的存在或不存在，最好讓
 前面提到的腳本來處理。但是如果您需要快速看一下，可以使用這個shell命令來檢查
 設置了哪些位::
 
 	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
 
-汙染狀態代碼表
+污染狀態代碼表
 ~~~~~~~~~~~~~~~
 
 ===  =====  ======  ========================================================
- 位  日誌     數字  內核被汙染的原因
+ 位  日誌     數字  內核被污染的原因
 ===  =====  ======  ========================================================
   0   G/P        1  已加載專用模塊
   1   _/F        2  模塊被強制加載
@@ -89,23 +89,23 @@ BUG、Oops或Panics消息中的汙染標誌
   3   _/R        8  模塊被強制卸載
   4   _/M       16  處理器報告了機器檢測異常（MCE）
   5   _/B       32  引用了錯誤的頁或某些意外的頁標誌
-  6   _/U       64  用戶空間應用程式請求的汙染
+  6   _/U       64  用戶空間應用程序請求的污染
   7   _/D      128  內核最近死機了，即曾出現OOPS或BUG
   8   _/A      256  ACPI表被用戶覆蓋
   9   _/W      512  內核發出警告
  10   _/C     1024  已加載staging驅動程序
- 11   _/I     2048  已應用平台固件缺陷的解決方案
- 12   _/O     4096  已加載外部構建（「樹外」）模塊
+ 11   _/I     2048  已應用平臺固件缺陷的解決方案
+ 12   _/O     4096  已加載外部構建（“樹外”）模塊
  13   _/E     8192  已加載未簽名的模塊
  14   _/L    16384  發生軟鎖定
  15   _/K    32768  內核已實時打補丁
- 16   _/X    65536  備用汙染，爲發行版定義並使用
+ 16   _/X    65536  備用污染，爲發行版定義並使用
  17   _/T   131072  內核是用結構隨機化插件構建的
 ===  =====  ======  ========================================================
 
-註：字符 ``_`` 表示空白，以便於閱讀表。
+注：字符 ``_`` 表示空白，以便於閱讀表。
 
-汙染的更詳細解釋
+污染的更詳細解釋
 ~~~~~~~~~~~~~~~~~
 
  0)  ``G`` 加載的所有模塊都有GPL或兼容許可證， ``P`` 加載了任何專有模塊。
@@ -115,14 +115,14 @@ BUG、Oops或Panics消息中的汙染標誌
 
  1)  ``F`` 任何模塊被 ``insmod -f`` 強制加載， ``' '`` 所有模塊正常加載。
 
- 2)  ``S`` 內核運行在不合規範的處理器或系統上：硬體已運行在不受支持的配置中，
-     因此無法保證正確執行。內核將被汙染，例如：
+ 2)  ``S`` 內核運行在不合規範的處理器或系統上：硬件已運行在不受支持的配置中，
+     因此無法保證正確執行。內核將被污染，例如：
 
      - 在x86上：PAE是通過intel CPU（如Pentium M）上的forcepae強制執行的，這些
        CPU不報告PAE，但可能有功能實現，SMP內核在非官方支持的SMP Athlon CPU上
        運行，MSR被暴露到用戶空間中。
      - 在arm上：在某些CPU（如Keystone 2）上運行的內核，沒有啓用某些內核特性。
-     - 在arm64上：CPU之間存在不匹配的硬體特性，引導加載程序以不同的模式引導CPU。
+     - 在arm64上：CPU之間存在不匹配的硬件特性，引導加載程序以不同的模式引導CPU。
      - 某些驅動程序正在被用在不受支持的體系結構上（例如x86_64以外的其他系統
        上的scsi/snic，非x86/x86_64/itanium上的scsi/ips，已經損壞了arm64上
        irqchip/irq-gic的固件設置…）。
@@ -131,22 +131,22 @@ BUG、Oops或Panics消息中的汙染標誌
 
  4)  ``M`` 任何處理器報告了機器檢測異常， ``' '`` 未發生機器檢測異常。
 
- 5)  ``B`` 頁面釋放函數發現錯誤的頁面引用或某些意外的頁面標誌。這表示硬體問題
-     或內核錯誤；日誌中應該有其他信息指示發生此汙染的原因。
+ 5)  ``B`` 頁面釋放函數發現錯誤的頁面引用或某些意外的頁面標誌。這表示硬件問題
+     或內核錯誤；日誌中應該有其他信息指示發生此污染的原因。
 
- 6)  ``U`` 用戶或用戶應用程式特意請求設置受汙染標誌，否則應爲 ``' '`` 。
+ 6)  ``U`` 用戶或用戶應用程序特意請求設置受污染標誌，否則應爲 ``' '`` 。
 
  7)  ``D`` 內核最近死機了，即出現了OOPS或BUG。
 
  8)  ``A`` ACPI表被重寫。
 
- 9)  ``W`` 內核之前已發出過警告（儘管有些警告可能會設置更具體的汙染標誌）。
+ 9)  ``W`` 內核之前已發出過警告（儘管有些警告可能會設置更具體的污染標誌）。
 
  10) ``C`` 已加載staging驅動程序。
 
- 11) ``I`` 內核正在處理平台固件（BIOS或類似軟體）中的嚴重錯誤。
+ 11) ``I`` 內核正在處理平臺固件（BIOS或類似軟件）中的嚴重錯誤。
 
- 12) ``O`` 已加載外部構建（「樹外」）模塊。
+ 12) ``O`` 已加載外部構建（“樹外”）模塊。
 
  13) ``E`` 在支持模塊簽名的內核中加載了未簽名的模塊。
 
@@ -154,8 +154,8 @@ BUG、Oops或Panics消息中的汙染標誌
 
  15) ``K`` 內核已經實時打了補丁。
 
- 16) ``X`` 備用汙染，由Linux發行版定義和使用。
+ 16) ``X`` 備用污染，由Linux發行版定義和使用。
 
  17) ``T`` 內核構建時使用了randstruct插件，它可以有意生成非常不尋常的內核結構
-     布局（甚至是性能病態的布局），這在調試時非常有用。於構建時設置。
+     佈局（甚至是性能病態的佈局），這在調試時非常有用。於構建時設置。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/unicode.rst b/Documentation/translations/zh_TW/admin-guide/unicode.rst
index 7908b369b85b..a2b48b5d0a64 100644
--- a/Documentation/translations/zh_TW/admin-guide/unicode.rst
+++ b/Documentation/translations/zh_TW/admin-guide/unicode.rst
@@ -37,15 +37,15 @@ IBMPC_MAP       IBM code page 437               ESC ( U
 USER_MAP        User defined                    ESC ( K
 =============== =============================== ================
 
-特別是 ESC ( U 不再是「直通字體」，因爲字體可能與IBM字符集完全不同。
+特別是 ESC ( U 不再是“直通字體”，因爲字體可能與IBM字符集完全不同。
 例如，即使加載了一個Latin-1字體，也允許使用塊圖形（block graphics）。
 
 請注意，儘管這些代碼與ISO 2022類似，但這些代碼及其用途都與ISO 2022不匹配；
 Linux有兩個八位代碼（G0和G1），而ISO 2022有四個七位代碼（G0-G3）。
 
-根據Unicode標準/ISO 10646，U+F000到U+F8FF被保留用於作業系統範圍內的分配
-（Unicode標準將其稱爲「團體區域（Corporate Zone）」，因爲這對於Linux是不準確
-的，所以我們稱之爲「Linux區域」）。選擇U+F000作爲起點，因爲它允許直接映射
+根據Unicode標準/ISO 10646，U+F000到U+F8FF被保留用於操作系統範圍內的分配
+（Unicode標準將其稱爲“團體區域（Corporate Zone）”，因爲這對於Linux是不準確
+的，所以我們稱之爲“Linux區域”）。選擇U+F000作爲起點，因爲它允許直接映射
 區域以2的大倍數開始（以防需要1024或2048個字符的字體）。這就留下U+E000到
 U+EFFF作爲最終用戶區。
 
@@ -87,7 +87,7 @@ U+F813 KEYBOARD SYMBOL SOLID APPLE
 克林貢（Klingon）語支持
 ------------------------
 
-1996年，Linux是世界上第一個添加對人工語言克林貢支持的作業系統，克林貢是由
+1996年，Linux是世界上第一個添加對人工語言克林貢支持的操作系統，克林貢是由
 Marc Okrand爲《星際迷航》電視連續劇創造的。這種編碼後來被徵募Unicode註冊表
 （ConScript Unicode Registry，CSUR）採用，並建議（但最終被拒絕）納入Unicode
 平面一。不過，它仍然是Linux區域中的Linux/CSUR私有分配。
diff --git a/Documentation/translations/zh_TW/arch/arm/Booting b/Documentation/translations/zh_TW/arch/arm/Booting
new file mode 100644
index 000000000000..a5375f262de2
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/arm/Booting
@@ -0,0 +1,176 @@
+Chinese translated version of Documentation/arch/arm/booting.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Russell King <linux@arm.linux.org.uk>
+Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
+---------------------------------------------------------------------
+Documentation/arch/arm/booting.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+
+英文版維護者： Russell King <linux@arm.linux.org.uk>
+中文版維護者： 傅煒  Fu Wei <tekkamanninja@gmail.com>
+中文版翻譯者： 傅煒  Fu Wei <tekkamanninja@gmail.com>
+中文版校譯者： 傅煒  Fu Wei <tekkamanninja@gmail.com>
+
+以下爲正文
+---------------------------------------------------------------------
+
+			啓動 ARM Linux
+			==============
+
+作者：Russell King
+日期：2002年5月18日
+
+以下文檔適用於 2.4.18-rmk6 及以上版本。
+
+爲了啓動 ARM Linux，你需要一個引導裝載程序（boot loader），
+它是一個在主內核啓動前運行的一個小程序。引導裝載程序需要初始化各種
+設備，並最終調用 Linux 內核，將信息傳遞給內核。
+
+從本質上講，引導裝載程序應提供（至少）以下功能：
+
+1、設置和初始化 RAM。
+2、初始化一個串口。
+3、檢測機器的類型（machine type）。
+4、設置內核標籤列表（tagged list）。
+5、調用內核映像。
+
+
+1、設置和初始化 RAM
+-------------------
+
+現有的引導加載程序:		強制
+新開發的引導加載程序:		強制
+
+引導裝載程序應該找到並初始化系統中所有內核用於保持系統變量數據的 RAM。
+這個操作的執行是設備依賴的。（它可能使用內部算法來自動定位和計算所有
+RAM，或可能使用對這個設備已知的 RAM 信息，還可能使用任何引導裝載程序
+設計者想到的匹配方法。）
+
+
+2、初始化一個串口
+-----------------------------
+
+現有的引導加載程序:		可選、建議
+新開發的引導加載程序:		可選、建議
+
+引導加載程序應該初始化並使能一個目標板上的串口。這允許內核串口驅動
+自動檢測哪個串口用於內核控制檯。(一般用於調試或與目標板通信。)
+
+作爲替代方案，引導加載程序也可以通過標籤列表傳遞相關的'console='
+選項給內核以指定某個串口，而串口數據格式的選項在以下文檔中描述：
+
+       Documentation/admin-guide/kernel-parameters.rst。
+
+
+3、檢測機器類型
+--------------------------
+
+現有的引導加載程序:		可選
+新開發的引導加載程序:		強制
+
+引導加載程序應該通過某些方式檢測自身所處的機器類型。這是一個硬件
+代碼或通過查看所連接的硬件用某些算法得到，這些超出了本文檔的範圍。
+引導加載程序最終必須能提供一個 MACH_TYPE_xxx 值給內核。
+(詳見 linux/arch/arm/tools/mach-types )。
+
+4、設置啓動數據
+------------------
+
+現有的引導加載程序:		可選、強烈建議
+新開發的引導加載程序:		強制
+
+引導加載程序必須提供標籤列表或者 dtb 映像以傳遞配置數據給內核。啓動
+數據的物理地址通過寄存器 r2 傳遞給內核。
+
+4a、設置內核標籤列表
+--------------------------------
+
+bootloader 必須創建和初始化內核標籤列表。一個有效的標籤列表以
+ATAG_CORE 標籤開始，並以 ATAG_NONE 標籤結束。ATAG_CORE 標籤可以是
+空的，也可以是非空。一個空 ATAG_CORE 標籤其 size 域設置爲
+‘2’(0x00000002)。ATAG_NONE 標籤的 size 域必須設置爲零。
+
+在列表中可以保存任意數量的標籤。對於一個重複的標籤是追加到之前標籤
+所攜帶的信息之後，還是會覆蓋原來的信息，是未定義的。某些標籤的行爲
+是前者，其他是後者。
+
+bootloader 必須傳遞一個系統內存的位置和最小值，以及根文件系統位置。
+因此，最小的標籤列表如下所示：
+
+		+-----------+
+基地址 ->	| ATAG_CORE |  |
+		+-----------+  |
+		| ATAG_MEM  |  | 地址增長方向
+		+-----------+  |
+		| ATAG_NONE |  |
+		+-----------+  v
+
+標籤列表應該保存在系統的 RAM 中。
+
+標籤列表必須置於內核自解壓和 initrd'bootp' 程序都不會覆蓋的內存區。
+建議放在 RAM 的頭 16KiB 中。
+
+4b、設置設備樹
+-------------------------
+
+bootloader 必須以 64bit 地址對齊的形式加載一個設備樹映像(dtb)到系統
+RAM 中，並用啓動數據初始化它。dtb 格式在文檔
+https://www.devicetree.org/specifications/ 中。內核將會在
+dtb 物理地址處查找 dtb 魔數值（0xd00dfeed），以確定 dtb 是否已經代替
+標籤列表被傳遞進來。
+
+bootloader 必須傳遞一個系統內存的位置和最小值，以及根文件系統位置。
+dtb 必須置於內核自解壓不會覆蓋的內存區。建議將其放置於 RAM 的頭 16KiB
+中。但是不可將其放置於“0”物理地址處，因爲內核認爲：r2 中爲 0，意味着
+沒有標籤列表和 dtb 傳遞過來。
+
+5、調用內核映像
+---------------------------
+
+現有的引導加載程序:		強制
+新開發的引導加載程序:		強制
+
+調用內核映像 zImage 有兩個選擇。如果 zImge 保存在 flash 中，且是爲了
+在 flash 中直接運行而被正確鏈接的。這樣引導加載程序就可以在 flash 中
+直接調用 zImage。
+
+zImage 也可以被放在系統 RAM（任意位置）中被調用。注意：內核使用映像
+基地址的前 16KB RAM 空間來保存頁表。建議將映像置於 RAM 的 32KB 處。
+
+對於以上任意一種情況，都必須符合以下啓動狀態：
+
+- 停止所有 DMA 設備，這樣內存數據就不會因爲虛假網絡包或磁盤數據而被破壞。
+  這可能可以節省你許多的調試時間。
+
+- CPU 寄存器配置
+  r0 = 0，
+  r1 = （在上面 3 中獲取的）機器類型碼。
+  r2 = 標籤列表在系統 RAM 中的物理地址，或
+       設備樹塊(dtb)在系統 RAM 中的物理地址
+
+- CPU 模式
+  所有形式的中斷必須被禁止 (IRQs 和 FIQs)
+  CPU 必須處於 SVC 模式。(對於 Angel 調試有特例存在)
+
+- 緩存，MMUs
+  MMU 必須關閉。
+  指令緩存開啓或關閉都可以。
+  數據緩存必須關閉。
+
+- 引導加載程序應該通過直接跳轉到內核映像的第一條指令來調用內核映像。
+
+  對於支持 ARM 指令集的 CPU，跳入內核入口時必須處在 ARM 狀態，即使
+  對於 Thumb-2 內核也是如此。
+
+  對於僅支持 Thumb 指令集的 CPU，比如 Cortex-M 系列的 CPU，跳入
+  內核入口時必須處於 Thumb 狀態。
+
diff --git a/Documentation/translations/zh_TW/arch/arm/kernel_user_helpers.txt b/Documentation/translations/zh_TW/arch/arm/kernel_user_helpers.txt
new file mode 100644
index 000000000000..4c0bff97af31
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/arm/kernel_user_helpers.txt
@@ -0,0 +1,285 @@
+Chinese translated version of Documentation/arch/arm/kernel_user_helpers.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Maintainer: Nicolas Pitre <nicolas.pitre@linaro.org>
+		Dave Martin <dave.martin@linaro.org>
+Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
+---------------------------------------------------------------------
+Documentation/arch/arm/kernel_user_helpers.rst 的中文翻譯
+
+如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
+交流有困難的話，也可以向中文版維護者求助。如果本翻譯更新不及時或者翻
+譯存在問題，請聯繫中文版維護者。
+英文版維護者： Nicolas Pitre <nicolas.pitre@linaro.org>
+		Dave Martin <dave.martin@linaro.org>
+中文版維護者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
+中文版翻譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
+中文版校譯者： 宋冬生 Dongsheng Song <dongshneg.song@gmail.com>
+		傅煒 Fu Wei <tekkamanninja@gmail.com>
+
+
+以下爲正文
+---------------------------------------------------------------------
+內核提供的用戶空間輔助代碼
+=========================
+
+在內核內存空間的固定地址處，有一個由內核提供並可從用戶空間訪問的代碼
+段。它用於向用戶空間提供因在許多 ARM CPU 中未實現的特性和/或指令而需
+內核提供幫助的某些操作。這些代碼直接在用戶模式下執行的想法是爲了獲得
+最佳效率，但那些與內核計數器聯繫過於緊密的部分，則被留給了用戶庫實現。
+事實上，此代碼甚至可能因不同的 CPU 而異，這取決於其可用的指令集或它
+是否爲 SMP 系統。換句話說，內核保留在不作出警告的情況下根據需要更改
+這些代碼的權利。只有本文檔描述的入口及其結果是保證穩定的。
+
+這與完全成熟的 VDSO 實現不同（但兩者並不衝突），儘管如此，VDSO 可阻止
+某些通過常量高效跳轉到那些代碼段的彙編技巧。且由於那些代碼段在返回用戶
+代碼前僅使用少量的代碼週期，則一個 VDSO 間接遠程調用將會在這些簡單的
+操作上增加一個可測量的開銷。
+
+在對那些擁有原生支持的新型處理器進行代碼優化時，僅在已爲其他操作使用
+了類似的新增指令，而導致二進制結果已與早期 ARM 處理器不兼容的情況下，
+用戶空間才應繞過這些輔助代碼，並在內聯函數中實現這些操作（無論是通過
+編譯器在代碼中直接放置，還是作爲庫函數調用實現的一部分）。也就是說，
+如果你編譯的代碼不會爲了其他目的使用新指令，則不要僅爲了避免使用這些
+內核輔助代碼，導致二進制程序無法在早期處理器上運行。
+
+新的輔助代碼可能隨着時間的推移而增加，所以新內核中的某些輔助代碼在舊
+內核中可能不存在。因此，程序必須在對任何輔助代碼調用假設是安全之前，
+檢測 __kuser_helper_version 的值（見下文）。理想情況下，這種檢測應該
+只在進程啓動時執行一次；如果內核版本不支持所需輔助代碼，則該進程可儘早
+中止執行。
+
+kuser_helper_version
+--------------------
+
+位置:	0xffff0ffc
+
+參考聲明:
+
+  extern int32_t __kuser_helper_version;
+
+定義:
+
+  這個區域包含了當前運行內核實現的輔助代碼版本號。用戶空間可以通過讀
+  取此版本號以確定特定的輔助代碼是否存在。
+
+使用範例:
+
+#define __kuser_helper_version (*(int32_t *)0xffff0ffc)
+
+void check_kuser_version(void)
+{
+	if (__kuser_helper_version < 2) {
+		fprintf(stderr, "can't do atomic operations, kernel too old\n");
+		abort();
+	}
+}
+
+注意:
+
+  用戶空間可以假設這個域的值不會在任何單個進程的生存期內改變。也就
+  是說，這個域可以僅在庫的初始化階段或進程啓動階段讀取一次。
+
+kuser_get_tls
+-------------
+
+位置:	0xffff0fe0
+
+參考原型:
+
+  void * __kuser_get_tls(void);
+
+輸入:
+
+  lr = 返回地址
+
+輸出:
+
+  r0 = TLS 值
+
+被篡改的寄存器:
+
+  無
+
+定義:
+
+  獲取之前通過 __ARM_NR_set_tls 系統調用設置的 TLS 值。
+
+使用範例:
+
+typedef void * (__kuser_get_tls_t)(void);
+#define __kuser_get_tls (*(__kuser_get_tls_t *)0xffff0fe0)
+
+void foo()
+{
+	void *tls = __kuser_get_tls();
+	printf("TLS = %p\n", tls);
+}
+
+注意:
+
+  - 僅在 __kuser_helper_version >= 1 時，此輔助代碼存在
+    （從內核版本 2.6.12 開始）。
+
+kuser_cmpxchg
+-------------
+
+位置:	0xffff0fc0
+
+參考原型:
+
+  int __kuser_cmpxchg(int32_t oldval, int32_t newval, volatile int32_t *ptr);
+
+輸入:
+
+  r0 = oldval
+  r1 = newval
+  r2 = ptr
+  lr = 返回地址
+
+輸出:
+
+  r0 = 成功代碼 (零或非零)
+  C flag = 如果 r0 == 0 則置 1，如果 r0 != 0 則清零。
+
+被篡改的寄存器:
+
+  r3, ip, flags
+
+定義:
+
+  僅在 *ptr 爲 oldval 時原子保存 newval 於 *ptr 中。
+  如果 *ptr 被改變，則返回值爲零，否則爲非零值。
+  如果 *ptr 被改變，則 C flag 也會被置 1，以實現調用代碼中的彙編
+  優化。
+
+使用範例:
+
+typedef int (__kuser_cmpxchg_t)(int oldval, int newval, volatile int *ptr);
+#define __kuser_cmpxchg (*(__kuser_cmpxchg_t *)0xffff0fc0)
+
+int atomic_add(volatile int *ptr, int val)
+{
+	int old, new;
+
+	do {
+		old = *ptr;
+		new = old + val;
+	} while(__kuser_cmpxchg(old, new, ptr));
+
+	return new;
+}
+
+注意:
+
+  - 這個例程已根據需要包含了內存屏障。
+
+  - 僅在 __kuser_helper_version >= 2 時，此輔助代碼存在
+    （從內核版本 2.6.12 開始）。
+
+kuser_memory_barrier
+--------------------
+
+位置:	0xffff0fa0
+
+參考原型:
+
+  void __kuser_memory_barrier(void);
+
+輸入:
+
+  lr = 返回地址
+
+輸出:
+
+  無
+
+被篡改的寄存器:
+
+  無
+
+定義:
+
+  應用於任何需要內存屏障以防止手動數據修改帶來的一致性問題，以及
+  __kuser_cmpxchg 中。
+
+使用範例:
+
+typedef void (__kuser_dmb_t)(void);
+#define __kuser_dmb (*(__kuser_dmb_t *)0xffff0fa0)
+
+注意:
+
+  - 僅在 __kuser_helper_version >= 3 時，此輔助代碼存在
+    （從內核版本 2.6.15 開始）。
+
+kuser_cmpxchg64
+---------------
+
+位置:	0xffff0f60
+
+參考原型:
+
+  int __kuser_cmpxchg64(const int64_t *oldval,
+                        const int64_t *newval,
+                        volatile int64_t *ptr);
+
+輸入:
+
+  r0 = 指向 oldval
+  r1 = 指向 newval
+  r2 = 指向目標值
+  lr = 返回地址
+
+輸出:
+
+  r0 = 成功代碼 (零或非零)
+  C flag = 如果 r0 == 0 則置 1，如果 r0 != 0 則清零。
+
+被篡改的寄存器:
+
+  r3, lr, flags
+
+定義:
+
+  僅在 *ptr 等於 *oldval 指向的 64 位值時，原子保存 *newval
+  指向的 64 位值於 *ptr 中。如果 *ptr 被改變，則返回值爲零，
+  否則爲非零值。
+
+  如果 *ptr 被改變，則 C flag 也會被置 1，以實現調用代碼中的彙編
+  優化。
+
+使用範例:
+
+typedef int (__kuser_cmpxchg64_t)(const int64_t *oldval,
+                                  const int64_t *newval,
+                                  volatile int64_t *ptr);
+#define __kuser_cmpxchg64 (*(__kuser_cmpxchg64_t *)0xffff0f60)
+
+int64_t atomic_add64(volatile int64_t *ptr, int64_t val)
+{
+	int64_t old, new;
+
+	do {
+		old = *ptr;
+		new = old + val;
+	} while(__kuser_cmpxchg64(&old, &new, ptr));
+
+	return new;
+}
+
+注意:
+
+  - 這個例程已根據需要包含了內存屏障。
+
+  - 由於這個過程的代碼長度（此輔助代碼跨越 2 個常規的 kuser “槽”），
+    因此 0xffff0f80 不被作爲有效的入口點。
+
+  - 僅在 __kuser_helper_version >= 5 時，此輔助代碼存在
+    （從內核版本 3.1 開始）。
+
diff --git a/Documentation/translations/zh_TW/arch/arm64/amu.rst b/Documentation/translations/zh_TW/arch/arm64/amu.rst
index 21ac0db63889..1b451eae2bee 100644
--- a/Documentation/translations/zh_TW/arch/arm64/amu.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/amu.rst
@@ -28,11 +28,11 @@ AArch64 Linux 中擴展的活動監控單元
 
 AMUv1 架構實現了一個由4個固定的64位事件計數器組成的計數器組。
 
-  - CPU 周期計數器：同 CPU 的頻率增長
+  - CPU 週期計數器：同 CPU 的頻率增長
   - 常量計數器：同固定的系統時鐘頻率增長
   - 淘汰指令計數器: 同每次架構指令執行增長
-  - 內存停頓周期計數器：計算由在時鐘域內的最後一級緩存中未命中而引起
-    的指令調度停頓周期數
+  - 內存停頓週期計數器：計算由在時鐘域內的最後一級緩存中未命中而引起
+    的指令調度停頓週期數
 
 當處於 WFI 或者 WFE 狀態時，計數器不會增長。
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/booting.txt b/Documentation/translations/zh_TW/arch/arm64/booting.txt
index 3cc8f593e006..be0de91ecebd 100644
--- a/Documentation/translations/zh_TW/arch/arm64/booting.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/booting.txt
@@ -41,8 +41,8 @@ AArch64 異常模型由多個異常級（EL0 - EL3）組成，對於 EL0 和 EL1
 有對應的安全和非安全模式。EL2 是系統管理級，且僅存在於非安全模式下。
 EL3 是最高特權級，且僅存在於安全模式下。
 
-基於本文檔的目的，我們將簡單地使用『引導裝載程序』（『boot loader』）
-這個術語來定義在將控制權交給 Linux 內核前 CPU 上執行的所有軟體。
+基於本文檔的目的，我們將簡單地使用‘引導裝載程序’（‘boot loader’）
+這個術語來定義在將控制權交給 Linux 內核前 CPU 上執行的所有軟件。
 這可能包含安全監控和系統管理代碼，或者它可能只是一些用於準備最小啓動
 環境的指令。
 
@@ -74,7 +74,7 @@ RAM，或可能使用對這個設備已知的 RAM 信息，還可能是引導裝
 數據塊將在使能緩存的情況下以 2MB 粒度被映射，故其不能被置於必須以特定
 屬性映射的2M區域內。
 
-註： v4.2 之前的版本同時要求設備樹數據塊被置於從內核映像以下
+注： v4.2 之前的版本同時要求設備樹數據塊被置於從內核映像以下
 text_offset 字節處算起第一個 512MB 內。
 
 3、解壓內核映像
@@ -106,7 +106,7 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
   u32 res5;			/* 保留 （用於 PE COFF 偏移） */
 
 
-映像頭注釋：
+映像頭註釋：
 
 - 自 v3.17 起，除非另有說明，所有域都是小端模式。
 
@@ -143,7 +143,7 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
 字節處，並從該處被調用。2MB 對齊基址和內核映像起始地址之間的區域對於
 內核來說沒有特殊意義，且可能被用於其他目的。
 從映像起始地址算起，最少必須準備 image_size 字節的空閒內存供內核使用。
-註： v4.6 之前的版本無法使用內核映像物理偏移以下的內存，所以當時建議
+注： v4.6 之前的版本無法使用內核映像物理偏移以下的內存，所以當時建議
 將映像儘量放置在靠近系統內存起始的地方。
 
 任何提供給內核的內存（甚至在映像起始地址之前），若未從內核中標記爲保留
@@ -151,7 +151,7 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
 
 在跳轉入內核前，必須符合以下狀態：
 
-- 停止所有 DMA 設備，這樣內存數據就不會因爲虛假網絡包或磁碟數據而
+- 停止所有 DMA 設備，這樣內存數據就不會因爲虛假網絡包或磁盤數據而
   被破壞。這可能可以節省你許多的調試時間。
 
 - 主 CPU 通用寄存器設置
@@ -175,7 +175,7 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
   而不通過虛擬地址操作維護構架緩存的系統緩存（不推薦），必須被配置且
   禁用。
 
-  *譯者註：對於 PoC 以及緩存相關內容，請參考 ARMv8 構架參考手冊
+  *譯者注：對於 PoC 以及緩存相關內容，請參考 ARMv8 構架參考手冊
    ARM DDI 0487A
 
 - 架構計時器
@@ -189,7 +189,7 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
   接收。
 
 - 系統寄存器
-  在進入內核映像的異常級中，所有構架中可寫的系統寄存器必須通過軟體
+  在進入內核映像的異常級中，所有構架中可寫的系統寄存器必須通過軟件
   在一個更高的異常級別下初始化，以防止在 未知 狀態下運行。
 
   對於擁有 GICv3 中斷控制器並以 v3 模式運行的系統：
@@ -214,14 +214,14 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
 引導裝載程序必須在每個 CPU 處於以下狀態時跳入內核入口：
 
 - 主 CPU 必須直接跳入內核映像的第一條指令。通過此 CPU 傳遞的設備樹
-  數據塊必須在每個 CPU 節點中包含一個 『enable-method』 屬性，所
+  數據塊必須在每個 CPU 節點中包含一個 ‘enable-method’ 屬性，所
   支持的 enable-method 請見下文。
 
   引導裝載程序必須生成這些設備樹屬性，並在跳入內核入口之前將其插入
   數據塊。
 
-- enable-method 爲 「spin-table」 的 CPU 必須在它們的 CPU
-  節點中包含一個 『cpu-release-addr』 屬性。這個屬性標識了一個
+- enable-method 爲 “spin-table” 的 CPU 必須在它們的 CPU
+  節點中包含一個 ‘cpu-release-addr’ 屬性。這個屬性標識了一個
   64 位自然對齊且初始化爲零的內存位置。
 
   這些 CPU 必須在內存保留區（通過設備樹中的 /memreserve/ 域傳遞
@@ -231,15 +231,15 @@ AArch64 內核當前沒有提供自解壓代碼，因此如果使用了壓縮內
   時，CPU 必須跳入此值所指向的地址。此值爲一個單獨的 64 位小端值，
   因此 CPU 須在跳轉前將所讀取的值轉換爲其本身的端模式。
 
-- enable-method 爲 「psci」 的 CPU 保持在內核外（比如，在
+- enable-method 爲 “psci” 的 CPU 保持在內核外（比如，在
   memory 節點中描述爲內核空間的內存區外，或在通過設備樹 /memreserve/
   域中描述爲內核保留區的空間中）。內核將會發起在 ARM 文檔（編號
-  ARM DEN 0022A：用於 ARM 上的電源狀態協調接口系統軟體）中描述的
+  ARM DEN 0022A：用於 ARM 上的電源狀態協調接口系統軟件）中描述的
   CPU_ON 調用來將 CPU 帶入內核。
 
   *譯者注: ARM DEN 0022A 已更新到 ARM DEN 0022C。
 
-  設備樹必須包含一個 『psci』 節點，請參考以下文檔：
+  設備樹必須包含一個 ‘psci’ 節點，請參考以下文檔：
   Documentation/devicetree/bindings/arm/psci.yaml
 
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
index ca7ff749a67b..d2c1c2f23812 100644
--- a/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
@@ -17,11 +17,11 @@ ARM64 ELF hwcaps
 1. 簡介
 -------
 
-有些硬體或軟體功能僅在某些 CPU 實現上和/或在具體某個內核配置上可用，但
+有些硬件或軟件功能僅在某些 CPU 實現上和/或在具體某個內核配置上可用，但
 對於處於 EL0 的用戶空間代碼沒有可用的架構發現機制。內核通過在輔助向量表
 公開一組稱爲 hwcaps 的標誌而把這些功能暴露給用戶空間。
 
-用戶空間軟體可以通過獲取輔助向量的 AT_HWCAP 或 AT_HWCAP2 條目來測試功能，
+用戶空間軟件可以通過獲取輔助向量的 AT_HWCAP 或 AT_HWCAP2 條目來測試功能，
 並測試是否設置了相關標誌，例如::
 
 	bool floating_point_is_present(void)
@@ -33,7 +33,7 @@ ARM64 ELF hwcaps
 		return false;
 	}
 
-如果軟體依賴於 hwcap 描述的功能，在嘗試使用該功能前則應檢查相關的 hwcap
+如果軟件依賴於 hwcap 描述的功能，在嘗試使用該功能前則應檢查相關的 hwcap
 標誌以驗證該功能是否存在。
 
 不能通過其他方式探查這些功能。當一個功能不可用時，嘗試使用它可能導致不可
@@ -44,8 +44,8 @@ ARM64 ELF hwcaps
 ----------------
 
 大多數 hwcaps 旨在說明通過架構 ID 寄存器(處於 EL0 的用戶空間代碼無法訪問)
-描述的功能的存在。這些 hwcap 通過 ID 寄存器欄位定義，並且應根據 ARM 體系
-結構參考手冊（ARM ARM）中定義的欄位來解釋說明。
+描述的功能的存在。這些 hwcap 通過 ID 寄存器字段定義，並且應根據 ARM 體系
+結構參考手冊（ARM ARM）中定義的字段來解釋說明。
 
 這些 hwcaps 以下面的形式描述::
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
index c2d02cd5017d..7d1f0593d7ca 100644
--- a/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
@@ -31,7 +31,7 @@ Documentation/arch/arm64/legacy_instructions.rst 的中文翻譯
 以下爲正文
 ---------------------------------------------------------------------
 Linux 內核在 arm64 上的移植提供了一個基礎框架，以支持構架中正在被淘汰或已廢棄指令的模擬執行。
-這個基礎框架的代碼使用未定義指令鉤子（hooks）來支持模擬。如果指令存在，它也允許在硬體中啓用該指令。
+這個基礎框架的代碼使用未定義指令鉤子（hooks）來支持模擬。如果指令存在，它也允許在硬件中啓用該指令。
 
 模擬模式可通過寫 sysctl 節點（/proc/sys/abi）來控制。
 不同的執行方式及 sysctl 節點的相應值，解釋如下：
@@ -42,18 +42,18 @@ Linux 內核在 arm64 上的移植提供了一個基礎框架，以支持構架
 
 * Emulate（模擬）
   值： 1
-  使用軟體模擬方式。爲解決軟體遷移問題，這種模擬指令模式的使用是被跟蹤的，並會發出速率限制警告。
+  使用軟件模擬方式。爲解決軟件遷移問題，這種模擬指令模式的使用是被跟蹤的，並會發出速率限制警告。
   它是那些構架中正在被淘汰的指令，如 CP15 barriers（隔離指令），的默認處理方式。
 
-* Hardware Execution（硬體執行）
+* Hardware Execution（硬件執行）
   值： 2
-  雖然標記爲正在被淘汰，但一些實現可能提供硬體執行這些指令的使能/禁用操作。
-  使用硬體執行一般會有更好的性能，但將無法收集運行時對正被淘汰指令的使用統計數據。
+  雖然標記爲正在被淘汰，但一些實現可能提供硬件執行這些指令的使能/禁用操作。
+  使用硬件執行一般會有更好的性能，但將無法收集運行時對正被淘汰指令的使用統計數據。
 
 默認執行模式依賴於指令在構架中狀態。正在被淘汰的指令應該以模擬（Emulate）作爲默認模式，
 而已廢棄的指令必須默認使用未定義（Undef）模式
 
-注意：指令模擬可能無法應對所有情況。更多詳情請參考單獨的指令注釋。
+注意：指令模擬可能無法應對所有情況。更多詳情請參考單獨的指令註釋。
 
 受支持的遺留指令
 -------------
@@ -71,7 +71,7 @@ Linux 內核在 arm64 上的移植提供了一個基礎框架，以支持構架
 節點: /proc/sys/abi/setend
 狀態: 正被淘汰，不推薦使用
 默認執行方式: Emulate (1)*
-註：爲了使能這個特性，系統中的所有 CPU 必須在 EL0 支持混合字節序。
+注：爲了使能這個特性，系統中的所有 CPU 必須在 EL0 支持混合字節序。
 如果一個新的 CPU （不支持混合字節序） 在使能這個特性後被熱插入系統，
 在應用中可能會出現不可預期的結果。
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/memory.txt b/Documentation/translations/zh_TW/arch/arm64/memory.txt
index 0280200e791f..e41c518e71c6 100644
--- a/Documentation/translations/zh_TW/arch/arm64/memory.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/memory.txt
@@ -28,17 +28,17 @@ Documentation/arch/arm64/memory.rst 的中文翻譯
 
 以下爲正文
 ---------------------------------------------------------------------
-		     Linux 在 AArch64 中的內存布局
+		     Linux 在 AArch64 中的內存佈局
 		     ===========================
 
 作者: Catalin Marinas <catalin.marinas@arm.com>
 
-本文檔描述 AArch64 Linux 內核所使用的虛擬內存布局。此構架可以實現
+本文檔描述 AArch64 Linux 內核所使用的虛擬內存佈局。此構架可以實現
 頁大小爲 4KB 的 4 級轉換表和頁大小爲 64KB 的 3 級轉換表。
 
 AArch64 Linux 使用 3 級或 4 級轉換表，其頁大小配置爲 4KB，對於用戶和內核
 分別都有 39-bit (512GB) 或 48-bit (256TB) 的虛擬地址空間。
-對於頁大小爲 64KB的配置，僅使用 2 級轉換表，有 42-bit (4TB) 的虛擬地址空間，但內存布局相同。
+對於頁大小爲 64KB的配置，僅使用 2 級轉換表，有 42-bit (4TB) 的虛擬地址空間，但內存佈局相同。
 
 用戶地址空間的 63:48 位爲 0，而內核地址空間的相應位爲 1。TTBRx 的
 選擇由虛擬地址的 63 位給出。swapper_pg_dir 僅包含內核（全局）映射，
@@ -46,7 +46,7 @@ AArch64 Linux 使用 3 級或 4 級轉換表，其頁大小配置爲 4KB，對
 TTBR1 中，且從不寫入 TTBR0。
 
 
-AArch64 Linux 在頁大小爲 4KB，並使用 3 級轉換表時的內存布局：
+AArch64 Linux 在頁大小爲 4KB，並使用 3 級轉換表時的內存佈局：
 
 起始地址			結束地址			大小		用途
 -----------------------------------------------------------------------
@@ -54,7 +54,7 @@ AArch64 Linux 在頁大小爲 4KB，並使用 3 級轉換表時的內存布局
 ffffff8000000000	ffffffffffffffff	 512GB		內核空間
 
 
-AArch64 Linux 在頁大小爲 4KB，並使用 4 級轉換表時的內存布局：
+AArch64 Linux 在頁大小爲 4KB，並使用 4 級轉換表時的內存佈局：
 
 起始地址			結束地址			大小		用途
 -----------------------------------------------------------------------
@@ -62,7 +62,7 @@ AArch64 Linux 在頁大小爲 4KB，並使用 4 級轉換表時的內存布局
 ffff000000000000	ffffffffffffffff	 256TB		內核空間
 
 
-AArch64 Linux 在頁大小爲 64KB，並使用 2 級轉換表時的內存布局：
+AArch64 Linux 在頁大小爲 64KB，並使用 2 級轉換表時的內存佈局：
 
 起始地址			結束地址			大小		用途
 -----------------------------------------------------------------------
@@ -70,7 +70,7 @@ AArch64 Linux 在頁大小爲 64KB，並使用 2 級轉換表時的內存布局
 fffffc0000000000	ffffffffffffffff	   4TB		內核空間
 
 
-AArch64 Linux 在頁大小爲 64KB，並使用 3 級轉換表時的內存布局：
+AArch64 Linux 在頁大小爲 64KB，並使用 3 級轉換表時的內存佈局：
 
 起始地址			結束地址			大小		用途
 -----------------------------------------------------------------------
@@ -78,7 +78,7 @@ AArch64 Linux 在頁大小爲 64KB，並使用 3 級轉換表時的內存布局
 ffff000000000000	ffffffffffffffff	 256TB		內核空間
 
 
-更詳細的內核虛擬內存布局，請參閱內核啓動信息。
+更詳細的內核虛擬內存佈局，請參閱內核啓動信息。
 
 
 4KB 頁大小的轉換表查找：
diff --git a/Documentation/translations/zh_TW/arch/arm64/perf.rst b/Documentation/translations/zh_TW/arch/arm64/perf.rst
index 645f3944a0f4..405d5f66964f 100644
--- a/Documentation/translations/zh_TW/arch/arm64/perf.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/perf.rst
@@ -59,7 +59,7 @@ EL2（VHE 內核 或 non-VHE 虛擬機監控器）。
 
 KVM 客戶機可能運行在 EL0（用戶空間）和 EL1（內核）。
 
-由於宿主機和客戶機之間重疊的異常級別，我們不能僅僅依靠 PMU 的硬體異
+由於宿主機和客戶機之間重疊的異常級別，我們不能僅僅依靠 PMU 的硬件異
 常過濾機制-因此我們必須啓用/禁用對於客戶機進入和退出的計數。而這在
 VHE 和 non-VHE 系統上表現不同。
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
index f6f41835a54a..70371807ca83 100644
--- a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
@@ -28,39 +28,39 @@ Documentation/arch/arm64/silicon-errata.rst 的中文翻譯
 
 以下爲正文
 ---------------------------------------------------------------------
-                晶片勘誤和軟體補救措施
+                芯片勘誤和軟件補救措施
                 ==================
 
 作者: Will Deacon <will.deacon@arm.com>
 日期: 2015年11月27日
 
-一個不幸的現實：硬體經常帶有一些所謂的「瑕疵（errata）」，導致其在
-某些特定情況下會違背構架定義的行爲。就基於 ARM 的硬體而言，這些瑕疵
+一個不幸的現實：硬件經常帶有一些所謂的“瑕疵（errata）”，導致其在
+某些特定情況下會違背構架定義的行爲。就基於 ARM 的硬件而言，這些瑕疵
 大體可分爲以下幾類：
 
   A 類：無可行補救措施的嚴重缺陷。
   B 類：有可接受的補救措施的重大或嚴重缺陷。
   C 類：在正常操作中不會顯現的小瑕疵。
 
-更多資訊，請在 infocenter.arm.com （需註冊）中查閱「軟體開發者勘誤
-筆記」（「Software Developers Errata Notice」）文檔。
+更多資訊，請在 infocenter.arm.com （需註冊）中查閱“軟件開發者勘誤
+筆記”（“Software Developers Errata Notice”）文檔。
 
-對於 Linux 而言，B 類缺陷可能需要作業系統的某些特別處理。例如，避免
+對於 Linux 而言，B 類缺陷可能需要操作系統的某些特別處理。例如，避免
 一個特殊的代碼序列，或是以一種特定的方式配置處理器。在某種不太常見的
 情況下，爲將 A 類缺陷當作 C 類處理，可能需要用類似的手段。這些手段被
-統稱爲「軟體補救措施」，且僅在少數情況需要（例如，那些需要一個運行在
+統稱爲“軟件補救措施”，且僅在少數情況需要（例如，那些需要一個運行在
 非安全異常級的補救措施 *並且* 能被 Linux 觸發的情況）。
 
-對於尚在討論中的可能對未受瑕疵影響的系統產生干擾的軟體補救措施，有一個
-相應的內核配置（Kconfig）選項被加在 「內核特性（Kernel Features）」->
-「基於可選方法框架的 ARM 瑕疵補救措施（ARM errata workarounds via
+對於尚在討論中的可能對未受瑕疵影響的系統產生干擾的軟件補救措施，有一個
+相應的內核配置（Kconfig）選項被加在 “內核特性（Kernel Features）”->
+“基於可選方法框架的 ARM 瑕疵補救措施（ARM errata workarounds via
 the alternatives framework）"。這些選項被默認開啓，若探測到受影響的CPU，
 補丁將在運行時被使用。至於對系統運行影響較小的補救措施，內核配置選項
-並不存在，且代碼以某種規避瑕疵的方式被構造（帶注釋爲宜）。
+並不存在，且代碼以某種規避瑕疵的方式被構造（帶註釋爲宜）。
 
-這種做法對於在任意內核原始碼樹中準確地判斷出哪個瑕疵已被軟體方法所補救
-稍微有點麻煩，所以在 Linux 內核中此文件作爲軟體補救措施的註冊表，
-並將在新的軟體補救措施被提交和向後移植（backported）到穩定內核時被更新。
+這種做法對於在任意內核源代碼樹中準確地判斷出哪個瑕疵已被軟件方法所補救
+稍微有點麻煩，所以在 Linux 內核中此文件作爲軟件補救措施的註冊表，
+並將在新的軟件補救措施被提交和向後移植（backported）到穩定內核時被更新。
 
 | 實現者         | 受影響的組件    | 勘誤編號        | 內核配置                |
 +----------------+-----------------+-----------------+-------------------------+
diff --git a/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
index c0be1d1e0d01..9812d99549ba 100644
--- a/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
@@ -36,14 +36,14 @@ Documentation/arch/arm64/tagged-pointers.rst 的中文翻譯
 AArch64 Linux 中的潛在用途。
 
 內核提供的地址轉換表配置使通過 TTBR0 完成的虛擬地址轉換（即用戶空間
-映射），其虛擬地址的最高 8 位（63:56）會被轉換硬體所忽略。這種機制
-讓這些位可供應用程式自由使用，其注意事項如下：
+映射），其虛擬地址的最高 8 位（63:56）會被轉換硬件所忽略。這種機制
+讓這些位可供應用程序自由使用，其注意事項如下：
 
 	(1) 內核要求所有傳遞到 EL1 的用戶空間地址帶有 0x00 標記。
-	    這意味著任何攜帶用戶空間虛擬地址的系統調用（syscall）
+	    這意味着任何攜帶用戶空間虛擬地址的系統調用（syscall）
 	    參數 *必須* 在陷入內核前使它們的最高字節被清零。
 
-	(2) 非零標記在傳遞信號時不被保存。這意味著在應用程式中利用了
+	(2) 非零標記在傳遞信號時不被保存。這意味着在應用程序中利用了
 	    標記的信號處理函數無法依賴 siginfo_t 的用戶空間虛擬
 	    地址所攜帶的包含其內部域信息的標記。此規則的一個例外是
 	    當信號是在調試觀察點的異常處理程序中產生的，此時標記的
@@ -53,5 +53,5 @@ AArch64 Linux 中的潛在用途。
 	    的高字節，C 編譯器很可能無法判斷它們是不同的。
 
 此構架會阻止對帶標記的 PC 指針的利用，因此在異常返回時，其高字節
-將被設置成一個爲 「55」 的擴展符。
+將被設置成一個爲 “55” 的擴展符。
 
diff --git a/Documentation/translations/zh_TW/arch/index.rst b/Documentation/translations/zh_TW/arch/index.rst
new file mode 100644
index 000000000000..42cdd882e40d
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/index.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+處理器體系結構
+==============
+
+以下文檔提供了具體架構實現的編程細節。
+
+.. toctree::
+   :maxdepth: 2
+
+   mips/index
+   arm64/index
+   ../riscv/index
+   openrisc/index
+   parisc/index
+   loongarch/index
+
+TODOList:
+
+* arm/index
+* ia64/index
+* m68k/index
+* nios2/index
+* powerpc/index
+* s390/index
+* sh/index
+* sparc/index
+* x86/index
+* xtensa/index
+
diff --git a/Documentation/translations/zh_TW/arch/loongarch/booting.rst b/Documentation/translations/zh_TW/arch/loongarch/booting.rst
new file mode 100644
index 000000000000..88291090cea1
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/loongarch/booting.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/loongarch/booting.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+====================
+啓動 Linux/LoongArch
+====================
+
+:作者: 司延騰 <siyanteng@loongson.cn>
+:日期: 2022年11月18日
+
+BootLoader傳遞給內核的信息
+==========================
+
+LoongArch支持ACPI和FDT啓動，需要傳遞給內核的信息包括memmap、initrd、cmdline、可
+選的ACPI/FDT表等。
+
+內核在 `kernel_entry` 入口處被傳遞以下參數:
+
+      - a0 = efi_boot: `efi_boot` 是一個標誌，表示這個啓動環境是否完全符合UEFI
+        的要求。
+
+      - a1 = cmdline: `cmdline` 是一個指向內核命令行的指針。
+
+      - a2 = systemtable: `systemtable` 指向EFI的系統表，在這個階段涉及的所有
+        指針都是物理地址。
+
+Linux/LoongArch內核鏡像文件頭
+=============================
+
+內核鏡像是EFI鏡像。作爲PE文件，它們有一個64字節的頭部結構體，如下所示::
+
+	u32	MZ_MAGIC                /* "MZ", MS-DOS 頭 */
+	u32	res0 = 0                /* 保留 */
+	u64	kernel_entry            /* 內核入口點 */
+	u64	_end - _text            /* 內核鏡像有效大小 */
+	u64	load_offset             /* 加載內核鏡像相對內存起始地址的偏移量 */
+	u64	res1 = 0                /* 保留 */
+	u64	res2 = 0                /* 保留 */
+	u64	res3 = 0                /* 保留 */
+	u32	LINUX_PE_MAGIC          /* 魔術數 */
+	u32	pe_header - _head       /* 到PE頭的偏移量 */
+
diff --git a/Documentation/translations/zh_TW/arch/loongarch/features.rst b/Documentation/translations/zh_TW/arch/loongarch/features.rst
new file mode 100644
index 000000000000..b64e430f55ae
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/loongarch/features.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/loongarch/features.rst
+:Translator: Huacai Chen <chenhuacai@loongson.cn>
+
+.. kernel-feat:: $srctree/Documentation/features loongarch
+
diff --git a/Documentation/translations/zh_TW/arch/loongarch/index.rst b/Documentation/translations/zh_TW/arch/loongarch/index.rst
new file mode 100644
index 000000000000..7281e050fe1c
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/loongarch/index.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/loongarch/index.rst
+:Translator: Huacai Chen <chenhuacai@loongson.cn>
+
+=================
+LoongArch體系結構
+=================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   introduction
+   booting
+   irq-chip-model
+
+   features
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/translations/zh_TW/arch/loongarch/introduction.rst b/Documentation/translations/zh_TW/arch/loongarch/introduction.rst
new file mode 100644
index 000000000000..ff2402962bf6
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/loongarch/introduction.rst
@@ -0,0 +1,354 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/loongarch/introduction.rst
+:Translator: Huacai Chen <chenhuacai@loongson.cn>
+
+=============
+LoongArch介紹
+=============
+
+LoongArch是一種新的RISC ISA，在一定程度上類似於MIPS和RISC-V。LoongArch指令集
+包括一個精簡32位版（LA32R）、一個標準32位版（LA32S）、一個64位版（LA64）。
+LoongArch定義了四個特權級（PLV0~PLV3），其中PLV0是最高特權級，用於內核；而PLV3
+是最低特權級，用於應用程序。本文檔介紹了LoongArch的寄存器、基礎指令集、虛擬內
+存以及其他一些主題。
+
+寄存器
+======
+
+LoongArch的寄存器包括通用寄存器（GPRs）、浮點寄存器（FPRs）、向量寄存器（VRs）
+和用於特權模式（PLV0）的控制狀態寄存器（CSRs）。
+
+通用寄存器
+----------
+
+LoongArch包括32個通用寄存器（ ``$r0`` ~ ``$r31`` ），LA32中每個寄存器爲32位寬，
+LA64中每個寄存器爲64位寬。 ``$r0`` 的內容總是固定爲0，而其他寄存器在體系結構層面
+沒有特殊功能。（ ``$r1`` 算是一個例外，在BL指令中固定用作鏈接返回寄存器。）
+
+內核使用了一套LoongArch寄存器約定，定義在LoongArch ELF psABI規範中，詳細描述參見
+:ref:`參考文獻 <loongarch-references-zh_TW>`:
+
+================= =============== =================== ==========
+寄存器名          別名            用途                跨調用保持
+================= =============== =================== ==========
+``$r0``           ``$zero``       常量0               不使用
+``$r1``           ``$ra``         返回地址            否
+``$r2``           ``$tp``         TLS/線程信息指針    不使用
+``$r3``           ``$sp``         棧指針              是
+``$r4``-``$r11``  ``$a0``-``$a7`` 參數寄存器          否
+``$r4``-``$r5``   ``$v0``-``$v1`` 返回值              否
+``$r12``-``$r20`` ``$t0``-``$t8`` 臨時寄存器          否
+``$r21``          ``$u0``         每CPU變量基地址     不使用
+``$r22``          ``$fp``         幀指針              是
+``$r23``-``$r31`` ``$s0``-``$s8`` 靜態寄存器          是
+================= =============== =================== ==========
+
+.. note::
+    注意： ``$r21`` 寄存器在ELF psABI中保留未使用，但是在Linux內核用於保
+    存每CPU變量基地址。該寄存器沒有ABI命名，不過在內核中稱爲 ``$u0`` 。在
+    一些遺留代碼中有時可能見到 ``$v0`` 和 ``$v1`` ，它們是 ``$a0`` 和
+    ``$a1`` 的別名，屬於已經廢棄的用法。
+
+浮點寄存器
+----------
+
+當系統中存在FPU時，LoongArch有32個浮點寄存器（ ``$f0`` ~ ``$f31`` ）。在LA64
+的CPU核上，每個寄存器均爲64位寬。
+
+浮點寄存器的使用約定與LoongArch ELF psABI規範的描述相同：
+
+================= ================== =================== ==========
+寄存器名          別名               用途                跨調用保持
+================= ================== =================== ==========
+``$f0``-``$f7``   ``$fa0``-``$fa7``  參數寄存器          否
+``$f0``-``$f1``   ``$fv0``-``$fv1``  返回值              否
+``$f8``-``$f23``  ``$ft0``-``$ft15`` 臨時寄存器          否
+``$f24``-``$f31`` ``$fs0``-``$fs7``  靜態寄存器          是
+================= ================== =================== ==========
+
+.. note::
+    注意：在一些遺留代碼中有時可能見到 ``$fv0`` 和 ``$fv1`` ，它們是
+    ``$fa0`` 和 ``$fa1`` 的別名，屬於已經廢棄的用法。
+
+
+向量寄存器
+----------
+
+LoongArch現有兩種向量擴展：
+
+- 128位向量擴展LSX（全稱Loongson SIMD eXtention），
+- 256位向量擴展LASX（全稱Loongson Advanced SIMD eXtention）。
+
+LSX使用 ``$v0`` ~ ``$v31`` 向量寄存器，而LASX則使用 ``$x0`` ~ ``$x31`` 。
+
+浮點寄存器和向量寄存器是複用的，比如：在一個實現了LSX和LASX的核上， ``$x0`` 的
+低128位與 ``$v0`` 共用， ``$v0`` 的低64位與 ``$f0`` 共用，其他寄存器依此類推。
+
+控制狀態寄存器
+--------------
+
+控制狀態寄存器只能在特權模式（PLV0）下訪問:
+
+================= ==================================== ==========
+地址              全稱描述                             簡稱
+================= ==================================== ==========
+0x0               當前模式信息                         CRMD
+0x1               異常前模式信息                       PRMD
+0x2               擴展部件使能                         EUEN
+0x3               雜項控制                             MISC
+0x4               異常配置                             ECFG
+0x5               異常狀態                             ESTAT
+0x6               異常返回地址                         ERA
+0x7               出錯(Faulting)虛擬地址               BADV
+0x8               出錯(Faulting)指令字                 BADI
+0xC               異常入口地址                         EENTRY
+0x10              TLB索引                              TLBIDX
+0x11              TLB表項高位                          TLBEHI
+0x12              TLB表項低位0                         TLBELO0
+0x13              TLB表項低位1                         TLBELO1
+0x18              地址空間標識符                       ASID
+0x19              低半地址空間頁全局目錄基址           PGDL
+0x1A              高半地址空間頁全局目錄基址           PGDH
+0x1B              頁全局目錄基址                       PGD
+0x1C              頁表遍歷控制低半部分                 PWCL
+0x1D              頁表遍歷控制高半部分                 PWCH
+0x1E              STLB頁大小                           STLBPS
+0x1F              縮減虛地址配置                       RVACFG
+0x20              CPU編號                              CPUID
+0x21              特權資源配置信息1                    PRCFG1
+0x22              特權資源配置信息2                    PRCFG2
+0x23              特權資源配置信息3                    PRCFG3
+0x30+n (0≤n≤15)   數據保存寄存器                       SAVEn
+0x40              定時器編號                           TID
+0x41              定時器配置                           TCFG
+0x42              定時器值                             TVAL
+0x43              計時器補償                           CNTC
+0x44              定時器中斷清除                       TICLR
+0x60              LLBit相關控制                        LLBCTL
+0x80              實現相關控制1                        IMPCTL1
+0x81              實現相關控制2                        IMPCTL2
+0x88              TLB重填異常入口地址                  TLBRENTRY
+0x89              TLB重填異常出錯(Faulting)虛地址      TLBRBADV
+0x8A              TLB重填異常返回地址                  TLBRERA
+0x8B              TLB重填異常數據保存                  TLBRSAVE
+0x8C              TLB重填異常表項低位0                 TLBRELO0
+0x8D              TLB重填異常表項低位1                 TLBRELO1
+0x8E              TLB重填異常表項高位                  TLBEHI
+0x8F              TLB重填異常前模式信息                TLBRPRMD
+0x90              機器錯誤控制                         MERRCTL
+0x91              機器錯誤信息1                        MERRINFO1
+0x92              機器錯誤信息2                        MERRINFO2
+0x93              機器錯誤異常入口地址                 MERRENTRY
+0x94              機器錯誤異常返回地址                 MERRERA
+0x95              機器錯誤異常數據保存                 MERRSAVE
+0x98              高速緩存標籤                         CTAG
+0x180+n (0≤n≤3)   直接映射配置窗口n                    DMWn
+0x200+2n (0≤n≤31) 性能監測配置n                        PMCFGn
+0x201+2n (0≤n≤31) 性能監測計數器n                      PMCNTn
+0x300             內存讀寫監視點整體控制               MWPC
+0x301             內存讀寫監視點整體狀態               MWPS
+0x310+8n (0≤n≤7)  內存讀寫監視點n配置1                 MWPnCFG1
+0x311+8n (0≤n≤7)  內存讀寫監視點n配置2                 MWPnCFG2
+0x312+8n (0≤n≤7)  內存讀寫監視點n配置3                 MWPnCFG3
+0x313+8n (0≤n≤7)  內存讀寫監視點n配置4                 MWPnCFG4
+0x380             取指監視點整體控制                   FWPC
+0x381             取指監視點整體狀態                   FWPS
+0x390+8n (0≤n≤7)  取指監視點n配置1                     FWPnCFG1
+0x391+8n (0≤n≤7)  取指監視點n配置2                     FWPnCFG2
+0x392+8n (0≤n≤7)  取指監視點n配置3                     FWPnCFG3
+0x393+8n (0≤n≤7)  取指監視點n配置4                     FWPnCFG4
+0x500             調試寄存器                           DBG
+0x501             調試異常返回地址                     DERA
+0x502             調試數據保存                         DSAVE
+================= ==================================== ==========
+
+ERA，TLBRERA，MERRERA和DERA有時也分別稱爲EPC，TLBREPC，MERREPC和DEPC。
+
+基礎指令集
+==========
+
+指令格式
+--------
+
+LoongArch的指令字長爲32位，一共有9種基本指令格式（以及一些變體）:
+
+=========== ==========================
+格式名稱    指令構成
+=========== ==========================
+2R          Opcode + Rj + Rd
+3R          Opcode + Rk + Rj + Rd
+4R          Opcode + Ra + Rk + Rj + Rd
+2RI8        Opcode + I8 + Rj + Rd
+2RI12       Opcode + I12 + Rj + Rd
+2RI14       Opcode + I14 + Rj + Rd
+2RI16       Opcode + I16 + Rj + Rd
+1RI21       Opcode + I21L + Rj + I21H
+I26         Opcode + I26L + I26H
+=========== ==========================
+
+Opcode是指令操作碼，Rj和Rk是源操作數（寄存器），Rd是目標操作數（寄存器），Ra是
+4R-type格式特有的附加操作數（寄存器）。I8/I12/I14/I16/I21/I26分別是8位/12位/14位/
+16位/21位/26位的立即數。其中較長的21位和26位立即數在指令字中被分割爲高位部分與低位
+部分，所以你們在這裏的格式描述中能夠看到I21L/I21H和I26L/I26H這樣帶後綴的表述。
+
+指令列表
+--------
+
+爲了簡便起見，我們在此只羅列一下指令名稱（助記符），需要詳細信息請閱讀
+:ref:`參考文獻 <loongarch-references-zh_TW>` 中的文檔。
+
+1. 算術運算指令::
+
+    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
+    SLT SLTU SLTI SLTUI
+    AND OR NOR XOR ANDN ORN ANDI ORI XORI
+    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
+    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
+    PCADDI PCADDU12I PCADDU18I
+    LU12I.W LU32I.D LU52I.D ADDU16I.D
+
+2. 移位運算指令::
+
+    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
+    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
+
+3. 位域操作指令::
+
+    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
+    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
+    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BITREV.W BITREV.D
+    MASKEQZ MASKNEZ
+
+4. 分支轉移指令::
+
+    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
+
+5. 訪存讀寫指令::
+
+    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
+    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
+    LDPTR.W LDPTR.D STPTR.W STPTR.D
+    PRELD PRELDX
+
+6. 原子操作指令::
+
+    LL.W SC.W LL.D SC.D
+    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXOR.W AMXOR.D
+    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
+
+7. 柵障指令::
+
+    IBAR DBAR
+
+8. 特殊指令::
+
+    SYSCALL BREAK CPUCFG NOP IDLE ERTN(ERET) DBCL(DBGCALL) RDTIMEL.W RDTIMEH.W RDTIME.D
+    ASRTLE.D ASRTGT.D
+
+9. 特權指令::
+
+    CSRRD CSRWR CSRXCHG
+    IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.W IOCSRWR.D
+    CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR LDPTE
+
+虛擬內存
+========
+
+LoongArch可以使用直接映射虛擬內存和分頁映射虛擬內存。
+
+直接映射虛擬內存通過CSR.DMWn（n=0~3）來進行配置，虛擬地址（VA）和物理地址（PA）
+之間有簡單的映射關係::
+
+ VA = PA + 固定偏移
+
+分頁映射的虛擬地址（VA）和物理地址（PA）有任意的映射關係，這種關係記錄在TLB和頁
+表中。LoongArch的TLB包括一個全相聯的MTLB（Multiple Page Size TLB，多樣頁大小TLB）
+和一個組相聯的STLB（Single Page Size TLB，單一頁大小TLB）。
+
+缺省狀態下，LA32的整個虛擬地址空間配置如下：
+
+============ =========================== ===========================
+區段名       地址範圍                    屬性
+============ =========================== ===========================
+``UVRANGE``  ``0x00000000 - 0x7FFFFFFF`` 分頁映射, 可緩存, PLV0~3
+``KPRANGE0`` ``0x80000000 - 0x9FFFFFFF`` 直接映射, 非緩存, PLV0
+``KPRANGE1`` ``0xA0000000 - 0xBFFFFFFF`` 直接映射, 可緩存, PLV0
+``KVRANGE``  ``0xC0000000 - 0xFFFFFFFF`` 分頁映射, 可緩存, PLV0
+============ =========================== ===========================
+
+用戶態（PLV3）只能訪問UVRANGE，對於直接映射的KPRANGE0和KPRANGE1，將虛擬地址的第
+30~31位清零就等於物理地址。例如：物理地址0x00001000對應的非緩存直接映射虛擬地址
+是0x80001000，而其可緩存直接映射虛擬地址是0xA0001000。
+
+缺省狀態下，LA64的整個虛擬地址空間配置如下：
+
+============ ====================== ==================================
+區段名       地址範圍               屬性
+============ ====================== ==================================
+``XUVRANGE`` ``0x0000000000000000 - 分頁映射, 可緩存, PLV0~3
+             0x3FFFFFFFFFFFFFFF``
+``XSPRANGE`` ``0x4000000000000000 - 直接映射, 可緩存 / 非緩存, PLV0
+             0x7FFFFFFFFFFFFFFF``
+``XKPRANGE`` ``0x8000000000000000 - 直接映射, 可緩存 / 非緩存, PLV0
+             0xBFFFFFFFFFFFFFFF``
+``XKVRANGE`` ``0xC000000000000000 - 分頁映射, 可緩存, PLV0
+             0xFFFFFFFFFFFFFFFF``
+============ ====================== ==================================
+
+用戶態（PLV3）只能訪問XUVRANGE，對於直接映射的XSPRANGE和XKPRANGE，將虛擬地址的第
+60~63位清零就等於物理地址，而其緩存屬性是通過虛擬地址的第60~61位配置的（0表示強序
+非緩存，1表示一致可緩存，2表示弱序非緩存）。
+
+目前，我們僅用XKPRANGE來進行直接映射，XSPRANGE保留給以後用。
+
+此處給出一個直接映射的例子：物理地址0x00000000_00001000的強序非緩存直接映射虛擬地址
+（在XKPRANGE中）是0x80000000_00001000，其一致可緩存直接映射虛擬地址（在XKPRANGE中）
+是0x90000000_00001000，而其弱序非緩存直接映射虛擬地址（在XKPRANGE中）是0xA0000000_
+00001000。
+
+Loongson與LoongArch的關係
+=========================
+
+LoongArch是一種RISC指令集架構（ISA），不同於現存的任何一種ISA，而Loongson（即龍
+芯）是一個處理器家族。龍芯包括三個系列：Loongson-1（龍芯1號）是32位處理器系列，
+Loongson-2（龍芯2號）是低端64位處理器系列，而Loongson-3（龍芯3號）是高端64位處理
+器系列。舊的龍芯處理器基於MIPS架構，而新的龍芯處理器基於LoongArch架構。以龍芯3號
+爲例：龍芯3A1000/3B1500/3A2000/3A3000/3A4000都是兼容MIPS的，而龍芯3A5000（以及將
+來的型號）都是基於LoongArch的。
+
+.. _loongarch-references-zh_TW:
+
+參考文獻
+========
+
+Loongson官方網站（龍芯中科技術股份有限公司）：
+
+  http://www.loongson.cn/
+
+Loongson與LoongArch的開發者網站（軟件與文檔資源）：
+
+  http://www.loongnix.cn/
+
+  https://github.com/loongson/
+
+  https://loongson.github.io/LoongArch-Documentation/
+
+LoongArch指令集架構的文檔：
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-Vol1-v1.02-CN.pdf （中文版）
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-Vol1-v1.02-EN.pdf （英文版）
+
+LoongArch的ELF psABI文檔：
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-ELF-ABI-v2.00-CN.pdf （中文版）
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/LoongArch-ELF-ABI-v2.00-EN.pdf （英文版）
+
+Loongson與LoongArch的Linux內核源碼倉庫：
+
+  https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
+
diff --git a/Documentation/translations/zh_TW/arch/loongarch/irq-chip-model.rst b/Documentation/translations/zh_TW/arch/loongarch/irq-chip-model.rst
new file mode 100644
index 000000000000..dbe9595bbf16
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/loongarch/irq-chip-model.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/loongarch/irq-chip-model.rst
+:Translator: Huacai Chen <chenhuacai@loongson.cn>
+
+==================================
+LoongArch的IRQ芯片模型（層級關係）
+==================================
+
+目前，基於LoongArch的處理器（如龍芯3A5000）只能與LS7A芯片組配合工作。LoongArch計算機
+中的中斷控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt Controller）、LIOINTC（
+Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt Controller）、
+HTVECINTC（Hyper-Transport Vector Interrupt Controller）、PCH-PIC（LS7A芯片組的主中
+斷控制器）、PCH-LPC（LS7A芯片組的LPC中斷控制器）和PCH-MSI（MSI中斷控制器）。
+
+CPUINTC是一種CPU內部的每個核本地的中斷控制器，LIOINTC/EIOINTC/HTVECINTC是CPU內部的
+全局中斷控制器（每個芯片一個，所有核共享），而PCH-PIC/PCH-LPC/PCH-MSI是CPU外部的中
+斷控制器（在配套芯片組裏面）。這些中斷控制器（或者說IRQ芯片）以一種層次樹的組織形式
+級聯在一起，一共有兩種層級關係模型（傳統IRQ模型和擴展IRQ模型）。
+
+傳統IRQ模型
+===========
+
+在這種模型裏面，IPI（Inter-Processor Interrupt）和CPU本地時鐘中斷直接發送到CPUINTC，
+CPU串口（UARTs）中斷髮送到LIOINTC，而其他所有設備的中斷則分別發送到所連接的PCH-PIC/
+PCH-LPC/PCH-MSI，然後被HTVECINTC統一收集，再發送到LIOINTC，最後到達CPUINTC::
+
+     +-----+     +---------+     +-------+
+     | IPI | --> | CPUINTC | <-- | Timer |
+     +-----+     +---------+     +-------+
+                      ^
+                      |
+                 +---------+     +-------+
+                 | LIOINTC | <-- | UARTs |
+                 +---------+     +-------+
+                      ^
+                      |
+                +-----------+
+                | HTVECINTC |
+                +-----------+
+                 ^         ^
+                 |         |
+           +---------+ +---------+
+           | PCH-PIC | | PCH-MSI |
+           +---------+ +---------+
+             ^     ^           ^
+             |     |           |
+     +---------+ +---------+ +---------+
+     | PCH-LPC | | Devices | | Devices |
+     +---------+ +---------+ +---------+
+          ^
+          |
+     +---------+
+     | Devices |
+     +---------+
+
+擴展IRQ模型
+===========
+
+在這種模型裏面，IPI（Inter-Processor Interrupt）和CPU本地時鐘中斷直接發送到CPUINTC，
+CPU串口（UARTs）中斷髮送到LIOINTC，而其他所有設備的中斷則分別發送到所連接的PCH-PIC/
+PCH-LPC/PCH-MSI，然後被EIOINTC統一收集，再直接到達CPUINTC::
+
+          +-----+     +---------+     +-------+
+          | IPI | --> | CPUINTC | <-- | Timer |
+          +-----+     +---------+     +-------+
+                       ^       ^
+                       |       |
+                +---------+ +---------+     +-------+
+                | EIOINTC | | LIOINTC | <-- | UARTs |
+                +---------+ +---------+     +-------+
+                 ^       ^
+                 |       |
+          +---------+ +---------+
+          | PCH-PIC | | PCH-MSI |
+          +---------+ +---------+
+            ^     ^           ^
+            |     |           |
+    +---------+ +---------+ +---------+
+    | PCH-LPC | | Devices | | Devices |
+    +---------+ +---------+ +---------+
+         ^
+         |
+    +---------+
+    | Devices |
+    +---------+
+
+ACPI相關的定義
+==============
+
+CPUINTC::
+
+  ACPI_MADT_TYPE_CORE_PIC;
+  struct acpi_madt_core_pic;
+  enum acpi_madt_core_pic_version;
+
+LIOINTC::
+
+  ACPI_MADT_TYPE_LIO_PIC;
+  struct acpi_madt_lio_pic;
+  enum acpi_madt_lio_pic_version;
+
+EIOINTC::
+
+  ACPI_MADT_TYPE_EIO_PIC;
+  struct acpi_madt_eio_pic;
+  enum acpi_madt_eio_pic_version;
+
+HTVECINTC::
+
+  ACPI_MADT_TYPE_HT_PIC;
+  struct acpi_madt_ht_pic;
+  enum acpi_madt_ht_pic_version;
+
+PCH-PIC::
+
+  ACPI_MADT_TYPE_BIO_PIC;
+  struct acpi_madt_bio_pic;
+  enum acpi_madt_bio_pic_version;
+
+PCH-MSI::
+
+  ACPI_MADT_TYPE_MSI_PIC;
+  struct acpi_madt_msi_pic;
+  enum acpi_madt_msi_pic_version;
+
+PCH-LPC::
+
+  ACPI_MADT_TYPE_LPC_PIC;
+  struct acpi_madt_lpc_pic;
+  enum acpi_madt_lpc_pic_version;
+
+參考文獻
+========
+
+龍芯3A5000的文檔：
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-3A5000-usermanual-1.02-CN.pdf (中文版)
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-3A5000-usermanual-1.02-EN.pdf (英文版)
+
+龍芯LS7A芯片組的文檔：
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-7A1000-usermanual-2.00-CN.pdf (中文版)
+
+  https://github.com/loongson/LoongArch-Documentation/releases/latest/download/Loongson-7A1000-usermanual-2.00-EN.pdf (英文版)
+
+.. note::
+    - CPUINTC：即《龍芯架構參考手冊卷一》第7.4節所描述的CSR.ECFG/CSR.ESTAT寄存器及其
+      中斷控制邏輯；
+    - LIOINTC：即《龍芯3A5000處理器使用手冊》第11.1節所描述的“傳統I/O中斷”；
+    - EIOINTC：即《龍芯3A5000處理器使用手冊》第11.2節所描述的“擴展I/O中斷”；
+    - HTVECINTC：即《龍芯3A5000處理器使用手冊》第14.3節所描述的“HyperTransport中斷”；
+    - PCH-PIC/PCH-MSI：即《龍芯7A1000橋片用戶手冊》第5章所描述的“中斷控制器”；
+    - PCH-LPC：即《龍芯7A1000橋片用戶手冊》第24.3節所描述的“LPC中斷”。
+
diff --git a/Documentation/translations/zh_TW/arch/mips/booting.rst b/Documentation/translations/zh_TW/arch/mips/booting.rst
new file mode 100644
index 000000000000..7e104abf5a51
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/mips/booting.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/mips/booting.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_booting:
+
+BMIPS設備樹引導
+------------------------
+
+  一些bootloaders只支持在內核鏡像開始地址處的單一入口點。而其它
+  bootloaders將跳轉到ELF的開始地址處。兩種方案都支持的；因爲
+  CONFIG_BOOT_RAW=y and CONFIG_NO_EXCEPT_FILL=y, 所以第一條指令
+  會立即跳轉到kernel_entry()入口處執行。
+
+  與arch/arm情況(b)類似，dt感知的引導加載程序需要設置以下寄存器:
+
+         a0 : 0
+
+         a1 : 0xffffffff
+
+         a2 : RAM中指向設備樹塊的物理指針(在chapterII中定義)。
+              設備樹可以位於前512MB物理地址空間(0x00000000 -
+              0x1fffffff)的任何位置，以64位邊界對齊。
+
+  傳統bootloaders不會使用這樣的約定，並且它們不傳入DT塊。
+  在這種情況下，Linux將通過選中CONFIG_DT_*查找DTB。
+
+  以上約定只在32位系統中定義，因爲目前沒有任何64位的BMIPS實現。
+
diff --git a/Documentation/translations/zh_TW/arch/mips/features.rst b/Documentation/translations/zh_TW/arch/mips/features.rst
new file mode 100644
index 000000000000..f69410420035
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/mips/features.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/mips/features.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_features:
+
+.. kernel-feat:: $srctree/Documentation/features mips
+
diff --git a/Documentation/translations/zh_TW/arch/mips/index.rst b/Documentation/translations/zh_TW/arch/mips/index.rst
new file mode 100644
index 000000000000..4b7d28806489
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/mips/index.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/mips/index.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+===========================
+MIPS特性文檔
+===========================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   booting
+   ingenic-tcu
+
+   features
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/translations/zh_TW/arch/mips/ingenic-tcu.rst b/Documentation/translations/zh_TW/arch/mips/ingenic-tcu.rst
new file mode 100644
index 000000000000..4385c0f3e9cd
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/mips/ingenic-tcu.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/mips/ingenic-tcu.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_ingenic-tcu:
+
+===============================================
+君正 JZ47xx SoC定時器/計數器硬件單元
+===============================================
+
+君正 JZ47xx SoC中的定時器/計數器單元(TCU)是一個多功能硬件塊。它有多達
+8個通道，可以用作計數器，計時器，或脈衝寬度調製器。
+
+- JZ4725B, JZ4750, JZ4755 只有６個TCU通道。其它SoC都有８個通道。
+
+- JZ4725B引入了一個獨立的通道，稱爲操作系統計時器(OST)。這是一個32位可
+  編程定時器。在JZ4760B及以上型號上，它是64位的。
+
+- 每個TCU通道都有自己的時鐘源，可以通過 TCSR 寄存器設置通道的父級時鐘
+  源（pclk、ext、rtc）、開關以及分頻。
+
+    - 看門狗和OST硬件模塊在它們的寄存器空間中也有相同形式的TCSR寄存器。
+    - 用於關閉/開啓的 TCU 寄存器也可以關閉/開啓看門狗和 OST 時鐘。
+
+- 每個TCU通道在兩種模式的其中一種模式下運行：
+
+    - 模式 TCU1：通道無法在睡眠模式下運行，但更易於操作。
+    - 模式 TCU2：通道可以在睡眠模式下運行，但操作比 TCU1 通道複雜一些。
+
+- 每個 TCU 通道的模式取決於使用的SoC：
+
+    - 在最老的SoC（高於JZ4740），八個通道都運行在TCU1模式。
+    - 在 JZ4725B，通道5運行在TCU2,其它通道則運行在TCU1。
+    - 在最新的SoC（JZ4750及之後），通道1-2運行在TCU2，其它通道則運行
+      在TCU1。
+
+- 每個通道都可以生成中斷。有些通道共享一條中斷線，而有些沒有，其在SoC型
+  號之間的變更：
+
+    - 在很老的SoC（JZ4740及更低），通道0和通道1有它們自己的中斷線；通
+      道2-7共享最後一條中斷線。
+    - 在 JZ4725B，通道0有它自己的中斷線；通道1-5共享一條中斷線；OST
+      使用最後一條中斷線。
+    - 在比較新的SoC（JZ4750及以後），通道5有它自己的中斷線；通
+      道0-4和（如果是8通道）6-7全部共享一條中斷線；OST使用最後一條中
+      斷線。
+
+實現
+====
+
+TCU硬件的功能分佈在多個驅動程序：
+
+==============      ===================================
+時鐘                drivers/clk/ingenic/tcu.c
+中斷                drivers/irqchip/irq-ingenic-tcu.c
+定時器              drivers/clocksource/ingenic-timer.c
+OST                 drivers/clocksource/ingenic-ost.c
+脈衝寬度調製器      drivers/pwm/pwm-jz4740.c
+看門狗              drivers/watchdog/jz4740_wdt.c
+==============      ===================================
+
+因爲可以從相同的寄存器控制屬於不同驅動程序和框架的TCU的各種功能，所以
+所有這些驅動程序都通過相同的控制總線通用接口訪問它們的寄存器。
+
+有關TCU驅動程序的設備樹綁定的更多信息，請參閱:
+Documentation/devicetree/bindings/timer/ingenic,tcu.yaml.
+
diff --git a/Documentation/translations/zh_TW/arch/openrisc/index.rst b/Documentation/translations/zh_TW/arch/openrisc/index.rst
new file mode 100644
index 000000000000..7585960783fc
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/openrisc/index.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/openrisc/index.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_openrisc_index:
+
+=================
+OpenRISC 體系架構
+=================
+
+.. toctree::
+   :maxdepth: 2
+
+   openrisc_port
+   todo
+
+Todolist:
+    features
+
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
new file mode 100644
index 000000000000..422fe9f7a3f2
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
@@ -0,0 +1,128 @@
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/openrisc/openrisc_port.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_openrisc_port:
+
+==============
+OpenRISC Linux
+==============
+
+這是Linux對OpenRISC類微處理器的移植；具體來說，最早移植目標是32位
+OpenRISC 1000系列（或1k）。
+
+關於OpenRISC處理器和正在進行中的開發的信息:
+
+	=======		=============================
+	網站		https://openrisc.io
+	郵箱		openrisc@lists.librecores.org
+	=======		=============================
+
+---------------------------------------------------------------------
+
+OpenRISC工具鏈和Linux的構建指南
+===============================
+
+爲了構建和運行Linux for OpenRISC，你至少需要一個基本的工具鏈，或許
+還需要架構模擬器。 這裏概述了準備就位這些部分的步驟。
+
+1) 工具鏈
+
+工具鏈二進制文件可以從openrisc.io或我們的github發佈頁面獲得。不同
+工具鏈的構建指南可以在openrisc.io或Stafford的工具鏈構建和發佈腳本
+中找到。
+
+	======      =================================================
+	二進制      https://github.com/openrisc/or1k-gcc/releases
+	工具鏈      https://openrisc.io/software
+	構建        https://github.com/stffrdhrn/or1k-toolchain-build
+	======      =================================================
+
+2) 構建
+
+像往常一樣構建Linux內核::
+
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
+
+3) 在FPGA上運行（可選)
+
+OpenRISC社區通常使用FuseSoC來管理構建和編程SoC到FPGA中。 下面是用
+OpenRISC SoC對De0 Nano開發板進行編程的一個例子。 在構建過程中，
+FPGA RTL是從FuseSoC IP核庫中下載的代碼，並使用FPGA供應商工具構建。
+二進制文件用openocd加載到電路板上。
+
+::
+
+	git clone https://github.com/olofk/fusesoc
+	cd fusesoc
+	sudo pip install -e .
+
+	fusesoc init
+	fusesoc build de0_nano
+	fusesoc pgm de0_nano
+
+	openocd -f interface/altera-usb-blaster.cfg \
+		-f board/or1k_generic.cfg
+
+	telnet localhost 4444
+	> init
+	> halt; load_image vmlinux ; reset
+
+4) 在模擬器上運行（可選）
+
+QEMU是一個處理器仿真器，我們推薦它來模擬OpenRISC平臺。 請按照QEMU網
+站上的OpenRISC說明，讓Linux在QEMU上運行。 你可以自己構建QEMU，但你的
+Linux發行版可能提供了支持OpenRISC的二進制包。
+
+	=============	======================================================
+	qemu openrisc	https://wiki.qemu.org/Documentation/Platforms/OpenRISC
+	=============	======================================================
+
+---------------------------------------------------------------------
+
+術語表
+======
+
+代碼中使用了以下符號約定以將範圍限制在幾個特定處理器實現上：
+
+========= =======================
+openrisc: OpenRISC類型處理器
+or1k:     OpenRISC 1000系列處理器
+or1200:   OpenRISC 1200處理器
+========= =======================
+
+---------------------------------------------------------------------
+
+歷史
+====
+
+2003-11-18	Matjaz Breskvar (phoenix@bsemi.com)
+   將linux初步移植到OpenRISC或32架構。
+       所有的核心功能都實現了，並且可以使用。
+
+2003-12-08	Matjaz Breskvar (phoenix@bsemi.com)
+   徹底改變TLB失誤處理。
+   重寫異常處理。
+   在默認的initrd中實現了sash-3.6的所有功能。
+   大幅改進的版本。
+
+2004-04-10	Matjaz Breskvar (phoenix@bsemi.com)
+   大量的bug修復。
+   支持以太網，http和telnet服務器功能。
+   可以運行許多標準的linux應用程序。
+
+2004-06-26	Matjaz Breskvar (phoenix@bsemi.com)
+   移植到2.6.x。
+
+2004-11-30	Matjaz Breskvar (phoenix@bsemi.com)
+   大量的bug修復和增強功能。
+   增加了opencores framebuffer驅動。
+
+2010-10-09    Jonas Bonn (jonas@southpole.se)
+   重大重寫，使其與上游的Linux 2.6.36看齊。
+
diff --git a/Documentation/translations/zh_TW/arch/openrisc/todo.rst b/Documentation/translations/zh_TW/arch/openrisc/todo.rst
new file mode 100644
index 000000000000..df261b9e3002
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/openrisc/todo.rst
@@ -0,0 +1,24 @@
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/openrisc/todo.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_openrisc_todo.rst:
+
+========
+待辦事項
+========
+
+OpenRISC Linux的移植已經完全投入使用，並且從 2.6.35 開始就一直在上游同步。
+然而，還有一些剩餘的項目需要在未來幾個月內完成。 下面是一個即將進行調查的已知
+不盡完美的項目列表，即我們的待辦事項列表。
+
+-   實現其餘的DMA API……dma_map_sg等。
+
+-   完成重命名清理工作……代碼中提到了or32，這是架構的一個老名字。 我們
+    已經確定的名字是or1k，這個改變正在以緩慢積累的方式進行。 目前，or32相當
+    於or1k。
+
diff --git a/Documentation/translations/zh_TW/arch/parisc/debugging.rst b/Documentation/translations/zh_TW/arch/parisc/debugging.rst
new file mode 100644
index 000000000000..c9ee804aebbd
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/parisc/debugging.rst
@@ -0,0 +1,46 @@
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/parisc/debugging.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_parisc_debugging:
+
+=================
+調試PA-RISC
+=================
+
+好吧，這裏有一些關於調試linux/parisc的較底層部分的信息。
+
+
+1. 絕對地址
+=====================
+
+很多彙編代碼目前運行在實模式下，這意味着會使用絕對地址，而不是像內核其他
+部分那樣使用虛擬地址。要將絕對地址轉換爲虛擬地址，你可以在System.map中查
+找，添加__PAGE_OFFSET（目前是0x10000000）。
+
+
+2. HPMCs
+========
+
+當實模式的代碼試圖訪問不存在的內存時，會出現HPMC（high priority machine
+check）而不是內核oops。若要調試HPMC，請嘗試找到系統響應程序/請求程序地址。
+系統請求程序地址應該與（某）處理器的HPA（I/O範圍內的高地址）相匹配；系統響應程
+序地址是實模式代碼試圖訪問的地址。
+
+系統響應程序地址的典型值是大於__PAGE_OFFSET （0x10000000）的地址，這意味着
+在實模式試圖訪問它之前，虛擬地址沒有被翻譯成物理地址。
+
+
+3. 有趣的Q位
+============
+
+某些非常關鍵的代碼必須清除PSW中的Q位。當Q位被清除時，CPU不會更新中斷處理
+程序所讀取的寄存器，以找出機器被中斷的位置——所以如果你在清除Q位的指令和再
+次設置Q位的RFI之間遇到中斷，你不知道它到底發生在哪裏。如果你幸運的話，IAOQ
+會指向清除Q位的指令，如果你不幸運的話，它會指向任何地方。通常Q位的問題會
+表現爲無法解釋的系統掛起或物理內存越界。
+
diff --git a/Documentation/translations/zh_TW/arch/parisc/index.rst b/Documentation/translations/zh_TW/arch/parisc/index.rst
new file mode 100644
index 000000000000..35941bf68c88
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/parisc/index.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/parisc/index.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_parisc_index:
+
+====================
+PA-RISC體系架構
+====================
+
+.. toctree::
+   :maxdepth: 2
+
+   debugging
+   registers
+
+Todolist:
+
+   features
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/translations/zh_TW/arch/parisc/registers.rst b/Documentation/translations/zh_TW/arch/parisc/registers.rst
new file mode 100644
index 000000000000..695acb21134a
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/parisc/registers.rst
@@ -0,0 +1,157 @@
+.. include:: ../../disclaimer-zh_TW.rst
+
+:Original: Documentation/arch/parisc/registers.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+.. _tw_parisc_registers:
+
+=========================
+Linux/PA-RISC的寄存器用法
+=========================
+
+[ 用星號表示目前尚未實現的計劃用途。 ]
+
+ABI約定的通用寄存器
+===================
+
+控制寄存器
+----------
+
+============================    =================================
+CR 0 (恢復計數器)               用於ptrace
+CR 1-CR 7(無定義)               未使用
+CR 8 (Protection ID)            每進程值*
+CR 9, 12, 13 (PIDS)             未使用
+CR10 (CCR)                      FPU延遲保存*
+CR11                            按照ABI的規定（SAR）
+CR14 (中斷向量)                 初始化爲 fault_vector
+CR15 (EIEM)                     所有位初始化爲1*
+CR16 (間隔計時器)               讀取週期數/寫入開始時間間隔計時器
+CR17-CR22                       中斷參數
+CR19                            中斷指令寄存器
+CR20                            中斷空間寄存器
+CR21                            中斷偏移量寄存器
+CR22                            中斷 PSW
+CR23 (EIRR)                     讀取未決中斷/寫入清除位
+CR24 (TR 0)                     內核空間頁目錄指針
+CR25 (TR 1)                     用戶空間頁目錄指針
+CR26 (TR 2)                     不使用
+CR27 (TR 3)                     線程描述符指針
+CR28 (TR 4)                     不使用
+CR29 (TR 5)                     不使用
+CR30 (TR 6)                     當前 / 0
+CR31 (TR 7)                     臨時寄存器，在不同地方使用
+============================    =================================
+
+空間寄存器（內核模式）
+----------------------
+
+========                        ==============================
+SR0                             臨時空間寄存器
+SR4-SR7                         設置爲0
+SR1                             臨時空間寄存器
+SR2                             內核不應該破壞它
+SR3                             用於用戶空間訪問（當前進程）
+========                        ==============================
+
+空間寄存器（用戶模式）
+----------------------
+
+========                        ============================
+SR0                             臨時空間寄存器
+SR1                             臨時空間寄存器
+SR2                             保存Linux gateway page的空間
+SR3                             在內核中保存用戶地址空間的值
+SR4-SR7                         定義了用戶/內核的短地址空間
+========                        ============================
+
+
+處理器狀態字
+------------
+
+======================          ================================================
+W （64位地址）                  0
+E （小尾端）                    0
+S （安全間隔計時器）            0
+T （產生分支陷阱）              0
+H （高特權級陷阱）              0
+L （低特權級陷阱）              0
+N （撤銷下一條指令）            被C代碼使用
+X （數據存儲中斷禁用）          0
+B （產生分支）                  被C代碼使用
+C （代碼地址轉譯）              1, 在執行實模式代碼時爲0
+V （除法步長校正）              被C代碼使用
+M （HPMC 掩碼）                 0, 在執行HPMC操作*時爲1
+C/B （進/借 位）                被C代碼使用
+O （有序引用）                  1*
+F （性能監視器）                0
+R （回收計數器陷阱）            0
+Q （收集中斷狀態）              1 （在rfi之前的代碼中爲0）
+P （保護標識符）                1*
+D （數據地址轉譯）              1, 在執行實模式代碼時爲0
+I （外部中斷掩碼）              由cli()/sti()宏使用。
+======================          ================================================
+
+“隱形”寄存器（影子寄存器）
+---------------------------
+
+=============                   ===================
+PSW W 默認值                    0
+PSW E 默認值                    0
+影子寄存器                      被中斷處理代碼使用
+TOC啓用位                       1
+=============                   ===================
+
+----------------------------------------------------------
+
+PA-RISC架構定義了7個寄存器作爲“影子寄存器”。這些寄存器在
+RETURN FROM INTERRUPTION AND RESTORE指令中使用，通過消
+除中斷處理程序中對一般寄存器（GR）的保存和恢復的需要來減
+少狀態保存和恢復時間。影子寄存器是GRs 1, 8, 9, 16, 17,
+24和25。
+
+-------------------------------------------------------------------------
+
+寄存器使用說明，最初由John Marvin提供，並由Randolph Chung提供一些補充說明。
+
+對於通用寄存器:
+
+r1,r2,r19-r26,r28,r29 & r31可以在不保存它們的情況下被使用。當然，如果你
+關心它們，在調用另一個程序之前，你也需要保存它們。上面的一些寄存器確實
+有特殊的含義，你應該注意一下:
+
+    r1:
+       addil指令是硬性規定將其結果放在r1中，所以如果你使用這條指令要
+       注意這點。
+
+    r2:
+       這就是返回指針。一般來說，你不想使用它，因爲你需要這個指針來返
+       回給你的調用者。然而，它與這組寄存器組合在一起，因爲調用者不能
+       依賴你返回時的值是相同的，也就是說，你可以將r2複製到另一個寄存
+       器，並在作廢r2後通過該寄存器返回，這應該不會給調用程序帶來問題。
+
+    r19-r22:
+       這些通常被認爲是臨時寄存器。
+       請注意，在64位中它們是arg7-arg4。
+
+    r23-r26:
+       這些是arg3-arg0，也就是說，如果你不再關心傳入的值，你可以使用
+       它們。
+
+    r28,r29:
+       這倆是ret0和ret1。它們是你傳入返回值的地方。r28是主返回值。當返回
+       小結構體時，r29也可以用來將數據傳回給調用程序。
+
+    r30:
+       棧指針
+
+    r31:
+       ble指令將返回指針放在這裏。
+
+
+    r3-r18,r27,r30需要被保存和恢復。r3-r18只是一般用途的寄存器。
+    r27是數據指針，用來使對全局變量的引用更容易。r30是棧指針。
+
diff --git a/Documentation/translations/zh_TW/cpu-freq/core.rst b/Documentation/translations/zh_TW/cpu-freq/core.rst
index f1951e1b23bb..4f98d1e9f34b 100644
--- a/Documentation/translations/zh_TW/cpu-freq/core.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/core.rst
@@ -1,13 +1,15 @@
 .. SPDX-License-Identifier: GPL-2.0
-
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :doc:`../../../cpu-freq/core`
-:Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res.211@gmail.com>
+:Original: Documentation/cpu-freq/core.rst
+
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
 
-.. _tw_core.rst:
+:校譯:
 
+ 唐藝舟 Tang Yizhou <tangyeechou@gmail.com>
 
 ====================================
 CPUFreq核心和CPUFreq通知器的通用說明
@@ -29,10 +31,10 @@ CPUFreq核心和CPUFreq通知器的通用說明
 ======================
 
 cpufreq核心代碼位於drivers/cpufreq/cpufreq.c中。這些cpufreq代碼爲CPUFreq架構的驅
-動程序（那些操作硬體切換頻率的代碼）以及 "通知器 "提供了一個標準化的接口。
-這些是設備驅動程序或需要了解策略變化的其它內核部分（如 ACPI 熱量管理）或所有頻率更改（除
-計時代碼外），甚至需要強制確定速度限制的通知器（如 ARM 架構上的 LCD 驅動程序）。
-此外， 內核 "常數" loops_per_jiffy會根據頻率變化而更新。
+動程序（那些執行硬件頻率切換的代碼）以及 "通知器" 提供了一個標準化的接口。
+包括設備驅動程序；需要了解策略變化（如 ACPI 熱量管理），或所有頻率變化（如計時代碼），
+甚至需要強制限制爲指定頻率（如 ARM 架構上的 LCD 驅動程序）的其它內核組件。
+此外，內核 "常數" loops_per_jiffy 會根據頻率變化而更新。
 
 cpufreq策略的引用計數由 cpufreq_cpu_get 和 cpufreq_cpu_put 來完成，以確保 cpufreq 驅
 動程序被正確地註冊到核心中，並且驅動程序在 cpufreq_put_cpu 被調用之前不會被卸載。這也保證
@@ -41,10 +43,10 @@ cpufreq策略的引用計數由 cpufreq_cpu_get 和 cpufreq_cpu_put 來完成，
 2. CPUFreq 通知器
 ====================
 
-CPUFreq通知器符合標準的內核通知器接口。
+CPUFreq通知器遵循標準的內核通知器接口。
 關於通知器的細節請參閱 linux/include/linux/notifier.h。
 
-這裡有兩個不同的CPUfreq通知器 - 策略通知器和轉換通知器。
+這裏有兩個不同的CPUfreq通知器 - 策略通知器和轉換通知器。
 
 
 2.1 CPUFreq策略通知器
@@ -62,27 +64,27 @@ CPUFreq通知器符合標準的內核通知器接口。
 2.2 CPUFreq轉換通知器
 --------------------------------
 
-當CPUfreq驅動切換CPU核心頻率時，策略中的每個在線CPU都會收到兩次通知，這些變化沒有任何外部干
+當CPUfreq驅動切換CPU核心頻率時，策略中的每個在線CPU都會收到兩次通知，這些變化沒有任何外部幹
 預。
 
 第二個參數指定階段 - CPUFREQ_PRECHANGE or CPUFREQ_POSTCHANGE.
 
 第三個參數是一個包含如下值的結構體cpufreq_freqs：
 
-=====	====================
-cpu	受影響cpu的編號
+======	===============================
+policy	指向struct cpufreq_policy的指針
 old	舊頻率
 new	新頻率
 flags	cpufreq驅動的標誌
-=====	====================
+======	===============================
 
 3. 含有Operating Performance Point (OPP)的CPUFreq表的生成
 ==================================================================
 關於OPP的細節請參閱 Documentation/power/opp.rst
 
 dev_pm_opp_init_cpufreq_table -
-	這個功能提供了一個隨時可用的轉換程序，用來將OPP層關於可用頻率的內部信息翻譯成一種容易提供給
-	cpufreq的格式。
+	這個函數提供了一個隨時可用的轉換例程，用來將OPP層關於可用頻率的內部信息翻譯成一種
+	cpufreq易於處理的格式。
 
 	.. Warning::
 
@@ -101,7 +103,7 @@ dev_pm_opp_init_cpufreq_table -
 
 	.. note::
 
-		該函數只有在CONFIG_PM_OPP之外還啓用了CONFIG_CPU_FREQ時才可用。
+		該函數只有在CONFIG_PM_OPP之外還啓用了CONFIG_CPU_FREQ時纔可用。
 
 dev_pm_opp_free_cpufreq_table
 	釋放dev_pm_opp_init_cpufreq_table分配的表。
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
index 671b1bf0e2c5..add3de2d4523 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -2,12 +2,15 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :doc:`../../../cpu-freq/cpu-drivers`
-:Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res.211@gmail.com>
+:Original: Documentation/cpu-freq/cpu-drivers.rst
 
-.. _tw_cpu-drivers.rst:
+:翻譯:
 
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+:校譯:
+
+ 唐藝舟 Tang Yizhou <tangyeechou@gmail.com>
 
 =======================================
 如何實現一個新的CPUFreq處理器驅動程序？
@@ -37,15 +40,15 @@
 1. 怎麼做？
 ===========
 
-如此，你剛剛得到了一個全新的CPU/晶片組及其數據手冊，並希望爲這個CPU/晶片組添加cpufreq
-支持？很好，這裡有一些至關重要的提示：
+如果，你剛剛得到了一個全新的CPU/芯片組及其數據手冊，並希望爲這個CPU/芯片組添加cpufreq
+支持？很好，這裏有一些至關重要的提示：
 
 
 1.1 初始化
 ----------
 
-首先，在__initcall_level_7 (module_init())或更靠後的函數中檢查這個內核是否
-運行在正確的CPU和正確的晶片組上。如果是，則使用cpufreq_register_driver()向
+首先，在 __initcall level 7 (module_init())或更靠後的函數中檢查這個內核是否
+運行在正確的CPU和正確的芯片組上。如果是，則使用cpufreq_register_driver()向
 CPUfreq核心層註冊一個cpufreq_driver結構體。
 
 結構體cpufreq_driver應該包含什麼成員?
@@ -59,11 +62,11 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
  .setpolicy 或 .fast_switch 或 .target 或 .target_index - 差異見
  下文。
 
-並且可選擇
+其它可選成員
 
- .flags - cpufreq核的提示。
+ .flags - 給cpufreq核心的提示。
 
- .driver_data - cpufreq驅動程序的特定數據。
+ .driver_data - cpufreq驅動程序的特有數據。
 
  .get_intermediate 和 target_intermediate - 用於在改變CPU頻率時切換到穩定
  的頻率。
@@ -72,18 +75,18 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
 
  .bios_limit - 返回HW/BIOS對CPU的最大頻率限制值。
 
- .exit - 一個指向per-policy清理函數的指針，該函數在cpu熱插拔過程的CPU_POST_DEAD
+ .exit - 一個指向per-policy清理函數的指針，該函數在CPU熱插拔過程的CPU_POST_DEAD
  階段被調用。
 
  .suspend - 一個指向per-policy暫停函數的指針，該函數在關中斷且在該策略的調節器停止
  後被調用。
 
- .resume - 一個指向per-policy恢復函數的指針，該函數在關中斷且在調節器再一次開始前被
+ .resume - 一個指向per-policy恢復函數的指針，該函數在關中斷且在調節器再一次啓動前被
  調用。
 
  .ready - 一個指向per-policy準備函數的指針，該函數在策略完全初始化之後被調用。
 
- .attr - 一個指向NULL結尾的"struct freq_attr"列表的指針，該函數允許導出值到
+ .attr - 一個指向NULL結尾的"struct freq_attr"列表的指針，該列表允許導出值到
  sysfs。
 
  .boost_enabled - 如果設置，則啓用提升(boost)頻率。
@@ -94,95 +97,93 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
 1.2 Per-CPU 初始化
 ------------------
 
-每當一個新的CPU被註冊到設備模型中，或者在cpufreq驅動註冊自己之後，如果此CPU的cpufreq策
-略不存在，則會調用per-policy的初始化函數cpufreq_driver.init。請注意，.init()和.exit()程序
-只對策略調用一次，而不是對策略管理的每個CPU調用一次。它需要一個 ``struct cpufreq_policy
+每當一個新的CPU被註冊到設備模型中，或者當cpufreq驅動註冊自身之後，如果此CPU的cpufreq策
+略不存在，則會調用per-policy的初始化函數cpufreq_driver.init。請注意，.init()和.exit()例程
+只爲某個策略調用一次，而不是對該策略管理的每個CPU調用一次。它需要一個 ``struct cpufreq_policy
 *policy`` 作爲參數。現在該怎麼做呢？
 
 如果有必要，請在你的CPU上激活CPUfreq功能支持。
 
-然後，驅動程序必須填寫以下數值:
+然後，驅動程序必須填寫以下值:
 
 +-----------------------------------+--------------------------------------+
-|policy->cpuinfo.min_freq 和	   |					  |
-|policy->cpuinfo.max_freq	    | 該CPU支持的最低和最高頻率（kHz）     |
-|				    |                                      |
-|				    | 				           |
+|policy->cpuinfo.min_freq和         | 該CPU支持的最低和最高頻率（kHz）     |
+|policy->cpuinfo.max_freq           |                                      |
+|                                   |                                      |
 +-----------------------------------+--------------------------------------+
-|policy->cpuinfo.transition_latency |                                      |
-|				    | CPU在兩個頻率之間切換所需的時間，以  |
-|				    | 納秒爲單位（如適用，否則指定         |
-|				    | CPUFREQ_ETERNAL）                    |
+|policy->cpuinfo.transition_latency | CPU在兩個頻率之間切換所需的時間，以  |
+|                                   | 納秒爲單位（如不適用，設定爲         |
+|                                   | CPUFREQ_ETERNAL）                    |
+|                                   |                                      |
 +-----------------------------------+--------------------------------------+
-|policy->cur			    | 該CPU當前的工作頻率(如適用)          |
-|				    |                                      |
+|policy->cur                        | 該CPU當前的工作頻率(如適用)          |
+|                                   |                                      |
 +-----------------------------------+--------------------------------------+
-|policy->min,			    |					   |
-|policy->max,			    |					   |
-|policy->policy and, if necessary,  |					   |
-|policy->governor		    | 必須包含該cpu的 「默認策略」。稍後   |
-|				    | 會用這些值調用                       |
-|				    | cpufreq_driver.verify and either     |
-|				    | cpufreq_driver.setpolicy or          |
-|				    | cpufreq_driver.target/target_index   |
-|				    | 		                           |
+|policy->min,                       | 必須包含該CPU的"默認策略"。稍後      |
+|policy->max,                       | 會用這些值調用                       |
+|policy->policy and, if necessary,  | cpufreq_driver.verify和下面函數      |
+|policy->governor                   | 之一：cpufreq_driver.setpolicy或     |
+|                                   | cpufreq_driver.target/target_index   |
+|                                   |                                      |
 +-----------------------------------+--------------------------------------+
-|policy->cpus			    | 用與這個CPU一起做DVFS的(在線+離線)   |
-|				    | CPU(即與它共享時鐘/電壓軌)的掩碼更新 |
-|				    | 這個                                 |
-|				    |                                      |
+|policy->cpus                       | 該policy通過DVFS框架影響的全部CPU    |
+|                                   | (即與本CPU共享"時鐘/電壓"對)構成     |
+|                                   | 掩碼(同時包含在線和離線CPU)，用掩碼  |
+|                                   | 更新本字段                           |
+|                                   |                                      |
 +-----------------------------------+--------------------------------------+
 
-對於設置其中的一些值(cpuinfo.min[max]_freq, policy->min[max])，頻率表助手可能會有幫
+對於設置其中的一些值(cpuinfo.min[max]_freq, policy->min[max])，頻率表輔助函數可能會有幫
 助。關於它們的更多信息，請參見第2節。
 
 
 1.3 驗證
 --------
 
-當用戶決定設置一個新的策略(由 「policy,governor,min,max組成」)時，必須對這個策略進行驗證，
+當用戶決定設置一個新的策略(由"policy,governor,min,max組成")時，必須對這個策略進行驗證，
 以便糾正不兼容的值。爲了驗證這些值，cpufreq_verify_within_limits(``struct cpufreq_policy
 *policy``, ``unsigned int min_freq``, ``unsigned int max_freq``)函數可能會有幫助。
-關於頻率表助手的詳細內容請參見第2節。
+關於頻率表輔助函數的詳細內容請參見第2節。
 
 您需要確保至少有一個有效頻率（或工作範圍）在 policy->min 和 policy->max 範圍內。如果有必
-要，先增加policy->max，只有在沒有辦法的情況下，才減少policy->min。
+要，先增大policy->max，只有在沒有解決方案的情況下，才減小policy->min。
 
 
 1.4 target 或 target_index 或 setpolicy 或 fast_switch?
 -------------------------------------------------------
 
-大多數cpufreq驅動甚至大多數cpu頻率升降算法只允許將CPU頻率設置爲預定義的固定值。對於這些，你
+大多數cpufreq驅動甚至大多數CPU頻率升降算法只允許將CPU頻率設置爲預定義的固定值。對於這些，你
 可以使用->target()，->target_index()或->fast_switch()回調。
 
-有些cpufreq功能的處理器可以自己在某些限制之間切換頻率。這些應使用->setpolicy()回調。
+有些具有硬件調頻能力的處理器可以自行依據某些限制來切換CPU頻率。它們應使用->setpolicy()回調。
 
 
 1.5. target/target_index
 ------------------------
 
-target_index調用有兩個參數：``struct cpufreq_policy * policy``和``unsigned int``
-索引(於列出的頻率表)。
+target_index調用有兩個參數： ``struct cpufreq_policy * policy`` 和 ``unsigned int``
+索引(用於索引頻率表項)。
 
-當調用這裡時，CPUfreq驅動必須設置新的頻率。實際頻率必須由freq_table[index].frequency決定。
+當調用這裏時，CPUfreq驅動必須設置新的頻率。實際頻率必須由freq_table[index].frequency決定。
 
-它應該總是在錯誤的情況下恢復到之前的頻率(即policy->restore_freq)，即使我們之前切換到中間頻率。
+在發生錯誤的情況下總是應該恢復到之前的頻率(即policy->restore_freq)，即使我們已經切換到了
+中間頻率。
 
 已棄用
 ----------
-目標調用有三個參數。``struct cpufreq_policy * policy``, unsigned int target_frequency,
+target調用有三個參數。``struct cpufreq_policy * policy``, unsigned int target_frequency,
 unsigned int relation.
 
-CPUfreq驅動在調用這裡時必須設置新的頻率。實際的頻率必須使用以下規則來確定。
+CPUfreq驅動在調用這裏時必須設置新的頻率。實際的頻率必須使用以下規則來確定。
 
-- 緊跟 "目標頻率"。
+- 儘量貼近"目標頻率"。
 - policy->min <= new_freq <= policy->max (這必須是有效的!!!)
 - 如果 relation==CPUFREQ_REL_L，嘗試選擇一個高於或等於 target_freq 的 new_freq。("L代表
   最低，但不能低於")
 - 如果 relation==CPUFREQ_REL_H，嘗試選擇一個低於或等於 target_freq 的 new_freq。("H代表
   最高，但不能高於")
 
-這裡，頻率表助手可能會幫助你--詳見第2節。
+這裏，頻率表輔助函數可能會幫助你 -- 詳見第2節。
 
 1.6. fast_switch
 ----------------
@@ -196,51 +197,52 @@ CPUfreq驅動在調用這裡時必須設置新的頻率。實際的頻率必須
 1.7 setpolicy
 -------------
 
-setpolicy調用只需要一個``struct cpufreq_policy * policy``作爲參數。需要將處理器內或晶片組內動態頻
+setpolicy調用只需要一個 ``struct cpufreq_policy * policy`` 作爲參數。需要將處理器內或芯片組內動態頻
 率切換的下限設置爲policy->min，上限設置爲policy->max，如果支持的話，當policy->policy爲
-CPUFREQ_POLICY_PERFORMANCE時選擇面向性能的設置，當CPUFREQ_POLICY_POWERSAVE時選擇面向省電的設置。
+CPUFREQ_POLICY_PERFORMANCE時選擇面向性能的設置，爲CPUFREQ_POLICY_POWERSAVE時選擇面向省電的設置。
 也可以查看drivers/cpufreq/longrun.c中的參考實現。
 
 1.8 get_intermediate 和 target_intermediate
 --------------------------------------------
 
-僅適用於 target_index() 和 CPUFREQ_ASYNC_NOTIFICATION 未設置的驅動。
+僅適用於未設置 target_index() 和 CPUFREQ_ASYNC_NOTIFICATION 的驅動。
 
-get_intermediate應該返回一個平台想要切換到的穩定的中間頻率，target_intermediate()應該將CPU設置爲
-該頻率，然後再跳轉到'index'對應的頻率。核心會負責發送通知，驅動不必在target_intermediate()或
-target_index()中處理。
+get_intermediate應該返回一個平臺想要切換到的穩定的中間頻率，target_intermediate()應該將CPU設置爲
+該頻率，然後再跳轉到'index'對應的頻率。cpufreq核心會負責發送通知，驅動不必在
+target_intermediate()或target_index()中處理它們。
 
-在驅動程序不想因爲某個目標頻率切換到中間頻率的情況下，它們可以從get_intermediate()中返回'0'。在這種情況
-下，核心將直接調用->target_index()。
+在驅動程序不想爲某個目標頻率切換到中間頻率的情況下，它們可以讓get_intermediate()返回'0'。
+在這種情況下，cpufreq核心將直接調用->target_index()。
 
-注意：->target_index()應該在失敗的情況下恢復到policy->restore_freq，因爲core會爲此發送通知。
+注意：->target_index()應該在發生失敗的情況下將頻率恢復到policy->restore_freq，
+因爲cpufreq核心會爲此發送通知。
 
 
-2. 頻率表助手
-=============
+2. 頻率表輔助函數
+=================
 
-由於大多數cpufreq處理器只允許被設置爲幾個特定的頻率，因此，一個帶有一些函數的 「頻率表」可能會輔助處理器驅動
-程序的一些工作。這樣的 "頻率表" 由一個cpufreq_frequency_table條目構成的數組組成，"driver_data" 中包
-含了驅動程序的具體數值，"frequency" 中包含了相應的頻率，並設置了標誌。在表的最後，需要添加一個
-cpufreq_frequency_table條目，頻率設置爲CPUFREQ_TABLE_END。而如果想跳過表中的一個條目，則將頻率設置爲
-CPUFREQ_ENTRY_INVALID。這些條目不需要按照任何特定的順序排序，但如果它們是cpufreq 核心會對它們進行快速的DVFS，
+由於大多數支持cpufreq的處理器只允許被設置爲幾個特定的頻率，因此，"頻率表"和一些相關函數可能會輔助處理器驅動
+程序的一些工作。這樣的"頻率表"是一個由struct cpufreq_frequency_table的條目構成的數組，"driver_data"成員包
+含驅動程序的專用值，"frequency"成員包含了相應的頻率，此外還有標誌成員。在表的最後，需要添加一個
+cpufreq_frequency_table條目，頻率設置爲CPUFREQ_TABLE_END。如果想跳過表中的一個條目，則將頻率設置爲
+CPUFREQ_ENTRY_INVALID。這些條目不需要按照任何特定的順序排序，如果排序了，cpufreq核心執行DVFS會更快一點，
 因爲搜索最佳匹配會更快。
 
-如果策略在其policy->freq_table欄位中包含一個有效的指針，cpufreq表就會被核心自動驗證。
+如果在policy->freq_table字段中包含一個有效的頻率表指針，頻率表就會被cpufreq核心自動驗證。
 
 cpufreq_frequency_table_verify()保證至少有一個有效的頻率在policy->min和policy->max範圍內，並且所有其他
-標準都被滿足。這對->verify調用很有幫助。
+準則都被滿足。這對->verify調用很有幫助。
 
-cpufreq_frequency_table_target()是對應於->target階段的頻率表助手。只要把數值傳遞給這個函數，這個函數就會返
+cpufreq_frequency_table_target()是對應於->target階段的頻率表輔助函數。只要把值傳遞給這個函數，這個函數就會返
 回包含CPU要設置的頻率的頻率表條目。
 
-以下宏可以作爲cpufreq_frequency_table的疊代器。
+以下宏可以作爲cpufreq_frequency_table的迭代器。
 
 cpufreq_for_each_entry(pos, table) - 遍歷頻率表的所有條目。
 
 cpufreq_for_each_valid_entry(pos, table) - 該函數遍歷所有條目，不包括CPUFREQ_ENTRY_INVALID頻率。
-使用參數 "pos"-一個``cpufreq_frequency_table * `` 作爲循環變量，使用參數 "table"-作爲你想疊代
-的``cpufreq_frequency_table * `` 。
+使用參數"pos" -- 一個 ``cpufreq_frequency_table *`` 作爲循環指針，使用參數"table" -- 作爲你想迭代
+的 ``cpufreq_frequency_table *`` 。
 
 例如::
 
@@ -251,6 +253,6 @@ cpufreq_for_each_valid_entry(pos, table) - 該函數遍歷所有條目，不包
 		pos->frequency = ...
 	}
 
-如果你需要在driver_freq_table中處理pos的位置，不要減去指針，因爲它的代價相當高。相反，使用宏
+如果你需要在driver_freq_table中處理pos的位置，不要做指針減法，因爲它的代價相當高。作爲替代，使用宏
 cpufreq_for_each_entry_idx() 和 cpufreq_for_each_valid_entry_idx() 。
 
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
index 49088becd5fa..01ec8c837fe9 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
@@ -2,18 +2,21 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :doc:`../../../cpu-freq/cpufreq-stats`
-:Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res.211@gmail.com>
+:Original: Documentation/cpu-freq/cpufreq-stats.rst
 
-.. _tw_cpufreq-stats.rst:
+:翻譯:
 
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
+
+:校譯:
+
+ 唐藝舟 Tang Yizhou <tangyeechou@gmail.com>
 
 ==========================================
 sysfs CPUFreq Stats的一般說明
 ==========================================
 
-用戶信息
+爲使用者準備的信息
 
 
 作者: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -28,17 +31,16 @@ sysfs CPUFreq Stats的一般說明
 1. 簡介
 ===============
 
-cpufreq-stats是一個爲每個CPU提供CPU頻率統計的驅動。
-這些統計數據在/sysfs中以一堆只讀接口的形式提供。這個接口（在配置好後）將出現在
-/sysfs（<sysfs root>/devices/system/cpu/cpuX/cpufreq/stats/）中cpufreq下的一個單
-獨的目錄中，提供給每個CPU。
-各種統計數據將在此目錄下形成只讀文件。
+cpufreq-stats是一種爲每個CPU提供CPU頻率統計的驅動。
+這些統計數據以/sysfs中一系列只讀接口的形式呈現。cpufreq-stats接口（若已配置）將爲每個CPU生成
+/sysfs（<sysfs root>/devices/system/cpu/cpuX/cpufreq/stats/）中cpufreq目錄下的stats目錄。
+各項統計數據將在stats目錄下形成對應的只讀文件。
 
-此驅動是獨立於任何可能運行在你所用CPU上的特定cpufreq_driver而設計的。因此，它將與所有
-cpufreq_driver一起工作。
+此驅動是以獨立於任何可能運行在你所用CPU上的特定cpufreq_driver的方式設計的。因此，它將能和任何
+cpufreq_driver協同工作。
 
 
-2. 提供的統計數據(舉例說明)
+2. 已提供的統計數據(有例子)
 =====================================
 
 cpufreq stats提供了以下統計數據（在下面詳細解釋）。
@@ -47,8 +49,8 @@ cpufreq stats提供了以下統計數據（在下面詳細解釋）。
 -  total_trans
 -  trans_table
 
-所有的統計數據將從統計驅動被載入的時間（或統計被重置的時間）開始，到某一統計數據被讀取的時間爲止。
-顯然，統計驅動不會有任何關於統計驅動載入之前的頻率轉換信息。
+所有統計數據來自以下時間範圍：從統計驅動被加載的時間（或統計數據被重置的時間）開始，到某一統計數據被讀取的時間爲止。
+顯然，統計驅動不會保存它被加載之前的任何頻率轉換信息。
 
 ::
 
@@ -63,14 +65,14 @@ cpufreq stats提供了以下統計數據（在下面詳細解釋）。
 
 - **reset**
 
-只寫屬性，可用於重置統計計數器。這對於評估不同調節器下的系統行爲非常有用，且無需重啓。
+只寫屬性，可用於重置統計計數器。這對於評估不同調節器的系統行爲非常有用，且無需重啓。
 
 
 - **time_in_state**
 
-此項給出了這個CPU所支持的每個頻率所花費的時間。cat輸出的每一行都會有"<frequency>
-<time>"對，表示這個CPU在<frequency>上花費了<time>個usertime單位的時間。這裡的
-usertime單位是10mS（類似於/proc中輸出的其他時間）。
+此文件給出了在本CPU支持的每個頻率上分別花費的時間。cat輸出的每一行都是一個"<frequency>
+<time>"對，表示這個CPU在<frequency>上花費了<time>個usertime單位的時間。輸出的每一行對應
+一個CPU支持的頻率。這裏usertime單位是10mS（類似於/proc導出的其它時間）。
 
 ::
 
@@ -84,7 +86,7 @@ usertime單位是10mS（類似於/proc中輸出的其他時間）。
 
 - **total_trans**
 
-給出了這個CPU上頻率轉換的總次數。cat的輸出將有一個單一的計數，這就是頻率轉換的總數。
+此文件給出了這個CPU頻率轉換的總次數。cat的輸出是一個計數值，它就是頻率轉換的總次數。
 
 ::
 
@@ -93,10 +95,10 @@ usertime單位是10mS（類似於/proc中輸出的其他時間）。
 
 - **trans_table**
 
-這將提供所有CPU頻率轉換的細粒度信息。這裡的cat輸出是一個二維矩陣，其中一個條目<i, j>（第
+本文件提供所有CPU頻率轉換的細粒度信息。這裏的cat輸出是一個二維矩陣，其中一個條目<i, j>（第
 i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列遵循驅動最初提供給cpufreq
-核的頻率表的排序順序，因此可以排序（升序或降序）或不排序。 這裡的輸出也包含了每行每列的實際
-頻率值，以便更好地閱讀。
+核心的頻率表的排列順序，因此可以已排序（升序或降序）或未排序。這裏的輸出也包含了實際
+頻率值，分別按行和按列顯示，以便更好地閱讀。
 
 如果轉換表大於PAGE_SIZE，讀取時將返回一個-EFBIG錯誤。
 
@@ -114,7 +116,7 @@ i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列
 3. 配置cpufreq-stats
 ============================
 
-要在你的內核中配置cpufreq-stats::
+按以下方式在你的內核中配置cpufreq-stats::
 
 	Config Main Menu
 		Power management options (ACPI, APM)  --->
@@ -123,7 +125,7 @@ i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列
 				[*]   CPU frequency translation statistics
 
 
-"CPU Frequency scaling" (CONFIG_CPU_FREQ) 應該被啓用以配置cpufreq-stats。
+"CPU Frequency scaling" (CONFIG_CPU_FREQ) 應該被啓用，以支持配置cpufreq-stats。
 
 "CPU frequency translation statistics" (CONFIG_CPU_FREQ_STAT)提供了包括
 time_in_state、total_trans和trans_table的統計數據。
diff --git a/Documentation/translations/zh_TW/cpu-freq/index.rst b/Documentation/translations/zh_TW/cpu-freq/index.rst
index c6cf825b57a5..a9df16870b21 100644
--- a/Documentation/translations/zh_TW/cpu-freq/index.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/index.rst
@@ -2,12 +2,13 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :doc:`../../../cpu-freq/index`
-:Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res.211@gmail.com>
+:Original: Documentation/cpu-freq/index.rst
 
-.. _tw_index.rst:
+:翻譯:
+
+ 司延騰 Yanteng Si <siyanteng@loongson.cn>
 
+.. _tw_index.rst:
 
 =======================================================
 Linux CPUFreq - Linux(TM)內核中的CPU頻率和電壓升降代碼
@@ -28,10 +29,10 @@ Author: Dominik Brodowski  <linux@brodo.de>
 
 郵件列表
 ------------
-這裡有一個 CPU 頻率變化的 CVS 提交和通用列表，您可以在這裡報告bug、問題或提交補丁。要發
+這裏有一個 CPU 頻率變化的 CVS 提交和通用列表，您可以在這裏報告bug、問題或提交補丁。要發
 布消息，請發送電子郵件到 linux-pm@vger.kernel.org。
 
-連結
+鏈接
 -----
 FTP檔案:
 * ftp://ftp.linux.org.uk/pub/linux/cpufreq/
diff --git a/Documentation/translations/zh_TW/filesystems/debugfs.rst b/Documentation/translations/zh_TW/filesystems/debugfs.rst
index ddf801943c92..dc9befa5cc83 100644
--- a/Documentation/translations/zh_TW/filesystems/debugfs.rst
+++ b/Documentation/translations/zh_TW/filesystems/debugfs.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :doc:`../../../filesystems/debugfs`
+:Original: Documentation/filesystems/debugfs.rst
 
 =======
 Debugfs
@@ -23,8 +23,8 @@ Debugfs
 
 
 Debugfs是內核開發人員在用戶空間獲取信息的簡單方法。與/proc不同，proc只提供進程
-信息。也不像sysfs,具有嚴格的「每個文件一個值「的規則。debugfs根本沒有規則,開發
-人員可以在這裡放置他們想要的任何信息。debugfs文件系統也不能用作穩定的ABI接口。
+信息。也不像sysfs,具有嚴格的“每個文件一個值“的規則。debugfs根本沒有規則,開發
+人員可以在這裏放置他們想要的任何信息。debugfs文件系統也不能用作穩定的ABI接口。
 從理論上講，debugfs導出文件的時候沒有任何約束。但是[1]實際情況並不總是那麼
 簡單。即使是debugfs接口，也最好根據需要進行設計,並儘量保持接口不變。
 
@@ -34,8 +34,8 @@ Debugfs通常使用以下命令安裝::
     mount -t debugfs none /sys/kernel/debug
 
 （或等效的/etc/fstab行）。
-debugfs根目錄默認僅可由root用戶訪問。要更改對文件樹的訪問，請使用「 uid」，「 gid」
-和「 mode」掛載選項。請注意，debugfs API僅按照GPL協議導出到模塊。
+debugfs根目錄默認僅可由root用戶訪問。要更改對文件樹的訪問，請使用“ uid”，“ gid”
+和“ mode”掛載選項。請注意，debugfs API僅按照GPL協議導出到模塊。
 
 使用debugfs的代碼應包含<linux/debugfs.h>。然後，首先是創建至少一個目錄來保存
 一組debugfs文件::
@@ -54,8 +54,8 @@ debugfs根目錄默認僅可由root用戶訪問。要更改對文件樹的訪問
 				       struct dentry *parent, void *data,
 				       const struct file_operations *fops);
 
-在這裡，name是要創建的文件的名稱，mode描述了訪問文件應具有的權限，parent指向
-應該保存文件的目錄，data將存儲在產生的inode結構體的i_private欄位中，而fops是
+在這裏，name是要創建的文件的名稱，mode描述了訪問文件應具有的權限，parent指向
+應該保存文件的目錄，data將存儲在產生的inode結構體的i_private字段中，而fops是
 一組文件操作函數，這些函數中實現文件操作的具體行爲。至少，read（）和/或
 write（）操作應提供；其他可以根據需要包括在內。同樣的，返回值將是指向創建文件
 的dentry指針，錯誤時返回ERR_PTR（-ERROR），系統不支持debugfs時返回值爲ERR_PTR
@@ -81,7 +81,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 			    struct dentry *parent, u64 *value);
 
 這些文件支持讀取和寫入給定值。如果某個文件不支持寫入，只需根據需要設置mode
-參數位。這些文件中的值以十進位表示；如果需要使用十六進位，可以使用以下函數
+參數位。這些文件中的值以十進制表示；如果需要使用十六進制，可以使用以下函數
 替代::
 
     void debugfs_create_x8(const char *name, umode_t mode,
@@ -93,7 +93,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
     void debugfs_create_x64(const char *name, umode_t mode,
 			    struct dentry *parent, u64 *value);
 
-這些功能只有在開發人員知道導出值的大小的時候才有用。某些數據類型在不同的架構上
+這些功能只有在開發人員知道導出值的大小的時候纔有用。某些數據類型在不同的架構上
 有不同的寬度，這樣會使情況變得有些複雜。在這種特殊情況下可以使用以下函數::
 
     void debugfs_create_size_t(const char *name, umode_t mode,
@@ -101,7 +101,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 
 不出所料，此函數將創建一個debugfs文件來表示類型爲size_t的變量。
 
-同樣地，也有導出無符號長整型變量的函數，分別以十進位和十六進位表示如下::
+同樣地，也有導出無符號長整型變量的函數，分別以十進制和十六進制表示如下::
 
     struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 					struct dentry *parent,
@@ -125,7 +125,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 
 讀取此文件將獲得atomic_t值，寫入此文件將設置atomic_t值。
 
-另一個選擇是通過以下結構體和函數導出一個任意二進位數據塊::
+另一個選擇是通過以下結構體和函數導出一個任意二進制數據塊::
 
     struct debugfs_blob_wrapper {
 	void *data;
@@ -136,10 +136,10 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 				       struct dentry *parent,
 				       struct debugfs_blob_wrapper *blob);
 
-讀取此文件將返回由指針指向debugfs_blob_wrapper結構體的數據。一些驅動使用「blobs」
-作爲一種返回幾行（靜態）格式化文本的簡單方法。這個函數可用於導出二進位信息，但
+讀取此文件將返回由指針指向debugfs_blob_wrapper結構體的數據。一些驅動使用“blobs”
+作爲一種返回幾行（靜態）格式化文本的簡單方法。這個函數可用於導出二進制信息，但
 似乎在主線中沒有任何代碼這樣做。請注意，使用debugfs_create_blob（）命令創建的
-所有文件是只讀的。
+所有文件是隻讀的。
 
 如果您要轉儲一個寄存器塊（在開發過程中經常會這麼做，但是這樣的調試代碼很少上傳
 到主線中。Debugfs提供兩個函數：一個用於創建僅寄存器文件，另一個把一個寄存器塊
@@ -163,7 +163,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
     void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
 			 int nregs, void __iomem *base, char *prefix);
 
-「base」參數可能爲0，但您可能需要使用__stringify構建reg32數組，實際上有許多寄存器
+“base”參數可能爲0，但您可能需要使用__stringify構建reg32數組，實際上有許多寄存器
 名稱（宏）是寄存器塊在基址上的字節偏移量。
 
 如果要在debugfs中轉儲u32數組，可以使用以下函數創建文件::
@@ -172,7 +172,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 			struct dentry *parent,
 			u32 *array, u32 elements);
 
-「array」參數提供數據，而「elements」參數爲數組中元素的數量。注意：數組創建後，數組
+“array”參數提供數據，而“elements”參數爲數組中元素的數量。注意：數組創建後，數組
 大小無法更改。
 
 有一個函數來創建與設備相關的seq_file::
@@ -183,8 +183,8 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 				int (*read_fn)(struct seq_file *s,
 					void *data));
 
-「dev」參數是與此debugfs文件相關的設備，並且「read_fn」是一個函數指針，這個函數在
-列印seq_file內容的時候被回調。
+“dev”參數是與此debugfs文件相關的設備，並且“read_fn”是一個函數指針，這個函數在
+打印seq_file內容的時候被回調。
 
 還有一些其他的面向目錄的函數::
 
@@ -199,7 +199,7 @@ file_size是初始文件大小。其他參數跟函數debugfs_create_file的相
 
 調用debugfs_rename()將爲現有的debugfs文件重命名，可能同時切換目錄。 new_name
 函數調用之前不能存在；返回值爲old_dentry，其中包含更新的信息。可以使用
-debugfs_create_symlink（）創建符號連結。
+debugfs_create_symlink（）創建符號鏈接。
 
 所有debugfs用戶必須考慮的一件事是：
 
@@ -219,6 +219,6 @@ dentry值可以爲NULL或錯誤值，在這種情況下，不會有任何文件
 
 如果將對應頂層目錄的dentry傳遞給以上函數，則該目錄下的整個層次結構將會被刪除。
 
-注釋：
+註釋：
 [1] http://lwn.net/Articles/309298/
 
diff --git a/Documentation/translations/zh_TW/filesystems/index.rst b/Documentation/translations/zh_TW/filesystems/index.rst
index 789e742fa3c5..d7f9d61f654c 100644
--- a/Documentation/translations/zh_TW/filesystems/index.rst
+++ b/Documentation/translations/zh_TW/filesystems/index.rst
@@ -12,7 +12,7 @@
 Linux Kernel中的文件系統
 ========================
 
-這份正在開發的手冊或許在未來某個輝煌的日子裡以易懂的形式將Linux虛擬\
+這份正在開發的手冊或許在未來某個輝煌的日子裏以易懂的形式將Linux虛擬\
 文件系統（VFS）層以及基於其上的各種文件系統如何工作呈現給大家。當前\
 可以看到下面的內容。
 
diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Documentation/translations/zh_TW/filesystems/sysfs.txt
index a84eba2af9d3..ebe90651fc3b 100644
--- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
@@ -61,7 +61,7 @@ Documentation/core-api/kobject.rst 文檔以獲得更多關於 kobject 接口的
 
 任何 kobject 在系統中註冊，就會有一個目錄在 sysfs 中被創建。這個
 目錄是作爲該 kobject 的父對象所在目錄的子目錄創建的，以準確地傳遞
-內核的對象層次到用戶空間。sysfs 中的頂層目錄代表著內核對象層次的
+內核的對象層次到用戶空間。sysfs 中的頂層目錄代表着內核對象層次的
 共同祖先；例如：某些對象屬於某個子系統。
 
 Sysfs 在與其目錄關聯的 kernfs_node 對象中內部保存一個指向實現
@@ -198,7 +198,7 @@ Sysfs 將會爲每次讀寫操作調用一次這個方法。這使得這些方
   不會不太高。
 
   這使得用戶空間可以局部地讀和任意的向前搜索整個文件。如果用戶空間
-  向後搜索到零或使用『0』偏移執行一個pread(2)操作，show()方法將
+  向後搜索到零或使用‘0’偏移執行一個pread(2)操作，show()方法將
   再次被調用，以重新填充緩存。
 
 - 在寫方面（write(2)），sysfs 希望在第一次寫操作時得到整個緩衝區。
@@ -253,7 +253,7 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
 
 （注意：真正的實現不允許用戶空間設置設備名。）
 
-頂層目錄布局
+頂層目錄佈局
 ~~~~~~~~~~~~
 
 sysfs 目錄的安排顯示了內核數據結構之間的關係。
@@ -272,23 +272,23 @@ fs/
 devices/ 包含了一個設備樹的文件系統表示。他直接映射了內部的內核
 設備樹，反映了設備的層次結構。
 
-bus/ 包含了內核中各種總線類型的平面目錄布局。每個總線目錄包含兩個
+bus/ 包含了內核中各種總線類型的平面目錄佈局。每個總線目錄包含兩個
 子目錄:
 
 	devices/
 	drivers/
 
-devices/ 包含了系統中出現的每個設備的符號連結，他們指向 root/ 下的
+devices/ 包含了系統中出現的每個設備的符號鏈接，他們指向 root/ 下的
 設備目錄。
 
-drivers/ 包含了每個已爲特定總線上的設備而掛載的驅動程序的目錄(這裡
+drivers/ 包含了每個已爲特定總線上的設備而掛載的驅動程序的目錄(這裏
 假定驅動沒有跨越多個總線類型)。
 
 fs/ 包含了一個爲文件系統設立的目錄。現在每個想要導出屬性的文件系統必須
 在 fs/ 下創建自己的層次結構(參見Documentation/filesystems/fuse.rst)。
 
 dev/ 包含兩個子目錄： char/ 和 block/。在這兩個子目錄中，有以
-<major>:<minor> 格式命名的符號連結。這些符號連結指向 sysfs 目錄
+<major>:<minor> 格式命名的符號鏈接。這些符號鏈接指向 sysfs 目錄
 中相應的設備。/sys/dev 提供一個通過一個 stat(2) 操作結果，查找
 設備 sysfs 接口快捷的方法。
 
diff --git a/Documentation/translations/zh_TW/filesystems/tmpfs.rst b/Documentation/translations/zh_TW/filesystems/tmpfs.rst
index 2c8439b2b77e..bf5a7eea54e9 100644
--- a/Documentation/translations/zh_TW/filesystems/tmpfs.rst
+++ b/Documentation/translations/zh_TW/filesystems/tmpfs.rst
@@ -13,18 +13,18 @@ Tmpfs
 
 Tmpfs是一個將所有文件都保存在虛擬內存中的文件系統。
 
-tmpfs中的所有內容都是臨時的，也就是說沒有任何文件會在硬碟上創建。
+tmpfs中的所有內容都是臨時的，也就是說沒有任何文件會在硬盤上創建。
 如果卸載tmpfs實例，所有保存在其中的文件都會丟失。
 
-tmpfs將所有文件保存在內核緩存中，隨著文件內容增長或縮小可以將不需要的
-頁面swap出去。它具有最大限制，可以通過「mount -o remount ...」調整。
+tmpfs將所有文件保存在內核緩存中，隨着文件內容增長或縮小可以將不需要的
+頁面swap出去。它具有最大限制，可以通過“mount -o remount ...”調整。
 
 和ramfs（創建tmpfs的模板）相比，tmpfs包含交換和限制檢查。和tmpfs相似的另
-一個東西是RAM磁碟（/dev/ram*），可以在物理RAM中模擬固定大小的硬碟，並在
+一個東西是RAM磁盤（/dev/ram*），可以在物理RAM中模擬固定大小的硬盤，並在
 此之上創建一個普通的文件系統。Ramdisks無法swap，因此無法調整它們的大小。
 
 由於tmpfs完全保存於頁面緩存和swap中，因此所有tmpfs頁面將在/proc/meminfo
-中顯示爲「Shmem」，而在free(1)中顯示爲「Shared」。請注意，這些計數還包括
+中顯示爲“Shmem”，而在free(1)中顯示爲“Shared”。請注意，這些計數還包括
 共享內存(shmem，請參閱ipcs(1))。獲得計數的最可靠方法是使用df(1)和du(1)。
 
 tmpfs具有以下用途：
@@ -45,7 +45,7 @@ tmpfs具有以下用途：
    tmpfs的前身(shm fs)才能使用SYSV共享內存)
 
 3) 很多人（包括我）都覺的在/tmp和/var/tmp上掛載非常方便，並具有較大的
-   swap分區。目前循環掛載tmpfs可以正常工作，所以大多數發布都應當可以
+   swap分區。目前循環掛載tmpfs可以正常工作，所以大多數發佈都應當可以
    使用mkinitrd通過/tmp訪問/tmp。
 
 4) 也許還有更多我不知道的地方:-)
@@ -58,11 +58,11 @@ size       tmpfs實例分配的字節數限制。默認值是不swap時物理RAM
            如果tmpfs實例過大，機器將死鎖，因爲OOM處理將無法釋放該內存。
 nr_blocks  與size相同，但以PAGE_SIZE爲單位。
 nr_inodes  tmpfs實例的最大inode個數。默認值是物理內存頁數的一半，或者
-           (有高端內存的機器)低端內存RAM的頁數，二者以較低者為準。
+           (有高端內存的機器)低端內存RAM的頁數，二者以較低者爲準。
 =========  ===========================================================
 
 這些參數接受後綴k，m或g表示千，兆和千兆字節，可以在remount時更改。
-size參數也接受後綴％用來限制tmpfs實例占用物理RAM的百分比：
+size參數也接受後綴％用來限制tmpfs實例佔用物理RAM的百分比：
 未指定size或nr_blocks時，默認值爲size=50％
 
 如果nr_blocks=0（或size=0），block個數將不受限制；如果nr_inodes=0，
@@ -71,26 +71,26 @@ inode個數將不受限制。這樣掛載通常是不明智的，因爲它允許
 場景下的訪問。
 
 tmpfs具有爲所有文件設置NUMA內存分配策略掛載選項(如果啓用了CONFIG_NUMA),
-可以通過「mount -o remount ...」調整
+可以通過“mount -o remount ...”調整
 
 ======================== =========================
 mpol=default             採用進程分配策略
                          (請參閱 set_mempolicy(2))
 mpol=prefer:Node         傾向從給定的節點分配
-mpol=bind:NodeList       只允許從指定的鍊表分配
+mpol=bind:NodeList       只允許從指定的鏈表分配
 mpol=interleave          傾向於依次從每個節點分配
 mpol=interleave:NodeList 依次從每個節點分配
 mpol=local               優先本地節點分配內存
 ======================== =========================
 
-NodeList格式是以逗號分隔的十進位數字表示大小和範圍，最大和最小範圍是用-
-分隔符的十進位數來表示。例如，mpol=bind0-3,5,7,9-15
+NodeList格式是以逗號分隔的十進制數字表示大小和範圍，最大和最小範圍是用-
+分隔符的十進制數來表示。例如，mpol=bind0-3,5,7,9-15
 
 帶有有效NodeList的內存策略將按指定格式保存，在創建文件時使用。當任務在該
 文件系統上創建文件時，會使用到掛載時的內存策略NodeList選項，如果設置的話，
 由調用任務的cpuset[請參見Documentation/admin-guide/cgroup-v1/cpusets.rst]
 以及下面列出的可選標誌約束。如果NodeLists爲設置爲空集，則文件的內存策略將
-恢復爲「默認」策略。
+恢復爲“默認”策略。
 
 NUMA內存分配策略有可選標誌，可以用於模式結合。在掛載tmpfs時指定這些可選
 標誌可以在NodeList之前生效。
@@ -107,12 +107,12 @@ Documentation/admin-guide/mm/numa_memory_policy.rst列出所有可用的內存
 請注意，如果內核不支持NUMA，那麼使用mpol選項掛載tmpfs將會失敗；nodelist指定不
 在線的節點也會失敗。如果您的系統依賴於此，但內核會運行不帶NUMA功能(也許是安全
 revocery內核)，或者具有較少的節點在線，建議從自動模式中省略mpol選項掛載選項。
-可以在以後通過「mount -o remount,mpol=Policy:NodeList MountPoint」添加到掛載點。
+可以在以後通過“mount -o remount,mpol=Policy:NodeList MountPoint”添加到掛載點。
 
 要指定初始根目錄，可以使用如下掛載選項：
 
 ====	====================
-模式	權限用八進位數字表示
+模式	權限用八進制數字表示
 uid	用戶ID
 gid	組ID
 ====	====================
@@ -129,7 +129,7 @@ inode32   使用32位inode
 
 在32位內核上，默認是inode32，掛載時指定inode64會被拒絕。
 在64位內核上，默認配置是CONFIG_TMPFS_INODE64。inode64避免了單個設備上可能有多個
-具有相同inode編號的文件；比如32位應用程式使用glibc如果長期訪問tmpfs，一旦達到33
+具有相同inode編號的文件；比如32位應用程序使用glibc如果長期訪問tmpfs，一旦達到33
 位inode編號，就有EOVERFLOW失敗的危險，無法打開大於2GiB的文件，並返回EINVAL。
 
 所以'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'將在
diff --git a/Documentation/translations/zh_TW/filesystems/virtiofs.rst b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
index 086fce5839dd..6edcbb1ac994 100644
--- a/Documentation/translations/zh_TW/filesystems/virtiofs.rst
+++ b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
@@ -21,7 +21,7 @@ virtiofs: virtio-fs 主機<->客機共享文件系統
 
 介紹
 ====
-Linux的virtiofs文件系統實現了一個半虛擬化VIRTIO類型「virtio-fs」設備的驅動，通過該\
+Linux的virtiofs文件系統實現了一個半虛擬化VIRTIO類型“virtio-fs”設備的驅動，通過該\
 類型設備實現客機<->主機文件系統共享。它允許客機掛載一個已經導出到主機的目錄。
 
 客機通常需要訪問主機或者遠程系統上的文件。使用場景包括：在新客機安裝時讓文件對其\
@@ -42,12 +42,12 @@ Linux的virtiofs文件系統實現了一個半虛擬化VIRTIO類型「virtio-fs
 
   guest# mount -t virtiofs myfs /mnt
 
-請查閱 https://virtio-fs.gitlab.io/ 了解配置QEMU和virtiofsd守護程序的詳細信息。
+請查閱 https://virtio-fs.gitlab.io/ 瞭解配置QEMU和virtiofsd守護程序的詳細信息。
 
 內幕
 ====
 由於virtio-fs設備將FUSE協議用於文件系統請求，因此Linux的virtiofs文件系統與FUSE文\
-件系統客戶端緊密集成在一起。客機充當FUSE客戶端而主機充當FUSE伺服器，內核與用戶空\
+件系統客戶端緊密集成在一起。客機充當FUSE客戶端而主機充當FUSE服務器，內核與用戶空\
 間之間的/dev/fuse接口由virtio-fs設備接口代替。
 
 FUSE請求被置於虛擬隊列中由主機處理。主機填充緩衝區中的響應部分，而客機處理請求的完成部分。
@@ -55,7 +55,7 @@ FUSE請求被置於虛擬隊列中由主機處理。主機填充緩衝區中的
 將/dev/fuse映射到虛擬隊列需要解決/dev/fuse和虛擬隊列之間語義上的差異。每次讀取\
 /dev/fuse設備時，FUSE客戶端都可以選擇要傳輸的請求，從而可以使某些請求優先於其他\
 請求。虛擬隊列有其隊列語義，無法更改已入隊請求的順序。在虛擬隊列已滿的情況下尤
-其關鍵，因爲此時不可能加入高優先級的請求。爲了解決此差異，virtio-fs設備採用「hiprio」\
+其關鍵，因爲此時不可能加入高優先級的請求。爲了解決此差異，virtio-fs設備採用“hiprio”\
 （高優先級）虛擬隊列，專門用於有別於普通請求的高優先級請求。
 
 
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index d1cf0b4d8e46..854ae2a89c1f 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -101,9 +101,10 @@ TODOList:
 體系結構文檔
 ------------
 
-TODOList:
+.. toctree::
+   :maxdepth: 1
 
-* arch/index
+   arch/index
 
 其他文檔
 --------
diff --git a/Documentation/translations/zh_TW/process/1.Intro.rst b/Documentation/translations/zh_TW/process/1.Intro.rst
index f236fe95a6c6..6e754ac48964 100644
--- a/Documentation/translations/zh_TW/process/1.Intro.rst
+++ b/Documentation/translations/zh_TW/process/1.Intro.rst
@@ -22,12 +22,12 @@
 --------
 
 本節的其餘部分涵蓋了內核開發的過程，以及開發人員及其僱主在這方面可能遇到的
-各種問題。有很多原因使內核代碼應被合併到正式的（「主線」）內核中，包括對用戶
+各種問題。有很多原因使內核代碼應被合併到正式的（“主線”）內核中，包括對用戶
 的自動可用性、多種形式的社區支持以及影響內核開發方向的能力。提供給Linux內核
 的代碼必須在與GPL兼容的許可證下可用。
 
-:ref:`tw_development_process` 介紹了開發過程、內核發布周期和合併窗口的機制。
-涵蓋了補丁開發、審查和合併周期中的各個階段。還有一些關於工具和郵件列表的討論？
+:ref:`tw_development_process` 介紹了開發過程、內核發佈週期和合並窗口的機制。
+涵蓋了補丁開發、審查和合並週期中的各個階段。還有一些關於工具和郵件列表的討論？
 鼓勵希望開始內核開發的開發人員跟蹤並修復缺陷以作爲初步練習。
 
 
@@ -38,39 +38,39 @@
 陷阱。也涵蓋了對補丁的一些要求，並且介紹了一些工具，這些工具有助於確保內核
 補丁是正確的。
 
-:ref:`tw_development_posting` 描述發布補丁以供評審的過程。爲了讓開發社區能
+:ref:`tw_development_posting` 描述發佈補丁以供評審的過程。爲了讓開發社區能
 認真對待，補丁必須被正確格式化和描述，並且必須發送到正確的地方。遵循本節中的
 建議有助於確保您的工作能被較好地接納。
 
-:ref:`tw_development_followthrough` 介紹了發布補丁之後發生的事情；工作在這時
+:ref:`tw_development_followthrough` 介紹了發佈補丁之後發生的事情；工作在這時
 還遠遠沒有完成。與審閱者一起工作是開發過程中的一個重要部分；本節提供了一些
 關於如何在這個重要階段避免問題的提示。當補丁被合併到主線中時，開發人員要注意
 不要假定任務已經完成。
 
-:ref:`tw_development_advancedtopics` 介紹了兩個「高級」主題：使用Git管理補丁
-和查看其他人發布的補丁。
+:ref:`tw_development_advancedtopics` 介紹了兩個“高級”主題：使用Git管理補丁
+和查看其他人發佈的補丁。
 
 :ref:`tw_development_conclusion` 總結了有關內核開發的更多信息，附帶有相關資源
-連結。
+鏈接。
 
 這個文檔是關於什麼的
 --------------------
 
 Linux內核有超過800萬行代碼，每個版本的貢獻者超過1000人，是現存最大、最活躍的
-免費軟體項目之一。從1991年開始，這個內核已經發展成爲一個最好的作業系統組件，
-運行在袖珍數位音樂播放器、桌上型電腦、現存最大的超級計算機以及所有類型的系統上。
+免費軟件項目之一。從1991年開始，這個內核已經發展成爲一個最好的操作系統組件，
+運行在袖珍數字音樂播放器、臺式電腦、現存最大的超級計算機以及所有類型的系統上。
 它是一種適用於幾乎任何情況的健壯、高效和可擴展的解決方案。
 
-隨著Linux的發展，希望參與其開發的開發人員（和公司）的數量也在增加。硬體供應商
+隨着Linux的發展，希望參與其開發的開發人員（和公司）的數量也在增加。硬件供應商
 希望確保Linux能夠很好地支持他們的產品，使這些產品對Linux用戶具有吸引力。嵌入
 式系統供應商使用Linux作爲集成產品的組件，希望Linux能夠儘可能地勝任手頭的任務。
-分銷商和其他基於Linux的軟體供應商切實關心Linux內核的功能、性能和可靠性。最終
+分銷商和其他基於Linux的軟件供應商切實關心Linux內核的功能、性能和可靠性。最終
 用戶也常常希望修改Linux，使之能更好地滿足他們的需求。
 
 Linux最引人注目的特性之一是這些開發人員可以訪問它；任何具備必要技能的人都可以
-改進Linux並影響其開發方向。專有產品不能提供這種開放性，這是自由軟體的一個特點。
-如果有什麼不同的話，那就是內核比大多數其他自由軟體項目更開放。一個典型的三個
-月內核開發周期可以涉及1000多個開發人員，他們爲100多個不同的公司（或者根本不
+改進Linux並影響其開發方向。專有產品不能提供這種開放性，這是自由軟件的一個特點。
+如果有什麼不同的話，那就是內核比大多數其他自由軟件項目更開放。一個典型的三個
+月內核開發週期可以涉及1000多個開發人員，他們爲100多個不同的公司（或者根本不
 隸屬公司）工作。
 
 與內核開發社區合作並不是特別困難。但儘管如此，仍有許多潛在的貢獻者在嘗試做
@@ -79,7 +79,7 @@ Linux最引人注目的特性之一是這些開發人員可以訪問它；任何
 過程與專有的開發模式有很大的不同也就不足爲奇了。
 
 對於新開發人員來說，內核的開發過程可能會讓人感到奇怪和恐懼，但這背後有充分的
-理由和堅實的經驗。一個不了解內核社區工作方式的開發人員（或者更糟的是，他們
+理由和堅實的經驗。一個不瞭解內核社區工作方式的開發人員（或者更糟的是，他們
 試圖拋棄或規避之）會得到令人沮喪的體驗。開發社區在幫助那些試圖學習的人的同時，
 沒有時間幫助那些不願意傾聽或不關心開發過程的人。
 
@@ -102,20 +102,20 @@ Andrew Morton, Andrew Price, Tsugikazu Shibata 和 Jochen Voß 。
 --------------------
 
 有些公司和開發人員偶爾會想，爲什麼他們要費心學習如何與內核社區合作，並將代碼
-放入主線內核（「主線」是由Linus Torvalds維護的內核，Linux發行商將其用作基礎）。
+放入主線內核（“主線”是由Linus Torvalds維護的內核，Linux發行商將其用作基礎）。
 在短期內，貢獻代碼看起來像是一種可以避免的開銷；維護獨立代碼並直接支持用戶
-似乎更容易。事實上，保持代碼獨立（「樹外」）是在經濟上是錯誤的。
+似乎更容易。事實上，保持代碼獨立（“樹外”）是在經濟上是錯誤的。
 
 爲了說明樹外代碼成本，下面給出內核開發過程的一些相關方面；本文稍後將更詳細地
 討論其中的大部分內容。請考慮：
 
 - 所有Linux用戶都可以使用合併到主線內核中的代碼。它將自動出現在所有啓用它的
-  發行版上。無需驅動程序磁碟、額外下載，也不需要爲多個發行版的多個版本提供
+  發行版上。無需驅動程序磁盤、額外下載，也不需要爲多個發行版的多個版本提供
   支持；這一切將方便所有開發人員和用戶。併入主線解決了大量的分發和支持問題。
 
 - 當內核開發人員努力維護一個穩定的用戶空間接口時，內核內部API處於不斷變化之中。
   不維持穩定的內部接口是一個慎重的設計決策；它允許在任何時候進行基本的改進，
-  並產出更高質量的代碼。但該策略導致結果是，若要使用新的內核，任何樹外代碼都
+  併產出更高質量的代碼。但該策略導致結果是，若要使用新的內核，任何樹外代碼都
   需要持續的維護。維護樹外代碼會需要大量的工作才能使代碼保持正常運行。
 
   相反，位於主線中的代碼不需要這樣做，因爲基本規則要求進行API更改的任何開發
@@ -140,60 +140,60 @@ Andrew Morton, Andrew Price, Tsugikazu Shibata 和 Jochen Voß 。
 
 - 代碼的貢獻是使整個流程工作的根本。通過貢獻代碼，您可以向內核添加新功能，並
   提供其他內核開發人員使用的功能和示例。如果您已經爲Linux開發了代碼（或者正在
-  考慮這樣做），那麼您顯然對這個平台的持續成功感興趣；貢獻代碼是確保成功的
+  考慮這樣做），那麼您顯然對這個平臺的持續成功感興趣；貢獻代碼是確保成功的
   最好方法之一。
 
-上述所有理由都適用於任何樹外內核代碼，包括以專有的、僅二進位形式分發的代碼。
-然而，在考慮任何類型的純二進位內核代碼分布之前，還需要考慮其他因素。包括：
+上述所有理由都適用於任何樹外內核代碼，包括以專有的、僅二進制形式分發的代碼。
+然而，在考慮任何類型的純二進制內核代碼分佈之前，還需要考慮其他因素。包括：
 
 - 圍繞專有內核模塊分發的法律問題其實較爲模糊；相當多的內核版權所有者認爲，
-  大多數僅二進位的模塊是內核的派生產品，因此，它們的分發違反了GNU通用公共
+  大多數僅二進制的模塊是內核的派生產品，因此，它們的分發違反了GNU通用公共
   許可證（下面將詳細介紹）。本文作者不是律師，本文檔中的任何內容都不可能被
-  視爲法律建議。封閉原始碼模塊的真實法律地位只能由法院決定。但不管怎樣，困擾
+  視爲法律建議。封閉源代碼模塊的真實法律地位只能由法院決定。但不管怎樣，困擾
   這些模塊的不確定性仍然存在。
 
-- 二進位模塊大大增加了調試內核問題的難度，以至於大多數內核開發人員甚至都不會
-  嘗試。因此，只分發二進位模塊將使您的用戶更難從社區獲得支持。
+- 二進制模塊大大增加了調試內核問題的難度，以至於大多數內核開發人員甚至都不會
+  嘗試。因此，只分發二進制模塊將使您的用戶更難從社區獲得支持。
 
-- 對於僅二進位的模塊的發行者來說，支持也更加困難，他們必須爲他們希望支持的
+- 對於僅二進制的模塊的發行者來說，支持也更加困難，他們必須爲他們希望支持的
   每個發行版和每個內核版本提供不同版本的模塊。爲了提供較爲全面的覆蓋範圍，
   可能需要一個模塊的幾十個構建，並且每次升級內核時，您的用戶都必須單獨升級
   這些模塊。
 
-- 上面提到的關於代碼評審的所有問題都更加存在於封閉原始碼中。由於該代碼根本
+- 上面提到的關於代碼評審的所有問題都更加存在於封閉源代碼中。由於該代碼根本
   不可得，因此社區無法對其進行審查，毫無疑問，它將存在嚴重問題。
 
 尤其是嵌入式系統的製造商，可能會傾向於忽視本節中所說的大部分內容；因爲他們
-相信自己正在商用一種使用凍結內核版本的獨立產品，在發布後不需要再進行開發。
+相信自己正在商用一種使用凍結內核版本的獨立產品，在發佈後不需要再進行開發。
 這個論點忽略了廣泛的代碼審查的價值以及允許用戶向產品添加功能的價值。但這些
-產品的商業壽命有限，之後必須發布新版本的產品。在這一點上，代碼在主線上並得到
-良好維護的供應商將能夠更好地占位，以使新產品快速上市。
+產品的商業壽命有限，之後必須發佈新版本的產品。在這一點上，代碼在主線上並得到
+良好維護的供應商將能夠更好地佔位，以使新產品快速上市。
 
 許可
 ----
 
 代碼是根據一些許可證提供給Linux內核的，但是所有代碼都必須與GNU通用公共許可
 證（GPLV2）的版本2兼容，該版本是覆蓋整個內核分發的許可證。在實踐中，這意味
-著所有代碼貢獻都由GPLv2（可選地，語言允許在更高版本的GPL下分發）或3子句BSD
+着所有代碼貢獻都由GPLv2（可選地，語言允許在更高版本的GPL下分發）或3子句BSD
 許可（New BSD License，譯者注）覆蓋。任何不包含在兼容許可證中的貢獻都不會
 被接受到內核中。
 
 貢獻給內核的代碼不需要（或請求）版權分配。合併到主線內核中的所有代碼都保留
 其原始所有權；因此，內核現在擁有數千個所有者。
 
-這種所有權結構也暗示著，任何改變內核許可的嘗試都註定會失敗。很少有實際情況
+這種所有權結構也暗示着，任何改變內核許可的嘗試都註定會失敗。很少有實際情況
 可以獲得所有版權所有者的同意（或者從內核中刪除他們的代碼）。因此，尤其是在
 可預見的將來，許可證不大可能遷移到GPL的版本3。
 
-所有貢獻給內核的代碼都必須是合法的免費軟體。因此，不接受匿名（或化名）貢獻
-者的代碼。所有貢獻者都需要在他們的代碼上「sign off（簽發）」，聲明代碼可以
-在GPL下與內核一起分發。無法提供未被其所有者許可爲免費軟體的代碼，或可能爲
+所有貢獻給內核的代碼都必須是合法的免費軟件。因此，不接受匿名（或化名）貢獻
+者的代碼。所有貢獻者都需要在他們的代碼上“sign off（簽發）”，聲明代碼可以
+在GPL下與內核一起分發。無法提供未被其所有者許可爲免費軟件的代碼，或可能爲
 內核造成版權相關問題的代碼（例如，由缺乏適當保護的反向工程工作派生的代碼）
 不能被接受。
 
 有關版權問題的提問在Linux開發郵件列表中很常見。這樣的問題通常會得到不少答案，
-但請記住，回答這些問題的人不是律師，不能提供法律諮詢。如果您有關於Linux原始碼
-的法律問題，沒有什麼可以代替諮詢了解這一領域的律師。依賴從技術郵件列表中獲得
+但請記住，回答這些問題的人不是律師，不能提供法律諮詢。如果您有關於Linux源代碼
+的法律問題，沒有什麼可以代替諮詢瞭解這一領域的律師。依賴從技術郵件列表中獲得
 的答案是一件冒險的事情。
 
 
diff --git a/Documentation/translations/zh_TW/process/2.Process.rst b/Documentation/translations/zh_TW/process/2.Process.rst
index 17bb4e07d171..49385d65c216 100644
--- a/Documentation/translations/zh_TW/process/2.Process.rst
+++ b/Documentation/translations/zh_TW/process/2.Process.rst
@@ -26,8 +26,8 @@
 總覽
 ----
 
-內核開發人員使用一個鬆散的基於時間的發布過程，每兩到三個月發布一次新的主要
-內核版本。最近的發布歷史記錄如下：
+內核開發人員使用一個鬆散的基於時間的發佈過程，每兩到三個月發佈一次新的主要
+內核版本。最近的發佈歷史記錄如下：
 
 	======  =================
 	5.0	2019年3月3日
@@ -42,33 +42,33 @@
 版本包含大約13000個變更集，變更了幾十萬行代碼。因此，5.x是Linux內核開發的前
 沿；內核使用滾動開發模型，不斷集成重大變化。
 
-對於每個版本的補丁合併，遵循一個相對簡單的規則。在每個開發周期的開頭，「合併
-窗口」被打開。這時，被認爲足夠穩定（並且被開發社區接受）的代碼被合併到主線內
-核中。在這段時間內，新開發周期的大部分變更（以及所有主要變更）將以接近每天
-1000次變更（「補丁」或「變更集」）的速度合併。
+對於每個版本的補丁合併，遵循一個相對簡單的規則。在每個開發週期的開頭，“合併
+窗口”被打開。這時，被認爲足夠穩定（並且被開發社區接受）的代碼被合併到主線內
+核中。在這段時間內，新開發週期的大部分變更（以及所有主要變更）將以接近每天
+1000次變更（“補丁”或“變更集”）的速度合併。
 
 （順便說一句，值得注意的是，合併窗口期間集成的更改並不是憑空產生的；它們是經
 提前收集、測試和分級的。稍後將詳細描述該過程的工作方式。）
 
-合併窗口持續大約兩周。在這段時間結束時，LinusTorvalds將聲明窗口已關閉，並
-釋放第一個「rc」內核。例如，對於目標爲5.6的內核，在合併窗口結束時發生的釋放
+合併窗口持續大約兩週。在這段時間結束時，Linus Torvalds將聲明窗口已關閉，並
+釋放第一個“rc”內核。例如，對於目標爲5.6的內核，在合併窗口結束時發生的釋放
 將被稱爲5.6-rc1。-rc1 版本是一個信號，表示合併新特性的時間已經過去，穩定下一
 個內核的時間已經到來。
 
 在接下來的6到10周內，只有修復問題的補丁才應該提交給主線。有時會允許更大的
 更改，但這種情況很少發生；試圖在合併窗口外合併新功能的開發人員往往受不到
 友好的接待。一般來說，如果您錯過了給定特性的合併窗口，最好的做法是等待下一
-個開發周期。（偶爾會對未支持硬體的驅動程序進行例外；如果它們不改變已有代碼，
-則不會導致回歸，應該可以隨時被安全地加入）。
+個開發週期。（偶爾會對未支持硬件的驅動程序進行例外；如果它們不改變已有代碼，
+則不會導致迴歸，應該可以隨時被安全地加入）。
 
-隨著修復程序進入主線，補丁速度將隨著時間的推移而變慢。Linus大約每周發布一次
-新的-rc內核；在內核被認爲足夠穩定並最終發布前，一般會達到-rc6到-rc9之間。
+隨着修復程序進入主線，補丁速度將隨着時間的推移而變慢。Linus大約每週發佈一次
+新的-rc內核；在內核被認爲足夠穩定並最終發佈前，一般會達到-rc6到-rc9之間。
 然後，整個過程又重新開始了。
 
-例如，這裡是5.4的開發周期進行情況（2019年）:
+例如，這裏是5.4的開發週期進行情況（2019年）:
 
 	==============  ==============================
-	九月 15         5.3 穩定版發布
+	九月 15         5.3 穩定版發佈
 	九月 30         5.4-rc1 合併窗口關閉
 	十月 6          5.4-rc2
 	十月 13         5.4-rc3
@@ -77,26 +77,26 @@
 	十一月 3        5.4-rc6
 	十一月 10       5.4-rc7
 	十一月 17       5.4-rc8
-	十一月 24       5.4 穩定版發布
+	十一月 24       5.4 穩定版發佈
 	==============  ==============================
 
-開發人員如何決定何時結束開發周期並創建穩定版本？最重要的指標是以前版本的
-回歸列表。不歡迎出現任何錯誤，但是那些破壞了以前能工作的系統的錯誤被認爲是
-特別嚴重的。因此，導致回歸的補丁是不受歡迎的，很可能在穩定期內刪除。
+開發人員如何決定何時結束開發週期並創建穩定版本？最重要的指標是以前版本的
+迴歸列表。不歡迎出現任何錯誤，但是那些破壞了以前能工作的系統的錯誤被認爲是
+特別嚴重的。因此，導致迴歸的補丁是不受歡迎的，很可能在穩定期內刪除。
 
-開發人員的目標是在穩定發布之前修復所有已知的回歸。在現實世界中，這種完美是
+開發人員的目標是在穩定發佈之前修復所有已知的迴歸。在現實世界中，這種完美是
 很難實現的；在這種規模的項目中，變數太多了。需要說明的是，延遲最終版本只會
-使問題變得更糟；等待下一個合併窗口的更改將變多，導致下次出現更多的回歸錯誤。
-因此，大多數5.x內核都有一些已知的回歸錯誤，不過，希望沒有一個是嚴重的。
+使問題變得更糟；等待下一個合併窗口的更改將變多，導致下次出現更多的迴歸錯誤。
+因此，大多數5.x內核都有一些已知的迴歸錯誤，不過，希望沒有一個是嚴重的。
 
-一旦一個穩定的版本發布，它的持續維護工作就被移交給「穩定團隊」，目前由
-Greg Kroah-Hartman領導。穩定團隊將使用5.x.y編號方案不定期地發布穩定版本的
+一旦一個穩定的版本發佈，它的持續維護工作就被移交給“穩定團隊”，目前由
+Greg Kroah-Hartman領導。穩定團隊將使用5.x.y編號方案不定期地發佈穩定版本的
 更新。要合入更新版本，補丁必須（1）修復一個重要的缺陷，且（2）已經合併到
-下一個開發版本主線中。內核通常會在其初始版本後的一個以上的開發周期內收到
+下一個開發版本主線中。內核通常會在其初始版本後的一個以上的開發週期內收到
 穩定版更新。例如，5.2內核的歷史如下（2019年）：
 
 	==============  ===============================
-        七月 7 	        5.2 穩定版發布
+        七月 7 	        5.2 穩定版發佈
 	七月 13	        5.2.1
 	七月 21	        5.2.2
 	七月 26	        5.2.3
@@ -108,7 +108,7 @@ Greg Kroah-Hartman領導。穩定團隊將使用5.x.y編號方案不定期地發
 
 5.2.21是5.2版本的最終穩定更新。
 
-有些內核被指定爲「長期」內核；它們將得到更長時間的支持。在本文中，當前的長期
+有些內核被指定爲“長期”內核；它們將得到更長時間的支持。在本文中，當前的長期
 內核及其維護者是：
 
 	======  ================================	================
@@ -121,9 +121,9 @@ Greg Kroah-Hartman領導。穩定團隊將使用5.x.y編號方案不定期地發
 	======  ================================	================
 
 長期支持內核的選擇純粹是維護人員是否有需求和時間來維護該版本的問題。
-目前還沒有爲即將發布的任何特定版本提供長期支持的已知計劃。
+目前還沒有爲即將發佈的任何特定版本提供長期支持的已知計劃。
 
-補丁的生命周期
+補丁的生命週期
 --------------
 
 補丁不會直接從開發人員的鍵盤進入主線內核。相反，有一個稍微複雜（如果有些非
@@ -140,7 +140,7 @@ Greg Kroah-Hartman領導。穩定團隊將使用5.x.y編號方案不定期地發
   是在不涉及社區的情況下完成的，但是如果可能的話，最好是在公開的情況下完成
   這項工作；這樣可以節省很多稍後再重新設計的時間。
 
-- 早期評審。補丁被發布到相關的郵件列表中，列表中的開發人員會回復他們可能有
+- 早期評審。補丁被髮布到相關的郵件列表中，列表中的開發人員會回覆他們可能有
   的任何評論。如果一切順利的話，這個過程應該會發現補丁的任何主要問題。
 
 - 更廣泛的評審。當補丁接近準備好納入主線時，它應該被相關的子系統維護人員
@@ -153,48 +153,48 @@ Greg Kroah-Hartman領導。穩定團隊將使用5.x.y編號方案不定期地發
   如果您的補丁得到了需要更改的反饋，那麼您應該進行這些更改，或者解釋爲何
   不應該進行這些更改。如果您的補丁沒有評審意見，也沒有被其相應的子系統或
   驅動程序維護者接受，那麼您應該堅持不懈地將補丁更新到當前內核使其可被正常
-  應用，並不斷地發送它以供審查和合併。
+  應用，並不斷地發送它以供審查和合並。
 
 - 合併到主線。最終，一個成功的補丁將被合併到由LinusTorvalds管理的主線存儲庫
   中。此時可能會出現更多的評論和/或問題；對開發人員來說應對這些問題並解決
   出現的任何問題仍很重要。
 
-- 穩定版發布。大量用戶可能受此補丁影響，因此可能再次出現新的問題。
+- 穩定版發佈。大量用戶可能受此補丁影響，因此可能再次出現新的問題。
 
 - 長期維護。雖然開發人員在合併代碼後可能會忘記代碼，但這種行爲往往會給開發
   社區留下不良印象。合併代碼消除了一些維護負擔，因爲其他人將修復由API更改
   引起的問題。但是，如果代碼要長期保持可用，原始開發人員應該繼續爲代碼負責。
 
-內核開發人員（或他們的僱主）犯的最大錯誤之一是試圖將流程簡化爲一個「合併到
-主線」步驟。這種方法總是會讓所有相關人員感到沮喪。
+內核開發人員（或他們的僱主）犯的最大錯誤之一是試圖將流程簡化爲一個“合併到
+主線”步驟。這種方法總是會讓所有相關人員感到沮喪。
 
 補丁如何進入內核
 ----------------
 
-只有一個人可以將補丁合併到主線內核存儲庫中：LinusTorvalds。但是，在進入
+只有一個人可以將補丁合併到主線內核存儲庫中：Linus Torvalds。但是，在進入
 2.6.38內核的9500多個補丁中，只有112個（大約1.3%）是由Linus自己直接選擇的。
 內核項目已經發展到一個沒有一個開發人員可以在沒有支持的情況下檢查和選擇每個
 補丁的規模。內核開發人員處理這種增長的方式是使用圍繞信任鏈構建的助理系統。
 
 內核代碼庫在邏輯上被分解爲一組子系統：網絡、特定體系結構支持、內存管理、視
 頻設備等。大多數子系統都有一個指定的維護人員，其總體負責該子系統中的代碼。
-這些子系統維護者（鬆散地）是他們所管理的內核部分的「守門員」；他們（通常）
+這些子系統維護者（鬆散地）是他們所管理的內核部分的“守門員”；他們（通常）
 會接受一個補丁以包含到主線內核中。
 
-子系統維護人員每個人都管理著自己版本的內核原始碼樹，通常（並非總是）使用Git。
+子系統維護人員每個人都管理着自己版本的內核源代碼樹，通常（並非總是）使用Git。
 Git等工具（以及Quilt或Mercurial等相關工具）允許維護人員跟蹤補丁列表，包括作者
 信息和其他元數據。在任何給定的時間，維護人員都可以確定他或她的存儲庫中的哪
 些補丁在主線中找不到。
 
-當合併窗口打開時，頂級維護人員將要求Linus從存儲庫中「拉出」他們爲合併選擇
+當合並窗口打開時，頂級維護人員將要求Linus從存儲庫中“拉出”他們爲合併選擇
 的補丁。如果Linus同意，補丁流將流向他的存儲庫，成爲主線內核的一部分。
 Linus對拉取中接收到的特定補丁的關注程度各不相同。很明顯，有時他看起來很
-關注。但是一般來說，Linus相信子系統維護人員不會向上游發送壞補丁。
+關注。但是一般來說，Linus相信子系統維護人員不會向上遊發送壞補丁。
 
-子系統維護人員反過來也可以從其他維護人員那裡獲取補丁。例如，網絡樹是由首先
+子系統維護人員反過來也可以從其他維護人員那裏獲取補丁。例如，網絡樹是由首先
 在專用於網絡設備驅動程序、無線網絡等的樹中積累的補丁構建的。此存儲鏈可以
-任意長，但很少超過兩個或三個連結。由於鏈中的每個維護者都信任那些管理較低
-級別樹的維護者，所以這個過程稱爲「信任鏈」。
+任意長，但很少超過兩個或三個鏈接。由於鏈中的每個維護者都信任那些管理較低
+級別樹的維護者，所以這個過程稱爲“信任鏈”。
 
 顯然，在這樣的系統中，獲取內核補丁取決於找到正確的維護者。直接向Linus發送
 補丁通常不是正確的方法。
@@ -204,30 +204,30 @@ Next 樹
 
 子系統樹鏈引導補丁流到內核，但它也提出了一個有趣的問題：如果有人想查看爲
 下一個合併窗口準備的所有補丁怎麼辦？開發人員將感興趣的是，還有什麼其他的
-更改有待解決，以了解是否存在需要擔心的衝突；例如，更改核心內核函數原型的
+更改有待解決，以瞭解是否存在需要擔心的衝突；例如，更改核心內核函數原型的
 修補程序將與使用該函數舊形式的任何其他修補程序衝突。審查人員和測試人員希望
 在所有這些變更到達主線內核之前，能夠訪問它們的集成形式的變更。您可以從所有
 相關的子系統樹中提取更改，但這將是一項複雜且容易出錯的工作。
 
-解決方案以-next樹的形式出現，在這裡子系統樹被收集以供測試和審查。這些樹中
-由Andrew Morton維護的較老的一個，被稱爲「-mm」（用於內存管理，創建時爲此）。
+解決方案以-next樹的形式出現，在這裏子系統樹被收集以供測試和審查。這些樹中
+由Andrew Morton維護的較老的一個，被稱爲“-mm”（用於內存管理，創建時爲此）。
 -mm 樹集成了一長串子系統樹中的補丁；它還包含一些旨在幫助調試的補丁。
 
 除此之外，-mm 還包含大量由Andrew直接選擇的補丁。這些補丁可能已經發布在郵件
 列表上，或者它們可能應用於內核中未指定子系統樹的部分。同時，-mm 作爲最後
 手段的子系統樹；如果沒有其他明顯的路徑可以讓補丁進入主線，那麼它很可能最
 終選擇-mm 樹。累積在-mm 中的各種補丁最終將被轉發到適當的子系統樹，或者直接
-發送到Linus。在典型的開發周期中，大約5-10%的補丁通過-mm 進入主線。
+發送到Linus。在典型的開發週期中，大約5-10%的補丁通過-mm 進入主線。
 
-當前-mm 補丁可在「mmotm」（-mm of the moment）目錄中找到：
+當前-mm 補丁可在“mmotm”（-mm of the moment）目錄中找到：
 
         https://www.ozlabs.org/~akpm/mmotm/
 
 然而，使用MMOTM樹可能會十分令人頭疼；它甚至可能無法編譯。
 
-下一個周期補丁合併的主要樹是linux-next，由Stephen Rothwell 維護。根據設計
+下一個週期補丁合併的主要樹是linux-next，由Stephen Rothwell 維護。根據設計
 linux-next 是下一個合併窗口關閉後主線的快照。linux-next樹在Linux-kernel 和
-Linux-next 郵件列表中發布，可從以下位置下載：
+Linux-next 郵件列表中發佈，可從以下位置下載：
 
         https://www.kernel.org/pub/linux/kernel/next/
 
@@ -237,7 +237,7 @@ Linux-next 已經成爲內核開發過程中不可或缺的一部分；在一個
 Staging 樹
 ----------
 
-內核原始碼樹包含drivers/staging/目錄，其中有許多驅動程序或文件系統的子目錄
+內核源代碼樹包含drivers/staging/目錄，其中有許多驅動程序或文件系統的子目錄
 正在被添加到內核樹中。它們在仍然需要更多的修正的時候可以保留在driver/staging/
 目錄中；一旦完成，就可以將它們移到內核中。這是一種跟蹤不符合Linux內核編碼或
 質量標準的驅動程序的方法，人們可能希望使用它們並跟蹤開發。
@@ -251,7 +251,7 @@ Greg Kroah Hartman 目前負責維護staging 樹。仍需要修正的驅動程
 Staging 是一種讓新的驅動程序進入主線的相對容易的方法，它們會幸運地引起其他
 開發人員的注意，並迅速改進。然而，進入staging並不是故事的結尾；staging中
 沒有看到常規進展的代碼最終將被刪除。經銷商也傾向於相對不願意使用staging驅動
-程序。因此，在成爲一個合適的主線驅動的路上，staging 僅是一個中轉站。
+程序。因此，在成爲一個合適的主線驅動的路上，staging 僅是一箇中轉站。
 
 工具
 ----
@@ -260,9 +260,9 @@ Staging 是一種讓新的驅動程序進入主線的相對容易的方法，它
 能力。如果沒有適當強大的工具，整個系統將無法在任何地方正常工作。關於如何使用
 這些工具的教程遠遠超出了本文檔的範圍，但還是用一點篇幅介紹一些關鍵點。
 
-到目前爲止，內核社區使用的主要原始碼管理系統是git。Git是在自由軟體社區中開發
-的許多分布式版本控制系統之一。它非常適合內核開發，因爲它在處理大型存儲庫和
-大量補丁時性能非常好。它也以難以學習和使用而著稱，儘管隨著時間的推移它變得
+到目前爲止，內核社區使用的主要源代碼管理系統是git。Git是在自由軟件社區中開發
+的許多分佈式版本控制系統之一。它非常適合內核開發，因爲它在處理大型存儲庫和
+大量補丁時性能非常好。它也以難以學習和使用而著稱，儘管隨着時間的推移它變得
 更好了。對於內核開發人員來說，對Git的某種熟悉幾乎是一種要求；即使他們不將它
 用於自己的工作，他們也需要Git來跟上其他開發人員（以及主線）正在做的事情。
 
@@ -270,7 +270,7 @@ Staging 是一種讓新的驅動程序進入主線的相對容易的方法，它
 
         https://git-scm.com/
 
-此頁面包含了文檔和教程的連結。
+此頁面包含了文檔和教程的鏈接。
 
 在不使用git的內核開發人員中，最流行的選擇幾乎肯定是Mercurial：
 
@@ -282,16 +282,16 @@ Mercurial與Git共享許多特性，但它提供了一個界面，許多人覺
 
         https://savannah.nongnu.org/projects/quilt
 
-Quilt 是一個補丁管理系統，而不是原始碼管理系統。它不會隨著時間的推移跟蹤歷史；
+Quilt 是一個補丁管理系統，而不是源代碼管理系統。它不會隨着時間的推移跟蹤歷史；
 相反，它面向根據不斷發展的代碼庫跟蹤一組特定的更改。一些主要的子系統維護人員
-使用Quilt來管理打算向上游移動的補丁。對於某些樹的管理（例如-mm），quilt 是
+使用Quilt來管理打算向上遊移動的補丁。對於某些樹的管理（例如-mm），quilt 是
 最好的工具。
 
 郵件列表
 --------
 
 大量的Linux內核開發工作是通過郵件列表完成的。如果不加入至少一個某個列表，
-就很難成爲社區中的一個「全功能」成員。但是，Linux郵件列表對開發人員來說也是
+就很難成爲社區中的一個“全功能”成員。但是，Linux郵件列表對開發人員來說也是
 一個潛在的危險，他們可能會被一堆電子郵件淹沒、違反Linux列表上使用的約定，
 或者兩者兼而有之。
 
@@ -316,14 +316,14 @@ redhat.com/mailman/listinfo。
 
 - 不要回復挑事的人。如果有人試圖激起憤怒，請忽略他們。
 
-- 當回復Linux內核電子郵件（或其他列表上的電子郵件）時，請爲所有相關人員保留
+- 當回覆Linux內核電子郵件（或其他列表上的電子郵件）時，請爲所有相關人員保留
   Cc: 抄送頭。如果沒有確實的理由（如明確的請求），則不應刪除收件人。一定要
   確保你要回復的人在抄送列表中。這個慣例也使你不必在回覆郵件時明確要求被抄送。
 
 - 在提出問題之前，搜索列表存檔（和整個網絡）。有些開發人員可能會對那些顯然
   沒有完成家庭作業的人感到不耐煩。
 
-- 避免頂部回復（把你的答案放在你要回復的引文上面的做法）。這會讓你的回答更難
+- 避免頂部回覆（把你的答案放在你要回復的引文上面的做法）。這會讓你的回答更難
   理解，印象也很差。
 
 - 在正確的郵件列表發問。linux-kernel 可能是通用的討論場所，但它不是尋找所有
@@ -332,7 +332,7 @@ redhat.com/mailman/listinfo。
 最後一點——找到正確的郵件列表——是開發人員常出錯的地方。在linux-kernel上
 提出與網絡相關的問題的人幾乎肯定會收到一個禮貌的建議，轉到netdev列表上提出，
 因爲這是大多數網絡開發人員經常出現的列表。還有其他列表可用於scsi、video4linux、
-ide、filesystem等子系統。查找郵件列表的最佳位置是與內核原始碼一起打包的
+ide、filesystem等子系統。查找郵件列表的最佳位置是與內核源代碼一起打包的
 MAINTAINERS文件。
 
 開始內核開發
@@ -344,7 +344,7 @@ MAINTAINERS文件。
 公司通常希望聘請知名的開發人員來啓動開發團隊。實際上，這是一種有效的技術。
 但它也往往是昂貴的，而且對增加有經驗的內核開發人員的數量沒有多大幫助。考
 慮到時間投入，可以讓內部開發人員加快Linux內核的開發速度。利用這段時間可以
-讓僱主擁有一批既了解內核又了解公司的開發人員，還可以幫助培訓其他人。從中期
+讓僱主擁有一批既瞭解內核又瞭解公司的開發人員，還可以幫助培訓其他人。從中期
 來看，這通常是更有利可圖的方法。
 
 可以理解的是，單個開發人員往往對起步感到茫然。從一個大型項目開始可能會很
@@ -353,17 +353,17 @@ MAINTAINERS文件。
 這會分散整個開發社區的注意力，因此，它們越來越被人不看重。希望向社區介紹
 自己的新開發人員將無法通過這些方式獲得他們期待的反響。
 
-Andrew Morton 爲有抱負的內核開發人員提供了如下建議
+Andrew Morton 爲有抱負的內核開發人員提供瞭如下建議
 
 ::
 
-	所有內核開發者的第一個項目肯定應該是「確保內核在您可以操作的所有
-	機器上始終完美運行」。通常的方法是和其他人一起解決問題（這可能需
+	所有內核開發者的第一個項目肯定應該是“確保內核在您可以操作的所有
+	機器上始終完美運行”。通常的方法是和其他人一起解決問題（這可能需
 	要堅持！），但就是如此——這是內核開發的一部分。
 
 (http://lwn.net/Articles/283982/)
 
-在沒有明顯問題需要解決的情況下，通常建議開發人員查看當前的回歸和開放缺陷
+在沒有明顯問題需要解決的情況下，通常建議開發人員查看當前的迴歸和開放缺陷
 列表。從來都不缺少需要解決的問題；通過解決這些問題，開發人員將從該過程獲得
 經驗，同時與開發社區的其他成員建立相互尊重。
 
diff --git a/Documentation/translations/zh_TW/process/3.Early-stage.rst b/Documentation/translations/zh_TW/process/3.Early-stage.rst
index 636e506fd196..a6959e6350f4 100644
--- a/Documentation/translations/zh_TW/process/3.Early-stage.rst
+++ b/Documentation/translations/zh_TW/process/3.Early-stage.rst
@@ -26,13 +26,13 @@
 --------
 
 與任何工程項目一樣，成功的內核改善從清晰描述要解決的問題開始。在某些情況
-下，這個步驟很容易：例如當某個特定硬體需要驅動程序時。不過，在其他情況下，
+下，這個步驟很容易：例如當某個特定硬件需要驅動程序時。不過，在其他情況下，
 很容易將實際問題與建議的解決方案混在一起，這可能會導致麻煩。
 
-舉個例子：幾年前，Linux音頻的開發人員尋求一種方法來運行應用程式，而不會因
+舉個例子：幾年前，Linux音頻的開發人員尋求一種方法來運行應用程序，而不會因
 系統延遲過大而導致退出或其他問題。他們得到的解決方案是一個連接到Linux安全
-模塊（LSM）框架中的內核模塊；這個模塊可以配置爲允許特定的應用程式訪問實時
-調度程序。這個模塊被實現並發到linux-kernel郵件列表，在那裡它立即遇到了麻煩。
+模塊（LSM）框架中的內核模塊；這個模塊可以配置爲允許特定的應用程序訪問實時
+調度程序。這個模塊被實現併發到linux-kernel郵件列表，在那裏它立即遇到了麻煩。
 
 對於音頻開發人員來說，這個安全模塊足以解決他們當前的問題。但是，對於更廣泛的
 內核社區來說，這被視爲對LSM框架的濫用（LSM框架並不打算授予他們原本不具備的
@@ -41,15 +41,15 @@
 
 然而，音頻社區無法超越他們實施的特定解決方案來看問題；他們不願意接受替代方案。
 由此產生的分歧使這些開發人員對整個內核開發過程感到失望；其中一個開發人員返回
-到audio列表並發布了以下內容：
+到audio列表併發布了以下內容：
 
 	有很多非常好的Linux內核開發人員，但他們往往會被一羣傲慢的傻瓜所壓倒。
-	試圖向這些人傳達用戶需求是浪費時間。他們太「聰明」了，根本聽不到少數
+	試圖向這些人傳達用戶需求是浪費時間。他們太“聰明”了，根本聽不到少數
 	人的話。
 
 （http://lwn.net/Articles/131776/）
 
-實際情況卻是不同的；與特定模塊相比，內核開發人員更關心系統穩定性、長期維護
+實際情況卻是不同的；與特定模塊相比，內核開發人員更關心繫統穩定性、長期維護
 以及找到問題的正確解決方案。這個故事的寓意是把重點放在問題上——而不是具體的
 解決方案上——並在開始編寫代碼之前與開發社區討論這個問題。
 
@@ -72,7 +72,7 @@
 
  - 很可能問題是由內核以您不理解的方式解決的。Linux內核很大，具有許多不明顯
    的特性和功能。並不是所有的內核功能都像人們所希望的那樣有文檔記錄，而且很
-   容易遺漏一些東西。某作者發布了一個完整的驅動程序，重複了一個其不
+   容易遺漏一些東西。某作者發佈了一個完整的驅動程序，重複了一個其不
    知道的現有驅動程序。重新發明現有輪子的代碼不僅浪費，而且不會被接受到主線
    內核中。
 
@@ -83,7 +83,7 @@
    可能願意幫助創建這個解決方案。
 
 在內核開發社區的多年經驗給了我們一個明確的教訓：閉門設計和開發的內核代碼總是
-有一些問題，這些問題只有在代碼發布到社區中時才會被發現。有時這些問題很嚴重，
+有一些問題，這些問題只有在代碼發佈到社區中時纔會被發現。有時這些問題很嚴重，
 需要數月或數年的努力才能使代碼達到內核社區的標準。例如：
 
  - 設計並實現了單處理器系統的DeviceScape網絡棧。只有使其適合於多處理器系統，
@@ -103,16 +103,16 @@
 找誰交流？
 ----------
 
-當開發人員決定公開他們的計劃時，下一個問題是：我們從哪裡開始？答案是找到正確
+當開發人員決定公開他們的計劃時，下一個問題是：我們從哪裏開始？答案是找到正確
 的郵件列表和正確的維護者。對於郵件列表，最好的方法是在維護者(MAINTAINERS)文件
-中查找要發布的相關位置。如果有一個合適的子系統列表，那麼其上發布通常比在
-linux-kernel上發布更可取；您更有可能接觸到在相關子系統中具有專業知識的開發
+中查找要發佈的相關位置。如果有一個合適的子系統列表，那麼其上發佈通常比在
+linux-kernel上發佈更可取；您更有可能接觸到在相關子系統中具有專業知識的開發
 人員，並且環境可能具支持性。
 
 找到維護人員可能會有點困難。同樣，維護者文件是開始的地方。但是，該文件往往不
-是最新的，並且並非所有子系統都在那裡顯示。實際上，維護者文件中列出的人員可能
+是最新的，並且並非所有子系統都在那裏顯示。實際上，維護者文件中列出的人員可能
 不是當前實際擔任該角色的人員。因此，當對聯繫誰有疑問時，一個有用的技巧是使用
-git（尤其是「git-log」）查看感興趣的子系統中當前活動的用戶。看看誰在寫補丁、
+git（尤其是“git-log”）查看感興趣的子系統中當前活動的用戶。看看誰在寫補丁、
 誰會在這些補丁上加上Signed-off-by行簽名（如有）。這些人將是幫助新開發項目的
 最佳人選。
 
@@ -123,7 +123,7 @@ git（尤其是「git-log」）查看感興趣的子系統中當前活動的用
 
 	.../scripts/get_maintainer.pl
 
-當給定「-f」選項時，此腳本將返回指定文件或目錄的當前維護者。如果在命令行上
+當給定“-f”選項時，此腳本將返回指定文件或目錄的當前維護者。如果在命令行上
 給出了一個補丁，它將列出可能接收補丁副本的維護人員。有許多選項可以調節
 get_maintainer.pl搜索維護者的嚴格程度；請小心使用更激進的選項，因爲最終結果
 可能會包括對您正在修改的代碼沒有真正興趣的開發人員。
@@ -134,17 +134,17 @@ get_maintainer.pl搜索維護者的嚴格程度；請小心使用更激進的選
 何時郵寄？
 ----------
 
-如果可能的話，在早期階段發布你的計劃只會更有幫助。描述正在解決的問題以及已經
+如果可能的話，在早期階段發佈你的計劃只會更有幫助。描述正在解決的問題以及已經
 制定的關於如何實施的任何計劃。您可以提供的任何信息都可以幫助開發社區爲項目
 提供有用的輸入。
 
 在這個階段可能發生的一件令人沮喪的事情不是得到反對意見，而是很少或根本沒有
 反饋。令人傷心的事實是：（1）內核開發人員往往很忙；（2）不缺少有宏偉計劃但
 代碼（甚至代碼設想）很少的人去支持他們；（3）沒有人有義務審查或評論別人發表
-的想法。除此之外，高層級的設計常常隱藏著一些問題，這些問題只有在有人真正嘗試
-實現這些設計時才會被發現；因此，內核開發人員寧願看到代碼。
+的想法。除此之外，高層級的設計常常隱藏着一些問題，這些問題只有在有人真正嘗試
+實現這些設計時纔會被發現；因此，內核開發人員寧願看到代碼。
 
-如果發布請求評論（RFC）並沒得到什麼有用的評論，不要以爲這意味著無人對此項目
+如果發佈請求評論（RFC）並沒得到什麼有用的評論，不要以爲這意味着無人對此項目
 有興趣，同時你也不能假設你的想法沒有問題。在這種情況下，最好的做法是繼續進
 行，把你的進展隨時通知社區。
 
@@ -152,12 +152,12 @@ get_maintainer.pl搜索維護者的嚴格程度；請小心使用更激進的選
 -----------------------
 
 如果您的工作是在公司環境中完成的，就像大多數Linux內核工作一樣；顯然，在您將
-公司的計劃或代碼發布到公共郵件列表之前，必須獲得有適當權利經理的許可。發布
-不確定是否兼容GPL的代碼尤其會帶來問題；公司的管理層和法律人員越早能夠就發布
+公司的計劃或代碼發佈到公共郵件列表之前，必須獲得有適當權利經理的許可。發佈
+不確定是否兼容GPL的代碼尤其會帶來問題；公司的管理層和法律人員越早能夠就發佈
 內核開發項目達成一致，對參與的每個人都越好。
 
 一些讀者可能會認爲他們的核心工作是爲了支持還沒有正式承認存在的產品。將僱主
-的計劃公布在公共郵件列表上可能不是一個可行的選擇。在這種情況下，有必要考慮
+的計劃公佈在公共郵件列表上可能不是一個可行的選擇。在這種情況下，有必要考慮
 保密是否真的是必要的；通常不需要把開發計劃關在門內。
 
 的確，有些情況下一家公司在開發過程的早期無法合法地披露其計劃。擁有經驗豐富
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index adb5339aab6a..5baea1a2e5ad 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -19,7 +19,7 @@
 ======================
 
 雖然一個堅實的、面向社區的設計過程有很多值得說道的，但是任何內核開發項目工作
-的證明都反映在代碼中。它是將由其他開發人員檢查併合並（或不合併）到主線樹中
+的證明都反映在代碼中。它是將由其他開發人員檢查併合並（或不合並）到主線樹中
 的代碼。所以這段代碼的質量決定了項目的最終成功。
 
 本節將檢查編碼過程。我們將從內核開發人員常犯的幾種錯誤開始。然後重點將轉移
@@ -42,7 +42,7 @@
 開發人員能夠快速理解其中的任何部分。所以再也經不起奇怪格式的代碼的折騰了。
 
 內核的代碼風格偶爾會與僱主的強制風格發生衝突。在這種情況下，必須在代碼合併
-之前遵從內核代碼風格。將代碼放入內核意味著以多種方式放棄一定程度的控制權——
+之前遵從內核代碼風格。將代碼放入內核意味着以多種方式放棄一定程度的控制權——
 包括控制代碼樣式。
 
 另一個危害是認爲已經在內核中的代碼迫切需要修復代碼樣式。開發者可能會開始編寫
@@ -70,21 +70,21 @@
 簡單點，先考慮一個調用時始終只有一個參數且總爲零的函數。我們可以保留這個參數，
 以在需要使用它時提供的額外靈活性。不過，在那時實現了這個額外參數的代碼很有
 可能以某種從未被注意到的微妙方式被破壞——因爲它從未被使用過。或者當需要額外
-的靈活性時，它並未以符合程式設計師當初期望的方式來實現。內核開發人員通常會提交
+的靈活性時，它並未以符合程序員當初期望的方式來實現。內核開發人員通常會提交
 補丁來刪除未使用的參數；一般來說，一開始就不應該添加這些參數。
 
-隱藏硬體訪問的抽象層——通常爲了允許大量的驅動程序兼容多個作業系統——尤其不受
+隱藏硬件訪問的抽象層——通常爲了允許大量的驅動程序兼容多個操作系統——尤其不受
 歡迎。這樣的層使代碼變得模糊，可能會造成性能損失；它們不屬於Linux內核。
 
 另一方面，如果您發現自己從另一個內核子系統複製了大量的代碼，那麼是時候
-了解一下：是否需要將這些代碼中的部分提取到單獨的庫中，或者在更高的層次上
+瞭解一下：是否需要將這些代碼中的部分提取到單獨的庫中，或者在更高的層次上
 實現這些功能。在整個內核中複製相同的代碼沒有價值。
 
 #ifdef 和預處理
 ***************
 
-C預處理器似乎給一些C程式設計師帶來了強大的誘惑，他們認爲它是一種將大量靈活性加入
-原始碼中的方法。但是預處理器不是C，大量使用它會導致代碼對其他人來說更難閱讀，
+C預處理器似乎給一些C程序員帶來了強大的誘惑，他們認爲它是一種將大量靈活性加入
+源代碼中的方法。但是預處理器不是C，大量使用它會導致代碼對其他人來說更難閱讀，
 對編譯器來說更難檢查正確性。使用了大量預處理器幾乎總是代碼需要一些
 清理工作的標誌。
 
@@ -100,23 +100,23 @@ C預處理器宏存在許多危險性，包括可能對具有副作用且沒有
 內聯函數
 ********
 
-不過，內聯函數本身也存在風險。程式設計師可以傾心於避免函數調用和用內聯函數填充源
+不過，內聯函數本身也存在風險。程序員可以傾心於避免函數調用和用內聯函數填充源
 文件所固有的效率。然而，這些功能實際上會降低性能。因爲它們的代碼在每個調用站
-點都被複製一遍，所以最終會增加編譯內核的大小。此外，這也對處理器的內存緩存
+點都被複制一遍，所以最終會增加編譯內核的大小。此外，這也對處理器的內存緩存
 造成壓力，從而大大降低執行速度。通常內聯函數應該非常小，而且相對較少。畢竟
 函數調用的成本並不高；大量創建內聯函數是過早優化的典型例子。
 
-一般來說，內核程式設計師會自冒風險忽略緩存效果。在數據結構課程開頭中的經典
-時間/空間權衡通常不適用於當代硬體。空間 *就是* 時間，因爲一個大的程序比一個
+一般來說，內核程序員會自冒風險忽略緩存效果。在數據結構課程開頭中的經典
+時間/空間權衡通常不適用於當代硬件。空間 *就是* 時間，因爲一個大的程序比一個
 更緊湊的程序運行得慢。
 
 較新的編譯器越來越激進地決定一個給定函數是否應該內聯。因此，隨意放置使用
-「inline」關鍵字可能不僅僅是過度的，也可能是無用的。
+“inline”關鍵字可能不僅僅是過度的，也可能是無用的。
 
 鎖
 **
 
-2006年5月，「deviceescape」網絡堆棧在前呼後擁下以GPL發布，並被納入主線內核。
+2006年5月，“deviceescape”網絡堆棧在前呼後擁下以GPL發佈，並被納入主線內核。
 這是一個受歡迎的消息；Linux中對無線網絡的支持充其量被認爲是不合格的，而
 Deviceescape堆棧承諾修復這種情況。然而直到2007年6月（2.6.22），這段代碼才真
 正進入主線。發生了什麼？
@@ -125,25 +125,25 @@ Deviceescape堆棧承諾修復這種情況。然而直到2007年6月（2.6.22）
 設計。在合併這個網絡堆棧（現在稱爲mac80211）之前，需要對其進行一個鎖方案的
 改造。
 
-曾經，Linux內核代碼可以在不考慮多處理器系統所帶來的並發性問題的情況下進行
+曾經，Linux內核代碼可以在不考慮多處理器系統所帶來的併發性問題的情況下進行
 開發。然而現在，這個文檔就是在雙核筆記本電腦上寫的。即使在單處理器系統上，
-爲提高響應能力所做的工作也會提高內核內的並發性水平。編寫內核代碼而不考慮鎖
+爲提高響應能力所做的工作也會提高內核內的併發性水平。編寫內核代碼而不考慮鎖
 的日子早已遠去。
 
-可以由多個線程並發訪問的任何資源（數據結構、硬體寄存器等）必須由鎖保護。新
+可以由多個線程併發訪問的任何資源（數據結構、硬件寄存器等）必須由鎖保護。新
 的代碼應該謹記這一要求；事後修改鎖是一項相當困難的任務。內核開發人員應該花
-時間充分了解可用的鎖原語，以便爲工作選擇正確的工具。對並發性缺乏關注的代碼
+時間充分了解可用的鎖原語，以便爲工作選擇正確的工具。對併發性缺乏關注的代碼
 很難進入主線。
 
-回歸
+迴歸
 ****
 
-最後一個值得一提的危險是回歸：它可能會引起導致現有用戶的某些東西中斷的改變
-（這也可能會帶來很大的改進）。這種變化被稱爲「回歸」，回歸已經成爲主線內核
-最不受歡迎的問題。除了少數例外情況，如果回歸不能及時修正，會導致回歸的修改
-將被取消。最好首先避免回歸發生。
+最後一個值得一提的危險是迴歸：它可能會引起導致現有用戶的某些東西中斷的改變
+（這也可能會帶來很大的改進）。這種變化被稱爲“迴歸”，迴歸已經成爲主線內核
+最不受歡迎的問題。除了少數例外情況，如果迴歸不能及時修正，會導致迴歸的修改
+將被取消。最好首先避免迴歸發生。
 
-人們常常爭論，如果回歸帶來的功能遠超過產生的問題，那麼回歸是否爲可接受的。
+人們常常爭論，如果迴歸帶來的功能遠超過產生的問題，那麼迴歸是否爲可接受的。
 如果它破壞了一個系統卻爲十個系統帶來新的功能，爲何不改改態度呢？2007年7月，
 Linus對這個問題給出了最佳答案:
 
@@ -154,7 +154,7 @@ Linus對這個問題給出了最佳答案:
 
 （http://lwn.net/Articles/243460/）
 
-特別不受歡迎的一種回歸類型是用戶空間ABI的任何變化。一旦接口被導出到用戶空間，
+特別不受歡迎的一種迴歸類型是用戶空間ABI的任何變化。一旦接口被導出到用戶空間，
 就必須無限期地支持它。這一事實使得用戶空間接口的創建特別具有挑戰性：因爲它們
 不能以不兼容的方式進行更改，所以必須一次就對。因此，用戶空間接口總是需要大量
 的思考、清晰的文檔和廣泛的審查。
@@ -171,19 +171,19 @@ Linus對這個問題給出了最佳答案:
 
 第一步是注意編譯器產生的警告。當前版本的GCC可以檢測（並警告）大量潛在錯誤。
 通常，這些警告都指向真正的問題。提交以供審閱的代碼一般不會產生任何編譯器警告。
-在消除警告時，注意了解真正的原因，並儘量避免僅「修復」使警告消失而不解決其原因。
+在消除警告時，注意瞭解真正的原因，並儘量避免僅“修復”使警告消失而不解決其原因。
 
-請注意，並非所有編譯器警告都默認啓用。使用「make KCFLAGS=-W」構建內核以
+請注意，並非所有編譯器警告都默認啓用。使用“make KCFLAGS=-W”構建內核以
 獲得完整集合。
 
-內核提供了幾個配置選項，可以打開調試功能；大多數配置選項位於「kernel hacking」
+內核提供了幾個配置選項，可以打開調試功能；大多數配置選項位於“kernel hacking”
 子菜單中。對於任何用於開發或測試目的的內核，都應該啓用其中幾個選項。特別是，
 您應該打開：
 
  - FRAME_WARN 獲取大於給定數量的堆棧幀的警告。
    這些警告生成的輸出可能比較冗長，但您不必擔心來自內核其他部分的警告。
 
- - DEBUG_OBJECTS 將添加代碼以跟蹤內核創建的各種對象的生命周期，並在出現問題
+ - DEBUG_OBJECTS 將添加代碼以跟蹤內核創建的各種對象的生命週期，並在出現問題
    時發出警告。如果你要添加創建（和導出）關於其自己的複雜對象的子系統，請
    考慮打開對象調試基礎結構的支持。
 
@@ -195,34 +195,34 @@ Linus對這個問題給出了最佳答案:
 還有很多其他調試選項，其中一些將在下面討論。其中一些有顯著的性能影響，不應
 一直使用。在學習可用選項上花費一些時間，可能會在短期內得到許多回報。
 
-其中一個較重的調試工具是鎖檢查器或「lockdep」。該工具將跟蹤系統中每個鎖
+其中一個較重的調試工具是鎖檢查器或“lockdep”。該工具將跟蹤系統中每個鎖
 （spinlock或mutex）的獲取和釋放、獲取鎖的相對順序、當前中斷環境等等。然後，
 它可以確保總是以相同的順序獲取鎖，相同的中斷假設適用於所有情況等等。換句話
 說，lockdep可以找到許多導致系統死鎖的場景。在部署的系統中，這種問題可能會
 很痛苦（對於開發人員和用戶而言）；LockDep允許提前以自動方式發現問題。具有
-任何類型的非普通鎖的代碼在提交合併前應在啓用lockdep的情況下運行測試。
+任何類型的非普通鎖的代碼在提交合並前應在啓用lockdep的情況下運行測試。
 
-作爲一個勤奮的內核程式設計師，毫無疑問，您將檢查任何可能失敗的操作（如內存分配）
+作爲一個勤奮的內核程序員，毫無疑問，您將檢查任何可能失敗的操作（如內存分配）
 的返回狀態。然而，事實上，最終的故障復現路徑可能完全沒有經過測試。未測試的
 代碼往往會出問題；如果所有這些錯誤處理路徑都被執行了幾次，那麼您可能對代碼
 更有信心。
 
 內核提供了一個可以做到這一點的錯誤注入框架，特別是在涉及內存分配的情況下。
 啓用故障注入後，內存分配的可配置失敗的百分比；這些失敗可以限定在特定的代碼
-範圍內。在啓用了故障注入的情況下運行，程式設計師可以看到當情況惡化時代碼如何響
+範圍內。在啓用了故障注入的情況下運行，程序員可以看到當情況惡化時代碼如何響
 應。有關如何使用此工具的詳細信息，請參閱
 Documentation/fault-injection/fault-injection.rst。
 
-「sparse」靜態分析工具可以發現其他類型的錯誤。sparse可以警告程式設計師用戶空間
+“sparse”靜態分析工具可以發現其他類型的錯誤。sparse可以警告程序員用戶空間
 和內核空間地址之間的混淆、大端序與小端序的混淆、在需要一組位標誌的地方傳遞
-整數值等等。sparse必須單獨安裝(如果您的分發伺服器沒有將其打包，
+整數值等等。sparse必須單獨安裝(如果您的分發服務器沒有將其打包，
 可以在 https://sparse.wiki.kernel.org/index.php/Main_page 找到）,
-然後可以通過在make命令中添加「C=1」在代碼上運行它。
+然後可以通過在make命令中添加“C=1”在代碼上運行它。
 
-「Coccinelle」工具 :ref:`http://coccinelle.lip6.fr/ <devtools_coccinelle>`
-能夠發現各種潛在的編碼問題；它還可以爲這些問題提出修複方案。在
-scripts/coccinelle目錄下已經打包了相當多的內核「語義補丁」；運行
-「make coccicheck」將運行這些語義補丁並報告發現的任何問題。有關詳細信息，請參閱
+“Coccinelle”工具 :ref:`http://coccinelle.lip6.fr/ <devtools_coccinelle>`
+能夠發現各種潛在的編碼問題；它還可以爲這些問題提出修復方案。在
+scripts/coccinelle目錄下已經打包了相當多的內核“語義補丁”；運行
+“make coccicheck”將運行這些語義補丁並報告發現的任何問題。有關詳細信息，請參閱
 :ref:`Documentation/dev-tools/coccinelle.rst <devtools_coccinelle>`
 
 
@@ -247,7 +247,7 @@ scripts/coccinelle目錄下已經打包了相當多的內核「語義補丁」
 
 任何添加新用戶空間接口的代碼——包括新的sysfs或/proc文件——都應該包含該接口
 的文檔，該文檔使用戶空間開發人員能夠知道他們在使用什麼。請參閱
-Documentation/ABI/README，了解如何此文檔格式以及需要提供哪些信息。
+Documentation/ABI/README，瞭解如何此文檔格式以及需要提供哪些信息。
 
 文檔 :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
 描述了內核的所有引導時間參數。任何添加新參數的補丁都應該向該文檔添加適當的
@@ -256,27 +256,27 @@ Documentation/ABI/README，了解如何此文檔格式以及需要提供哪些
 任何新的配置選項都必須附有幫助文本，幫助文本需清楚地解釋這些選項以及用戶可能
 希望何時使用它們。
 
-許多子系統的內部API信息通過專門格式化的注釋進行記錄；這些注釋可以通過
-「kernel-doc」腳本以多種方式提取和格式化。如果您在具有kerneldoc注釋的子系統中
+許多子系統的內部API信息通過專門格式化的註釋進行記錄；這些註釋可以通過
+“kernel-doc”腳本以多種方式提取和格式化。如果您在具有kerneldoc註釋的子系統中
 工作，則應該維護它們，並根據需要爲外部可用的功能添加它們。即使在沒有如此記錄
-的領域中，爲將來添加kerneldoc注釋也沒有壞處；實際上，這對於剛開始開發內核的人
-來說是一個有用的活動。這些注釋的格式以及如何創建kerneldoc模板的一些信息可以在
+的領域中，爲將來添加kerneldoc註釋也沒有壞處；實際上，這對於剛開始開發內核的人
+來說是一個有用的活動。這些註釋的格式以及如何創建kerneldoc模板的一些信息可以在
 :ref:`Documentation/doc-guide/ <doc_guide>` 上找到。
 
-任何閱讀大量現有內核代碼的人都會注意到，注釋的缺失往往是最值得注意的。同時，
-對新代碼的要求比過去更高；合併未注釋的代碼將更加困難。這就是說，人們並不期望
-詳細注釋的代碼。代碼本身應該是自解釋的，注釋闡釋了更微妙的方面。
+任何閱讀大量現有內核代碼的人都會注意到，註釋的缺失往往是最值得注意的。同時，
+對新代碼的要求比過去更高；合併未註釋的代碼將更加困難。這就是說，人們並不期望
+詳細註釋的代碼。代碼本身應該是自解釋的，註釋闡釋了更微妙的方面。
 
-某些事情應該總是被注釋。使用內存屏障時，應附上一行文字，解釋爲什麼需要設置內存
+某些事情應該總是被註釋。使用內存屏障時，應附上一行文字，解釋爲什麼需要設置內存
 屏障。數據結構的鎖規則通常需要在某個地方解釋。一般來說，主要數據結構需要全面
 的文檔。應該指出代碼中分立的位之間不明顯的依賴性。任何可能誘使代碼管理人進行
-錯誤的「清理」的事情都需要一個注釋來說明爲什麼要這樣做。等等。
+錯誤的“清理”的事情都需要一個註釋來說明爲什麼要這樣做。等等。
 
 
 內部API更改
 -----------
 
-內核提供給用戶空間的二進位接口不能被破壞，除非逼不得已。而內核的內部編程接口
+內核提供給用戶空間的二進制接口不能被破壞，除非逼不得已。而內核的內部編程接口
 是高度流動的，當需要時可以更改。如果你發現自己不得不處理一個內核API，或者僅
 僅因爲它不滿足你的需求導致無法使用特定的功能，這可能是API需要改變的一個標誌。
 作爲內核開發人員，您有權進行此類更改。
@@ -287,7 +287,7 @@ Documentation/ABI/README，了解如何此文檔格式以及需要提供哪些
 
 另一個要點是，更改內部API的開發人員通常要負責修復內核樹中被更改破壞的任何代碼。
 對於一個廣泛使用的函數，這個責任可以導致成百上千的變化，其中許多變化可能與其他
-開發人員正在做的工作相衝突。不用說，這可能是一項大工程，所以最好確保理由是
+開發人員正在做的工作相沖突。不用說，這可能是一項大工程，所以最好確保理由是
 可靠的。請注意，coccinelle工具可以幫助進行廣泛的API更改。
 
 在進行不兼容的API更改時，應儘可能確保編譯器捕獲未更新的代碼。這將幫助您確保找
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index 27015622ad63..a82b15f0d49a 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -15,27 +15,27 @@
 
 .. _tw_development_posting:
 
-發布補丁
+發佈補丁
 ========
 
 您的工作遲早會準備好提交給社區進行審查，並最終包含到主線內核中。毫不稀奇，
-內核開發社區已經發展出一套用於發布補丁的約定和過程；遵循這些約定和過程將使
+內核開發社區已經發展出一套用於發佈補丁的約定和過程；遵循這些約定和過程將使
 參與其中的每個人的生活更加輕鬆。本文檔試圖描述這些約定的部分細節；更多信息
 也可在以下文檔中找到
 :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 和 :ref:`Documentation/translations/zh_TW/process/submit-checklist.rst <tw_submitchecklist>`。
 
-何時郵寄
+何時寄送
 --------
 
-在補丁完全「準備好」之前，避免發布補丁是一種持續的誘惑。對於簡單的補丁，這
+在補丁完全“準備好”之前，避免發佈補丁是一種持續的誘惑。對於簡單的補丁，這
 不是問題。但是如果正在完成的工作很複雜，那麼在工作完成之前從社區獲得反饋就
-可以獲得很多好處。因此，您應該考慮發布正在進行的工作，甚至維護一個可用的Git
+可以獲得很多好處。因此，您應該考慮發佈正在進行的工作，甚至維護一個可用的Git
 樹，以便感興趣的開發人員可以隨時趕上您的工作。
 
-當發布中有尚未準備好被包含的代碼，最好在發布中說明。還應提及任何有待完成的
+當發佈中有尚未準備好被包含的代碼，最好在發佈中說明。還應提及任何有待完成的
 主要工作和任何已知問題。很少有人會願意看那些被認爲是半生不熟的補丁，但是
-那些願意的人會帶著他們的點子來一起幫助你把工作推向正確的方向。
+那些願意的人會帶着他們的點子來一起幫助你把工作推向正確的方向。
 
 創建補丁之前
 ------------
@@ -50,20 +50,20 @@
  - 您的更改是否具有性能影響？如果是這樣，您應該運行基準測試來顯示您的變更的
    影響（或好處）；結果的摘要應該包含在補丁中。
 
- - 確保您有權發布代碼。如果這項工作是爲僱主完成的，僱主對這項工作具有所有權，
-   並且必須同意根據GPL對其進行發布。
+ - 確保您有權發佈代碼。如果這項工作是爲僱主完成的，僱主對這項工作具有所有權，
+   並且必須同意根據GPL對其進行發佈。
 
-一般來說，在發布代碼之前進行一些額外的思考，幾乎總是能在短時間內得到回報。
+一般來說，在發佈代碼之前進行一些額外的思考，幾乎總是能在短時間內得到回報。
 
 補丁準備
 --------
 
-準備補丁發布的工作量可能很驚人，但在此嘗試節省時間通常是不明智的，即使在短期
+準備補丁發佈的工作量可能很驚人，但在此嘗試節省時間通常是不明智的，即使在短期
 內亦然。
 
 必須針對內核的特定版本準備補丁。一般來說，補丁應該基於Linus的Git樹中的當前
-主線。當以主線爲基礎時，請從一個衆所周知的發布點開始——如穩定版本或 -rc
-版本發布點——而不是在一個任意的主線分支點。
+主線。當以主線爲基礎時，請從一個衆所周知的發佈點開始——如穩定版本或 -rc
+版本發佈點——而不是在一個任意的主線分支點。
 
 也可能需要針對-mm、linux-next或子系統樹生成版本，以便於更廣泛的測試和審查。
 根據補丁的區域以及其他地方的情況，針對其他樹建立的補丁可能需要大量的工作來
@@ -73,12 +73,12 @@
 分割補丁是一門藝術；一些開發人員花了很長時間來弄清楚如何按照社區期望的方式來
 分割。不過，這些經驗法則也許有幫助：
 
- - 您發布的補丁系列幾乎肯定不會是開發過程中版本控制系統中的一系列更改。相反，
+ - 您發佈的補丁系列幾乎肯定不會是開發過程中版本控制系統中的一系列更改。相反，
    需要對您所做更改的最終形式加以考慮，然後以有意義的方式進行拆分。開發人員對
    離散的、自包含的更改感興趣，而不是您創造這些更改的原始路徑。
 
- - 每個邏輯上獨立的變更都應該格式化爲單獨的補丁。這些更改可以是小的（如「向
-   此結構體添加欄位」）或大的（如添加一個重要的新驅動程序），但它們在概念上
+ - 每個邏輯上獨立的變更都應該格式化爲單獨的補丁。這些更改可以是小的（如“向
+   此結構體添加字段”）或大的（如添加一個重要的新驅動程序），但它們在概念上
    應該是小的，並且可以在一行內簡述。每個補丁都應該做一個特定的、可以單獨
    檢查並驗證它所做的事情的更改。
 
@@ -88,34 +88,34 @@
 
  - 每個補丁都應該能創建一個可以正確地構建和運行的內核；如果補丁系列在中間被
    斷開，那麼結果仍應是一個正常工作的內核。部分應用一系列補丁是使用
-   「git bisct」工具查找回歸的一個常見場景；如果結果是一個損壞的內核，那麼將使
+   “git bisct”工具查找回歸的一個常見場景；如果結果是一個損壞的內核，那麼將使
    那些從事追蹤問題的高尚工作的開發人員和用戶的生活更加艱難。
 
  - 不要過分分割。一位開發人員曾經將一組針對單個文件的編輯分成500個單獨的補丁
-   發布，這並沒有使他成爲內核郵件列表中最受歡迎的人。一個補丁可以相當大，
+   發佈，這並沒有使他成爲內核郵件列表中最受歡迎的人。一個補丁可以相當大，
    只要它仍然包含一個單一的 *邏輯* 變更。
 
  - 用一系列補丁添加一個全新的基礎設施，但是該設施在系列中的最後一個補丁啓用
    整個變更之前不能使用，這看起來很誘人。如果可能的話，應該避免這種誘惑；
-   如果這個系列增加了回歸，那麼二分法將指出最後一個補丁是導致問題的補丁，
+   如果這個系列增加了迴歸，那麼二分法將指出最後一個補丁是導致問題的補丁，
    即使真正的bug在其他地方。只要有可能，添加新代碼的補丁程序應該立即激活該
    代碼。
 
-創建完美補丁系列的工作可能是一個令人沮喪的過程，在完成「真正的工作」之後需要
+創建完美補丁系列的工作可能是一個令人沮喪的過程，在完成“真正的工作”之後需要
 花費大量的時間和思考。但是如果做得好，花費的時間就是值得的。
 
 補丁格式和更改日誌
 ------------------
 
-所以現在你有了一系列完美的補丁可以發布，但是這項工作還沒有完成。每個補丁都
+所以現在你有了一系列完美的補丁可以發佈，但是這項工作還沒有完成。每個補丁都
 需要被格式化成一條消息，以快速而清晰地將其目的傳達到世界其他地方。爲此，
 每個補丁將由以下部分組成：
 
- - 可選的「From」行，表明補丁作者。只有當你通過電子郵件發送別人的補丁時，這一行
-   才是必須的，但是爲防止疑問加上它也不會有什麼壞處。
+ - 可選的“From”行，表明補丁作者。只有當你通過電子郵件發送別人的補丁時，這一行
+   纔是必須的，但是爲防止疑問加上它也不會有什麼壞處。
 
  - 一行描述，說明補丁的作用。對於在沒有其他上下文的情況下看到該消息的讀者來說，
-   該消息應足以確定修補程序的範圍；此行將顯示在「short form（簡短格式）」變更
+   該消息應足以確定修補程序的範圍；此行將顯示在“short form（簡短格式）”變更
    日誌中。此消息通常需要先加上子系統名稱前綴，然後是補丁的目的。例如：
 
    ::
@@ -144,13 +144,13 @@
 一般來說，你越把自己放在每個閱讀你變更日誌的人的位置上，變更日誌（和內核
 作爲一個整體）就越好。
 
-不消說，變更日誌是將變更提交到版本控制系統時使用的文本。接下來將是：
+不需要說，變更日誌是將變更提交到版本控制系統時使用的文本。接下來將是：
 
- - 補丁本身，採用統一的（「-u」）補丁格式。使用「-p」選項來diff將使函數名與
+ - 補丁本身，採用統一的（“-u”）補丁格式。使用“-p”選項來diff將使函數名與
    更改相關聯，從而使結果補丁更容易被其他人讀取。
 
 您應該避免在補丁中包括與更改不相關文件（例如，構建過程生成的文件或編輯器
-備份文件）。文檔目錄中的「dontdiff」文件在這方面有幫助；使用「-X」選項將
+備份文件）。文檔目錄中的“dontdiff”文件在這方面有幫助；使用“-X”選項將
 其傳遞給diff。
 
 上面提到的標籤（tag）用於描述各種開發人員如何與這個補丁的開發相關聯。
@@ -188,10 +188,10 @@
 
 在補丁中添加標籤時要小心：只有Cc:才適合在沒有指定人員明確許可的情況下添加。
 
-發送補丁
+寄送補丁
 --------
 
-在寄出補丁之前，您還需要注意以下幾點：
+在寄送補丁之前，您還需要注意以下幾點：
 
  - 您確定您的郵件發送程序不會損壞補丁嗎？被郵件客戶端更改空白或修飾了行的補丁
    無法被另一端接受，並且通常不會進行任何詳細檢查。如果有任何疑問，先把補丁寄
@@ -209,12 +209,12 @@
 引用補丁的部分。相反，只需將補丁直接放到您的消息中。
 
 寄出補丁時，重要的是將副本發送給任何可能感興趣的人。與其他一些項目不同，內核
-鼓勵人們甚至錯誤地發送過多的副本；不要假定相關人員會看到您在郵件列表中的發布。
+鼓勵人們甚至錯誤地發送過多的副本；不要假定相關人員會看到您在郵件列表中的發佈。
 尤其是，副本應發送至：
 
  - 受影響子系統的維護人員。如前所述，維護人員文件是查找這些人員的首選地方。
 
- - 其他在同一領域工作的開發人員，尤其是那些現在可能在那裡工作的開發人員。使用
+ - 其他在同一領域工作的開發人員，尤其是那些現在可能在那裏工作的開發人員。使用
    git查看還有誰修改了您正在處理的文件，這很有幫助。
 
  - 如果您對某錯誤報告或功能請求做出響應，也可以抄送原始發送人。
@@ -223,7 +223,7 @@
 
  - 如果您正在修復一個缺陷，請考慮該修復是否應進入下一個穩定更新。如果是這樣，
    補丁副本也應發到stable@vger.kernel.org 。另外，在補丁本身的標籤中添加一個
-   「Cc: stable@vger.kernel.org」；這將使穩定版團隊在修復進入主線時收到通知。
+   “Cc: stable@vger.kernel.org”；這將使穩定版團隊在修復進入主線時收到通知。
 
 當爲一個補丁選擇接收者時，最好清楚你認爲誰最終會接受這個補丁並將其合併。雖然
 可以將補丁直接發給Linus Torvalds並讓他合併，但通常情況下不會這樣做。Linus很
@@ -236,7 +236,7 @@
 
 	[PATCH nn/mm] subsys: one-line description of the patch
 
-其中「nn」是補丁的序號，「mm」是系列中補丁的總數，「subsys」是受影響子系統的
+其中“nn”是補丁的序號，“mm”是系列中補丁的總數，“subsys”是受影響子系統的
 名稱。當然，一個單獨的補丁可以省略nn/mm。
 
 如果您有一系列重要的補丁，那麼通常發送一個簡介作爲第〇部分。不過，這個約定
diff --git a/Documentation/translations/zh_TW/process/6.Followthrough.rst b/Documentation/translations/zh_TW/process/6.Followthrough.rst
index 5073b6e77c1c..bcc885ae1b8e 100644
--- a/Documentation/translations/zh_TW/process/6.Followthrough.rst
+++ b/Documentation/translations/zh_TW/process/6.Followthrough.rst
@@ -18,13 +18,13 @@
 跟進
 ====
 
-此時，您已經遵循了到目前爲止給出的指導方針，並且，隨著您自己的工程技能的增加，
+此時，您已經遵循了到目前爲止給出的指導方針，並且，隨着您自己的工程技能的增加，
 已經發布了一系列完美的補丁。即使是經驗豐富的內核開發人員也能犯的最大錯誤之一
-是，認爲他們的工作現在已經完成了。事實上，發布補丁意味著進入流程的下一個階段，
+是，認爲他們的工作現在已經完成了。事實上，發佈補丁意味着進入流程的下一個階段，
 可能還需要做很多工作。
 
-一個補丁在首次發布時就非常出色、沒有改進的餘地，這是很罕見的。內核開發流程已
-認識到這一事實，因此它非常注重對已發布代碼的改進。作爲代碼的作者，您應該與
+一個補丁在首次發佈時就非常出色、沒有改進的餘地，這是很罕見的。內核開發流程已
+認識到這一事實，因此它非常注重對已發佈代碼的改進。作爲代碼的作者，您應該與
 內核社區合作，以確保您的代碼符合內核的質量標準。如果不參與這個過程，很可能會
 無法將補丁合併到主線中。
 
@@ -41,7 +41,7 @@
    調整到大量的重寫——都來自於對Linux的理解，即從現在起十年後，Linux仍將
    在開發中。
 
- - 代碼審查是一項艱苦的工作，這是一項相對吃力不討好的工作；人們記得誰編寫了
+ - 代碼審查是一項艱苦的工作，這是一項相對喫力不討好的工作；人們記得誰編寫了
    內核代碼，但對於那些審查它的人來說，幾乎沒有什麼長久的名聲。因此，審閱
    人員可能會變得暴躁，尤其是當他們看到同樣的錯誤被一遍又一遍地犯下時。如果
    你得到了一個看起來憤怒、侮辱或完全冒犯你的評論，請抑制以同樣方式回應的衝動。
@@ -54,7 +54,7 @@
 
 所有這些歸根結底就是，當審閱者向您發送評論時，您需要注意他們正在進行的技術
 評論。不要讓他們的表達方式或你自己的驕傲阻止此事。當你在一個補丁上得到評論
-時，花點時間去理解評論人想說什麼。如果可能的話，請修覆審閱者要求您修復的內
+時，花點時間去理解評論人想說什麼。如果可能的話，請修復審閱者要求您修復的內
 容。然後回覆審閱者：謝謝他們，並描述你將如何回答他們的問題。
 
 請注意，您不必同意審閱者建議的每個更改。如果您認爲審閱者誤解了您的代碼，請
@@ -65,19 +65,19 @@
 是錯誤的，或者你甚至沒有解決正確的問題。
 
 Andrew Morton建議，每一個不會導致代碼更改的審閱評論都應該產生一個額外的代碼
-注釋；這可以幫助未來的審閱人員避免第一次出現的問題。
+註釋；這可以幫助未來的審閱人員避免第一次出現的問題。
 
 一個致命的錯誤是忽視評論，希望它們會消失。它們不會走的。如果您在沒有對之前
 收到的評論做出響應的情況下重新發布代碼，那麼很可能會發現補丁毫無用處。
 
-說到重新發布代碼：請記住，審閱者不會記住您上次發布的代碼的所有細節。因此，
+說到重新發布代碼：請記住，審閱者不會記住您上次發佈的代碼的所有細節。因此，
 提醒審閱人員以前提出的問題以及您如何處理這些問題總是一個好主意；補丁變更
 日誌是提供此類信息的好地方。審閱者不必搜索列表檔案來熟悉上次所說的內容；
 如果您幫助他們直接開始，當他們重新查看您的代碼時，心情會更好。
 
-如果你已經試著做正確的事情，但事情仍然沒有進展呢？大多數技術上的分歧都可以
+如果你已經試着做正確的事情，但事情仍然沒有進展呢？大多數技術上的分歧都可以
 通過討論來解決，但有時人們仍需要做出決定。如果你真的認爲這個決定對你不利，
-你可以試著向有更高權力的人上訴。對於本文，更高權力的人是 Andrew Morton 。
+你可以試着向有更高權力的人上訴。對於本文，更高權力的人是 Andrew Morton 。
 Andrew 在內核開發社區中非常受尊敬；他經常爲似乎被絕望阻塞的事情清障。儘管
 如此，不應輕易就直接找 Andrew ，也不應在所有其他替代方案都被嘗試之前找他。
 當然，記住，他也可能不同意你的意見。
@@ -95,7 +95,7 @@ Andrew 在內核開發社區中非常受尊敬；他經常爲似乎被絕望阻
 
 包含在子系統樹中可以提高補丁的可見性。現在，使用該樹的其他開發人員將默認獲
 得補丁。子系統樹通常也爲Linux提供支持，使其內容對整個開發社區可見。在這一點
-上，您很可能會從一組新的審閱者那裡得到更多的評論；這些評論需要像上一輪那樣
+上，您很可能會從一組新的審閱者那裏得到更多的評論；這些評論需要像上一輪那樣
 得到回應。
 
 在這時也會發生點什麼，這取決於你的補丁的性質，是否與其他人正在做的工作發生
@@ -114,23 +114,23 @@ Andrew 在內核開發社區中非常受尊敬；他經常爲似乎被絕望阻
 這種誘惑，您仍然需要對有問題或建議的開發人員作出響應。
 
 不過，更重要的是：將代碼包含在主線中會將代碼交給更多的一些測試人員。即使您
-爲尚未可用的硬體提供了驅動程序，您也會驚訝於有多少人會將您的代碼構建到內核
+爲尚未可用的硬件提供了驅動程序，您也會驚訝於有多少人會將您的代碼構建到內核
 中。當然，如果有測試人員，也可能會有錯誤報告。
 
-最糟糕的錯誤報告是回歸。如果你的補丁導致回歸，你會發現多到讓你不舒服的眼睛盯
-著你；回歸需要儘快修復。如果您不願意或無法修復回歸（其他人都不會爲您修復），
+最糟糕的錯誤報告是迴歸。如果你的補丁導致迴歸，你會發現多到讓你不舒服的眼睛盯
+着你；迴歸需要儘快修復。如果您不願意或無法修復迴歸（其他人都不會爲您修復），
 那麼在穩定期內，您的補丁幾乎肯定會被移除。除了否定您爲使補丁進入主線所做的
-所有工作之外，如果由於未能修復回歸而取消補丁，很可能會使將來的工作更難被合併。
+所有工作之外，如果由於未能修復迴歸而取消補丁，很可能會使將來的工作更難被合併。
 
-在處理完任何回歸之後，可能還有其他普通缺陷需要處理。穩定期是修復這些錯誤並
-確保代碼在主線內核版本中的首次發布儘可能可靠的最好機會。所以，請回應錯誤
+在處理完任何迴歸之後，可能還有其他普通缺陷需要處理。穩定期是修復這些錯誤並
+確保代碼在主線內核版本中的首次發佈儘可能可靠的最好機會。所以，請回應錯誤
 報告，並儘可能解決問題。這就是穩定期的目的；一旦解決了舊補丁的任何問題，就
 可以開始盡情創建新補丁。
 
 別忘了，還有其他節點也可能會創建缺陷報告：下一個主線穩定版本，當著名的發行
 商選擇包含您補丁的內核版本時等等。繼續響應這些報告是您工作的基本素養。但是
 如果這不能提供足夠的動機，那麼也需要考慮：開發社區會記住那些在合併後對代碼
-失去興趣的開發人員。下一次你發布補丁時，他們會以你以後不會持續維護它爲前提
+失去興趣的開發人員。下一次你發佈補丁時，他們會以你以後不會持續維護它爲前提
 來評估它。
 
 其他可能發生的事情
@@ -141,15 +141,15 @@ Andrew 在內核開發社區中非常受尊敬；他經常爲似乎被絕望阻
 維護人員（確保包含一個正確的From:行，這樣屬性是正確的，並添加一個您自己的
 signoff ），或者回復一個 Acked-by: 讓原始發送者向上發送它。
 
-如果您不同意補丁，請禮貌地回復，解釋原因。如果可能的話，告訴作者需要做哪些
-更改才能讓您接受補丁。合併代碼的編寫者和維護者所反對的補丁的確存在著一定的
+如果您不同意補丁，請禮貌地回覆，解釋原因。如果可能的話，告訴作者需要做哪些
+更改才能讓您接受補丁。合併代碼的編寫者和維護者所反對的補丁的確存在着一定的
 阻力，但僅此而已。如果你被認爲不必要的阻礙了好的工作，那麼這些補丁最終會
 繞過你並進入主線。在Linux內核中，沒有人對任何代碼擁有絕對的否決權。可能除
 了Linus。
 
-在非常罕見的情況下，您可能會看到完全不同的東西：另一個開發人員發布了針對您
-的問題的不同解決方案。在這時，兩個補丁之一可能不會被合併，「我的補丁首先
-發布」不被認爲是一個令人信服的技術論據。如果有別人的補丁取代了你的補丁而進
+在非常罕見的情況下，您可能會看到完全不同的東西：另一個開發人員發佈了針對您
+的問題的不同解決方案。在這時，兩個補丁之一可能不會被合併，“我的補丁首先
+發佈”不被認爲是一個令人信服的技術論據。如果有別人的補丁取代了你的補丁而進
 入了主線，那麼只有一種方法可以回應你：很高興你的問題解決了，請繼續工作吧。
 以這種方式把某人的工作推到一邊可能導致傷心和氣餒，但是社區會記住你的反應，
 即使很久以後他們已經忘記了誰的補丁真正被合併。
diff --git a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
index 2cbd16bfed29..db74d8ca3f3b 100644
--- a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
@@ -24,14 +24,14 @@
 使用Git管理補丁
 ---------------
 
-內核使用分布式版本控制始於2002年初，當時Linus首次開始使用專有的Bitkeeper應用
-程序。雖然BitKeeper存在爭議，但它所體現的軟體版本管理方法卻肯定不是。分布式
+內核使用分佈式版本控制始於2002年初，當時Linus首次開始使用專有的Bitkeeper應用
+程序。雖然BitKeeper存在爭議，但它所體現的軟件版本管理方法卻肯定不是。分佈式
 版本控制可以立即加速內核開發項目。現在有好幾種免費的BitKeeper替代品。
 但無論好壞，內核項目都已經選擇了Git作爲其工具。
 
-使用Git管理補丁可以使開發人員的生活更加輕鬆，尤其是隨著補丁數量的增長。Git也
+使用Git管理補丁可以使開發人員的生活更加輕鬆，尤其是隨着補丁數量的增長。Git也
 有其粗糙的邊角和一定的危險性，它是一個年輕和強大的工具，仍然在其開發人員完善
-中。本文檔不會試圖教會讀者如何使用git；這會是個巨長的文檔。相反，這裡的重點
+中。本文檔不會試圖教會讀者如何使用git；這會是個巨長的文檔。相反，這裏的重點
 將是Git如何特別適合內核開發過程。想要加快用Git速度的開發人員可以在以下網站上
 找到更多信息：
 
@@ -42,22 +42,22 @@
 同時網上也能找到各種各樣的教程。
 
 在嘗試使用它生成補丁供他人使用之前，第一要務是閱讀上述網頁，對Git的工作方式
-有一個紮實的了解。使用Git的開發人員應能進行拉取主線存儲庫的副本，查詢修訂
-歷史，提交對樹的更改，使用分支等操作。了解Git用於重寫歷史的工具（如rebase）
-也很有用。Git有自己的術語和概念；Git的新用戶應該了解引用、遠程分支、索引、
-快進合併、推拉、游離頭等。一開始可能有點嚇人，但這些概念不難通過一點學習來
+有一個紮實的瞭解。使用Git的開發人員應能進行拉取主線存儲庫的副本，查詢修訂
+歷史，提交對樹的更改，使用分支等操作。瞭解Git用於重寫歷史的工具（如rebase）
+也很有用。Git有自己的術語和概念；Git的新用戶應該瞭解引用、遠程分支、索引、
+快進合併、推拉、遊離頭等。一開始可能有點嚇人，但這些概念不難通過一點學習來
 理解。
 
 使用git生成通過電子郵件提交的補丁是提高速度的一個很好的練習。
 
-當您準備好開始建立Git樹供其他人查看時，無疑需要一個可以從中拉取的伺服器。
-如果您有一個可以訪問網際網路的系統，那麼使用git-daemon設置這樣的伺服器相對
+當您準備好開始建立Git樹供其他人查看時，無疑需要一個可以從中拉取的服務器。
+如果您有一個可以訪問因特網的系統，那麼使用git-daemon設置這樣的服務器相對
 簡單。同時，免費的公共託管網站（例如github）也開始出現在網絡上。成熟的開發
 人員可以在kernel.org上獲得一個帳戶，但這些帳戶並不容易得到；更多有關信息，
 請參閱 https://kernel.org/faq/ 。
 
-正常的Git工作流程涉及到許多分支的使用。每一條開發線都可以分爲單獨的「主題
-分支」，並獨立維護。Git的分支很容易使用，沒有理由不使用它們。而且，在任何
+正常的Git工作流程涉及到許多分支的使用。每一條開發線都可以分爲單獨的“主題
+分支”，並獨立維護。Git的分支很容易使用，沒有理由不使用它們。而且，在任何
 情況下，您都不應該在任何您打算讓其他人從中拉取的分支中進行開發。應該小心地
 創建公開可用的分支；當開發分支處於完整狀態並已準備好時(而不是之前）才合併
 開發分支的補丁。
@@ -72,10 +72,10 @@ Git提供了一些強大的工具，可以讓您重寫開發歷史。一個不
 簡單癡迷。重寫歷史將重寫該歷史中包含的更改，將經過測試（希望如此）的內核樹
 變爲未經測試的內核樹。除此之外，如果開發人員沒有共享項目歷史，他們就無法
 輕鬆地協作；如果您重寫了其他開發人員拉入他們存儲庫的歷史，您將使這些開發
-人員的生活更加困難。因此，這裡有一個簡單的經驗法則：被導出到其他地方的歷史
+人員的生活更加困難。因此，這裏有一個簡單的經驗法則：被導出到其他地方的歷史
 在此後通常被認爲是不可變的。
 
-因此，一旦將一組更改推送到公開可用的伺服器上，就不應該重寫這些更改。如果您
+因此，一旦將一組更改推送到公開可用的服務器上，就不應該重寫這些更改。如果您
 嘗試強制進行無法快進合併的更改（即不共享同一歷史記錄的更改），Git將嘗試強制
 執行此規則。這可能覆蓋檢查，有時甚至需要重寫導出的樹。在樹之間移動變更集以
 避免linux-next中的衝突就是一個例子。但這種行爲應該是罕見的。這就是爲什麼
@@ -86,9 +86,9 @@ Git提供了一些強大的工具，可以讓您重寫開發歷史。一個不
 對於一個私有的分支，rebasing 可能是一個很容易跟上另一棵樹的方法，但是一旦
 一棵樹被導出到外界，rebasing就不可取了。一旦發生這種情況，就必須進行完全
 合併（merge）。合併有時是很有意義的，但是過於頻繁的合併會不必要地擾亂歷史。
-在這種情況下建議的做法是不要頻繁合併，通常只在特定的發布點（如主線-rc發布）
+在這種情況下建議的做法是不要頻繁合併，通常只在特定的發佈點（如主線-rc發佈）
 合併。如果您對特定的更改感到緊張，則可以始終在私有分支中執行測試合併。在
-這種情況下，git「rerere」工具很有用；它能記住合併衝突是如何解決的，這樣您
+這種情況下，git“rerere”工具很有用；它能記住合併衝突是如何解決的，這樣您
 就不必重複相同的工作。
 
 關於Git這樣的工具的一個最大的反覆抱怨是：補丁從一個存儲庫到另一個存儲庫的
@@ -98,36 +98,36 @@ Git提供了一些強大的工具，可以讓您重寫開發歷史。一個不
 
 ::
 
-   你可以給我發補丁，但當我從你那裡拉取一個Git補丁時，我需要知道你清楚
+   你可以給我發補丁，但當我從你那裏拉取一個Git補丁時，我需要知道你清楚
    自己在做什麼，我需要能夠相信事情而 *無需* 手動檢查每個單獨的更改。
 
 （http://lwn.net/Articles/224135/）。
 
-爲了避免這種情況，請確保給定分支中的所有補丁都與相關主題緊密相關；「驅動程序
-修復」分支不應更改核心內存管理代碼。而且，最重要的是，不要使用Git樹來繞過
-審查過程。不時的將樹的摘要發布到相關的列表中，在合適時候請求linux-next中
+爲了避免這種情況，請確保給定分支中的所有補丁都與相關主題緊密相關；“驅動程序
+修復”分支不應更改核心內存管理代碼。而且，最重要的是，不要使用Git樹來繞過
+審查過程。不時的將樹的摘要發佈到相關的列表中，在合適時候請求linux-next中
 包含該樹。
 
 如果其他人開始發送補丁以包含到您的樹中，不要忘記審閱它們。還要確保您維護正確
-的作者信息； git 「am」工具在這方面做得最好，但是如果補丁通過第三方轉發給您，
-您可能需要在補丁中添加「From:」行。
+的作者信息； git “am”工具在這方面做得最好，但是如果補丁通過第三方轉發給您，
+您可能需要在補丁中添加“From:”行。
 
 請求拉取時，請務必提供所有相關信息：樹的位置、要拉取的分支以及拉取將導致的
 更改。在這方面 git request-pull 命令非常有用；它將按照其他開發人員所期望的
-格式化請求，並檢查以確保您已記得將這些更改推送到公共伺服器。
+格式化請求，並檢查以確保您已記得將這些更改推送到公共服務器。
 
 審閱補丁
 --------
 
-一些讀者顯然會反對將本節與「高級主題」放在一起，因爲即使是剛開始的內核開發人員
-也應該審閱補丁。當然，沒有比查看其他人發布的代碼更好的方法來學習如何在內核環境
+一些讀者顯然會反對將本節與“高級主題”放在一起，因爲即使是剛開始的內核開發人員
+也應該審閱補丁。當然，沒有比查看其他人發佈的代碼更好的方法來學習如何在內核環境
 中編程了。此外，審閱者永遠供不應求；通過審閱代碼，您可以對整個流程做出重大貢獻。
 
 審查代碼可能是一副令人生畏的圖景，特別是對一個新的內核開發人員來說，他們
-可能會對公開詢問代碼感到緊張，而這些代碼是由那些有更多經驗的人發布的。不過，
+可能會對公開詢問代碼感到緊張，而這些代碼是由那些有更多經驗的人發佈的。不過，
 即使是最有經驗的開發人員編寫的代碼也可以得到改進。也許對（所有）審閱者最好
-的建議是：把審閱評論當成問題而不是批評。詢問「在這條路徑中如何釋放鎖？」
-總是比說「這裡的鎖是錯誤的」更好。
+的建議是：把審閱評論當成問題而不是批評。詢問“在這條路徑中如何釋放鎖？”
+總是比說“這裏的鎖是錯誤的”更好。
 
 不同的開發人員將從不同的角度審查代碼。部分人會主要關注代碼風格以及代碼行是
 否有尾隨空格。其他人會主要關注補丁作爲一個整體實現的變更是否對內核有好處。
diff --git a/Documentation/translations/zh_TW/process/8.Conclusion.rst b/Documentation/translations/zh_TW/process/8.Conclusion.rst
index 1207991d1570..1f696e739868 100644
--- a/Documentation/translations/zh_TW/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_TW/process/8.Conclusion.rst
@@ -17,13 +17,13 @@
 更多信息
 ========
 
-關於Linux內核開發和相關主題的信息來源很多。首先是在內核原始碼分發中找到的
+關於Linux內核開發和相關主題的信息來源很多。首先是在內核源代碼分發中找到的
 文檔目錄。頂級
 :ref:`Documentation/translations/zh_TW/process/howto.rst <tw_process_howto>`
 文件是一個重要的起點；
 :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 也是所有內核開發人員都應該閱讀的內容。許多內部內核API都是使用kerneldoc機制
-記錄的；「make htmldocs」或「make pdfdocs」可用於以HTML或PDF格式生成這些文檔
+記錄的；“make htmldocs”或“make pdfdocs”可用於以HTML或PDF格式生成這些文檔
 （儘管某些發行版提供的tex版本會遇到內部限制，無法正確處理文檔）。
 
 不同的網站在各個細節層次上討論內核開發。本文作者想謙虛地建議用 https://lwn.net/
@@ -35,7 +35,7 @@
 
   https://kernelnewbies.org/
 
-當然，也不應該忘記 https://kernel.org/ ，這是內核發布信息的最終位置。
+當然，也不應該忘記 https://kernel.org/ ，這是內核發佈信息的最終位置。
 
 關於內核開發有很多書：
 
@@ -47,7 +47,7 @@
   《深入理解Linux內核》(Daniel Bovet和Marco Cesati）
 
 然而，所有這些書都有一個共同的缺點：它們上架時就往往有些過時，而且已經上架
-一段時間了。不過，在那裡還是可以找到相當多的好信息。
+一段時間了。不過，在那裏還是可以找到相當多的好信息。
 
 有關git的文檔，請訪問：
 
@@ -61,7 +61,7 @@
 祝賀所有通過這篇冗長的文檔的人。希望它能夠幫助您理解Linux內核是如何開發的，
 以及您如何參與這個過程。
 
-最後，重要的是參與。任何開源軟體項目都不會超過其貢獻者投入其中的總和。Linux
+最後，重要的是參與。任何開源軟件項目都不會超過其貢獻者投入其中的總和。Linux
 內核的發展速度和以前一樣快，因爲它得到了大量開發人員的幫助，他們都在努力使它
 變得更好。內核是一個最成功的例子，說明了當成千上萬的人爲了一個共同的目標一起
 工作時，可以做出什麼。
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
index 920bb0f36974..48df918000e9 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
@@ -8,34 +8,34 @@
 
 .. _tw_code_of_conduct_interpretation:
 
-Linux內核貢獻者契約行為準則解釋
+Linux內核貢獻者契約行爲準則解釋
 ===============================
 
 :ref:`tw_code_of_conduct` 準則是一個通用文檔，旨在爲幾乎所有開源社區提供一套規則。
 每個開源社區都是獨一無二的，Linux內核也不例外。因此，本文描述了Linux內核社區中
-如何解釋它。我們也不希望這種解釋隨著時間的推移是靜態的，並將根據需要進行調整。
+如何解釋它。我們也不希望這種解釋隨着時間的推移是靜態的，並將根據需要進行調整。
 
-與開發軟體的「傳統」方法相比，Linux內核開發工作是一個非常個人化的過程。你的貢獻
+與開發軟件的“傳統”方法相比，Linux內核開發工作是一個非常個人化的過程。你的貢獻
 和背後的想法將被仔細審查，往往導致批判和批評。審查將幾乎總是需要改進，材料才
 能包括在內核中。要知道這是因爲所有相關人員都希望看到Linux整體成功的最佳解決方
-案。這個開發過程已經被證明可以創建有史以來最健壯的作業系統內核，我們不想做任何
+案。這個開發過程已經被證明可以創建有史以來最健壯的操作系統內核，我們不想做任何
 事情來導致提交質量和最終結果的下降。
 
 維護者
 ------
 
-行為準則多次使用「維護者」一詞。在內核社區中，「維護者」是負責子系統、驅動程序或
-文件的任何人，並在內核原始碼樹的維護者文件中列出。
+行爲準則多次使用“維護者”一詞。在內核社區中，“維護者”是負責子系統、驅動程序或
+文件的任何人，並在內核源代碼樹的維護者文件中列出。
 
 責任
 ----
 
-《行為準則》提到了維護人員的權利和責任，這需要進一步澄清。
+《行爲準則》提到了維護人員的權利和責任，這需要進一步澄清。
 
 首先，最重要的是，有一個合理的期望是由維護人員通過實例來領導。
 
 也就是說，我們的社區是廣闊的，對維護者沒有新的要求，他們單方面處理其他人在
-他們活躍的社區的行爲。這一責任由我們所有人承擔，最終《行為準則》記錄了最終的
+他們活躍的社區的行爲。這一責任由我們所有人承擔，最終《行爲準則》記錄了最終的
 上訴路徑，以防有關行爲問題的問題懸而未決。
 
 維護人員應該願意在出現問題時提供幫助，並在需要時與社區中的其他人合作。如果您
@@ -43,10 +43,10 @@ Linux內核貢獻者契約行為準則解釋
 除非您願意，否則不會將其視爲違規報告。如果您不確定是否該聯繫TAB 或任何其他維
 護人員，請聯繫我們的衝突調解人 Mishi Choudhary <mishi@linux.com>。
 
-最後，「善待對方」才是每個人的最終目標。我們知道每個人都是人，有時我們都會失敗，
-但我們所有人的首要目標應該是努力友好地解決問題。執行行為準則將是最後的選擇。
+最後，“善待對方”纔是每個人的最終目標。我們知道每個人都是人，有時我們都會失敗，
+但我們所有人的首要目標應該是努力友好地解決問題。執行行爲準則將是最後的選擇。
 
-我們的目標是創建一個強大的、技術先進的作業系統，以及所涉及的技術複雜性，這自
+我們的目標是創建一個強大的、技術先進的操作系統，以及所涉及的技術複雜性，這自
 然需要專業知識和決策。
 
 所需的專業知識因貢獻領域而異。它主要由上下文和技術複雜性決定，其次由貢獻者和
@@ -55,58 +55,58 @@ Linux內核貢獻者契約行為準則解釋
 專家的期望和決策都要經過討論，但在最後，爲了取得進展，必須能夠做出決策。這一
 特權掌握在維護人員和項目領導的手中，預計將善意使用。
 
-因此，設定專業知識期望、作出決定和拒絕不適當的貢獻不被視爲違反行為準則。
+因此，設定專業知識期望、作出決定和拒絕不適當的貢獻不被視爲違反行爲準則。
 
 雖然維護人員一般都歡迎新來者，但他們幫助（新）貢獻者克服障礙的能力有限，因此
-他們必須確定優先事項。這也不應被視爲違反了行為準則。內核社區意識到這一點，並
+他們必須確定優先事項。這也不應被視爲違反了行爲準則。內核社區意識到這一點，並
 以各種形式提供入門級節目，如 kernelnewbies.org 。
 
 範圍
 ----
 
-Linux內核社區主要在一組公共電子郵件列表上進行交互，這些列表分布在由多個不同
-公司或個人控制的多個不同伺服器上。所有這些列表都在內核原始碼樹中的
+Linux內核社區主要在一組公共電子郵件列表上進行交互，這些列表分佈在由多個不同
+公司或個人控制的多個不同服務器上。所有這些列表都在內核源代碼樹中的
 MAINTAINERS 文件中定義。發送到這些郵件列表的任何電子郵件都被視爲包含在行爲
 準則中。
 
 使用 kernel.org bugzilla和其他子系統bugzilla 或bug跟蹤工具的開發人員應該遵循
-行為準則的指導原則。Linux內核社區沒有「官方」項目電子郵件地址或「官方」社交媒體
-地址。使用kernel.org電子郵件帳戶執行的任何活動必須遵循爲kernel.org發布的行爲
+行爲準則的指導原則。Linux內核社區沒有“官方”項目電子郵件地址或“官方”社交媒體
+地址。使用kernel.org電子郵件帳戶執行的任何活動必須遵循爲kernel.org發佈的行爲
 準則，就像任何使用公司電子郵件帳戶的個人必須遵循該公司的特定規則一樣。
 
-行為準則並不禁止在郵件列表消息、內核更改日誌消息或代碼注釋中繼續包含名稱、
+行爲準則並不禁止在郵件列表消息、內核更改日誌消息或代碼註釋中繼續包含名稱、
 電子郵件地址和相關注釋。
 
-其他論壇中的互動包括在適用於上述論壇的任何規則中，通常不包括在行為準則中。
+其他論壇中的互動包括在適用於上述論壇的任何規則中，通常不包括在行爲準則中。
 除了在極端情況下可考慮的例外情況。
 
-提交給內核的貢獻應該使用適當的語言。在行為準則之前已經存在的內容現在不會被
+提交給內核的貢獻應該使用適當的語言。在行爲準則之前已經存在的內容現在不會被
 視爲違反。然而，不適當的語言可以被視爲一個bug；如果任何相關方提交補丁，
 這樣的bug將被更快地修復。當前屬於用戶/內核API的一部分的表達式，或者反映已
-發布標準或規範中使用的術語的表達式，不被視爲bug。
+發佈標準或規範中使用的術語的表達式，不被視爲bug。
 
 執行
 ----
 
-行為準則中列出的地址屬於行為準則委員會。https://kernel.org/code-of-conduct.html
+行爲準則中列出的地址屬於行爲準則委員會。https://kernel.org/code-of-conduct.html
 列出了在任何給定時間接收這些電子郵件的確切成員。成員不能訪問在加入委員會之前
 或離開委員會之後所做的報告。
 
-最初的行為準則委員會由TAB的志願者以及作爲中立第三方的專業調解人組成。委員會
+最初的行爲準則委員會由TAB的志願者以及作爲中立第三方的專業調解人組成。委員會
 的首要任務是建立文件化的流程，並將其公開。
 
 如果報告人不希望將整個委員會納入投訴或關切，可直接聯繫委員會的任何成員，包括
 調解人。
 
-行為準則委員會根據流程審查案例（見上文），並根據需要和適當與TAB協商，例如請求
+行爲準則委員會根據流程審查案例（見上文），並根據需要和適當與TAB協商，例如請求
 和接收有關內核社區的信息。
 
 委員會做出的任何決定都將提交到表中，以便在必要時與相關維護人員一起執行。行爲
 準則委員會的決定可以通過三分之二的投票推翻。
 
-每季度，行為準則委員會和標籤將提供一份報告，概述行為準則委員會收到的匿名報告
+每季度，行爲準則委員會和標籤將提供一份報告，概述行爲準則委員會收到的匿名報告
 及其狀態，以及任何否決決定的細節，包括完整和可識別的投票細節。
 
-我們希望在啓動期之後爲行為準則委員會人員配備建立一個不同的流程。發生此情況時，
+我們希望在啓動期之後爲行爲準則委員會人員配備建立一個不同的流程。發生此情況時，
 將使用該信息更新此文檔。
 
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct.rst b/Documentation/translations/zh_TW/process/code-of-conduct.rst
index e3087112f0bc..a7a31de03526 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct.rst
@@ -8,7 +8,7 @@
 
 .. _tw_code_of_conduct:
 
-貢獻者契約行為準則
+貢獻者契約行爲準則
 ++++++++++++++++++
 
 我們的誓言
@@ -35,7 +35,7 @@
 * 使用性意味的語言或意象以及不受歡迎的性注意或者更過分的行爲
 * 煽動、侮辱/貶損評論以及個人或政治攻擊
 * 公開或私下騷擾
-* 未經明確許可，發布他人的私人信息，如物理或電子地址。
+* 未經明確許可，發佈他人的私人信息，如物理或電子地址。
 * 在專業場合被合理認爲不適當的其他行爲
 
 我們的責任
@@ -44,29 +44,29 @@
 維護人員負責澄清可接受行爲的標準，並應針對任何不可接受行爲採取適當和公平的
 糾正措施。
 
-維護人員有權和責任刪除、編輯或拒絕與本行為準則不一致的評論、承諾、代碼、
+維護人員有權和責任刪除、編輯或拒絕與本行爲準則不一致的評論、承諾、代碼、
 wiki編輯、問題和其他貢獻，或暫時或永久禁止任何貢獻者從事他們認爲不適當、
 威脅、冒犯或有害的其他行爲。
 
 範圍
 ====
 
-當個人代表項目或其社區時，本行為準則既適用於項目空間，也適用於公共空間。
+當個人代表項目或其社區時，本行爲準則既適用於項目空間，也適用於公共空間。
 代表一個項目或社區的例子包括使用一個正式的項目電子郵件地址，通過一個正式
-的社交媒體帳戶發布，或者在在線或離線事件中擔任指定的代表。項目維護人員可以
+的社交媒體帳戶發佈，或者在在線或離線事件中擔任指定的代表。項目維護人員可以
 進一步定義和澄清項目的表示。
 
 執行
 ====
 
-如有濫用、騷擾或其他不可接受的行爲，可聯繫行為準則委員會<conduct@kernel.org>。
-所有投訴都將接受審查和調查，並將得到必要和適當的答覆。行為準則委員會有義務
-對事件報告人保密。具體執行政策的進一步細節可單獨公布。
+如有濫用、騷擾或其他不可接受的行爲，可聯繫行爲準則委員會<conduct@kernel.org>。
+所有投訴都將接受審查和調查，並將得到必要和適當的答覆。行爲準則委員會有義務
+對事件報告人保密。具體執行政策的進一步細節可單獨公佈。
 
 歸屬
 ====
 
-本行為準則改編自《貢獻者契約》，版本1.4，可從
+本行爲準則改編自《貢獻者契約》，版本1.4，可從
 https://www.contributor-covenant.org/version/1/4/code-of-conduct.html 獲取。
 
 解釋
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 83862e4d3b64..78785519f9e9 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -2,42 +2,44 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/process/coding-style.rst <codingstyle>`
+:Original: Documentation/process/coding-style.rst
 
 .. _tw_codingstyle:
 
-譯者::
+:譯者:
+ - 張樂 Zhang Le <r0bertz@gentoo.org>
+ - Andy Deng <theandy.deng@gmail.com>
+ - 吳想成 <bobwxc@email.cn>
 
-  中文版維護者： 張樂 Zhang Le <r0bertz@gentoo.org>
-  中文版翻譯者： 張樂 Zhang Le <r0bertz@gentoo.org>
-  中文版校譯者： 王聰 Wang Cong <xiyou.wangcong@gmail.com>
-                 wheelz <kernel.zeng@gmail.com>
-                 管旭東 Xudong Guan <xudong.guan@gmail.com>
-                 Li Zefan <lizf@cn.fujitsu.com>
-                 Wang Chen <wangchen@cn.fujitsu.com>
-                 Hu Haowen <src.res.211@gmail.com>
+:校譯:
+ - 王聰 Wang Cong <xiyou.wangcong@gmail.com>
+ - wheelz <kernel.zeng@gmail.com>
+ - 管旭東 Xudong Guan <xudong.guan@gmail.com>
+ - Li Zefan <lizf@cn.fujitsu.com>
+ - Wang Chen <wangchen@cn.fujitsu.com>
+ - Hu Haowen <src.res.211@gmail.com>
 
 Linux 內核代碼風格
-=========================
+==================
 
 這是一個簡短的文檔，描述了 linux 內核的首選代碼風格。代碼風格是因人而異的，
 而且我不願意把自己的觀點強加給任何人，但這就像我去做任何事情都必須遵循的原則
-那樣，我也希望在絕大多數事上保持這種的態度。請 (在寫代碼時) 至少考慮一下這裡
+那樣，我也希望在絕大多數事上保持這種的態度。請 (在寫代碼時) 至少考慮一下這裏
 的代碼風格。
 
-首先，我建議你列印一份 GNU 代碼規範，然後不要讀。燒了它，這是一個具有重大象徵
+首先，我建議你打印一份 GNU 代碼規範，然後不要讀。燒了它，這是一個具有重大象徵
 性意義的動作。
 
 不管怎樣，現在我們開始：
 
 
 1) 縮進
---------------
+-------
 
-制表符是 8 個字符，所以縮進也是 8 個字符。有些異端運動試圖將縮進變爲 4 (甚至
+製表符是 8 個字符，所以縮進也是 8 個字符。有些異端運動試圖將縮進變爲 4 (甚至
 2！) 字符深，這幾乎相當於嘗試將圓周率的值定義爲 3。
 
-理由：縮進的全部意義就在於清楚的定義一個控制塊起止於何處。尤其是當你盯著你的
+理由：縮進的全部意義就在於清楚的定義一個控制塊起止於何處。尤其是當你盯着你的
 屏幕連續看了 20 小時之後，你將會發現大一點的縮進會使你更容易分辨縮進。
 
 現在，有些人會抱怨 8 個字符的縮進會使代碼向右邊移動的太遠，在 80 個字符的終端
@@ -69,39 +71,60 @@ Linux 內核代碼風格
 		break;
 	}
 
-不要把多個語句放在一行里，除非你有什麼東西要隱藏：
+不要把多個語句放在一行裏，除非你有什麼東西要隱藏：
 
 .. code-block:: c
 
 	if (condition) do_this;
 	  do_something_everytime;
 
-也不要在一行里放多個賦值語句。內核代碼風格超級簡單。就是避免可能導致別人誤讀
+不要使用逗號來避免使用大括號：
+
+.. code-block:: c
+
+	if (condition)
+		do_this(), do_that();
+
+使用大括號包裹多語句：
+
+.. code-block:: c
+
+	if (condition) {
+		do_this();
+		do_that();
+	}
+
+也不要在一行裏放多個賦值語句。內核代碼風格超級簡單。就是避免可能導致別人誤讀
 的表達式。
 
-除了注釋、文檔和 Kconfig 之外，不要使用空格來縮進，前面的例子是例外，是有意爲
+除了註釋、文檔和 Kconfig 之外，不要使用空格來縮進，前面的例子是例外，是有意爲
 之。
 
 選用一個好的編輯器，不要在行尾留空格。
 
 
 2) 把長的行和字符串打散
-------------------------------
+-----------------------
 
 代碼風格的意義就在於使用平常使用的工具來維持代碼的可讀性和可維護性。
 
 每一行的長度的限制是 80 列，我們強烈建議您遵守這個慣例。
 
 長於 80 列的語句要打散成有意義的片段。除非超過 80 列能顯著增加可讀性，並且不
-會隱藏信息。子片段要明顯短於母片段，並明顯靠右。這同樣適用於有著很長參數列表
-的函數頭。然而，絕對不要打散對用戶可見的字符串，例如 printk 信息，因爲這樣就
+會隱藏信息。
+
+子片段要明顯短於母片段，並明顯靠右。一種非常常用的樣式是將子體與函數左括號對齊。
+
+這同樣適用於有着很長參數列表的函數頭。
+
+然而，絕對不要打散對用戶可見的字符串，例如 printk 信息，因爲這樣就
 很難對它們 grep。
 
 
 3) 大括號和空格的放置
-------------------------------
+---------------------
 
-C 語言風格中另外一個常見問題是大括號的放置。和縮進大小不同，選擇或棄用某种放
+C 語言風格中另外一個常見問題是大括號的放置。和縮進大小不同，選擇或棄用某種放
 置策略並沒有多少技術上的原因，不過首選的方式，就像 Kernighan 和 Ritchie 展示
 給我們的，是把起始大括號放在行尾，而把結束大括號放在行首，所以：
 
@@ -135,12 +158,12 @@ C 語言風格中另外一個常見問題是大括號的放置。和縮進大小
 		body of function
 	}
 
-全世界的異端可能會抱怨這個不一致性是... 呃... 不一致的，不過所有思維健全的人
+全世界的異端可能會抱怨這個不一致性是……呃……不一致，不過所有思維健全的人
 都知道 (a) K&R 是 **正確的** 並且 (b) K&R 是正確的。此外，不管怎樣函數都是特
 殊的 (C 函數是不能嵌套的)。
 
-注意結束大括號獨自占據一行，除非它後面跟著同一個語句的剩餘部分，也就是 do 語
-句中的 "while" 或者 if 語句中的 "else"，像這樣：
+注意結束大括號獨自佔據一行，除非它後面跟着同一個語句的剩餘部分，也就是 do 語
+句中的 ``while`` 或者 if 語句中的 ``else`` ，像這樣：
 
 .. code-block:: c
 
@@ -164,7 +187,7 @@ C 語言風格中另外一個常見問題是大括號的放置。和縮進大小
 
 也請注意這種大括號的放置方式也能使空 (或者差不多空的) 行的數量最小化，同時不
 失可讀性。因此，由於你的屏幕上的新行是不可再生資源 (想想 25 行的終端屏幕)，你
-將會有更多的空行來放置注釋。
+將會有更多的空行來放置註釋。
 
 當只有一個單獨的語句的時候，不用加不必要的大括號。
 
@@ -194,12 +217,12 @@ C 語言風格中另外一個常見問題是大括號的放置。和縮進大小
 	}
 
 3.1) 空格
-********************
+*********
 
 Linux 內核的空格使用方式 (主要) 取決於它是用於函數還是關鍵字。(大多數) 關鍵字
 後要加一個空格。值得注意的例外是 sizeof, typeof, alignof 和 __attribute__，這
-些關鍵字某些程度上看起來更像函數 (它們在 Linux 里也常常伴隨小括號而使用，儘管
-在 C 里這樣的小括號不是必需的，就像 ``struct fileinfo info;`` 聲明過後的
+些關鍵字某些程度上看起來更像函數 (它們在 Linux 裏也常常伴隨小括號而使用，儘管
+在 C 裏這樣的小括號不是必需的，就像 ``struct fileinfo info;`` 聲明過後的
 ``sizeof info``)。
 
 所以在這些關鍵字之後放一個空格::
@@ -213,7 +236,7 @@ Linux 內核的空格使用方式 (主要) 取決於它是用於函數還是關
 
 	s = sizeof(struct file);
 
-不要在小括號里的表達式兩側加空格。這是一個 **反例** ：
+不要在小括號裏的表達式兩側加空格。這是一個 **反例** ：
 
 .. code-block:: c
 
@@ -257,10 +280,10 @@ Linux 內核的空格使用方式 (主要) 取決於它是用於函數還是關
 
 
 4) 命名
-------------------------------
+-------
 
-C 是一個簡樸的語言，你的命名也應該這樣。和 Modula-2 和 Pascal 程式設計師不同，
-C 程式設計師不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的名字。C 程式設計師會
+C 是一個簡樸的語言，你的命名也應該這樣。和 Modula-2 和 Pascal 程序員不同，
+C 程序員不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的名字。C 程序員會
 稱那個變量爲 ``tmp`` ，這樣寫起來會更容易，而且至少不會令其難於理解。
 
 不過，雖然混用大小寫的名字是不提倡使用的，但是全局變量還是需要一個具描述性的
@@ -271,23 +294,42 @@ C 程式設計師不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的
 ``count_active_users()`` 或者類似的名字，你不應該叫它 ``cntuser()`` 。
 
 在函數名中包含函數類型 (所謂的匈牙利命名法) 是腦子出了問題——編譯器知道那些類
-型而且能夠檢查那些類型，這樣做只能把程式設計師弄糊塗了。難怪微軟總是製造出有問題
-的程序。
+型而且能夠檢查那些類型，這樣做只能把程序員弄糊塗了。
 
 本地變量名應該簡短，而且能夠表達相關的含義。如果你有一些隨機的整數型的循環計
 數器，它應該被稱爲 ``i`` 。叫它 ``loop_counter`` 並無益處，如果它沒有被誤解的
 可能的話。類似的， ``tmp`` 可以用來稱呼任意類型的臨時變量。
 
 如果你怕混淆了你的本地變量名，你就遇到另一個問題了，叫做函數增長荷爾蒙失衡綜
-合症。請看第六章 (函數)。
+合徵。請看第六章 (函數)。
 
+對於符號名稱和文檔，避免引入新的“master/slave”（或獨立於“master”的“slave”）
+和“blacklist/whitelist”。
+
+“master/slave”推薦替換爲：
+    '{primary,main} / {secondary,replica,subordinate}'
+    '{initiator,requester} / {target,responder}'
+    '{controller,host} / {device,worker,proxy}'
+    'leader/follower'
+    'director/performer'
+
+“blacklist/whitelist”推薦替換爲：
+    'denylist/allowlist'
+    'blocklist/passlist'
+
+引入新用法的例外情況是：維護用戶空間ABI/API，或更新現有（截至2020年）硬件或
+協議規範的代碼時要求這些術語。對於新規範，儘可能將術語的規範用法轉換爲內核
+編碼標準。
+
+.. warning::
+	以上主從、黑白名單規則不適用於中文文檔，請勿更改中文術語！
 
 5) Typedef
------------
+----------
 
 不要使用類似 ``vps_t`` 之類的東西。
 
-對結構體和指針使用 typedef 是一個 **錯誤** 。當你在代碼里看到：
+對結構體和指針使用 typedef 是一個 **錯誤** 。當你在代碼裏看到：
 
 .. code-block:: c
 
@@ -312,13 +354,13 @@ C 程式設計師不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的
 
      .. note::
 
-       不透明性和 "訪問函數" 本身是不好的。我們使用 pte_t 等類型的原因在於真
+       不透明性和“訪問函數”本身是不好的。我們使用 pte_t 等類型的原因在於真
        的是完全沒有任何共用的可訪問信息。
 
  (b) 清楚的整數類型，如此，這層抽象就可以 **幫助** 消除到底是 ``int`` 還是
      ``long`` 的混淆。
 
-     u8/u16/u32 是完全沒有問題的 typedef，不過它們更符合類別 (d) 而不是這裡。
+     u8/u16/u32 是完全沒有問題的 typedef，不過它們更符合類別 (d) 而不是這裏。
 
      .. note::
 
@@ -345,30 +387,30 @@ C 程式設計師不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的
 
  (e) 可以在用戶空間安全使用的類型。
 
-     在某些用戶空間可見的結構體裡，我們不能要求 C99 類型而且不能用上面提到的
+     在某些用戶空間可見的結構體裏，我們不能要求 C99 類型而且不能用上面提到的
      ``u32`` 類型。因此，我們在與用戶空間共享的所有結構體中使用 __u32 和類似
      的類型。
 
 可能還有其他的情況，不過基本的規則是 **永遠不要** 使用 typedef，除非你可以明
 確的應用上述某個規則中的一個。
 
-總的來說，如果一個指針或者一個結構體裡的元素可以合理的被直接訪問到，那麼它們
+總的來說，如果一個指針或者一個結構體裏的元素可以合理的被直接訪問到，那麼它們
 就不應該是一個 typedef。
 
 
 6) 函數
-------------------------------
+-------
 
 函數應該簡短而漂亮，並且只完成一件事情。函數應該可以一屏或者兩屏顯示完 (我們
 都知道 ISO/ANSI 屏幕大小是 80x24)，只做一件事情，而且把它做好。
 
 一個函數的最大長度是和該函數的複雜度和縮進級數成反比的。所以，如果你有一個理
 論上很簡單的只有一個很長 (但是簡單) 的 case 語句的函數，而且你需要在每個 case
-里做很多很小的事情，這樣的函數儘管很長，但也是可以的。
+裏做很多很小的事情，這樣的函數儘管很長，但也是可以的。
 
 不過，如果你有一個複雜的函數，而且你懷疑一個天分不是很高的高中一年級學生可能
 甚至搞不清楚這個函數的目的，你應該嚴格遵守前面提到的長度限制。使用輔助函數，
-並爲之取個具描述性的名字 (如果你覺得它們的性能很重要的話，可以讓編譯器內聯它
+併爲之取個具描述性的名字 (如果你覺得它們的性能很重要的話，可以讓編譯器內聯它
 們，這樣的效果往往會比你寫一個複雜函數的效果要好。)
 
 函數的另外一個衡量標準是本地變量的數量。此數量不應超過 5－10 個，否則你的函數
@@ -376,7 +418,7 @@ C 程式設計師不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的
 的同時跟蹤 7 個不同的事物，如果再增多的話，就會糊塗了。即便你聰穎過人，你也可
 能會記不清你 2 個星期前做過的事情。
 
-在源文件里，使用空行隔開不同的函數。如果該函數需要被導出，它的 **EXPORT** 宏
+在源文件裏，使用空行隔開不同的函數。如果該函數需要被導出，它的 **EXPORT** 宏
 應該緊貼在它的結束大括號之下。比如：
 
 .. code-block:: c
@@ -387,12 +429,46 @@ C 程式設計師不使用類似 ThisVariableIsATemporaryCounter 這樣華麗的
 	}
 	EXPORT_SYMBOL(system_is_up);
 
-在函數原型中，包含函數名和它們的數據類型。雖然 C 語言裡沒有這樣的要求，在
-Linux 里這是提倡的做法，因爲這樣可以很簡單的給讀者提供更多的有價值的信息。
+6.1) 函數原型
+*************
+
+在函數原型中包含參數名和它們的數據類型。雖然 C 語言裏沒有這樣的要求，但在
+Linux 裏這是提倡的做法，因爲這樣可以很簡單的給讀者提供更多的有價值的信息。
 
+不要在函數聲明裏使用 ``extern`` 關鍵字，因爲這會導致代碼行變長，並且不是嚴格
+必需的。
+
+寫函數原型時，請保持 `元素順序規則 <https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_ 。
+例如下列函數聲明::
+
+ __init void * __must_check action(enum magic value, size_t size, u8 count,
+				   char *fmt, ...) __printf(4, 5) __malloc;
+
+推薦的函數原型元素順序是：
+
+- 儲存類型（下方的 ``static __always_inline`` ，注意 ``__always_inline``
+  技術上來講是個屬性但被當做 ``inline`` ）
+- 儲存類型屬性（上方的 ``__init`` ——即節聲明，但也像 ``__cold`` ）
+- 返回類型（上方的 ``void *`` ）
+- 返回類型屬性（上方的 ``__must_check`` ）
+- 函數名（上方的 ``action`` ）
+- 函數參數（上方的 ``(enum magic value, size_t size, u8 count, char *fmt, ...)`` ，
+  注意必須寫上參數名）
+- 函數參數屬性（上方的 ``__printf(4, 5)`` ）
+- 函數行爲屬性（上方的 ``__malloc`` ）
+
+請注意，對於函數 **定義** （即實際函數體），編譯器不允許在函數參數之後添加函
+數參數屬性。在這種情況下，它們應該跟隨存儲類型屬性（例如，與上面的 **聲明**
+示例相比，請注意下面的 ``__printf(4, 5)`` 的位置發生了變化）::
+
+ static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
+		size_t size, u8 count, char *fmt, ...) __malloc
+ {
+	...
+ }
 
 7) 集中的函數退出途徑
-------------------------------
+---------------------
 
 雖然被某些人聲稱已經過時，但是 goto 語句的等價物還是經常被編譯器所使用，具體
 形式是無條件跳轉指令。
@@ -436,7 +512,7 @@ Linux 里這是提倡的做法，因爲這樣可以很簡單的給讀者提供
 		return result;
 	}
 
-一個需要注意的常見錯誤是 ``一個 err 錯誤`` ，就像這樣：
+一個需要注意的常見錯誤是 ``單 err 錯誤`` ，就像這樣：
 
 .. code-block:: c
 
@@ -459,22 +535,22 @@ Linux 里這是提倡的做法，因爲這樣可以很簡單的給讀者提供
 理想情況下，你應該模擬錯誤來測試所有退出路徑。
 
 
-8) 注釋
-------------------------------
+8) 註釋
+-------
 
-注釋是好的，不過有過度注釋的危險。永遠不要在注釋里解釋你的代碼是如何運作的：
+註釋是好的，不過有過度註釋的危險。永遠不要在註釋裏解釋你的代碼是如何運作的：
 更好的做法是讓別人一看你的代碼就可以明白，解釋寫的很差的代碼是浪費時間。
 
-一般的，你想要你的注釋告訴別人你的代碼做了什麼，而不是怎麼做的。也請你不要把
-注釋放在一個函數體內部：如果函數複雜到你需要獨立的注釋其中的一部分，你很可能
+一般來說你用註釋告訴別人你的代碼做了什麼，而不是怎麼做的。也請你不要把
+註釋放在一個函數體內部：如果函數複雜到你需要獨立的註釋其中的一部分，你很可能
 需要回到第六章看一看。你可以做一些小注釋來註明或警告某些很聰明 (或者槽糕) 的
-做法，但不要加太多。你應該做的，是把注釋放在函數的頭部，告訴人們它做了什麼，
+做法，但不要加太多。你應該做的，是把註釋放在函數的頭部，告訴人們它做了什麼，
 也可以加上它做這些事情的原因。
 
-當注釋內核 API 函數時，請使用 kernel-doc 格式。請看
-Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
+當註釋內核 API 函數時，請使用 kernel-doc 格式。詳見
+Documentation/translations/zh_TW/doc-guide/index.rst 和 scripts/kernel-doc 。
 
-長 (多行) 注釋的首選風格是：
+長 (多行) 註釋的首選風格是：
 
 .. code-block:: c
 
@@ -487,7 +563,7 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
 	 * with beginning and ending almost-blank lines.
 	 */
 
-對於在 net/ 和 drivers/net/ 的文件，首選的長 (多行) 注釋風格有些不同。
+對於在 net/ 和 drivers/net/ 的文件，首選的長 (多行) 註釋風格有些不同。
 
 .. code-block:: c
 
@@ -498,23 +574,24 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
 	 * but there is no initial almost-blank line.
 	 */
 
-注釋數據也是很重要的，不管是基本類型還是衍生類型。爲了方便實現這一點，每一行
+註釋數據也是很重要的，不管是基本類型還是衍生類型。爲了方便實現這一點，每一行
 應只聲明一個數據 (不要使用逗號來一次聲明多個數據)。這樣你就有空間來爲每個數據
 寫一段小注釋來解釋它們的用途了。
 
 
 9) 你已經把事情弄糟了
-------------------------------
+---------------------
 
-這沒什麼，我們都是這樣。可能你的使用了很長時間 Unix 的朋友已經告訴你
-``GNU emacs`` 能自動幫你格式化 C 原始碼，而且你也注意到了，確實是這樣，不過它
+這沒什麼，我們都是這樣。可能你長期使用 Unix 的朋友已經告訴你
+``GNU emacs`` 能自動幫你格式化 C 源代碼，而且你也注意到了，確實是這樣，不過它
 所使用的默認值和我們想要的相去甚遠 (實際上，甚至比隨機打的還要差——無數個猴子
-在 GNU emacs 里打字永遠不會創造出一個好程序) (譯註：Infinite Monkey Theorem)
+在 GNU emacs 裏打字永遠不會創造出一個好程序)
+*(譯註：Infinite Monkey Theorem)*
 
 所以你要麼放棄 GNU emacs，要麼改變它讓它使用更合理的設定。要採用後一個方案，
-你可以把下面這段粘貼到你的 .emacs 文件里。
+你可以把下面這段粘貼到你的 .emacs 文件裏。
 
-.. code-block:: none
+.. code-block:: elisp
 
   (defun c-lineup-arglist-tabs-only (ignored)
     "Line up argument lists by tabs, not spaces"
@@ -533,7 +610,7 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
           (c-offsets-alist . (
                   (arglist-close         . c-lineup-arglist-tabs-only)
                   (arglist-cont-nonempty .
-		      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
+                      (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
                   (arglist-intro         . +)
                   (brace-list-intro      . +)
                   (c                     . c-lineup-C-comments)
@@ -565,24 +642,29 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
 
 這會讓 emacs 在 ``~/src/linux-trees`` 下的 C 源文件獲得更好的內核代碼風格。
 
-不過就算你嘗試讓 emacs 正確的格式化代碼失敗了，也並不意味著你失去了一切：還可
+不過就算你嘗試讓 emacs 正確的格式化代碼失敗了，也並不意味着你失去了一切：還可
 以用 ``indent`` 。
 
 不過，GNU indent 也有和 GNU emacs 一樣有問題的設定，所以你需要給它一些命令選
 項。不過，這還不算太糟糕，因爲就算是 GNU indent 的作者也認同 K&R 的權威性
 (GNU 的人並不是壞人，他們只是在這個問題上被嚴重的誤導了)，所以你只要給 indent
 指定選項 ``-kr -i8`` (代表 ``K&R，8 字符縮進``)，或使用 ``scripts/Lindent``
-這樣就可以以最時髦的方式縮進原始碼。
+這樣就可以以最時髦的方式縮進源代碼。
 
-``indent`` 有很多選項，特別是重新格式化注釋的時候，你可能需要看一下它的手冊。
+``indent`` 有很多選項，特別是重新格式化註釋的時候，你可能需要看一下它的手冊。
 不過記住： ``indent`` 不能修正壞的編程習慣。
 
+請注意，您還可以使用 ``clang-format`` 工具幫助您處理這些規則，快速自動重新格
+式化部分代碼，並審閱整個文件以發現代碼風格錯誤、打字錯誤和可能的改進。它還可
+以方便地排序 ``#include`` ，對齊變量/宏，重排文本和其他類似任務。
+詳見 Documentation/process/clang-format.rst 。
+
 
 10) Kconfig 配置文件
-------------------------------
+--------------------
 
-對於遍布源碼樹的所有 Kconfig* 配置文件來說，它們縮進方式有所不同。緊挨著
-``config`` 定義的行，用一個制表符縮進，然而 help 信息的縮進則額外增加 2 個空
+對於遍佈源碼樹的所有 Kconfig* 配置文件來說，它們縮進方式有所不同。緊挨着
+``config`` 定義的行，用一個製表符縮進，然而 help 信息的縮進則額外增加 2 個空
 格。舉個例子::
 
   config AUDIT
@@ -594,7 +676,7 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
 	  logging of avc messages output).  Does not do system-call
 	  auditing without CONFIG_AUDITSYSCALL.
 
-而那些危險的功能 (比如某些文件系統的寫支持) 應該在它們的提示字符串里顯著的聲
+而那些危險的功能 (比如某些文件系統的寫支持) 應該在它們的提示字符串裏顯著的聲
 明這一點::
 
   config ADFS_FS_RW
@@ -602,17 +684,17 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
 	depends on ADFS_FS
 	...
 
-要查看配置文件的完整文檔，請看 Documentation/kbuild/kconfig-language.rst。
+要查看配置文件的完整文檔，請看 Documentation/kbuild/kconfig-language.rst 。
 
 
 11) 數據結構
-------------------------------
+------------
 
-如果一個數據結構，在創建和銷毀它的單線執行環境之外可見，那麼它必須要有一個引
-用計數器。內核里沒有垃圾收集 (並且內核之外的垃圾收集慢且效率低下)，這意味著你
+如果一個數據結構，在創建和銷燬它的單線執行環境之外可見，那麼它必須要有一個引
+用計數器。內核裏沒有垃圾收集 (並且內核之外的垃圾收集慢且效率低下)，這意味着你
 絕對需要記錄你對這種數據結構的使用情況。
 
-引用計數意味著你能夠避免上鎖，並且允許多個用戶並行訪問這個數據結構——而不需要
+引用計數意味着你能夠避免上鎖，並且允許多個用戶並行訪問這個數據結構——而不需要
 擔心這個數據結構僅僅因爲暫時不被使用就消失了，那些用戶可能不過是沉睡了一陣或
 者做了一些其他事情而已。
 
@@ -626,13 +708,13 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以獲得詳細信息。
 mm_count)，和文件系統 (``struct super_block``: s_count 和 s_active) 中找到。
 
 記住：如果另一個執行線索可以找到你的數據結構，但這個數據結構沒有引用計數器，
-這裡幾乎肯定是一個 bug。
+這裏幾乎肯定是一個 bug。
 
 
 12) 宏，枚舉和RTL
-------------------------------
+-----------------
 
-用於定義常量的宏的名字及枚舉里的標籤需要大寫。
+用於定義常量的宏的名字及枚舉裏的標籤需要大寫。
 
 .. code-block:: c
 
@@ -642,9 +724,9 @@ mm_count)，和文件系統 (``struct super_block``: s_count 和 s_active) 中
 
 宏的名字請用大寫字母，不過形如函數的宏的名字可以用小寫字母。
 
-一般的，如果能寫成內聯函數就不要寫成像函數的宏。
+通常如果能寫成內聯函數就不要寫成像函數的宏。
 
-含有多個語句的宏應該被包含在一個 do-while 代碼塊里：
+含有多個語句的宏應該被包含在一個 do-while 代碼塊裏：
 
 .. code-block:: c
 
@@ -667,7 +749,7 @@ mm_count)，和文件系統 (``struct super_block``: s_count 和 s_active) 中
 		} while (0)
 
 **非常** 不好。它看起來像一個函數，不過卻能導致 ``調用`` 它的函數退出；不要打
-亂讀者大腦里的語法分析器。
+亂讀者大腦裏的語法分析器。
 
 2) 依賴於一個固定名字的本地變量的宏：
 
@@ -689,7 +771,7 @@ mm_count)，和文件系統 (``struct super_block``: s_count 和 s_active) 中
 	#define CONSTANT 0x4000
 	#define CONSTEXP (CONSTANT | 3)
 
-5) 在宏里定義類似函數的本地變量時命名衝突：
+5) 在宏裏定義類似函數的本地變量時命名衝突：
 
 .. code-block:: c
 
@@ -700,45 +782,46 @@ mm_count)，和文件系統 (``struct super_block``: s_count 和 s_active) 中
 		(ret);				\
 	})
 
-ret 是本地變量的通用名字 - __foo_ret 更不容易與一個已存在的變量衝突。
+ret 是本地變量的通用名字—— __foo_ret 更不容易與一個已存在的變量衝突。
 
-cpp 手冊對宏的講解很詳細。gcc internals 手冊也詳細講解了 RTL，內核里的彙編語
+cpp 手冊對宏的講解很詳細。gcc internals 手冊也詳細講解了 RTL，內核裏的彙編語
 言經常用到它。
 
 
-13) 列印內核消息
-------------------------------
+13) 打印內核消息
+----------------
 
-內核開發者應該是受過良好教育的。請一定注意內核信息的拼寫，以給人以好的印象。
+內核開發者應該看起來有文化。請一定注意內核信息的拼寫，以給人良好的印象。
 不要用不規範的單詞比如 ``dont``，而要用 ``do not`` 或者 ``don't`` 。保證這些信
-息簡單明了,無歧義。
+息簡單明瞭、無歧義。
 
 內核信息不必以英文句號結束。
 
-在小括號里列印數字 (%d) 沒有任何價值，應該避免這樣做。
+在小括號裏打印數字 (%d) 沒有任何價值，應該避免這樣做。
 
-<linux/device.h> 里有一些驅動模型診斷宏，你應該使用它們，以確保信息對應於正確
+<linux/device.h> 裏有一些驅動模型診斷宏，你應該使用它們，以確保信息對應於正確
 的設備和驅動，並且被標記了正確的消息級別。這些宏有：dev_err(), dev_warn(),
 dev_info() 等等。對於那些不和某個特定設備相關連的信息，<linux/printk.h> 定義
 了 pr_notice(), pr_info(), pr_warn(), pr_err() 和其他。
 
 寫出好的調試信息可以是一個很大的挑戰；一旦你寫出後，這些信息在遠程除錯時能提
-供極大的幫助。然而列印調試信息的處理方式同列印非調試信息不同。其他 pr_XXX()
-函數能無條件地列印，pr_debug() 卻不；默認情況下它不會被編譯，除非定義了 DEBUG
+供極大的幫助。然而打印調試信息的處理方式同打印非調試信息不同。其他 pr_XXX()
+函數能無條件地打印，pr_debug() 卻不；默認情況下它不會被編譯，除非定義了 DEBUG
 或設定了 CONFIG_DYNAMIC_DEBUG。實際這同樣是爲了 dev_dbg()，一個相關約定是在一
 個已經開啓了 DEBUG 時，使用 VERBOSE_DEBUG 來添加 dev_vdbg()。
 
-許多子系統擁有 Kconfig 調試選項來開啓 -DDEBUG 在對應的 Makefile 裡面；在其他
-情況下，特殊文件使用 #define DEBUG。當一條調試信息需要被無條件列印時，例如，
+許多子系統擁有 Kconfig 調試選項來開啓對應 Makefile 裏面的 -DDEBUG；在其他
+情況下，特殊文件使用 #define DEBUG。當一條調試信息需要被無條件打印時，例如，
 如果已經包含一個調試相關的 #ifdef 條件，printk(KERN_DEBUG ...) 就可被使用。
 
 
 14) 分配內存
-------------------------------
+------------
 
 內核提供了下面的一般用途的內存分配函數：
 kmalloc(), kzalloc(), kmalloc_array(), kcalloc(), vmalloc() 和 vzalloc()。
-請參考 API 文檔以獲取有關它們的詳細信息。
+請參考 API 文檔以獲取有關它們的詳細信息：
+Documentation/translations/zh_TW/core-api/memory-allocation.rst 。
 
 傳遞結構體大小的首選形式是這樣的：
 
@@ -765,17 +848,19 @@ kmalloc(), kzalloc(), kmalloc_array(), kcalloc(), vmalloc() 和 vzalloc()。
 
 	p = kcalloc(n, sizeof(...), ...);
 
-兩種形式檢查分配大小 n * sizeof(...) 的溢出，如果溢出返回 NULL。
+兩種形式都會檢查分配 n * sizeof(...) 大小時內存的溢出，如果溢出返回 NULL。
 
+在沒有 __GFP_NOWARN 的情況下使用時，這些通用分配函數都會在失敗時發起堆棧轉儲，
+因此當返回NULL時，沒有必要發出額外的失敗消息。
 
 15) 內聯弊病
-------------------------------
+------------
 
 有一個常見的誤解是 ``內聯`` 是 gcc 提供的可以讓代碼運行更快的一個選項。雖然使
 用內聯函數有時候是恰當的 (比如作爲一種替代宏的方式，請看第十二章)，不過很多情
 況下不是這樣。inline 的過度使用會使內核變大，從而使整個系統運行速度變慢。
-因爲體積大內核會占用更多的指令高速緩存，而且會導致 pagecache 的可用內存減少。
-想像一下，一次 pagecache 未命中就會導致一次磁碟尋址，將耗時 5 毫秒。5 毫秒的
+因爲體積大內核會佔用更多的指令高速緩存，而且會導致 pagecache 的可用內存減少。
+想象一下，一次 pagecache 未命中就會導致一次磁盤尋址，將耗時 5 毫秒。5 毫秒的
 時間內 CPU 能執行很多很多指令。
 
 一個基本的原則是如果一個函數有 3 行以上，就不要把它變成內聯函數。這個原則的一
@@ -790,7 +875,7 @@ inline gcc 也可以自動使其內聯。而且其他用戶可能會要求移除
 
 
 16) 函數返回值及命名
-------------------------------
+--------------------
 
 函數可以返回多種不同類型的值，最常見的一種是表明函數執行成功或者失敗的值。這樣
 的一個值可以表示爲一個錯誤代碼整數 (-Exxx＝失敗，0＝成功) 或者一個 ``成功``
@@ -801,7 +886,7 @@ inline gcc 也可以自動使其內聯。而且其他用戶可能會要求移除
 產生這種 bug，請遵循下面的慣例::
 
 	如果函數的名字是一個動作或者強制性的命令，那麼這個函數應該返回錯誤代
-	碼整數。如果是一個判斷，那麼函數應該返回一個 "成功" 布爾值。
+	碼整數。如果是一個判斷，那麼函數應該返回一個“成功”布爾值。
 
 比如， ``add work`` 是一個命令，所以 add_work() 在成功時返回 0，在失敗時返回
 -EBUSY。類似的，因爲 ``PCI device present`` 是一個判斷，所以 pci_dev_present()
@@ -810,13 +895,35 @@ inline gcc 也可以自動使其內聯。而且其他用戶可能會要求移除
 所有 EXPORTed 函數都必須遵守這個慣例，所有的公共函數也都應該如此。私有
 (static) 函數不需要如此，但是我們也推薦這樣做。
 
-返回值是實際計算結果而不是計算是否成功的標誌的函數不受此慣例的限制。一般的，
+返回值是實際計算結果而不是計算是否成功的標誌的函數不受此慣例的限制。通常
 他們通過返回一些正常值範圍之外的結果來表示出錯。典型的例子是返回指針的函數，
 他們使用 NULL 或者 ERR_PTR 機制來報告錯誤。
 
+17) 使用布爾類型
+----------------
+
+Linux內核布爾（bool）類型是C99 _Bool類型的別名。布爾值只能爲0或1，而對布爾的
+隱式或顯式轉換將自動將值轉換爲true或false。在使用布爾類型時 **不需要** 構造，
+它會消除一類錯誤。
+
+使用布爾值時，應使用true和false定義，而不是1和0。
 
-17) 不要重新發明內核宏
-------------------------------
+布爾函數返回類型和堆棧變量總是可以在適當的時候使用。鼓勵使用布爾來提高可讀性，
+並且布爾值在存儲時通常比“int”更好。
+
+如果緩存行佈局或值的大小很重要，請不要使用布爾，因爲其大小和對齊方式根據編譯
+的體系結構而不同。針對對齊和大小進行優化的結構體不應使用布爾。
+
+如果一個結構體有多個true/false值，請考慮將它們合併爲具有1比特成員的位域，或使
+用適當的固定寬度類型，如u8。
+
+類似地，對於函數參數，多個true/false值可以合併爲單個按位的“標誌”參數，如果調
+用點具有裸true/false常量，“標誌”參數通常是更具可讀性的替代方法。
+
+總之，在結構體和參數中有限地使用布爾可以提高可讀性。
+
+18) 不要重新發明內核宏
+----------------------
 
 頭文件 include/linux/kernel.h 包含了一些宏，你應該使用它們，而不要自己寫一些
 它們的變種。比如，如果你需要計算一個數組的長度，使用這個宏
@@ -832,15 +939,15 @@ inline gcc 也可以自動使其內聯。而且其他用戶可能會要求移除
 	#define sizeof_field(t, f) (sizeof(((t*)0)->f))
 
 還有可以做嚴格的類型檢查的 min() 和 max() 宏，如果你需要可以使用它們。你可以
-自己看看那個頭文件里還定義了什麼你可以拿來用的東西，如果有定義的話，你就不應
-在你的代碼里自己重新定義。
+自己看看那個頭文件裏還定義了什麼你可以拿來用的東西，如果有定義的話，你就不應
+在你的代碼裏自己重新定義。
 
 
-18) 編輯器模式行和其他需要羅嗦的事情
---------------------------------------------------
+19) 編輯器模式行和其他需要羅嗦的事情
+------------------------------------
 
-有一些編輯器可以解釋嵌入在源文件里的由一些特殊標記標明的配置信息。比如，emacs
-能夠解釋被標記成這樣的行：
+有一些編輯器可以解釋嵌入在源文件裏的由一些特殊標記標明的配置信息。比如，emacs
+能夠解析被標記成這樣的行：
 
 .. code-block:: c
 
@@ -856,23 +963,23 @@ inline gcc 也可以自動使其內聯。而且其他用戶可能會要求移除
 	End:
 	*/
 
-Vim 能夠解釋這樣的標記：
+Vim 能夠解析這樣的標記：
 
 .. code-block:: c
 
 	/* vim:set sw=8 noet */
 
-不要在原始碼中包含任何這樣的內容。每個人都有他自己的編輯器配置，你的源文件不
+不要在源代碼中包含任何這樣的內容。每個人都有他自己的編輯器配置，你的源文件不
 應該覆蓋別人的配置。這包括有關縮進和模式配置的標記。人們可以使用他們自己定製
 的模式，或者使用其他可以產生正確的縮進的巧妙方法。
 
 
-19) 內聯彙編
-------------------------------
+20) 內聯彙編
+------------
 
-在特定架構的代碼中，你可能需要內聯彙編與 CPU 和平台相關功能連接。需要這麼做時
+在特定架構的代碼中，你可能需要內聯彙編與 CPU 和平臺相關功能連接。需要這麼做時
 就不要猶豫。然而，當 C 可以完成工作時，不要平白無故地使用內聯彙編。在可能的情
-況下，你可以並且應該用 C 和硬體溝通。
+況下，你可以並且應該用 C 和硬件溝通。
 
 請考慮去寫捆綁通用位元 (wrap common bits) 的內聯彙編的簡單輔助函數，別去重複
 地寫下只有細微差異內聯彙編。記住內聯彙編可以使用 C 參數。
@@ -883,9 +990,9 @@ Vim 能夠解釋這樣的標記：
 你可能需要把彙編語句標記爲 volatile，用來阻止 GCC 在沒發現任何副作用後就把它
 移除了。你不必總是這樣做，儘管，這不必要的舉動會限制優化。
 
-在寫一個包含多條指令的單個內聯彙編語句時，把每條指令用引號分割而且各占一行，
-除了最後一條指令外，在每個指令結尾加上 \n\t，讓彙編輸出時可以正確地縮進下一條
-指令：
+在寫一個包含多條指令的單個內聯彙編語句時，把每條指令用引號分割而且各佔一行，
+除了最後一條指令外，在每個指令結尾加上 ``\n\t`` ，讓彙編輸出時可以正確地縮進
+下一條指令：
 
 .. code-block:: c
 
@@ -894,10 +1001,10 @@ Vim 能夠解釋這樣的標記：
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
 
 
-20) 條件編譯
-------------------------------
+21) 條件編譯
+------------
 
-只要可能，就不要在 .c 文件裡面使用預處理條件 (#if, #ifdef)；這樣做讓代碼更難
+只要可能，就不要在 .c 文件裏面使用預處理條件 (#if, #ifdef)；這樣做會讓代碼更難
 閱讀並且更難去跟蹤邏輯。替代方案是，在頭文件中用預處理條件提供給那些 .c 文件
 使用，再給 #else 提供一個空樁 (no-op stub) 版本，然後在 .c 文件內無條件地調用
 那些 (定義在頭文件內的) 函數。這樣做，編譯器會避免爲樁函數 (stub) 的調用生成
@@ -908,8 +1015,8 @@ Vim 能夠解釋這樣的標記：
 條件到這個輔助函數內。
 
 如果你有一個在特定配置中，可能變成未使用的函數或變量，編譯器會警告它定義了但
-未使用，把它標記爲 __maybe_unused 而不是將它包含在一個預處理條件中。(然而，如
-果一個函數或變量總是未使用，就直接刪除它。)
+未使用，請把它標記爲 __maybe_unused 而不是將它包含在一個預處理條件中。(然而，
+如果一個函數或變量總是未使用，就直接刪除它。)
 
 在代碼中，儘可能地使用 IS_ENABLED 宏來轉化某個 Kconfig 標記爲 C 的布爾
 表達式，並在一般的 C 條件中使用它：
@@ -926,7 +1033,7 @@ Vim 能夠解釋這樣的標記：
 不存在時，你還是必須去用 #ifdef。
 
 在任何有意義的 #if 或 #ifdef 塊的末尾 (超過幾行的)，在 #endif 同一行的後面寫下
-註解，注釋這個條件表達式。例如：
+註解，註釋這個條件表達式。例如：
 
 .. code-block:: c
 
@@ -935,24 +1042,46 @@ Vim 能夠解釋這樣的標記：
 	#endif /* CONFIG_SOMETHING */
 
 
-附錄 I) 參考
--------------------
+附錄 I) 參考資料
+----------------
 
-The C Programming Language, 第二版
+The C Programming Language, 2nd Edition
 作者：Brian W. Kernighan 和 Denni M. Ritchie.
 Prentice Hall, Inc., 1988.
-ISBN 0-13-110362-8 (軟皮), 0-13-110370-9 (硬皮).
+ISBN 0-13-110362-8 (平裝), 0-13-110370-9 (精裝).
+
+.. note::
+
+    《C程序設計語言（第2版）》
+    作者：[美] Brian W. Kernighan / [美] Dennis M. Ritchie
+    譯者：徐寶文 / 李志 / 尤晉元（審校）
+    出版社：機械工業出版社，2019
+    ISBN：9787111617945
 
 The Practice of Programming
 作者：Brian W. Kernighan 和 Rob Pike.
 Addison-Wesley, Inc., 1999.
 ISBN 0-201-61586-X.
 
+.. note::
+
+    《程序設計實踐》
+    作者：[美] Brian W. Kernighan / [美] Rob Pike
+    出版社：機械工業出版社，2005
+    ISBN：9787111091578
+
+    《程序設計實踐》
+    作者：[美] Brian W. Kernighan / Rob Pike
+    譯者：裘宗燕
+    出版社：機械工業出版社，2000
+    ISBN：9787111075738
+
 GNU 手冊 - 遵循 K&R 標準和此文本 - cpp, gcc, gcc internals and indent,
 都可以從 https://www.gnu.org/manual/ 找到
 
 WG14 是 C 語言的國際標準化工作組，URL: http://www.open-std.org/JTC1/SC22/WG14/
 
-Kernel process/coding-style.rst，作者 greg@kroah.com 發表於 OLS 2002：
+內核文檔 Documentation/process/coding-style.rst，
+作者 greg@kroah.com 發表於 OLS 2002：
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
 
diff --git a/Documentation/translations/zh_TW/process/development-process.rst b/Documentation/translations/zh_TW/process/development-process.rst
index f4cf5c2bbc82..7d803d3db89e 100644
--- a/Documentation/translations/zh_TW/process/development-process.rst
+++ b/Documentation/translations/zh_TW/process/development-process.rst
@@ -26,5 +26,5 @@
    7.AdvancedTopics
    8.Conclusion
 
-本文檔的目的是幫助開發人員（及其經理）以最小的挫折感與開發社區合作。它試圖記錄這個社區如何以一種不熟悉Linux內核開發（或者實際上是自由軟體開發）的人可以訪問的方式工作。雖然這裡有一些技術資料，但這是一個面向過程的討論，不需要深入了解內核編程就可以理解。
+本文檔的目的是幫助開發人員（及其經理）以最小的挫折感與開發社區合作。它試圖記錄這個社區如何以一種不熟悉Linux內核開發（或者實際上是自由軟件開發）的人可以訪問的方式工作。雖然這裏有一些技術資料，但這是一個面向過程的討論，不需要深入瞭解內核編程就可以理解。
 
diff --git a/Documentation/translations/zh_TW/process/email-clients.rst b/Documentation/translations/zh_TW/process/email-clients.rst
index ae63e41d9cee..55e10d3fc28a 100644
--- a/Documentation/translations/zh_TW/process/email-clients.rst
+++ b/Documentation/translations/zh_TW/process/email-clients.rst
@@ -1,20 +1,21 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-.. _tw_email_clients:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
+.. _tw_email_clients:
 
-譯者::
+:Original: Documentation/process/email-clients.rst
 
-        中文版維護者： 賈威威  Harry Wei <harryxiyou@gmail.com>
-        中文版翻譯者： 賈威威  Harry Wei <harryxiyou@gmail.com>
-                       時奎亮  Alex Shi <alex.shi@linux.alibaba.com>
-        中文版校譯者： Yinglin Luan <synmyth@gmail.com>
-        	       Xiaochen Wang <wangxiaochen0@gmail.com>
-                       yaxinsn <yaxinsn@163.com>
-                      Hu Haowen <src.res.211@gmail.com>
+:譯者:
+ - 賈威威  Harry Wei <harryxiyou@gmail.com>
+ - 時奎亮  Alex Shi <alexs@kernel.org>
+ - 吳想成  Wu XiangCheng <bobwxc@email.cn>
+
+:校譯:
+ - Yinglin Luan <synmyth@gmail.com>
+ - Xiaochen Wang <wangxiaochen0@gmail.com>
+ - yaxinsn <yaxinsn@163.com>
+ - Hu Haowen <src.res.211@gmail.com>
 
 Linux郵件客戶端配置信息
 =======================
@@ -30,30 +31,35 @@ Git
 改日誌。如果工作正常，再將補丁發送到相應的郵件列表。
 
 
-普通配置
+通用配置
 --------
+
 Linux內核補丁是通過郵件被提交的，最好把補丁作爲郵件體的內嵌文本。有些維護者
 接收附件，但是附件的內容格式應該是"text/plain"。然而，附件一般是不贊成的，
 因爲這會使補丁的引用部分在評論過程中變的很困難。
 
+同時也強烈建議在補丁或其他郵件的正文中使用純文本格式。https://useplaintext.email
+有助於瞭解如何配置你喜歡的郵件客戶端，並在您還沒有首選的情況下列出一些推薦的
+客戶端。
+
 用來發送Linux內核補丁的郵件客戶端在發送補丁時應該處於文本的原始狀態。例如，
-他們不能改變或者刪除制表符或者空格，甚至是在每一行的開頭或者結尾。
+他們不能改變或者刪除製表符或者空格，甚至是在每一行的開頭或者結尾。
 
 不要通過"format=flowed"模式發送補丁。這樣會引起不可預期以及有害的斷行。
 
 不要讓你的郵件客戶端進行自動換行。這樣也會破壞你的補丁。
 
-郵件客戶端不能改變文本的字符集編碼方式。要發送的補丁只能是ASCII或者UTF-8編碼方式，
-如果你使用UTF-8編碼方式發送郵件，那麼你將會避免一些可能發生的字符集問題。
+郵件客戶端不能改變文本的字符集編碼方式。要發送的補丁只能是ASCII或者UTF-8編碼
+方式，如果你使用UTF-8編碼方式發送郵件，那麼你將會避免一些可能發生的字符集問題。
 
-郵件客戶端應該形成並且保持 References: 或者 In-Reply-To: 標題，那麼
-郵件話題就不會中斷。
+郵件客戶端應該生成並且保持“References:”或者“In-Reply-To:”郵件頭，這樣郵件會話
+就不會中斷。
 
-複製粘帖(或者剪貼粘帖)通常不能用於補丁，因爲制表符會轉換爲空格。使用xclipboard, xclip
-或者xcutsel也許可以，但是最好測試一下或者避免使用複製粘帖。
+複製粘帖(或者剪貼粘帖)通常不能用於補丁，因爲製表符會轉換爲空格。使用xclipboard,
+xclip或者xcutsel也許可以，但是最好測試一下或者避免使用複製粘帖。
 
-不要在使用PGP/GPG署名的郵件中包含補丁。這樣會使得很多腳本不能讀取和適用於你的補丁。
-（這個問題應該是可以修復的）
+不要在使用PGP/GPG簽名的郵件中包含補丁。這樣會使得很多腳本不能讀取和適用於你的
+補丁。（這個問題應該是可以修復的）
 
 在給內核郵件列表發送補丁之前，給自己發送一個補丁是個不錯的主意，保存接收到的
 郵件，將補丁用'patch'命令打上，如果成功了，再給內核郵件列表發送。
@@ -61,100 +67,135 @@ Linux內核補丁是通過郵件被提交的，最好把補丁作爲郵件體的
 
 一些郵件客戶端提示
 ------------------
-這裡給出一些詳細的MUA配置提示，可以用於給Linux內核發送補丁。這些並不意味是
-所有的軟體包配置總結。
+
+這裏給出一些詳細的MUA配置提示，可以用於給Linux內核發送補丁。這些並不意味是
+所有的軟件包配置總結。
 
 說明：
-TUI = 以文本爲基礎的用戶接口
-GUI = 圖形界面用戶接口
+
+- TUI = 以文本爲基礎的用戶接口
+- GUI = 圖形界面用戶接口
 
 Alpine (TUI)
-~~~~~~~~~~~~
+************
 
 配置選項：
-在"Sending Preferences"部分：
 
-- "Do Not Send Flowed Text"必須開啓
-- "Strip Whitespace Before Sending"必須關閉
+在 :menuselection:`Sending Preferences` 菜單：
+
+- :menuselection:`Do Not Send Flowed Text` 必須開啓
+- :menuselection:`Strip Whitespace Before Sending` 必須關閉
+
+當寫郵件時，光標應該放在補丁會出現的地方，然後按下 :kbd:`CTRL-R` 組合鍵，使指
+定的補丁文件嵌入到郵件中。
 
-當寫郵件時，光標應該放在補丁會出現的地方，然後按下CTRL-R組合鍵，使指定的
-補丁文件嵌入到郵件中。
+Claws Mail (GUI)
+****************
+
+可以用，有人用它成功地發過補丁。
+
+用 :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`) 或外置編輯器插入補丁。
+
+若要在Claws編輯窗口重修改插入的補丁，需關閉
+:menuselection:`Configuration-->Preferences-->Compose-->Wrapping`
+的 `Auto wrapping` 。
 
 Evolution (GUI)
-~~~~~~~~~~~~~~~
+***************
 
-一些開發者成功的使用它發送補丁
+一些開發者成功的使用它發送補丁。
 
-當選擇郵件選項：Preformat
-  從Format->Heading->Preformatted (Ctrl-7)或者工具欄
+撰寫郵件時：
+從 :menuselection:`格式-->段落樣式-->預格式化` (:kbd:`CTRL-7`)
+或工具欄選擇 :menuselection:`預格式化` ；
 
 然後使用：
-  Insert->Text File... (Alt-n x)插入補丁文件。
+:menuselection:`插入-->文本文件...` (:kbd:`ALT-N x`) 插入補丁文件。
 
-你還可以"diff -Nru old.c new.c | xclip"，選擇Preformat，然後使用中間鍵進行粘帖。
+你還可以 ``diff -Nru old.c new.c | xclip`` ，選擇 :menuselection:`預格式化` ，
+然後使用鼠標中鍵進行粘帖。
 
 Kmail (GUI)
-~~~~~~~~~~~
+***********
 
 一些開發者成功的使用它發送補丁。
 
-默認設置不爲HTML格式是合適的；不要啓用它。
+默認撰寫設置禁用HTML格式是合適的；不要啓用它。
+
+當書寫一封郵件的時候，在選項下面不要選擇自動換行。唯一的缺點就是你在郵件中輸
+入的任何文本都不會被自動換行，因此你必須在發送補丁之前手動換行。最簡單的方法
+就是啓用自動換行來書寫郵件，然後把它保存爲草稿。一旦你在草稿中再次打開它，它
+已經全部自動換行了，那麼你的郵件雖然沒有選擇自動換行，但是還不會失去已有的自
+動換行。
 
-當書寫一封郵件的時候，在選項下面不要選擇自動換行。唯一的缺點就是你在郵件中輸入的任何文本
-都不會被自動換行，因此你必須在發送補丁之前手動換行。最簡單的方法就是啓用自動換行來書寫郵件，
-然後把它保存爲草稿。一旦你在草稿中再次打開它，它已經全部自動換行了，那麼你的郵件雖然沒有
-選擇自動換行，但是還不會失去已有的自動換行。
+在郵件的底部，插入補丁之前，放上常用的補丁定界符：三個連字符(``---``)。
 
-在郵件的底部，插入補丁之前，放上常用的補丁定界符：三個連字號(---)。
+然後在 :menuselection:`信件` 菜單，選擇 :menuselection:`插入文本文件` ，接
+着選取你的補丁文件。還有一個額外的選項，你可以通過它配置你的創建新郵件工具欄，
+加上 :menuselection:`插入文本文件` 圖標。
 
-然後在"Message"菜單條目，選擇插入文件，接著選取你的補丁文件。還有一個額外的選項，你可以
-通過它配置你的郵件建立工具欄菜單，還可以帶上"insert file"圖標。
+將編輯器窗口拉到足夠寬避免折行。對於KMail 1.13.5 (KDE 4.5.4)，它會在發送郵件
+時對編輯器窗口中顯示折行的地方自動換行。在選項菜單中取消自動換行仍不能解決。
+因此，如果你的補丁中有非常長的行，必須在發送之前把編輯器窗口拉得非常寬。
+參見：https://bugs.kde.org/show_bug.cgi?id=174034
 
-你可以安全地通過GPG標記附件，但是內嵌補丁最好不要使用GPG標記它們。作爲內嵌文本的簽發補丁，
-當從GPG中提取7位編碼時會使他們變的更加複雜。
+你可以安全地用GPG簽名附件，但是內嵌補丁最好不要使用GPG簽名它們。作爲內嵌文本
+插入的簽名補丁將使其難以從7-bit編碼中提取。
 
-如果你非要以附件的形式發送補丁，那麼就右鍵點擊附件，然後選中屬性，突出"Suggest automatic
-display"，這樣內嵌附件更容易讓讀者看到。
+如果你非要以附件的形式發送補丁，那麼就右鍵點擊附件，然後選擇
+:menuselection:`屬性` ，打開 :menuselection:`建議自動顯示` ，使附件內聯更容
+易讓讀者看到。
 
-當你要保存將要發送的內嵌文本補丁，你可以從消息列表窗格選擇包含補丁的郵件，然後右擊選擇
-"save as"。你可以使用一個沒有更改的包含補丁的郵件，如果它是以正確的形式組成。當你正真在它
-自己的窗口之下察看，那時沒有選項可以保存郵件--已經有一個這樣的bug被匯報到了kmail的bugzilla
-並且希望這將會被處理。郵件是以只針對某個用戶可讀寫的權限被保存的，所以如果你想把郵件複製到其他地方，
-你不得不把他們的權限改爲組或者整體可讀。
+當你要保存將要發送的內嵌文本補丁，你可以從消息列表窗格選擇包含補丁的郵件，然
+後右鍵選擇 :menuselection:`另存爲` 。如果整個電子郵件的組成正確，您可直接將
+其作爲補丁使用。電子郵件以當前用戶可讀寫權限保存，因此您必須 ``chmod`` ，以
+使其在複製到別處時用戶組和其他人可讀。
 
 Lotus Notes (GUI)
-~~~~~~~~~~~~~~~~~
+*****************
 
 不要使用它。
 
+IBM Verse (Web GUI)
+*******************
+
+同上條。
+
 Mutt (TUI)
-~~~~~~~~~~
+**********
 
-很多Linux開發人員使用mutt客戶端，所以證明它肯定工作的非常漂亮。
+很多Linux開發人員使用mutt客戶端，這證明它肯定工作得非常漂亮。
 
-Mutt不自帶編輯器，所以不管你使用什麼編輯器都不應該帶有自動斷行。大多數編輯器都帶有
-一個"insert file"選項，它可以通過不改變文件內容的方式插入文件。
+Mutt不自帶編輯器，所以不管你使用什麼編輯器，不自動斷行就行。大多數編輯器都有
+:menuselection:`插入文件` 選項，它可以在不改變文件內容的情況下插入文件。
+
+用 ``vim`` 作爲mutt的編輯器::
 
-'vim'作爲mutt的編輯器：
   set editor="vi"
 
-  如果使用xclip，敲入以下命令
+如果使用xclip，敲入以下命令::
+
   :set paste
-  按中鍵之前或者shift-insert或者使用
+
+然後再按中鍵或者shift-insert或者使用::
+
   :r filename
 
-如果想要把補丁作爲內嵌文本。
-(a)ttach工作的很好，不帶有"set paste"。
+把補丁插入爲內嵌文本。
+在未設置  ``set paste`` 時(a)ttach工作的很好。
 
 你可以通過 ``git format-patch`` 生成補丁，然後用 Mutt發送它們::
 
-        $ mutt -H 0001-some-bug-fix.patch
+    $ mutt -H 0001-some-bug-fix.patch
 
 配置選項：
+
 它應該以默認設置的形式工作。
-然而，把"send_charset"設置爲"us-ascii::utf-8"也是一個不錯的主意。
+然而，把 ``send_charset`` 設置一下也是一個不錯的主意::
 
-Mutt 是高度可配置的。 這裡是個使用mutt通過 Gmail 發送的補丁的最小配置::
+  set send_charset="us-ascii:utf-8"
+
+Mutt 是高度可配置的。 這裏是個使用mutt通過 Gmail 發送的補丁的最小配置::
 
   # .muttrc
   # ================  IMAP ====================
@@ -181,72 +222,108 @@ Mutt 是高度可配置的。 這裡是個使用mutt通過 Gmail 發送的補丁
   set from = "username@gmail.com"
   set use_from = yes
 
-Mutt文檔含有更多信息:
+Mutt文檔含有更多信息：
 
-    http://dev.mutt.org/trac/wiki/UseCases/Gmail
+    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail
 
-    http://dev.mutt.org/doc/manual.html
+    http://www.mutt.org/doc/manual/
 
 Pine (TUI)
-~~~~~~~~~~
+**********
 
 Pine過去有一些空格刪減問題，但是這些現在應該都被修復了。
 
-如果可以，請使用alpine(pine的繼承者)
+如果可以，請使用alpine（pine的繼承者）。
 
 配置選項：
-- 最近的版本需要消除流程文本
-- "no-strip-whitespace-before-send"選項也是需要的。
+
+- 最近的版本需要 ``quell-flowed-text``
+- ``no-strip-whitespace-before-send`` 選項也是需要的。
 
 
 Sylpheed (GUI)
-~~~~~~~~~~~~~~
+**************
 
 - 內嵌文本可以很好的工作（或者使用附件）。
 - 允許使用外部的編輯器。
-- 對於目錄較多時非常慢。
+- 收件箱較多時非常慢。
 - 如果通過non-SSL連接，無法使用TLS SMTP授權。
-- 在組成窗口中有一個很有用的ruler bar。
-- 給地址本中添加地址就不會正確的了解顯示名。
+- 撰寫窗口的標尺很有用。
+- 將地址添加到通訊簿時無法正確理解顯示的名稱。
 
 Thunderbird (GUI)
-~~~~~~~~~~~~~~~~~
+*****************
+
+Thunderbird是Outlook的克隆版本，它很容易損壞文本，但也有一些方法強制修正。
+
+在完成修改後（包括安裝擴展），您需要重新啓動Thunderbird。
+
+- 允許使用外部編輯器：
+
+  使用Thunderbird發補丁最簡單的方法是使用擴展來打開您最喜歡的外部編輯器。
+
+  下面是一些能夠做到這一點的擴展樣例。
+
+  - “External Editor Revived”
+
+    https://github.com/Frederick888/external-editor-revived
+
+    https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/
+
+    它需要安裝“本地消息主機（native messaging host）”。
+    參見以下文檔:
+    https://github.com/Frederick888/external-editor-revived/wiki
+
+  - “External Editor”
+
+    https://github.com/exteditor/exteditor
+
+    下載並安裝此擴展，然後打開 :menuselection:`新建消息` 窗口, 用
+    :menuselection:`查看-->工具欄-->自定義...` 給它增加一個按鈕，直接點擊此
+    按鈕即可使用外置編輯器。
+
+    請注意，“External Editor”要求你的編輯器不能fork，換句話說，編輯器必須在
+    關閉前不返回。你可能需要傳遞額外的參數或修改編輯器設置。最值得注意的是，
+    如果您使用的是gvim，那麼您必須將 :menuselection:`external editor` 設置的
+    編輯器字段設置爲 ``/usr/bin/gvim --nofork"`` （假設可執行文件在
+    ``/usr/bin`` ），以傳遞 ``-f`` 參數。如果您正在使用其他編輯器，請閱讀其
+    手冊瞭解如何處理。
 
-默認情況下，thunderbird很容易損壞文本，但是還有一些方法可以強制它變得更好。
+若要修正內部編輯器，請執行以下操作：
 
-- 在用戶帳號設置里，組成和尋址，不要選擇"Compose messages in HTML format"。
+- 修改你的Thunderbird設置，不要使用 ``format=flowed`` ！
+  回到主窗口，按照
+  :menuselection:`主菜單-->首選項-->常規-->配置編輯器...`
+  打開Thunderbird的配置編輯器。
 
-- 編輯你的Thunderbird配置設置來使它不要拆行使用：user_pref("mailnews.wraplength", 0);
+  - 將 ``mailnews.send_plaintext_flowed`` 設爲 ``false``
 
-- 編輯你的Thunderbird配置設置，使它不要使用"format=flowed"格式：user_pref("mailnews.
-  send_plaintext_flowed", false);
+  - 將 ``mailnews.wraplength`` 從 ``72`` 改爲 ``0``
 
-- 你需要使Thunderbird變爲預先格式方式：
-  如果默認情況下你書寫的是HTML格式，那不是很難。僅僅從標題欄的下拉框中選擇"Preformat"格式。
-  如果默認情況下你書寫的是文本格式，你不得把它改爲HTML格式（僅僅作爲一次性的）來書寫新的消息，
-  然後強制使它回到文本格式，否則它就會拆行。要實現它，在寫信的圖標上使用shift鍵來使它變爲HTML
-  格式，然後標題欄的下拉框中選擇"Preformat"格式。
+- 不要寫HTML郵件！
+  回到主窗口，打開
+  :menuselection:`主菜單-->賬戶設置-->你的@郵件.地址-->通訊錄/編寫&地址簿` ，
+  關掉 ``以HTML格式編寫消息`` 。
 
-- 允許使用外部的編輯器：
-  針對Thunderbird打補丁最簡單的方法就是使用一個"external editor"擴展，然後使用你最喜歡的
-  $EDITOR來讀取或者合併補丁到文本中。要實現它，可以下載並且安裝這個擴展，然後添加一個使用它的
-  按鍵View->Toolbars->Customize...最後當你書寫信息的時候僅僅點擊它就可以了。
+- 只用純文本格式查看郵件！
+  回到主窗口， :menuselection:`主菜單-->查看-->消息體爲-->純文本` ！
 
 TkRat (GUI)
-~~~~~~~~~~~
+***********
 
 可以使用它。使用"Insert file..."或者外部的編輯器。
 
 Gmail (Web GUI)
-~~~~~~~~~~~~~~~
+***************
 
 不要使用它發送補丁。
 
-Gmail網頁客戶端自動地把制表符轉換爲空格。
+Gmail網頁客戶端自動地把製表符轉換爲空格。
 
-雖然制表符轉換爲空格問題可以被外部編輯器解決，同時它還會使用回車換行把每行拆分爲78個字符。
+雖然製表符轉換爲空格問題可以被外部編輯器解決，但它同時還會使用回車換行把每行
+拆分爲78個字符。
 
-另一個問題是Gmail還會把任何不是ASCII的字符的信息改爲base64編碼。它把東西變的像歐洲人的名字。
+另一個問題是Gmail還會把任何含有非ASCII的字符的消息改用base64編碼，如歐洲人的
+名字。
 
-                                ###
 
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index 8e4db8baa0d1..50b2dc3a3999 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -6,17 +6,17 @@
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
              Hu Haowen <src.res.211@gmail.com>
 
-被限制的硬體問題
+被限制的硬件問題
 ================
 
 範圍
 ----
 
-導致安全問題的硬體問題與只影響Linux內核的純軟體錯誤是不同的安全錯誤類別。
+導致安全問題的硬件問題與隻影響Linux內核的純軟件錯誤是不同的安全錯誤類別。
 
-必須區別對待諸如熔毀(Meltdown)、Spectre、L1TF等硬體問題，因爲它們通常會影響
-所有作業系統（「OS」），因此需要在不同的OS供應商、發行版、硬體供應商和其他各方
-之間進行協調。對於某些問題，軟體緩解可能依賴於微碼或固件更新，這需要進一步的
+必須區別對待諸如熔燬(Meltdown)、Spectre、L1TF等硬件問題，因爲它們通常會影響
+所有操作系統（“OS”），因此需要在不同的OS供應商、發行版、硬件供應商和其他各方
+之間進行協調。對於某些問題，軟件緩解可能依賴於微碼或固件更新，這需要進一步的
 協調。
 
 .. _tw_Contact:
@@ -24,9 +24,9 @@
 接觸
 ----
 
-Linux內核硬體安全小組獨立於普通的Linux內核安全小組。
+Linux內核硬件安全小組獨立於普通的Linux內核安全小組。
 
-該小組只負責協調被限制的硬體安全問題。Linux內核中純軟體安全漏洞的報告不由該
+該小組只負責協調被限制的硬件安全問題。Linux內核中純軟件安全漏洞的報告不由該
 小組處理，報告者將被引導至常規Linux內核安全小組(:ref:`Documentation/admin-guide/
 <securitybugs>`)聯繫。
 
@@ -37,13 +37,13 @@ Linux內核硬體安全小組獨立於普通的Linux內核安全小組。
 者的PGP密鑰或S/MIME證書籤名。該列表的PGP密鑰和S/MIME證書可從
 https://www.kernel.org/.... 獲得。
 
-雖然硬體安全問題通常由受影響的硬體供應商處理，但我們歡迎發現潛在硬體缺陷的研究
+雖然硬件安全問題通常由受影響的硬件供應商處理，但我們歡迎發現潛在硬件缺陷的研究
 人員或個人與我們聯繫。
 
-硬體安全官
+硬件安全官
 ^^^^^^^^^^
 
-目前的硬體安全官小組:
+目前的硬件安全官小組:
 
   - Linus Torvalds（Linux基金會院士）
   - Greg Kroah Hartman（Linux基金會院士）
@@ -62,50 +62,50 @@ Linux基金會目前的IT基礎設施安全總監是 Konstantin Ryabitsev。
 保密協議
 --------
 
-Linux內核硬體安全小組不是正式的機構，因此無法簽訂任何保密協議。核心社區意識到
+Linux內核硬件安全小組不是正式的機構，因此無法簽訂任何保密協議。核心社區意識到
 這些問題的敏感性，並提供了一份諒解備忘錄。
 
 諒解備忘錄
 ----------
 
-Linux內核社區深刻理解在不同作業系統供應商、發行商、硬體供應商和其他各方之間
-進行協調時，保持硬體安全問題處於限制狀態的要求。
+Linux內核社區深刻理解在不同操作系統供應商、發行商、硬件供應商和其他各方之間
+進行協調時，保持硬件安全問題處於限制狀態的要求。
 
-Linux內核社區在過去已經成功地處理了硬體安全問題，並且有必要的機制允許在限制
+Linux內核社區在過去已經成功地處理了硬件安全問題，並且有必要的機制允許在限制
 限制下進行符合社區的開發。
 
-Linux內核社區有一個專門的硬體安全小組負責初始聯繫，並監督在限制規則下處理
+Linux內核社區有一個專門的硬件安全小組負責初始聯繫，並監督在限制規則下處理
 此類問題的過程。
 
-硬體安全小組確定開發人員（領域專家），他們將組成特定問題的初始響應小組。最初
+硬件安全小組確定開發人員（領域專家），他們將組成特定問題的初始響應小組。最初
 的響應小組可以引入更多的開發人員（領域專家）以最佳的技術方式解決這個問題。
 
 所有相關開發商承諾遵守限制規定，並對收到的信息保密。違反承諾將導致立即從當前
-問題中排除，並從所有相關郵件列表中刪除。此外，硬體安全小組還將把違反者排除在
+問題中排除，並從所有相關郵件列表中刪除。此外，硬件安全小組還將把違反者排除在
 未來的問題之外。這一後果的影響在我們社區是一種非常有效的威懾。如果發生違規
-情況，硬體安全小組將立即通知相關方。如果您或任何人發現潛在的違規行爲，請立即
-向硬體安全人員報告。
+情況，硬件安全小組將立即通知相關方。如果您或任何人發現潛在的違規行爲，請立即
+向硬件安全人員報告。
 
 流程
 ^^^^
 
-由於Linux內核開發的全球分布式特性，面對面的會議幾乎不可能解決硬體安全問題。
+由於Linux內核開發的全球分佈式特性，面對面的會議幾乎不可能解決硬件安全問題。
 由於時區和其他因素，電話會議很難協調，只能在絕對必要時使用。加密電子郵件已被
 證明是解決此類問題的最有效和最安全的通信方法。
 
 開始披露
 """"""""
 
-披露內容首先通過電子郵件聯繫Linux內核硬體安全小組。此初始聯繫人應包含問題的
-描述和任何已知受影響硬體的列表。如果您的組織製造或分發受影響的硬體，我們建議
-您也考慮哪些其他硬體可能會受到影響。
+披露內容首先通過電子郵件聯繫Linux內核硬件安全小組。此初始聯繫人應包含問題的
+描述和任何已知受影響硬件的列表。如果您的組織製造或分發受影響的硬件，我們建議
+您也考慮哪些其他硬件可能會受到影響。
 
-硬體安全小組將提供一個特定於事件的加密郵件列表，用於與報告者進行初步討論、
+硬件安全小組將提供一個特定於事件的加密郵件列表，用於與報告者進行初步討論、
 進一步披露和協調。
 
-硬體安全小組將向披露方提供一份開發人員（領域專家）名單，在與開發人員確認他們
+硬件安全小組將向披露方提供一份開發人員（領域專家）名單，在與開發人員確認他們
 將遵守本諒解備忘錄和文件化流程後，應首先告知開發人員有關該問題的信息。這些開發
-人員組成初始響應小組，並在初始接觸後負責處理問題。硬體安全小組支持響應小組，
+人員組成初始響應小組，並在初始接觸後負責處理問題。硬件安全小組支持響應小組，
 但不一定參與緩解開發過程。
 
 雖然個別開發人員可能通過其僱主受到保密協議的保護，但他們不能以Linux內核開發
@@ -113,7 +113,7 @@ Linux內核社區有一個專門的硬體安全小組負責初始聯繫，並監
 
 披露方應提供已經或應該被告知該問題的所有其他實體的聯繫人名單。這有幾個目的:
 
-  - 披露的實體列表允許跨行業通信，例如其他作業系統供應商、硬體供應商等。
+  - 披露的實體列表允許跨行業通信，例如其他操作系統供應商、硬件供應商等。
 
   - 可聯繫已披露的實體，指定應參與緩解措施開發的專家。
 
@@ -133,10 +133,10 @@ Linux內核社區有一個專門的硬體安全小組負責初始聯繫，並監
 
 初始響應小組設置加密郵件列表，或在適當的情況下重新修改現有郵件列表。
 
-使用郵件列表接近於正常的Linux開發過程，並且在過去已經成功地用於爲各種硬體安全
+使用郵件列表接近於正常的Linux開發過程，並且在過去已經成功地用於爲各種硬件安全
 問題開發緩解措施。
 
-郵件列表的操作方式與正常的Linux開發相同。發布、討論和審查修補程序，如果同意，
+郵件列表的操作方式與正常的Linux開發相同。發佈、討論和審查修補程序，如果同意，
 則應用於非公共git存儲庫，參與開發人員只能通過安全連接訪問該存儲庫。存儲庫包含
 針對主線內核的主開發分支，並根據需要爲穩定的內核版本提供向後移植分支。
 
@@ -155,9 +155,9 @@ Linux內核社區有一個專門的硬體安全小組負責初始聯繫，並監
 """"""""
 
 有關各方將協商限制結束的日期和時間。此時，準備好的緩解措施集成到相關的內核樹中
-並發布。
+併發布。
 
-雖然我們理解硬體安全問題需要協調限制時間，但限制時間應限制在所有有關各方制定、
+雖然我們理解硬件安全問題需要協調限制時間，但限制時間應限制在所有有關各方制定、
 測試和準備緩解措施所需的最短時間內。人爲地延長限制時間以滿足會議討論日期或其他
 非技術原因，會給相關的開發人員和響應小組帶來了更多的工作和負擔，因爲補丁需要
 保持最新，以便跟蹤正在進行的上游內核開發，這可能會造成衝突的更改。
@@ -165,7 +165,7 @@ Linux內核社區有一個專門的硬體安全小組負責初始聯繫，並監
 CVE分配
 """""""
 
-硬體安全小組和初始響應小組都不分配CVE，開發過程也不需要CVE。如果CVE是由披露方
+硬件安全小組和初始響應小組都不分配CVE，開發過程也不需要CVE。如果CVE是由披露方
 提供的，則可用於文檔中。
 
 流程專使
@@ -196,16 +196,16 @@ CVE分配
   Google	Kees Cook <keescook@chromium.org>
   ============= ========================================================
 
-如果要將您的組織添加到專使名單中，請與硬體安全小組聯繫。被提名的專使必須完全
+如果要將您的組織添加到專使名單中，請與硬件安全小組聯繫。被提名的專使必須完全
 理解和支持我們的過程，並且在Linux內核社區中很容易聯繫。
 
 加密郵件列表
 ------------
 
 我們使用加密郵件列表進行通信。這些列表的工作原理是，發送到列表的電子郵件使用
-列表的PGP密鑰或列表的/MIME證書進行加密。郵件列表軟體對電子郵件進行解密，並
+列表的PGP密鑰或列表的/MIME證書進行加密。郵件列表軟件對電子郵件進行解密，並
 使用訂閱者的PGP密鑰或S/MIME證書爲每個訂閱者分別對其進行重新加密。有關郵件列表
-軟體和用於確保列表安全和數據保護的設置的詳細信息，請訪問:
+軟件和用於確保列表安全和數據保護的設置的詳細信息，請訪問:
 https://www.kernel.org/....
 
 關鍵點
@@ -220,8 +220,8 @@ https://www.kernel.org/....
 訂閱由響應小組處理。希望參與通信的披露方將潛在訂戶的列表發送給響應組，以便
 響應組可以驗證訂閱請求。
 
-每個訂戶都需要通過電子郵件向響應小組發送訂閱請求。電子郵件必須使用訂閱伺服器
-的PGP密鑰或S/MIME證書籤名。如果使用PGP密鑰，則必須從公鑰伺服器獲得該密鑰，
+每個訂戶都需要通過電子郵件向響應小組發送訂閱請求。電子郵件必須使用訂閱服務器
+的PGP密鑰或S/MIME證書籤名。如果使用PGP密鑰，則必須從公鑰服務器獲得該密鑰，
 並且理想情況下該密鑰連接到Linux內核的PGP信任網。另請參見:
 https://www.kernel.org/signature.html.
 
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 306f5b77b4b8..e58d5eccb6c8 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. _tw_process_howto:
 
@@ -31,8 +31,8 @@
 入門
 ----
 
-你想了解如何成爲一名Linux內核開發者？或者老闆吩咐你「給這個設備寫個Linux
-驅動程序」？這篇文章的目的就是教會你達成這些目標的全部訣竅，它將描述你需
+你想了解如何成爲一名Linux內核開發者？或者老闆吩咐你“給這個設備寫個Linux
+驅動程序”？這篇文章的目的就是教會你達成這些目標的全部訣竅，它將描述你需
 要經過的流程以及給出如何同內核社區合作的一些提示。它還將試圖解釋內核社區
 爲何這樣運作。
 
@@ -52,11 +52,11 @@ Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C11標準，但
 標準中沒有定義的擴展。內核是自給自足的C環境，不依賴於標準C庫的支持，所以
 並不支持C標準中的部分定義。比如long long類型的大數除法和浮點運算就不允許
 使用。有時候確實很難弄清楚內核對工具鏈的要求和它所使用的擴展，不幸的是目
-前還沒有明確的參考資料可以解釋它們。請查閱gcc信息頁（使用「info gcc」命令
+前還沒有明確的參考資料可以解釋它們。請查閱gcc信息頁（使用“info gcc”命令
 顯示）獲得一些這方面信息。
 
 請記住你是在學習怎麼和已經存在的開發社區打交道。它由一羣形形色色的人組成，
-他們對代碼、風格和過程有著很高的標準。這些標準是在長期實踐中總結出來的，
+他們對代碼、風格和過程有着很高的標準。這些標準是在長期實踐中總結出來的，
 適應於地理上分散的大型開發團隊。它們已經被很好得整理成檔，建議你在開發
 之前儘可能多的學習這些標準，而不要期望別人來適應你或者你公司的行爲方式。
 
@@ -64,21 +64,21 @@ Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C11標準，但
 法律問題
 --------
 
-Linux內核原始碼都是在GPL（通用公共許可證）的保護下發布的。要了解這種許可
-的細節請查看原始碼主目錄下的COPYING文件。Linux內核許可準則和如何使用
+Linux內核源代碼都是在GPL（通用公共許可證）的保護下發布的。要了解這種許可
+的細節請查看源代碼主目錄下的COPYING文件。Linux內核許可準則和如何使用
 `SPDX <https://spdx.org/>` 標誌符說明在這個文件中
 :ref:`Documentation/translations/zh_TW/process/license-rules.rst <tw_kernel_licensing>`
 如果你對它還有更深入問題請聯繫律師，而不要在Linux內核郵件組上提問。因爲
-郵件組裡的人並不是律師，不要期望他們的話有法律效力。
+郵件組裏的人並不是律師，不要期望他們的話有法律效力。
 
-對於GPL的常見問題和解答，請訪問以下連結：
+對於GPL的常見問題和解答，請訪問以下鏈接：
 	https://www.gnu.org/licenses/gpl-faq.html
 
 
 文檔
 ----
 
-Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與內核社區互動有著
+Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與內核社區互動有着
 不可估量的價值。當一個新的功能被加入內核，最好把解釋如何使用這個功能的文
 檔也放進內核。當內核的改動導致面向用戶空間的接口發生變化時，最好將相關信
 息或手冊頁(manpages)的補丁發到mtk.manpages@gmail.com，以向手冊頁(manpages)
@@ -86,16 +86,16 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
 
 以下是內核代碼中需要閱讀的文檔：
   :ref:`Documentation/admin-guide/README.rst <readme>`
-    文件簡要介紹了Linux內核的背景，並且描述了如何配置和編譯內核。內核的
-    新用戶應該從這裡開始。
+    文件簡要介紹了Linux內核的背景，並且描述瞭如何配置和編譯內核。內核的
+    新用戶應該從這裏開始。
 
 
   :ref:`Documentation/process/changes.rst <changes>`
-    文件給出了用來編譯和使用內核所需要的最小軟體包列表。
+    文件給出了用來編譯和使用內核所需要的最小軟件包列表。
 
   :ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`
     描述Linux內核的代碼風格和理由。所有新代碼需要遵守這篇文檔中定義的規
-    范。大多數維護者只會接收符合規定的補丁，很多人也只會幫忙檢查符合風格
+    範。大多數維護者只會接收符合規定的補丁，很多人也只會幫忙檢查符合風格
     的代碼。
 
   :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
@@ -106,7 +106,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
        - 選擇收件人
 
     遵守這些規定並不能保證提交成功（因爲所有補丁需要通過嚴格的內容和風格
-    審查），但是忽視他們幾乎就意味著失敗。
+    審查），但是忽視他們幾乎就意味着失敗。
 
     其他關於如何正確地生成補丁的優秀文檔包括：
     "The Perfect Patch"
@@ -122,10 +122,10 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
     性：
 
        - 子系統中間層（爲了兼容性？）
-       - 在不同作業系統間易於移植的驅動程序
+       - 在不同操作系統間易於移植的驅動程序
        - 減緩（甚至阻止）內核代碼的快速變化
 
-    這篇文檔對於理解Linux的開發哲學至關重要。對於將開發平台從其他操作系
+    這篇文檔對於理解Linux的開發哲學至關重要。對於將開發平臺從其他操作系
     統轉移到Linux的人來說也很重要。
 
   :ref:`Documentation/process/security-bugs.rst <securitybugs>`
@@ -139,7 +139,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
     普遍誤解與迷惑。
 
   :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
-    解釋了穩定版內核發布的規則，以及如何將改動放入這些版本的步驟。
+    解釋了穩定版內核發佈的規則，以及如何將改動放入這些版本的步驟。
 
   :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
     有助於內核開發的外部文檔列表。如果你在內核自帶的文檔中沒有找到你想找
@@ -163,7 +163,7 @@ ReST格式的文檔會生成在 Documentation/output. 目錄中。
 
 如何成爲內核開發者
 ------------------
-如果你對Linux內核開發一無所知，你應該訪問「Linux內核新手」計劃：
+如果你對Linux內核開發一無所知，你應該訪問“Linux內核新手”計劃：
 
 	https://kernelnewbies.org
 
@@ -171,12 +171,12 @@ ReST格式的文檔會生成在 Documentation/output. 目錄中。
 查找已往的郵件，確認是否有人已經回答過相同的問題）。它還擁有一個可以獲得
 實時反饋的IRC聊天頻道，以及大量對於學習Linux內核開發相當有幫助的文檔。
 
-網站簡要介紹了原始碼組織結構、子系統劃分以及目前正在進行的項目（包括內核
+網站簡要介紹了源代碼組織結構、子系統劃分以及目前正在進行的項目（包括內核
 中的和單獨維護的）。它還提供了一些基本的幫助信息，比如如何編譯內核和打補
 丁。
 
-如果你想加入內核開發社區並協助完成一些任務，卻找不到從哪裡開始，可以訪問
-「Linux內核房管員」計劃：
+如果你想加入內核開發社區並協助完成一些任務，卻找不到從哪裏開始，可以訪問
+“Linux內核房管員”計劃：
 
 	https://kernelnewbies.org/KernelJanitors
 
@@ -186,9 +186,9 @@ ReST格式的文檔會生成在 Documentation/output. 目錄中。
 向性的指點。
 
 在真正動手修改內核代碼之前，理解要修改的代碼如何運作是必需的。要達到這個
-目的，沒什麼辦法比直接讀代碼更有效了（大多數花招都會有相應的注釋），而且
-一些特製的工具還可以提供幫助。例如，「Linux代碼交叉引用」項目就是一個值得
-特別推薦的幫助工具，它將原始碼顯示在有編目和索引的網頁上。其中一個更新及
+目的，沒什麼辦法比直接讀代碼更有效了（大多數花招都會有相應的註釋），而且
+一些特製的工具還可以提供幫助。例如，“Linux代碼交叉引用”項目就是一個值得
+特別推薦的幫助工具，它將源代碼顯示在有編目和索引的網頁上。其中一個更新及
 時的內核源碼庫，可以通過以下地址訪問：
 
         https://elixir.bootlin.com/
@@ -197,7 +197,7 @@ ReST格式的文檔會生成在 Documentation/output. 目錄中。
 開發流程
 --------
 
-目前Linux內核開發流程包括幾個「主內核分支」和很多子系統相關的內核分支。這
+目前Linux內核開發流程包括幾個“主內核分支”和很多子系統相關的內核分支。這
 些分支包括：
 
   - Linus 的內核源碼樹
@@ -211,40 +211,40 @@ ReST格式的文檔會生成在 Documentation/output. 目錄中。
 主線樹是由Linus Torvalds 維護的。你可以在https://kernel.org 網站或者代碼
 庫中下找到它。它的開發遵循以下步驟：
 
-  - 每當一個新版本的內核被發布，爲期兩周的集成窗口將被打開。在這段時間裡
+  - 每當一個新版本的內核被髮布，爲期兩週的集成窗口將被打開。在這段時間裏
     維護者可以向Linus提交大段的修改，通常這些修改已經被放到-mm內核中幾個
     星期了。提交大量修改的首選方式是使用git工具（內核的代碼版本管理工具
     ，更多的信息可以在 https://git-scm.com/ 獲取），不過使用普通補丁也是
     可以的。
-  - 兩個星期以後-rc1版本內核發布。之後只有不包含可能影響整個內核穩定性的
-    新功能的補丁才可能被接受。請注意一個全新的驅動程序（或者文件系統）有
+  - 兩個星期以後-rc1版本內核發佈。之後只有不包含可能影響整個內核穩定性的
+    新功能的補丁纔可能被接受。請注意一個全新的驅動程序（或者文件系統）有
     可能在-rc1後被接受是因爲這樣的修改完全獨立，不會影響其他的代碼，所以
     沒有造成內核退步的風險。在-rc1以後也可以用git向Linus提交補丁，不過所
-    有的補丁需要同時被發送到相應的公衆郵件列表以徵詢意見。
-  - 當Linus認爲當前的git源碼樹已經達到一個合理健全的狀態足以發布供人測試
-    時，一個新的-rc版本就會被發布。計劃是每周都發布新的-rc版本。
+    有的補丁需要同時被髮送到相應的公衆郵件列表以徵詢意見。
+  - 當Linus認爲當前的git源碼樹已經達到一個合理健全的狀態足以發佈供人測試
+    時，一個新的-rc版本就會被髮布。計劃是每週都發布新的-rc版本。
   - 這個過程一直持續下去直到內核被認爲達到足夠穩定的狀態，持續時間大概是
     6個星期。
 
-關於內核發布，值得一提的是Andrew Morton在linux-kernel郵件列表中如是說：
-	「沒有人知道新內核何時會被發布，因爲發布是根據已知bug的情況來決定
-	的，而不是根據一個事先制定好的時間表。」
+關於內核發佈，值得一提的是Andrew Morton在linux-kernel郵件列表中如是說：
+	“沒有人知道新內核何時會被髮布，因爲發佈是根據已知bug的情況來決定
+	的，而不是根據一個事先制定好的時間表。”
 
 子系統特定樹
 ------------
 
-各種內核子系統的維護者——以及許多內核子系統開發人員——在原始碼庫中公開了他們
+各種內核子系統的維護者——以及許多內核子系統開發人員——在源代碼庫中公開了他們
 當前的開發狀態。這樣，其他人就可以看到內核的不同區域發生了什麼。在開發速度
 很快的領域，可能會要求開發人員將提交的內容建立在這樣的子系統內核樹上，這樣
 就避免了提交與其他已經進行的工作之間的衝突。
 
-這些存儲庫中的大多數都是Git樹，但是也有其他的scm在使用，或者補丁隊列被發布
+這些存儲庫中的大多數都是Git樹，但是也有其他的scm在使用，或者補丁隊列被髮布
 爲Quilt系列。這些子系統存儲庫的地址列在MAINTAINERS文件中。其中許多可以在
 https://git.kernel.org/上瀏覽。
 
 在將一個建議的補丁提交到這樣的子系統樹之前，需要對它進行審查，審查主要發生
 在郵件列表上（請參見下面相應的部分）。對於幾個內核子系統，這個審查過程是通
-過工具補丁跟蹤的。Patchwork提供了一個Web界面，顯示補丁發布、對補丁的任何評
+過工具補丁跟蹤的。Patchwork提供了一個Web界面，顯示補丁發佈、對補丁的任何評
 論或修訂，維護人員可以將補丁標記爲正在審查、接受或拒絕。大多數補丁網站都列
 在 https://patchwork.kernel.org/
 
@@ -254,10 +254,10 @@ Linux-next 集成測試樹
 在將子系統樹的更新合併到主線樹之前，需要對它們進行集成測試。爲此，存在一個
 特殊的測試存儲庫，其中幾乎每天都會提取所有子系統樹：
 
-        https://git.kernel.org/？p=linux/kernel/git/next/linux-next.git
+        https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
 
 通過這種方式，Linux-next 對下一個合併階段將進入主線內核的內容給出了一個概要
-展望。非常歡冒險的測試者運行測試Linux-next。
+展望。非常歡迎冒險的測試者運行測試Linux-next。
 
 多個主要版本的穩定版內核樹
 -----------------------------------
@@ -267,11 +267,11 @@ Linux-next 集成測試樹
 這種版本的內核適用於那些期望獲得最新的穩定版內核並且不想參與測試開發版或
 者實驗版的用戶。
 
-穩定版內核樹版本由「穩定版」小組（郵件地址<stable@vger.kernel.org>）維護，一般
-隔周發布新版本。
+穩定版內核樹版本由“穩定版”小組（郵件地址<stable@vger.kernel.org>）維護，一般
+隔週發佈新版本。
 
 內核源碼中的 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
-文件具體描述了可被穩定版內核接受的修改類型以及發布的流程。
+文件具體描述了可被穩定版內核接受的修改類型以及發佈的流程。
 
 
 報告bug
@@ -283,7 +283,7 @@ bugzilla.kernel.org是Linux內核開發者們用來跟蹤內核Bug的網站。
 	http://test.kernel.org/bugzilla/faq.html
 
 內核源碼主目錄中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
-文件里有一個很好的模板。它指導用戶如何報告可能的內核bug以及需要提供哪些信息
+文件裏有一個很好的模板。它指導用戶如何報告可能的內核bug以及需要提供哪些信息
 來幫助內核開發者們找到問題的根源。
 
 
@@ -302,11 +302,11 @@ bugzilla.kernel.org是Linux內核開發者們用來跟蹤內核Bug的網站。
 --------
 
 正如上面的文檔所描述，大多數的骨幹內核開發者都加入了Linux Kernel郵件列
-表。如何訂閱和退訂列表的細節可以在這裡找到：
+表。如何訂閱和退訂列表的細節可以在這裏找到：
 
 	http://vger.kernel.org/vger-lists.html#linux-kernel
 
-網上很多地方都有這個郵件列表的存檔(archive)。可以使用搜尋引擎來找到這些
+網上很多地方都有這個郵件列表的存檔(archive)。可以使用搜索引擎來找到這些
 存檔。比如：
 
 	https://lore.kernel.org/lkml/
@@ -317,11 +317,11 @@ bugzilla.kernel.org是Linux內核開發者們用來跟蹤內核Bug的網站。
 大多數內核子系統也有自己獨立的郵件列表來協調各自的開發工作。從
 MAINTAINERS文件中可以找到不同話題對應的郵件列表。
 
-很多郵件列表架設在kernel.org伺服器上。這些列表的信息可以在這裡找到：
+很多郵件列表架設在kernel.org服務器上。這些列表的信息可以在這裏找到：
 
 	http://vger.kernel.org/vger-lists.html
 
-在使用這些郵件列表時，請記住保持良好的行爲習慣。下面的連結提供了與這些列
+在使用這些郵件列表時，請記住保持良好的行爲習慣。下面的鏈接提供了與這些列
 表（或任何其它郵件列表）交流的一些簡單規則，雖然內容有點濫竽充數。
 
 	http://www.albion.com/netiquette/
@@ -331,14 +331,14 @@ MAINTAINERS文件中可以找到不同話題對應的郵件列表。
 一封郵件接收兩次（一封來自發送者一封來自郵件列表），而不要試圖通過添加一
 些奇特的郵件頭來解決這個問題，人們不會喜歡的。
 
-記住保留你所回復內容的上下文和源頭。在你回覆郵件的頂部保留「某某某說到……」
+記住保留你所回覆內容的上下文和源頭。在你回覆郵件的頂部保留“某某某說到……”
 這幾行。將你的評論加在被引用的段落之間而不要放在郵件的頂部。
 
 如果你在郵件中附帶補丁，請確認它們是可以直接閱讀的純文本（如
 :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 文檔中所述）。內核開發者們不希望遇到附件或者被壓縮了的補丁。只有這樣才能
 保證他們可以直接評論你的每行代碼。請確保你使用的郵件發送程序不會修改空格
-和制表符。一個防範性的測試方法是先將郵件發送給自己，然後自己嘗試是否可以
+和製表符。一個防範性的測試方法是先將郵件發送給自己，然後自己嘗試是否可以
 順利地打上收到的補丁。如果測試不成功，請調整或者更換你的郵件發送程序直到
 它正確工作爲止。
 
@@ -359,7 +359,7 @@ MAINTAINERS文件中可以找到不同話題對應的郵件列表。
 
 要記住，這些是把補丁放進內核的正常情況。你必須學會聽取對補丁的批評和評論，
 從技術層面評估它們，然後要麼重寫你的補丁要麼簡明扼要地論證修改是不必要
-的。如果你發的郵件沒有得到任何回應，請過幾天後再試一次，因爲有時信件會湮
+的。如果你發的郵件沒有得到任何回應，請過幾天后再試一次，因爲有時信件會湮
 沒在茫茫信海中。
 
 你不應該做的事情：
@@ -369,13 +369,13 @@ MAINTAINERS文件中可以找到不同話題對應的郵件列表。
   - 忽略別人的評論
   - 沒有按照別人的要求做任何修改就重新提交
 
-在一個努力追尋最好技術方案的社區里，對於一個補丁有多少好處總會有不同的見
-解。你必須要抱著合作的態度，願意改變自己的觀點來適應內核的風格。或者至少
-願意去證明你的想法是有價值的。記住，犯錯誤是允許的，只要你願意朝著正確的
+在一個努力追尋最好技術方案的社區裏，對於一個補丁有多少好處總會有不同的見
+解。你必須要抱着合作的態度，願意改變自己的觀點來適應內核的風格。或者至少
+願意去證明你的想法是有價值的。記住，犯錯誤是允許的，只要你願意朝着正確的
 方案去努力。
 
 如果你的第一個補丁換來的是一堆修改建議，這是很正常的。這並不代表你的補丁
-不會被接受，也不意味著有人和你作對。你只需要改正所有提出的問題然後重新發
+不會被接受，也不意味着有人和你作對。你只需要改正所有提出的問題然後重新發
 送你的補丁。
 
 內核社區和公司文化的差異
@@ -383,7 +383,7 @@ MAINTAINERS文件中可以找到不同話題對應的郵件列表。
 
 內核社區的工作模式同大多數傳統公司開發隊伍的工作模式並不相同。下面這些例
 子，可以幫助你避免某些可能發生問題：
-用這些話介紹你的修改提案會有好處：
+用這些話介紹你的修改提案會有好處：（在任何時候你都不應該用中文寫提案）
 
     - 它同時解決了多個問題
     - 它刪除了2000行代碼
@@ -398,15 +398,15 @@ MAINTAINERS文件中可以找到不同話題對應的郵件列表。
     - 我做這行已經20年了，所以……
     - 爲了我們公司賺錢考慮必須這麼做
     - 這是我們的企業產品線所需要的
-    - 這裡是描述我觀點的1000頁設計文檔
+    - 這裏是描述我觀點的1000頁設計文檔
     - 這是一個5000行的補丁用來……
     - 我重寫了現在亂七八糟的代碼，這就是……
     - 我被規定了最後期限，所以這個補丁需要立刻被接受
 
-另外一個內核社區與大部分傳統公司的軟體開發隊伍不同的地方是無法面對面地交
+另外一個內核社區與大部分傳統公司的軟件開發隊伍不同的地方是無法面對面地交
 流。使用電子郵件和IRC聊天工具做爲主要溝通工具的一個好處是性別和種族歧視
 將會更少。Linux內核的工作環境更能接受婦女和少數族羣，因爲每個人在別人眼
-里只是一個郵件地址。國際化也幫助了公平的實現，因爲你無法通過姓名來判斷人
+裏只是一個郵件地址。國際化也幫助了公平的實現，因爲你無法通過姓名來判斷人
 的性別。男人有可能叫李麗，女人也有可能叫王剛。大多數在Linux內核上工作過
 並表達過看法的女性對在linux上工作的經歷都給出了正面的評價。
 
@@ -437,10 +437,10 @@ Linux內核社區並不喜歡一下接收大段的代碼。修改需要被恰當
 2）不光發送小的補丁很重要，在提交之前重新編排、化簡（或者僅僅重新排列）
    補丁也是很重要的。
 
-這裡有內核開發者Al Viro打的一個比方：
-	「想像一個老師正在給學生批改數學作業。老師並不希望看到學生爲了得
+這裏有內核開發者Al Viro打的一個比方：
+	“想象一個老師正在給學生批改數學作業。老師並不希望看到學生爲了得
 	到正確解法所進行的嘗試和產生的錯誤。他希望看到的是最乾淨最優雅的
-	解答。好學生了解這點，絕不會把最終解決之前的中間方案提交上去。」
+	解答。好學生了解這點，絕不會把最終解決之前的中間方案提交上去。”
 
 	內核開發也是這樣。維護者和評審者不希望看到一個人在解決問題時的思
 	考過程。他們只希望看到簡單和優雅的解決方案。
@@ -450,20 +450,20 @@ Linux內核社區並不喜歡一下接收大段的代碼。修改需要被恰當
 保證修改分成很多小塊，這樣在整個項目都準備好被包含進內核之前，其中的一部
 分可能會先被接收。
 
-必須了解這樣做是不可接受的：試圖將未完成的工作提交進內核，然後再找時間修
-復。
+你必須明白這麼做是無法令人接受的：試圖將不完整的代碼提交進內核，然後再找
+時間修復。
 
 
 證明修改的必要性
 ----------------
-除了將補丁拆成小塊，很重要的一點是讓Linux社區了解他們爲什麼需要這樣修改。
+除了將補丁拆成小塊，很重要的一點是讓Linux社區瞭解他們爲什麼需要這樣修改。
 你必須證明新功能是有人需要的並且是有用的。
 
 
 記錄修改
 --------
 
-當你發送補丁的時候，需要特別留意郵件正文的內容。因爲這裡的信息將會做爲補
+當你發送補丁的時候，需要特別留意郵件正文的內容。因爲這裏的信息將會做爲補
 丁的修改記錄(ChangeLog)，會被一直保留以備大家查閱。它需要完全地描述補丁，
 包括：
 
@@ -472,19 +472,19 @@ Linux內核社區並不喜歡一下接收大段的代碼。修改需要被恰當
   - 實現細節
   - 測試結果
 
-想了解它具體應該看起來像什麼，請查閱以下文檔中的「ChangeLog」章節：
-  「The Perfect Patch」
+想了解它具體應該看起來像什麼，請查閱以下文檔中的“ChangeLog”章節：
+  “The Perfect Patch”
   	 https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 
-這些事情有時候做起來很難。要在任何方面都做到完美可能需要好幾年時間。這是
-一個持續提高的過程，它需要大量的耐心和決心。只要不放棄，你一定可以做到。
+這些事情有時候做起來很難。想要在任何方面都做到完美可能需要好幾年時間。這
+是一個持續提高的過程，它需要大量的耐心和決心。只要不放棄，你一定可以做到。
 很多人已經做到了，而他們都曾經和現在的你站在同樣的起點上。
 
 
 感謝
 ----
-感謝Paolo Ciarrocchi允許「開發流程」部分基於他所寫的文章
+感謝Paolo Ciarrocchi允許“開發流程”部分基於他所寫的文章
 (http://www.kerneltravel.net/newbie/2.6-development_process)，感謝Randy
 Dunlap和Gerrit Huizenga完善了應該說和不該說的列表。感謝Pat Mochel, Hanna
 Linder, Randy Dunlap, Kay Sievers, Vojtech Pavlik, Jan Kara, Josh Boyer,
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documentation/translations/zh_TW/process/index.rst
index d742642dab01..6a0d98b2f9ee 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -13,11 +13,12 @@
 
 .. _tw_process_index:
 
+========================
 與Linux 內核社區一起工作
 ========================
 
 你想成爲Linux內核開發人員嗎？歡迎之至！在學習許多關於內核的技術知識的同時，
-了解我們社區的工作方式也很重要。閱讀這些文檔可以讓您以更輕鬆的、麻煩更少的
+瞭解我們社區的工作方式也很重要。閱讀這些文檔可以讓您以更輕鬆的、麻煩更少的
 方式將更改合併到內核。
 
 以下是每位開發人員都應閱讀的基本指南：
@@ -49,7 +50,7 @@
    management-style
    embargoed-hardware-issues
 
-這些是一些總體性技術指南，由於不大好分類而放在這裡：
+這些是一些總體性技術指南，由於不大好分類而放在這裏：
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
index 963ecece3db1..847fce637e67 100644
--- a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
@@ -1,12 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _zh_process_statement_driver:
+.. _tw_process_statement_driver:
 
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/kernel-driver-statement.rst <process_statement_driver>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
 
 內核驅動聲明
 ------------
diff --git a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
index 2861f4a15721..7cd9f4d0a554 100644
--- a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. _tw_process_statement_kernel:
 
@@ -11,11 +11,11 @@
 Linux 內核執行聲明
 ------------------
 
-作爲Linux內核的開發人員，我們對如何使用我們的軟體以及如何實施軟體許可證有著
-濃厚的興趣。遵守GPL-2.0的互惠共享義務對我們軟體和社區的長期可持續性至關重要。
+作爲Linux內核的開發人員，我們對如何使用我們的軟件以及如何實施軟件許可證有着
+濃厚的興趣。遵守GPL-2.0的互惠共享義務對我們軟件和社區的長期可持續性至關重要。
 
 雖然有權強制執行對我們社區的貢獻中的單獨版權權益，但我們有共同的利益，即確保
-個人強制執行行動的方式有利於我們的社區，不會對我們軟體生態系統的健康和增長
+個人強制執行行動的方式有利於我們的社區，不會對我們軟件生態系統的健康和增長
 產生意外的負面影響。爲了阻止無益的執法行動，我們同意代表我們自己和我們版權
 利益的任何繼承人對Linux內核用戶作出以下符合我們開發社區最大利益的承諾:
 
@@ -32,9 +32,9 @@ Linux 內核執行聲明
         從該版權所有者處收到違反本許可的通知（對於任何作品），並且您在收到通知
         後的30天內糾正違規行爲。則您從特定版權所有者處獲得的許可將永久恢復.
 
-我們提供這些保證的目的是鼓勵更多地使用該軟體。我們希望公司和個人使用、修改和
-分發此軟體。我們希望以公開和透明的方式與用戶合作，以消除我們對法規遵從性或強制
-執行的任何不確定性，這些不確定性可能會限制我們軟體的採用。我們將法律行動視爲
+我們提供這些保證的目的是鼓勵更多地使用該軟件。我們希望公司和個人使用、修改和
+分發此軟件。我們希望以公開和透明的方式與用戶合作，以消除我們對法規遵從性或強制
+執行的任何不確定性，這些不確定性可能會限制我們軟件的採用。我們將法律行動視爲
 最後手段，只有在其他社區努力未能解決這一問題時才採取行動。
 
 最後，一旦一個不合規問題得到解決，我們希望用戶會感到歡迎，加入我們爲之努力的
diff --git a/Documentation/translations/zh_TW/process/license-rules.rst b/Documentation/translations/zh_TW/process/license-rules.rst
index 503b6701bde4..2c43bcf2ac79 100644
--- a/Documentation/translations/zh_TW/process/license-rules.rst
+++ b/Documentation/translations/zh_TW/process/license-rules.rst
@@ -1,7 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. SPDX-License-Identifier: GPL-2.0
-
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/license-rules.rst <kernel_licensing>`
@@ -17,10 +15,10 @@ Linux內核根據LICENSES/preferred/GPL-2.0中提供的GNU通用公共許可證
 （GPL-2.0）的條款提供，並在LICENSES/exceptions/Linux-syscall-note中顯式
 描述了例外的系統調用，如COPYING文件中所述。
 
-此文檔文件提供了如何對每個源文件進行注釋以使其許可證清晰明確的說明。
+此文檔文件提供瞭如何對每個源文件進行註釋以使其許可證清晰明確的說明。
 它不會取代內核的許可證。
 
-內核原始碼作爲一個整體適用於COPYING文件中描述的許可證，但是單個源文件可以
+內核源代碼作爲一個整體適用於COPYING文件中描述的許可證，但是單個源文件可以
 具有不同的與GPL-20兼容的許可證::
 
     GPL-1.0+ : GNU通用公共許可證v1.0或更高版本
@@ -34,18 +32,18 @@ Linux內核根據LICENSES/preferred/GPL-2.0中提供的GNU通用公共許可證
 MIT等許可。
 
 用戶空間API（UAPI）頭文件描述了用戶空間程序與內核的接口，這是一種特殊情況。
-根據內核COPYING文件中的注釋，syscall接口是一個明確的邊界，它不會將GPL要求
-擴展到任何使用它與內核通信的軟體。由於UAPI頭文件必須包含在創建在Linux內核
+根據內核COPYING文件中的註釋，syscall接口是一個明確的邊界，它不會將GPL要求
+擴展到任何使用它與內核通信的軟件。由於UAPI頭文件必須包含在創建在Linux內核
 上運行的可執行文件的任何源文件中，因此此例外必須記錄在特別的許可證表述中。
 
-表達源文件許可證的常用方法是將匹配的樣板文本添加到文件的頂部注釋中。由於
-格式，拼寫錯誤等，這些「樣板」很難通過那些在上下文中使用的驗證許可證合規性
+表達源文件許可證的常用方法是將匹配的樣板文本添加到文件的頂部註釋中。由於
+格式，拼寫錯誤等，這些“樣板”很難通過那些在上下文中使用的驗證許可證合規性
 的工具。
 
-樣板文本的替代方法是在每個源文件中使用軟體包數據交換（SPDX）許可證標識符。
+樣板文本的替代方法是在每個源文件中使用軟件包數據交換（SPDX）許可證標識符。
 SPDX許可證標識符是機器可解析的，並且是用於提供文件內容的許可證的精確縮寫。
 SPDX許可證標識符由Linux 基金會的SPDX 工作組管理，並得到了整個行業，工具
-供應商和法律團隊的合作夥伴的一致同意。有關詳細信息，請參閱
+供應商和法律團隊的合作伙伴的一致同意。有關詳細信息，請參閱
 https://spdx.org/
 
 Linux內核需要所有源文件中的精確SPDX標識符。內核中使用的有效標識符在
@@ -58,7 +56,7 @@ https://spdx.org/licenses/ 上的官方SPDX許可證列表中檢索，並附帶
 
 1.安置:
 
-   內核文件中的SPDX許可證標識符應添加到可包含注釋的文件中的第一行。對於大多
+   內核文件中的SPDX許可證標識符應添加到可包含註釋的文件中的第一行。對於大多
    數文件，這是第一行，除了那些在第一行中需要'#!PATH_TO_INTERPRETER'的腳本。
    對於這些腳本，SPDX標識符進入第二行。
 
@@ -66,7 +64,7 @@ https://spdx.org/licenses/ 上的官方SPDX許可證列表中檢索，並附帶
 
 2. 風格:
 
-   SPDX許可證標識符以注釋的形式添加。注釋樣式取決於文件類型::
+   SPDX許可證標識符以註釋的形式添加。註釋樣式取決於文件類型::
 
       C source:	// SPDX-License-Identifier: <SPDX License Expression>
       C header:	/* SPDX-License-Identifier: <SPDX License Expression> */
@@ -75,20 +73,20 @@ https://spdx.org/licenses/ 上的官方SPDX許可證列表中檢索，並附帶
       .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
       .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>
 
-   如果特定工具無法處理標準注釋樣式，則應使用工具接受的相應注釋機制。這是在
-   C 頭文件中使用「/\*\*/」樣式注釋的原因。過去在使用生成的.lds文件中觀察到
-   構建被破壞，其中'ld'無法解析C++注釋。現在已經解決了這個問題，但仍然有較
-   舊的彙編程序工具無法處理C++樣式的注釋。
+   如果特定工具無法處理標準註釋樣式，則應使用工具接受的相應註釋機制。這是在
+   C 頭文件中使用“/\*\*/”樣式註釋的原因。過去在使用生成的.lds文件中觀察到
+   構建被破壞，其中'ld'無法解析C++註釋。現在已經解決了這個問題，但仍然有較
+   舊的彙編程序工具無法處理C++樣式的註釋。
 
 |
 
 3. 句法:
 
    <SPDX許可證表達式>是SPDX許可證列表中的SPDX短格式許可證標識符，或者在許可
-   證例外適用時由「WITH」分隔的兩個SPDX短格式許可證標識符的組合。當應用多個許
-   可證時，表達式由分隔子表達式的關鍵字「AND」，「OR」組成，並由「（」，「）」包圍。
+   證例外適用時由“WITH”分隔的兩個SPDX短格式許可證標識符的組合。當應用多個許
+   可證時，表達式由分隔子表達式的關鍵字“AND”，“OR”組成，並由“（”，“）”包圍。
 
-   帶有「或更高」選項的[L]GPL等許可證的許可證標識符通過使用「+」來表示「或更高」
+   帶有“或更高”選項的[L]GPL等許可證的許可證標識符通過使用“+”來表示“或更高”
    選項來構建。::
 
       // SPDX-License-Identifier: GPL-2.0+
@@ -230,7 +228,7 @@ https://spdx.org/licenses/ 上的官方SPDX許可證列表中檢索，並附帶
 
    元標籤:
 
-   「其他」許可證的元標籤要求與 `優先許可`_ 的要求相同。
+   “其他”許可證的元標籤要求與 `優先許可`_ 的要求相同。
 
    文件格式示例::
 
@@ -267,8 +265,8 @@ https://spdx.org/licenses/ 上的官方SPDX許可證列表中檢索，並附帶
 
       LICENSES/exceptions/GCC-exception-2.0
 
-   包含GCC'連結例外'，它允許獨立於其許可證的任何二進位文件與標記有此例外的
-   文件的編譯版本連結。這是從GPL不兼容原始碼創建可運行的可執行文件所必需的。
+   包含GCC'鏈接例外'，它允許獨立於其許可證的任何二進制文件與標記有此例外的
+   文件的編譯版本鏈接。這是從GPL不兼容源代碼創建可運行的可執行文件所必需的。
 
    _`例外元標記`:
 
@@ -333,11 +331,11 @@ https://spdx.org/licenses/ 上的官方SPDX許可證列表中檢索，並附帶
 _`模塊許可`
 -----------------
 
-   可加載內核模塊還需要MODULE_LICENSE（）標記。此標記既不替代正確的原始碼
+   可加載內核模塊還需要MODULE_LICENSE（）標記。此標記既不替代正確的源代碼
    許可證信息（SPDX-License-Identifier），也不以任何方式表示或確定提供模塊
-   原始碼的確切許可證。
+   源代碼的確切許可證。
 
-   此標記的唯一目的是提供足夠的信息，該模塊是否是自由軟體或者是內核模塊加
+   此標記的唯一目的是提供足夠的信息，該模塊是否是自由軟件或者是內核模塊加
    載器和用戶空間工具的專有模塊。
 
    MODULE_LICENSE（）的有效許可證字符串是:
@@ -365,9 +363,9 @@ _`模塊許可`
                                   只能通過相應的源文件中的許可證信息來確定。
 
     "Proprietary"		  該模塊屬於專有許可。此字符串僅用於專有的第三
-                                  方模塊，不能用於在內核樹中具有原始碼的模塊。
-                                  以這種方式標記的模塊在加載時會使用'P'標記汙
-                                  染內核，並且內核模塊加載器拒絕將這些模塊連結
+                                  方模塊，不能用於在內核樹中具有源代碼的模塊。
+                                  以這種方式標記的模塊在加載時會使用'P'標記污
+                                  染內核，並且內核模塊加載器拒絕將這些模塊鏈接
                                   到使用EXPORT_SYMBOL_GPL（）導出的符號。
     ============================= =============================================
 
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
index 5657d5cd18d4..5ad17a69a406 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -74,3 +74,4 @@ QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/scsi/a
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/scsi/arm/queue.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mips/include/asm/sn/nmi.h``
 ===================== ================ ======================== ==========================================
+
diff --git a/Documentation/translations/zh_TW/process/management-style.rst b/Documentation/translations/zh_TW/process/management-style.rst
index e9d29024f4c9..f3913e3c159d 100644
--- a/Documentation/translations/zh_TW/process/management-style.rst
+++ b/Documentation/translations/zh_TW/process/management-style.rst
@@ -16,20 +16,20 @@ Linux內核管理風格
 主要是爲了避免反覆回答 [#cnf1]_ 相同（或類似）的問題。
 
 管理風格是非常個人化的，比簡單的編碼風格規則更難以量化，因此本文檔可能與實
-際情況有關，也可能與實際情況無關。起初它是一個玩笑，但這並不意味著它可能不
+際情況有關，也可能與實際情況無關。起初它是一個玩笑，但這並不意味着它可能不
 是真的。你得自己決定。
 
-順便說一句，在談到「核心管理者」時，主要是技術負責人，而不是在公司內部進行傳
-統管理的人。如果你簽署了採購訂單或者對你的團隊的預算有任何了解，你幾乎肯定
+順便說一句，在談到“核心管理者”時，主要是技術負責人，而不是在公司內部進行傳
+統管理的人。如果你簽署了採購訂單或者對你的團隊的預算有任何瞭解，你幾乎肯定
 不是一個核心管理者。這些建議可能適用於您，也可能不適用於您。
 
-首先，我建議你購買「高效人的七個習慣」，而不是閱讀它。燒了它，這是一個偉大的
+首先，我建議你購買“高效人的七個習慣”，而不是閱讀它。燒了它，這是一個偉大的
 象徵性姿態。
 
 .. [#cnf1] 本文件並不是通過回答問題，而是通過讓提問者痛苦地明白，我們不知道
    答案是什麼。
 
-不管怎樣，這裡是：
+不管怎樣，這裏是：
 
 .. _tw_decisions:
 
@@ -39,14 +39,14 @@ Linux內核管理風格
 每個人都認爲管理者做決定，而且決策很重要。決定越大越痛苦，管理者就必須越高級。
 這很明顯，但事實並非如此。
 
-遊戲的名字是 **避免** 做出決定。尤其是，如果有人告訴你「選擇（a）或（b），
-我們真的需要你來做決定」，你就是陷入麻煩的管理者。你管理的人比你更了解細節，
+最重要的是 **避免** 做出決定。尤其是，如果有人告訴你“選擇（a）或（b），
+我們真的需要你來做決定”，你就是陷入麻煩的管理者。你管理的人比你更瞭解細節，
 所以如果他們來找你做技術決策，你完蛋了。你顯然沒有能力爲他們做這個決定。
 
-（推論：如果你管理的人不比你更了解細節，你也會被搞砸，儘管原因完全不同。
+（推論：如果你管理的人不比你更瞭解細節，你也會被搞砸，儘管原因完全不同。
 也就是說，你的工作是錯的，他們應該管理你的才智）
 
-所以遊戲的名字是 **避免** 做出決定，至少是那些大而痛苦的決定。做一些小的
+所以最重要的是 **避免** 做出決定，至少是那些大而痛苦的決定。做一些小的
 和非結果性的決定是很好的，並且使您看起來好像知道自己在做什麼，所以內核管理者
 需要做的是將那些大的和痛苦的決定變成那些沒有人真正關心的小事情。
 
@@ -61,7 +61,7 @@ Linux內核管理風格
 逃離的角落。走投無路的老鼠可能很危險——走投無路的管理者真可憐。
 
 事實證明，由於沒有人會愚蠢到讓內核管理者承擔巨大的財政責任，所以通常很容易
-回溯。既然你不可能浪費掉你無法償還的巨額資金，你唯一可以回溯的就是技術決策，
+回溯。既然你不可能浪費掉你無法償還的鉅額資金，你唯一可以回溯的就是技術決策，
 而回溯很容易：只要告訴大家你是個不稱職的傻瓜，說對不起，然後撤銷你去年讓別
 人所做的毫無價值的工作。突然間，你一年前做的決定不在是一個重大的決定，因爲
 它很容易被推翻。
@@ -72,7 +72,7 @@ Linux內核管理風格
    確實很難。
  - 如果有人告訴你，你去年所做的工作終究是不值得的，那麼對那些可憐的低級工
    程師來說也是很困難的，雖然實際的 **工作** 很容易刪除，但你可能已經不可
-   挽回地失去了工程師的信任。記住：「不可撤銷」是我們一開始就試圖避免的，
+   挽回地失去了工程師的信任。記住：“不可撤銷”是我們一開始就試圖避免的，
    而你的決定終究是一個重大的決定。
 
 令人欣慰的是，這兩個原因都可以通過預先承認你沒有任何線索，提前告訴人們你的
@@ -80,19 +80,19 @@ Linux內核管理風格
 的權利，並讓人們 **意識** 到這一點。當你 **還沒有** 做過真正愚蠢的事情的時
 候，承認自己是愚蠢的要容易得多。
 
-然後，當它真的被證明是愚蠢的時候，人們就轉動他們的眼珠說「哎呀，下次不要了」。
+然後，當它真的被證明是愚蠢的時候，人們就轉動他們的眼珠說“哎呀，下次不要了”。
 
 這種對不稱職的先發制人的承認，也可能使真正做這項工作的人也會三思是否值得做。
 畢竟，如果他們不確定這是否是一個好主意，你肯定不應該通過向他們保證他們所做
 的工作將會進入（內核）鼓勵他們。在他們開始一項巨大的努力之前，至少讓他們三
 思而後行。
 
-記住：他們最好比你更了解細節，而且他們通常認爲他們對每件事都有答案。作爲一
+記住：他們最好比你更瞭解細節，而且他們通常認爲他們對每件事都有答案。作爲一
 個管理者，你能做的最好的事情不是灌輸自信，而是對他們所做的事情進行健康的批
 判性思考。
 
-順便說一句，另一種避免做出決定的方法是看起來很可憐的抱怨 「我們不能兩者兼
-得嗎？」 相信我，它是有效的。如果不清楚哪種方法更好，他們最終會弄清楚的。
+順便說一句，另一種避免做出決定的方法是看起來很可憐的抱怨 “我們不能兩者兼
+得嗎？” 相信我，它是有效的。如果不清楚哪種方法更好，他們最終會弄清楚的。
 最終的答案可能是兩個團隊都會因爲這種情況而感到沮喪，以至於他們放棄了。
 
 這聽起來像是一個失敗，但這通常是一個跡象，表明兩個項目都有問題，而參與其中
@@ -102,7 +102,7 @@ Linux內核管理風格
 2）人
 -----
 
-大多數人都是白癡，做一名管理者意味著你必須處理好這件事，也許更重要的是,
+大多數人都是白癡，做一名管理者意味着你必須處理好這件事，也許更重要的是,
 **他們** 必須處理好你。
 
 事實證明，雖然很容易糾正技術錯誤，但不容易糾正人格障礙。你只能和他們的和
@@ -110,16 +110,16 @@ Linux內核管理風格
 
 但是，爲了做好作爲內核管理者的準備，最好記住不要燒掉任何橋樑，不要轟炸任何
 無辜的村民，也不要疏遠太多的內核開發人員。事實證明，疏遠人是相當容易的，而
-親近一個疏遠的人是很難的。因此，「疏遠」立即屬於「不可逆」的範疇，並根據
+親近一個疏遠的人是很難的。因此，“疏遠”立即屬於“不可逆”的範疇，並根據
 :ref:`tw_decisions` 成爲絕不可以做的事情。
 
-這裡只有幾個簡單的規則：
+這裏只有幾個簡單的規則：
 
  (1) 不要叫人笨蛋（至少不要在公共場合）
  (2) 學習如何在忘記規則(1)時道歉
 
-問題在於 #1 很容易去做，因爲你可以用數百萬種不同的方式說「你是一個笨蛋」 [#cnf2]_
-有時甚至沒有意識到，而且幾乎總是帶著一種白熱化的信念，認爲你是對的。
+問題在於 #1 很容易去做，因爲你可以用數百萬種不同的方式說“你是一個笨蛋” [#cnf2]_
+有時甚至沒有意識到，而且幾乎總是帶着一種白熱化的信念，認爲你是對的。
 
 你越確信自己是對的（讓我們面對現實吧，你可以把幾乎所有人都稱爲壞人，而且你
 經常是對的），事後道歉就越難。
@@ -127,12 +127,12 @@ Linux內核管理風格
 要解決此問題，您實際上只有兩個選項：
 
  - 非常擅長道歉
- - 把「愛」均勻地散開，沒有人會真正感覺到自己被不公平地瞄準了。讓它有足夠的
+ - 把“愛”均勻地散開，沒有人會真正感覺到自己被不公平地瞄準了。讓它有足夠的
    創造性，他們甚至可能會覺得好笑。
 
 選擇永遠保持禮貌是不存在的。沒有人會相信一個如此明顯地隱藏了他們真實性格的人。
 
-.. [#cnf2] 保羅·西蒙演唱了「離開愛人的50種方法」，因爲坦率地說，「告訴開發者
+.. [#cnf2] 保羅·西蒙演唱了“離開愛人的50種方法”，因爲坦率地說，“告訴開發者
    他們是D*CKHEAD" 的100萬種方法都無法確認。但我確信他已經這麼想了。
 
 3）人2 - 好人
@@ -148,8 +148,8 @@ Linux內核管理風格
 特別是，他們能夠爲你做決定，這就是遊戲的全部內容。
 
 所以當你發現一個比你聰明的人時，就順其自然吧。你的管理職責在很大程度上變成
-了「聽起來像是個好主意——去嘗試吧」，或者「聽起來不錯，但是XXX呢？」「。第二個版
-本尤其是一個很好的方法，要麼學習一些關於「XXX」的新東西，要麼通過指出一些聰明
+了“聽起來像是個好主意——去嘗試吧”，或者“聽起來不錯，但是XXX呢？”“。第二個版
+本尤其是一個很好的方法，要麼學習一些關於“XXX”的新東西，要麼通過指出一些聰明
 人沒有想到的東西來顯得更具管理性。無論哪種情況，你都會贏。
 
 要注意的一件事是認識到一個領域的偉大不一定會轉化爲其他領域。所以你可能會向
@@ -172,22 +172,22 @@ Linux內核管理風格
 他們也可能是能夠解決問題的人。因爲，讓我們面對現實吧，肯定不是你。
 
 承擔責任也是你首先成爲管理者的原因。這是讓人們信任你，讓你獲得潛在的榮耀的
-一部分，因爲你就是那個會說「我搞砸了」的人。如果你已經遵循了以前的規則，你現
+一部分，因爲你就是那個會說“我搞砸了”的人。如果你已經遵循了以前的規則，你現
 在已經很擅長說了。
 
 5）應避免的事情
 ---------------
 
-有一件事人們甚至比被稱爲「笨蛋」更討厭，那就是在一個神聖的聲音中被稱爲「笨蛋」。
+有一件事人們甚至比被稱爲“笨蛋”更討厭，那就是在一個神聖的聲音中被稱爲“笨蛋”。
 第一個你可以道歉，第二個你不會真正得到機會。即使你做得很好，他們也可能不再
 傾聽。
 
-我們都認爲自己比別人強，這意味著當別人裝腔作勢時，這會讓我們很惱火。你也許
+我們都認爲自己比別人強，這意味着當別人裝腔作勢時，這會讓我們很惱火。你也許
 在道德和智力上比你周圍的每個人都優越，但不要試圖太明顯，除非你真的打算激怒
 某人 [#cnf3]_
 
 同樣，不要對事情太客氣或太微妙。禮貌很容易落得落花流水，把問題隱藏起來，
-正如他們所說，「在網際網路上，沒人能聽到你的含蓄。」用一個鈍器把這一點錘進去，
+正如他們所說，“在互聯網上，沒人能聽到你的含蓄。”用一個鈍器把這一點錘進去，
 因爲你不能真的依靠別人來獲得你的觀點。
 
 一些幽默可以幫助緩和直率和道德化。過度到荒謬的地步，可以灌輸一個觀點，而不
@@ -203,8 +203,8 @@ Linux內核管理風格
 既然你的主要責任似乎是爲別人的錯誤承擔責任，並且讓別人痛苦地明白你是不稱職
 的，那麼顯而易見的問題之一就變成了爲什麼首先要這樣做。
 
-首先，雖然你可能會或可能不會聽到十幾歲女孩（或男孩，讓我們不要在這裡評判或
-性別歧視）敲你的更衣室門，你會得到一個巨大的個人成就感爲「負責」。別介意你真
+首先，雖然你可能會或可能不會聽到十幾歲女孩（或男孩，讓我們不要在這裏評判或
+性別歧視）敲你的更衣室門，你會得到一個巨大的個人成就感爲“負責”。別介意你真
 的在領導別人，你要跟上別人，儘可能快地追趕他們。每個人都會認爲你是負責人。
 
 如果你可以做到這個， 這是個偉大的工作！
diff --git a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
index 33fc85c2cc51..6839d25bb22a 100644
--- a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
@@ -17,45 +17,45 @@
 Linux 內核驅動接口
 ==================
 
-寫作本文檔的目的，是爲了解釋爲什麼Linux既沒有二進位內核接口，也沒有穩定
-的內核接口。這裡所說的內核接口，是指內核里的接口，而不是內核和用戶空間
-的接口。內核到用戶空間的接口，是提供給應用程式使用的系統調用，系統調用
-在歷史上幾乎沒有過變化，將來也不會有變化。我有一些老應用程式是在0.9版本
-或者更早版本的內核上編譯的，在使用2.6版本內核的Linux發布上依然用得很好
-。用戶和應用程式作者可以將這個接口看成是穩定的。
+寫作本文檔的目的，是爲了解釋爲什麼Linux既沒有二進制內核接口，也沒有穩定
+的內核接口。這裏所說的內核接口，是指內核裏的接口，而不是內核和用戶空間
+的接口。內核到用戶空間的接口，是提供給應用程序使用的系統調用，系統調用
+在歷史上幾乎沒有過變化，將來也不會有變化。我有一些老應用程序是在0.9版本
+或者更早版本的內核上編譯的，在使用2.6版本內核的Linux發佈上依然用得很好
+。用戶和應用程序作者可以將這個接口看成是穩定的。
 
 
 執行綱要
 --------
 
 你也許以爲自己想要穩定的內核接口，但是你不清楚你要的實際上不是它。你需
-要的其實是穩定的驅動程序，而你只有將驅動程序放到公版內核的原始碼樹里，
-才有可能達到這個目的。而且這樣做還有很多其它好處，正是因爲這些好處使得
-Linux能成爲強壯，穩定，成熟的作業系統，這也是你最開始選擇Linux的原因。
+要的其實是穩定的驅動程序，而你只有將驅動程序放到公版內核的源代碼樹裏，
+纔有可能達到這個目的。而且這樣做還有很多其它好處，正是因爲這些好處使得
+Linux能成爲強壯，穩定，成熟的操作系統，這也是你最開始選擇Linux的原因。
 
 
 入門
 -----
 
-只有那些寫驅動程序的「怪人」才會擔心內核接口的改變，對廣大用戶來說，既
+只有那些寫驅動程序的“怪人”纔會擔心內核接口的改變，對廣大用戶來說，既
 看不到內核接口，也不需要去關心它。
 
 首先，我不打算討論關於任何非GPL許可的內核驅動的法律問題，這些非GPL許可
-的驅動程序包括不公開原始碼，隱藏原始碼，二進位或者是用原始碼包裝，或者
-是其它任何形式的不能以GPL許可公開原始碼的驅動程序。如果有法律問題，請咨
-詢律師，我只是一個程式設計師，所以我只打算探討技術問題（不是小看法律問題，
+的驅動程序包括不公開源代碼，隱藏源代碼，二進制或者是用源代碼包裝，或者
+是其它任何形式的不能以GPL許可公開源代碼的驅動程序。如果有法律問題，請諮
+詢律師，我只是一個程序員，所以我只打算探討技術問題（不是小看法律問題，
 法律問題很實際，並且需要一直關注）。
 
-既然只談技術問題，我們就有了下面兩個主題：二進位內核接口和穩定的內核源
-代碼接口。這兩個問題是互相關聯的，讓我們先解決掉二進位接口的問題。
+既然只談技術問題，我們就有了下面兩個主題：二進制內核接口和穩定的內核源
+代碼接口。這兩個問題是互相關聯的，讓我們先解決掉二進制接口的問題。
 
 
-二進位內核接口
+二進制內核接口
 --------------
-假如我們有一個穩定的內核原始碼接口，那麼自然而然的，我們就擁有了穩定的
-二進位接口，是這樣的嗎？錯。讓我們看看關於Linux內核的幾點事實：
+假如我們有一個穩定的內核源代碼接口，那麼自然而然的，我們就擁有了穩定的
+二進制接口，是這樣的嗎？錯。讓我們看看關於Linux內核的幾點事實：
 
-    - 取決於所用的C編譯器的版本，不同的內核數據結構里的結構體的對齊方
+    - 取決於所用的C編譯器的版本，不同的內核數據結構裏的結構體的對齊方
       式會有差別，代碼中不同函數的表現形式也不一樣（函數是不是被inline
       編譯取決於編譯器行爲）。不同的函數的表現形式並不重要，但是數據
       結構內部的對齊方式很關鍵。
@@ -69,33 +69,33 @@ Linux能成爲強壯，穩定，成熟的作業系統，這也是你最開始選
         項。
 
     - Linux可以在很多的不同體系結構的處理器上運行。在某個體系結構上編
-      譯好的二進位驅動程序，不可能在另外一個體系結構上正確的運行。
+      譯好的二進制驅動程序，不可能在另外一個體繫結構上正確的運行。
 
 對於一個特定的內核，滿足這些條件並不難，使用同一個C編譯器和同樣的內核配
-置選項來編譯驅動程序模塊就可以了。這對於給一個特定Linux發布的特定版本提
-供驅動程序，是完全可以滿足需求的。但是如果你要給不同發布的不同版本都發
-布一個驅動程序，就需要在每個發布上用不同的內核設置參數都編譯一次內核，
-這簡直跟噩夢一樣。而且還要注意到，每個Linux發布還提供不同的Linux內核，
-這些內核都針對不同的硬體類型進行了優化（有很多種不同的處理器，還有不同
-的內核設置選項）。所以每發布一次驅動程序，都需要提供很多不同版本的內核
+置選項來編譯驅動程序模塊就可以了。這對於給一個特定Linux發佈的特定版本提
+供驅動程序，是完全可以滿足需求的。但是如果你要給不同發佈的不同版本都發
+佈一個驅動程序，就需要在每個發佈上用不同的內核設置參數都編譯一次內核，
+這簡直跟噩夢一樣。而且還要注意到，每個Linux發佈還提供不同的Linux內核，
+這些內核都針對不同的硬件類型進行了優化（有很多種不同的處理器，還有不同
+的內核設置選項）。所以每發佈一次驅動程序，都需要提供很多不同版本的內核
 模塊。
 
-相信我，如果你真的要採取這種發布方式，一定會慢慢瘋掉，我很久以前就有過
+相信我，如果你真的要採取這種發佈方式，一定會慢慢瘋掉，我很久以前就有過
 深刻的教訓...
 
 
-穩定的內核原始碼接口
+穩定的內核源代碼接口
 --------------------
 
-如果有人不將他的內核驅動程序，放入公版內核的原始碼樹，而又想讓驅動程序
+如果有人不將他的內核驅動程序，放入公版內核的源代碼樹，而又想讓驅動程序
 一直保持在最新的內核中可用，那麼這個話題將會變得沒完沒了。
 內核開發是持續而且快節奏的，從來都不會慢下來。內核開發人員在當前接口中
 找到bug，或者找到更好的實現方式。一旦發現這些，他們就很快會去修改當前的
-接口。修改接口意味著，函數名可能會改變，結構體可能被擴充或者刪減，函數
+接口。修改接口意味着，函數名可能會改變，結構體可能被擴充或者刪減，函數
 的參數也可能發生改變。一旦接口被修改，內核中使用這些接口的地方需要同時
 修正，這樣才能保證所有的東西繼續工作。
 
-舉一個例子，內核的USB驅動程序接口在USB子系統的整個生命周期中，至少經歷
+舉一個例子，內核的USB驅動程序接口在USB子系統的整個生命週期中，至少經歷
 了三次重寫。這些重寫解決以下問題：
 
     - 把數據流從同步模式改成非同步模式，這個改動減少了一些驅動程序的
@@ -104,11 +104,11 @@ Linux能成爲強壯，穩定，成熟的作業系統，這也是你最開始選
     - 修改了USB核心代碼中爲USB驅動分配數據包內存的方式，所有的驅動都
       需要提供更多的參數給USB核心，以修正了很多已經被記錄在案的死鎖。
 
-這和一些封閉原始碼的作業系統形成鮮明的對比，在那些作業系統上，不得不額
+這和一些封閉源代碼的操作系統形成鮮明的對比，在那些操作系統上，不得不額
 外的維護舊的USB接口。這導致了一個可能性，新的開發者依然會不小心使用舊的
-接口，以不恰當的方式編寫代碼，進而影響到作業系統的穩定性。
+接口，以不恰當的方式編寫代碼，進而影響到操作系統的穩定性。
 在上面的例子中，所有的開發者都同意這些重要的改動，在這樣的情況下修改代
-價很低。如果Linux保持一個穩定的內核原始碼接口，那麼就得創建一個新的接口
+價很低。如果Linux保持一個穩定的內核源代碼接口，那麼就得創建一個新的接口
 ；舊的，有問題的接口必須一直維護，給Linux USB開發者帶來額外的工作。既然
 所有的Linux USB驅動的作者都是利用自己的時間工作，那麼要求他們去做毫無意
 義的免費額外工作，是不可能的。
@@ -126,28 +126,28 @@ Linux能成爲強壯，穩定，成熟的作業系統，這也是你最開始選
 要做什麼
 --------
 
-如果你寫了一個Linux內核驅動，但是它還不在Linux原始碼樹里，作爲一個開發
-者，你應該怎麼做？爲每個發布的每個版本提供一個二進位驅動，那簡直是一個
+如果你寫了一個Linux內核驅動，但是它還不在Linux源代碼樹裏，作爲一個開發
+者，你應該怎麼做？爲每個發佈的每個版本提供一個二進制驅動，那簡直是一個
 噩夢，要跟上永遠處於變化之中的內核接口，也是一件辛苦活。
-很簡單，讓你的驅動進入內核原始碼樹（要記得我們在談論的是以GPL許可發行
+很簡單，讓你的驅動進入內核源代碼樹（要記得我們在談論的是以GPL許可發行
 的驅動，如果你的代碼不符合GPL，那麼祝你好運，你只能自己解決這個問題了，
-你這個吸血鬼<把Andrew和Linus對吸血鬼的定義連結到這裡>）。當你的代碼加入
-公版內核原始碼樹之後，如果一個內核接口改變，你的驅動會直接被修改接口的
+你這個吸血鬼<把Andrew和Linus對吸血鬼的定義鏈接到這裏>）。當你的代碼加入
+公版內核源代碼樹之後，如果一個內核接口改變，你的驅動會直接被修改接口的
 那個人修改。保證你的驅動永遠都可以編譯通過，並且一直工作，你幾乎不需要
 做什麼事情。
 
-把驅動放到內核原始碼樹里會有很多的好處：
+把驅動放到內核源代碼樹裏會有很多的好處：
 
     - 驅動的質量會提升，而維護成本（對原始作者來說）會下降。
     - 其他人會給驅動添加新特性。
     - 其他人會找到驅動中的bug並修復。
     - 其他人會在驅動中找到性能優化的機會。
     - 當外部的接口的改變需要修改驅動程序的時候，其他人會修改驅動程序
-    - 不需要聯繫任何發行商，這個驅動會自動的隨著所有的Linux發布一起發
+    - 不需要聯繫任何發行商，這個驅動會自動的隨着所有的Linux發佈一起發
       布。
 
-和別的作業系統相比，Linux爲更多不同的設備提供現成的驅動，而且能在更多不
-同體系結構的處理器上支持這些設備。這個經過考驗的開發模式，必然是錯不了
+和別的操作系統相比，Linux爲更多不同的設備提供現成的驅動，而且能在更多不
+同體繫結構的處理器上支持這些設備。這個經過考驗的開發模式，必然是錯不了
 的 :)
 
 感謝
diff --git a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
index 29d9a70a1868..41c78166f1a6 100644
--- a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
@@ -17,10 +17,10 @@
             - Kangkai Yin <e12051@motorola.com>
             - 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
-所有你想知道的事情 - 關於linux穩定版發布
+所有你想知道的事情 - 關於linux穩定版發佈
 ========================================
 
-關於Linux 2.6穩定版發布，所有你想知道的事情。
+關於Linux 2.6穩定版發佈，所有你想知道的事情。
 
 關於哪些類型的補丁可以被接收進入穩定版代碼樹，哪些不可以的規則：
 ----------------------------------------------------------------
@@ -28,39 +28,39 @@
   - 必須是顯而易見的正確，並且經過測試的。
   - 連同上下文，不能大於100行。
   - 必須只修正一件事情。
-  - 必須修正了一個給大家帶來麻煩的真正的bug（不是「這也許是一個問題...」
+  - 必須修正了一個給大家帶來麻煩的真正的bug（不是“這也許是一個問題...”
     那樣的東西）。
   - 必須修正帶來如下後果的問題：編譯錯誤（對被標記爲CONFIG_BROKEN的例外），
-    內核崩潰，掛起，數據損壞，真正的安全問題，或者一些類似「哦，這不
-    好」的問題。簡短的說，就是一些致命的問題。
-  - 沒有「理論上的競爭條件」，除非能給出競爭條件如何被利用的解釋。
-  - 不能存在任何的「瑣碎的」修正（拼寫修正，去掉多餘空格之類的）。
+    內核崩潰，掛起，數據損壞，真正的安全問題，或者一些類似“哦，這不
+    好”的問題。簡短的說，就是一些致命的問題。
+  - 沒有“理論上的競爭條件”，除非能給出競爭條件如何被利用的解釋。
+  - 不能存在任何的“瑣碎的”修正（拼寫修正，去掉多餘空格之類的）。
   - 必須被相關子系統的維護者接受。
-  - 必須遵循Documentation/translations/zh_TW/process/submitting-patches.rst里的規則。
+  - 必須遵循Documentation/translations/zh_TW/process/submitting-patches.rst裏的規則。
 
 向穩定版代碼樹提交補丁的過程：
 ------------------------------
 
   - 在確認了補丁符合以上的規則後，將補丁發送到stable@vger.kernel.org。
-  - 如果補丁被接受到隊列里，發送者會收到一個ACK回復，如果沒有被接受，收
-    到的是NAK回復。回復需要幾天的時間，這取決於開發者的時間安排。
-  - 被接受的補丁會被加到穩定版本隊列里，等待其他開發者的審查。
+  - 如果補丁被接受到隊列裏，發送者會收到一個ACK回覆，如果沒有被接受，收
+    到的是NAK回覆。回覆需要幾天的時間，這取決於開發者的時間安排。
+  - 被接受的補丁會被加到穩定版本隊列裏，等待其他開發者的審查。
   - 安全方面的補丁不要發到這個列表，應該發送到security@kernel.org。
 
-審查周期：
+審查週期：
 ----------
 
-  - 當穩定版的維護者決定開始一個審查周期，補丁將被發送到審查委員會，以
+  - 當穩定版的維護者決定開始一個審查週期，補丁將被髮送到審查委員會，以
     及被補丁影響的領域的維護者（除非提交者就是該領域的維護者）並且抄送
     到linux-kernel郵件列表。
-  - 審查委員會有48小時的時間，用來決定給該補丁回復ACK還是NAK。
+  - 審查委員會有48小時的時間，用來決定給該補丁回覆ACK還是NAK。
   - 如果委員會中有成員拒絕這個補丁，或者linux-kernel列表上有人反對這個
     補丁，並提出維護者和審查委員會之前沒有意識到的問題，補丁會從隊列中
     丟棄。
-  - 在審查周期結束的時候，那些得到ACK回應的補丁將會被加入到最新的穩定版
-    發布中，一個新的穩定版發布就此產生。
-  - 安全性補丁將從內核安全小組那裡直接接收到穩定版代碼樹中，而不是通過
-    通常的審查周期。請聯繫內核安全小組以獲得關於這個過程的更多細節。
+  - 在審查週期結束的時候，那些得到ACK回應的補丁將會被加入到最新的穩定版
+    發佈中，一個新的穩定版發佈就此產生。
+  - 安全性補丁將從內核安全小組那裏直接接收到穩定版代碼樹中，而不是通過
+    通常的審查週期。請聯繫內核安全小組以獲得關於這個過程的更多細節。
 
 審查委員會：
 ------------
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index 12bf6f5ca5c6..00924da85e2b 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -2,108 +2,114 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
-:Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+:Original: Documentation/process/submit-checklist.rst
+:Translator:
+ - Alex Shi <alexs@kernel.org>
+ - Wu XiangCheng <bobwxc@email.cn>
+ - Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_submitchecklist:
 
-Linux內核補丁提交清單
-~~~~~~~~~~~~~~~~~~~~~
+Linux內核補丁提交檢查單
+~~~~~~~~~~~~~~~~~~~~~~~
 
 如果開發人員希望看到他們的內核補丁提交更快地被接受，那麼他們應該做一些基本
 的事情。
 
-這些都是在
-:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
+這些都是在 Documentation/translations/zh_TW/process/submitting-patches.rst
 和其他有關提交Linux內核補丁的文檔中提供的。
 
-1) 如果使用工具，則包括定義/聲明該工具的文件。不要依賴於其他頭文件拉入您使用
+1) 如果使用工具，則包括定義/聲明該工具的文件。不要依賴其他頭文件來引入您使用
    的頭文件。
 
 2) 乾淨的編譯：
 
-   a) 使用適用或修改的 ``CONFIG`` 選項 ``=y``、``=m`` 和 ``=n`` 。沒有GCC
-      警告/錯誤，沒有連結器警告/錯誤。
+   a) 使用合適的 ``CONFIG`` 選項 ``=y``、``=m`` 和 ``=n`` 。沒有 ``gcc``
+      警告/錯誤，沒有鏈接器警告/錯誤。
 
-   b) 通過allnoconfig、allmodconfig
+   b) 通過 ``allnoconfig`` 、 ``allmodconfig``
 
    c) 使用 ``O=builddir`` 時可以成功編譯
 
-3) 通過使用本地交叉編譯工具或其他一些構建場在多個CPU體系結構上構建。
+   d) 任何 Doucmentation/ 下的變更都能成功構建且不引入新警告/錯誤。
+      用 ``make htmldocs`` 或 ``make pdfdocs`` 檢驗構建情況並修復問題。
+
+3) 通過使用本地交叉編譯工具或其他一些構建設施在多個CPU體系結構上構建。
 
 4) PPC64是一種很好的交叉編譯檢查體系結構，因爲它傾向於對64位的數使用無符號
    長整型。
 
-5) 如下所述 :ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`.
-   檢查您的補丁是否爲常規樣式。在提交（ ``scripts/check patch.pl`` ）之前，
-   使用補丁樣式檢查器檢查是否有輕微的衝突。您應該能夠處理您的補丁中存在的所有
+5) 按 Documentation/translations/zh_TW/process/coding-style.rst 所述檢查您的
+   補丁是否爲常規樣式。在提交之前使用補丁樣式檢查器 ``scripts/checkpatch.pl``
+   檢查是否有輕微的衝突。您應該能夠處理您的補丁中存在的所有
    違規行爲。
 
-6) 任何新的或修改過的 ``CONFIG`` 選項都不會弄髒配置菜單，並默認爲關閉，除非
-   它們符合 ``Documentation/kbuild/kconfig-language.rst`` 中記錄的異常條件,
-   菜單屬性：默認值.
+6) 任何新的或修改過的 ``CONFIG`` 選項都不應搞亂配置菜單，並默認爲關閉，除非
+   它們符合 ``Documentation/kbuild/kconfig-language.rst`` 菜單屬性：默認值中
+   記錄的例外條件。
 
 7) 所有新的 ``kconfig`` 選項都有幫助文本。
 
-8) 已仔細審查了相關的 ``Kconfig`` 組合。這很難用測試來糾正——腦力在這裡是有
+8) 已仔細審查了相關的 ``Kconfig`` 組合。這很難用測試來糾正——腦力在這裏是有
    回報的。
 
-9) 用 sparse 檢查乾淨。
+9) 通過 sparse 清查。
+   （參見 Documentation/translations/zh_TW/dev-tools/sparse.rst ）
 
 10) 使用 ``make checkstack`` 和 ``make namespacecheck`` 並修復他們發現的任何
     問題。
 
     .. note::
 
-        ``checkstack`` 並沒有明確指出問題，但是任何一個在堆棧上使用超過512
+        ``checkstack`` 並不會明確指出問題，但是任何一個在堆棧上使用超過512
         字節的函數都可以進行更改。
 
-11) 包括 :ref:`kernel-doc <kernel_doc>` 內核文檔以記錄全局內核API。（靜態函數
-    不需要，但也可以。）使用 ``make htmldocs`` 或 ``make pdfdocs`` 檢查
-    :ref:`kernel-doc <kernel_doc>` 並修復任何問題。
+11) 包括 :ref:`kernel-doc <kernel_doc_zh>` 內核文檔以記錄全局內核API。（靜態
+    函數不需要，但也可以。）使用 ``make htmldocs`` 或 ``make pdfdocs`` 檢查
+    :ref:`kernel-doc <kernel_doc_zh>` 並修復任何問題。
 
-12) 通過以下選項同時啓用的測試 ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+12) 通過以下選項同時啓用的測試： ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
     ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
     ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
-    ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD``
-
-13) 已經過構建和運行時測試，包括有或沒有 ``CONFIG_SMP``, ``CONFIG_PREEMPT``.
+    ``CONFIG_PROVE_RCU`` 和 ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` 。
 
-14) 如果補丁程序影響IO/磁碟等：使用或不使用 ``CONFIG_LBDAF`` 進行測試。
+13) 在 ``CONFIG_SMP``, ``CONFIG_PREEMPT`` 開啓和關閉的情況下都進行構建和運行
+    時測試。
 
-15) 所有代碼路徑都已在啓用所有lockdep功能的情況下運行。
+14) 所有代碼路徑都已在啓用所有死鎖檢測（lockdep）功能的情況下運行。
 
-16) 所有新的/proc條目都記錄在 ``Documentation/``
+15) 所有新的 ``/proc`` 條目都記錄在 ``Documentation/``
 
-17) 所有新的內核引導參數都記錄在
+16) 所有新的內核引導參數都記錄在
     Documentation/admin-guide/kernel-parameters.rst 中。
 
-18) 所有新的模塊參數都記錄在 ``MODULE_PARM_DESC()``
+17) 所有新的模塊參數都記錄在 ``MODULE_PARM_DESC()``
 
-19) 所有新的用戶空間接口都記錄在 ``Documentation/ABI/`` 中。有關詳細信息，
+18) 所有新的用戶空間接口都記錄在 ``Documentation/ABI/`` 中。有關詳細信息，
     請參閱 ``Documentation/ABI/README`` 。更改用戶空間接口的補丁應該抄送
     linux-api@vger.kernel.org。
 
-20) 已通過至少注入slab和page分配失敗進行檢查。請參閱 ``Documentation/fault-injection/``
+19) 已通過至少注入slab和page分配失敗進行檢查。請參閱 ``Documentation/fault-injection/`` 。
     如果新代碼是實質性的，那麼添加子系統特定的故障注入可能是合適的。
 
-21) 新添加的代碼已經用 ``gcc -W`` 編譯（使用 ``make EXTRA-CFLAGS=-W`` ）。這
-    將產生大量噪聲，但對於查找諸如「警告：有符號和無符號之間的比較」之類的錯誤
+20) 新添加的代碼已經用 ``gcc -W`` 編譯（使用 ``make EXTRA-CFLAGS=-W`` ）。這
+    將產生大量噪聲，但對於查找諸如“警告：有符號和無符號之間的比較”之類的錯誤
     很有用。
 
-22) 在它被合併到-mm補丁集中之後進行測試，以確保它仍然與所有其他排隊的補丁以
+21) 在它被合併到-mm補丁集中之後進行測試，以確保它仍然與所有其他排隊的補丁以
     及VM、VFS和其他子系統中的各種更改一起工作。
 
-23) 所有內存屏障例如 ``barrier()``, ``rmb()``, ``wmb()`` 都需要原始碼中的注
+22) 所有內存屏障（例如 ``barrier()``, ``rmb()``, ``wmb()`` ）都需要源代碼注
     釋來解釋它們正在執行的操作及其原因的邏輯。
 
-24) 如果補丁添加了任何ioctl，那麼也要更新 ``Documentation/userspace-api/ioctl/ioctl-number.rst``
+23) 如果補丁添加了任何ioctl，那麼也要更新
+    ``Documentation/userspace-api/ioctl/ioctl-number.rst`` 。
 
-25) 如果修改後的原始碼依賴或使用與以下 ``Kconfig`` 符號相關的任何內核API或
+24) 如果修改後的源代碼依賴或使用與以下 ``Kconfig`` 符號相關的任何內核API或
     功能，則在禁用相關 ``Kconfig`` 符號和/或 ``=m`` （如果該選項可用）的情況
     下測試以下多個構建[並非所有這些都同時存在，只是它們的各種/隨機組合]：
 
-    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``, ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
-    ``CONFIG_NET``, ``CONFIG_INET=n`` (但是後者伴隨 ``CONFIG_NET=y``).
+    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``,
+    ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
+    ``CONFIG_NET``, ``CONFIG_INET=n`` （但是最後一個需要 ``CONFIG_NET=y`` ）。
 
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index 0746809c31a2..46bc6734b82b 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -1,229 +1,199 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-.. _tw_submittingpatches:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+.. _tw_submittingpatches:
+
+:Original: Documentation/process/submitting-patches.rst
 
-譯者::
+:譯者:
+ - 鍾宇 TripleX Chung <xxx.phy@gmail.com>
+ - 時奎亮 Alex Shi <alexs@kernel.org>
+ - 吳想成 Wu XiangCheng <bobwxc@email.cn>
 
-        中文版維護者： 鍾宇 TripleX Chung <xxx.phy@gmail.com>
-        中文版翻譯者： 鍾宇 TripleX Chung <xxx.phy@gmail.com>
-                       時奎亮 Alex Shi <alex.shi@linux.alibaba.com>
-        中文版校譯者： 李陽 Li Yang <leoyang.li@nxp.com>
-                       王聰 Wang Cong <xiyou.wangcong@gmail.com>
-                       胡皓文 Hu Haowen <src.res.211@gmail.com>
+:校譯:
+ - 李陽 Li Yang <leoyang.li@nxp.com>
+ - 王聰 Wang Cong <xiyou.wangcong@gmail.com>
+ - 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
-如何讓你的改動進入內核
-======================
+提交補丁：如何讓你的改動進入內核
+================================
 
-對於想要將改動提交到 Linux 內核的個人或者公司來說，如果不熟悉「規矩」，
-提交的流程會讓人畏懼。本文檔收集了一系列建議，這些建議可以大大的提高你
+對於想要將改動提交到 Linux 內核的個人或者公司來說，如果不熟悉“規矩”，
+提交的流程會讓人畏懼。本文檔包含了一系列建議，可以大大提高你
 的改動被接受的機會.
 
-以下文檔含有大量簡潔的建議， 具體請見：
-:ref:`Documentation/process <development_process_main>`
-同樣，:ref:`Documentation/translations/zh_TW/process/submit-checklist.rst <tw_submitchecklist>`
-給出在提交代碼前需要檢查的項目的列表。
+本文檔以較爲簡潔的行文給出了大量建議。關於內核開發流程如何進行的詳細信息，
+參見： Documentation/translations/zh_TW/process/development-process.rst 。
+Documentation/translations/zh_TW/process/submit-checklist.rst 給出了一系列
+提交補丁之前要檢查的事項。設備樹相關的補丁，請參閱
+Documentation/devicetree/bindings/submitting-patches.rst 。
 
-其中許多步驟描述了Git版本控制系統的默認行爲；如果您使用Git來準備補丁，
-您將發現它爲您完成的大部分機械工作，儘管您仍然需要準備和記錄一組合理的
-補丁。一般來說，使用git將使您作爲內核開發人員的生活更輕鬆。
+本文檔假設您正在使用 ``git`` 準備你的補丁。如果您不熟悉 ``git`` ，最好學習
+如何使用它，這將使您作爲內核開發人員的生活變得更加輕鬆。
 
+部分子系統和維護人員的樹有一些關於其工作流程和要求的額外信息，請參閱
+Documentation/process/maintainer-handbooks.rst 。
 
-0) 獲取當前源碼樹
------------------
+獲取當前源碼樹
+--------------
 
-如果您沒有一個可以使用當前內核原始碼的存儲庫，請使用git獲取一個。您將要
-從主線存儲庫開始，它可以通過以下方式獲取::
+如果您手頭沒有當前內核源代碼的存儲庫，請使用 ``git`` 獲取一份。您需要先獲取
+主線存儲庫，它可以通過以下命令拉取::
 
-        git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+    git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 
-但是，請注意，您可能不希望直接針對主線樹進行開發。大多數子系統維護人員運
+但是，請注意，您可能不想直接針對主線樹進行開發。大多數子系統維護人員運
 行自己的樹，並希望看到針對這些樹準備的補丁。請參見MAINTAINERS文件中子系
-統的 **T:** 項以查找該樹，或者簡單地詢問維護者該樹是否未在其中列出。
-
-仍然可以通過tarballs下載內核版本（如下一節所述），但這是進行內核開發的
-一種困難的方式。
-
-1) "diff -up"
--------------
-
-使用 "diff -up" 或者 "diff -uprN" 來創建補丁。
-
-所有內核的改動，都是以補丁的形式呈現的，補丁由 diff(1) 生成。創建補丁的
-時候，要確認它是以 "unified diff" 格式創建的，這種格式由 diff(1) 的 '-u'
-參數生成。而且，請使用 '-p' 參數，那樣會顯示每個改動所在的C函數，使得
-產生的補丁容易讀得多。補丁應該基於內核原始碼樹的根目錄，而不是裡邊的任
-何子目錄。
-
-爲一個單獨的文件創建補丁，一般來說這樣做就夠了::
-
-        SRCTREE=linux
-        MYFILE=drivers/net/mydriver.c
-
-        cd $SRCTREE
-        cp $MYFILE $MYFILE.orig
-        vi $MYFILE      # make your change
-        cd ..
-        diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch
-
-爲多個文件創建補丁，你可以解開一個沒有修改過的內核原始碼樹，然後和你自
-己的代碼樹之間做 diff 。例如::
-
-        MYSRC=/devel/linux
-
-        tar xvfz linux-3.19.tar.gz
-        mv linux-3.19 linux-3.19-vanilla
-        diff -uprN -X linux-3.19-vanilla/Documentation/dontdiff \
-                linux-3.19-vanilla $MYSRC > /tmp/patch
-
-"dontdiff" 是內核在編譯的時候產生的文件的列表，列表中的文件在 diff(1)
-產生的補丁里會被跳過。
-
-確定你的補丁里沒有包含任何不屬於這次補丁提交的額外文件。記得在用diff(1)
-生成補丁之後，審閱一次補丁，以確保準確。
+統的 **T:** 項以查找該樹，或者直接詢問維護者該樹是否未在其中列出。
 
-如果你的改動很散亂，你應該研究一下如何將補丁分割成獨立的部分，將改動分
-割成一系列合乎邏輯的步驟。這樣更容易讓其他內核開發者審核，如果你想你的
-補丁被接受，這是很重要的。請參閱：
-:ref:`tw_split_changes`
+.. _zh_describe_changes:
 
-如果你用 ``git`` , ``git rebase -i`` 可以幫助你這一點。如果你不用 ``git``,
-``quilt`` <https://savannah.nongnu.org/projects/quilt> 另外一個流行的選擇。
-
-.. _tw_describe_changes:
-
-2) 描述你的改動
----------------
+描述你的改動
+------------
 
 描述你的問題。無論您的補丁是一行錯誤修復還是5000行新功能，都必須有一個潛在
-的問題激勵您完成這項工作。讓審稿人相信有一個問題值得解決，讓他們讀完第一段
-是有意義的。
+的問題激勵您完成這項工作。說服審閱者相信有一個問題值得解決，讓他們讀完第一段
+後就能明白這一點。
 
 描述用戶可見的影響。直接崩潰和鎖定是相當有說服力的，但並不是所有的錯誤都那麼
-明目張胆。即使在代碼審查期間發現了這個問題，也要描述一下您認爲它可能對用戶產
+明目張膽。即使在代碼審閱期間發現了這個問題，也要描述一下您認爲它可能對用戶產
 生的影響。請記住，大多數Linux安裝運行的內核來自二級穩定樹或特定於供應商/產品
 的樹，只從上游精選特定的補丁，因此請包含任何可以幫助您將更改定位到下游的內容：
-觸發的場景、DMESG的摘錄、崩潰描述、性能回歸、延遲尖峯、鎖定等。
+觸發的場景、DMESG的摘錄、崩潰描述、性能迴歸、延遲尖峯、鎖定等。
 
-量化優化和權衡。如果您聲稱在性能、內存消耗、堆棧占用空間或二進位大小方面有所
-改進，請包括支持它們的數字。但也要描述不明顯的成本。優化通常不是免費的，而是
-在CPU、內存和可讀性之間進行權衡；或者，探索性的工作，在不同的工作負載之間進
+質量優化和權衡。如果您聲稱在性能、內存消耗、堆棧佔用空間或二進制大小方面有所
+改進，請包括支持它們的數據。但也要描述不明顯的成本。優化通常不是零成本的，而是
+在CPU、內存和可讀性之間進行權衡；或者，做探索性的工作，在不同的工作負載之間進
 行權衡。請描述優化的預期缺點，以便審閱者可以權衡成本和收益。
 
-一旦問題建立起來，就要詳細地描述一下您實際在做什麼。對於審閱者來說，用簡單的
-英語描述代碼的變化是很重要的，以驗證代碼的行爲是否符合您的意願。
+提出問題之後，就要詳細地描述一下您實際在做的技術細節。對於審閱者來說，用簡練的
+英語描述代碼的變化是很重要的，以驗證代碼的行爲是否符合您的意圖。
 
-如果您將補丁描述寫在一個表單中，這個表單可以很容易地作爲「提交日誌」放入Linux
-的原始碼管理系統git中，那麼維護人員將非常感謝您。見 :ref:`tw_explicit_in_reply_to`.
+如果您將補丁描述寫成“標準格式”，可以很容易地作爲“提交日誌”放入Linux的源代
+碼管理系統 ``git`` 中，那麼維護人員將非常感謝您。
+參見 :ref:`zh_the_canonical_patch_format` 。
 
 每個補丁只解決一個問題。如果你的描述開始變長，這就表明你可能需要拆分你的補丁。
-請見 :ref:`tw_split_changes`
+請見 :ref:`zh_split_changes` 。
 
-提交或重新提交修補程序或修補程序系列時，請包括完整的修補程序說明和理由。不要
+提交或重新提交補丁或補丁系列時，請包括完整的補丁說明和理由。不要
 只說這是補丁（系列）的第幾版。不要期望子系統維護人員引用更早的補丁版本或引用
 URL來查找補丁描述並將其放入補丁中。也就是說，補丁（系列）及其描述應該是獨立的。
-這對維護人員和審查人員都有好處。一些評審者可能甚至沒有收到補丁的早期版本。
+這對維護人員和審閱者都有好處。一些審閱者可能甚至沒有收到補丁的早期版本。
 
-描述你在命令語氣中的變化，例如「make xyzzy do frotz」而不是「[這個補丁]make
-xyzzy do frotz」或「[我]changed xyzzy to do frotz」，就好像你在命令代碼庫改變
+用祈使句描述你的變更，例如“make xyzzy do frotz”而不是“[This patch]make
+xyzzy do frotz”或“[I]changed xyzzy to do frotz”，就好像你在命令代碼庫改變
 它的行爲一樣。
 
-如果修補程序修復了一個記錄的bug條目，請按編號和URL引用該bug條目。如果補丁來
-自郵件列表討論，請給出郵件列表存檔的URL；使用帶有 ``Message-ID`` 的
-https://lore.kernel.org/ 重定向，以確保連結不會過時。
-
-但是，在沒有外部資源的情況下，儘量讓你的解釋可理解。除了提供郵件列表存檔或
-bug的URL之外，還要總結需要提交補丁的相關討論要點。
-
-如果您想要引用一個特定的提交，不要只引用提交的 SHA-1 ID。還請包括提交的一行
-摘要，以便於審閱者了解它是關於什麼的。例如::
+如果您想要引用一個特定的提交，不要只引用提交的SHA-1 ID。還請包括提交的一行
+摘要，以便於審閱者瞭解它是關於什麼的。例如::
 
         Commit e21d2170f36602ae2708 ("video: remove unnecessary
         platform_set_drvdata()") removed the unnecessary
         platform_set_drvdata(), but left the variable "dev" unused,
         delete it.
 
-您還應該確保至少使用前12位 SHA-1 ID. 內核存儲庫包含*許多*對象，使與較短的ID
+您還應該確保至少使用前12位SHA-1 ID。內核存儲庫包含 *許多* 對象，使較短的ID
 發生衝突的可能性很大。記住，即使現在不會與您的六個字符ID發生衝突，這種情況
-可能五年後改變。
+也可能在五年後改變。
+
+如果該變更的相關討論或背景信息可以在網上查閱，請加上“Link:”標籤指向它。例如
+你的補丁修復了一個缺陷，需要添加一個帶有URL的標籤指向郵件列表存檔或缺陷跟蹤器
+的相關報告；如果該補丁是由一些早先郵件列表討論或網絡上的記錄引起的，請指向它。
+
+當鏈接到郵件列表存檔時，請首選lore.kernel.org郵件存檔服務。用郵件中的
+``Message-ID`` 頭（去掉尖括號）可以創建鏈接URL。例如::
+
+    Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+
+請檢查該鏈接以確保可用且指向正確的郵件。
 
-如果修補程序修復了特定提交中的錯誤，例如，使用 ``git bisct`` ，請使用帶有前
-12個字符SHA-1 ID 的"Fixes:"標記和單行摘要。爲了簡化不要將標記拆分爲多個，
-行、標記不受分析腳本「75列換行」規則的限制。例如::
+不過，在沒有外部資源的情況下，也要儘量讓你的解釋可理解。除了提供郵件列表存檔或
+缺陷的URL之外，還要需要總結該補丁的相關討論要點。
 
-        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+如果補丁修復了特定提交中的錯誤，例如使用 ``git bisct`` 發現了一個問題，請使用
+帶有前12個字符SHA-1 ID的“Fixes:”標籤和單行摘要。爲了簡化解析腳本，不要將該
+標籤拆分爲多行，標籤不受“75列換行”規則的限制。例如::
 
-下列 ``git config`` 設置可以添加讓 ``git log``, ``git show`` 漂亮的顯示格式::
+  Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+
+下列 ``git config`` 設置可以讓 ``git log``, ``git show`` 增加上述風格的顯示格式::
 
 	[core]
 		abbrev = 12
 	[pretty]
 		fixes = Fixes: %h (\"%s\")
 
-.. _tw_split_changes:
+使用示例::
+
+	$ git log -1 --pretty=fixes 54a4f0239f2e
+	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
-3) 拆分你的改動
----------------
+.. _zh_split_changes:
 
-將每個邏輯更改分隔成一個單獨的補丁。
+拆分你的改動
+------------
 
-例如，如果你的改動里同時有bug修正和性能優化，那麼把這些改動拆分到兩個或
-者更多的補丁文件中。如果你的改動包含對API的修改，並且修改了驅動程序來適
-應這些新的API，那麼把這些修改分成兩個補丁。
+將每個 **邏輯更改** 拆分成一個單獨的補丁。
+
+例如，如果你的改動裏同時有bug修正和性能優化，那麼把這些改動拆分到兩個或
+者更多的補丁文件中。如果你的改動包含對API的修改，並且增加了一個使用該新API
+的驅動，那麼把這些修改分成兩個補丁。
 
 另一方面，如果你將一個單獨的改動做成多個補丁文件，那麼將它們合併成一個
-單獨的補丁文件。這樣一個邏輯上單獨的改動只被包含在一個補丁文件里。
+單獨的補丁文件。這樣一個邏輯上單獨的改動只被包含在一個補丁文件裏。
+
+需要記住的一點是，每個補丁的更改都應易於理解，以便審閱者驗證。每個補丁都應該
+對其價值進行闡述。
 
-如果有一個補丁依賴另外一個補丁來完成它的改動，那沒問題。簡單的在你的補
-丁描述里指出「這個補丁依賴某補丁」就好了。
+如果有一個補丁依賴另外一個補丁來完成它的改動，那沒問題。直接在你的補
+丁描述裏指出 **“這個補丁依賴某補丁”** 就好了。
 
-在將您的更改劃分爲一系列補丁時，要特別注意確保內核在系列中的每個補丁之後
-都能正常構建和運行。使用 ``git bisect`` 來追蹤問題的開發者可能會在任何時
-候分割你的補丁系列；如果你在中間引入錯誤，他們不會感謝你。
+在將您的更改劃分爲一系列補丁時，要特別注意確保內核在應用系列中的每個補丁之後
+都能正常構建和運行。使用 ``git bisect`` 來追蹤問題的開發者可能會在任何地方分
+割你的補丁系列；如果你在中間引入錯誤，他們不會感謝你。
 
-如果你不能將補丁濃縮成更少的文件，那麼每次大約發送出15個，然後等待審查
+如果你不能將補丁系列濃縮得更小，那麼每次大約發送出15個補丁，然後等待審閱
 和集成。
 
-4) 檢查你的更改風格
--------------------
+檢查你的更改風格
+----------------
 
-檢查您的補丁是否存在基本樣式衝突，詳細信息可在
-:ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`
-中找到。如果不這樣做，只會浪費審稿人的時間，並且會導致你的補丁被拒絕，甚至
+檢查您的補丁是否違反了基本樣式規定，詳細信息參見
+Documentation/translations/zh_TW/process/coding-style.rst
+中找到。如果不這樣做，只會浪費審閱者的時間，並且會導致你的補丁被拒絕，甚至
 可能沒有被閱讀。
 
 一個重要的例外是在將代碼從一個文件移動到另一個文件時——在這種情況下，您不應
 該在移動代碼的同一個補丁中修改移動的代碼。這清楚地描述了移動代碼和您的更改
-的行爲。這大大有助於審查實際差異，並允許工具更好地跟蹤代碼本身的歷史。
+的行爲。這大大有助於審閱實際差異，並允許工具更好地跟蹤代碼本身的歷史。
 
 在提交之前，使用補丁樣式檢查程序檢查補丁（scripts/check patch.pl）。不過，
 請注意，樣式檢查程序應該被視爲一個指南，而不是作爲人類判斷的替代品。如果您
-的代碼看起來更好，但有違規行爲，那麼最好不要使用它。
+的代碼看起來更好，但有違規行爲，那麼最好別管它。
 
 檢查者報告三個級別：
 
  - ERROR：很可能出錯的事情
- - WARNING：需要仔細審查的事項
+ - WARNING：需要仔細審閱的事項
  - CHECK：需要思考的事情
 
 您應該能夠判斷您的補丁中存在的所有違規行爲。
 
-5) 選擇補丁收件人
------------------
+選擇補丁收件人
+--------------
 
-您應該總是在任何補丁上複製相應的子系統維護人員，以獲得他們維護的代碼；查看
-維護人員文件和原始碼修訂歷史記錄，以了解這些維護人員是誰。腳本
-scripts/get_Maintainer.pl在這個步驟中非常有用。如果您找不到正在工作的子系統
+您應該總是知會任何補丁相應代碼的子系統維護人員；查看
+維護人員文件和源代碼修訂歷史記錄，以瞭解這些維護人員是誰。腳本
+scripts/get_maintainer.pl在這個步驟中非常有用。如果您找不到正在工作的子系統
 的維護人員，那麼Andrew Morton（akpm@linux-foundation.org）將充當最後的維護
 人員。
 
-您通常還應該選擇至少一個郵件列表來接收補丁集的。linux-kernel@vger.kernel.org
-作爲最後一個解決辦法的列表，但是這個列表上的體積已經引起了許多開發人員的拒絕。
-在MAINTAINERS文件中查找子系統特定的列表；您的補丁可能會在那裡得到更多的關注。
+您通常還應該選擇至少一個郵件列表來接收補丁集的副本。linux-kernel@vger.kernel.org
+是所有補丁的默認列表，但是這個列表的流量已經導致了許多開發人員不再看它。
+在MAINTAINERS文件中查找子系統特定的列表；您的補丁可能會在那裏得到更多的關注。
 不過，請不要發送垃圾郵件到無關的列表。
 
 許多與內核相關的列表託管在vger.kernel.org上；您可以在
@@ -232,188 +202,170 @@ http://vger.kernel.org/vger-lists.html 上找到它們的列表。不過，也
 
 不要一次發送超過15個補丁到vger郵件列表！！！！
 
-Linus Torvalds 是決定改動能否進入 Linux 內核的最終裁決者。他的 e-mail
-地址是 <torvalds@linux-foundation.org> 。他收到的 e-mail 很多，所以一般
-的說，最好別給他發 e-mail。
-
-如果您有修復可利用安全漏洞的補丁，請將該補丁發送到 security@kernel.org。對於
-嚴重的bug，可以考慮短期暫停以允許分銷商向用戶發布補丁；在這種情況下，顯然不應
-將補丁發送到任何公共列表。
+Linus Torvalds是決定改動能否進入 Linux 內核的最終裁決者。他的郵件地址是
+torvalds@linux-foundation.org 。他收到的郵件很多，所以一般來說最好 **別**
+給他發郵件。
 
-修復已發布內核中嚴重錯誤的補丁程序應該指向穩定版維護人員，方法是放這樣的一行::
+如果您有修復可利用安全漏洞的補丁，請將該補丁發送到 security@kernel.org 。對於
+嚴重的bug，可以考慮短期禁令以允許分銷商（有時間）向用戶發佈補丁；在這種情況下，
+顯然不應將補丁發送到任何公共列表。
+參見 Documentation/translations/zh_TW/admin-guide/security-bugs.rst 。
 
-        Cc: stable@vger.kernel.org
+修復已發佈內核中嚴重錯誤的補丁程序應該抄送給穩定版維護人員，方法是把以下列行
+放進補丁的籤準區（注意，不是電子郵件收件人）::
 
-進入補丁的簽准區（注意，不是電子郵件收件人）。除了這個文件之外，您還應該閱讀
-:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+  Cc: stable@vger.kernel.org
 
-但是，請注意，一些子系統維護人員希望得出他們自己的結論，即哪些補丁應該被放到
-穩定的樹上。尤其是網絡維護人員，不希望看到單個開發人員在補丁中添加像上面這樣
-的行。
+除了本文件之外，您還應該閱讀
+Documentation/translations/zh_TW/process/stable-kernel-rules.rst 。
 
-如果更改影響到用戶和內核接口，請向手冊頁維護人員（如維護人員文件中所列）發送
+如果更改影響到用戶側內核接口，請向手冊頁維護人員（如維護人員文件中所列）發送
 手冊頁補丁，或至少發送更改通知，以便一些信息進入手冊頁。還應將用戶空間API
-更改複製到 linux-api@vger.kernel.org。
+更改抄送到 linux-api@vger.kernel.org 。
 
-6) 沒有 MIME 編碼，沒有連結，沒有壓縮，沒有附件，只有純文本
------------------------------------------------------------
+
+不要MIME編碼，不要鏈接，不要壓縮，不要附件，只要純文本
+------------------------------------------------------
 
 Linus 和其他的內核開發者需要閱讀和評論你提交的改動。對於內核開發者來說
-，可以「引用」你的改動很重要，使用一般的 e-mail 工具，他們就可以在你的
+，可以“引用”你的改動很重要，使用一般的郵件工具，他們就可以在你的
 代碼的任何位置添加評論。
 
-因爲這個原因，所有的提交的補丁都是 e-mail 中「內嵌」的。
+因爲這個原因，所有的提交的補丁都是郵件中“內嵌”的。最簡單（和推薦）的方法就
+是使用 ``git send-email`` 。https://git-send-email.io 有 ``git send-email``
+的交互式教程。
+
+如果你選擇不用 ``git send-email`` ：
 
 .. warning::
-   如果你使用剪切-粘貼你的補丁，小心你的編輯器的自動換行功能破壞你的補丁
 
-不要將補丁作爲 MIME 編碼的附件，不管是否壓縮。很多流行的 e-mail 軟體不
-是任何時候都將 MIME 編碼的附件當作純文本發送的，這會使得別人無法在你的
-代碼中加評論。另外，MIME 編碼的附件會讓 Linus 多花一點時間來處理，這就
-降低了你的改動被接受的可能性。
+  如果你使用剪切-粘貼你的補丁，小心你的編輯器的自動換行功能破壞你的補丁
 
-例外：如果你的郵遞員弄壞了補丁，那麼有人可能會要求你使用mime重新發送補丁
+不要將補丁作爲MIME編碼的附件，不管是否壓縮。很多流行的郵件軟件不
+是任何時候都將MIME編碼的附件當作純文本發送的，這會使得別人無法在你的
+代碼中加評論。另外，MIME編碼的附件會讓Linus多花一點時間來處理，這就
+降低了你的改動被接受的可能性。
 
-請參閱 :ref:`Documentation/translations/zh_TW/process/email-clients.rst <tw_email_clients>`
-以獲取有關配置電子郵件客戶端以使其不受影響地發送修補程序的提示。
+例外：如果你的郵路損壞了補丁，那麼有人可能會要求你使用MIME重新發送補丁。
 
-7) e-mail 的大小
-----------------
+請參閱 Documentation/translations/zh_TW/process/email-clients.rst
+以獲取有關配置電子郵件客戶端以使其不受影響地發送補丁的提示。
 
-大的改動對郵件列表不合適，對某些維護者也不合適。如果你的補丁，在不壓縮
-的情況下，超過了300kB，那麼你最好將補丁放在一個能通過 internet 訪問的服
-務器上，然後用指向你的補丁的 URL 替代。但是請注意，如果您的補丁超過了
-300kb，那麼它幾乎肯定需要被破壞。
+回覆審閱意見
+------------
 
-8）回複評審意見
----------------
+你的補丁幾乎肯定會得到審閱者對補丁改進方法的評論（以回覆郵件的形式）。您必須
+對這些評論作出回應；讓補丁被忽略的一個好辦法就是忽略審閱者的意見。直接回復郵
+件來回應意見即可。不會導致代碼更改的意見或問題幾乎肯定會帶來註釋或變更日誌的
+改變，以便下一個審閱者更好地瞭解正在發生的事情。
 
-你的補丁幾乎肯定會得到評審者對補丁改進方法的評論。您必須對這些評論作出
-回應；讓補丁被忽略的一個好辦法就是忽略審閱者的意見。不會導致代碼更改的
-意見或問題幾乎肯定會帶來注釋或變更日誌的改變，以便下一個評審者更好地了解
-正在發生的事情。
+一定要告訴審閱者你在做什麼改變，並感謝他們的時間。代碼審閱是一個累人且耗時的
+過程，審閱者有時會變得暴躁。即使在這種情況下，也要禮貌地回應並解決他們指出的
+問題。當發送下一版時，在封面郵件或獨立補丁里加上 ``patch changelog`` 說明與
+前一版本的不同之處（參見 :ref:`zh_the_canonical_patch_format` ）。
 
-一定要告訴審稿人你在做什麼改變，並感謝他們的時間。代碼審查是一個累人且
-耗時的過程，審查人員有時會變得暴躁。即使在這種情況下，也要禮貌地回應並
-解決他們指出的問題。
+.. _zh_resend_reminders:
 
-9）不要洩氣或不耐煩
--------------------
+不要泄氣或不耐煩
+----------------
 
-提交更改後，請耐心等待。審閱者是忙碌的人，可能無法立即訪問您的修補程序。
+提交更改後，請耐心等待。審閱者是大忙人，可能無法立即審閱您的補丁。
 
-曾幾何時，補丁曾在沒有評論的情況下消失在空白中，但開發過程比現在更加順利。
-您應該在一周左右的時間內收到評論；如果沒有收到評論，請確保您已將補丁發送
-到正確的位置。在重新提交或聯繫審閱者之前至少等待一周-在諸如合併窗口之類的
+曾幾何時，補丁曾在沒收到評論的情況下消失在虛空中，但現在開發過程應該更加順利了。
+您應該在一週左右的時間內收到評論；如果沒有收到評論，請確保您已將補丁發送
+到正確的位置。在重新提交或聯繫審閱者之前至少等待一週——在諸如合併窗口之類的
 繁忙時間可能更長。
 
-10）主題中包含 PATCH
---------------------
+在等了幾個星期後，用帶RESEND的主題重發補丁也是可以的::
 
-由於到linus和linux內核的電子郵件流量很高，通常會在主題行前面加上[PATCH]
-前綴. 這使Linus和其他內核開發人員更容易將補丁與其他電子郵件討論區分開。
+   [PATCH Vx RESEND] sub/sys: Condensed patch summary
 
-11）簽署你的作品-開發者原始認證
--------------------------------
-
-爲了加強對誰做了何事的追蹤，尤其是對那些透過好幾層的維護者的補丁，我們
-建議在發送出去的補丁上加一個 「sign-off」 的過程。
-
-"sign-off" 是在補丁的注釋的最後的簡單的一行文字，認證你編寫了它或者其他
-人有權力將它作爲開放原始碼的補丁傳遞。規則很簡單：如果你能認證如下信息:
-
-開發者來源證書 1.1
-^^^^^^^^^^^^^^^^^^
+當你發佈補丁（系列）修改版的時候，不要加上“RESEND”——“RESEND”只適用於重
+新提交之前未經修改的補丁（系列）。
 
-對於本項目的貢獻，我認證如下信息：
+主題中包含 PATCH
+----------------
 
-      （a）這些貢獻是完全或者部分的由我創建，我有權利以文件中指出
-           的開放原始碼許可證提交它；或者
-      （b）這些貢獻基於以前的工作，據我所知，這些以前的工作受恰當的開放
-           原始碼許可證保護，而且，根據許可證，我有權提交修改後的貢獻，
-           無論是完全還是部分由我創造，這些貢獻都使用同一個開放原始碼許可證
-           （除非我被允許用其它的許可證），正如文件中指出的；或者
-      （c）這些貢獻由認證（a），（b）或者（c）的人直接提供給我，而
-           且我沒有修改它。
-      （d）我理解並同意這個項目和貢獻是公開的，貢獻的記錄（包括我
-           一起提交的個人記錄，包括 sign-off ）被永久維護並且可以和這個項目
-           或者開放原始碼的許可證同步地再發行。
+由於到Linus和linux-kernel的電子郵件流量很高，通常會在主題行前面加上[PATCH]
+前綴。這使Linus和其他內核開發人員更容易將補丁與其他電子郵件討論區分開。
 
-那麼加入這樣一行::
+``git send-email`` 會自動爲你加上。
 
-       Signed-off-by: Random J Developer <random@developer.example.org>
+簽署你的作品——開發者來源認證
+------------------------------
 
-使用你的真名（抱歉，不能使用假名或者匿名。）
+爲了加強對誰做了何事的追蹤，尤其是對那些透過好幾層維護者才最終到達的補丁，我
+們在通過郵件發送的補丁上引入了“簽署（sign-off）”流程。
 
-有人在最後加上標籤。現在這些東西會被忽略，但是你可以這樣做，來標記公司
-內部的過程，或者只是指出關於 sign-off 的一些特殊細節。
+“簽署”是在補丁註釋最後的一行簡單文字，認證你編寫了它或者其他
+人有權力將它作爲開放源代碼的補丁傳遞。規則很簡單：如果你能認證如下信息:
 
-如果您是子系統或分支維護人員，有時需要稍微修改收到的補丁，以便合併它們，
-因爲樹和提交者中的代碼不完全相同。如果你嚴格遵守規則（c），你應該要求提交者
-重新發布，但這完全是在浪費時間和精力。規則（b）允許您調整代碼，但是更改一個
-提交者的代碼並讓他認可您的錯誤是非常不禮貌的。要解決此問題，建議在最後一個
-由簽名行和您的行之間添加一行，指示更改的性質。雖然這並不是強制性的，但似乎
-在描述前加上您的郵件和/或姓名（全部用方括號括起來），這足以讓人注意到您對最
-後一分鐘的更改負有責任。例如::
+開發者來源認證 1.1
+^^^^^^^^^^^^^^^^^^
 
-	Signed-off-by: Random J Developer <random@developer.example.org>
-	[lucky@maintainer.example.org: struct foo moved from foo.c to foo.h]
-	Signed-off-by: Lucky K Maintainer <lucky@maintainer.example.org>
+對於本項目的貢獻，我認證如下信息：
 
-如果您維護一個穩定的分支機構，同時希望對作者進行致謝、跟蹤更改、合併修復並
-保護提交者不受投訴，那麼這種做法尤其有用。請注意，在任何情況下都不能更改作者
-的ID（From 頭），因爲它是出現在更改日誌中的標識。
+       (a) 這些貢獻是完全或者部分的由我創建，我有權利以文件中指出
+           的開放源代碼許可證提交它；或者
 
-對回合（back-porters）的特別說明：在提交消息的頂部（主題行之後）插入一個補丁
-的起源指示似乎是一種常見且有用的實踐，以便於跟蹤。例如，下面是我們在3.x穩定
-版本中看到的內容::
+       (b) 這些貢獻基於以前的工作，據我所知，這些以前的工作受恰當的開放
+           源代碼許可證保護，而且，根據文件中指出的許可證，我有權提交修改後的貢獻，
+           無論是完全還是部分由我創造，這些貢獻都使用同一個開放源代碼許可證
+           （除非我被允許用其它的許可證）；或者
 
-  Date:   Tue Oct 7 07:26:38 2014 -0400
+       (c) 這些貢獻由認證（a），（b）或者（c）的人直接提供給我，而
+           且我沒有修改它。
 
-    libata: Un-break ATA blacklist
+       (d) 我理解並同意這個項目和貢獻是公開的，貢獻的記錄（包括我
+           一起提交的個人記錄，包括sign-off）被永久維護並且可以和這個項目
+           或者開放源代碼的許可證同步地再發行。
 
-    commit 1c40279960bcd7d52dbdf1d466b20d24b99176c8 upstream.
+那麼加入這樣一行::
 
-還有， 這裡是一個舊版內核中的一個回合補丁::
+  Signed-off-by: Random J Developer <random@developer.example.org>
 
-    Date:   Tue May 13 22:12:27 2008 +0200
+使用你的真名（抱歉，不能使用假名或者匿名。）如果使用 ``git commit -s`` 的話
+將會自動完成。撤銷也應當包含“Signed-off-by”， ``git revert -s`` 會幫你搞定。
 
-        wireless, airo: waitbusy() won't delay
+有些人會在最後加上額外的標籤。現在這些東西會被忽略，但是你可以這樣做，來標記
+公司內部的過程，或者只是指出關於簽署的一些特殊細節。
 
-        [backport of 2.6 commit b7acbdfbd1f277c1eb23f344f899cfa4cd0bf36a]
+作者簽署之後的任何其他簽署（Signed-off-by:'s）均來自處理和傳遞補丁的人員，但
+未參與其開發。簽署鏈應當反映補丁傳播到維護者並最終傳播到Linus所經過的 **真實**
+路徑，首個簽署指明單個作者的主要作者身份。
 
-12）何時使用Acked-by:，CC:，和Co-Developed by:
-----------------------------------------------
+何時使用Acked-by:，CC:，和Co-Developed by:
+------------------------------------------
 
-Singed-off-by: 標記表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
+Singed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
 
-如果一個人沒有直接參與補丁的準備或處理，但希望表示並記錄他們對補丁的批准，
-那麼他們可以要求在補丁的變更日誌中添加一個 Acked-by:
+如果一個人沒有直接參與補丁的準備或處理，但希望表示並記錄他們對補丁的批准/贊成，
+那麼他們可以要求在補丁的變更日誌中添加一個Acked-by:。
 
-Acked-by：通常由受影響代碼的維護者使用，當該維護者既沒有貢獻也沒有轉發補丁時。
+Acked-by: 通常由受影響代碼的維護者使用，當該維護者既沒有貢獻也沒有轉發補丁時。
 
-Acked-by: 不像簽字人那樣正式。這是一個記錄，確認人至少審查了補丁，並表示接受。
-因此，補丁合併有時會手動將Acker的「Yep，looks good to me」轉換爲 Acked-By：（但
+Acked-by: 不像簽署那樣正式。這是一個記錄，確認人至少審閱了補丁，並表示接受。
+因此，補丁合併有時會手動將Acker的“Yep，looks good to me”轉換爲 Acked-By:（但
 請注意，通常最好要求一個明確的Ack）。
 
 Acked-by：不一定表示對整個補丁的確認。例如，如果一個補丁影響多個子系統，並且
-有一個：來自一個子系統維護者，那麼這通常表示只確認影響維護者代碼的部分。這裡
-應該仔細判斷。如有疑問，應參考郵件列表檔案中的原始討論。
+有一個來自某個子系統維護者的Acked-By:，那麼這通常表示只確認影響維護者代碼的部
+分。這裏應該仔細判斷。如有疑問，應參考郵件列表存檔中的原始討論。
 
-如果某人有機會對補丁進行評論，但沒有提供此類評論，您可以選擇在補丁中添加 ``Cc:``
-這是唯一一個標籤，它可以在沒有被它命名的人顯式操作的情況下添加，但它應該表明
-這個人是在補丁上抄送的。討論中包含了潛在利益相關方。
+如果某人本應有機會對補丁進行評論，但沒有提供此類評論，您可以選擇在補丁中添加
+``Cc:`` 這是唯一可以在沒有被該人明確同意的情況下添加的標籤——但它應該表明
+這個人是在補丁上抄送的。此標籤記錄了討論中包含的潛在利益相關方。
 
 Co-developed-by: 聲明補丁是由多個開發人員共同創建的；當幾個人在一個補丁上工
-作時，它用於將屬性賦予共同作者（除了 From: 所賦予的作者之外）。因爲
-Co-developed-by: 表示作者身份，所以每個共同開發人：必須緊跟在相關合作作者的
-簽名之後。標準的簽核程序要求：標記的簽核順序應儘可能反映補丁的時間歷史，而不
-管作者是通過 From ：還是由 Co-developed-by: 共同開發的。值得注意的是，最後一
-個簽字人：必須始終是提交補丁的開發人員。
+作時，它用於給出共同作者（除了From:所給出的作者之外）。因爲Co-developed-by:
+表示作者身份，所以每個Co-developed-by:必須緊跟在相關合作作者的簽署之後。標準
+簽署程序要求Singed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
+過From:還是Co-developed-by:表明。值得注意的是，最後一個Singed-off-by:必須是
+提交補丁的開發人員。
 
-注意，當作者也是電子郵件標題「發件人：」行中列出的人時，「From: 」 標記是可選的。
+注意，如果From:作者也是電子郵件標題的From:行中列出的人，則From:標籤是可選的。
 
-作者提交的補丁程序示例::
+被From:作者提交的補丁示例::
 
 	<changelog>
 
@@ -423,7 +375,7 @@ Co-developed-by: 表示作者身份，所以每個共同開發人：必須緊跟
 	Signed-off-by: Second Co-Author <second@coauthor.example.org>
 	Signed-off-by: From Author <from@author.example.org>
 
-合作開發者提交的補丁示例::
+被合作開發者提交的補丁示例::
 
 	From: From Author <from@author.example.org>
 
@@ -436,106 +388,115 @@ Co-developed-by: 表示作者身份，所以每個共同開發人：必須緊跟
 	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
 
-13）使用報告人：、測試人：、審核人：、建議人：、修復人：
---------------------------------------------------------
+使用Reported-by:、Tested-by:、Reviewed-by:、Suggested-by:和Fixes:
+-----------------------------------------------------------------
 
 Reported-by: 給那些發現錯誤並報告錯誤的人致謝，它希望激勵他們在將來再次幫助
-我們。請注意，如果bug是以私有方式報告的，那麼在使用Reported-by標記之前，請
-先請求權限。
+我們。請注意，如果bug是以私有方式報告的，那麼在使用Reported-by標籤之前，請
+先請求許可。此標籤是爲Bug設計的；請不要將其用於感謝功能請求。
 
-Tested-by: 標記表示補丁已由指定的人（在某些環境中）成功測試。這個標籤通知
-維護人員已經執行了一些測試，爲將來的補丁提供了一種定位測試人員的方法，並確
-保測試人員的信譽。
+Tested-by: 標籤表示補丁已由指定的人（在某些環境中）成功測試。這個標籤通知
+維護人員已經執行了一些測試，爲將來的補丁提供了一種定位測試人員的方法，並彰顯測試人員的功勞。
 
-Reviewed-by：相反，根據審查人的聲明，表明該補丁已被審查並被認爲是可接受的：
+Reviewed-by：根據審閱者的監督聲明，表明該補丁已被審閱並被認爲是可接受的：
 
 
-審查人的監督聲明
+審閱者的監督聲明
 ^^^^^^^^^^^^^^^^
 
-通過提供我的 Reviewed-by，我聲明：
+通過提供我的Reviewed-by:標籤，我聲明：
 
-        (a) 我已經對這個補丁進行了一次技術審查，以評估它是否適合被包含到
+        (a) 我已經對這個補丁進行了一次技術審閱，以評估它是否適合被包含到
             主線內核中。
 
         (b) 與補丁相關的任何問題、顧慮或問題都已反饋給提交者。我對提交者對
             我的評論的回應感到滿意。
 
-        (c) 雖然這一提交可能會改進一些東西，但我相信，此時，（1）對內核
+        (c) 雖然這一提交可能仍可被改進，但我相信，此時，（1）對內核
             進行了有價值的修改，（2）沒有包含爭論中涉及的已知問題。
 
-        (d) 雖然我已經審查了補丁並認爲它是健全的，但我不會（除非另有明確
-            說明）作出任何保證或保證它將在任何給定情況下實現其規定的目的
+        (d) 雖然我已經審閱了補丁並認爲它是健全的，但我不會（除非另有明確
+            說明）作出任何保證或擔保它會在任何給定情況下實現其規定的目的
             或正常運行。
 
-Reviewed-by 是一種觀點聲明，即補丁是對內核的適當修改，沒有任何遺留的嚴重技術
-問題。任何感興趣的審閱者（完成工作的人）都可以爲一個補丁提供一個 Review-by
-標籤。此標籤用於向審閱者提供致謝，並通知維護者已在修補程序上完成的審閱程度。
-Reviewed-by: 當由已知了解主題區域並執行徹底檢查的審閱者提供時，通常會增加
+Reviewed-by是一種觀點聲明，即補丁是對內核的適當修改，沒有任何遺留的嚴重技術
+問題。任何感興趣的審閱者（完成工作的人）都可以爲一個補丁提供一個Reviewed-by
+標籤。此標籤用於向審閱者提供致謝，並通知維護者補丁的審閱進度。
+當Reviewed-by:標籤由已知了解主題區域並執行徹底檢查的審閱者提供時，通常會增加
 補丁進入內核的可能性。
 
+一旦從測試人員或審閱者的“Tested-by”和“Reviewed-by”標籤出現在郵件列表中，
+作者應在發送下一個版本時將其添加到適用的補丁中。但是，如果補丁在以下版本中發
+生了實質性更改，這些標籤可能不再適用，因此應該刪除。通常，在補丁更改日誌中
+（在 ``---`` 分隔符之後）應該提到刪除某人的測試者或審閱者標籤。
+
 Suggested-by: 表示補丁的想法是由指定的人提出的，並確保將此想法歸功於指定的
-人。請注意，未經許可，不得添加此標籤，特別是如果該想法未在公共論壇上發布。
-這就是說，如果我們勤快地致謝我們的創意者，他們很有希望在未來得到鼓舞，再次
+人。請注意，未經許可，不得添加此標籤，特別是如果該想法未在公共論壇上發佈。
+也就是說，如果我們勤快地致謝創意提供者，他們將受到鼓舞，很有希望在未來再次
 幫助我們。
 
-Fixes: 指示補丁在以前的提交中修復了一個問題。它可以很容易地確定錯誤的來源，
-這有助於檢查錯誤修復。這個標記還幫助穩定內核團隊確定應該接收修復的穩定內核
-版本。這是指示補丁修復的錯誤的首選方法。請參閱 :ref:`tw_describe_changes`
-描述您的更改以了解更多詳細信息。
+Fixes: 指示補丁修復了之前提交的一個問題。它可以便於確定錯誤的來源，這有助於
+檢查錯誤修復。這個標籤還幫助穩定內核團隊確定應該接收修復的穩定內核版本。這是
+指示補丁修復的錯誤的首選方法。請參閱 :ref:`zh_describe_changes` 瞭解更多信息。
 
-.. _tw_the_canonical_patch_format:
+.. note::
 
-12）標準補丁格式
-----------------
+  附加Fixes:標籤不會改變穩定內核規則流程，也不改變所有穩定版補丁抄送
+  stable@vger.kernel.org的要求。有關更多信息，請閱讀
+  Documentation/translations/zh_TW/process/stable-kernel-rules.rst 。
+
+.. _zh_the_canonical_patch_format:
+
+標準補丁格式
+------------
 
 本節描述如何格式化補丁本身。請注意，如果您的補丁存儲在 ``Git`` 存儲庫中，則
-可以使用 ``git format-patch`` 進行正確的補丁格式設置。但是，這些工具無法創建
+可以使用 ``git format-patch`` 進行正確的補丁格式化。但是，這些工具無法創建
 必要的文本，因此請務必閱讀下面的說明。
 
-標準的補丁，標題行是::
+標準的補丁標題行是::
 
     Subject: [PATCH 001/123] 子系統:一句話概述
 
-標準補丁的信體存在如下部分：
+標準補丁的信體包含如下部分：
 
-  - 一個 "from" 行指出補丁作者。後跟空行（僅當發送修補程序的人不是作者時才需要）。
+  - 一個 ``from`` 行指出補丁作者。後跟空行（僅當發送補丁的人不是作者時才需要）。
 
-  - 解釋的正文，行以75列包裝，這將被複製到永久變更日誌來描述這個補丁。
+  - 說明文字，每行最長75列，這將被複制到永久變更日誌來描述這個補丁。
 
   - 一個空行
 
-  - 上面描述的「Signed-off-by」 行，也將出現在更改日誌中。
+  - 上述的 ``Signed-off-by:`` 行，也將出現在更改日誌中。
 
   - 只包含 ``---`` 的標記線。
 
-  - 任何其他不適合放在變更日誌的注釋。
+  - 任何其他不適合放在變更日誌的註釋。
 
   - 實際補丁（ ``diff`` 輸出）。
 
-標題行的格式，使得對標題行按字母序排序非常的容易 - 很多 e-mail 客戶端都
-可以支持 - 因爲序列號是用零填充的，所以按數字排序和按字母排序是一樣的。
+標題行的格式，使得對標題行按字母序排序非常的容易——很多郵件客戶端都
+可以支持——因爲序列號是用零填充的，所以按數字排序和按字母排序是一樣的。
 
-e-mail 標題中的「子系統」標識哪個內核子系統將被打補丁。
+郵件標題中的“子系統”標識哪個內核子系統將被打補丁。
 
-e-mail 標題中的「一句話概述」扼要的描述 e-mail 中的補丁。「一句話概述」
-不應該是一個文件名。對於一個補丁系列（「補丁系列」指一系列的多個相關補
-丁），不要對每個補丁都使用同樣的「一句話概述」。
+郵件標題中的“一句話概述”扼要的描述郵件中的補丁。“一句話概述”
+不應該是一個文件名。對於一個補丁系列（“補丁系列”指一系列的多個相關補
+丁），不要對每個補丁都使用同樣的“一句話概述”。
 
-記住 e-mail 的「一句話概述」會成爲該補丁的全局唯一標識。它會蔓延到 git
-的改動記錄里。然後「一句話概述」會被用在開發者的討論里，用來指代這個補
-丁。用戶將希望通過 google 來搜索"一句話概述"來找到那些討論這個補丁的文
+記住郵件的“一句話概述”會成爲該補丁的全局唯一標識。它會進入 ``git``
+的改動記錄裏。然後“一句話概述”會被用在開發者的討論裏，用來指代這個補
+丁。用戶將希望通過搜索引擎搜索“一句話概述”來找到那些討論這個補丁的文
 章。當人們在兩三個月後使用諸如 ``gitk`` 或 ``git log --oneline`` 之類
 的工具查看數千個補丁時，也會很快看到它。
 
 出於這些原因，概述必須不超過70-75個字符，並且必須描述補丁的更改以及爲
-什麼需要補丁。既要簡潔又要描述性很有挑戰性，但寫得好的概述應該這樣做。
+什麼需要補丁。既要簡潔又要描述性很有挑戰性，但寫得好的概述應該這樣。
 
-概述的前綴可以用方括號括起來：「Subject: [PATCH <tag>...] <概述>」。標記
+概述的前綴可以用方括號括起來：“Subject: [PATCH <tag>...] <概述>”。標記
 不被視爲概述的一部分，而是描述應該如何處理補丁。如果補丁的多個版本已發
-送出來以響應評審（即「v1，v2，v3」）或「rfc」，以指示評審請求，那麼通用標記
-可能包括版本描述符。如果一個補丁系列中有四個補丁，那麼各個補丁可以這樣
-編號：1/4、2/4、3/4、4/4。這可以確保開發人員了解補丁應用的順序，並且他們
+送出來以響應評審（即“v1，v2，v3”）則必須包含版本號，或包含“RFC”以指示
+評審請求。如果一個補丁系列中有四個補丁，那麼各個補丁可以這樣編號：1/4、2/4、
+3/4、4/4。這可以確保開發人員瞭解補丁應用的順序，且
 已經查看或應用了補丁系列中的所有補丁。
 
 一些標題的例子::
@@ -543,95 +504,134 @@ e-mail 標題中的「一句話概述」扼要的描述 e-mail 中的補丁。
     Subject: [patch 2/5] ext2: improve scalability of bitmap searching
     Subject: [PATCHv2 001/207] x86: fix eflags tracking
 
-"From" 行是信體裡的最上面一行，具有如下格式：
+``From`` 行是信體裏的最上面一行，具有如下格式::
+
         From: Patch Author <author@example.com>
 
-"From" 行指明在永久改動日誌里，誰會被確認爲作者。如果沒有 "From" 行，那
-麼郵件頭裡的 "From: " 行會被用來決定改動日誌中的作者。
+``From`` 行指明在永久改動日誌裏，誰會被確認爲作者。如果沒有 ``From`` 行，那
+麼郵件頭裏的 ``From:`` 行會被用來決定改動日誌中的作者。
+
+說明文字將會被提交到永久的源代碼改動日誌裏，因此應針對那些早已經不記得和這
+個補丁相關的討論細節的讀者。包括補丁處理的故障症狀（內核日誌消息、oops消息
+等），這對於可能正在搜索提交日誌以查找適用補丁的人特別有用。文本應該寫得如
+此詳細，以便在數週、數月甚至數年後閱讀時，能夠爲讀者提供所需的細節信息，以
+掌握創建補丁的 **原因** 。
 
-說明的主題將會被提交到永久的原始碼改動日誌里，因此對那些早已經不記得和
-這個補丁相關的討論細節的有能力的讀者來說，是有意義的。包括補丁程序定位
-錯誤的（內核日誌消息、OOPS消息等）症狀，對於搜索提交日誌以尋找適用補丁的人
-尤其有用。如果一個補丁修復了一個編譯失敗，那麼可能不需要包含所有編譯失敗；
+如果一個補丁修復了一個編譯失敗，那麼可能不需要包含 *所有* 編譯失敗；
 只要足夠讓搜索補丁的人能夠找到它就行了。與概述一樣，既要簡潔又要描述性。
 
-"---" 標記行對於補丁處理工具要找到哪裡是改動日誌信息的結束，是不可缺少
+``---`` 標記行對於補丁處理工具要找到哪裏是改動日誌信息的結束，是不可缺少
 的。
 
-對於 "---" 標記之後的額外註解，一個好的用途就是用來寫 diffstat，用來顯
-示修改了什麼文件和每個文件都增加和刪除了多少行。diffstat 對於比較大的補
-丁特別有用。其餘那些只是和時刻或者開發者相關的註解，不合適放到永久的改
-動日誌里的，也應該放這裡。
-使用 diffstat的選項 "-p 1 -w 70" 這樣文件名就會從內核原始碼樹的目錄開始
-，不會占用太寬的空間（很容易適合80列的寬度，也許會有一些縮進。）
+對於 ``---`` 標記之後的額外註解，一個好的用途就是用來寫 ``diffstat`` ，用來顯
+示修改了什麼文件和每個文件都增加和刪除了多少行。 ``diffstat`` 對於比較大的補
+丁特別有用。
+使用 ``diffstat`` 的選項 ``-p 1 -w 70`` 這樣文件名就會從內核源代碼樹的目錄開始
+，不會佔用太寬的空間（很容易適合80列的寬度，也許會有一些縮進。）
+（ ``git`` 默認會生成合適的diffstat。）
 
-在後面的參考資料中能看到適當的補丁格式的更多細節。
+其餘那些只適用於當時或者與維護者相關的註解，不合適放到永久的改動日誌裏的，也
+應該放這裏。較好的例子就是 ``補丁更改記錄`` ，記錄了v1和v2版本補丁之間的差異。
 
-.. _tw_explicit_in_reply_to:
+請將此信息放在將變更日誌與補丁的其餘部分分隔開的 ``---`` 行 **之後** 。版本
+信息不是提交到git樹的變更日誌的一部分。只是供審閱人員使用的附加信息。如果將
+其放置在提交標記上方，則需要手動交互才能將其刪除。如果它位於分隔線以下，則在
+應用補丁時會自動剝離::
 
-15) 明確回覆郵件頭(In-Reply-To)
--------------------------------
+  <commit message>
+  ...
+  Signed-off-by: Author <author@mail>
+  ---
+  V2 -> V3: Removed redundant helper function
+  V1 -> V2: Cleaned up coding style and addressed review comments
 
-手動添加回復補丁的的標題頭(In-Reply_To:) 是有幫助的（例如，使用 ``git send-email`` ）
-將補丁與以前的相關討論關聯起來，例如，將bug修復程序連結到電子郵件和bug報告。
-但是，對於多補丁系列，最好避免在回復時使用連結到該系列的舊版本。這樣，
-補丁的多個版本就不會成爲電子郵件客戶端中無法管理的引用序列。如果連結有用，
-可以使用 https://lore.kernel.org/ 重定向器（例如，在封面電子郵件文本中）
-連結到補丁系列的早期版本。
+  path/to/file | 5+++--
+  ...
+
+在後面的參考資料中能看到正確補丁格式的更多細節。
 
-16) 發送git pull請求
---------------------
+.. _zh_backtraces:
 
-如果您有一系列補丁，那麼讓維護人員通過git pull操作將它們直接拉入子系統存儲
-庫可能是最方便的。但是，請注意，從開發人員那裡獲取補丁比從郵件列表中獲取補
-丁需要更高的信任度。因此，許多子系統維護人員不願意接受請求，特別是來自新的
-未知開發人員的請求。如果有疑問，您可以在封面郵件中使用pull 請求作爲補丁系列
-正常發布的一個選項，讓維護人員可以選擇使用其中之一。
+提交消息中的回溯（Backtraces）
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+回溯有助於記錄導致問題的調用鏈。然而，並非所有回溯都有幫助。例如，早期引導調
+用鏈是獨特而明顯的。而逐字複製完整的dmesg輸出則會增加時間戳、模塊列表、寄存
+器和堆棧轉儲等分散注意力的信息。
+
+因此，最有用的回溯應該從轉儲中提取相關信息，以更容易集中在真實問題上。下面是
+一個剪裁良好的回溯示例::
+
+  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
+  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
+  Call Trace:
+  mba_wrmsr
+  update_domains
+  rdtgroup_mkdir
+
+.. _zh_explicit_in_reply_to:
+
+明確回覆郵件頭（In-Reply-To）
+-----------------------------
+
+手動添加回復補丁的的郵件頭（In-Reply_To:）是有用的（例如，使用 ``git send-email`` ），
+可以將補丁與以前的相關討論關聯起來，例如，將bug補丁鏈接到電子郵件和bug報告。
+但是，對於多補丁系列，最好避免在回覆時使用鏈接到該系列的舊版本。這樣，
+補丁的多個版本就不會成爲電子郵件客戶端中無法管理的引用樹。如果鏈接有用，
+可以使用 https://lore.kernel.org/ 重定向器（例如，在封面電子郵件文本中）
+鏈接到補丁系列的早期版本。
 
-pull 請求的主題行中應該有[Git Pull]。請求本身應該在一行中包含存儲庫名稱和
-感興趣的分支；它應該看起來像::
+給出基礎樹信息
+--------------
 
-  Please pull from
+當其他開發人員收到您的補丁並開始審閱時，知道應該將您的工作放到代碼樹歷史記錄
+中的什麼位置通常很有用。這對於自動化持續集成流水（CI）特別有用，這些流水線試
+圖運行一系列測試，以便在維護人員開始審閱之前確定提交的質量。
 
-      git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus
+如果您使用 ``git format-patch`` 生成補丁，則可以通過 ``--base`` 標誌在提交中
+自動包含基礎樹信息。使用此選項最簡單、最方便的方法是配合主題分支::
 
-  to get these changes:
+    $ git checkout -t -b my-topical-branch master
+    Branch 'my-topical-branch' set up to track local branch 'master'.
+    Switched to a new branch 'my-topical-branch'
 
+    [perform your edits and commits]
 
-pull 請求還應該包含一條整體消息，說明請求中將包含什麼，一個補丁本身的 ``Git shortlog``
-以及一個顯示補丁系列整體效果的 ``diffstat`` 。當然，將所有這些信息收集在一起
-的最簡單方法是讓 ``git`` 使用 ``git request-pull`` 命令爲您完成這些工作。
+    $ git format-patch --base=auto --cover-letter -o outgoing/ master
+    outgoing/0000-cover-letter.patch
+    outgoing/0001-First-Commit.patch
+    outgoing/...
 
-一些維護人員（包括Linus）希望看到來自已簽名提交的請求；這增加了他們對你的
-請求信心。特別是，在沒有簽名標籤的情況下，Linus 不會從像 Github 這樣的公共
-託管站點拉請求。
+當你編輯 ``outgoing/0000-cover-letter.patch`` 時，您會注意到在它的最底部有一
+行 ``base-commit:`` 尾註，它爲審閱者和CI工具提供了足夠的信息以正確執行
+``git am`` 而不必擔心衝突::
 
-創建此類簽名的第一步是生成一個 GNRPG 密鑰，並由一個或多個核心內核開發人員對
-其進行簽名。這一步對新開發人員來說可能很困難，但沒有辦法繞過它。參加會議是
-找到可以簽署您的密鑰的開發人員的好方法。
+    $ git checkout -b patch-review [base-commit-id]
+    Switched to a new branch 'patch-review'
+    $ git am patches.mbox
+    Applying: First Commit
+    Applying: ...
 
-一旦您在Git 中準備了一個您希望有人拉的補丁系列，就用 ``git tag -s`` 創建一
-個簽名標記。這將創建一個新標記，標識該系列中的最後一次提交，並包含用您的私
-鑰創建的簽名。您還可以將changelog樣式的消息添加到標記中；這是一個描述拉請求
-整體效果的理想位置。
+有關此選項的更多信息，請參閱 ``man git-format-patch`` 。
 
-如果維護人員將要從中提取的樹不是您正在使用的存儲庫，請不要忘記將已簽名的標記
-顯式推送到公共樹。
+.. note::
 
-生成拉請求時，請使用已簽名的標記作爲目標。這樣的命令可以實現::
+    ``--base`` 功能是在2.9.0版git中引入的。
 
-  git request-pull master git://my.public.tree/linux.git my-signed-tag
+如果您不使用git格式化補丁，仍然可以包含相同的 ``base-commit`` 尾註，以指示您
+的工作所基於的樹的提交哈希。你應該在封面郵件或系列的第一個補丁中添加它，它應
+該放在 ``---`` 行的下面或所有其他內容之後，即只在你的電子郵件簽名之前。
 
 參考文獻
 --------
 
-Andrew Morton, "The perfect patch" (tpp).
+Andrew Morton，“完美的補丁”（tpp）
   <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
-Jeff Garzik, "Linux kernel patch submission format".
+Jeff Garzik，“Linux內核補丁提交格式”
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
 
-Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
+Greg Kroah-Hartman，“如何惹惱內核子系統維護人員”
   <http://www.kroah.com/log/linux/maintainer.html>
 
   <http://www.kroah.com/log/linux/maintainer-02.html>
@@ -644,17 +644,16 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
 
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
-NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
+不！！！別再發巨型補丁炸彈給linux-kernel@vger.kernel.org的人們了！
   <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
-Kernel Documentation/process/coding-style.rst:
-  :ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`
+內核 Documentation/translations/zh_TW/process/coding-style.rst
 
-Linus Torvalds's mail on the canonical patch format:
+Linus Torvalds關於標準補丁格式的郵件
   <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
 
-Andi Kleen, "On submitting kernel patches"
-  Some strategies to get difficult or controversial changes in.
+Andi Kleen，“提交補丁之路”
+  一些幫助合入困難或有爭議的變更的策略。
 
   http://halobates.de/on-submitting-patches.pdf
 
diff --git a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
index 469cb5b3a07c..a609620affb0 100644
--- a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
@@ -19,20 +19,20 @@
                        時奎亮 Alex Shi <alex.shi@linux.alibaba.com>
                        胡皓文 Hu Haowen <src.res.211@gmail.com>
 
-爲什麼不應該使用「volatile」類型
-================================
+爲什麼不應該使用“volatile”類型
+==============================
 
-C程式設計師通常認爲volatile表示某個變量可以在當前執行的線程之外被改變；因此，在內核
-中用到共享數據結構時，常常會有C程式設計師喜歡使用volatile這類變量。換句話說，他們經
+C程序員通常認爲volatile表示某個變量可以在當前執行的線程之外被改變；因此，在內核
+中用到共享數據結構時，常常會有C程序員喜歡使用volatile這類變量。換句話說，他們經
 常會把volatile類型看成某種簡易的原子變量，當然它們不是。在內核中使用volatile幾
 乎總是錯誤的；本文檔將解釋爲什麼這樣。
 
 理解volatile的關鍵是知道它的目的是用來消除優化，實際上很少有人真正需要這樣的應
-用。在內核中，程式設計師必須防止意外的並發訪問破壞共享的數據結構，這其實是一個完全
-不同的任務。用來防止意外並發訪問的保護措施，可以更加高效的避免大多數優化相關的
+用。在內核中，程序員必須防止意外的併發訪問破壞共享的數據結構，這其實是一個完全
+不同的任務。用來防止意外併發訪問的保護措施，可以更加高效的避免大多數優化相關的
 問題。
 
-像volatile一樣，內核提供了很多原語來保證並發訪問時的數據安全（自旋鎖, 互斥量,內
+像volatile一樣，內核提供了很多原語來保證併發訪問時的數據安全（自旋鎖, 互斥量,內
 存屏障等等），同樣可以防止意外的優化。如果可以正確使用這些內核原語，那麼就沒有
 必要再使用volatile。如果仍然必須使用volatile，那麼幾乎可以肯定在代碼的某處有一
 個bug。在正確設計的內核代碼中，volatile能帶來的僅僅是使事情變慢。
@@ -46,8 +46,8 @@ C程式設計師通常認爲volatile表示某個變量可以在當前執行的
 
 如果所有的代碼都遵循加鎖規則，當持有the_lock的時候，不可能意外的改變shared_data的
 值。任何可能訪問該數據的其他代碼都會在這個鎖上等待。自旋鎖原語跟內存屏障一樣—— 它
-們顯式的用來書寫成這樣 —— 意味著數據訪問不會跨越它們而被優化。所以本來編譯器認爲
-它知道在shared_data裡面將有什麼，但是因爲spin_lock()調用跟內存屏障一樣，會強制編
+們顯式的用來書寫成這樣 —— 意味着數據訪問不會跨越它們而被優化。所以本來編譯器認爲
+它知道在shared_data裏面將有什麼，但是因爲spin_lock()調用跟內存屏障一樣，會強制編
 譯器忘記它所知道的一切。那麼在訪問這些數據時不會有優化的問題。
 
 如果shared_data被聲名爲volatile，鎖操作將仍然是必須的。就算我們知道沒有其他人正在
@@ -55,13 +55,13 @@ C程式設計師通常認爲volatile表示某個變量可以在當前執行的
 shared_data不是volatile的。在處理共享數據的時候，適當的鎖操作可以不再需要
 volatile —— 並且是有潛在危害的。
 
-volatile的存儲類型最初是爲那些內存映射的I/O寄存器而定義。在內核里，寄存器訪問也應
-該被鎖保護，但是人們也不希望編譯器「優化」臨界區內的寄存器訪問。內核里I/O的內存訪問
+volatile的存儲類型最初是爲那些內存映射的I/O寄存器而定義。在內核裏，寄存器訪問也應
+該被鎖保護，但是人們也不希望編譯器“優化”臨界區內的寄存器訪問。內核裏I/O的內存訪問
 是通過訪問函數完成的；不贊成通過指針對I/O內存的直接訪問，並且不是在所有體系架構上
 都能工作。那些訪問函數正是爲了防止意外優化而寫的，因此，再說一次，volatile類型不
 是必需的。
 
-另一種引起用戶可能使用volatile的情況是當處理器正忙著等待一個變量的值。正確執行一
+另一種引起用戶可能使用volatile的情況是當處理器正忙着等待一個變量的值。正確執行一
 個忙等待的方法是::
 
     while (my_variable != what_i_want)
@@ -74,14 +74,14 @@ cpu_relax()調用會降低CPU的能量消耗或者讓位於超線程雙處理器
 
   - 在一些體系架構的系統上，允許直接的I/0內存訪問，那麼前面提到的訪問函數可以使用
     volatile。基本上，每一個訪問函數調用它自己都是一個小的臨界區域並且保證了按照
-    程式設計師期望的那樣發生訪問操作。
+    程序員期望的那樣發生訪問操作。
 
   - 某些會改變內存的內聯彙編代碼雖然沒有什麼其他明顯的附作用，但是有被GCC刪除的可
     能性。在彙編聲明中加上volatile關鍵字可以防止這種刪除操作。
 
   - Jiffies變量是一種特殊情況，雖然每次引用它的時候都可以有不同的值，但讀jiffies
     變量時不需要任何特殊的加鎖保護。所以jiffies變量可以使用volatile，但是不贊成
-    其他跟jiffies相同類型變量使用volatile。Jiffies被認爲是一種「愚蠢的遺留物"
+    其他跟jiffies相同類型變量使用volatile。Jiffies被認爲是一種“愚蠢的遺留物"
     （Linus的話）因爲解決這個問題比保持現狀要麻煩的多。
 
   - 由於某些I/0設備可能會修改連續一致的內存,所以有時,指向連續一致內存的數據結構
@@ -92,9 +92,9 @@ cpu_relax()調用會降低CPU的能量消耗或者讓位於超線程雙處理器
 bug並且需要對這樣的代碼額外仔細檢查。那些試圖使用volatile的開發人員需要退一步想想
 他們真正想實現的是什麼。
 
-非常歡迎刪除volatile變量的補丁 － 只要證明這些補丁完整的考慮了並發問題。
+非常歡迎刪除volatile變量的補丁 － 只要證明這些補丁完整的考慮了併發問題。
 
-注釋
+註釋
 ----
 
 [1] https://lwn.net/Articles/233481/
-- 
2.34.1

