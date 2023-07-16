Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056CC754E32
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGPJrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGPJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:47:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1810DA;
        Sun, 16 Jul 2023 02:47:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso2695215a12.1;
        Sun, 16 Jul 2023 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689500844; x=1692092844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvyNRJBQ11pXNQvWgbLUDf2K7q03T5RUswvoa04jxNo=;
        b=RBmpEd22QYG9ra4rAST+5Re4MQK0yyEy5miuDAPQhgMqBgBVjDDguBsNu0Sxz3h9ir
         RzzO/ldU+1G6ETXh1UYBYumC31xx4oxLdnkS3k1KU6Zr9u1LltnhgyN0ZrKOi/ckuwSz
         hQvzsIiK9wlq5Pb+lt6GKeH0jwLpNJmp2LZmc0sErATuBgcf9giiIVcSPHfiOGRPi1mT
         W5HByZ0cUAwNtKBk1NGxzgB7Y/s5YqbAusRj+9sMP1icB71bx1sUuekvf0XQFqz0QsbS
         Z5uayvgMSYok/75ZTBBt8Eza7L/Kqzm+PX1YloulIBaZs/x8K3LnS21yNVaPe3v/Ag2/
         jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689500844; x=1692092844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvyNRJBQ11pXNQvWgbLUDf2K7q03T5RUswvoa04jxNo=;
        b=TFyKE8fI+RzSpNY2ZuBI9t/17S5QTfO5PAYqUeDCId34gBN72C7px6wd1jhGdJFq06
         HeIQp2XKm9BLdMmsm2XqPEzmoI7G4UUTaaUdIdpVWLbtDAaRySoB6kpoOf1OPlVjS650
         ysn2UXG+bJeNjRGxkUhJ6+IiBsE8duLfpWOIE0AKEEeZwatNUmUPmGpwruoP2haXboA7
         iVWkhvrTspjC4I3KWZHvLZt9ecwSrEFKQ+Cf7VzFzAbfy2zIwMM68vg3lsD/4lEs/Itm
         e0G5bphI3uqGa+PDUU66vRIvCt4eQ/i7POAIWroxI9ZOkIvzjar14QjGCDJnW2sppOLA
         a/HA==
X-Gm-Message-State: ABy/qLYdmUxHZ9pky9WeLakBuQNl8a3NCyRFxT5UwDYgdn37/anPDbA/
        JCMBaZ2EkzwJsxaSGc8JrgFnl6xltviYaRoA+vY=
X-Google-Smtp-Source: APBJJlHQPu/jGGuJdII24Cknaab4i5MfhM3haDqNAm5gmg8+m3aMTvSpZUFenQ803Cu+SvXRWz/zRw==
X-Received: by 2002:a17:90b:1885:b0:263:2da2:fe9b with SMTP id mn5-20020a17090b188500b002632da2fe9bmr9086327pjb.21.1689500843314;
        Sun, 16 Jul 2023 02:47:23 -0700 (PDT)
Received: from localhost.localdomain ([113.251.0.121])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a1a0c00b00263dfe1f8d8sm3742150pjk.23.2023.07.16.02.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 02:47:22 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] docs/zh_TW: turn zh_CN's folder references and headers into zh_TW's ones
Date:   Sun, 16 Jul 2023 17:46:53 +0800
Message-Id: <20230716094653.10044-6-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230716094653.10044-1-src.res.211@gmail.com>
References: <20230716094653.10044-1-src.res.211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some contents under zh_TW's translation folder contain folder references
and headers that refer to zh_CN's locations. Hence replace them.

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 .../translations/zh_TW/admin-guide/README.rst |  6 ++--
 .../zh_TW/admin-guide/reporting-issues.rst    | 12 ++++----
 .../admin-guide/reporting-regressions.rst     | 10 +++----
 .../zh_TW/admin-guide/security-bugs.rst       |  2 +-
 .../translations/zh_TW/arch/arm64/booting.txt |  2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt       |  2 +-
 .../translations/zh_TW/process/1.Intro.rst    | 14 +++++-----
 .../translations/zh_TW/process/4.Coding.rst   |  2 +-
 .../translations/zh_TW/process/5.Posting.rst  | 14 +++++-----
 .../zh_TW/process/8.Conclusion.rst            |  4 +--
 .../code-of-conduct-interpretation.rst        |  2 +-
 .../zh_TW/process/coding-style.rst            |  4 +--
 .../translations/zh_TW/process/howto.rst      | 12 ++++----
 .../process/kernel-enforcement-statement.rst  |  4 +--
 .../zh_TW/process/management-style.rst        |  4 +--
 .../zh_TW/process/programming-language.rst    | 28 +++++++++----------
 .../zh_TW/process/stable-kernel-rules.rst     |  2 +-
 .../zh_TW/process/submit-checklist.rst        |  6 ++--
 .../zh_TW/process/submitting-patches.rst      | 16 +++++------
 19 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
index 4cb581f5994a..e132993abce6 100644
--- a/Documentation/translations/zh_TW/admin-guide/README.rst
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -284,12 +284,12 @@ Linux內核6.x版本 <http://kernel.org/>
 -----------
 
 如果您發現了一些可能由於內核缺陷所導致的問題，請參閱：
-Documentation/translations/zh_CN/admin-guide/reporting-issues.rst 。
+Documentation/translations/zh_TW/admin-guide/reporting-issues.rst 。
 
 想要理解內核錯誤報告，請參閱：
-Documentation/translations/zh_CN/admin-guide/bug-hunting.rst 。
+Documentation/translations/zh_TW/admin-guide/bug-hunting.rst 。
 
 更多用GDB調試內核的信息，請參閱：
-Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
+Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst
 和 Documentation/dev-tools/kgdb.rst 。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
index fe5a5a07d51a..ff2d406ab4d5 100644
--- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
@@ -301,7 +301,7 @@ Documentation/admin-guide/reporting-regressions.rst 對此進行了更詳細的
 添加到迴歸跟蹤列表中，以確保它不會被忽略。
 
 什麼是安全問題留給您自己判斷。在繼續之前，請考慮閱讀
-Documentation/translations/zh_CN/admin-guide/security-bugs.rst ，
+Documentation/translations/zh_TW/admin-guide/security-bugs.rst ，
 因爲它提供瞭如何最恰當地處理安全問題的額外細節。
 
 當發生了完全無法接受的糟糕事情時，此問題就是一個“非常嚴重的問題”。例如，
@@ -385,7 +385,7 @@ Linux內核破壞了它處理的數據或損壞了它運行的硬件。當內核
 核未被污染，那麼它應該以“Not infected”結束；如果你看到“Tainted:”且後跟一些
 空格和字母，那就被污染了。
 
-如果你的內核被污染了，請閱讀 Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst
+如果你的內核被污染了，請閱讀 Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
 以找出原因。設法消除污染因素。通常是由以下三種因素之一引起的：
 
  1. 發生了一個可恢復的錯誤（“kernel Oops”），內核污染了自己，因爲內核知道在
@@ -798,7 +798,7 @@ Linux 首席開發者 Linus Torvalds 認爲 Linux 內核永遠不應惡化，這
 重現它。
 
 有一個叫做“二分”的過程可以來尋找變化，這在
-Documentation/translations/zh_CN/admin-guide/bug-bisect.rst 文檔中進行了詳細
+Documentation/translations/zh_TW/admin-guide/bug-bisect.rst 文檔中進行了詳細
 的描述，這個過程通常需要你構建十到二十個內核鏡像，每次都嘗試在構建下一個鏡像
 之前重現問題。是的，這需要花費一些時間，但不用擔心，它比大多數人想象的要快得多。
 多虧了“binary search二分搜索”，這將引導你在源代碼管理系統中找到導致迴歸的提交。
@@ -984,7 +984,7 @@ Documentation/admin-guide/reporting-regressions.rst ；它還提供了大量其
 報告，請將報告的文本轉發到這些地址；但請在報告的頂部加上註釋，表明您提交了
 報告，並附上工單鏈接。
 
-更多信息請參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
+更多信息請參見 Documentation/translations/zh_TW/admin-guide/security-bugs.rst 。
 
 
 發佈報告後的責任
@@ -1198,7 +1198,7 @@ FLOSS 問題報告的人看，詢問他們的意見。同時徵求他們關於
 前一段基本粗略地概述了“二分”方法。一旦報告出來，您可能會被要求做一個正確的
 報告，因爲它允許精確地定位導致問題的確切更改（然後很容易被恢復以快速修復問題）。
 因此如果時間允許，考慮立即進行適當的二分。有關如何詳細信息，請參閱“對迴歸的
-特別關照”部分和文檔 Documentation/translations/zh_CN/admin-guide/bug-bisect.rst 。
+特別關照”部分和文檔 Documentation/translations/zh_TW/admin-guide/bug-bisect.rst 。
 如果成功二分的話，請將“罪魁禍首”的作者添加到收件人中；同時抄送所有在
 signed-off-by鏈中的人，您可以在提交消息的末尾找到。
 
@@ -1217,7 +1217,7 @@ signed-off-by鏈中的人，您可以在提交消息的末尾找到。
 
 即使是微小的、看似明顯的代碼變化，有時也會帶來新的、完全意想不到的問題。穩
 定版和長期支持內核的維護者非常清楚這一點，因此他們只對這些內核進行符合
-Documentation/translations/zh_CN/process/stable-kernel-rules.rst 中所列出的
+Documentation/translations/zh_TW/process/stable-kernel-rules.rst 中所列出的
 規則的修改。
 
 複雜或有風險的修改不符合條件，因此只能應用於主線。其他的修復很容易被回溯到
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst b/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
index d7dcb2a26564..38149b0f6493 100644
--- a/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
@@ -28,7 +28,7 @@ Torvalds立下了此規則並確保它被落實。
    能用，那麼你就碰見迴歸問題了。注意，新內核需要使用類似配置編譯；更多相關細
    節參見下方。
 
-#. 按照 Documentation/translations/zh_CN/admin-guide/reporting-issues.rst 中
+#. 按照 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst 中
    所說的報告你的問題，該文檔已經包含了所有關於迴歸的重要方面，爲了方便起見也
    複製到了下面。兩個重點：在報告主題中使用“[REGRESSION]”開頭並抄送或轉發到
    `迴歸郵件列表 <https://lore.kernel.org/regressions/>`_
@@ -71,7 +71,7 @@ Torvalds立下了此規則並確保它被落實。
 如何報告迴歸？
 ~~~~~~~~~~~~~~
 
-只需按照 Documentation/translations/zh_CN/admin-guide/reporting-issues.rst 中
+只需按照 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst 中
 所說的報告你的問題，該文檔已經包含了要點。下面幾點概述了一下只在迴歸中重要的
 方面：
 
@@ -133,8 +133,8 @@ regzbot發送的每週迴歸報告，可能會出現延遲。 這樣的延誤會
 如何找到罪魁禍首？
 ~~~~~~~~~~~~~~~~~~
 
-如 Documentation/translations/zh_CN/admin-guide/reporting-issues.rst （簡要）
-和 Documentation/translations/zh_CN/admin-guide/bug-bisect.rst （詳細）中所
+如 Documentation/translations/zh_TW/admin-guide/reporting-issues.rst （簡要）
+和 Documentation/translations/zh_TW/admin-guide/bug-bisect.rst （詳細）中所
 述，執行二分。聽起來工作量很大，但大部分情況下很快就能找到罪魁禍首。如果這很
 困難或可靠地重現問題很耗時，請考慮與其他受影響的用戶合作，一起縮小搜索範圍。
 
@@ -364,7 +364,7 @@ Regzbot還支持其他一些主要由開發人員或迴歸追蹤人員使用的
 ..
    如本文件開頭所述，本文以GPL-2.0+或CC-BY-4.0許可發行。如您想僅在CC-BY-4.0許
    可下重分發本文，請用“Linux內核開發者”作爲作者，並用如下鏈接作爲來源：
-   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/translations/zh_CN/admin-guide/reporting-regressions.rst
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
 ..
    注意：本RST文件內容只有在來自Linux內核源代碼時是使用CC-BY-4.0許可的，因爲經
    過處理的版本（如經內核的構建系統）可能包含來自使用更嚴格許可證的文件的內容。
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
index c0e9fc247695..a2e196b3ad6a 100644
--- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -24,7 +24,7 @@ Linux內核開發人員非常重視安全性。因此我們想知道何時發現
 人員那裏獲得額外的幫助，以理解和修復安全漏洞。
 
 與任何缺陷一樣，提供的信息越多，診斷和修復就越容易。如果您不清楚哪些信息有用，
-請查看“Documentation/translations/zh_CN/admin-guide/reporting-issues.rst”中
+請查看“Documentation/translations/zh_TW/admin-guide/reporting-issues.rst”中
 概述的步驟。任何利用漏洞的攻擊代碼都非常有用，未經報告者同意不會對外發布，除
 非已經公開。
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/booting.txt b/Documentation/translations/zh_TW/arch/arm64/booting.txt
index af1bd2d7eec1..80487c86d3eb 100644
--- a/Documentation/translations/zh_TW/arch/arm64/booting.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/booting.txt
@@ -9,7 +9,7 @@ help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
 M:	Will Deacon <will.deacon@arm.com>
-zh_CN:	Fu Wei <wefu@redhat.com>
+zh_TW:	Fu Wei <wefu@redhat.com>
 zh_TW:	Hu Haowen <src.res@email.cn>
 C:	55f058e7574c3615dea4615573a19bdb258696c6
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
index 9d1f49a6b6e7..cdcb3b338cb1 100644
--- a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
@@ -9,7 +9,7 @@ help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
 M:	Will Deacon <will.deacon@arm.com>
-zh_CN:	Fu Wei <wefu@redhat.com>
+zh_TW:	Fu Wei <wefu@redhat.com>
 zh_TW:	Hu Haowen <src.res@email.cn>
 C:	1926e54f115725a9248d0c4c65c22acaf94de4c4
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/process/1.Intro.rst b/Documentation/translations/zh_TW/process/1.Intro.rst
index 53f3f3135d47..a5ac77942bef 100644
--- a/Documentation/translations/zh_TW/process/1.Intro.rst
+++ b/Documentation/translations/zh_TW/process/1.Intro.rst
@@ -26,31 +26,31 @@
 的自動可用性、多種形式的社區支持以及影響內核開發方向的能力。提供給Linux內核
 的代碼必須在與GPL兼容的許可證下可用。
 
-:ref:`cn_development_process` 介紹了開發過程、內核發佈週期和合並窗口的機制。
+:ref:`tw_development_process` 介紹了開發過程、內核發佈週期和合並窗口的機制。
 涵蓋了補丁開發、審查和合並週期中的各個階段。還有一些關於工具和郵件列表的討論？
 鼓勵希望開始內核開發的開發人員跟蹤並修復缺陷以作爲初步練習。
 
 
-:ref:`cn_development_early_stage` 包括項目的早期規劃，重點是儘快讓開發社區
+:ref:`tw_development_early_stage` 包括項目的早期規劃，重點是儘快讓開發社區
 參與進來。
 
-:ref:`cn_development_coding` 是關於編程過程的；介紹了其他開發人員遇到的幾個
+:ref:`tw_development_coding` 是關於編程過程的；介紹了其他開發人員遇到的幾個
 陷阱。也涵蓋了對補丁的一些要求，並且介紹了一些工具，這些工具有助於確保內核
 補丁是正確的。
 
-:ref:`cn_development_posting` 描述發佈補丁以供評審的過程。爲了讓開發社區能
+:ref:`tw_development_posting` 描述發佈補丁以供評審的過程。爲了讓開發社區能
 認真對待，補丁必須被正確格式化和描述，並且必須發送到正確的地方。遵循本節中的
 建議有助於確保您的工作能被較好地接納。
 
-:ref:`cn_development_followthrough` 介紹了發佈補丁之後發生的事情；工作在這時
+:ref:`tw_development_followthrough` 介紹了發佈補丁之後發生的事情；工作在這時
 還遠遠沒有完成。與審閱者一起工作是開發過程中的一個重要部分；本節提供了一些
 關於如何在這個重要階段避免問題的提示。當補丁被合併到主線中時，開發人員要注意
 不要假定任務已經完成。
 
-:ref:`cn_development_advancedtopics` 介紹了兩個“高級”主題：使用Git管理補丁
+:ref:`tw_development_advancedtopics` 介紹了兩個“高級”主題：使用Git管理補丁
 和查看其他人發佈的補丁。
 
-:ref:`cn_development_conclusion` 總結了有關內核開發的更多信息，附帶有相關資源
+:ref:`tw_development_conclusion` 總結了有關內核開發的更多信息，附帶有相關資源
 鏈接。
 
 這個文檔是關於什麼的
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index 96b8c0bd8423..8b7b4a3248c8 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -32,7 +32,7 @@
 ********
 
 內核長期以來都有其標準的代碼風格，如
-:ref:`Documentation/translations/zh_CN/process/coding-style.rst <cn_codingstyle>`
+:ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`
 中所述。在多數時候，該文檔中描述的準則至多被認爲是建議性的。因此，內核中存在
 大量不符合代碼風格準則的代碼。這種代碼的存在會給內核開發人員帶來兩方面的危害。
 
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index caef6e0b31a5..2bd87b8358d5 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -22,8 +22,8 @@
 內核開發社區已經發展出一套用於發佈補丁的約定和過程；遵循這些約定和過程將使
 參與其中的每個人的生活更加輕鬆。本文檔試圖描述這些約定的部分細節；更多信息
 也可在以下文檔中找到
-:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
-和 :ref:`Documentation/translations/zh_CN/process/submit-checklist.rst <cn_submitchecklist>`。
+:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
+和 :ref:`Documentation/translations/zh_TW/process/submit-checklist.rst <tw_submitchecklist>`。
 
 何時寄送
 --------
@@ -154,7 +154,7 @@
 其傳遞給diff。
 
 上面提到的標籤（tag）用於描述各種開發人員如何與這個補丁的開發相關聯。
-:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 文檔中對它們進行了詳細描述；下面是一個簡短的總結。每一行的格式如下：
 
 ::
@@ -165,14 +165,14 @@
 
  - Signed-off-by: 這是一個開發人員的證明，證明他或她有權提交補丁以包含到內核
    中。這表明同意開發者來源認證協議，其全文見
-   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+   :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
    如果沒有合適的簽字，則不能合併到主線中。
 
  - Co-developed-by: 聲明補丁是由多個開發人員共同創建的；當幾個人在一個補丁上
    工作時，它用於給出共同作者（除了 From: 所給出的作者之外）。由於
    Co-developed-by: 表示作者身份，所以每個共同開發人，必須緊跟在相關合作作者
    的Signed-off-by之後。具體內容和示例見以下文件
-   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+   :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 
  - Acked-by: 表示另一個開發人員（通常是相關代碼的維護人員）同意補丁適合包含
    在內核中。
@@ -180,7 +180,7 @@
  - Tested-by: 聲明某人已經測試了補丁並確認它可以工作。
 
  - Reviewed-by: 表示某開發人員已經審查了補丁的正確性；有關詳細信息，請參閱
-   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+   :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 
  - Reported-by: 指定報告此補丁修復的問題的用戶；此標記用於表示感謝。
 
@@ -197,7 +197,7 @@
    無法被另一端接受，並且通常不會進行任何詳細檢查。如果有任何疑問，先把補丁寄
    給你自己，讓你自己確定它是完好無損的。
 
-   :ref:`Documentation/translations/zh_CN/process/email-clients.rst <cn_email_clients>`
+   :ref:`Documentation/translations/zh_TW/process/email-clients.rst <tw_email_clients>`
    提供了一些有用的提示，可以讓特定的郵件客戶端正常發送補丁。
 
  - 你確定你的補丁沒有荒唐的錯誤嗎？您應該始終通過scripts/checkpatch.pl檢查
diff --git a/Documentation/translations/zh_TW/process/8.Conclusion.rst b/Documentation/translations/zh_TW/process/8.Conclusion.rst
index 3ae08a41fd78..cac4b794c84a 100644
--- a/Documentation/translations/zh_TW/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_TW/process/8.Conclusion.rst
@@ -19,9 +19,9 @@
 
 關於Linux內核開發和相關主題的信息來源很多。首先是在內核源代碼分發中找到的
 文檔目錄。頂級
-:ref:`Documentation/translations/zh_CN/process/howto.rst <cn_process_howto>`
+:ref:`Documentation/translations/zh_TW/process/howto.rst <tw_process_howto>`
 文件是一個重要的起點；
-:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 也是所有內核開發人員都應該閱讀的內容。許多內部內核API都是使用kerneldoc機制
 記錄的；“make htmldocs”或“make pdfdocs”可用於以HTML或PDF格式生成這些文檔
 （儘管某些發行版提供的tex版本會遇到內部限制，無法正確處理文檔）。
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
index 70293eb332b9..843ba484abdc 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
@@ -11,7 +11,7 @@
 Linux內核貢獻者契約行爲準則解釋
 ===============================
 
-:ref:`cn_code_of_conduct` 準則是一個通用文檔，旨在爲幾乎所有開源社區提供一套規則。
+:ref:`tw_code_of_conduct` 準則是一個通用文檔，旨在爲幾乎所有開源社區提供一套規則。
 每個開源社區都是獨一無二的，Linux內核也不例外。因此，本文描述了Linux內核社區中
 如何解釋它。我們也不希望這種解釋隨着時間的推移是靜態的，並將根據需要進行調整。
 
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 6c9d4dcbc669..0fe08e03b33a 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -546,7 +546,7 @@ Linux 裏這是提倡的做法，因爲這樣可以很簡單的給讀者提供
 也可以加上它做這些事情的原因。
 
 當註釋內核 API 函數時，請使用 kernel-doc 格式。詳見
-Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
+Documentation/translations/zh_TW/doc-guide/index.rst 和 scripts/kernel-doc 。
 
 長 (多行) 註釋的首選風格是：
 
@@ -819,7 +819,7 @@ dev_info() 等等。對於那些不和某個特定設備相關連的信息，<li
 內核提供了下面的一般用途的內存分配函數：
 kmalloc(), kzalloc(), kmalloc_array(), kcalloc(), vmalloc() 和 vzalloc()。
 請參考 API 文檔以獲取有關它們的詳細信息：
-Documentation/translations/zh_CN/core-api/memory-allocation.rst 。
+Documentation/translations/zh_TW/core-api/memory-allocation.rst 。
 
 傳遞結構體大小的首選形式是這樣的：
 
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 18094c27ad4d..d568903bf51c 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -67,7 +67,7 @@ Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C11標準，但
 Linux內核源代碼都是在GPL（通用公共許可證）的保護下發布的。要了解這種許可
 的細節請查看源代碼主目錄下的COPYING文件。Linux內核許可準則和如何使用
 `SPDX <https://spdx.org/>` 標誌符說明在這個文件中
-:ref:`Documentation/translations/zh_CN/process/license-rules.rst <cn_kernel_licensing>`
+:ref:`Documentation/translations/zh_TW/process/license-rules.rst <tw_kernel_licensing>`
 如果你對它還有更深入問題請聯繫律師，而不要在Linux內核郵件組上提問。因爲
 郵件組裏的人並不是律師，不要期望他們的話有法律效力。
 
@@ -93,12 +93,12 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
   :ref:`Documentation/process/changes.rst <changes>`
     文件給出了用來編譯和使用內核所需要的最小軟件包列表。
 
-  :ref:`Documentation/translations/zh_CN/process/coding-style.rst <cn_codingstyle>`
+  :ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`
     描述Linux內核的代碼風格和理由。所有新代碼需要遵守這篇文檔中定義的規
     範。大多數維護者只會接收符合規定的補丁，很多人也只會幫忙檢查符合風格
     的代碼。
 
-  :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+  :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 
     這兩份文檔明確描述如何創建和發送補丁，其中包括（但不僅限於)：
        - 郵件內容
@@ -117,7 +117,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
 
         https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
-  :ref:`Documentation/translations/zh_CN/process/stable-api-nonsense.rst <cn_stable_api_nonsense>`
+  :ref:`Documentation/translations/zh_TW/process/stable-api-nonsense.rst <tw_stable_api_nonsense>`
     論證內核爲什麼特意不包括穩定的內核內部API，也就是說不包括像這樣的特
     性：
 
@@ -132,7 +132,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
     如果你認爲自己發現了Linux內核的安全性問題，請根據這篇文檔中的步驟來
     提醒其他內核開發者並幫助解決這個問題。
 
-  :ref:`Documentation/translations/zh_CN/process/management-style.rst <cn_managementstyle>`
+  :ref:`Documentation/translations/zh_TW/process/management-style.rst <tw_managementstyle>`
 
     描述內核維護者的工作方法及其共有特點。這對於剛剛接觸內核開發（或者對
     它感到好奇）的人來說很重要，因爲它解釋了很多對於內核維護者獨特行爲的
@@ -335,7 +335,7 @@ MAINTAINERS文件中可以找到不同話題對應的郵件列表。
 這幾行。將你的評論加在被引用的段落之間而不要放在郵件的頂部。
 
 如果你在郵件中附帶補丁，請確認它們是可以直接閱讀的純文本（如
-:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+:ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
 文檔中所述）。內核開發者們不希望遇到附件或者被壓縮了的補丁。只有這樣才能
 保證他們可以直接評論你的每行代碼。請確保你使用的郵件發送程序不會修改空格
 和製表符。一個防範性的測試方法是先將郵件發送給自己，然後自己嘗試是否可以
diff --git a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
index 86d876a5fa0f..519d0f236bfa 100644
--- a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
@@ -1,6 +1,6 @@
-﻿.. _cn_process_statement_kernel:
+﻿.. _tw_process_statement_kernel:
 
-.. include:: ../disclaimer-zh_CN.rst
+.. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
diff --git a/Documentation/translations/zh_TW/process/management-style.rst b/Documentation/translations/zh_TW/process/management-style.rst
index 2d373f71e976..80d5db27a8de 100644
--- a/Documentation/translations/zh_TW/process/management-style.rst
+++ b/Documentation/translations/zh_TW/process/management-style.rst
@@ -31,7 +31,7 @@ Linux內核管理風格
 
 不管怎樣，這裏是：
 
-.. _cn_decisions:
+.. _tw_decisions:
 
 1）決策
 -------
@@ -111,7 +111,7 @@ Linux內核管理風格
 但是，爲了做好作爲內核管理者的準備，最好記住不要燒掉任何橋樑，不要轟炸任何
 無辜的村民，也不要疏遠太多的內核開發人員。事實證明，疏遠人是相當容易的，而
 親近一個疏遠的人是很難的。因此，“疏遠”立即屬於“不可逆”的範疇，並根據
-:ref:`cn_decisions` 成爲絕不可以做的事情。
+:ref:`tw_decisions` 成爲絕不可以做的事情。
 
 這裏只有幾個簡單的規則：
 
diff --git a/Documentation/translations/zh_TW/process/programming-language.rst b/Documentation/translations/zh_TW/process/programming-language.rst
index 591e884dfd58..144bdaf81a41 100644
--- a/Documentation/translations/zh_TW/process/programming-language.rst
+++ b/Documentation/translations/zh_TW/process/programming-language.rst
@@ -11,20 +11,20 @@
 程序設計語言
 ============
 
-內核是用C語言 :ref:`c-language <cn_c-language>` 編寫的。更準確地說，內核通常是用 :ref:`gcc <cn_gcc>`
-在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下編譯的：ISO C11的 GNU 方言
+內核是用C語言 :ref:`c-language <tw_c-language>` 編寫的。更準確地說，內核通常是用 :ref:`gcc <tw_gcc>`
+在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect-options>` 下編譯的：ISO C11的 GNU 方言
 
-這種方言包含對語言 :ref:`gnu-extensions <cn_gnu-extensions>` 的許多擴展，當然，它們許多都在內核中使用。
+這種方言包含對語言 :ref:`gnu-extensions <tw_gnu-extensions>` 的許多擴展，當然，它們許多都在內核中使用。
 
-對於一些體系結構，有一些使用 :ref:`clang <cn_clang>` 和 :ref:`icc <cn_icc>` 編譯內核
+對於一些體系結構，有一些使用 :ref:`clang <tw_clang>` 和 :ref:`icc <tw_icc>` 編譯內核
 的支持，儘管在編寫此文檔時還沒有完成，仍需要第三方補丁。
 
 屬性
 ----
 
-在整個內核中使用的一個常見擴展是屬性（attributes） :ref:`gcc-attribute-syntax <cn_gcc-attribute-syntax>`
+在整個內核中使用的一個常見擴展是屬性（attributes） :ref:`gcc-attribute-syntax <tw_gcc-attribute-syntax>`
 屬性允許將實現定義的語義引入語言實體（如變量、函數或類型），而無需對語言進行
-重大的語法更改（例如添加新關鍵字） :ref:`n2049 <cn_n2049>`
+重大的語法更改（例如添加新關鍵字） :ref:`n2049 <tw_n2049>`
 
 在某些情況下，屬性是可選的（即不支持這些屬性的編譯器仍然應該生成正確的代碼，
 即使其速度較慢或執行的編譯時檢查/診斷次數不夠）
@@ -33,42 +33,42 @@
 ``__attribute__((__pure__))`` ），以檢測可以使用哪些關鍵字和/或縮短代碼, 具體
 請參閱 ``include/linux/compiler_attributes.h``
 
-.. _cn_c-language:
+.. _tw_c-language:
 
 c-language
    http://www.open-std.org/jtc1/sc22/wg14/www/standards
 
-.. _cn_gcc:
+.. _tw_gcc:
 
 gcc
    https://gcc.gnu.org
 
-.. _cn_clang:
+.. _tw_clang:
 
 clang
    https://clang.llvm.org
 
-.. _cn_icc:
+.. _tw_icc:
 
 icc
    https://software.intel.com/en-us/c-compilers
 
-.. _cn_gcc-c-dialect-options:
+.. _tw_gcc-c-dialect-options:
 
 c-dialect-options
    https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
 
-.. _cn_gnu-extensions:
+.. _tw_gnu-extensions:
 
 gnu-extensions
    https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
 
-.. _cn_gcc-attribute-syntax:
+.. _tw_gcc-attribute-syntax:
 
 gcc-attribute-syntax
    https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
 
-.. _cn_n2049:
+.. _tw_n2049:
 
 n2049
    http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
diff --git a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
index 4c66eb448eaa..5da43e010102 100644
--- a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
@@ -36,7 +36,7 @@
   - 沒有“理論上的競爭條件”，除非能給出競爭條件如何被利用的解釋。
   - 不能存在任何的“瑣碎的”修正（拼寫修正，去掉多餘空格之類的）。
   - 必須被相關子系統的維護者接受。
-  - 必須遵循Documentation/translations/zh_CN/process/submitting-patches.rst裏的規則。
+  - 必須遵循Documentation/translations/zh_TW/process/submitting-patches.rst裏的規則。
 
 向穩定版代碼樹提交補丁的過程：
 ------------------------------
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index 004a241ca72a..aa4888dc71ef 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -14,7 +14,7 @@ Linux內核補丁提交清單
 如果開發人員希望看到他們的內核補丁提交更快地被接受，那麼他們應該做一些基本
 的事情。
 
-這些都是在 Documentation/translations/zh_CN/process/submitting-patches.rst
+這些都是在 Documentation/translations/zh_TW/process/submitting-patches.rst
 和其他有關提交Linux內核補丁的文檔中提供的。
 
 1) 如果使用工具，則包括定義/聲明該工具的文件。不要依賴其他頭文件來引入您使用
@@ -37,7 +37,7 @@ Linux內核補丁提交清單
 4) PPC64是一種很好的交叉編譯檢查體系結構，因爲它傾向於對64位的數使用無符號
    長整型。
 
-5) 按 Documentation/translations/zh_CN/process/coding-style.rst 所述檢查您的
+5) 按 Documentation/translations/zh_TW/process/coding-style.rst 所述檢查您的
    補丁是否爲常規樣式。在提交之前使用補丁樣式檢查器 ``scripts/checkpatch.pl``
    檢查是否有輕微的衝突。您應該能夠處理您的補丁中存在的所有
    違規行爲。
@@ -52,7 +52,7 @@ Linux內核補丁提交清單
    回報的。
 
 9) 通過 sparse 清查。
-   （參見 Documentation/translations/zh_CN/dev-tools/sparse.rst ）
+   （參見 Documentation/translations/zh_TW/dev-tools/sparse.rst ）
 
 10) 使用 ``make checkstack`` 和 ``make namespacecheck`` 並修復他們發現的任何
     問題。
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index a3e55a59bc66..256cd8a90b4d 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -24,8 +24,8 @@
 的改動被接受的機會.
 
 本文檔以較爲簡潔的行文給出了大量建議。關於內核開發流程如何進行的詳細信息，
-參見： Documentation/translations/zh_CN/process/development-process.rst 。
-Documentation/translations/zh_CN/process/submit-checklist.rst 給出了一系列
+參見： Documentation/translations/zh_TW/process/development-process.rst 。
+Documentation/translations/zh_TW/process/submit-checklist.rst 給出了一系列
 提交補丁之前要檢查的事項。設備樹相關的補丁，請參閱
 Documentation/devicetree/bindings/submitting-patches.rst 。
 
@@ -161,7 +161,7 @@ xyzzy do frotz”或“[I]changed xyzzy to do frotz”，就好像你在命令
 ----------------
 
 檢查您的補丁是否違反了基本樣式規定，詳細信息參見
-Documentation/translations/zh_CN/process/coding-style.rst
+Documentation/translations/zh_TW/process/coding-style.rst
 中找到。如果不這樣做，只會浪費審閱者的時間，並且會導致你的補丁被拒絕，甚至
 可能沒有被閱讀。
 
@@ -208,7 +208,7 @@ torvalds@linux-foundation.org 。他收到的郵件很多，所以一般來說
 如果您有修復可利用安全漏洞的補丁，請將該補丁發送到 security@kernel.org 。對於
 嚴重的bug，可以考慮短期禁令以允許分銷商（有時間）向用戶發佈補丁；在這種情況下，
 顯然不應將補丁發送到任何公共列表。
-參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
+參見 Documentation/translations/zh_TW/admin-guide/security-bugs.rst 。
 
 修復已發佈內核中嚴重錯誤的補丁程序應該抄送給穩定版維護人員，方法是把以下列行
 放進補丁的籤準區（注意，不是電子郵件收件人）::
@@ -216,7 +216,7 @@ torvalds@linux-foundation.org 。他收到的郵件很多，所以一般來說
   Cc: stable@vger.kernel.org
 
 除了本文件之外，您還應該閱讀
-Documentation/translations/zh_CN/process/stable-kernel-rules.rst 。
+Documentation/translations/zh_TW/process/stable-kernel-rules.rst 。
 
 如果更改影響到用戶側內核接口，請向手冊頁維護人員（如維護人員文件中所列）發送
 手冊頁補丁，或至少發送更改通知，以便一些信息進入手冊頁。還應將用戶空間API
@@ -247,7 +247,7 @@ Linus 和其他的內核開發者需要閱讀和評論你提交的改動。對
 
 例外：如果你的郵路損壞了補丁，那麼有人可能會要求你使用MIME重新發送補丁。
 
-請參閱 Documentation/translations/zh_CN/process/email-clients.rst
+請參閱 Documentation/translations/zh_TW/process/email-clients.rst
 以獲取有關配置電子郵件客戶端以使其不受影響地發送補丁的提示。
 
 回覆審閱意見
@@ -442,7 +442,7 @@ Fixes: 指示補丁修復了之前提交的一個問題。它可以便於確定
 
   附加Fixes:標籤不會改變穩定內核規則流程，也不改變所有穩定版補丁抄送
   stable@vger.kernel.org的要求。有關更多信息，請閱讀
-  Documentation/translations/zh_CN/process/stable-kernel-rules.rst 。
+  Documentation/translations/zh_TW/process/stable-kernel-rules.rst 。
 
 .. _zh_the_canonical_patch_format:
 
@@ -646,7 +646,7 @@ Greg Kroah-Hartman，“如何惹惱內核子系統維護人員”
 不！！！別再發巨型補丁炸彈給linux-kernel@vger.kernel.org的人們了！
   <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
-內核 Documentation/translations/zh_CN/process/coding-style.rst
+內核 Documentation/translations/zh_TW/process/coding-style.rst
 
 Linus Torvalds關於標準補丁格式的郵件
   <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
-- 
2.34.1

