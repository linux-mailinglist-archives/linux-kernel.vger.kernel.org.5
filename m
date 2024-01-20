Return-Path: <linux-kernel+bounces-31692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A98833287
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2869C1F22C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D99FC0E;
	Sat, 20 Jan 2024 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/0q5VZ/"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFBEAF1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719071; cv=none; b=AYFvBZTtVBeNTOT3YI6VN+42rTJMIyrzIVEOQqW6oO1s8tEnquBJ/C4CpRqNeqIAgo4OP7st60D9dE9KaveCgC2810d0F4IyYSIByTcmnSIcR0ENABgIFO2yrxNv9CwJN4XzYTHgGCLsLSb0RDMK2KeJtiiDT9SjYW3qXeyIS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719071; c=relaxed/simple;
	bh=UIQYKYf6qv+31oI5sMl8bv/xnQG3+D90nWie+7vmd3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VykBEM68inBEg41/JvTH8FNrK/lYqX46V8VYcPJ30/GzdzIdOA46IdapMKGBo6M5Dmm/+gNmWdxIcbUxLElNQHZJc3ImHflFORLG0xjKgNeGw9/o9vtfBqtJjOuHfORgxtF27kCcrz9YQYhetAC+CbXw08LvfDvaLf6zg5JfpLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/0q5VZ/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc223f3dd5eso1237950276.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719068; x=1706323868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHN46ZnhVRtGaHejqRmQyDg/24XoRBDottjOY+gFecc=;
        b=U/0q5VZ/ktJTriBXLaV5A6vyIl1cqBNY9Nt3bCcjafPH+WB/x2nFmanFi8yC9bsRET
         Mhdgj496ZZV9lTKOdqHJEOvIQ6FgYW7MVlzxru3T7fRJIHQkYd++kO/wt9HZgsyQkTVs
         CLvKZqflnEdEFbZTrwYfyyh1qf+HOgqvH3AdE9tg0lTvgoHCfzQfINod23wBLpcLRUHr
         GG+lrPmILnLtKNkqGgsXkmR3lU1veQ+EWCNhgVKt7Edw94ujieR+7pHP0AGOCHDWWxbt
         J6rfZkJEbgA5gPsc7s4mlQqnktrGnIkvVK2mGc2PnhUqAmrP6saO+PxWs0l6T5LYBJTJ
         KClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719068; x=1706323868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHN46ZnhVRtGaHejqRmQyDg/24XoRBDottjOY+gFecc=;
        b=u+wgAnPncYjBqBhFUjs6A4oreUuVOhbP4Kw4bTqGyeKiAw+Yvz2ofBJ8h5FjDwtSoj
         wd/RGlgVfWGxODDgVpokX1ZjteF77IWnJGQICi9fX9JQxtO7g3Phg+KAlwttq59jI5qn
         AzQAtTJLLTmf6uCrWLEB7yqFx6K86ugriaAgrxx8Z1UK6m+ZqHDoHGvdBYH6wzE9VOcp
         JwXajVoKmRawZ6V4/9J+s3P6N9/YuPQ8xGA3+KjgoHWMhETNO21djlxwdm0H7Zrd18W7
         5AEXkEFkthEt7dj5mfdD8s5FALsVEeM6TF+S/Ekacy0a6TJuF9o3iKGBDRL09u7cL1Bs
         rhBw==
X-Gm-Message-State: AOJu0YyU3dZp6270ps1J9k4qe6LglxyYkKIzx9NNtiLK+6kimN3InUlo
	1nk6Gd3vmyQSsryYaaRluhNqk89nx8ONpVUOwDEXj2mZyMAADXc1
X-Google-Smtp-Source: AGHT+IHCZLAVrRY2oNLTx0e7hzc3AHDIllg73ghGrBa88/4cdw1RA9LuKkpABJdDuzgxVwF1pjClBA==
X-Received: by 2002:a25:e081:0:b0:db5:3e3b:d2bb with SMTP id x123-20020a25e081000000b00db53e3bd2bbmr907407ybg.48.1705719068318;
        Fri, 19 Jan 2024 18:51:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id s65-20020a25c244000000b00dc2310abe8bsm179790ybf.38.2024.01.19.18.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:51:07 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 9/9] lib/group_cpus: simplify group_cpus_evenly() for more
Date: Fri, 19 Jan 2024 18:50:53 -0800
Message-Id: <20240120025053.684838-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120025053.684838-1-yury.norov@gmail.com>
References: <20240120025053.684838-1-yury.norov@gmail.com>
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
index 4c09df9eb886..71e802fca35f 100644
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
+	cpumask_var_t nmsk __free(free_cpumask_var) = CPUMASK_NULL;
+
+	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return -ENOMEM;
 
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
@@ -350,11 +354,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) = alloc_node_to_cpumask();
 	struct cpumask *masks __free(kfree) = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
 	cpumask_var_t npresmsk __free(free_cpumask_var) = CPUMASK_NULL;
-	cpumask_var_t nmsk __free(free_cpumask_var) = CPUMASK_NULL;
 	int curgrp, nr_present, nr_others;
 
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


