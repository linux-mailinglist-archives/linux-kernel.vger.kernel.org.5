Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C14772349
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjHGMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjHGMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C2E6F;
        Mon,  7 Aug 2023 05:00:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-686f94328a4so2896947b3a.0;
        Mon, 07 Aug 2023 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691409625; x=1692014425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys6CTDvhnj97qu5mgH5sv10pWsJgX9tlCQKDnAcFDAg=;
        b=EYtbUsvhRFJMMxihEMMpdlkC8IcMM84GRyBa4iBrZAHiuRB74P2gONzxtaH9WkgIGw
         xFpIIISsVS2czuwtz0gwVXi1Qw584SIvCChX7ywHzr8RNDV7F3Qyny87J34S9L5jbtde
         ZIF+Ho697Pv4jBWeQslV/9LHX4F5SrhVsUnM+Ev/1WEuCkiJ8Kq2AYsOaU5ttNwQxLKq
         sOVywzi1lWfLq2b5O+ro85gz6+WIVQ18916tEuVFA7rUBxFpm6dmhmYi8emhih3oZDg8
         I9t/Tscth8OXXxzc17fMWRFGI9zEyb+aUfTXKD+/L+gNrInopHqCqjeMvWNDpTB/gArT
         Op7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409625; x=1692014425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys6CTDvhnj97qu5mgH5sv10pWsJgX9tlCQKDnAcFDAg=;
        b=KPTJpywqW+meM7E/MCavFUJ2XdlnhD1+AmQvUbPNSHatjMTtsT2RnKnLOAVxeyJ7Hx
         LyTGGwMRzwXDVniLQBw7g1QqegZrsadm5+xKl5SdVur9m6Eud/WWf8E7a6sjd/g/9fya
         EYtoZV9W/8693XVubC6r+sY2Irue4auo7y9QhUUhm9+R5gzV8V7AvacKBDGyAIXw1AY2
         /EApNohagaTPX4L/XhVcEsxCoqPujoYiUJu3i1LJNSCd6k2DZcOUkr630SBAy0l7VCIu
         WncGTmOXava1LD5PGMtOAYlnlqfovK/mP5KTME2Brg+RrLr7Ip6w3PlwCA3Vinb4tPBI
         IAbQ==
X-Gm-Message-State: AOJu0YymHggDWeqr5hVADMaTIwKnC8WOtvhhQWvjAzrsRmiREDwIwwJz
        2EbWlgxI9oQSfxMrgV26z8NNXimAOzT3balT+2c=
X-Google-Smtp-Source: AGHT+IFsdkL4YCMpktQwm+LUonL0NyKlq1qROunDeNaBrgrdfwPVU6Md+wiq5Eke9BZLT+Jqitj4Ig==
X-Received: by 2002:a05:6a00:cc8:b0:666:b22d:c6e0 with SMTP id b8-20020a056a000cc800b00666b22dc6e0mr7943661pfv.11.1691409623035;
        Mon, 07 Aug 2023 05:00:23 -0700 (PDT)
Received: from localhost.localdomain ([113.251.7.202])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b00686940bfb77sm6013108pfi.71.2023.08.07.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:00:22 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] docs/zh_TW: update admin-guide
Date:   Mon,  7 Aug 2023 20:00:01 +0800
Message-Id: <20230807120006.6361-2-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807120006.6361-1-src.res.211@gmail.com>
References: <20230807120006.6361-1-src.res.211@gmail.com>
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

Update zh_TW's admin-guide documentation concentrating on the following
aspects:

    * The file tree structure changes of the main documentation;
    * Some changes and ideas from zh_CN translation;
    * Removal for several obsoleted contents within the zh_TW translation
      or those which are not exising anymore in the main documentation.
    * Replacements for some incorrect words and phrases in traditional
      Chinese or those which are odd within their context being hard for
      readers to comprehend.

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 .../translations/zh_TW/admin-guide/README.rst | 166 ++--
 .../zh_TW/admin-guide/bootconfig.rst          | 294 +++++++
 .../zh_TW/admin-guide/bug-bisect.rst          |  12 +-
 .../zh_TW/admin-guide/bug-hunting.rst         |  40 +-
 .../zh_TW/admin-guide/clearing-warn-once.rst  |   6 +-
 .../zh_TW/admin-guide/cpu-load.rst            |  10 +-
 .../zh_TW/admin-guide/cputopology.rst         |  98 +++
 .../translations/zh_TW/admin-guide/index.rst  | 136 ++--
 .../translations/zh_TW/admin-guide/init.rst   |  38 +-
 .../zh_TW/admin-guide/lockup-watchdogs.rst    |  69 ++
 .../zh_TW/admin-guide/mm/damon/index.rst      |  31 +
 .../zh_TW/admin-guide/mm/damon/lru_sort.rst   | 265 +++++++
 .../zh_TW/admin-guide/mm/damon/reclaim.rst    | 230 ++++++
 .../zh_TW/admin-guide/mm/damon/start.rst      | 126 +++
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 593 ++++++++++++++
 .../zh_TW/admin-guide/mm/index.rst            |  52 ++
 .../translations/zh_TW/admin-guide/mm/ksm.rst | 201 +++++
 .../zh_TW/admin-guide/reporting-issues.rst    | 729 +++++++++---------
 .../admin-guide/reporting-regressions.rst     | 371 +++++++++
 .../zh_TW/admin-guide/security-bugs.rst       |  28 +-
 .../translations/zh_TW/admin-guide/sysrq.rst  | 283 +++++++
 .../zh_TW/admin-guide/tainted-kernels.rst     |  86 +--
 .../zh_TW/admin-guide/unicode.rst             |  12 +-
 23 files changed, 3233 insertions(+), 643 deletions(-)
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

diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
index 6ce97edbab37..4cb581f5994a 100644
--- a/Documentation/translations/zh_TW/admin-guide/README.rst
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -7,18 +7,18 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
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
+Documentation/translations/zh_CN/admin-guide/reporting-issues.rst 。
+
+想要理解內核錯誤報告，請參閱：
+Documentation/translations/zh_CN/admin-guide/bug-hunting.rst 。
+
+更多用GDB調試內核的信息，請參閱：
+Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
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
index 41a39aebb8d6..3f10a9f8f223 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 二分（bisect）缺陷
 +++++++++++++++++++
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
index 4d813aec77d2..631fd2650929 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 追蹤缺陷
 =========
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
index bdc1a22046cf..6961006b4a2d 100644
--- a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
+++ b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
@@ -2,15 +2,15 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 清除 WARN_ONCE
 --------------
 
-WARN_ONCE / WARN_ON_ONCE / printk_once 僅僅列印一次消息.
+WARN_ONCE / WARN_ON_ONCE / printk_once 僅僅打印一次消息.
 
 echo 1 > /sys/kernel/debug/clear_warn_once
 
-可以清除這種狀態並且再次允許列印一次告警信息，這對於運行測試集後重現問題
+可以清除這種狀態並且再次允許打印一次告警信息，這對於運行測試集後重現問題
 很有用。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
index be087cef1967..cc046f3b7ffa 100644
--- a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
+++ b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 ========
 CPU 負載
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
index 000000000000..147a286e517c
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/cputopology.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 293c20245783..b51ddf760c4d 100644
--- a/Documentation/translations/zh_TW/admin-guide/index.rst
+++ b/Documentation/translations/zh_TW/admin-guide/index.rst
@@ -3,13 +3,13 @@
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :doc:`../../../admin-guide/index`
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Linux 內核用戶和管理員指南
 ==========================
 
 下面是一組隨時間添加到內核中的面向用戶的文檔的集合。到目前爲止，還沒有一個
-整體的順序或組織 - 這些材料不是一個單一的，連貫的文件！幸運的話，情況會隨著
+整體的順序或組織 - 這些材料不是一個單一的，連貫的文件！幸運的話，情況會隨着
 時間的推移而迅速改善。
 
 這個初始部分包含總體信息，包括描述內核的README， 關於內核參數的文檔等。
@@ -21,15 +21,15 @@ Linux 內核用戶和管理員指南
 
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
 
@@ -37,6 +37,7 @@ Todolist:
    :maxdepth: 1
 
    reporting-issues
+   reporting-regressions
    security-bugs
    bug-hunting
    bug-bisect
@@ -45,18 +46,17 @@ Todolist:
 
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
 
@@ -64,67 +64,67 @@ Todolist:
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
index 32cdf134948f..be6e34f5f7fa 100644
--- a/Documentation/translations/zh_TW/admin-guide/init.rst
+++ b/Documentation/translations/zh_TW/admin-guide/init.rst
@@ -7,10 +7,10 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
-解釋「No working init found.」啓動掛起消息
-==========================================
+解釋“No working init found.”啓動掛起消息
+=========================================
 
 :作者:
 
@@ -18,41 +18,41 @@
 
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
index 000000000000..64a28637c853
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/lockup-watchdogs.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..1900692f1c75
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/index.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..01cea8784b6e
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/lru_sort.rst
@@ -0,0 +1,265 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..a390712d5792
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/reclaim.rst
@@ -0,0 +1,230 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..9b8be5addd45
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..ac1af36bb17d
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
@@ -0,0 +1,593 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..917559614a1f
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/index.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..3b401c09e7bf
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/mm/ksm.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index 27638e199f13..fe5a5a07d51a 100644
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
 
@@ -16,7 +9,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 報告問題
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
+Documentation/translations/zh_CN/admin-guide/security-bugs.rst ，
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
+如果你的內核被污染了，請閱讀 Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst
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
+Documentation/translations/zh_CN/admin-guide/bug-bisect.rst 文檔中進行了詳細
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
+更多信息請參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
 
 
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
+特別關照”部分和文檔 Documentation/translations/zh_CN/admin-guide/bug-bisect.rst 。
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
+Documentation/translations/zh_CN/process/stable-kernel-rules.rst 中所列出的
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
index 000000000000..d7dcb2a26564
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
+#. 按照 Documentation/translations/zh_CN/admin-guide/reporting-issues.rst 中
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
+只需按照 Documentation/translations/zh_CN/admin-guide/reporting-issues.rst 中
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
+如 Documentation/translations/zh_CN/admin-guide/reporting-issues.rst （簡要）
+和 Documentation/translations/zh_CN/admin-guide/bug-bisect.rst （詳細）中所
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
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/translations/zh_CN/admin-guide/reporting-regressions.rst
+..
+   注意：本RST文件內容只有在來自Linux內核源代碼時是使用CC-BY-4.0許可的，因爲經
+   過處理的版本（如經內核的構建系統）可能包含來自使用更嚴格許可證的文件的內容。
+
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
index 15f8e9005071..c0e9fc247695 100644
--- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 安全缺陷
 =========
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
+請查看“Documentation/translations/zh_CN/admin-guide/reporting-issues.rst”中
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
index 000000000000..446277674b64
--- /dev/null
+++ b/Documentation/translations/zh_TW/admin-guide/sysrq.rst
@@ -0,0 +1,283 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
index d7b3c4276417..47629f6b05de 100644
--- a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
+++ b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
@@ -7,29 +7,29 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
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
index 720875be5ef8..a2b48b5d0a64 100644
--- a/Documentation/translations/zh_TW/admin-guide/unicode.rst
+++ b/Documentation/translations/zh_TW/admin-guide/unicode.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Unicode（統一碼）支持
 ======================
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
-- 
2.34.1

