Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368CC78B772
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjH1SoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjH1SoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:04 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E4BF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:02 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bcae8c4072so2410184a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248241; x=1693853041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rqkvZA+m4Co7mK4wIInGc1Yx/+x+E1K3USzQUDzsT0=;
        b=Livc0PaChEpmZbX7QTsKnliy45x50RNaWbynGVLdkowAwOQXuqHGksuZE8h2JEuXoz
         VBQCh89e95HwaCY1PGwLd5C9brm982As1qibqaQ9iBjkmP0wlBABfgLyAr8fcpE+Ka1t
         P4nA5PfaZITh2Hk2st+NSCryf3Jq6S3Xz/5v6+sCggPMWV6nZ9+40++J9HSXJ7B+rHQ9
         UL8tt0RtOltoSM5k4wPJ651DNHL3bBwP8ul5J8Po1vVSBdWSAIoz7Jh7A7hR6k+EQ8bZ
         T5g0jZUgSKJW5rrt1e89dByliwTF0TsknbGaguWfO0baC2WuJRzSIdXPqjumj5lKRgX7
         s6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248241; x=1693853041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rqkvZA+m4Co7mK4wIInGc1Yx/+x+E1K3USzQUDzsT0=;
        b=mDb6Qwhhg9bytY31DiBZgb15ux0LAaJnKqcTfSj3/2Zm8WGghl7T8TsHQOZwxjFizQ
         oqO5ay6wlhYjo55+jM75kdqt649TJLiqxRLC3JWJQel6S9mluNWLvhTbJe557PYtiyx9
         MQ+MU/nFXvyhoMA8fpZDzFbm6FORhQMMelJ+78ipy+9tS3qYC9ntYSrgDaqltreYgREK
         yqboCPlFYcdFdYqGC9yaKOdZUxjEmNfHEx2Vl+JNra1FZpuBT8j+Dk8PXM5KC/gjVY7T
         PaQ9PPLVB4LWOjvoD8YmKhXvM2XeV5kwrpIjP0VhHm9nbvqnjKNEuOhJdpHGjIL8y1JG
         f8Sg==
X-Gm-Message-State: AOJu0YwaYqt+O0f3BqTk10/011UA+eU9l7kv21iPWxKzM3aiK0qsMWPv
        kn7Q3DXPfP+OImEm+xGkcIxqT88A3Lw=
X-Google-Smtp-Source: AGHT+IEnxhLP+YPYgRbroOpWL+D5N3R7se11xwTu4MXZi2EgoCg3hUnwljJbUCKkbgine9QclHEofg==
X-Received: by 2002:a05:6871:69e:b0:1bf:12ff:db2c with SMTP id l30-20020a056871069e00b001bf12ffdb2cmr10761239oao.22.1693248241229;
        Mon, 28 Aug 2023 11:44:01 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id g6-20020a056870340600b001cd316935c6sm2627296oah.54.2023.08.28.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:00 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 03/12] bitmap: add test for bitmap_remap()
Date:   Mon, 28 Aug 2023 11:43:43 -0700
Message-Id: <20230828184353.5145-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
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

Basic functional and performance tests for bitmap_remap(). 1000 bits
length is chosen for performance test because it's of the same order
as default value for MAX_NUMNODES in major distros like Ubuntu (1024).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index a5d823f7589d..e1c22d399f24 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -378,6 +378,85 @@ static void __init test_weight(void)
 	}
 }
 
+static void __init test_remap(void)
+{
+	DECLARE_BITMAP(dst, 8);
+
+	DECLARE_BITMAP(empty, 8) = { 0 };
+	DECLARE_BITMAP(src, 8) = { 0b00101010 };
+	DECLARE_BITMAP(old, 8) = { 0b00011100 };
+	DECLARE_BITMAP(new, 8) = { 0b00111000 };
+	DECLARE_BITMAP(exp0, 8) = { 0b00110010 };
+	DECLARE_BITMAP(exp1, 8) = { 0b00011010 };
+	DECLARE_BITMAP(exp2, 8) = { 0b10000010 };
+
+	DECLARE_BITMAP(perf_exp, 1000);
+	DECLARE_BITMAP(perf_dst, 1000);
+	DECLARE_BITMAP(perf_src, 1000);
+	DECLARE_BITMAP(perf_old, 1000);
+	DECLARE_BITMAP(perf_new, 1000);
+
+	unsigned int i;
+	ktime_t time;
+
+	bitmap_remap(dst, src, old, new, 8);
+	expect_eq_bitmap(exp0, dst, 8);
+
+	/*
+	 * When old mapping is the same as new, source bits are copied to dst.
+	 * Real code must use bitmap_copy() if it's known in advance.
+	 */
+	bitmap_remap(dst, src, old, old, 8);
+	expect_eq_bitmap(src, dst, 8);
+
+	bitmap_remap(dst, src, new, new, 8);
+	expect_eq_bitmap(src, dst, 8);
+
+	/*
+	 * When either old or new mappings are empty, source bits are copied to
+	 * dst. Real code must use bitmap_copy() if it's known in advance.
+	 */
+	bitmap_remap(dst, src, empty, new, 8);
+	expect_eq_bitmap(src, dst, 8);
+
+	bitmap_remap(dst, src, old, empty, 8);
+	expect_eq_bitmap(src, dst, 8);
+
+	bitmap_remap(dst, src, empty, empty, 8);
+	expect_eq_bitmap(src, dst, 8);
+
+	/* Set extra bit in old map to test carry logic */
+	set_bit(5, old);
+	bitmap_remap(dst, src, old, new, 8);
+	expect_eq_bitmap(exp1, dst, 8);
+
+	/* Map old bits to #7 */
+	bitmap_zero(new, 8);
+	set_bit(7, new);
+	bitmap_remap(dst, src, old, new, 8);
+	expect_eq_bitmap(exp2, dst, 8);
+
+	bitmap_fill(perf_src, 1000);
+	bitmap_set(perf_old, 0, 500);
+	bitmap_clear(perf_old, 500, 500);
+
+	for (i = 0; i < 1000; i += 20) {
+		bitmap_set(perf_new, i, 10);
+		bitmap_clear(perf_new, i + 10, 10);
+	}
+
+	bitmap_copy(perf_exp, perf_new, 500);
+	bitmap_set(perf_exp, 500, 500);
+
+	time = ktime_get();
+	bitmap_remap(perf_dst, perf_src, perf_old, perf_new, 1000);
+	time = ktime_get() - time;
+
+	expect_eq_bitmap(perf_exp, perf_dst, 1000);
+	pr_err("bitmap_remap:  %llu ns\n", time);
+
+}
+
 #define EXP2_IN_BITS	(sizeof(exp2) * 8)
 
 static void __init test_replace(void)
@@ -1278,6 +1357,7 @@ static void __init selftest(void)
 	test_bitmap_region();
 	test_replace();
 	test_weight();
+	test_remap();
 	test_bitmap_arr32();
 	test_bitmap_arr64();
 	test_bitmap_parse();
-- 
2.39.2

