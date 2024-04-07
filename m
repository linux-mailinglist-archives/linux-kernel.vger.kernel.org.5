Return-Path: <linux-kernel+bounces-134230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6589AF46
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B411F21F6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A503F9CC;
	Sun,  7 Apr 2024 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyoiW8Px"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308106FC3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476533; cv=none; b=aexVEGkQ2b68LccpZYGhRGc6zWmmts9V9qyJxRNBVboknKFy1MTm5Gd3rjF/8OtqjnFmOuF1CgPke/zKaS6MMZ8b9+AVcl/U7da0xW44BN6WEIZ/iEzlYQEOawB1Z/F9LgL+kSz68JZTzcC+EGvXGQNcRTIZ0su2T4sE2pBlc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476533; c=relaxed/simple;
	bh=+B8d/wmf1YxZiAa4fbdsDHljotFFId2D8bExhgkmTFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bz/RCgs9FX4xNLoVBD6X+9TwUBSVZVhQr7KEP9WKodQuoAmtiTjw5r27TmMIHvRm3R0s1cgO6BCu3Y3JSgfxtmxhRFJcRxs+Y4GErSLLGLA63HtPlA1clvQrShnTFooYvFmFUH6aM//xpBqx0p51eCYYxH6jLWNEYPVWRIjThjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyoiW8Px; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343e46ec237so1643933f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712476530; x=1713081330; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g3MTv1Idd5V8ahBC+akHFcdn0CaAt9Plz28mXNpxS2Y=;
        b=OyoiW8PxzcfBbRcR4SlqocWzgaawyzu7HD9m+2HApDaSPFaI4Am+wIVkWMZPFRljO4
         OjGgAWChjueSgOrbOaacitwEV+Sl6QK12zL92lKFE2RWOWiQyMZ43ZBsbf2D647wemO0
         m2YUtakiFRtt6JSca/Zgdf2kqygDXrfV9eQBpskyx2VW7KGuCN1FoBmZiJnGwojqjM4f
         LYmKGHboeM+3lzR8LuVB0L/e9Y7CfEhlhicZMi6RuV4KuqmmI56xM2DGiS2SW0GcCsSF
         KaUvZ2H6Bk4IV6yWrvmdOKVV5pvxNhov/ZFHTYcbdmR0cHpu9w9/ONXhYc7A1EqcRD2g
         iSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712476530; x=1713081330;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3MTv1Idd5V8ahBC+akHFcdn0CaAt9Plz28mXNpxS2Y=;
        b=nuez1KpYonESwOXYOcRvxW9m2FNLi6Zq5Uq0pbeNhjZxKgTAyMBkgE8RVs1Ag2lcz9
         bj0Ggpzqk+wV6yLFPgf7VFDx8Meujx9THajox8evelruv+Mujc98MlT4J6fW/Pu40d/x
         P4YvS+rkujyaCBipk3F5FInhsj9LswGb0E4ji4YI27EGY1HkPwyRafdlY45oFfrv8g6E
         hxHNG1NT6KzyuHVRfPzCIoGxV0XqCIN4RhgIFWDgIZDuYRESBs7/ogGWatoKRg7EhHxl
         9zScqKx1P1sALBH2FdXCP+9TZDxXgpgNiLGk6lkU85jcfPKTjUibj4HpNrJQ2nkfRWsp
         opAA==
X-Gm-Message-State: AOJu0YwE135xSWH2GMpT3Nejt6keoQhl+JGKZBTNKrSSsu+2cV1HIscV
	Kc4kiUZsJHz+wobZKE39FjxkKgcjfMPfNljx6QhRmD+L3/zJU7KW
X-Google-Smtp-Source: AGHT+IHHYgL/8qifd/w5Lh+AI03DdF4/WJsH9k/EPGUJ7XTe8esElIx635OUsBPWpW4Y7t0p+fylFg==
X-Received: by 2002:adf:e50f:0:b0:343:3a38:d934 with SMTP id j15-20020adfe50f000000b003433a38d934mr4444416wrm.19.1712476529986;
        Sun, 07 Apr 2024 00:55:29 -0700 (PDT)
Received: from gmail.com (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id x8-20020adfffc8000000b00343c1cd5aedsm6084796wrs.52.2024.04.07.00.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 00:55:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 7 Apr 2024 09:55:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fix
Message-ID: <ZhJRb8TBJOLEEES5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-04-07

   # HEAD: 312be9fc2234c8acfb8148a9f4c358b70d358dee perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event

Fix a combined PEBS events bug on x86 Intel CPUs.

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event


 arch/x86/events/intel/ds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2641ba620f12..e010bfed8417 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1237,11 +1237,11 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	struct pmu *pmu = event->pmu;
 
 	/*
-	 * Make sure we get updated with the first PEBS
-	 * event. It will trigger also during removal, but
-	 * that does not hurt:
+	 * Make sure we get updated with the first PEBS event.
+	 * During removal, ->pebs_data_cfg is still valid for
+	 * the last PEBS event. Don't clear it.
 	 */
-	if (cpuc->n_pebs == 1)
+	if ((cpuc->n_pebs == 1) && add)
 		cpuc->pebs_data_cfg = PEBS_UPDATE_DS_SW;
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {

