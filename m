Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B823D7AA7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjIVEgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjIVEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:36:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6770F192
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:30 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-690c2fec489so1666309b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695357390; x=1695962190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/KUuuQt1wtLnvbtfLVYFf0YPn4pz5Wk+u9cse4uVUE=;
        b=g0DrD1J3I/aBzq1Qo1EPcvjmJzgMiJ7/EkxODsE9SfoSVZYfby0JdYQaQgapzAquBI
         MqQpezaUPoCRhxSkDEv0cqDG/zZSAENwct5dQ3kcOv51udpojGyZuvSQcePfPMk0st5S
         /DMEuRM2wVCZgTyRHn7cwbO8gFnjbhuOAuFmwO3P7kGPocjCnXApXX1kqykNoDW5km+o
         7bvZxD2gsr1WhwFOo26L/mn3j3pzB4820BZIj8SpvU+C/Sb3l5x7UaL/It0yisa1QRsj
         JXk5GDF8iC7AXwu+tL4G3g/Ob77HOLlTD1skRkhz/JmilgpA7vKwH28A8bRLY4lQSvl8
         tLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357390; x=1695962190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/KUuuQt1wtLnvbtfLVYFf0YPn4pz5Wk+u9cse4uVUE=;
        b=Zk5TwSpS8IkexpdbsRmYHMald7app7AWG9tWIS/XrGySl2pzzsUBwtRnrMlPVz+Buw
         BnDkHGu8HWUD5XixNJDNOHGuPFRMj+DDqM8e9bfRWKg5m51aW4R7dBRy35u1T3u9xHz6
         TKrbjCNI+D4FAKK/vR3Q4lS9jAOPlWsW10iFahnALpu8kplVsgaB7OaULPzqEGLcKMIi
         UWe2SF9e4noxv1jVMfQIgfIBiG3yFhtMMbSVGbIV+4Fa0jHy1dVRSWzzo0EoLwE98yTg
         bvFyR1d/SbzEs4hnq+aHacXD5qX2gQ1qO1Ojtiv0XncrC2guMORdfSb79KtUTZ4EIO2i
         D80w==
X-Gm-Message-State: AOJu0YwB+bbnZzcTMfucM3RR/XeAmr7BN1BM7jWGakfDkbLVNe2KSoB5
        hC0A5mAap6O9uhULn4xJTK2+kI2Gb04q030IvBelysmh0ln/8UzOCUZd1Zjux3D9u66Nu9e5wvX
        SIosWncvCF0AOrw5QAen7J7UKebg17JQL49E5qj+oCtWmdV9kR4SNFAY8T649yOH0Ip79bFg=
X-Google-Smtp-Source: AGHT+IECV1YgzUdYwFj51w3+MPI0hZIbAXhqIaJV6YqJbBEazjIHb5LEGCWnetMW+pkWTk6eGtYnxd4OSB2N
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:c91:b0:690:3793:17f9 with SMTP id
 a17-20020a056a000c9100b00690379317f9mr127074pfv.6.1695357389355; Thu, 21 Sep
 2023 21:36:29 -0700 (PDT)
Date:   Fri, 22 Sep 2023 04:36:01 +0000
In-Reply-To: <20230922043616.19282-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230922043616.19282-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922043616.19282-4-jstultz@google.com>
Subject: [PATCH 3/3] test-ww_mutex: Make sure we bail out instead of livelock
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, Li Zhijian <zhijianx.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen what appears to be livelocks in the stress_inorder_work()
function, and looking at the code it is clear we can have a case
where we continually retry acquiring the locks and never check to
see if we have passed the specified timeout.

This patch reworks that function so we always check the timeout
before iterating through the loop again.

I believe others may have hit this previously here:
https://lore.kernel.org/lkml/895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com/

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Reported-by: Li Zhijian <zhijianx.li@intel.com>
Link: https://lore.kernel.org/lkml/895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/test-ww_mutex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 358d66150426..78719e1ef1b1 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -465,17 +465,18 @@ static void stress_inorder_work(struct work_struct *work)
 			ww_mutex_unlock(&locks[order[n]]);
 
 		if (err == -EDEADLK) {
-			ww_mutex_lock_slow(&locks[order[contended]], &ctx);
-			goto retry;
+			if (!time_after(jiffies, stress->timeout)) {
+				ww_mutex_lock_slow(&locks[order[contended]], &ctx);
+				goto retry;
+			}
 		}
 
+		ww_acquire_fini(&ctx);
 		if (err) {
 			pr_err_once("stress (%s) failed with %d\n",
 				    __func__, err);
 			break;
 		}
-
-		ww_acquire_fini(&ctx);
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-- 
2.42.0.515.g380fc7ccd1-goog

