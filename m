Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35E772351
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjHGMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjHGMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C2DE5A;
        Mon,  7 Aug 2023 05:00:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-686f0d66652so4219953b3a.2;
        Mon, 07 Aug 2023 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691409633; x=1692014433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOTT3ocs5JS/M9oY/Qz6qPTtcZIfhKxiBJT+VKUnYUM=;
        b=Wv0SnLYdusLUjLeSDaiXZ59LVe474seqZoAdL5s88eRgqDX6v4xAAIFdb5Br1xfJuB
         yr3EbNL1wnXdvPRP+bgnY0HjF4ZBUt3NuNb4CBqyz7BdmPCcukLHOtwyUMc1/dkJ0hoC
         zf5az6B8DkhkYj6dZYNfS3TMAKkItJqa0C6k48bgU1/xoHy3+wMeStwvyuP3uftltjBM
         kiT8DxAFZw+8U1dlkqzsbliivG7pEsXAUK+dSr83ed3gDYB6VyNPxeqBjXVbuvjt45N2
         pzTtFMf1gxERr/nR4tbymXABt9tyVIVuLLTpp+n9nrAUFfrSe/6WEOpSU6iWePuqQeCP
         8UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409633; x=1692014433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOTT3ocs5JS/M9oY/Qz6qPTtcZIfhKxiBJT+VKUnYUM=;
        b=TCqoUyhukRZuzcSkQJc/0Bv5kqaKeOaFSX8fuwuaytefcZPVRQA69uhyfDD0xZGc4W
         XuMXYNeIk43XRoiHK/Lc/TW0wKGZ5mxjT99wq614w9XrtIioGjaiZGSxbdNxhoWqzHMx
         SsYm0OiqniAVRh6V3cwfZvofxtaMVJ7Te3fo7t3JaYfmLPvq9kmYGWRX+U/+pU6U9mR+
         o8m6qrqZR6/vRef7XrZ0wcWdkC2ZMIG57qMG0pfc7c95dp3Wn7+jkiJqrBLhQUvjhFLZ
         E7E867cqHFw6QXA7kZNNle1P0SYG+m6+3tujNu/GuCwX4aMM0mRRapTb9mSOd3vjqlQ/
         a8yQ==
X-Gm-Message-State: AOJu0YzHPQluRImSmtflYIuCtc76LQma/XM6t+oY9Nn/8q7HnqO6Oc4f
        DkVnoBYbW+x+JGTm8xuuZKc=
X-Google-Smtp-Source: AGHT+IGKdQqMSBFweOC3eBnmzOyTGDnO4n8wn5aOc+c9PlOhvC/wwJmV61lrREviQeRT5p+rK65onA==
X-Received: by 2002:a05:6a20:3ca4:b0:133:e31f:e7d6 with SMTP id b36-20020a056a203ca400b00133e31fe7d6mr12539960pzj.55.1691409632946;
        Mon, 07 Aug 2023 05:00:32 -0700 (PDT)
Received: from localhost.localdomain ([113.251.7.202])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b00686940bfb77sm6013108pfi.71.2023.08.07.05.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:00:32 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] docs/zh_TW: update filesystems
Date:   Mon,  7 Aug 2023 20:00:04 +0800
Message-Id: <20230807120006.6361-5-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807120006.6361-1-src.res.211@gmail.com>
References: <20230807120006.6361-1-src.res.211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update zh_TW's filesystems documentation concentrating on the following
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
 .../zh_TW/filesystems/debugfs.rst             | 38 +++++++++----------
 .../translations/zh_TW/filesystems/index.rst  |  2 +-
 .../translations/zh_TW/filesystems/sysfs.txt  | 16 ++++----
 .../translations/zh_TW/filesystems/tmpfs.rst  | 32 ++++++++--------
 .../zh_TW/filesystems/virtiofs.rst            |  8 ++--
 5 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/Documentation/translations/zh_TW/filesystems/debugfs.rst b/Documentation/translations/zh_TW/filesystems/debugfs.rst
index 270dd94fddf1..45347ae1ccd2 100644
--- a/Documentation/translations/zh_TW/filesystems/debugfs.rst
+++ b/Documentation/translations/zh_TW/filesystems/debugfs.rst
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
index 4e5dde0dca3c..415abfe327c1 100644
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
index 280824cc7e5d..a401739d0914 100644
--- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
@@ -1,5 +1,3 @@
-SPDX-License-Identifier: GPL-2.0
-
 Chinese translated version of Documentation/filesystems/sysfs.rst
 
 If you have any comment or update to the content, please contact the
@@ -61,7 +59,7 @@ Documentation/core-api/kobject.rst 文檔以獲得更多關於 kobject 接口的
 
 任何 kobject 在系統中註冊，就會有一個目錄在 sysfs 中被創建。這個
 目錄是作爲該 kobject 的父對象所在目錄的子目錄創建的，以準確地傳遞
-內核的對象層次到用戶空間。sysfs 中的頂層目錄代表著內核對象層次的
+內核的對象層次到用戶空間。sysfs 中的頂層目錄代表着內核對象層次的
 共同祖先；例如：某些對象屬於某個子系統。
 
 Sysfs 在與其目錄關聯的 kernfs_node 對象中內部保存一個指向實現
@@ -198,7 +196,7 @@ Sysfs 將會爲每次讀寫操作調用一次這個方法。這使得這些方
   不會不太高。
 
   這使得用戶空間可以局部地讀和任意的向前搜索整個文件。如果用戶空間
-  向後搜索到零或使用『0』偏移執行一個pread(2)操作，show()方法將
+  向後搜索到零或使用‘0’偏移執行一個pread(2)操作，show()方法將
   再次被調用，以重新填充緩存。
 
 - 在寫方面（write(2)），sysfs 希望在第一次寫操作時得到整個緩衝區。
@@ -253,7 +251,7 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
 
 （注意：真正的實現不允許用戶空間設置設備名。）
 
-頂層目錄布局
+頂層目錄佈局
 ~~~~~~~~~~~~
 
 sysfs 目錄的安排顯示了內核數據結構之間的關係。
@@ -272,23 +270,23 @@ fs/
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
index 8d753a34785b..16c188436b41 100644
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
index 2b05e84375dd..05274d9e0843 100644
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
 
 
-- 
2.34.1

