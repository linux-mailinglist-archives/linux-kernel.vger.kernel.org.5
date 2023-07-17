Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B89755C16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGQGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGQGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:50:04 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D408E40
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:50:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34637362297so22068005ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689576599; x=1692168599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0/uT8T+DtOLvk7VVHi5K8JLtFZW6znqNmYr+1FCVNQ=;
        b=AYZeZtw3BBwjsiog+NTNFnVu7tIWAKy0Ltu68XiI6XcYzGFkpJUK6lisjGmCy30XY+
         M9P/Bu9u6fxGYc/L7dc+u82lqEZpycPhfhbI25lbQHWcWVWebD7MbluDoXRzsGhqOe8g
         cTEMxgF2/Ke8El5EHg+SWiy1i6AM5zyrs8tbtehPaKKWfkA2FneTsQfNPLKM90RPbgHn
         kOg4MVac2iDR8f0REUgN+P1k04SK0oosDJRfLD2acluKHxZr/y7cbjfFK4qrYDsYY8h2
         QBBP175lg8NZsI1jRbO3wF1+fIMWgh5wTbYRnyFl4pVl/CscabGV9twbQeSwnpYpn79S
         abXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576599; x=1692168599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0/uT8T+DtOLvk7VVHi5K8JLtFZW6znqNmYr+1FCVNQ=;
        b=j2fziQDyShrK6gTdaheeca3N8x9sHYc6+lD+6UHKBAg8i1O1yS2SpKAkA30XBoeQkn
         c0DFbTVBuAHi6itZF+2Qoy99edrXUGiEzkCZi0S9P4TMaVL/CxNo9vlgIoRvpsVIkc9f
         5F4C47eY6vzgNf59FwfEi4K6ceMWykF08uuk1jGNDr8YcxEKTQIkvWSvq8Jj9J6BkRFA
         FXpzBEl12eZv3JYzLA3r5qkMzGs243qUdF0c4fUtxdTg3lE+oz5QqADMfgFYV2+gXP4K
         WfpweGI9eEw2iTh3xSDLBdZlQHNZhbd/auwk9cUka7ao1cHApucUArto3QS2EQsOrH/N
         +NeQ==
X-Gm-Message-State: ABy/qLZb3BxPtJsQpyBlO3Hibnrbx9AGA1ggT5DxitkXiY/7vdqBFXxU
        PrjO+4yXiEhLvY5EvNnKQQwbzCK0nqhbuVd9
X-Google-Smtp-Source: APBJJlG6KWY3GSdTr5CJBTl8eVp3evgkjThaS9ig+iYqoPp0yNcV0/YYs+jfOSO9LLQAlZ0512Rz6w==
X-Received: by 2002:a05:6e02:20ed:b0:348:8ebc:835d with SMTP id q13-20020a056e0220ed00b003488ebc835dmr463242ilv.8.1689576599464;
        Sun, 16 Jul 2023 23:49:59 -0700 (PDT)
Received: from ubuntu2204.ims1.cht.com.tw (111-240-187-4.dynamic-ip.hinet.net. [111.240.187.4])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a01c600b00256bbfbabcfsm4767290pjd.48.2023.07.16.23.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:49:59 -0700 (PDT)
From:   Chin Yik Ming <yikming2222@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Chin Yik Ming <yikming2222@gmail.com>
Subject: [PATCH] sched: Fixed typo in comment
Date:   Mon, 17 Jul 2023 14:49:52 +0800
Message-Id: <20230717064952.2804-1-yikming2222@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_struct's state member is prefixed by "__"

Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
---
 include/linux/sched.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814..942c61dce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -75,14 +75,14 @@ struct user_event_mm;
  * Task state bitmask. NOTE! These bits are also
  * encoded in fs/proc/array.c: get_task_state().
  *
- * We have two separate sets of flags: task->state
+ * We have two separate sets of flags: task->__state
  * is about runnability, while task->exit_state are
  * about the task exiting. Confusing, but this way
  * modifying one set can't modify the other one by
  * mistake.
  */
 
-/* Used in tsk->state: */
+/* Used in tsk->__state: */
 #define TASK_RUNNING			0x00000000
 #define TASK_INTERRUPTIBLE		0x00000001
 #define TASK_UNINTERRUPTIBLE		0x00000002
@@ -92,7 +92,7 @@ struct user_event_mm;
 #define EXIT_DEAD			0x00000010
 #define EXIT_ZOMBIE			0x00000020
 #define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
-/* Used in tsk->state again: */
+/* Used in tsk->__state again: */
 #define TASK_PARKED			0x00000040
 #define TASK_DEAD			0x00000080
 #define TASK_WAKEKILL			0x00000100
@@ -173,7 +173,7 @@ struct user_event_mm;
 #endif
 
 /*
- * set_current_state() includes a barrier so that the write of current->state
+ * set_current_state() includes a barrier so that the write of current->__state
  * is correctly serialised wrt the caller's subsequent test of whether to
  * actually sleep:
  *
@@ -196,9 +196,9 @@ struct user_event_mm;
  *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
  * where wake_up_state()/try_to_wake_up() executes a full memory barrier before
- * accessing p->state.
+ * accessing p->__state.
  *
- * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
+ * Wakeup will do: if (@state & p->__state) p->__state = TASK_RUNNING, that is,
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
  * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
  *
-- 
2.34.1

