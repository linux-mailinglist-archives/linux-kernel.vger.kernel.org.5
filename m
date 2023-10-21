Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501467D1DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjJUPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:23:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D6B9;
        Sat, 21 Oct 2023 08:23:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so267973066b.1;
        Sat, 21 Oct 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697901787; x=1698506587; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6VF4qC2hXc2d0oacLPBDdXJdqA+m5UEYXoM+OQj/89g=;
        b=CpBTxM1zcsoP+oInRKRaq62BqKQSs2v//EYLQYYhV/8rR7wajX2gFcXkXtEoo2yvBJ
         JbszV9FAPXJ702dXVt+T0TFXWEZ+vSFmp7etSb2q42n5x8uSSqUPttDRdwluTeZ8yaKZ
         DBKEOr3OcjrwOCPw1ys2nn1c/2dkXKDBRzdlMC8p2XKWcCVyRENsz62wflRbwmeYGEi4
         9LGgT0fUJOBfH2heDFeEphev3vLw8Udt3PBnhxWsRC2HYXMGTLtvQGgQl/mKk3ii/oQ3
         Mzcs8sYqX74JMe5yWggpRfjqyDM8s1BKOnraQu5xCDncS74+C99l/2jwJyRsxqqO/DrR
         At4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697901787; x=1698506587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VF4qC2hXc2d0oacLPBDdXJdqA+m5UEYXoM+OQj/89g=;
        b=fSrjSyhpgfOFKB+mtjYe9KNC9JNkYIja7Q9QkzOQ+cWyQ4mCrl7bf0Z1FThrTeiSOF
         tAcaYUXSIHiXVKWGEKauib4wRdEUlYTef0V3iNhmm9C3Zx8mYgjjH1GRSTtqhxjB9ZPK
         BP31TDQrrriR8SBNRkvtiJfXDcl0MwnwunonJUKW91DIMTA6sxPzS8tqZxnm2/iD16Hp
         sKJU4woFkzzBpyfqboNkNzgrzhX5zU6uFmfmaTinoUYRf/3g0cbGpeZIB3P9CMLLWATK
         imgAHsxrk/z7tPhCi6PkUSn2vWP0ksghcjpx224OdQJ4F7YAicTLqf/h0GkfYIj80Byt
         /w9w==
X-Gm-Message-State: AOJu0YxbcocnIODdrypXkEP5Kg4aetejpvDRvN689mOH6yzRfHs2eMel
        9K666jKP61w5u54rIK9Or/E=
X-Google-Smtp-Source: AGHT+IFNaFTbH73weeKJQ/wEth3rN/5nXFTJo+CRuaEMoB6+VbO8OYZJ6btsdyqXC0nRDFkH69F3QQ==
X-Received: by 2002:a17:907:783:b0:9ae:5253:175b with SMTP id xd3-20020a170907078300b009ae5253175bmr4013246ejb.34.1697901786605;
        Sat, 21 Oct 2023 08:23:06 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b009786c8249d6sm3834641ejq.175.2023.10.21.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 08:23:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 21 Oct 2023 17:22:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZTPs0ncHILbDrGh6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-21

   # HEAD: 32671e3799ca2e4590773fd0e63aaa4229e50c06 perf: Disallow mis-matched inherited group reads

Fix group event semantics.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      perf: Disallow mis-matched inherited group reads


 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 39 +++++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c0eaf3..7b5406e3288d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -704,6 +704,7 @@ struct perf_event {
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
 
+	unsigned int			group_generation;
 	struct perf_event		*group_leader;
 	/*
 	 * event->pmu will always point to pmu in which this event belongs.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..d0663b9324e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1954,6 +1954,7 @@ static void perf_group_attach(struct perf_event *event)
 
 	list_add_tail(&event->sibling_list, &group_leader->sibling_list);
 	group_leader->nr_siblings++;
+	group_leader->group_generation++;
 
 	perf_event__header_size(group_leader);
 
@@ -2144,6 +2145,7 @@ static void perf_group_detach(struct perf_event *event)
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
+		event->group_leader->group_generation++;
 		goto out;
 	}
 
@@ -5440,7 +5442,7 @@ static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
 	struct perf_event_context *ctx = leader->ctx;
-	struct perf_event *sub;
+	struct perf_event *sub, *parent;
 	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
@@ -5450,6 +5452,33 @@ static int __perf_read_group_add(struct perf_event *leader,
 		return ret;
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
+	/*
+	 * Verify the grouping between the parent and child (inherited)
+	 * events is still in tact.
+	 *
+	 * Specifically:
+	 *  - leader->ctx->lock pins leader->sibling_list
+	 *  - parent->child_mutex pins parent->child_list
+	 *  - parent->ctx->mutex pins parent->sibling_list
+	 *
+	 * Because parent->ctx != leader->ctx (and child_list nests inside
+	 * ctx->mutex), group destruction is not atomic between children, also
+	 * see perf_event_release_kernel(). Additionally, parent can grow the
+	 * group.
+	 *
+	 * Therefore it is possible to have parent and child groups in a
+	 * different configuration and summing over such a beast makes no sense
+	 * what so ever.
+	 *
+	 * Reject this.
+	 */
+	parent = leader->parent;
+	if (parent &&
+	    (parent->group_generation != leader->group_generation ||
+	     parent->nr_siblings != leader->nr_siblings)) {
+		ret = -ECHILD;
+		goto unlock;
+	}
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -5483,8 +5512,9 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
+unlock:
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	return 0;
+	return ret;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -5503,10 +5533,6 @@ static int perf_read_group(struct perf_event *event,
 
 	values[0] = 1 + leader->nr_siblings;
 
-	/*
-	 * By locking the child_mutex of the leader we effectively
-	 * lock the child list of all siblings.. XXX explain how.
-	 */
 	mutex_lock(&leader->child_mutex);
 
 	ret = __perf_read_group_add(leader, read_format, values);
@@ -13346,6 +13372,7 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
+	leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
