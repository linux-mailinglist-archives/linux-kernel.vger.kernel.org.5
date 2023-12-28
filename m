Return-Path: <linux-kernel+bounces-12850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DCF81FB22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0F1F21104
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D06125D1;
	Thu, 28 Dec 2023 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNXQMtKG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330AB11CB7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ebca94cf74so26631017b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794191; x=1704398991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuwjfzn9Rfwwgagf8FmGExz6QUv+UeUHULe7+jnQcq0=;
        b=KNXQMtKGf3U+zjtBUmWGOpdnRNrLimoC8Z5HyKHcnq7BeOWvqqEfeUxNuu5YzCBgac
         Jdg3WFoMq6zYllgrJa3FBNSQaYy/P2fUBDbkGWWKn1712kCLzoI1LRwRMAVFHlq5X3xW
         tiieTqfO0BjCYpFi56HCbNd2r3WBQeDWja+0CLCoZYwXaJGz4EfmRvwP69CFY72FBskR
         /q7GZwUFWN8RBNeDnykP12vHw7oqzhaYGdJEQ9va7KLj/G6Q8A1Xv1Rcn/dZD1G+y34R
         4/JFnqcjfaSkAXresDG/LnvudJFMupe5fODmdyJl0y/7GsCp+k/MAn/qsZntfzQkNmiP
         fZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794191; x=1704398991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuwjfzn9Rfwwgagf8FmGExz6QUv+UeUHULe7+jnQcq0=;
        b=Qq9A7DInuA/bH95e9DjkPIg26vysGtYBcIOBFK/K2n1ojpcfZwP+8CtxheWHdA1erY
         UNaeRbI6riJSMluMziir74NZZKWemJEM7aTHROaBNnWPuagp1bbfjuUJPO6jlmojGAxj
         qXaQDqV5mnPckMh6nY6jf9fwjWGJ1G4815jlkLZKX9z76xofGp2EnhFhVIfV62gPLzvs
         +9Va8Pw6rhlK0kWdNtLAyfQbgCrOsZyM29PdFz/E1BqxqIYFe7IZ0qzk5vFzg0IuOg+z
         5arJN4tftHO6EmsvQaibKy5JRh/aTZ+8/n7wvDtaQj1YF3kD7lMl3+19wWsgCY6lguWa
         /j0w==
X-Gm-Message-State: AOJu0YxSsi0Q41cjgcP6h4fOsBnCv7a3G65OQBu7e3glqHwSf0xx8nYk
	8Cx0PM9Wab49orADscSNRcE=
X-Google-Smtp-Source: AGHT+IFbF1+LVktMVD7en5D6HNE0SGHAz/HAc5YF47LDJpVcDL8ft1yLx9TCEJehoNm6TpwGlxsapQ==
X-Received: by 2002:a0d:d74c:0:b0:5e7:5577:2af2 with SMTP id z73-20020a0dd74c000000b005e755772af2mr5990440ywd.62.1703794191147;
        Thu, 28 Dec 2023 12:09:51 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id q126-20020a815c84000000b005e8af6a6e19sm7749528ywb.144.2023.12.28.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:50 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 9/9] lib/group_cpus: simplify group_cpus_evenly() for more
Date: Thu, 28 Dec 2023 12:09:36 -0800
Message-Id: <20231228200936.2475595-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228200936.2475595-1-yury.norov@gmail.com>
References: <20231228200936.2475595-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nmsk parameter is used only in helper function, so move it there.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index b9ab32e00a79..3a0db0f51f09 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -253,13 +253,17 @@ static void alloc_nodes_groups(unsigned int numgrps,
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			       cpumask_var_t *node_to_cpumask,
 			       const struct cpumask *cpu_mask,
-			       struct cpumask *nmsk, struct cpumask *masks)
+			       struct cpumask *masks)
 {
 	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done = 0;
 	unsigned int last_grp = numgrps;
 	unsigned int curgrp = startgrp;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_groups *node_groups;
+	cpumask_var_t nmsk __free(free_cpumask_var);
+
+	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return -ENOMEM;
 
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
@@ -350,11 +354,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) = alloc_node_to_cpumask();
 	struct cpumask *masks __free(kfree) = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
 	cpumask_var_t npresmsk __free(free_cpumask_var);
-	cpumask_var_t nmsk __free(free_cpumask_var);
 	unsigned int curgrp, nr_present, nr_others;
 
-	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&nmsk, GFP_KERNEL)
-			|| !alloc_cpumask_var(&npresmsk, GFP_KERNEL))
+	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		return NULL;
 
 	build_node_to_cpumask(node_to_cpumask);
@@ -374,7 +376,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_copy(npresmsk, data_race(cpu_present_mask));
 
 	/* grouping present CPUs first */
-	nr_present = __group_cpus_evenly(0, numgrps, node_to_cpumask, npresmsk, nmsk, masks);
+	nr_present = __group_cpus_evenly(0, numgrps, node_to_cpumask, npresmsk, masks);
 	if (nr_present < 0)
 		return NULL;
 
@@ -390,8 +392,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	 * group space, assign the non present CPUs to the already
 	 * allocated out groups.
 	 */
-	nr_others = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-					npresmsk, nmsk, masks);
+	nr_others = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask, npresmsk, masks);
 	if (nr_others < 0)
 		return NULL;
 
-- 
2.40.1


