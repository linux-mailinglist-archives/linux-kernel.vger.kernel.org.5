Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE87E0E85
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjKDJM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:12:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C38194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:12:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5ae143e08b1so33497857b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699089171; x=1699693971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq1/qtMyQtDFm5+WYRR5U7fgUbb1lnE9Y7tTS1p4Dgk=;
        b=CRCsAlBgLv1oG58jPzIvJegwGEMn6QZui7ySuMLPBE/Go3FHGBFBg8ADfaSBs1sOHp
         d+703QcqCZwoBJ6vdid0ZvBQeY31pNwveQC/JFBlEBIZrzoRTRKRflUIbz3Qz0DfXIrh
         OPwISElP/SMs/CvXmXZMxto1KzNKfvQfhcSC+Eupb5d6VjMSN2m85vayQUGa9FXvFab4
         uyNmPer9LKnjXTxiWN5EJArCbzvCDJUzx+eKce0j7nG59p7nvmzK/zEVypOLecIvx7mo
         Qx8t5NwJP0oiSrEsvL+eP0qh3Dgvb83Bh/TIZhhgptZDW0qNyvXN11u+NFjzMIK0Rmvy
         5oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089171; x=1699693971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq1/qtMyQtDFm5+WYRR5U7fgUbb1lnE9Y7tTS1p4Dgk=;
        b=l3Sv721Gvnzd51JgWQbE0+xDKsYLMhv5IsRwa/sZIGRrgy9GIbOiqJdYALboL9EC7b
         ZLhrylbieH+/9ggNdoB2iJYQtVrMEg/CdWf6ro2TcQ0ttfWCmVPcn/BN9v8RJvBX8dpo
         T78mezd5w5uat5TWKyw6aBXiKNAvhq2BPkqL90MArQHvnMUrMJy2l69aZ6fHHspTjl04
         YmID34OdjgjeK+QFK1KRsrn/00Ed4bulUoQ+m9wSS1MiyqFpfDGiQOrNodwn4zd98nJO
         MqoQ/nV0xBrnBoC730CmyJGIqVPAkA1dTgQNO/DPAUVZMowRImCGEVSgl3Jgq5/Q/h2H
         mMBQ==
X-Gm-Message-State: AOJu0YydBasrENvk89HGhSqynJ+fP50kXCj85hv/COMQeNocaVPJmG5Z
        KU67JfN8cSRSbEJqQe119c3J9KFScC8gTCQ0
X-Google-Smtp-Source: AGHT+IFJc+x4eS8AiIUICxSb0+C40KD1OqsDHbh9ia4C1qLc9x+6uTqdbqfImy/DEBwpEpas0+wgYw==
X-Received: by 2002:a25:d4e:0:b0:da3:b87b:5b75 with SMTP id 75-20020a250d4e000000b00da3b87b5b75mr8715085ybn.64.1699089171382;
        Sat, 04 Nov 2023 02:12:51 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id k12-20020a63d10c000000b0059b2316be86sm2561625pgg.46.2023.11.04.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:12:51 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975628@gmail.com
Subject: [PATCH] sched: Remove nr_spread_over for sched debug
Date:   Sat,  4 Nov 2023 17:12:30 +0800
Message-Id: <20231104091230.128516-1-s921975628@gmail.com>
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

As the statistic for nr_spread_over isn't tracked in scheduler
anymore after the EEVDF changes, we should just remove it.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/debug.c | 2 --
 kernel/sched/sched.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a4507..b5157db38 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -663,8 +663,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
-			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486..5b5839c34 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -562,10 +562,6 @@ struct cfs_rq {
 	struct sched_entity	*curr;
 	struct sched_entity	*next;
 
-#ifdef	CONFIG_SCHED_DEBUG
-	unsigned int		nr_spread_over;
-#endif
-
 #ifdef CONFIG_SMP
 	/*
 	 * CFS load tracking
-- 
2.34.1

