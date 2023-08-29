Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D415A78BCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjH2Cjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjH2CjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3514CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9e478e122so2868845a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276755; x=1693881555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NE27I3CsU4QkkPBH5fYXurm70My+K33B6QZenOIBsA=;
        b=KvQCDpFJZ1opI3ehAB2jl9X3ERludzMXHIY7OiEF8Pm4w+rhqwwbCav9u2g/rffEb2
         ZbaOrenHzfrV6OZi9384i58lZJGNQpUx002T28aasoepfrjYN+qgJOtqNzombEgrb0l0
         9GkE/0kAYlLkNNMnbb6e7jpYHE7JpieglR/YYDvbqZCun7R6pARexT4sgy9Z+qkUD272
         2rUFsYOOF3iTYUsPWZP2fkVFi/b+abVLW6H3t1DunzB3AjUM7g8LU46u83LBDDowckz3
         jFr1ocOSWdrWXtVofsPGF1ltIjqfX1b9JZP90FQfAjusVH1adcIgAV+5/63MPmm3K1z3
         jILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276755; x=1693881555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NE27I3CsU4QkkPBH5fYXurm70My+K33B6QZenOIBsA=;
        b=IFxDRRMXoBUls8Y4pktGRhH+QsA4YjQ3g4PM38UbxjQTuqkuvfPU68cDV84M1nZN3g
         /hpiwJyj6P3lEf9YiSRmIQHDiwbPkKu88ZrZmCvo5HdniRwS93QmmAHZI4mo01Npn9Uu
         LKgUH4kcQK8p3xI8DaBMOGiCSh6WPRiUgy0C8Pz6rP+/fDehTLgSSqUtc2pJXHcW8QSD
         Nz2C6WtMAzdqZcBUHNI/cLTcmXL3PFPYu/Zms5LK1+eqfNF88uW+G7v0bI4XNpY27BLI
         5wXlw49rzXVkLwCC5oJfefI2b3bKdpTNywrF5F5GQiCe/wyLxhgkPfnOhO3mYwxRPwzX
         V+xQ==
X-Gm-Message-State: AOJu0Yyi+GB9gnHuNOXFi7KhisXGfsJB6LDlr/kcFSzUv6aW+4ZOr032
        6t6TOQeI7QWCL1BndkjiVanScC9s0F4=
X-Google-Smtp-Source: AGHT+IEODGxB8695GNUoglx5oPne5IYWXgo+MDk+8WSWIrnVQN/n9ehKW76kAi7TPtV7BGScdf9pvQ==
X-Received: by 2002:a05:6830:16cf:b0:6bb:1071:ea72 with SMTP id l15-20020a05683016cf00b006bb1071ea72mr15713974otr.36.1693276755592;
        Mon, 28 Aug 2023 19:39:15 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id p24-20020a0568301d5800b006af913c1044sm4054188oth.16.2023.08.28.19.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:15 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 1/8] bitmap: align __reg_op() wrappers with modern coding style
Date:   Mon, 28 Aug 2023 19:39:04 -0700
Message-Id: <20230829023911.64335-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829023911.64335-1-yury.norov@gmail.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments so that scripts/kernel-doc doesn't warn, and fix for-loop
stype in bitmap_find_free_region().

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 935e0f96e785..250715260d95 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1234,8 +1234,8 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
  * some size '1 << order' (a power of two), aligned to that same
  * '1 << order' power of two.
  *
- * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- * Returns 0 in all other cases and reg_ops.
+ * Return: 1 if REG_OP_ISFREE succeeds (region is all zero bits).
+ *	   0 in all other cases and reg_ops.
  */
 
 enum {
@@ -1307,14 +1307,14 @@ static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_
  * a power (@order) of two, aligned to that power of two, which
  * makes the search algorithm much faster.
  *
- * Return the bit offset in bitmap of the allocated region,
+ * Return: the bit offset in bitmap of the allocated region,
  * or -errno on failure.
  */
 int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 {
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
-	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
+	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
 		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 			continue;
 		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
@@ -1332,8 +1332,6 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  *
  * This is the complement to __bitmap_find_free_region() and releases
  * the found region (by clearing it in the bitmap).
- *
- * No return value.
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
@@ -1349,7 +1347,7 @@ EXPORT_SYMBOL(bitmap_release_region);
  *
  * Allocate (set bits in) a specified region of a bitmap.
  *
- * Return 0 on success, or %-EBUSY if specified region wasn't
+ * Return: 0 on success, or %-EBUSY if specified region wasn't
  * free (not all bits were zero).
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
-- 
2.39.2

