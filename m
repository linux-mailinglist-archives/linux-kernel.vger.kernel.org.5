Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F477234F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjHGMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjHGMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243FF1B1;
        Mon,  7 Aug 2023 05:00:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-686ba97e4feso4242305b3a.0;
        Mon, 07 Aug 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691409627; x=1692014427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDEAJSJUMbcZRSLqOZC204RmLR3/sGRUsu91i10Qvh4=;
        b=H7L0sXgqR8J5Y8LshvCw0GrMQC+V8Us+haAHV2zQVtqp2WWpvARzVNhqeXUEZ9JQgx
         ESuLFNT1Gcd3ixbOUKfU1A8sfP4OrxJlpjYDSdcjR3qI/RcMDwZ1KcUV5waL+5syfc+8
         DJ8lT8NIHAq7B6NLP2L9inFWy9E9jNfRABzyz+4JzLt2uIknj2ZczpKOaw9Em4Tl1aDZ
         RymZms/pv3+3M1ZiSTt+Rfq3tXPIqA3kC+oC0vfVZIue+ACsRqEWvyS46EPUJy4Pi/8j
         Okq/BfbTnuR9qEQiNbcwZ+kBWF1grlvbItp7geUTjK7RexK+/vZ8Er6nEDXga5/GdeQK
         es9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409627; x=1692014427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDEAJSJUMbcZRSLqOZC204RmLR3/sGRUsu91i10Qvh4=;
        b=ZjYG8J5xKgwfSAj7MZl2UD1+uievde+QS+DSENeRnC9MmAOu4/kKREeWdswP18ap6v
         PjWkROoh7OZb1AK5RY13M1R11vGZwqbzcXYZ7w0bAQW7bpt0NcxGstuEu9zqAsUyr/Yu
         xQoBbmeKr1PefHnmZLc2/de3CXq+4897xOAt49DbBlBazDP7ffuq8nkUv2mRVUhZM4ih
         kTumECxgvmBl0hcsj4UR9hOSHHrhuYeGWCgdx3SyOx0QHU0raxaOdn+wHcCqaMBfE6nD
         a01eefSiWe4E09Cex6VPR47wQdutUiRyHW3tQ8l65HxIP9HBPoRR+j2VgzCgBiKSFkJP
         VZkg==
X-Gm-Message-State: AOJu0YwAZDmyQqq/hSwcTwXQnDcsUf15aQ/e4NtvPRCgLOhOfgur2AUm
        258q+REHgCBPNKAM5EGNnggKxsHCro4mTDrtefo=
X-Google-Smtp-Source: AGHT+IHz2j4VZeZ6OLMEdOjbGLip2WVnAv4jsITzwtd3lWkfs5UchJEoHwkFU41ij5WOQ9V0m+xeiQ==
X-Received: by 2002:a05:6a00:178e:b0:67e:6269:6ea8 with SMTP id s14-20020a056a00178e00b0067e62696ea8mr12236463pfg.22.1691409626594;
        Mon, 07 Aug 2023 05:00:26 -0700 (PDT)
Received: from localhost.localdomain ([113.251.7.202])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b00686940bfb77sm6013108pfi.71.2023.08.07.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:00:26 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] docs/zh_TW: update arch
Date:   Mon,  7 Aug 2023 20:00:02 +0800
Message-Id: <20230807120006.6361-3-src.res.211@gmail.com>
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

Update zh_TW's arch documentation concentrating on the following
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
 .../translations/zh_TW/arch/arm/Booting       | 176 +++++++++++
 .../zh_TW/arch/arm/kernel_user_helpers.txt    | 285 ++++++++++++++++++
 .../translations/zh_TW/arch/arm64/amu.rst     |   6 +-
 .../translations/zh_TW/arch/arm64/booting.txt |  26 +-
 .../zh_TW/arch/arm64/elf_hwcaps.rst           |  10 +-
 .../zh_TW/arch/arm64/legacy_instructions.txt  |  14 +-
 .../translations/zh_TW/arch/arm64/memory.txt  |  16 +-
 .../translations/zh_TW/arch/arm64/perf.rst    |   2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt       |  28 +-
 .../zh_TW/arch/arm64/tagged-pointers.txt      |  10 +-
 .../translations/zh_TW/arch/index.rst         |  30 ++
 .../zh_TW/arch/openrisc/index.rst             |  33 ++
 .../zh_TW/arch/openrisc/openrisc_port.rst     | 129 ++++++++
 .../translations/zh_TW/arch/openrisc/todo.rst |  25 ++
 .../zh_TW/arch/parisc/debugging.rst           |  47 +++
 .../translations/zh_TW/arch/parisc/index.rst  |  32 ++
 .../zh_TW/arch/parisc/registers.rst           | 157 ++++++++++
 Documentation/translations/zh_TW/index.rst    |   5 +-
 18 files changed, 973 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/arch/arm/Booting
 create mode 100644 Documentation/translations/zh_TW/arch/arm/kernel_user_helpers.txt
 create mode 100644 Documentation/translations/zh_TW/arch/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/todo.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/debugging.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/registers.rst

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
index f947a6c7369f..80044364208e 100644
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
index 24817b8b70cd..af1bd2d7eec1 100644
--- a/Documentation/translations/zh_TW/arch/arm64/booting.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/booting.txt
@@ -41,7 +41,7 @@ AArch64 異常模型由多個異常級（EL0 - EL3）組成，對於 EL0 和 EL1
 有對應的安全和非安全模式。EL2 是系統管理級，且僅存在於非安全模式下。
 EL3 是最高特權級，且僅存在於安全模式下。
 
-基於本文檔的目的，我們將簡單地使用『引導裝載程序』（『boot loader』）
+基於本文檔的目的，我們將簡單地使用“引導裝載程序”（“boot loader”）
 這個術語來定義在將控制權交給 Linux 內核前 CPU 上執行的所有軟體。
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
index fca3c6ff7b93..b67df8939d60 100644
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
index 3c915df9836c..03e36567ad5f 100644
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
index 2437380a26d8..5d57603aa271 100644
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
index 3b39997a52eb..07b264d70e43 100644
--- a/Documentation/translations/zh_TW/arch/arm64/perf.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/perf.rst
@@ -59,7 +59,7 @@ EL2（VHE 內核 或 non-VHE 虛擬機監控器）。
 
 KVM 客戶機可能運行在 EL0（用戶空間）和 EL1（內核）。
 
-由於宿主機和客戶機之間重疊的異常級別，我們不能僅僅依靠 PMU 的硬體異
+由於宿主機和客戶機之間重疊的異常級別，我們不能僅僅依靠 PMU 的硬件異
 常過濾機制-因此我們必須啓用/禁用對於客戶機進入和退出的計數。而這在
 VHE 和 non-VHE 系統上表現不同。
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
index 66c3a3506458..9d1f49a6b6e7 100644
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
index b7f683f20ed1..fa2fbc4cecad 100644
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
index 000000000000..fd1f0de1b8de
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
+   ../mips/index
+   arm64/index
+   ../riscv/index
+   openrisc/index
+   parisc/index
+   ../loongarch/index
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
index 000000000000..e72b470cf792
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0
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
index 000000000000..cbf4ca74fa23
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/openrisc/todo.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
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
index 000000000000..d74c73557e9b
--- /dev/null
+++ b/Documentation/translations/zh_TW/arch/parisc/debugging.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
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
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index fe0c8b34bafc..411a9323b41d 100644
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
-- 
2.34.1

