Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720C7EE002
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjKPLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:42:39 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF37181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:42:36 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1eb39505ba4so337704fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700134954; x=1700739754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lqOnO0oJxNOdZT+nOsjz4IxTYG9kJzFJrhOiEWcwDcs=;
        b=OUX7oq8ZFJFVEbjmlLdxxRx35gLLLCjzs+OF0ZtSHifuROKBz0p8cxnrMJHTvfq1n/
         Cyjusoy6La7tTsDQ/QYuBroiABnTQsNAA//Ea1xsC6yW1SjFkRa7OwDvnkXuJ+DJSMJF
         iKCA325IRIuPbgnAFdVqLddgvBKOIvbFSGanSBRtCELt6vp8bMzG7Brk0GKj/zFQljGp
         +GU91R/N71AZ1BykuC80ixLia11fIMVb0LFYxms/7A9ElWK4wWLS362YNIA1cgVfZrfB
         MdLVC+HZd4hGwe21WIWYMD/2hacWRAFumAyEFUm+pB5iIzveVIT4CU0JJyl1mC96tG0h
         YeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134954; x=1700739754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqOnO0oJxNOdZT+nOsjz4IxTYG9kJzFJrhOiEWcwDcs=;
        b=qXQE2eMzPQCRVMdJZKs8Jr3B0RES9dgdRUeqFaB2zXKW/y4iv9ln49sSGNPy9TiQrJ
         B162ubxT1kxUxm9gIWaU9J28zaUoc6m1ERZxMbuXuxFf59rWZJP27OX8M2fiuNJxaKG5
         CS+F10pHufW7jH9xMiMaN4dCiaiilVMBTnSP61dNIRenczSXrp50sTMKftZis3h4qcwP
         0Wiy8PdH06EjwD7GZ0pyifF56kJEUhP1QRMZbXxSt2PHSxfnP5YAMu2ybzh557ZK2DP+
         h4yUvjhWBrhpeSCe8gdl9cRBHkxdgQX6cQ4IM1/FFbOPbMmIEZOxFvObxjgqMmWOBEnZ
         v89g==
X-Gm-Message-State: AOJu0Yz/kbaZbXHDIiVEFEq/opXPIMRtcxiKSKGa+pvoxvdcz1zCgPyM
        SavDxd/2PnLRPvbFvgUi4dA=
X-Google-Smtp-Source: AGHT+IEj7KMFDYT8iB8P2zS8wXt3ewD1W6oVGbAbui5MTDFFs6vmCWirnUB5XNfimZ40Mt6mhBSS4w==
X-Received: by 2002:a05:6870:f78d:b0:1d0:e372:6b06 with SMTP id fs13-20020a056870f78d00b001d0e3726b06mr19145879oab.25.1700134953637;
        Thu, 16 Nov 2023 03:42:33 -0800 (PST)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id fi42-20020a056a0039aa00b006bb5ff51177sm4330247pfb.194.2023.11.16.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:42:33 -0800 (PST)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH] sched/fair: Update min_vruntime for reweight_entity() correctly
Date:   Thu, 16 Nov 2023 19:42:17 +0800
Message-Id: <20231116114217.90553-1-s921975628@gmail.com>
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

Since reweight_entity() may have chance to change the weight of
cfs_rq->curr entity, we should also update_min_vruntime() if
this is the case

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07f555857..6fb89f4a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (!curr) {
-			/*
-			 * The entity's vruntime has been adjusted, so let's check
-			 * whether the rq-wide min_vruntime needs updated too. Since
-			 * the calculations above require stable min_vruntime rather
-			 * than up-to-date one, we do the update at the end of the
-			 * reweight process.
-			 */
+		if (!curr)
 			__enqueue_entity(cfs_rq, se);
-			update_min_vruntime(cfs_rq);
-		}
+
+		/*
+		 * The entity's vruntime has been adjusted, so let's check
+		 * whether the rq-wide min_vruntime needs updated too. Since
+		 * the calculations above require stable min_vruntime rather
+		 * than up-to-date one, we do the update at the end of the
+		 * reweight process.
+		 */
+		update_min_vruntime(cfs_rq);
 	}
 }
 
-- 
2.34.1

