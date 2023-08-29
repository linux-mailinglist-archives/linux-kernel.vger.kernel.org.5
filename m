Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACC78BCED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjH2CkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjH2Cja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:30 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942DCA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:26 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-573921661a6so844255eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276766; x=1693881566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJhbsn7qD8sqFnBkCZdh14WA9jrZUyo54sNK/cY2q/E=;
        b=XQuYU8dK6jhL7sbKNyo2taeA89OfxRCHksQlhNuhmfftnwQDmyrzGZNwJdUqzWFOv0
         XBz6abdDaLKo2eOktGLNEQr3nC3VxHruJ3L+s7iSO46imkb2s6YEWFnMHCD8JzYIFO11
         moVxzApqEgAH/jTMD8JUnu2IkX1m1PpAObrfTn2anvL37NM589hPYs/cOM8cDK8xyaSE
         nfUvtA/GXIsOA9zipxc6Df+htqpHUU65Q7JuljpZQ+pFoqSMAzCSqocsmUFPnGWfqbF1
         jexwmQI5iazqEXyeegfWjaA3+boY5nCflzvuHZsXA46JP8lfOQl2vm9iESm+qRC9lbZf
         mJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276766; x=1693881566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJhbsn7qD8sqFnBkCZdh14WA9jrZUyo54sNK/cY2q/E=;
        b=kcPT/108J3hXUUnAUVeJVXKxHiinmDHpAbUM6sc8sc50TryVBB6pBSCTldn/M8dOSs
         7sky+MKqKSvV+4Xpwo/t6Tuh17DsIJIx9HBw4J0r+WthkWcOejR5xhtGPALS0UrVQ8ZN
         hgAgeCcqfGtXSdGHwQfhQLFldnEqu7XvHBZvGuWMlezp8THjEKzoiK7b06tqY2B2SNbV
         3Lxa6btdW3TMHm81ls4FpdXUa6pVRLTxwpWRl5aowBjM39EhQ1Hi+T/Bcbc4ZmrlpLHV
         /BwRdGn2TfKcPn06zB1ZJ0h7jbP5RpfoERcwk2R9uxZ+/YNI45l4ONIyoOkxkeeGC/FP
         rE+Q==
X-Gm-Message-State: AOJu0Yyv2MMLmhPx5LQY8kcyCwVZSiDKj36+/L6TyEf52pDxT9aZspSf
        L8D6z/XDuvt1bgyG3uGi6NYQ86rE7QI=
X-Google-Smtp-Source: AGHT+IGpYP8ClbveZocLTNQ1+4Cm1LAZ09Xz+AZEHbOnZqqDlT8S3bOvDYOQkyixb2ZQc8VMP7PmQQ==
X-Received: by 2002:a4a:3014:0:b0:573:2312:b3 with SMTP id q20-20020a4a3014000000b00573231200b3mr11605146oof.4.1693276765754;
        Mon, 28 Aug 2023 19:39:25 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id 4-20020a4a1704000000b0056d361ca33fsm4699375ooe.16.2023.08.28.19.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 7/8] bitmap: drop _reg_op() function
Date:   Mon, 28 Aug 2023 19:39:10 -0700
Message-Id: <20230829023911.64335-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829023911.64335-1-yury.norov@gmail.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all _reg_op() users are switched to alternative functions,
_reg_op() machinery is not needed anymore.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 76 ----------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index c94340c4ba86..ab730ce52d21 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1220,82 +1220,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 }
 #endif /* CONFIG_NUMA */
 
-/*
- * Common code for bitmap_*_region() routines.
- *	bitmap: array of unsigned longs corresponding to the bitmap
- *	pos: the beginning of the region
- *	order: region size (log base 2 of number of bits)
- *	reg_op: operation(s) to perform on that region of bitmap
- *
- * Can set, verify and/or release a region of bits in a bitmap,
- * depending on which combination of REG_OP_* flag bits is set.
- *
- * A region of a bitmap is a sequence of bits in the bitmap, of
- * some size '1 << order' (a power of two), aligned to that same
- * '1 << order' power of two.
- *
- * Return: 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- *	   0 in all other cases and reg_ops.
- */
-
-enum {
-	REG_OP_ISFREE,		/* true if region is all zero bits */
-	REG_OP_ALLOC,		/* set all bits in region */
-	REG_OP_RELEASE,		/* clear all bits in region */
-};
-
-static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_op)
-{
-	int nbits_reg;		/* number of bits in region */
-	int index;		/* index first long of region in bitmap */
-	int offset;		/* bit offset region in bitmap[index] */
-	int nlongs_reg;		/* num longs spanned by region in bitmap */
-	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask for one long of region */
-	int i;			/* scans bitmap by longs */
-	int ret = 0;		/* return value */
-
-	/*
-	 * Either nlongs_reg == 1 (for small orders that fit in one long)
-	 * or (offset == 0 && mask == ~0UL) (for larger multiword orders.)
-	 */
-	nbits_reg = 1 << order;
-	index = pos / BITS_PER_LONG;
-	offset = pos - (index * BITS_PER_LONG);
-	nlongs_reg = BITS_TO_LONGS(nbits_reg);
-	nbitsinlong = min(nbits_reg,  BITS_PER_LONG);
-
-	/*
-	 * Can't do "mask = (1UL << nbitsinlong) - 1", as that
-	 * overflows if nbitsinlong == BITS_PER_LONG.
-	 */
-	mask = (1UL << (nbitsinlong - 1));
-	mask += mask - 1;
-	mask <<= offset;
-
-	switch (reg_op) {
-	case REG_OP_ISFREE:
-		for (i = 0; i < nlongs_reg; i++) {
-			if (bitmap[index + i] & mask)
-				goto done;
-		}
-		ret = 1;	/* all bits in region free (zero) */
-		break;
-
-	case REG_OP_ALLOC:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] |= mask;
-		break;
-
-	case REG_OP_RELEASE:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] &= ~mask;
-		break;
-	}
-done:
-	return ret;
-}
-
 /**
  * bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: array of unsigned longs corresponding to the bitmap
-- 
2.39.2

