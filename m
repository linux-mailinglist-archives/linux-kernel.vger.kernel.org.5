Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A497D1DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjJUP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:28:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27FD6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:28:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so265686766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697902095; x=1698506895; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eTV5TdN8XnmwCbXJlALC4Yi9SLWv2TXy/RSRk5k8erY=;
        b=XeSkEEEEGSEq1IKRCY+TeRJSr8MzVpcc4APML2bjQ6D4hHqlf2XvAviTh/hg9Wwb0T
         QUyqFl8T0BmOXoNcEpQ2w+Zl2j/K0RShtCPxcLoYHeTOoxSpN/NG2XtMVf/f0dZ0SrQf
         9Iutu6xWFLoqfWS5pq2USiVRArdZhH/LFZlNMW/NkhT+jnN5bMhn/emS/bla5a8GNxKL
         m/H4KFIlDRovp65BMD0Jv8otOoWLmLU7B10wK0TO4/UdWWqctRuxLezpg0FSyLmjAf6e
         qdRuOf7776xTibLDNOZ/8fhwGY0ZDpRz6+02XFxyuldxGGLYv0iE4oO3TRC06Iq2ngN+
         R33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697902095; x=1698506895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTV5TdN8XnmwCbXJlALC4Yi9SLWv2TXy/RSRk5k8erY=;
        b=KyUXjfmAq2awgQBQAx38TqQHDU+iYKSXXyoBg8uJGsOCIvaTWYk22TzQNXjjOIox9C
         qZbPM6sPUllqU0s9DchN+KoTY186cTgBB88U0cPR2T9ibqmlsE+3vSNsTCc5O7yAtorN
         elCR0RnSE53DzsDJEyQKVyy+SCnTloh89P0j+zVEYk0RLlXSzy9VqnUeOZS+XjJS274q
         L9G622BGxLRihuh1iWeMmJP7u8Gsly1T3c3ka00vh24fSHe/Q/uCHD1XgEFRiBlYgpL3
         YIqZ5PqNBXGzI8qKqn28aog9aGUee1QHFyP7a61rEwj1fIvbq3lr1esn9bxMWFouFJT9
         VCSg==
X-Gm-Message-State: AOJu0YyphuC65m5yc5s5XwhWhs6738Sw02R5ygX9/ly+ikmeMKRnfk+w
        oRMaLd+LgwvqfnI48T4FfWE=
X-Google-Smtp-Source: AGHT+IFNbWSr75DSeGOKsRABUfgM89+hmD5x7uzZermA358RhYv2Ay3UdO91LA3S0g1spMHtmfNKYQ==
X-Received: by 2002:a17:907:961a:b0:9bf:39f3:f11d with SMTP id gb26-20020a170907961a00b009bf39f3f11dmr4401239ejc.30.1697902094739;
        Sat, 21 Oct 2023 08:28:14 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709062dc900b009930c80b87csm3813556eji.142.2023.10.21.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 08:28:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 21 Oct 2023 17:28:09 +0200
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
Subject: [GIT PULL] scheduler fixes
Message-ID: <ZTPuCcQkcn4TVTMn@gmail.com>
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

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-21

   # HEAD: d2929762cc3f85528b0ca12f6f63c2a714f24778 sched/eevdf: Fix heap corruption more

Fix a recently introduced use-after-free bug.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      sched/eevdf: Fix heap corruption more


 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 061a30a8925a..df348aa55d3c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3657,7 +3657,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 */
 		deadline = div_s64(deadline * old_weight, weight);
 		se->deadline = se->vruntime + deadline;
-		min_deadline_cb_propagate(&se->run_node, NULL);
+		if (se != cfs_rq->curr)
+			min_deadline_cb_propagate(&se->run_node, NULL);
 	}
 
 #ifdef CONFIG_SMP
