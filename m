Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813B07BCDDF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbjJHKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbjJHKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:49:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D5BA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:49:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690bd59322dso2640959b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762184; x=1697366984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0bXJ89oPO1no0IVuo2PGkRvQqnJiMrSvjxvIuMh5/g=;
        b=HdSQe6/WGPb9GTnKdLdzbl6bE0Kxodvc4g8gXK1ZtTfGv9duqcA0gCOiJgvxA+jLJY
         jLdZi2eALbuN1/aSlLFP7KNNmlNb2lVS/2FIfOu7WNGPsPl0iRPogG55dhbPvXErElDa
         Ri8HX7hNYukunurigBbJxLh4GtVQPau3cBwQVvyuiQH0ZbjPbTDXJsn8E33AbVlf9xRR
         sTqG4GEgC3NxWHzZES3qwAIG+yj5xUCeqDJQzv85akGAXhXDPKS0tAw+MEG2kjyql2zk
         njLXTzMsv5KOkFhWWOayF9wudMyoHgSyl75NDkQfTXIhe6m+8OGN/3Zs4LsOj8ySfj1Q
         Hz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762184; x=1697366984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0bXJ89oPO1no0IVuo2PGkRvQqnJiMrSvjxvIuMh5/g=;
        b=OFTysyOTuvBjfgs0lk8Y9qLeezzsWcU+YaZbBRjGGWH1fbCDE4AO24ZW6555EoWQU+
         maN/k70ZTCqJ4KzcIuJT97mmDfEDSvDuexQsh15zFoErqrzlmjlGVE8YiaEh1yW4q0fo
         Pf+U8hbyLt02o9gTbjkQF0pwJYmottPsSUodoeIYcKoySRRMxDjvpOQ7VqWOfvYw5Qke
         y+wk1rMfY5/TF+0dmuBRCdFPCxyVxHYRndYxrMXXZhbgqBbsr/bvOKJA5dhuLcjUzvKQ
         kWhPCj/qjyLyXodW/A+plQrb1BCXv3tTGLg8Sfphi/IjfIsixAghNLoar9vxmBzDgWKV
         PXGg==
X-Gm-Message-State: AOJu0Yyrzr8VtNY0Fj1Gh5LqrnUu2DPiYbzFdOjZdt1gN8QUXGaQ1FML
        oW6xsA6UXn1w48PkX9F3ZFI=
X-Google-Smtp-Source: AGHT+IHG++AMBHMS7vHqSUm5FUSc1g+S+Xjse2uxT+9IdAIQVEC4rUuoEhVxOWRNaBXrul5fUnUG1w==
X-Received: by 2002:a17:90b:3554:b0:26f:a34c:90e3 with SMTP id lt20-20020a17090b355400b0026fa34c90e3mr10515879pjb.31.1696762183822;
        Sun, 08 Oct 2023 03:49:43 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090acb0b00b002630c9d78aasm6311517pjt.5.2023.10.08.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:49:43 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     bsingharora@gmail.com, juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] delayacct: introduce delayacct_enabled() to simplify implement
Date:   Sun,  8 Oct 2023 18:49:36 +0800
Message-Id: <8e5d6ed7d70ff7187a33130231783ed2c1d70841.1696761522.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1696761522.git.chunguang.xu@shopee.com>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
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

From: Chunguang Xu <chunguang.xu@shopee.com>

Introduce delayacct_enabled() to simplify the code and make it
more concise.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 include/linux/delayacct.h | 74 +++++++++++----------------------------
 kernel/delayacct.c        |  2 +-
 2 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6639f48dac36..660e534ce7c4 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -94,137 +94,103 @@ static inline void delayacct_tsk_init(struct task_struct *tsk)
 		__delayacct_tsk_init(tsk);
 }
 
+static inline bool delayacct_enabled(void)
+{
+	return static_branch_unlikely(&delayacct_key);
+}
+
 /* Free tsk->delays. Called from bad fork and __put_task_struct
  * where there's no risk of tsk->delays being accessed elsewhere
  */
 static inline void delayacct_tsk_free(struct task_struct *tsk)
 {
-	if (tsk->delays)
+	if (delayacct_enabled())
 		kmem_cache_free(delayacct_cache, tsk->delays);
 	tsk->delays = NULL;
 }
 
 static inline void delayacct_blkio_start(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_blkio_start();
 }
 
 static inline void delayacct_blkio_end(struct task_struct *p)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (p->delays)
+	if (delayacct_enabled())
 		__delayacct_blkio_end(p);
 }
 
 static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 {
-	if (tsk->delays)
+	if (delayacct_enabled())
 		return __delayacct_blkio_ticks(tsk);
 	return 0;
 }
 
 static inline void delayacct_freepages_start(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_freepages_start();
 }
 
 static inline void delayacct_freepages_end(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_freepages_end();
 }
 
 static inline void delayacct_thrashing_start(bool *in_thrashing)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_thrashing_start(in_thrashing);
 }
 
 static inline void delayacct_thrashing_end(bool *in_thrashing)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_thrashing_end(in_thrashing);
 }
 
 static inline void delayacct_swapin_start(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_swapin_start();
 }
 
 static inline void delayacct_swapin_end(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_swapin_end();
 }
 
 static inline void delayacct_compact_start(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_compact_start();
 }
 
 static inline void delayacct_compact_end(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_compact_end();
 }
 
 static inline void delayacct_wpcopy_start(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_wpcopy_start();
 }
 
 static inline void delayacct_wpcopy_end(void)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (current->delays)
+	if (delayacct_enabled())
 		__delayacct_wpcopy_end();
 }
 
 static inline void delayacct_irq(struct task_struct *task, u32 delta)
 {
-	if (!static_branch_unlikely(&delayacct_key))
-		return;
-
-	if (task->delays)
+	if (delayacct_enabled())
 		__delayacct_irq(task, delta);
 }
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..ce10b7c1ee43 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -161,7 +161,7 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->cpu_run_virtual_total =
 		(tmp < (s64)d->cpu_run_virtual_total) ?	0 : tmp;
 
-	if (!tsk->delays)
+	if (!delayacct_enabled())
 		return 0;
 
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
-- 
2.25.1

