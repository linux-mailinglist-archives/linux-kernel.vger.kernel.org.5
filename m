Return-Path: <linux-kernel+bounces-124706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417DA891BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53BC1F25DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14561327ED;
	Fri, 29 Mar 2024 12:36:14 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785614387F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715774; cv=none; b=iKQWGSXleHvKem2IMD4fS2tVEkRewW0DJ7DTFaq7rsMfTcMaDX4k578PVBZIle+6mYf/IXLB6wvDcmwq7i7QLjY/t9OMttw6mNqtuZiS123oHM6qWqPXvtnNo77HCGcMRdD/O9nPQpWKDHki/O+WerZmukWteQcKyhjgrQg0Pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715774; c=relaxed/simple;
	bh=WqAHVDbRSQlXSs3fhY+o+tngUEP/W8dgzeNBIhNbb1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UL8LCkNjDvlNdTL/0FFa4MCC6N6ZW3+s760SByd7vhSPaWRiY2y7W0GdjG3h9He0IaAkHn4CS2p2NRxPN4E3Kn2YiZjfMlYMFHjnfWK5vsmBfiLWmHPn1MAxogPQXT61avCyDkF7jAfPdOl4GQWw5JBe0q9LXH0yISvli5mOpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id 4cc82C0050SSLxL01cc8x9; Fri, 29 Mar 2024 13:36:09 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rqBSR-005D9J-5k;
	Fri, 29 Mar 2024 13:36:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rqBSq-0020YW-5y;
	Fri, 29 Mar 2024 13:36:08 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs/zh: Fix Cc, Co-developed-by, and Signed-off-by tags
Date: Fri, 29 Mar 2024 13:35:29 +0100
Message-Id: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The updates from commit ae67ee6c5e1d5b6a ("docs: fix Co-Developed-by
docs") in v5.0 were never applied to the Chinese translations.
In addition:
  - "Cc" used wrong case,
  - "Co-developed-by" lacked a dash,
  - "Signed-off-by" was misspelled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../translations/zh_CN/process/submitting-patches.rst     | 8 ++++----
 .../translations/zh_TW/process/submitting-patches.rst     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index f8978f02057c164c..7864107e60a85c58 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -333,10 +333,10 @@ Linus 和其他的内核开发者需要阅读和评论你提交的改动。对
 未参与其开发。签署链应当反映补丁传播到维护者并最终传播到Linus所经过的 **真实**
 路径，首个签署指明单个作者的主要作者身份。
 
-何时使用Acked-by:，CC:，和Co-Developed by:
+何时使用Acked-by:，Cc:，和Co-developed-by:
 ------------------------------------------
 
-Singed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
+Signed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
 
 如果一个人没有直接参与补丁的准备或处理，但希望表示并记录他们对补丁的批准/赞成，
 那么他们可以要求在补丁的变更日志中添加一个Acked-by:。
@@ -358,8 +358,8 @@ Acked-by：不一定表示对整个补丁的确认。例如，如果一个补丁
 Co-developed-by: 声明补丁是由多个开发人员共同创建的；当几个人在一个补丁上工
 作时，它用于给出共同作者（除了From:所给出的作者之外）。因为Co-developed-by:
 表示作者身份，所以每个Co-developed-by:必须紧跟在相关合作作者的签署之后。标准
-签署程序要求Singed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
-过From:还是Co-developed-by:表明。值得注意的是，最后一个Singed-off-by:必须是
+签署程序要求Signed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
+过From:还是Co-developed-by:表明。值得注意的是，最后一个Signed-off-by:必须是
 提交补丁的开发人员。
 
 注意，如果From:作者也是电子邮件标题的From:行中列出的人，则From:标签是可选的。
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index 99fa0f2fe6f414e1..f12f2f193f855cfb 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -334,10 +334,10 @@ Linus 和其他的內核開發者需要閱讀和評論你提交的改動。對
 未參與其開發。簽署鏈應當反映補丁傳播到維護者並最終傳播到Linus所經過的 **真實**
 路徑，首個簽署指明單個作者的主要作者身份。
 
-何時使用Acked-by:，CC:，和Co-Developed by:
+何時使用Acked-by:，Cc:，和Co-developed-by:
 ------------------------------------------
 
-Singed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
+Signed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
 
 如果一個人沒有直接參與補丁的準備或處理，但希望表示並記錄他們對補丁的批准/贊成，
 那麼他們可以要求在補丁的變更日誌中添加一個Acked-by:。
@@ -359,8 +359,8 @@ Acked-by：不一定表示對整個補丁的確認。例如，如果一個補丁
 Co-developed-by: 聲明補丁是由多個開發人員共同創建的；當幾個人在一個補丁上工
 作時，它用於給出共同作者（除了From:所給出的作者之外）。因爲Co-developed-by:
 表示作者身份，所以每個Co-developed-by:必須緊跟在相關合作作者的簽署之後。標準
-簽署程序要求Singed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
-過From:還是Co-developed-by:表明。值得注意的是，最後一個Singed-off-by:必須是
+簽署程序要求Signed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
+過From:還是Co-developed-by:表明。值得注意的是，最後一個Signed-off-by:必須是
 提交補丁的開發人員。
 
 注意，如果From:作者也是電子郵件標題的From:行中列出的人，則From:標籤是可選的。
-- 
2.34.1


