Return-Path: <linux-kernel+bounces-43729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82984186E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAE1C228DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE79383A1;
	Tue, 30 Jan 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMLXVbn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC4381CD;
	Tue, 30 Jan 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578563; cv=none; b=AVD+zP9tq4hsX2RZxWG8FEEqT2Ign/Oz2OkWLJppoNif1fKNvaS7WGqtc+m9A9u0vlMGIkfQwUM/gSZp6n7xZlw+971Wd43h+JDp/17wy7XMXQ7bm01fhXA3AFlSeMVY9YrAebRnYaKcBPZ+Hs+2nNU8JUXFLwSa+o5+heptQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578563; c=relaxed/simple;
	bh=7bWBPmCSHdznVFxRyJOlll8Hcrn56ik2cXlXDedGAEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7+tMMFuxB/QLO9wFMTyuUuxUpROUnFbcZP7HG0xwVbz+ihiAio7q9hsgyrntBquez7RDypwU51qL6inP5c1HaFMqp1ZcWJ10MZtDAsygkQzcZr4ODaHH52kZAL6g29SUl/9r+CEIzYlG91+HO6cuQTY+RHy/gunduyeDK5Mzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMLXVbn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F719C433C7;
	Tue, 30 Jan 2024 01:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578562;
	bh=7bWBPmCSHdznVFxRyJOlll8Hcrn56ik2cXlXDedGAEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMLXVbn3ikYp3m99vFuBEfXugsLp/lFqkGEhNptQNvOhTNQW87unjfKJvX8DrujH5
	 RxrCI6TC5M9lJ4qMyyMwzuq4h6fxlRUnMW1nkvwNbdmezIHH9eRDnKhn4wsTvjl0wR
	 VVeDyZdTcnRWdWZokAXliSsehfMY6kDl+BZxyQElXe8/JjexD4ihBeaIdzxrr+VhP0
	 hfkwY+4kDPPkMjQ0Q1WSEEYEgCF/pd3AF1mO4WXlBts6/3Cg9jlw2EC9iGCPArcpAa
	 f+v0NUYK0rrGl6SZF7nqnX4RwBSet0dGeI5tMTaXvuFL4gZBsvdLzRn8+5CkaJehky
	 U1FmAQQYOUocA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] Docs/translations/damon/usage: update for monitor_on renaming
Date: Mon, 29 Jan 2024 17:35:48 -0800
Message-Id: <20240130013549.89538-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON debugfs interface sections on the translated usage
documents to reflect the fact that 'monitor_on' file has renamed to
'monitor_on_DEPRECATED'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 20 +++++++++----------
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 20 +++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
index 17b9949d9b43..da2745464ece 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
@@ -344,7 +344,7 @@ debugfs接口
   :ref:`sysfs接口<sysfs_interface>`。
 
 DAMON导出了八个文件, ``attrs``, ``target_ids``, ``init_regions``,
-``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` 和
+``schemes``, ``monitor_on_DEPRECATED``, ``kdamond_pid``, ``mk_contexts`` 和
 ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
 
 
@@ -521,15 +521,15 @@ DAMON导出了八个文件, ``attrs``, ``target_ids``, ``init_regions``,
 开关
 ----
 
-除非你明确地启动监测，否则如上所述的文件设置不会产生效果。你可以通过写入和读取 ``monitor_on``
+除非你明确地启动监测，否则如上所述的文件设置不会产生效果。你可以通过写入和读取 ``monitor_on_DEPRECATED``
 文件来启动、停止和检查监测的当前状态。写入 ``on`` 该文件可以启动对有属性的目标的监测。写入
 ``off`` 该文件则停止这些目标。如果每个目标进程被终止，DAMON也会停止。下面的示例命令开启、关
 闭和检查DAMON的状态::
 
     # cd <debugfs>/damon
-    # echo on > monitor_on
-    # echo off > monitor_on
-    # cat monitor_on
+    # echo on > monitor_on_DEPRECATED
+    # echo off > monitor_on_DEPRECATED
+    # cat monitor_on_DEPRECATED
     off
 
 请注意，当监测开启时，你不能写到上述的debugfs文件。如果你在DAMON运行时写到这些文件，将会返
@@ -543,11 +543,11 @@ DAMON通过一个叫做kdamond的内核线程来进行请求监测。你可以
 得该线程的 ``pid`` 。当监测被 ``关闭`` 时，读取该文件不会返回任何信息::
 
     # cd <debugfs>/damon
-    # cat monitor_on
+    # cat monitor_on_DEPRECATED
     off
     # cat kdamond_pid
     none
-    # echo on > monitor_on
+    # echo on > monitor_on_DEPRECATED
     # cat kdamond_pid
     18594
 
@@ -574,7 +574,7 @@ DAMON通过一个叫做kdamond的内核线程来进行请求监测。你可以
     # ls foo
     # ls: cannot access 'foo': No such file or directory
 
-注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on`` 文件只在根目录下。
+注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on_DEPRECATED`` 文件只在根目录下。
 
 
 监测结果的监测点
@@ -583,9 +583,9 @@ DAMON通过一个叫做kdamond的内核线程来进行请求监测。你可以
 DAMON通过一个tracepoint ``damon:damon_aggregated`` 提供监测结果.  当监测开启时，你可
 以记录追踪点事件，并使用追踪点支持工具如perf显示结果。比如说::
 
-    # echo on > monitor_on
+    # echo on > monitor_on_DEPRECATED
     # perf record -e damon:damon_aggregated &
     # sleep 5
     # kill 9 $(pidof perf)
-    # echo off > monitor_on
+    # echo off > monitor_on_DEPRECATED
     # perf script
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
index 6dee719a32ea..7464279f9b7d 100644
--- a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
@@ -344,7 +344,7 @@ debugfs接口
   :ref:`sysfs接口<sysfs_interface>`。
 
 DAMON導出了八個文件, ``attrs``, ``target_ids``, ``init_regions``,
-``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` 和
+``schemes``, ``monitor_on_DEPRECATED``, ``kdamond_pid``, ``mk_contexts`` 和
 ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
 
 
@@ -521,15 +521,15 @@ DAMON導出了八個文件, ``attrs``, ``target_ids``, ``init_regions``,
 開關
 ----
 
-除非你明確地啓動監測，否則如上所述的文件設置不會產生效果。你可以通過寫入和讀取 ``monitor_on``
+除非你明確地啓動監測，否則如上所述的文件設置不會產生效果。你可以通過寫入和讀取 ``monitor_on_DEPRECATED``
 文件來啓動、停止和檢查監測的當前狀態。寫入 ``on`` 該文件可以啓動對有屬性的目標的監測。寫入
 ``off`` 該文件則停止這些目標。如果每個目標進程被終止，DAMON也會停止。下面的示例命令開啓、關
 閉和檢查DAMON的狀態::
 
     # cd <debugfs>/damon
-    # echo on > monitor_on
-    # echo off > monitor_on
-    # cat monitor_on
+    # echo on > monitor_on_DEPRECATED
+    # echo off > monitor_on_DEPRECATED
+    # cat monitor_on_DEPRECATED
     off
 
 請注意，當監測開啓時，你不能寫到上述的debugfs文件。如果你在DAMON運行時寫到這些文件，將會返
@@ -543,11 +543,11 @@ DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以
 得該線程的 ``pid`` 。當監測被 ``關閉`` 時，讀取該文件不會返回任何信息::
 
     # cd <debugfs>/damon
-    # cat monitor_on
+    # cat monitor_on_DEPRECATED
     off
     # cat kdamond_pid
     none
-    # echo on > monitor_on
+    # echo on > monitor_on_DEPRECATED
     # cat kdamond_pid
     18594
 
@@ -574,7 +574,7 @@ DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以
     # ls foo
     # ls: cannot access 'foo': No such file or directory
 
-注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on`` 文件只在根目錄下。
+注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on_DEPRECATED`` 文件只在根目錄下。
 
 
 監測結果的監測點
@@ -583,10 +583,10 @@ DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以
 DAMON通過一個tracepoint ``damon:damon_aggregated`` 提供監測結果.  當監測開啓時，你可
 以記錄追蹤點事件，並使用追蹤點支持工具如perf顯示結果。比如說::
 
-    # echo on > monitor_on
+    # echo on > monitor_on_DEPRECATED
     # perf record -e damon:damon_aggregated &
     # sleep 5
     # kill 9 $(pidof perf)
-    # echo off > monitor_on
+    # echo off > monitor_on_DEPRECATED
     # perf script
 
-- 
2.39.2


