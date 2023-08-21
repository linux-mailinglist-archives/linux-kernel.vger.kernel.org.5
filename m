Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D106E7835EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjHUWpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:45:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E7127
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso37019005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692657932; x=1693262732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFW77HVAlIdubmWbkisYSEeA6oEI/aggshywaPs8dlA=;
        b=QBnwZTJfIHcV9avSW9/1hhQNJ3WwZV+dBaG7/h7g3plV0Wzn2IaLeFlSRgtQSx+F5U
         lnru9HwBl+ZGYkczi691Oa30vpOnIqZ/bMpfp2/4Ps93nxI5AAhWRKX1gZPlc2wREyZF
         6RmumAmXQwlMj582Ia57ei7XpqYOLsJh4DyU1UB3rU1PjuSlrfJVtTfC0iy5VCCaGlfS
         W1wh/nwUsv5zBXHVrzlvDL5QbgQ+ao48BzbzkRtzbyddhp8g7AWAGWKGWS7p5tFDuwRj
         lpuNDn6Yc2hYENGzL6oPINLSt43/aqAWLxs0cdEEt5gbNnTwaD9n/iSGMdnC1VhIDlly
         h0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657932; x=1693262732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFW77HVAlIdubmWbkisYSEeA6oEI/aggshywaPs8dlA=;
        b=XeoxzRjZ0tcRbhXAkdjs4bnUpq/hBMuPuWkV0JffbhBEdeb34GduTKQghHsidxpveq
         tIwHeXHlpt9nz8GHAX9OFSjoiIFb/xcG6pI1Jeur0/6tMaMhg36g0v/Yf05ea1H2GICt
         QMnhj7+HcZvp8nbST6Grv0s9hyTcSoxx7UWpKAO7MI+ynEMzPLhumC1ymDKFpJWs7+sH
         shxJbx0Thml59DokGPIc2yQwlidz7yjzrH/R+uHjcH2twhUVSPEPr0AAB7/vJU3qbdDt
         Oxgb9ArMDMp6jSPr+LEUeSC89wCMxN4+lINkGqFDWB9VPFCmCY9aL2RNWQk7UTxxh7t+
         oTPA==
X-Gm-Message-State: AOJu0YzgbJHqiYB/+7b1ZnPj/hH+hohELZKti3by6RDReygKvo4HaEj/
        KFkfTv6+jQzhGb/Oj7BV8YdPlA==
X-Google-Smtp-Source: AGHT+IGI8C2Z2a8o4C/ENevumdpRkTH5dOBfoqSu3JDtd0o+Xgb3EEbaWmlzHgaVff4+thbEAGdp8w==
X-Received: by 2002:adf:f8cb:0:b0:314:46af:e1e7 with SMTP id f11-20020adff8cb000000b0031446afe1e7mr5782553wrq.34.1692657932285;
        Mon, 21 Aug 2023 15:45:32 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000100100b0031981c500aasm13820788wrx.25.2023.08.21.15.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:45:31 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v4 0/3] Fix a couple of corner cases in feec() when using uclamp_max
Date:   Mon, 21 Aug 2023 23:45:01 +0100
Message-Id: <20230821224504.710576-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:

	* Added Reviewed-by Vincent Guittot.
	* Updated sched_compute_energy_tp() to include  max_util and busy_time
	  as requested by Lukasz.

Changes in v3:

	* Fix sign comparison problem in patch 1 (Thanks Vincent!)
	* Simplify comparison and remove function in patch 2 (Thanks Dietmar!)

Changes in v2:

	* Use long instead of unsigned long to keep the comparison simple
	  in spite of being inconsistent with how capacity type.
	* Fix missing termination parenthesis that caused build error.
	* Rebase on latest tip/sched/core and Vincent v5 of Unlink misift patch.

v1 link: https://lore.kernel.org/lkml/20230129161444.1674958-1-qyousef@layalina.io/
v2 link: https://lore.kernel.org/lkml/20230205224318.2035646-1-qyousef@layalina.io/
v3 link: https://lore.kernel.org/lkml/20230717215717.309174-1-qyousef@layalina.io/

In v2 Dietmar has raised concerns about limitation in current EM calculations
that can end up packing more tasks on a cluster. While this is not ideal
situation and we need to fix it, but it is another independent problem that is
not introduced by this fix. I don't see a reason why we should couple them
rather than work on each problem independently. The packing behavior in
practice is actually not bad as if something is capped really hard, there's
a desire to keep them on this less performant clusters.

Patch 1 addresses a bug because forcing a task on a small CPU to honour
uclamp_max hint means we can end up with spare_capacity = 0; but the logic is
constructed such that spare_capacity = 0 leads to ignoring this CPU as
a candidate to compute_energy().

Patch 2 addresses a bug due to an optimization in feec() that could lead to
ignoring tasks whose uclamp_max = 0 but task_util(0) != 0.

Patch 3 adds a new tracepoint in compute_energy() as it was helpful in
debugging these two problems.

This is based on tip/sched/core.

Qais Yousef (3):
  sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
  sched/uclamp: Ignore (util == 0) optimization in feec() when
    p_util_max = 0
  sched/tp: Add new tracepoint to track compute energy computation

 include/trace/events/sched.h |  5 +++++
 kernel/sched/core.c          |  1 +
 kernel/sched/fair.c          | 36 ++++++++++++------------------------
 3 files changed, 18 insertions(+), 24 deletions(-)

-- 
2.34.1

