Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C7772350
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHGMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHGMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D710E10E0;
        Mon,  7 Aug 2023 05:00:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-68706d67ed9so3004638b3a.2;
        Mon, 07 Aug 2023 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691409630; x=1692014430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAcMAkOEEJOMPamUrjBYhNdogwU9IE1IaXVm3ZpGv80=;
        b=SU4YU2mOQ6oTpPOIxSgtboG7UzhWHhVxG+nN0nQZF0EL7chmFAwM7GpkQ2Z7xF2tRk
         FHOn2qfWNV5Neo4/PXySrJ2FRadtFhTfPvTVJ3GMnO0sAsnqaI+79h9FHkN1PIILnPFz
         n4ykhzwYY1FvMkfdX6m3GhLdwdoGIY+AhPSg4a64SxMRKdxoe7hTn+ekMPEnsAu21jNb
         veVbC5zi7v0cREt9W7tfisjM2530h/z5goFmsn2BUvgnfub28jzoOzjJqK4MLmwWj31v
         W+yKncb0v3pMDaDQtbLgkUVLo+7m4Lru3StCwgymhMB4uQwCTRNhKdhBKYLIS215X0Vg
         SNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409630; x=1692014430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAcMAkOEEJOMPamUrjBYhNdogwU9IE1IaXVm3ZpGv80=;
        b=gZwDR1LhY+6d8ZbzDQ2CpoDR1Uss7RKNf5goF+inzei1/nWUrZr4prPpCBh6m/qru4
         psMdMHenc8AQ9y5mxR/jqhV8d7E0djrf9GG/FTy0hhnwdiB63YrC38KZV264rpn/EQaS
         t6OsgEuktiXS89L64sIfMaVqp6vYta4JUTSY6tONo2avGOlUPEcpi9Oa23NOzzM6NAfI
         wZRgaSz3Ah0pIl4GI9D8lX+zMyXZ/+Wd7JN4Mf5YQBB58Ewm8j0es+VuhfDCmPP2S5lg
         nSTzvXxs7zA4ICuBAvaSOBJIn0jhr/frBCGzzjaIucEwFw8Ld0rtBt4nDt56cJYzD4X5
         i1fQ==
X-Gm-Message-State: AOJu0YxC1YGjqxc+WvGRIFq7EHSYdUkSsz15R86iS/qtxbtQjRfWuX7D
        q18W06MCQE/VqHhARMdzCxk=
X-Google-Smtp-Source: AGHT+IFZSP29bxarmYXaIIsYf+6opK+zkOBNhmpCFXYXdidTMIxFcz3j0bddoRPZRpvqAIgv/8+DNg==
X-Received: by 2002:a05:6a20:3b1d:b0:140:48d4:8199 with SMTP id c29-20020a056a203b1d00b0014048d48199mr4808556pzh.24.1691409629800;
        Mon, 07 Aug 2023 05:00:29 -0700 (PDT)
Received: from localhost.localdomain ([113.251.7.202])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b00686940bfb77sm6013108pfi.71.2023.08.07.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:00:29 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] docs/zh_TW: update cpu-freq
Date:   Mon,  7 Aug 2023 20:00:03 +0800
Message-Id: <20230807120006.6361-4-src.res.211@gmail.com>
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

Update zh_TW's cpu-freq documentation concentrating on the following
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
 .../translations/zh_TW/cpu-freq/core.rst      |  26 ++--
 .../zh_TW/cpu-freq/cpu-drivers.rst            | 147 +++++++++---------
 .../zh_TW/cpu-freq/cpufreq-stats.rst          |  41 +++--
 .../translations/zh_TW/cpu-freq/index.rst     |   4 +-
 4 files changed, 108 insertions(+), 110 deletions(-)

diff --git a/Documentation/translations/zh_TW/cpu-freq/core.rst b/Documentation/translations/zh_TW/cpu-freq/core.rst
index 3d890c2f2a61..20ec33aa98e4 100644
--- a/Documentation/translations/zh_TW/cpu-freq/core.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/core.rst
@@ -29,10 +29,10 @@ CPUFreq核心和CPUFreq通知器的通用說明
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
@@ -41,10 +41,10 @@ cpufreq策略的引用計數由 cpufreq_cpu_get 和 cpufreq_cpu_put 來完成，
 2. CPUFreq 通知器
 ====================
 
-CPUFreq通知器符合標準的內核通知器接口。
+CPUFreq通知器遵循標準的內核通知器接口。
 關於通知器的細節請參閱 linux/include/linux/notifier.h。
 
-這裡有兩個不同的CPUfreq通知器 - 策略通知器和轉換通知器。
+這裏有兩個不同的CPUfreq通知器 - 策略通知器和轉換通知器。
 
 
 2.1 CPUFreq策略通知器
@@ -62,27 +62,27 @@ CPUFreq通知器符合標準的內核通知器接口。
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
 
@@ -101,7 +101,7 @@ dev_pm_opp_init_cpufreq_table -
 
 	.. note::
 
-		該函數只有在CONFIG_PM_OPP之外還啓用了CONFIG_CPU_FREQ時才可用。
+		該函數只有在CONFIG_PM_OPP之外還啓用了CONFIG_CPU_FREQ時纔可用。
 
 dev_pm_opp_free_cpufreq_table
 	釋放dev_pm_opp_init_cpufreq_table分配的表。
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
index 2bb8197cd320..40b56259cf72 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -37,15 +37,15 @@
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
@@ -59,11 +59,11 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
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
@@ -72,18 +72,18 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
 
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
@@ -94,95 +94,93 @@ CPUfreq核心層註冊一個cpufreq_driver結構體。
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
@@ -196,51 +194,52 @@ CPUfreq驅動在調用這裡時必須設置新的頻率。實際的頻率必須
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
 
@@ -251,6 +250,6 @@ cpufreq_for_each_valid_entry(pos, table) - 該函數遍歷所有條目，不包
 		pos->frequency = ...
 	}
 
-如果你需要在driver_freq_table中處理pos的位置，不要減去指針，因爲它的代價相當高。相反，使用宏
+如果你需要在driver_freq_table中處理pos的位置，不要做指針減法，因爲它的代價相當高。作爲替代，使用宏
 cpufreq_for_each_entry_idx() 和 cpufreq_for_each_valid_entry_idx() 。
 
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
index d80bfed50e8c..f8d0d462f29a 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
@@ -13,7 +13,7 @@
 sysfs CPUFreq Stats的一般說明
 ==========================================
 
-用戶信息
+爲使用者準備的信息
 
 
 作者: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -28,17 +28,16 @@ sysfs CPUFreq Stats的一般說明
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
@@ -47,8 +46,8 @@ cpufreq stats提供了以下統計數據（在下面詳細解釋）。
 -  total_trans
 -  trans_table
 
-所有的統計數據將從統計驅動被載入的時間（或統計被重置的時間）開始，到某一統計數據被讀取的時間爲止。
-顯然，統計驅動不會有任何關於統計驅動載入之前的頻率轉換信息。
+所有統計數據來自以下時間範圍：從統計驅動被加載的時間（或統計數據被重置的時間）開始，到某一統計數據被讀取的時間爲止。
+顯然，統計驅動不會保存它被加載之前的任何頻率轉換信息。
 
 ::
 
@@ -63,14 +62,14 @@ cpufreq stats提供了以下統計數據（在下面詳細解釋）。
 
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
 
@@ -84,7 +83,7 @@ usertime單位是10mS（類似於/proc中輸出的其他時間）。
 
 - **total_trans**
 
-給出了這個CPU上頻率轉換的總次數。cat的輸出將有一個單一的計數，這就是頻率轉換的總數。
+此文件給出了這個CPU頻率轉換的總次數。cat的輸出是一個計數值，它就是頻率轉換的總次數。
 
 ::
 
@@ -93,10 +92,10 @@ usertime單位是10mS（類似於/proc中輸出的其他時間）。
 
 - **trans_table**
 
-這將提供所有CPU頻率轉換的細粒度信息。這裡的cat輸出是一個二維矩陣，其中一個條目<i, j>（第
+本文件提供所有CPU頻率轉換的細粒度信息。這裏的cat輸出是一個二維矩陣，其中一個條目<i, j>（第
 i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列遵循驅動最初提供給cpufreq
-核的頻率表的排序順序，因此可以排序（升序或降序）或不排序。 這裡的輸出也包含了每行每列的實際
-頻率值，以便更好地閱讀。
+核心的頻率表的排列順序，因此可以已排序（升序或降序）或未排序。這裏的輸出也包含了實際
+頻率值，分別按行和按列顯示，以便更好地閱讀。
 
 如果轉換表大於PAGE_SIZE，讀取時將返回一個-EFBIG錯誤。
 
@@ -114,7 +113,7 @@ i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列
 3. 配置cpufreq-stats
 ============================
 
-要在你的內核中配置cpufreq-stats::
+按以下方式在你的內核中配置cpufreq-stats::
 
 	Config Main Menu
 		Power management options (ACPI, APM)  --->
@@ -123,7 +122,7 @@ i行，第j列）代表從Freq_i到Freq_j的轉換次數。Freq_i行和Freq_j列
 				[*]   CPU frequency translation statistics
 
 
-"CPU Frequency scaling" (CONFIG_CPU_FREQ) 應該被啓用以配置cpufreq-stats。
+"CPU Frequency scaling" (CONFIG_CPU_FREQ) 應該被啓用，以支持配置cpufreq-stats。
 
 "CPU frequency translation statistics" (CONFIG_CPU_FREQ_STAT)提供了包括
 time_in_state、total_trans和trans_table的統計數據。
diff --git a/Documentation/translations/zh_TW/cpu-freq/index.rst b/Documentation/translations/zh_TW/cpu-freq/index.rst
index 1a8e680f95ed..ce717dd6dcd5 100644
--- a/Documentation/translations/zh_TW/cpu-freq/index.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/index.rst
@@ -28,10 +28,10 @@ Author: Dominik Brodowski  <linux@brodo.de>
 
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
-- 
2.34.1

