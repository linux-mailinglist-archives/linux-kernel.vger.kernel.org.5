Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778D578BCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjH2Cj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjH2CjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62857CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bd066b0fd4so2649869a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276757; x=1693881557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKyaL6L4bgunsABP04Ms41wHAbdnN+iVX6+0TH71sYQ=;
        b=X/JzL3Qv7uFXDscK0ih8PDh4PXidjku3vi+73IEaLgriu45KriE7cXTMAaPgB3QSsH
         OEYalXoIgHwQhYEfzSnco6xby9MimJbiw9H9Kb+fQb7bpu8kNjUNBxrN5C9aVYR1Y2Rk
         HxW6Fsvuka+CuFxSGPjpMubcH9ODkUwArGmf7b0JQ70EM+mGKE734pVGfZlLmbP26fdw
         ArNkWNUOhw/amx0QpBIYrduF1IodueK2t/4vV91G94Jb+/xl0T7k21vpNkLS7/FxXT25
         2Pkc7ZPoTu1xqDqyn107uWk9TbLRd/m2/vP+jgRNDtAppkgyufbeRLKQNdIdQAdl0qKM
         GX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276757; x=1693881557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKyaL6L4bgunsABP04Ms41wHAbdnN+iVX6+0TH71sYQ=;
        b=FMry0yUmvqdkbZnri7R9wERmIUXPbWi3WcZOMPQPCwhdQGkF4YPQUVGcIVnHMGCVqN
         xyymb68hNQSqjM2z3VXXOqE3sGeFRlG0BxsY0rVgVyIjy5FnD/qt98irEDke9ODzy3Kf
         /kXxfz2xjgm19Nu7O2pmseOv4WcU+roECX5FRqhZwCqJOgAEOQeI0iCVeN3is5rNmAh3
         K9TcOQeFJf8Lf6WPnWZgdSzz0WfCqgyMw/QHYTvII1yozlG61C4/UntUK/kJaDsDOyP+
         UorjPxI+o2wKO6D66Q2lgQjHOgz8GrejRAfsfD62sFTGSUggvHKLcElDPWBHGPFJmPVL
         kn0A==
X-Gm-Message-State: AOJu0YwgN/soukdi7C/xwmulmV+FxyFNmmp9msfcvbYtfU6cy4TODjWn
        xDSZgkRWSbly14B5RVwkqtvgX6GrYpo=
X-Google-Smtp-Source: AGHT+IFnzTnWB9ZsD1rGaOSQX00OJfa6VcFJ8CS3D4WVvCgy5iX0g9gmx/r+toCDhs7Ve4WzpcFkDg==
X-Received: by 2002:a05:6830:1314:b0:6bd:a47:7bb6 with SMTP id p20-20020a056830131400b006bd0a477bb6mr13322361otq.14.1693276757228;
        Mon, 28 Aug 2023 19:39:17 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id q24-20020a05683033d800b006b9348b6f51sm3893008ott.54.2023.08.28.19.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:16 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 2/8] bitmap: add test for bitmap_*_region() functions
Date:   Mon, 28 Aug 2023 19:39:05 -0700
Message-Id: <20230829023911.64335-3-yury.norov@gmail.com>
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

Test basic functionality of bitmap_{allocate,release,find_free}_region()
functions.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index f2ea9f30c7c5..65f22c2578b0 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -330,6 +330,29 @@ static void __init test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
+static void __init test_bitmap_region(void)
+{
+	int pos, order;
+
+	DECLARE_BITMAP(bmap, 1000);
+
+	bitmap_zero(bmap, 1000);
+
+	for (order = 0; order < 10; order++) {
+		pos = bitmap_find_free_region(bmap, 1000, order);
+		if (order == 0)
+			expect_eq_uint(pos, 0);
+		else
+			expect_eq_uint(pos, order < 9 ? BIT(order) : -ENOMEM);
+	}
+
+	bitmap_release_region(bmap, 0, 0);
+	for (order = 1; order < 9; order++)
+		bitmap_release_region(bmap, BIT(order), order);
+
+	expect_eq_uint(bitmap_weight(bmap, 1000), 0);
+}
+
 #define EXP2_IN_BITS	(sizeof(exp2) * 8)
 
 static void __init test_replace(void)
@@ -1227,6 +1250,7 @@ static void __init selftest(void)
 	test_zero_clear();
 	test_fill_set();
 	test_copy();
+	test_bitmap_region();
 	test_replace();
 	test_bitmap_arr32();
 	test_bitmap_arr64();
-- 
2.39.2

