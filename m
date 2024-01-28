Return-Path: <linux-kernel+bounces-41539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF083F3F9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FFA1F22121
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958522087;
	Sun, 28 Jan 2024 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grpLTiGS"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED31208B4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418387; cv=none; b=tva42E15bZuSai/K9puEcuxR1ynmGKfcOAEHoXu5TQIIch+Gq5reKsZYyWouDAtrmKsxdW1nUSE7tLnBT5ooRG0chRl78VspVUaM/zs5xVFRY2Bnm+1830y2QFMLicWSMqBtV3Y/iqnr+CJMrWS+ifH3u2cENOJMR3P604p9e/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418387; c=relaxed/simple;
	bh=sqYZMDlKDRUfnljor6SGKDrcquN71PTrtDOFGVVMCyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kScuWIbZS/MDr6Y4O0+XdVqoeuTLgpowE/5frefYdC4KJUdvdSl0vx3XWRroAPDa9MXOtERHyMqJ5vu8hWFtBf1QvFTjiWylQEYkQ7QHUzNmesxcFgWXwntyAElH4gWtYOl0zJAE7IFd/GWf9dZVeI4tz5KzWXOX1GPh3mDZCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grpLTiGS; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd6581bc66so1568747b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706418385; x=1707023185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Klq863pFaGoDv/8+20XN12p6t4dw+6WO92EMrH2yao8=;
        b=grpLTiGSYbX1nqjDPil48wSclML50UBppOs5Z7oYohbns2Vj3FGn3ktoR0d8WaAZNV
         v3Vnl6JxI6Fc/AeRcuX/2F1ig/zaUhQW0L8/i2RSYTDOWjfKeuFeXFpIdxmiqhFdESpO
         /rMzCo5mJ9lKq9AefbVVNLLKiYozv1h1huUA4Z98nk9IIl8aCiEhHJneJ/K970ZqyXOR
         f28xmcFtivFSWuN2VXQjjWl/8QiMYGsEhgVbFQkc6W/wTtWjR1xXEwQ+2QUjzUlXbGhS
         T0MwsmBa7ohy13f1rm8k8FtZBp4pv5dlo0QejgnYsfyigpn7/bjxY9NqUz1Bd6asYeVa
         NX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418385; x=1707023185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Klq863pFaGoDv/8+20XN12p6t4dw+6WO92EMrH2yao8=;
        b=g5ZX7o8fRysor6ySubqGX4K4JV0U7eobPpgM43JrxBb6IGDlvN+G2AMMZDXUCdMpYH
         ZB5lskDh+1Agzqd/yZyo+MO5ifrdtFZH9LJKD013ueu8Szvcb3JySR5TFhGFb4XeUtyV
         Dlk2hCAkKfZkOFEdRSPgK70PhXeRxv7hwiwtOzg1WN8XLIswkaUZhngmMjAd+9qTTOqq
         26Eq2UV8iwupQJg7CGVYCL74qHAVb2RguxPPKOyFi8K9uHbdhoQvUmrt1o3UULEH/XHP
         ZHobPlZvbqVHiNvxJNdNYG2sUUwrLsaZUPpafz63cnRiYpx+HF9zVQLGZvMcDnuDUeO2
         aesw==
X-Gm-Message-State: AOJu0YybPLkV7zU8WB7KJzqeAaF7NOTAph8YT9dLSDUVeW9jfgnZqDx0
	h8eTee2Eyx8Frq0Jo7WjsI205+WgKCbE28edu3PKOoxEvKaCnhH7
X-Google-Smtp-Source: AGHT+IFJKmp+bAvhbdfzCBdTHyX1Zr9Yd3+YnQ7Hr1irLdsB79h6IjRdALDmguFKws+ptaAXM7qdlQ==
X-Received: by 2002:a05:6808:d49:b0:3be:3a9e:5cd6 with SMTP id w9-20020a0568080d4900b003be3a9e5cd6mr804691oik.34.1706418385049;
        Sat, 27 Jan 2024 21:06:25 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm3550372pfb.46.2024.01.27.21.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:06:24 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marco Elver <elver@google.com>,
	Brian Cain <bcain@quicinc.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-m68k@lists.linux-m68k.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 5/5] lib: test_bitops: add compile-time optimization/evaluations assertions
Date: Sun, 28 Jan 2024 14:00:11 +0900
Message-ID: <20240128050449.1332798-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function in the bitops test suite to assert that the bitops
helper functions correctly fold into constant expressions (or trigger
a build bug otherwise). This should work on all the optimization
levels supported by Kbuild.

The added function does not perform any runtime tests and gets
optimized out to nothing after passing the build assertions.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 lib/Kconfig.debug |  4 ++++
 lib/test_bitops.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4405f81248fb..85f8638b3ae6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2439,6 +2439,10 @@ config TEST_BITOPS
 	  compilations. It has no dependencies and doesn't run or load unless
 	  explicitly requested by name.  for example: modprobe test_bitops.
 
+	  In addition, check that the compiler is able to fold the bitops
+	  function into a compile-time constant (given that the argument is also
+	  a compile-time constant) and trigger a build bug otherwise.
+
 	  If unsure, say N.
 
 config TEST_VMALLOC
diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index 3b7bcbee84db..99b612515eb6 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -50,6 +50,34 @@ static unsigned long order_comb_long[][2] = {
 };
 #endif
 
+/* Assert that a boolean expression can be folded in a constant and is true. */
+#define test_const_eval(test_expr)				\
+({								\
+	/* Evaluate once so that compiler can fold it. */	\
+	bool __test_expr = test_expr;				\
+								\
+	BUILD_BUG_ON(!__builtin_constant_p(__test_expr));	\
+	BUILD_BUG_ON(!__test_expr);				\
+})
+
+/*
+ * On any supported optimization level (-O2, -Os) and if invoked with
+ * a compile-time constant argument, the compiler must be able to fold
+ * into a constant expression all the bit find functions. Namely:
+ * __ffs(), ffs(), ffz(), __fls(), fls() and fls64(). Otherwise,
+ * trigger a build bug.
+ */
+static __always_inline void test_bitops_const_eval(unsigned int n)
+{
+	test_const_eval(__ffs(BIT(n)) == n);
+	test_const_eval(ffs(BIT(n)) == n + 1);
+	test_const_eval(ffz(~BIT(n)) == n);
+	test_const_eval(__fls(BIT(n)) == n);
+	test_const_eval(fls(BIT(n)) == n + 1);
+	test_const_eval(fls64(BIT_ULL(n)) == n + 1);
+	test_const_eval(fls64(BIT_ULL(n + 32)) == n + 33);
+}
+
 static int __init test_bitops_startup(void)
 {
 	int i, bit_set;
@@ -94,6 +122,10 @@ static int __init test_bitops_startup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
+	test_bitops_const_eval(0);
+	test_bitops_const_eval(10);
+	test_bitops_const_eval(31);
+
 	pr_info("Completed bitops test\n");
 
 	return 0;
-- 
2.43.0


