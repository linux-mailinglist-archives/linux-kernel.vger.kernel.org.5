Return-Path: <linux-kernel+bounces-19831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577BE8274DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B31B2293E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488D5466D;
	Mon,  8 Jan 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="hfeYGviL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460A5465D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 69C9D24002A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:16:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704730603; bh=i725bwQMCd01Orv6abs3xlOUBm43RkTh68m2tAj/kj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=hfeYGviLiV5nx/uAlkvRGMTGX57uSbquPKBtr/ZgxfNC4h/zg3HehsAI9u89pKG7v
	 2m8Gap1ZTW3DHpYKKanAAOk8BCerOUsNwYgLp9BEcBr2yHAbOg4WLhOxhuo4jcdTm7
	 mFWIvq11IYy0J8INb8s97LsTaVredjltf0cchw8ibyHWtwnFktpb+TXLyI7hUe1qn2
	 jUaXYDFraMUJgdfkuN4WtEkXh7YFDwR1Z77jgs14GEt31F5+8/6WrPND16+wt0Ibky
	 HmjB0WJhab6OPDyMymuIv33BcKpkXMvrq/xf7TgoIgclpd6YB3qo1dB3l+68hDuF3F
	 xEYRvGAt1p3og==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T7zhn114nz9rxS;
	Mon,  8 Jan 2024 17:16:40 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Hu Haowen <src.res.211@gmail.com>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] doc/zh_TW: coding-style: update content for section 18
Date: Mon,  8 Jan 2024 16:03:24 +0000
Message-ID: <20240108160746.177421-4-shamrocklee@posteo.net>
In-Reply-To: <20240108160746.177421-1-shamrocklee@posteo.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108160746.177421-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the content of the zh_TW translation of "Linux kernel coding
style" section 18, following the change proposed in the first 2 patches
in these patch series.

From the diff of between the zh_TW and zh_CN translation of the file
coding-style.rst, it seems that the zh_TW files are direct
character-by-character translation of the zh_CN files, without any
phrase localization. This results in wording unfamilliar to zh_TW
speakers.

This patch reuses existing terms inside coding-style.rst (e.g. 宏 for
"macros" and 頭文件 for "header files"), while localizing terms
introduced in this file the first time (e.g. 搜尋 instead of 搜索 for
"search").

The localization of Chinese dialects could be performed programmatically
with the help of OpenCC[1] with custom configuration based on the
upstream s2twp.json (zh_CN to zh_TW with Taiwanese idiom), but that is
beyond the scope of this patch.

[1]: https://github.com/BYVoid/OpenCC

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 .../zh_TW/process/coding-style.rst            | 39 +++++++++++++++----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 5749363de421..0197405cfec8 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -922,25 +922,48 @@ Linux內核布爾（bool）類型是C99 _Bool類型的別名。布爾值只能
 
 總之，在結構體和參數中有限地使用布爾可以提高可讀性。
 
+
 18) 不要重新發明內核宏
 ----------------------
 
-頭文件 include/linux/kernel.h 包含了一些宏，你應該使用它們，而不要自己寫一些
-它們的變種。比如，如果你需要計算一個數組的長度，使用這個宏
+``include/linux`` 目錄下的頭文件提供了一些宏，你應該使用它們，而不要自己寫
+一些它們的變種。比如，如果你需要計算一個數組的長度，使用
+``include/linux/array_size.h`` 提供的 ``ARRAY_SIZE()`` 宏
 
 .. code-block:: c
 
-	#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+	#include <linux/array_size.h>
+	ARRAY_SIZE(x) // The size of array x
+
+類似的，如果你要計算某結構體成員的大小，使用 ``include/linux/stddef.h`` 當
+中的 ``sizeof_field()`` 宏。
+
+還有 ``include/linux/minmax.h`` 提供能做嚴格的類型檢查的 ``min()`` 和
+``max()`` 宏，如果你需要可以使用它們。
 
-類似的，如果你要計算某結構體成員的大小，使用
+使用共用頭文件所提供的宏也能避免命名衝突。比如說，如果有個開發者在頭文件
+``foo.h`` 中定義了
 
 .. code-block:: c
 
-	#define sizeof_field(t, f) (sizeof(((t*)0)->f))
+	#define __stringify(x) __stringify_1(x)
+	#define __stringify_1(x) #x
+
+但另一個開發者在頭文件 ``bar.h`` 中定義了
+
+.. code-block:: c
+
+	#define stringify(x) __stringify(x)
+	#define __stringify(x) #x
+
+當兩個頭文件都被 ``#include`` 進同一份文件，``foo.h`` 提供的工具可能會被
+``bar.h`` 破壞。
+
+如果兩個頭文件都使用 ``include/linux/stringify.h`` 提供的 ``__stringify()``
+宏，就不會互相干擾了。
 
-還有可以做嚴格的類型檢查的 min() 和 max() 宏，如果你需要可以使用它們。你可以
-自己看看那個頭文件裏還定義了什麼你可以拿來用的東西，如果有定義的話，你就不應
-在你的代碼裏自己重新定義。
+你可以自己搜尋、看看那些頭文件裏還定義了什麼你可以拿來用的東西，如果有定義的
+話，你就不應在你的代碼裏自己重新定義。
 
 
 19) 編輯器模式行和其他需要羅嗦的事情
-- 
2.42.0


