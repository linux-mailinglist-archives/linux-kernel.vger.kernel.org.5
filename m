Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779117784AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjHKA6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjHKA56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:57:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7562703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:57:58 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7653bd3ff2fso122454985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715477; x=1692320277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3H4QcxoOw2DG/R4k9BtZKu5lf2fmFfD2kmZ30iKZhA=;
        b=gKtmxZxuxUVBO7cgHEYVX9XcshmrkkoJZhXBY2GLXYQrnKyfPnI0U9809swzJHDZ7c
         SMunyTA5OtLAmQDA9HjXKioNvhDh/r/Kxu2eBVkA32ZaC+uW2lkhdee3Xiu1PwaSGwYK
         LecM9E3Bcv7aOUbiN2HJ+5FXpGJ6fy3QgKqFmO5nVxR2utYF1a5rvPWgofIEuV4r5FB7
         AOHjSJOM60MhMiKXbRoYcLtLGvLnnLQt2LHC/Dd0atWedFQ0OgThRWpiWo1q7tJLzIEl
         JHHWvEPbqXQImqblOF9n9SZ4eniDKmvdWeI617tCNbjzXSHiivirpOPAt8IvDMS8WHqH
         epZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715477; x=1692320277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3H4QcxoOw2DG/R4k9BtZKu5lf2fmFfD2kmZ30iKZhA=;
        b=jlLr5tGka+b56UN5SzjXN22xBBP1FWJ58JT17XaUoiZKQatU3XLLf7ALrE6/c8cwQW
         z1ZtQbQVRhLN2jVtWQ9jU7bsJsTtz/EN1MmFrmgtwO5vTD5X0z0M8bIALAC+HWU9M40H
         7NAiVh4f62Lhn2jPNN/EXyFV61UAIshhiEtDioYo4b/Us746caMZZQudo3uraVe4shdm
         Df+RP+rK0baof8QpgKPTzUejsAJPANEPb+VqfWfIXCP9BnMXruWKGoq1JAVcrKmIg2lB
         rkBXxJ63XOzg6Ka7eFadB1FGXgrtkDppAEMglB3D7l+eiP3J+AU5hyGS6SD41uamjweB
         MnJQ==
X-Gm-Message-State: AOJu0YwWL8hs9svJBMjRTnk/E6e/0hjC859EU/+asloYYGNMdFGBAtvc
        2SM0cO7oWCQs0Jd/3LlNQ2+AMLs2Q7s=
X-Google-Smtp-Source: AGHT+IEvg/FJ+qWMR+KK5F2J12QpkOEgjFOGEicCVDp0abnar3RD+3dE5iv14sKmMq2aGfCwVBhjBQ==
X-Received: by 2002:a05:620a:410a:b0:76c:ecef:28c with SMTP id j10-20020a05620a410a00b0076cecef028cmr595311qko.57.1691715477212;
        Thu, 10 Aug 2023 17:57:57 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id i26-20020a05620a145a00b00767cdf23ee3sm863627qkl.92.2023.08.10.17.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:57:56 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
Date:   Thu, 10 Aug 2023 17:57:28 -0700
Message-Id: <20230811005732.107718-3-yury.norov@gmail.com>
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

_reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 3a589016f5e0..c9afe704fe4b 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1352,9 +1352,12 @@ EXPORT_SYMBOL(bitmap_release_region);
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
+	unsigned int nbits = pos + BIT(order);
+
 	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 		return -EBUSY;
-	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	bitmap_set(bitmap, pos, nbits);
+	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);
 
-- 
2.39.2

