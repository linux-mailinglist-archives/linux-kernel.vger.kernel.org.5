Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF57C774264
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjHHRny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHHRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:43:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71112498D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:19:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-768270326b8so635552285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511526; x=1692116326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7oKrmXIz3NsRfcR5MFYJZeuPXTlZNmpPB/o29ITFQI=;
        b=LLaqBjd4f9hbhCmCTs/5WF+B22WR06Nz5JfC3U/hQ039kYEniV8mrgEbjikVq8JmJc
         +T2SsO4OY9e/yAStgVCOlsw/5FkXzB7XGI4clM5VCCYXOjAT2U2ucFzuji/jyu158Xm7
         dxN+xf9ApfXv5/X0HWNbsFcfEwGRjOlJIDdUHOH9+fvU1nxmfctrtAsMPgKSRmCOtI75
         H7bll04PyL/XJiTFQZkIsCkfEgWILdiO2krCpgIUCAnf99+LmGYS3d9CgnMmjjA2EFpO
         s9ObvxNOK8JZHO3z3SRsF3AGXKXJV3rO9EWDsvnSTYIKiXAJfFhQ+laT1aTRsIelUvoa
         84Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511526; x=1692116326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7oKrmXIz3NsRfcR5MFYJZeuPXTlZNmpPB/o29ITFQI=;
        b=NW90u6VRRU6J/VAjR8pPHXhIoRj1avDuxo5+XeOVMiN9tyWbcHrkP8EQuoqNRdNOFI
         T6RTtuzr16MeU1N5Cg8mM8l4ZkXsNu4T/gIIqBqORQChgl39G6XQCHac9SBg63wUdfnE
         PXYcGDYNVu+mKoSfzHU9rQnkgZ805WP/Oyx9LNgpgQMkXKLJNluRhQ61VLL+HXBtjQeM
         QJgtUGpkm40SmQnD46CTS6gUGAokezM3rvI0iX01Gv64PWJ/h1F8EzpG/pql1ZaYPnjT
         lmCS83bC5XyiFF52f4NMSVEzXkKrBjcWb9jKDPSBqDd1LLD/Ds5vFUGzhQZUzXxe6JKg
         PiAg==
X-Gm-Message-State: AOJu0Yza0Ic5g8nht/7kSmMsYGTUV0NnVhletPoNRptVrW829Vt8QR8G
        rX84J9CKdioFVqlmnD/Wal2SmavseiWFrVV8yXxobrMPAYxdB77dBGsLNrBV5X+ahVKkjV7+gVc
        zb+HIL/tkrphWBSzvPdtal2YKY0lgPyJRiimLUYRwxTktPxMqEipvVNtBnJxM5fHI8K9i+Pc=
X-Google-Smtp-Source: AGHT+IGhdd9/6FpupVF/U/x4zx4Q8zbIJse0Sw4k06GfTMBc1OKW4ryDOJLK8I94bNfoJOyeIuXYWgoXYFFf
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:6d8c:0:b0:563:4342:4307 with SMTP id
 i134-20020a636d8c000000b0056343424307mr41016pgc.2.1691476024079; Mon, 07 Aug
 2023 23:27:04 -0700 (PDT)
Date:   Tue,  8 Aug 2023 06:26:41 +0000
In-Reply-To: <20230808062658.391595-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230808062658.391595-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808062658.391595-2-jstultz@google.com>
Subject: [RFC][PATCH 1/3] test-ww_mutex: Use prng instead of rng to avoid
 hangs at bootup
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting w/ qemu without kvm, I noticed we'd sometimes seem to get
stuck in get_random_u32_below(). This seems potentially to be
entropy exhaustion (with the test module linked statically, it
runs pretty early in the bootup).

I'm not 100% sure on this, but this patch switches to use the
prng instead since we don't need true randomness, just mixed up
orders for testing ww_mutex lock acquisitions.

With this patch, I no longer see hangs in get_random_u32_below()

Feedback would be appreciated!

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Li Zhijian <zhijianx.li@intel.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/test-ww_mutex.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 93cca6e69860..9bceba65858a 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -9,7 +9,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
@@ -386,6 +386,19 @@ struct stress {
 	int nlocks;
 };
 
+struct rnd_state rng;
+DEFINE_SPINLOCK(rng_lock);
+
+static inline u32 prandom_u32_below(u32 ceil)
+{
+	u32 ret;
+
+	spin_lock(&rng_lock);
+	ret = prandom_u32_state(&rng) % ceil;
+	spin_unlock(&rng_lock);
+	return ret;
+}
+
 static int *get_random_order(int count)
 {
 	int *order;
@@ -399,7 +412,7 @@ static int *get_random_order(int count)
 		order[n] = n;
 
 	for (n = count - 1; n > 1; n--) {
-		r = get_random_u32_below(n + 1);
+		r = prandom_u32_below(n + 1);
 		if (r != n) {
 			tmp = order[n];
 			order[n] = order[r];
@@ -625,6 +638,8 @@ static int __init test_ww_mutex_init(void)
 
 	printk(KERN_INFO "Beginning ww mutex selftests\n");
 
+	prandom_seed_state(&rng, get_random_u64());
+
 	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
 	if (!wq)
 		return -ENOMEM;
-- 
2.41.0.640.ga95def55d0-goog

