Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2187777E26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjHJQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjHJQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:24:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EEBA8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26b1adbd655so176024a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684686; x=1692289486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRvLZDhWcGnPdY9h/q6AZNh1Jgsr0H6ELyGlOlcNDu8=;
        b=hYxybaTW11UlI4LM7eEkhYhmtEDhS+XGGVk24GlaHXOuzMCVLSRNcoRWTFY6BpnfPX
         FK3gcYM427jwuSUKbDuSDRpExooWV6Mas1v03DunpDP0VapML2RLS7dKnmGh3eOigx69
         wwHrRFeaevptg+b2HYj1kAmNdpo8xuqBBPmcbWkhHkIUTCt6b3NWffF5nLLnlo7+urfT
         UN9J5Bx+JV4JBAW/1B7D7yx7v7jhZU3NX9g2GYa7EIETy3u/l4LE98TZqrJwOEu9U23Y
         CEBxbPJVN3JLZklNcWlIpUtnDfbRjmHl5goRHT+Huszw56zZjgMdDEHXN/RCzUYJD3j0
         fzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684686; x=1692289486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRvLZDhWcGnPdY9h/q6AZNh1Jgsr0H6ELyGlOlcNDu8=;
        b=YQ/417j5soNY22RwMBky9fq87oURw7118OHyDmBGvyubJRvZLZLdfjdSAYRVelS6HF
         tTt2MEfppL2zzVsAZSCF4Rzgl5IlnAA8NYBnG+BWKgiCeCf/dDgRJsPbPYvLGvm7So2Y
         MBefFyTzr1+JXgFpb1rpyvmRF3nDrSOoJ3f0bHB4qfjetkpMMTB0WmRhHCUC5Ad1IB4X
         CG410WH7riCBa1Q2843qQaiea8t4rqIFo3I7LJE5rCz1RSb7RL21Wxx2gFzT5sfYNw30
         DL5oqdNZyaUSy+FfvAiniM/Q0BIqOVFfrOoFliaEM9V/ItCpHm98jR1gHF4Jhh0nx4BS
         RQ9A==
X-Gm-Message-State: AOJu0Yz33FddiqEl3vFQC9qfrR94MynCRVXolYkLh+V6qwj+Y7Z+c7GJ
        tLaIIdI5DVN2QeD2coGRFclOFvA5AiI=
X-Google-Smtp-Source: AGHT+IHcq4syu2/GZsexvse8a6MHdIwHMRMoxSyuXzKskexPw5t8yZQDsDxrud4YtIHcfNs5TzkwFA==
X-Received: by 2002:a17:90a:fa8:b0:268:f56:a2d6 with SMTP id 37-20020a17090a0fa800b002680f56a2d6mr2134657pjz.22.1691684686560;
        Thu, 10 Aug 2023 09:24:46 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090a664700b002636e5c224asm1695535pjm.56.2023.08.10.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:24:46 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] sched fixes
Date:   Thu, 10 Aug 2023 09:24:38 -0700
Message-Id: <20230810162442.9863-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Fixes for recently introduced sched_numa_find_nth_cpu(), and minor
improvements in sched/fair.

Yury Norov (4):
  numa: generalize numa_map_to_online_node()
  sched/fair: fix opencoded numa_nearest_node()
  sched: fix sched_numa_find_nth_cpu() in CPU-less case
  sched: fix sched_numa_find_nth_cpu() in non-NUMA case

 include/linux/numa.h     |  7 +++++--
 include/linux/topology.h |  2 +-
 kernel/sched/fair.c      | 14 +-------------
 kernel/sched/topology.c  |  6 +++++-
 mm/mempolicy.c           | 18 +++++++++++-------
 5 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.39.2

