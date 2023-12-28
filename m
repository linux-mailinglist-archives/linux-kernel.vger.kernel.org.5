Return-Path: <linux-kernel+bounces-12849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA17281FB21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3861F229AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF4125AE;
	Thu, 28 Dec 2023 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOtHbzZT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4611C86
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e7bb1e0db8so51508527b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794190; x=1704398990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TlZbwiWH1Vw1yns1kCBHb/nB4XyLWx4ePYr3lVNDe0=;
        b=BOtHbzZTOSKvn1C1KCqBDEpwzb1/GE9PqC7WuXzGgkBujhtePTR4z/0t5WSfYeXe7L
         dRB4nCEaSBgK7wKWDLgNttfAc7gOggJJu9F1DVwwC8Q4MPebygThcNJ86H3LkudI2iwZ
         kqfMdHbX5O7vuQtRMLL8t0NcaH4zMN8+pICWWPKIKM9JQ7CGIgUnmxH0Dsiu6SAuC3hI
         ffzrhr2PvZQnRNoKxU3Fal/aW7uFrYpjaQIzeacqHD1pdVv1LshLCvYwvXOo7l890UqM
         DP4f7nLpoYu1zzZaLQmnREtg1x3sapE9wTzItXrnTJP+SJ6BCI81sBvFkqh0F7PaB4HB
         e1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794190; x=1704398990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TlZbwiWH1Vw1yns1kCBHb/nB4XyLWx4ePYr3lVNDe0=;
        b=hj+RXtgtt5Hyit1j48wINCHRHWDKHPT3WhHXvs5Vem9/m7Q71oN/36KcMnmfHBWU63
         OS/6doNNYTzToyeHQFFWBS1BBVf9+kuTbQnUrNBhIM+kZrCMDm6Lf1IvPk2gSsfLVG1T
         rXItX3U6kgvBbKAI5qvrdW3W6adAVGKn8ncpmOvArXi2CH9EomQ681Bakk+j+BixPgRy
         q5K5d7CNIn/P57FNRFS/QzMqVydHjSoCCGIq9BTITRLnxPAA+kHFmQHiJpEXFcZ0rscU
         bCtNlQG6ywmTlpLz8ad8RLPDV0fwv6NwKaHXRulYYGsxZL9VEjHx2HPVqJgcUL7xMoJy
         CqfQ==
X-Gm-Message-State: AOJu0Yy+DJnED5NBlIgnklYweZT9ZAbK9R0adit1VuI9uNy8nyyFGO9H
	GZZTgJ0zi1ZZG39ESNcd9Ps=
X-Google-Smtp-Source: AGHT+IEWxqyGLbrIXb7NZcPO9H8pmvjZvPfzBkTcaALqI3LX+W+Usl3clXueRADT8bD6BbAx++kEcg==
X-Received: by 2002:a81:4522:0:b0:5eb:1edf:ae28 with SMTP id s34-20020a814522000000b005eb1edfae28mr5483139ywa.57.1703794189674;
        Thu, 28 Dec 2023 12:09:49 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id w126-20020a817b84000000b005e79f80959bsm7812882ywc.112.2023.12.28.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:49 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 8/9] lib/group_cpus: rework group_cpus_evenly()
Date: Thu, 28 Dec 2023 12:09:35 -0800
Message-Id: <20231228200936.2475595-9-yury.norov@gmail.com>
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

Leverage cleanup machinery and drop most of housekeeping code.
Particularly, drop unneeded and erroneously initialized with -ENOMEM
variable ret.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 79 +++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 54 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index b8c0c3ae2bbd..b9ab32e00a79 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -76,6 +76,8 @@ static void free_node_to_cpumask(cpumask_var_t *masks)
 	kfree(masks);
 }
 
+DEFINE_FREE(free_node_to_cpumask, cpumask_var_t *, if (_T) free_node_to_cpumask(_T));
+
 static void build_node_to_cpumask(cpumask_var_t *masks)
 {
 	int cpu;
@@ -345,26 +347,16 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
-	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
-	cpumask_var_t *node_to_cpumask;
-	cpumask_var_t nmsk, npresmsk;
-	int ret = -ENOMEM;
-	struct cpumask *masks = NULL;
-
-	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
+	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) = alloc_node_to_cpumask();
+	struct cpumask *masks __free(kfree) = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	cpumask_var_t npresmsk __free(free_cpumask_var);
+	cpumask_var_t nmsk __free(free_cpumask_var);
+	unsigned int curgrp, nr_present, nr_others;
+
+	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&nmsk, GFP_KERNEL)
+			|| !alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		return NULL;
 
-	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail_nmsk;
-
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		goto fail_npresmsk;
-
-	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto fail_node_to_cpumask;
-
 	build_node_to_cpumask(node_to_cpumask);
 
 	/*
@@ -382,11 +374,15 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_copy(npresmsk, data_race(cpu_present_mask));
 
 	/* grouping present CPUs first */
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
-	if (ret < 0)
-		goto fail_build_affinity;
-	nr_present = ret;
+	nr_present = __group_cpus_evenly(0, numgrps, node_to_cpumask, npresmsk, nmsk, masks);
+	if (nr_present < 0)
+		return NULL;
+
+	/* If npresmsk is empty */
+	if (!cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
+		return_ptr(masks);
+
+	curgrp = nr_present < numgrps ? nr_present : 0;
 
 	/*
 	 * Allocate non present CPUs starting from the next group to be
@@ -394,38 +390,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	 * group space, assign the non present CPUs to the already
 	 * allocated out groups.
 	 */
-	if (nr_present >= numgrps)
-		curgrp = 0;
-	else
-		curgrp = nr_present;
-
-	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
-		/* If npresmsk is not empty */
-		ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-					  npresmsk, nmsk, masks);
-	else
-		ret = 0;
-
-	if (ret >= 0)
-		nr_others = ret;
-
- fail_build_affinity:
-	if (ret >= 0)
-		WARN_ON(nr_present + nr_others < numgrps);
-
- fail_node_to_cpumask:
-	free_node_to_cpumask(node_to_cpumask);
-
- fail_npresmsk:
-	free_cpumask_var(npresmsk);
-
- fail_nmsk:
-	free_cpumask_var(nmsk);
-	if (ret < 0) {
-		kfree(masks);
+	nr_others = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+					npresmsk, nmsk, masks);
+	if (nr_others < 0)
 		return NULL;
-	}
-	return masks;
+
+	WARN_ON(nr_present + nr_others < numgrps);
+	return_ptr(masks);
 }
 #else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
-- 
2.40.1


