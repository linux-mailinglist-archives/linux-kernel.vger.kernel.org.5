Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4457D07F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376270AbjJTF4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjJTF4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:56:34 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B6D41
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:56:32 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5841bdf1b81so86993eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697781392; x=1698386192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poHlEB2ruOIikyhtmJOkPouVUxbi+dlk39CgpHNpB9U=;
        b=Odb/xnFkLiQAhW+L3xAXg4M38w4m4XeG8eLxW5OkQLtctXriTI8JbO+LRhd/VSlF8v
         CsjbAo45GXOFoNItn6aRZKOp3I6XVtyQTt+BzadXcGYcAvZgii+VI0exatEE3iSg2G8F
         FJ/V6wEy98ipP9Kd7Ufd1ZpT/H3gfmDmQZc3xbJidu/egqk8BKwOXrwmmWZpq3S9ZBS5
         9PfGvvnws+AvA4q2MVMq8TBDgDqYNTeum756g+3LQLdL63EvgYlccflRfC5qAE79l+DQ
         8DM9xDQTN1hfl+zjB8FCscvdx0HCk3qrnX832tXjcHFk0aIBt/gdcGlN1YcmzT6GFxI3
         y1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697781392; x=1698386192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poHlEB2ruOIikyhtmJOkPouVUxbi+dlk39CgpHNpB9U=;
        b=MjlwHw0+4oVVEU4WzjT23itWA6bc1kgyqQqBVlA9C/E1haEsA4lrFJFWm4SM7tvpOk
         gMGAqNhRMowU3Q90AneCeDFcxswmpwFLoSh99UTyZg/ituRn4kZx/jccnzVJqf4wggwl
         0iSCnZvoOC1Wk0SzTwsLHl3rMdfvYgWxFurK8tTrBIjf4hYry/N5lFZQPxY5+jboSN0+
         PFqu4BtOxYNwRr/VJk57Yq2HSa/+lVBGmiFpcEQxLeEsqb32QZ9kbKElBV9Td7juAYII
         96zxhqpoPT1qwRaroTsfn/AvDciGWDWHtcHipaq8DR8LFdfuGgYmThIHJOjcNxJoJAEI
         Misg==
X-Gm-Message-State: AOJu0YwYeib3YXxiYgqjdRow1GN1kYaAWWFr8qbA2KqEWtW4lmx05+q3
        HqW4URfOdZesXFrkWtiAoGo=
X-Google-Smtp-Source: AGHT+IGhty/EnQI4Pxc2Ij3EWjQ2cNSqRH/IM33U95FUGMX7bf6FAkZFzKG8XslgP9ppfAvvQHGYgA==
X-Received: by 2002:a05:6358:925:b0:139:a45c:32b2 with SMTP id r37-20020a056358092500b00139a45c32b2mr1135354rwi.11.1697781391668;
        Thu, 19 Oct 2023 22:56:31 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-208-182.dynamic-ip.hinet.net. [111.255.208.182])
        by smtp.gmail.com with ESMTPSA id f15-20020aa79d8f000000b00690b8961bf4sm730499pfq.146.2023.10.19.22.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:56:31 -0700 (PDT)
From:   s921975628@gmail.com
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975628@gmail.com
Subject: [PATCH] sched/fair: Remove unused args for pick_next_entity
Date:   Fri, 20 Oct 2023 13:56:17 +0800
Message-Id: <20231020055617.42064-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Lin <s921975628@gmail.com>

The arguments 'curr' for pick_next_entity is useless after
the EEVDF changes.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ae220808..486f3c2f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5256,7 +5256,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+pick_next_entity(struct cfs_rq *cfs_rq)
 {
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
@@ -8160,7 +8160,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 				goto again;
 		}
 
-		se = pick_next_entity(cfs_rq, curr);
+		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8223,7 +8223,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			}
 		}
 
-		se = pick_next_entity(cfs_rq, curr);
+		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8262,7 +8262,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		put_prev_task(rq, prev);
 
 	do {
-		se = pick_next_entity(cfs_rq, NULL);
+		se = pick_next_entity(cfs_rq);
 		set_next_entity(cfs_rq, se);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
-- 
2.34.1

