Return-Path: <linux-kernel+bounces-3581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A644816E11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924C91C236DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC47EFCE;
	Mon, 18 Dec 2023 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orq+uUl0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D61DDCA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbce98f7d44so2990660276.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903243; x=1703508043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+s7R5buINA1l+45iU7O1tB1KNs5J4gGn/liaeDYSEis=;
        b=orq+uUl0cqCSdiF2IJzqA3h4Vxq8Es30qtmr4C+/BwxXFcVFhxxylNmlYCYT8MGtgV
         Yiep/uj0DLyl99EEdnWcfT6Gjg+xMiZk6lJD8WFugkwMsdgiyQRDAP4SaLTnc9Tl/DL0
         n60XVqlfJyL1OBZCGgBxMQ8we+c2DBb8Pf+Ld5fINS5WUzeIFiwlK/ygoE8/IOUtQpSF
         X70H76pbk2+kCr/HtWN5ahZm1hmTfHy8vuko1LKwRLE6EDACRv85nsgwg82krzB9hRAH
         0/3KTCJtAfdiL0hjjXYc2KqBO7EE6M0y3Uhcd95h+9tZk9oXiBdDUH6SK89sgk+MwtDb
         NFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903243; x=1703508043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s7R5buINA1l+45iU7O1tB1KNs5J4gGn/liaeDYSEis=;
        b=V1O3UJE8xEL+xogDmrPPCmtWygjimxif0wOsCUSsDqQADzHrZRreqLt87e4O/R2Hg5
         6JUiQ8VeEFOK76TxUkA6e3hU3c361o2JDr3gc0aUmcwb0Hr0VbwXGELLgMoIgdbpHrUL
         eGf4NTESmq6xYSPYiP8f9nVg/TbF4XahKmZsm27J7TBi0wn4gWDDwy7HNJd63oK3jDF1
         GYLymNXpRKMm+02TezCX6WSI8zvP0dnkZC2JOpCS51esF+ZsW9BdgVFq2L+B580MpUk/
         2aRxaNCvwA3wLn0IIx7t5hAxF8+mjqSwXy0C6TWBuMgAAaidNyEETef4DwjWGQDSm7Wk
         tNcA==
X-Gm-Message-State: AOJu0Yxzo66naLsTu0cZi6bFY0yHDgx7liKhQ0eyblvkNcCd2TE664KN
	4kDAwDZxIIT+ZG4X/SrPi78PBTyrREc=
X-Google-Smtp-Source: AGHT+IGb4xCln8IqSdTzAT71MlgqNnXOUpBRk3Q118PoT1YbYgqVVxGub1tkoODygZr5QCyZ6dbFESKf3b8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:9a3f:c8e7:1395:806e])
 (user=glider job=sendgmr) by 2002:a25:814c:0:b0:dbd:460e:1265 with SMTP id
 j12-20020a25814c000000b00dbd460e1265mr74851ybm.5.1702903243657; Mon, 18 Dec
 2023 04:40:43 -0800 (PST)
Date: Mon, 18 Dec 2023 13:40:28 +0100
In-Reply-To: <20231218124033.551770-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218124033.551770-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218124033.551770-3-glider@google.com>
Subject: [PATCH v11-mte 2/7] lib/test_bitmap: add tests for bitmap_{read,write}()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, catalin.marinas@arm.com, will@kernel.org, 
	pcc@google.com, andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, yury.norov@gmail.com, 
	alexandru.elisei@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

Add basic tests ensuring that values can be added at arbitrary positions
of the bitmap, including those spanning into the adjacent unsigned
longs.

Two new performance tests, test_bitmap_read_perf() and
test_bitmap_write_perf(), can be used to assess future performance
improvements of bitmap_read() and bitmap_write():

[    0.431119][    T1] test_bitmap: Time spent in test_bitmap_read_perf:	615253
[    0.433197][    T1] test_bitmap: Time spent in test_bitmap_write_perf:	916313

(numbers from a Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz machine running
QEMU).

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>

---
v11-mte:
 - add Yury's Acked-by:

v10-mte:
 - send this patch together with the "Implement MTE tag compression for
   swapped pages"

Revisions v8-v12 of bitmap patches were reviewed separately from the
"Implement MTE tag compression for swapped pages" series
(https://lore.kernel.org/lkml/20231109151106.2385155-1-glider@google.com/)

This patch was previously called
"lib/test_bitmap: add tests for bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-3-glider@google.com/)
and
"lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
(https://lore.kernel.org/lkml/20230713125706.2884502-3-glider@google.com/)

v12:
 - as suggested by Alexander Lobakin, replace expect_eq_uint() with
   expect_eq_ulong() and a cast

v9:
 - use WRITE_ONCE() to prevent optimizations in test_bitmap_read_perf()
 - update patch description

v8:
 - as requested by Andy Shevchenko, add tests for reading/writing
   sizes > BITS_PER_LONG

v7:
 - as requested by Yury Norov, add performance tests for bitmap_read()
   and bitmap_write()

v6:
 - use bitmap API to initialize test bitmaps
 - as requested by Yury Norov, do not check the return value of
   bitmap_read(..., 0)
 - fix a compiler warning on 32-bit systems

v5:
 - update patch title
 - address Yury Norov's comments:
   - rename the test cases
   - factor out test_bitmap_write_helper() to test writing over
     different background patterns;
   - add a test case copying a nontrivial value bit-by-bit;
   - drop volatile

v4:
 - Address comments by Andy Shevchenko: added Reviewed-by: and a link to
   the previous discussion
 - Address comments by Yury Norov:
   - expand the bitmap to catch more corner cases
   - add code testing that bitmap_set_value() does not touch adjacent
     bits
   - add code testing the nbits==0 case
   - rename bitmap_{get,set}_value() to bitmap_{read,write}()

v3:
 - switch to using bitmap_{set,get}_value()
 - change the expected bit pattern in test_set_get_value(),
   as the test was incorrectly assuming 0 is the LSB.
---
 lib/test_bitmap.c | 179 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 172 insertions(+), 7 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 65f22c2578b06..46c0154680772 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -60,18 +60,17 @@ static const unsigned long exp3_1_0[] __initconst = {
 };
 
 static bool __init
-__check_eq_uint(const char *srcfile, unsigned int line,
-		const unsigned int exp_uint, unsigned int x)
+__check_eq_ulong(const char *srcfile, unsigned int line,
+		 const unsigned long exp_ulong, unsigned long x)
 {
-	if (exp_uint != x) {
-		pr_err("[%s:%u] expected %u, got %u\n",
-			srcfile, line, exp_uint, x);
+	if (exp_ulong != x) {
+		pr_err("[%s:%u] expected %lu, got %lu\n",
+			srcfile, line, exp_ulong, x);
 		return false;
 	}
 	return true;
 }
 
-
 static bool __init
 __check_eq_bitmap(const char *srcfile, unsigned int line,
 		  const unsigned long *exp_bmap, const unsigned long *bmap,
@@ -185,7 +184,8 @@ __check_eq_str(const char *srcfile, unsigned int line,
 		result;							\
 	})
 
-#define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
+#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
+#define expect_eq_uint(x, y)		expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
@@ -1245,6 +1245,168 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(~var != ~BIT(25));
 }
 
+/*
+ * Test bitmap should be big enough to include the cases when start is not in
+ * the first word, and start+nbits lands in the following word.
+ */
+#define TEST_BIT_LEN (1000)
+
+/*
+ * Helper function to test bitmap_write() overwriting the chosen byte pattern.
+ */
+static void __init test_bitmap_write_helper(const char *pattern)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
+	DECLARE_BITMAP(pat_bitmap, TEST_BIT_LEN);
+	unsigned long w, r, bit;
+	int i, n, nbits;
+
+	/*
+	 * Only parse the pattern once and store the result in the intermediate
+	 * bitmap.
+	 */
+	bitmap_parselist(pattern, pat_bitmap, TEST_BIT_LEN);
+
+	/*
+	 * Check that writing a single bit does not accidentally touch the
+	 * adjacent bits.
+	 */
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		bitmap_copy(bitmap, pat_bitmap, TEST_BIT_LEN);
+		bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
+		for (bit = 0; bit <= 1; bit++) {
+			bitmap_write(bitmap, bit, i, 1);
+			__assign_bit(i, exp_bitmap, bit);
+			expect_eq_bitmap(exp_bitmap, bitmap,
+					 TEST_BIT_LEN);
+		}
+	}
+
+	/* Ensure writing 0 bits does not change anything. */
+	bitmap_copy(bitmap, pat_bitmap, TEST_BIT_LEN);
+	bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		bitmap_write(bitmap, ~0UL, i, 0);
+		expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+	}
+
+	for (nbits = BITS_PER_LONG; nbits >= 1; nbits--) {
+		w = IS_ENABLED(CONFIG_64BIT) ? 0xdeadbeefdeadbeefUL
+					     : 0xdeadbeefUL;
+		w >>= (BITS_PER_LONG - nbits);
+		for (i = 0; i <= TEST_BIT_LEN - nbits; i++) {
+			bitmap_copy(bitmap, pat_bitmap, TEST_BIT_LEN);
+			bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
+			for (n = 0; n < nbits; n++)
+				__assign_bit(i + n, exp_bitmap, w & BIT(n));
+			bitmap_write(bitmap, w, i, nbits);
+			expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+			r = bitmap_read(bitmap, i, nbits);
+			expect_eq_ulong(r, w);
+		}
+	}
+}
+
+static void __init test_bitmap_read_write(void)
+{
+	unsigned char *pattern[3] = {"", "all:1/2", "all"};
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned long zero_bits = 0, bits_per_long = BITS_PER_LONG;
+	unsigned long val;
+	int i, pi;
+
+	/*
+	 * Reading/writing zero bits should not crash the kernel.
+	 * READ_ONCE() prevents constant folding.
+	 */
+	bitmap_write(NULL, 0, 0, READ_ONCE(zero_bits));
+	/* Return value of bitmap_read() is undefined here. */
+	bitmap_read(NULL, 0, READ_ONCE(zero_bits));
+
+	/*
+	 * Reading/writing more than BITS_PER_LONG bits should not crash the
+	 * kernel. READ_ONCE() prevents constant folding.
+	 */
+	bitmap_write(NULL, 0, 0, READ_ONCE(bits_per_long) + 1);
+	/* Return value of bitmap_read() is undefined here. */
+	bitmap_read(NULL, 0, READ_ONCE(bits_per_long) + 1);
+
+	/*
+	 * Ensure that bitmap_read() reads the same value that was previously
+	 * written, and two consequent values are correctly merged.
+	 * The resulting bit pattern is asymmetric to rule out possible issues
+	 * with bit numeration order.
+	 */
+	for (i = 0; i < TEST_BIT_LEN - 7; i++) {
+		bitmap_zero(bitmap, TEST_BIT_LEN);
+
+		bitmap_write(bitmap, 0b10101UL, i, 5);
+		val = bitmap_read(bitmap, i, 5);
+		expect_eq_ulong(0b10101UL, val);
+
+		bitmap_write(bitmap, 0b101UL, i + 5, 3);
+		val = bitmap_read(bitmap, i + 5, 3);
+		expect_eq_ulong(0b101UL, val);
+
+		val = bitmap_read(bitmap, i, 8);
+		expect_eq_ulong(0b10110101UL, val);
+	}
+
+	for (pi = 0; pi < ARRAY_SIZE(pattern); pi++)
+		test_bitmap_write_helper(pattern[pi]);
+}
+
+static void __init test_bitmap_read_perf(void)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned int cnt, nbits, i;
+	unsigned long val;
+	ktime_t time;
+
+	bitmap_fill(bitmap, TEST_BIT_LEN);
+	time = ktime_get();
+	for (cnt = 0; cnt < 5; cnt++) {
+		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
+			for (i = 0; i < TEST_BIT_LEN; i++) {
+				if (i + nbits > TEST_BIT_LEN)
+					break;
+				/*
+				 * Prevent the compiler from optimizing away the
+				 * bitmap_read() by using its value.
+				 */
+				WRITE_ONCE(val, bitmap_read(bitmap, i, nbits));
+			}
+		}
+	}
+	time = ktime_get() - time;
+	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+}
+
+static void __init test_bitmap_write_perf(void)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned int cnt, nbits, i;
+	unsigned long val = 0xfeedface;
+	ktime_t time;
+
+	bitmap_zero(bitmap, TEST_BIT_LEN);
+	time = ktime_get();
+	for (cnt = 0; cnt < 5; cnt++) {
+		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
+			for (i = 0; i < TEST_BIT_LEN; i++) {
+				if (i + nbits > TEST_BIT_LEN)
+					break;
+				bitmap_write(bitmap, val, i, nbits);
+			}
+		}
+	}
+	time = ktime_get() - time;
+	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+}
+
+#undef TEST_BIT_LEN
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1261,6 +1423,9 @@ static void __init selftest(void)
 	test_bitmap_cut();
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
+	test_bitmap_read_write();
+	test_bitmap_read_perf();
+	test_bitmap_write_perf();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();
-- 
2.43.0.472.g3155946c3a-goog


