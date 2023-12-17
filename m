Return-Path: <linux-kernel+bounces-2494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC2815DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA2B21E0F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFEE570;
	Sun, 17 Dec 2023 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZMjzs+Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886EDDB2;
	Sun, 17 Dec 2023 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ba2dd905f9so1376544b6e.2;
        Sat, 16 Dec 2023 23:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702797220; x=1703402020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsNa9K53QEIWDiiqOBuAFIxQwF1kCxA5oMZgz893y4w=;
        b=TZMjzs+QukM7cdi3bcOcVsGeJQzJtJtG1caB1xo7KqHzvB87Q/fm93wYXls+4wPHah
         fYPMe9AnnMnwumjHXT6v0s23V2I5r8dlfQ6KmACKnzKFBOQa89oHhGiSesu0d0fQLRK8
         E+/PdAdpbptsaLXbtae3Ibqx+0icHll2HwRkxxs3KQSgBlZ8WiSMZ6br1lqEe9G+K2JA
         NWYCe92BVaLRg5lzFBiJdN0PV7TwEuidHtG8Zn4P2nBRlCcqIyhziZ6tPtTegp7rnPQ7
         tszJZjr30G++D1U6Ksf1eJ75FrxpVd50lEBFflmlRTrBBKgAZYG2+ExzFO3zRnrE/9VL
         H6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702797220; x=1703402020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsNa9K53QEIWDiiqOBuAFIxQwF1kCxA5oMZgz893y4w=;
        b=ZVS7MYyrvdYqCuajwLnS3dizNN7gFXrKEV2bgXfTs+YsN/G++WqMl4uAsAmESP6jz1
         EI1NiJuZJfmDgBLxKV19f2l2iPbJEcFQKvlksUnA9erWOc/XNstEm9kLzRCvSOFlHeOJ
         5xMStgGYbk1O3ZJ8n3DrBoj1NcFGGse4MOB3CHa/pDM65oj3xBQxe3yR1zGwK/0875aW
         i4/3Pa1vSID3ZEDpx1QulOs5yII3PFPVax2x9KDZkmksB5iJJRymIvUyixFzCEyq4OeF
         i3kCLnxrO0uWGIom9P2qlD180Xev12hqjGlUYdv2rRyJJAQG/8jUupLIEn2kdnmwV4Ub
         ygPQ==
X-Gm-Message-State: AOJu0Yy0q4NjnSFL6kSNXTQDgGVqvoBqIG6EFGaNiTXWpn4QlAHV4CVE
	zxCATM+57u0IY1YZ5RhznF4=
X-Google-Smtp-Source: AGHT+IGWwFqDW7XfFkRgyj/Gr80/LunbsYTvIMkNiVdagI90/MvOj3NipYqj2bpZF0ACp4FlPYnzLQ==
X-Received: by 2002:a05:6808:1924:b0:3b9:f017:28f with SMTP id bf36-20020a056808192400b003b9f017028fmr18156464oib.67.1702797220239;
        Sat, 16 Dec 2023 23:13:40 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000cd100b0068ffb8da107sm15740231pfv.212.2023.12.16.23.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 23:13:39 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
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
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 5/5] lib: test_bitops: add compile-time optimization/evaluations assertions
Date: Sun, 17 Dec 2023 16:12:50 +0900
Message-Id: <20231217071250.892867-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231217071250.892867-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20231217071250.892867-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function in the bitops test suite to assert that the bitops
helper correctly fold constant expressions (or trigger a build bug
otherwise). This should work on all the optimization levels supported
by Kbuild.

The added function doesn't perform any runtime tests and gets
optimized out to nothing after passing the build assertions.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 lib/Kconfig.debug |  4 ++++
 lib/test_bitops.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..c97d818dbc30 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2454,6 +2454,10 @@ config TEST_BITOPS
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
2.25.1


