Return-Path: <linux-kernel+bounces-64768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E485429D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4875B2864A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2AC11CBD;
	Wed, 14 Feb 2024 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnlYhY3Q"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE3111BE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890763; cv=none; b=QWoReFhF6HxtyXWduIwTEYKOw/e6FUti8zfEVHEWqGl5z/jZBiqQ5ptbBiZmUhntRHumWe/j8pY9fsh93k9genng/PfgVyw2HDYzpXvHw+p8/nDzC68PeIMEntV8SgCkamUNZ1VpcKsO/7Lq6kI/FFSWesXV0FOsuFBGfuzm6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890763; c=relaxed/simple;
	bh=T/QGXqkR1FvOAuC5zznScAzCN6HFAcM6dUi3a9AX+sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TP0aqG/aKi3LlPcOo3UhZMIEth/k+I8VCUOZElHWjfAC+3NNhUBvBI9xLNGmjgfEGlXgv2lRSdGgpGt6wT833W52eZBB98YA/CRva/cLJ7vJ1A3AwkWCeyVtJnmqXYvRoyFT/wpFUdl+8F5aeObl9p0aEzb+uO5jlfJnX4rdBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnlYhY3Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645a6790so9467916276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707890761; x=1708495561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oan+94DZASviMy6e/v6AGJHUkNS1XGpMmnaov86Qm34=;
        b=KnlYhY3QcWeDvbOKhL5WnPWBsWV4a1i7L6Tjo4XmvoRndsskAZf39tTyPeH5mPyld8
         kRVU3z2ep1UTdv75VhPCpF6XmXC2puL94HcV5Bc5VULB3W70tjOW0uIF4zjgWcFA7GA8
         oX7vpYtW/Ix02MIqRdJwEdQ2hz/S8geSp0hStnNjCglnazEiItuiahkZqweuhbkAsR4L
         FGelscy0th2vaDlTKhN2WsJdUc+Ba8R4O8M2t5cTUpZqPD1Gz6JKXoG0kehPhP5624Jq
         CG87dOOmxPCVRI6owehaXr91E9VABYun0xs1AnERSWBTlqWXeRPPd565e9RCQ96Hr3w+
         qtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890761; x=1708495561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oan+94DZASviMy6e/v6AGJHUkNS1XGpMmnaov86Qm34=;
        b=FxOdf8GdQTiP33+VzyF4I54cqnCN1H6TPS/RtZXhvhssS7RnUxUsrtsD3yEiMhb3+s
         X64j8XXJkeZ5aZWYBU6ncov8VPv8nnjqM+zz6fAep+jvAea/no3QzzGDB2EfkRyWGcJH
         Jh88AYl/TD3ke3clWCj5uJnoPNP/JE4fEFyvx8DWeall+2Q4D0VAlRZM5/dXGP9qYUuL
         n6cjpQGshKRRIZ5Jo937/C3FKydVAkwX+mJme+98Z1J0HrqlTjwapf6dTshruNkZK8Yp
         yuZpCP6EjefFSMxXgFzil2lYbcVBV7PX++wegciYg8TvW42UURPGQ9GjVSyPTmZknq90
         hi5g==
X-Forwarded-Encrypted: i=1; AJvYcCUl93Yyo2PPdGJZspcO6uFjfpyV9SGD71NReKUyxLXKR66jT+f4e6TY3t5aGTvo4yOCzReDLxwQbXhyfjTE4U4tPX9Vh66CgoZqepx6
X-Gm-Message-State: AOJu0Yw6/XSmE3SzE4o7iYiNoFfpRiIW1SN+LvlofHDJLhLjiLV+i/pK
	lmZJvyr0FkMHf60x6+0zZWzjy0kuBBwR+9Djti7QZDzvXvYuAVZuroRp8sknUypBK1kk4N3CFIE
	Rt3NXAJgJSw==
X-Google-Smtp-Source: AGHT+IECTCgII+UlLQnb07kGfoMwJpWECxrLnQCitRZFg1hQDwcIyXTVjd31/aZJ1ay0iHXrZplnkBjLTApk8w==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a25:698d:0:b0:dca:33b8:38d7 with SMTP id
 e135-20020a25698d000000b00dca33b838d7mr320126ybc.11.1707890761264; Tue, 13
 Feb 2024 22:06:01 -0800 (PST)
Date: Wed, 14 Feb 2024 06:05:35 +0000
In-Reply-To: <20240214060538.3524462-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214060538.3524462-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214060538.3524462-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 2/5] mm/mglru: improve should_run_aging()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

scan_control *sc does not need to be passed into should_run_aging(), as
it provides only the reclaim priority. This can be moved to
get_nr_to_scan().

Refactor should_run_aging() and get_nr_to_scan() to improve code
readability. No functional changes.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/vmscan.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9d15648561ec..87de39e7410b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4602,14 +4602,13 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 }
 
 static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
-			     struct scan_control *sc, bool can_swap, unsigned long *nr_to_scan)
+			     bool can_swap, unsigned long *nr_to_scan)
 {
 	int gen, type, zone;
 	unsigned long old = 0;
 	unsigned long young = 0;
 	unsigned long total = 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
 	/* whether this lruvec is completely out of cold folios */
@@ -4637,13 +4636,7 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
 		}
 	}
 
-	/* try to scrape all its memory if this memcg was deleted */
-	if (!mem_cgroup_online(memcg)) {
-		*nr_to_scan = total;
-		return false;
-	}
-
-	*nr_to_scan = total >> sc->priority;
+	*nr_to_scan = total;
 
 	/*
 	 * The aging tries to be lazy to reduce the overhead, while the eviction
@@ -4675,6 +4668,7 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
  */
 static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool can_swap)
 {
+	bool success;
 	unsigned long nr_to_scan;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
@@ -4682,14 +4676,17 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
 		return -1;
 
-	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
-		return nr_to_scan;
+	success = should_run_aging(lruvec, max_seq, can_swap, &nr_to_scan);
 
-	/* skip the aging path at the default priority */
-	if (sc->priority == DEF_PRIORITY)
+	/* try to scrape all its memory if this memcg was deleted */
+	if (nr_to_scan && !mem_cgroup_online(memcg))
 		return nr_to_scan;
 
-	/* skip this lruvec as it's low on cold folios */
+	/* try to get away with not aging at the default priority */
+	if (!success || sc->priority == DEF_PRIORITY)
+		return nr_to_scan >> sc->priority;
+
+	/* stop scanning this lruvec as it's low on cold folios */
 	return try_to_inc_max_seq(lruvec, max_seq, can_swap, false) ? -1 : 0;
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


