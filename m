Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0337B4662
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjJAIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjJAIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:51:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8436B3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 01:51:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-327be5fe4beso310980f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696150276; x=1696755076; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fK8C+2KBdUOl+wUgjWnV9QkDzr0lfjpNjwPIUDoQ8ck=;
        b=L/rFCagj36dTQkBeFQohYWf1HJcJjiz4Z22PNcbNBuRaRwqyb+60wX+s0ybRSmZ2NC
         xFlKBbEWJzaIMJJf89rf3TvDC+fsaGJh4PYVuHhLsKSKPgB6wrtAZeBoZ0NbcjsTc3ne
         vpcny5kYjtSjLhRvO0e516CFrrKafejLJiEej+PMzB/NbGkyQ35RB6Vu9BhM7Jk3XxRx
         +S7lH8KQiyMwRBsabJCEXlLdQkSgHRAdD19vufQuKxRePbxOJKmztGqO10agCd/A8vf0
         /ekB2kkG10hG2GDrbEcrGoTRFa3vFlVmpqPZrs70HeZ7i+GQjOEWJxHv0YZ2y8Zx8Zu5
         NugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696150276; x=1696755076;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK8C+2KBdUOl+wUgjWnV9QkDzr0lfjpNjwPIUDoQ8ck=;
        b=MmNLjK7UUbISfihvmNDP9aIgEOyF3juD/ccCb2BPElNJ9OAqJuePzkoVT+eaNF4eJE
         kSe5SJuI9gMKkE6yWPfOaqTM3fF38ItEKjJ+e2NCswaDBNeAG2sMGMagHmEoSymyfUyi
         2WUOXfEtzO1R/+DBikebk0bqy0EtkOK0uAnuahiMaCXbn6s28w+tP961AOX+jgZ52CEN
         VWkQX5q2mYKQHY6ljeOeAPnKj6jK2e5p3UuKntGOlzWqv5ycqAe76Y+o7YOaW2OBzDvF
         KF1JZa74IJUmOBMdCaAGR3dJ0kuQ1Xjtg2v+tRpzXFFjSsCR0kQ7/GHHmbmCOvxckZJy
         QTFQ==
X-Gm-Message-State: AOJu0YwuY3sq/1IvJ9tFhT3lNt91Fn7qV864D/nNv6EeHmZk0NLWFgSh
        7AsSLtSlAMt3jMySyfyurfXVqoJmI+c=
X-Google-Smtp-Source: AGHT+IHGO/X/kpv3AJfMY5VfdhmYkcLOGneBVaZvN6PwKujeKN+mXgRRvxu4zIPPGVHNomXgfbpGCw==
X-Received: by 2002:a5d:4532:0:b0:31f:ec91:39a3 with SMTP id j18-20020a5d4532000000b0031fec9139a3mr7091112wra.30.1696150275635;
        Sun, 01 Oct 2023 01:51:15 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id 11-20020a056000156b00b0032485046055sm7539102wrz.5.2023.10.01.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:51:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 1 Oct 2023 10:51:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timers fix
Message-ID: <ZRkzAN0rpNWCarZf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-10-01

   # HEAD: 1a6a464774947920dcedcf7409be62495c7cedd0 timers: Tag (hr)timer softirq as hotplug safe

Fix a spurious kernel warning during CPU hotplug events that
may trigger when timer/hrtimer softirqs are pending, which
are otherwise hotplug-safe and don't merit a warning.

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (1):
      timers: Tag (hr)timer softirq as hotplug safe


 include/linux/interrupt.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..4a1dc88ddbff 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,8 +569,12 @@ enum
  * 	2) rcu_report_dead() reports the final quiescent states.
  *
  * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
+ *
+ * _ (HR)TIMER_SOFTIRQ: (hr)timers_dead_cpu() migrates the queue
  */
-#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(TIMER_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ) |\
+				   BIT(HRTIMER_SOFTIRQ) | BIT(RCU_SOFTIRQ))
+
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
