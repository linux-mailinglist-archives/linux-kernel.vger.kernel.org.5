Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0DB78358D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjHUWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjHUWUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:20:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B161188
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:20:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso38237245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692656424; x=1693261224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv3/KXztnL5KoChNf1Fo3z4E8w03N3Vz74hqaKz4DNE=;
        b=BpLPwm/4qMtYQnJZdL/KNRwP7phYdTF/YWVH8K9pnFsM+Q5zE6QnM3lHDFdGixEgkK
         v9CC/qdXTeYberXAtZHhgv1f4FthPxkH4H5GCMD3xctFGhsQw3lZ1O76tK7SjuRJcNNF
         +LvwpBst3BGysD2QvvtOYZMwAAoipc0lx0GZIegv4Xt6Hs8Ho3z/IKqEd+s3muOAvGdz
         jqmRE31xvlWiQCYgNUPoTCFaqwS4vE3AyUoob04X41XCqGWTv0vERBz5s7NZFnTCxfTQ
         MN5Qy0DbKmEVlA/yR0gWNAkpkMB5lM8drWnV6Bk+GXgAZfe73+VUgxiCRT2ddDASzsdw
         3ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656424; x=1693261224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv3/KXztnL5KoChNf1Fo3z4E8w03N3Vz74hqaKz4DNE=;
        b=i6/J54pK6m0JJzkr5x2po8wWP1L0ytqQ2O8KOgTM+sR1bLZ40PbxIBmeX7agBEWry/
         JHc5PBG5ufwBTQ9csYCvpHTL6+MZ2nW37q7HI3jCh62B7kQ+Ozr+lYe294qoNnzpQhPr
         Wiaokh7zsjxUO9AKwDrWDU157hgkpXStheGS8lN26oaAx6CXE9Vg/gCSkvkL2sg0OJWd
         wle6GeZczanHwsbVZXJ8EMZbtqnvvKjNCKtmUspBevd4ZYtwGka97W4ag4MFccXmfFzr
         4Qpow8eSVSWQWGTjVYWd9tI8OvOL57VoDkLPYMBjcFb1yhHOdUO570KikRToKyohVkex
         4P3Q==
X-Gm-Message-State: AOJu0YxNHmukj/t9RwCO573WHTKiE2MzL52FQlpO+rlisHeiUwkK4lc4
        T6Uj+5oMYJ2VGVEP+sBnepKc2g==
X-Google-Smtp-Source: AGHT+IH+42oA+v5gZ66xF6eh/lfH7VJgolpwEE78hT93/Yh/YPgkaMG+Tx/AoHmev2F7Tp/vH2gpAw==
X-Received: by 2002:a05:600c:2307:b0:3fe:687a:abad with SMTP id 7-20020a05600c230700b003fe687aabadmr5792357wmo.20.1692656424104;
        Mon, 21 Aug 2023 15:20:24 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fe61c33df5sm17751154wmb.3.2023.08.21.15.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:20:23 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Mon, 21 Aug 2023 23:19:54 +0100
Message-Id: <20230821221956.698117-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821221956.698117-1-qyousef@layalina.io>
References: <20230821221956.698117-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit c0f78fd5edcf29b2822ac165f9248a6c165e8554 upstream.

update_tasks_root_domain currently iterates over all tasks even if no
DEADLINE task is present on the cpuset/root domain for which bandwidth
accounting is being rebuilt. This has been reported to introduce 10+ ms
delays on suspend-resume operations.

Skip the costly iteration for cpusets that don't contain DEADLINE tasks.

Reported-by: Qais Yousef (Google) <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit c0f78fd5edcf29b2822ac165f9248a6c165e8554)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ca195ff8b298..b7168970fff2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1092,6 +1092,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.34.1

