Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE787784B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHKA6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjHKA6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:58:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEB9270C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:45 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40fe3850312so9889321cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715524; x=1692320324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLUgq5sJsnksu1tWPL/AvbQtFjshrxem+O1ixGkwgGI=;
        b=c/N3HdTFafA30pqcnQ6Yi6qPggV9xJGETGJJKibehzqerEjPIpg5gT2EylgZodM2kB
         32Cc02zA1Rz6tGpFsPWRZAKtPmTnAP3XcDAdretq5Z2V2d2GnEBncvoKVoyrmV6ZhHnI
         h+Yd1j6GPDBCvFFpvIVerW5jdoqgDSCjo84T0+trzyNMYSI3JMOsPptOfcO0jPLJb4Pj
         IFC8VrD2FIgjKPNCW4uLUGfe4QSVzqdeZt5MNZjP22uXb4K99snRgVjvN8WL5tz7vpIl
         1783PLW1DgiCN4+3NAChXo30B/4D7Zd7dT8jF3nWLZpaY7l265YzeteTNE0LVEY9g3lT
         nOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715524; x=1692320324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLUgq5sJsnksu1tWPL/AvbQtFjshrxem+O1ixGkwgGI=;
        b=dc9E2OP0ihHSGofZO469igWIyS6DCl+HeCEUovqvfYKJU3PzifcGpdrqcgz6o3CFQ6
         NRB8MZ9+K/AyUisdxzwDfUGt4yQIL+9zwHQ736Q6lbSVnX8WT4bi6e6X69whBxUdFn56
         cg7mB26rxVP2GuqBsgiU4r5DfHGOFBhuHynG9ZOJPXF5VGH+wYtwRlWSmbYB6TDv/cm5
         iVJ/ad2bl5m/Zq565ySnLHIo+QqQA41sTTliPZ6qmu8TIWyHlKIkCDTPwCShuVNaxwWH
         tcAubrVhhGnMe7ERtr9SiH5Gw4YMEFuhImId4MvTeCimJDAoW+Hqaakvqv92yQGqeQqP
         ncRw==
X-Gm-Message-State: AOJu0Yy12Js7dbpLPhOsPC3OhSdfuKDnWNiqd3itKYgNkd4aAsT6+rbj
        e41o6Xy/00MU9/4l0hHHiT08r2Ab2HM=
X-Google-Smtp-Source: AGHT+IHtKsSs2OApRO3X79J//8az7omv+QeZus8SVI47r9Fa1ZeZJUyO4OPeYyiWjLYaf1PuiR0rjg==
X-Received: by 2002:ac8:7d51:0:b0:403:9be1:c969 with SMTP id h17-20020ac87d51000000b004039be1c969mr545246qtb.62.1691715523874;
        Thu, 10 Aug 2023 17:58:43 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id c5-20020ac85185000000b0041031c46637sm576022qtn.48.2023.08.10.17.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:58:43 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 5/6] bitmap: drop _reg_op() function
Date:   Thu, 10 Aug 2023 17:57:31 -0700
Message-Id: <20230811005732.107718-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811005732.107718-1-yury.norov@gmail.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
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

Now that all _reg_op() users are switched alternative functions, _reg_op()
machinery is not needed anymore.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 76 ----------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index d4560acbe077..ae619523c3ec 100644
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
- * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- * Returns 0 in all other cases and reg_ops.
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

