Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8987D825E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbjJZMQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjJZMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:16:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D8B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:16:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9d132d92cso1655075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698322596; x=1698927396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO8QG8mtg640mQEHVkNaf9/uSEs9JeitYsu0UTItPaY=;
        b=EYx9yii6b/rzXBx4KU4/nBrcHsWJJDsvR95ktWQNk5/13R79Jz625TL2w01wyfjl6q
         okJYH9N1nupXgBF7Agjt0nCaNRm35IZJOdttUtb+hks6gf+zpuYTQYlzZVveu6uV9eDR
         extzggeGHZs0SQdvj0383gl1jiaALrVSoT58oeu28F5p49TEJBtFw1dh8fM0F6QzUySo
         3hfvfMTP9splfwBNi0zhoTs/pvQPlN39ctYGKTMlGP43tThv3h6aAcWlqp6+lAXqsjZE
         ESbLzG/4cDLlk4RiGjzBc4NPyz/LyWy/a8ryIPY38UJp7WMzJ1vmOJhG0GyY2Ay40hfh
         rt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322596; x=1698927396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO8QG8mtg640mQEHVkNaf9/uSEs9JeitYsu0UTItPaY=;
        b=IGGWe6h4yGBhbHkyxrAHncNk0RVyW2Y3a6J57j88ky7BHm8gOJk3lzx7zOhbIP3yHx
         lfW0cHY2k+0OVi+uBIQu94uRzhBUgp6tE+W5t5Pp0il5P/j6cw/HFeJDLTDvcwj7gHH8
         yobrF6r4OAOhA24SkuAo9p2fqi2Z8NNiUX5B3wffO3zb/Qb87gd3NmPAWRvkEuCnYlkS
         rG98C70hZnDPgzBJisTS4noPlJ9/x/jUHYaUR/BprsVr/oC55jDtY7M1cwS/x5S2NWKP
         9AnDQSwsXDg616d0FqKbU53WQUnWn3oBG+gv2lvS+g8AYYHgVjiK1wGN5HdAqDaNdaqz
         a8zw==
X-Gm-Message-State: AOJu0YxN9XizcCMXsC+QquKqxCiCrnLYYgBFNolNsEtX7PE4DdKgp7xR
        AMmqnU4G9yFu0D1PRmHH52g=
X-Google-Smtp-Source: AGHT+IEx/OC9MKfzRsz/7kV73A86XsZe58590KKbyAkpmjp40WJ407zi5FlpwA/ZR3sTNt6Q+feoBQ==
X-Received: by 2002:a17:903:41c7:b0:1bf:349f:b85c with SMTP id u7-20020a17090341c700b001bf349fb85cmr17553128ple.1.1698322596368;
        Thu, 26 Oct 2023 05:16:36 -0700 (PDT)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001bde65894c8sm691439pli.268.2023.10.26.05.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:16:36 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
Date:   Thu, 26 Oct 2023 17:46:21 +0530
Message-Id: <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning about directly dereferencing a pointer
tagged with __rcu annotation.

Dereferencing the pointers tagged with __rcu directly should
always be avoided according to the docs. There is a rcu helper
functions rcu_dereference(...) to use when dereferencing a __rcu
pointer. This functions returns the non __rcu tagged pointer which
can be dereferenced just like a normal pointers.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..802b7bbe3d92 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = -EAGAIN;
 	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if (p->real_cred->user != INIT_USER &&
+		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
@@ -2692,7 +2692,7 @@ __latent_entropy struct task_struct *copy_process(
 			 */
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
-			list_add_tail(&p->sibling, &p->real_parent->children);
+			list_add_tail(&p->sibling, &(rcu_dereference(p->real_parent)->children));
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.39.2

