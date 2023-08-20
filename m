Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B306B781EAD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHTP0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjHTPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:25:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1044BC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:23:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31768ce2e81so2267729f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544984; x=1693149784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGKyARVcdmy9q5MfP+wkkLHAfHG9qOLxVevsPvfEUVw=;
        b=Do2ue4Y+/ZJOLugGYY0E8XKnkh9k1nN16G/r8pNiNB8wL7R+lB1wpGoFR6ywwmy7qw
         J8ErqEw9djt9QocokoWK7Ywi4ywptdG0OJMBfLDYI9x8Cwb+2L/yATE4CrbXXAFlUKj3
         cYY8FXqWdB+D2nCgiyOWvghOJFvIusHcSwyAlMiIfzeLymDuiakdsPXqrIzbdlryHjFB
         4Uk3Is7HTsYRQUZMl8OXxk03i0ojN0vj+lD9F5mZzgmHrOFRYPlXrE/H0itmIfNNA1Ms
         N6KUV74wfhdGdzU5l8EHZJpAJm3XaTrSUm13DtPdO52XjbS3rOfOBAR1PDkcHp0tlQlZ
         gMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544984; x=1693149784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGKyARVcdmy9q5MfP+wkkLHAfHG9qOLxVevsPvfEUVw=;
        b=WLYIsJxewYWjBd+rdyZT3+lGncQ49n8IoPHWbSbZB0XMSphimg3MrYTxLsD4w13fnv
         seeo5XqtJb6uOnBMFDwc7ICcLuKhW8RZIUCOnW8x1bOaywVHpnY9xjmFQZjUsLEBQSfX
         d5ucDgPihw+xsW0QK8IG+/Xj7S/XfF3+l3AUkU+J4MWHldYEFzBgRn3sgXJUpPK+x/uO
         Zk7M1xf4Xw9QIPN192AdkFUx//1c3xocy7KYfiuh4TTXzx5YXgZpU4QGeSVDw3rii8SM
         08CvKG/oFPNI+MNbLH6LiujJshnaD4SqjowSOHaGYnuq6+8GZX8ek4a8N24wAHCB3pEL
         kDlg==
X-Gm-Message-State: AOJu0Yy8hU8kZNk6xYCE28Q1io2BaZEfGnJ46NT0IjKNQytUT/oQ7p2o
        GGdqLtoyLB2Ho7V10QIGZ64Bhw==
X-Google-Smtp-Source: AGHT+IEFu3g1K7MScgnuwByH+y3Y320wY+S3m1YwvDe3bv+jrjGoadwqPdVdEz4/Imz1SMMlQciRrw==
X-Received: by 2002:a5d:6282:0:b0:31a:c6ef:5edc with SMTP id k2-20020a5d6282000000b0031ac6ef5edcmr2672647wru.12.1692544984661;
        Sun, 20 Aug 2023 08:23:04 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm9527466wrm.37.2023.08.20.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:23:04 -0700 (PDT)
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
Subject: [PATCH 1/6] cgroup/cpuset: Rename functions dealing with DEADLINE accounting
Date:   Sun, 20 Aug 2023 16:22:53 +0100
Message-Id: <20230820152258.518128-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152258.518128-1-qyousef@layalina.io>
References: <20230820152258.518128-1-qyousef@layalina.io>
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

From: Juri Lelli <juri.lelli@redhat.com>

commit ad3a557daf6915296a43ef97a3e9c48e076c9dd8 upstream.

rebuild_root_domains() and update_tasks_root_domain() have neutral
names, but actually deal with DEADLINE bandwidth accounting.

Rename them to use 'dl_' prefix so that intent is more clear.

No functional change.

Suggested-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit ad3a557daf6915296a43ef97a3e9c48e076c9dd8)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fb895eaf3a7c..de078f6c1144 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -940,7 +940,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
-static void update_tasks_root_domain(struct cpuset *cs)
+static void dl_update_tasks_root_domain(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -953,7 +953,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
@@ -981,7 +981,7 @@ static void rebuild_root_domains(void)
 
 		rcu_read_unlock();
 
-		update_tasks_root_domain(cs);
+		dl_update_tasks_root_domain(cs);
 
 		rcu_read_lock();
 		css_put(&cs->css);
@@ -995,7 +995,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
-- 
2.34.1

