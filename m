Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F447B465E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjJAInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJAInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:43:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829EA2
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 01:43:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so21052642a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696149788; x=1696754588; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/1JVq5aMNsVzlgk5O/XCJK3uAg2NxWJYWeSGwlur0P4=;
        b=kJD8xNO4OmWSDA1eZOzenTY5tA8rZ72z/7mWx+VVtZ7S+gHKKjoVJPnh+lDDCewxDA
         H1C5q64ikwvPtNsPO2CFc8tVhlc6IaRocMH8n9Q38jVb5v6sr27EzE0FSXF47gLMVZq/
         rbfpqyDaIUC2Xm4mW0yrvwAmLMts7UYbhGu4ewA37h9hokmMPmJyBLHmiiEvnXO2025Q
         J6jjcPeTul1riqhQQVsxZEm73Zvcz+ffvBnCvfCmgGxrUPwvAmAYNK8p8cp8Yt2p7XSj
         jKJPz3JhigikTHvEZKturw6+B5ZbtKjClIefllwSxOBCLNQvrt+8JvvUrk0n60glhRvi
         kYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696149788; x=1696754588;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1JVq5aMNsVzlgk5O/XCJK3uAg2NxWJYWeSGwlur0P4=;
        b=gArpb/zIccivYYpRFKnt6DbkgkKMCG8hUc4HhxzAFzzOUFX3iEurJBq+0Zb8xXXJLk
         DhJHF4eDXqP1Xb5La2fWsdG29VWeVmmKgStJkF3UGkFSq4oGfnxDXqrUQcD/D6hprZuy
         7y45/MNSDA3yic10SIkg3OenU/pwx9Q6vO8ec25VTyPX6Wn2AjAURX/O1K2eQ9bUG/C6
         YDPe7y3hxGKxUlYMTAGgClXC/6C+A4R5KxhhdUIINBXQszUlWST2IoIqDxv/5OvCvTSi
         gGWKa65DjAQS8ACxOXpba4D2QRAa3s0yfO2wjMSbZ/GDDNhnqAK/lehsGyEoYdBkDbZ/
         pO3w==
X-Gm-Message-State: AOJu0Yw7Iq7Nla2OgE3vxtwIbDa8otw258fxMl68aqZA+QI1EfJg4UPY
        8W30rSfWK/tYYq079/iSgoY=
X-Google-Smtp-Source: AGHT+IHD2H9nlz24B5iXDwpZpHAnO7/cKD9VlGuBRjtWBX9mGDTqfx5Fe9np6T9/Aaek43lD5EE3Kg==
X-Received: by 2002:a17:906:301a:b0:9a1:6318:4d39 with SMTP id 26-20020a170906301a00b009a163184d39mr7285650ejz.29.1696149787982;
        Sun, 01 Oct 2023 01:43:07 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b0052576969ef8sm13655696edr.14.2023.10.01.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:43:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 1 Oct 2023 10:43:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <ZRkxGdBEof6Ya+E7@gmail.com>
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

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-01

   # HEAD: fc09027786c900368de98d03d40af058bcb01ad9 sched/rt: Fix live lock between select_fallback_rq() and RT push

Fix a RT tasks related lockup/live-lock during CPU offlining.

 Thanks,

	Ingo

------------------>
Joel Fernandes (Google) (1):
      sched/rt: Fix live lock between select_fallback_rq() and RT push


 kernel/sched/cpupri.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a286e726eb4b..42c40cfdf836 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
