Return-Path: <linux-kernel+bounces-3580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA7816E10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435B51C23534
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2C7EFAC;
	Mon, 18 Dec 2023 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ/BH2uN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4D7D61A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e7547e98f1so310987b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903241; x=1703508041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8Y1vpDLXBoOVMPkC57pHh/dMlB5nfNRh+2cjdcX+Qc=;
        b=SZ/BH2uNlHZPdZRmIvzMRqiHSoL+vFR7XWaghjOckIg/jHhz8742MINK0cbFgfk1YI
         ZUZaV8CpbtsnCBhxhER9vjXO8WLyt2BN6Lqe/IqmbZRgx2iYzI1IA5XH4C5MS/eN898K
         VNgoHyjZoXoaCpdnMRq8xPWF9CtebFn3Ju4njt0CnbrVpFB8auO8cXCq/ZEbC4uwpLMw
         jiBShTUBtk6ScOkpwdeFpM0i/54Us7I5T4cHmCbKvvM8et/r3GCtPppQF0w/dUJxRaPM
         GqNWBG4E8+tGUImErE+sWvb5ITk3tYf7L+k8Yb0e02K28a6YfzQIMfcwl16DsN/YQXHE
         Guwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903241; x=1703508041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8Y1vpDLXBoOVMPkC57pHh/dMlB5nfNRh+2cjdcX+Qc=;
        b=AD2eLz/H7t8crEgdBGxqboKfQXoolFpPlX4U/EcStmysJZ5m7KIEhrfRfg6W0GAnoE
         GW0VuSx1rysZ9hHXK1V7W8JlRXdx+vjf7/x48eskolspYysG48kf9nk2+HkHKVTf1rSY
         DUtd0j8p35h77TeztG9CTB0ciew3rHoJgGPCmNHI1+GHFvEJOXPOH1HC7BWlCa5eDc55
         IxEiIIS5q5VWypmE8Ei/eD8wjrxaO+LtvAfeuaAwSHlCegcCSMBWS5K2rUpKaVZwss0s
         tjatFVEUI04yt2DDhCN3b1ozgbI72cceRsOpEtguXdeQEo6nqgGtSkrqvZb/rR7T79fR
         A8Lg==
X-Gm-Message-State: AOJu0YylAe34KPoJQUpSm8zOGMmv4hPZcyIEu3YAICkaihcxn8eptjUy
	xhaRsp8izMaNxVi4Qb8opnnveOihydc=
X-Google-Smtp-Source: AGHT+IE7ihbMpk13JBzv7e+cU/i+BqwecvBnY7IH9/0tDL6jCpWfN6m7AIIo1GGAyzhgiLbHWu4SYj8h6qw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:9a3f:c8e7:1395:806e])
 (user=glider job=sendgmr) by 2002:a05:6902:1367:b0:dbd:30b0:828e with SMTP id
 bt7-20020a056902136700b00dbd30b0828emr605226ybb.1.1702903240833; Mon, 18 Dec
 2023 04:40:40 -0800 (PST)
Date: Mon, 18 Dec 2023 13:40:27 +0100
In-Reply-To: <20231218124033.551770-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218124033.551770-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218124033.551770-2-glider@google.com>
Subject: [PATCH v11-mte 1/7] lib/bitmap: add bitmap_{read,write}()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, catalin.marinas@arm.com, will@kernel.org, 
	pcc@google.com, andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, yury.norov@gmail.com, 
	alexandru.elisei@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

From: Syed Nayyar Waris <syednwaris@gmail.com>

The two new functions allow reading/writing values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a number of changes and simplifications:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value());
 - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
   and bitmap_write();
 - some redundant computations are omitted.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
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

This patch was previously called "lib/bitmap: add
bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-2-glider@google.com/)

v11:
 - rearrange whitespace as requested by Andy Shevchenko,
   add Reviewed-by:, update a comment

v10:
 - update comments as requested by Andy Shevchenko

v8:
 - as suggested by Andy Shevchenko, handle reads/writes of more than
   BITS_PER_LONG bits, add a note for 32-bit systems

v7:
 - Address comments by Yury Norov, Andy Shevchenko, Rasmus Villemoes:
   - update code comments;
   - get rid of GENMASK();
   - s/assign_bit/__assign_bit;
   - more vertical whitespace for better readability;
 - more compact code for bitmap_write() (now for real)

v6:
 - As suggested by Yury Norov, do not require bitmap_read(..., 0) to
   return 0.

v5:
 - Address comments by Yury Norov:
   - updated code comments and patch title/description
   - replace GENMASK(nbits - 1, 0) with BITMAP_LAST_WORD_MASK(nbits)
   - more compact bitmap_write() implementation

v4:
 - Address comments by Andy Shevchenko and Yury Norov:
   - prevent passing values >= 64 to GENMASK()
   - fix commit authorship
   - change comments
   - check for unlikely(nbits==0)
   - drop unnecessary const declarations
   - fix kernel-doc comments
   - rename bitmap_{get,set}_value() to bitmap_{read,write}()
---
 include/linux/bitmap.h | 77 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d65..7ca0379be8c13 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -79,6 +79,10 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -636,6 +640,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
+ *
+ * Returns: value of @nbits bits located at the @start bit offset within the
+ * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
+ * value is undefined.
+ */
+static inline unsigned long bitmap_read(const unsigned long *map,
+					unsigned long start,
+					unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+	unsigned long value_low, value_high;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return 0;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
+
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
+ *
+ * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
+ * i.e. bits beyond @nbits are ignored:
+ *
+ *   for (bit = 0; bit < nbits; bit++)
+ *           __assign_bit(start + bit, bitmap, val & BIT(bit));
+ *
+ * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
+ */
+static inline void bitmap_write(unsigned long *map, unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index;
+	unsigned long offset;
+	unsigned long space;
+	unsigned long mask;
+	bool fit;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return;
+
+	mask = BITMAP_LAST_WORD_MASK(nbits);
+	value &= mask;
+	offset = start % BITS_PER_LONG;
+	space = BITS_PER_LONG - offset;
+	fit = space >= nbits;
+	index = BIT_WORD(start);
+
+	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
+	map[index] |= value << offset;
+	if (fit)
+		return;
+
+	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.43.0.472.g3155946c3a-goog


