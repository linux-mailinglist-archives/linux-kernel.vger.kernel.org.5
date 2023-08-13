Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C777A65A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjHMMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:33:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC5170A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:33:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe934c4decso4378309e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691930023; x=1692534823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSjhW1uG1o6nQbq3sjFtkQd0RVg/lRnd6Jfl5GatpGQ=;
        b=Wd3Fnl8ZMJI7vU8qFAWKyJs3Roeecc/2RWh8MqNKinKmhL82lginkhzba9Qa6YUH0I
         /Eo/J91R4cc14OKedBRGU/CcCb1c2BRSc3UL3I4Cvg6wem5hi+INWpXQlHWhG0/jJUJ5
         n47zE1TYWiBihbm7xk93gcKernCHwG5dLaO2yRE5lDsvkAmXKC0w1xr4KBhh3Dxi0LL5
         xA9TPowVG/eluGLSukW/xW6quFk4WZF5CtiQONwnN5z6QA7/akecF6GHrYtg8NxHAOjt
         wl6wtW2BNEqGGQc38Mm7ZPiYOjeqDTLQ3XQrSmVycp5KLGxPVjFUZzC5Kg7k8BdlKSMI
         CX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691930023; x=1692534823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSjhW1uG1o6nQbq3sjFtkQd0RVg/lRnd6Jfl5GatpGQ=;
        b=G8/H8eO+6FOltcmxVHae0sGUN7EtlwYze6LQNchl4y4I58hjnJ4BESWqUpf2u7b1TR
         e8UhRDLSDFeMEMXnYU0uQBotimlsoh1VBwUsYVVnDc2UkFn2gN2lPwc+AFbNlr6RXXl5
         kKyqfqT1qhhlcCs1O8cuO7DpRVtvM7GezULh0+ac9rBCAAqrj/hBlYDb8dKdVrrYLBQ8
         YbD5MhSJ525nB388NRGQUJznQAtuU0dp2iJTtj+RjWTacSsUHPDNaulkeJ7jUEKGkvEI
         HLGgXamMUOFrYS+r+N2/8FdgCkxNdj1Bow8JGA8lRHc8Cdrl38rS2O/6wCQKXFJ7vwWl
         CaKA==
X-Gm-Message-State: AOJu0YxIXemrIexyi9MRR+LcD53QnQSQNYnOYAEMUW2+sAmbwka9ijV/
        5Uy1MNk7aWYroAqpj6xceO6pWX6/z4bRuQ==
X-Google-Smtp-Source: AGHT+IEV6PZ0pYSJkAr1JbvpUPDImfEGzBdDcVXRPaG5toyIrMPl0os7wm6/OkC861oyjw/MxoONTQ==
X-Received: by 2002:a05:6512:10d4:b0:4f8:7513:8cb0 with SMTP id k20-20020a05651210d400b004f875138cb0mr4928430lfg.2.1691930022946;
        Sun, 13 Aug 2023 05:33:42 -0700 (PDT)
Received: from f.. (cst-prg-75-195.cust.vodafone.cz. [46.135.75.195])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7cf98000000b0052341df84d0sm4366470edx.33.2023.08.13.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 05:33:42 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, david@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, koct9i@gmail.com, oleg@redhat.com,
        dave@stgolabs.net, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] kernel/fork: stop playing lockless games for exe_file replacement
Date:   Sun, 13 Aug 2023 14:33:33 +0200
Message-Id: <20230813123333.1705833-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
exe_file serialization"). While the commit message does not explain
*why* the change, clearly the intent was to use mmap_sem less in this
codepath. I found the original submission [1] which ultimately claims it
cleans things up.

However, replacement itself takes it for reading before doing any work
and other places associated with it also take it.

fe69d560b5bd ("kernel/fork: always deny write access to current MM
exe_file") added another lock trip to synchronize the state of exe_file
against fork, further defeating the point of xchg.

As such I think the atomic here only adds complexity for no benefit.

Just write-lock around the replacement.

I also note that replacement races against the mapping check loop as
nothing synchronizes actual assignment with with said checks but I am
not addressing it in this patch. (Is the loop of any use to begin with?)

Link: https://lore.kernel.org/linux-mm/1424979417.10344.14.camel@stgolabs.net/ [1]
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 kernel/fork.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..f576ce341e43 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1464,22 +1464,20 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 			return ret;
 	}
 
-	/* set the new file, lockless */
 	ret = deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
 
-	old_exe_file = xchg(&mm->exe_file, new_exe_file);
+	/* set the new file */
+	mmap_write_lock(mm);
+	old_exe_file = rcu_dereference_raw(mm->exe_file);
+	rcu_assign_pointer(mm->exe_file, new_exe_file);
+	mmap_write_unlock(mm);
+
 	if (old_exe_file) {
-		/*
-		 * Don't race with dup_mmap() getting the file and disallowing
-		 * write access while someone might open the file writable.
-		 */
-		mmap_read_lock(mm);
 		allow_write_access(old_exe_file);
 		fput(old_exe_file);
-		mmap_read_unlock(mm);
 	}
 	return 0;
 }
-- 
2.39.2

