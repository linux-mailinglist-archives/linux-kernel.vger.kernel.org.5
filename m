Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E77EAF85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjKNLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:52:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03AE8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:51:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso3954562b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699962715; x=1700567515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQsE6MJAheSr1JS9SgiuPhMANqzU/DS59G3Dz1UiP2A=;
        b=Zrz6UHW+l+zm7zs00uAA/OSTwi6PT5mTFavObklPqD5HW75zrai+mCk7Oh9RlRITIZ
         s/wW0LabID79Ys2F8ENaN/sWys4x8N2bmRzAzAkUmFy/c3tf/7M5zVdWluLF6IVjCueu
         hS/dRk/CFJRlPaDsMXqR71BSHR8xPWA5+lC8xe38zrUHhZDXvuuomnaAaP/8qjnP5Rjh
         ed5H2kKv9ZNcR7bSaocV3aCcr08robyf9s8sPTBd0rXczzinIRM9Qd36V93MtC7qgD8g
         VZd4aAgrDnvu7i5ItgzWUo/21Ud9Yden/vt80GDer/9gvdlNrvpYWv+3rJpNqF9Y4wxk
         stCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699962715; x=1700567515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQsE6MJAheSr1JS9SgiuPhMANqzU/DS59G3Dz1UiP2A=;
        b=K3Hg7E1bvVquijmssY82T9+RgGmDtYfsfgi8xtujqKHXU59lirclY8PfMUf5KWCPkl
         AioAYWFyK+O9SO4J0kLW91DWI1yAhI/f1D2NPbIQJGFVnUnta3Fb39RrdAseOwKZPJs4
         DTdKi/CGr8upNxz6su6aXcp6BDieoU0fYfusxFwB1iIdAjJSj7uQTLP1tuwZRyOI0yDF
         2LjxuYgZnVV4GtqGoHsp1+HTNbeLDVenGdN2nUYt+vyFXosbyoKLEA+hJFNHMhRgmOkm
         0YHoaOkl+h2euo9CDUfnOgNMzqwSAs0WrBO7HcnaB1DNUtIBaqeq6Jt1jC5VmYkMY6nD
         3lhA==
X-Gm-Message-State: AOJu0YxFndes55v3iuHxx2oj6HOsKO5bdqwa5L1iDqxyV9nnhy0azX9b
        hWwwnz4I8JiMZ43JcsTZWdvYtA==
X-Google-Smtp-Source: AGHT+IEgDgB7Xz7YhugvEapNGfl8R3U9Nh07N+hCnctczvS4wBz/Tw5YCEgcucdCS/1o1oJjWjfisw==
X-Received: by 2002:a05:6a00:2794:b0:6c3:775e:be12 with SMTP id bd20-20020a056a00279400b006c3775ebe12mr10386588pfb.22.1699962715138;
        Tue, 14 Nov 2023 03:51:55 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006c871f3ad1csm760523pfc.71.2023.11.14.03.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:51:54 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mattwu@163.com, "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v1] lib: objpool: fix head overrun on RK3588 SBC
Date:   Tue, 14 Nov 2023 19:51:48 +0800
Message-Id: <20231114115148.298821-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objpool overrun stress with test_objpool on OrangePi5+ SBC triggered the
following kernel warnings:

    WARNING: CPU: 6 PID: 3115 at lib/objpool.c:168 objpool_push+0xc0/0x100

This message is from objpool.c:168:

    WARN_ON_ONCE(tail - head > pool->nr_objs);

The overrun test case is to validate the case that pre-allocated objects
are insufficient: 8 objects are pre-allocated for each node and consumer
thread per node tries to grab 16 objects in a row. The testing system is
OrangePI 5+, with RK3588, a big.LITTLE SOC with 4x A76 and 4x A55. When
disabling either all 4 big or 4 little cores, the overrun tests run well,
and once with big and little cores mixed together, the overrun test would
always cause an overrun loop. It's likely the memory timing differences
of big and little cores cause this trouble. Here are the debugging data
of objpool_try_get_slot after try_cmpxchg_release:

    objpool_pop: cpu: 4/0 0:0 head: 278/279 tail:278 last:276/278

The local copies of 'head' and 'last' were 278 and 276, and reloading of
'slot->head' and 'slot->last' got 279 and 278. After try_cmpxchg_release
'slot->head' became 'head + 1', which is correct. But what's wrong here
is the stale value of 'last', and that stale value of 'last' finally led
the overrun of 'head'.

Memory updating of 'last' and 'head' are performed in push() and pop()
independently, which could be the culprit leading this out of order
visibility of 'last' and 'head'. So for objpool_try_get_slot(), it's
not enough only checking the condition of 'head != slot', the implicit
condition 'last - head <= nr_objs' must also be explicitly asserted to
guarantee 'last' is always behind 'head' before the object retrieving.

This patch will check and try reloading of 'head' and 'last' to ensure
'last' is behind 'head' at the time of object retrieving. Performance
testings show the average impact is about 0.1% for X86_64 and 1.12% for
ARM64. Here are the results:

    OS: Debian 10 X86_64, Linux 6.6rc
    HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
                      1T         2T         4T         8T        16T
    native:     49543304   99277826  199017659  399070324  795185848
    objpool:    29909085   59865637  119692073  239750369  478005250
    objpool+:   29879313   59230743  119609856  239067773  478509029
                     32T        48T        64T        96T       128T
    native:   1596927073 2390099988 2929397330 3183875848 3257546602
    objpool:   957553042 1435814086 1680872925 2043126796 2165424198
    objpool+:  956476281 1434491297 1666055740 2041556569 2157415622

    OS: Debian 11 AARCH64, Linux 6.6rc
    HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
                      1T         2T         4T         8T        16T
    native:     30890508   60399915  123111980  242257008  494002946
    objpool:    14742531   28883047   57739948  115886644  232455421
    objpool+:   14107220   29032998   57286084  113730493  232232850
                     24T        32T        48T        64T        96T
    native:    746406039 1000174750 1493236240 1998318364 2942911180
    objpool:   349164852  467284332  702296756  934459713 1387898285
    objpool+:  348388180  462750976  696606096  927865887 1368402195

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 lib/objpool.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/objpool.c b/lib/objpool.c
index ce0087f64400..cfdc02420884 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -201,6 +201,23 @@ static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
 	while (head != READ_ONCE(slot->last)) {
 		void *obj;
 
+		/*
+		 * data visibility of 'last' and 'head' could be out of
+		 * order since memory updating of 'last' and 'head' are
+		 * performed in push() and pop() independently
+		 *
+		 * before any retrieving attempts, pop() must guarantee
+		 * 'last' is behind 'head', that is to say, there must
+		 * be available objects in slot, which could be ensured
+		 * by condition 'last != head && last - head <= nr_objs'
+		 * that is equivalent to 'last - head - 1 < nr_objs' as
+		 * 'last' and 'head' are both unsigned int32
+		 */
+		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
+			head = READ_ONCE(slot->head);
+			continue;
+		}
+
 		/* obj must be retrieved before moving forward head */
 		obj = READ_ONCE(slot->entries[head & slot->mask]);
 
-- 
2.40.1

