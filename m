Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF50678C036
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjH2I0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjH2I0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:26:19 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499A109
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:26:16 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-76f036041b4so126742385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693297576; x=1693902376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFTsc9V1hAeiO8mBrWjns7vrpRI2iBufLq7iQH/8sGw=;
        b=U+7KnemEFsJnGKA3+B7NMVMEDgjZoB36r+/gZm5DhPonutWRSWhTHpF2SALS7kyHJd
         QfOU9QeaqZ0l2HPHBLwEJPK/2KZ0UzRVr04RpVNQE1E4NBm7Fxnagow+B2M495XMUgwl
         R+UeBMOHZ8OqEQdzUnLZexgJnmvkgIAnjWQD9OOfeDLUGWuQQfIu4teIZdaM59D4xha0
         XGdfJZTRk6WNLnslhs9CbqOeOiXGCR8alPnW9RxQ4PuVj5XzuwUNhstg8ZVsToTaoANR
         Bf8h5HD9iMHsICBDXSjmHpnZNI//zGX5a877BXjTiw3IeYDoDvTwtJYKFoPOEQ2650j5
         3DKQ==
X-Gm-Message-State: AOJu0YxONn8PBu0fJ453cfYrBboLO6XwnUTIVJpvrA530tlztlN6McC+
        1xdByKSWJsjjwBGmxiWpdFM=
X-Google-Smtp-Source: AGHT+IFC0aimOSQdqGimzWTBgDqs/DLpySsNBWUY/RryKPL4zNea/T2fXeqUM35hJHoL6xlN/D1UfQ==
X-Received: by 2002:a05:620a:244b:b0:76f:6a9:18bc with SMTP id h11-20020a05620a244b00b0076f06a918bcmr2148897qkn.4.1693297575654;
        Tue, 29 Aug 2023 01:26:15 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8fff:fff6:56dc:6bcb:5787])
        by smtp.gmail.com with ESMTPSA id w10-20020ae9e50a000000b00767cd764ecfsm2918924qkf.33.2023.08.29.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:26:14 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] sched: add kernel-doc for set_cpus_allowed_ptr
Date:   Tue, 29 Aug 2023 11:25:51 +0300
Message-ID: <20230829082551.2661290-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an exported symbol, so it should have kernel-doc.
Add a note to very similar function do_set_cpus_allowed
to avoid confusion and misuse.
---
 include/linux/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..ee64d1877be0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1858,7 +1858,17 @@ extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
+
+/* do_set_cpus_allowed - consider using set_cpus_allowed_ptr instead */
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
+
+/**
+ * set_cpus_allowed_ptr - set CPU affinity mask of a task
+ * @p: the task
+ * @new_mask: CPU affinity mask
+ *
+ * Return: zero if successful, or a negative error code
+ */
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
-- 
2.41.0

