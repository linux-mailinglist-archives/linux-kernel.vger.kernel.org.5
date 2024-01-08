Return-Path: <linux-kernel+bounces-19832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F28274DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7509A283D46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2454BC0;
	Mon,  8 Jan 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="CAaevBH3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC954736
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 41B6A240028
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704730612; bh=FSKcWsQ5mtlwkCpoTpXGMOT6OsAb8LvcvEc/sUGr2VU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=CAaevBH3V6YyG0d8ShmWsQfffeLzQeCzOuqDjG3fTJ5UP16tN/extBLKsb1kyHN8E
	 RWjsOvPT1fIHR5kRDbF8LwgpoZXSyH0yCVjlfDEVr4Co83FsQ/evQqMbhEQBvSqpz3
	 wK5/PxtRlDUdYby8ytb0+7CR1KUYzyIXXspo6EQbTNjzl2/nXjGqQGm0hSnNHG8Sae
	 WykSkkO1Cv967G7diIZ4d9/KD8JzlbZkIAmPl4UlRGyTUlboTVY1SuWQLZzFSNVlJJ
	 KV5NuCegkufYWrRfbz+Gm0qDekkpjx1QTTBw3rqC1kc/PUKNuro/Ta0Eg/FgGWWD8K
	 9+Uddbnyj3enw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T7zhx4HD5z9rxF;
	Mon,  8 Jan 2024 17:16:49 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] doc/zh_CN: coding-style: update content of section 18
Date: Mon,  8 Jan 2024 16:03:25 +0000
Message-ID: <20240108160746.177421-5-shamrocklee@posteo.net>
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

Update the content of the zh_CN translation of "Linux kernel coding
style" section 18, following the change proposed in the first 2 patches
in these patch series.

As a zh_TW speaker, I tried my best to compare and proofread the content
generated with OpenCC[1] with tw2s and tw2sp configurations, and
existing translation in the same file. Please kindly point out anything
I should fix.

[1]: https://github.com/BYVoid/OpenCC

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 .../zh_CN/process/coding-style.rst            | 39 +++++++++++++++----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index fa28ef0a7fee..14ff3cdc2d0d 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -919,25 +919,48 @@ Linux内核布尔（bool）类型是C99 _Bool类型的别名。布尔值只能
 
 总之，在结构体和参数中有限地使用布尔可以提高可读性。
 
+
 18) 不要重新发明内核宏
 ----------------------
 
-头文件 include/linux/kernel.h 包含了一些宏，你应该使用它们，而不要自己写一些
-它们的变种。比如，如果你需要计算一个数组的长度，使用这个宏
+``include/linux`` 目录下的头文件提供了一些宏，你应该使用它们，而不要自己写
+一些它们的变种。比如，如果你需要计算一个数组的长度，使用
+``include/linux/array_size.h`` 提供的 ``ARRAY_SIZE()`` 宏
 
 .. code-block:: c
 
-	#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+	#include <linux/array_size.h>
+	ARRAY_SIZE(x) // The size of array x
+
+类似的，如果你要计算某结构体成员的大小，使用 ``include/linux/stddef.h`` 当
+中的 ``sizeof_field()`` 宏。
+
+还有 ``include/linux/minmax.h`` 提供能做严格的类型检查的 ``min()`` 和
+``max()`` 宏，如果你需要可以使用它们。
 
-类似的，如果你要计算某结构体成员的大小，使用
+使用共用头文件所提供的宏也能避免命名冲突。比如说，如果有个开发者在头文件
+``foo.h`` 中定义了
 
 .. code-block:: c
 
-	#define sizeof_field(t, f) (sizeof(((t*)0)->f))
+	#define __stringify(x) __stringify_1(x)
+	#define __stringify_1(x) #x
+
+但另一个开发者在头文件 ``bar.h`` 中定义了
+
+.. code-block:: c
+
+	#define stringify(x) __stringify(x)
+	#define __stringify(x) #x
+
+当两个头文件都被 ``#include`` 进同一份文件，``foo.h`` 提供的工具可能会被
+``bar.h`` 破坏。
+
+如果两个头文件都使用 ``include/linux/stringify.h`` 提供的 ``__stringify()``
+宏，就不会互相干扰了。
 
-还有可以做严格的类型检查的 min() 和 max() 宏，如果你需要可以使用它们。你可以
-自己看看那个头文件里还定义了什么你可以拿来用的东西，如果有定义的话，你就不应
-在你的代码里自己重新定义。
+你可以自己搜索、看看那些头文件里还定义了什么你可以拿来用的东西，如果有定义的
+话，你就不应在你的代码里自己重新定义。
 
 
 19) 编辑器模式行和其他需要罗嗦的事情
-- 
2.42.0


