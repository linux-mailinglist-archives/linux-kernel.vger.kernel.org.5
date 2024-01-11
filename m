Return-Path: <linux-kernel+bounces-23894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64E82B353
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F066284FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C750279;
	Thu, 11 Jan 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="limOh/Qh"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799A5026B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-28bcf7f605aso5180960a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704991838; x=1705596638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=coTF8H6/VApCNyDZSyKgzvq0UwcwbIR90wms3XVyTCI=;
        b=limOh/Qh8NpninifhsGWUoGUvcL3QtrAoOHH6pix5r0nmAwHa1XyJ9///wSYSIsg1d
         JpFm3zBUfyrzqsPK+eGnQFQoO6TPxM4GTPu9hhLhQAxfcVsnPMTwAfATHdq5T2ixpPKf
         uqGHDwyuMHqJ2lw7KQ1+Et5biFm01Nj4tnIY5qPAgpjk60lQnfhcHCPIYEuRcGb5/iCW
         Q+apOF7AgMaLeI3pcnShlqQ9j0fFgE3SmbTDzmLipCDyaStB6c4PqSEuBU8m7lIbcs1T
         HMH2t8i5NrRXxMfFNZ7eVe8XZj4NDS2fBzw3wSfuFwzy6CNwauFQi+MbT75gMGuLYLic
         HgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991838; x=1705596638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coTF8H6/VApCNyDZSyKgzvq0UwcwbIR90wms3XVyTCI=;
        b=EWiAyYrYhSN7CMd/ZMorR548yEzeAx4iAtPnuyNkIncmFtf+ztfiHNbxSANnMtwxAW
         pWNJgOu/UQgDYj7Vcx7ll7f02VSHBuJUfxEJrmk3dKs3AUxjXHNvfyUkOcxQ2sxWoNWw
         w3vdJPc5pgBhRFyR2y+8MdVK3f586IuxvQJNXrhbo1a0E8F8C6BZVW+iZZZqdrKH463v
         U7zUKgZj5oOoBzO0R3pIP9CE+5bPEKfqHhZ1Hd2wc4oRcUkXwvvAQij/vXubh+tntchf
         y7eLUjSDuBk+LjV8krBc7nEm07Cn3qKYSaRHbPmPUDRbocnrTjxmThW81bQ6yo+YsUh2
         ZnuQ==
X-Gm-Message-State: AOJu0Yys/ie3Poait2ZnGZgsM3kKSxmuqosIH19kKD3Zy559+YWpZQkN
	eDUlLMrl/Rxl4TVfUhU8iDOjkLxcQWK0IRz88JI4
X-Google-Smtp-Source: AGHT+IFCpeT8TO0CDr+kdjYeWOkXPtp4h+2DY3GsSHKqrWWWTnbbH8sY60YGOWIj1fasgxU58Xbgi+/mtAQHcA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:3d90:b0:28d:ba07:8c2 with SMTP id
 pq16-20020a17090b3d9000b0028dba0708c2mr3992pjb.1.1704991838589; Thu, 11 Jan
 2024 08:50:38 -0800 (PST)
Date: Thu, 11 Jan 2024 16:50:36 +0000
In-Reply-To: <20240111132902.389862-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111132902.389862-1-hannes@cmpxchg.org>
Message-ID: <20240111165036.w2qbetwrxb2mcur4@google.com>
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
From: Shakeel Butt <shakeelb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 11, 2024 at 08:29:02AM -0500, Johannes Weiner wrote:
> While investigating hosts with high cgroup memory pressures, Tejun
> found culprit zombie tasks that had were holding on to a lot of
> memory, had SIGKILL pending, but were stuck in memory.high reclaim.
> 
> In the past, we used to always force-charge allocations from tasks
> that were exiting in order to accelerate them dying and freeing up
> their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> prohibit unconditional exceeding the limit of dying tasks"); it noted
> that this can cause (userspace inducable) containment failures, so it
> added a mandatory reclaim and OOM kill cycle before forcing charges.
> At the time, memory.high enforcement was handled in the userspace
> return path, which isn't reached by dying tasks, and so memory.high
> was still never enforced by dying tasks.
> 
> When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
> overcharges") added synchronous reclaim for memory.high, it added
> unconditional memory.high enforcement for dying tasks as well. The
> callstack shows that this path is where the zombie is stuck in.
> 
> We need to accelerate dying tasks getting past memory.high, but we
> cannot do it quite the same way as we do for memory.max: memory.max is
> enforced strictly, and tasks aren't allowed to move past it without
> FIRST reclaiming and OOM killing if necessary. This ensures very small
> levels of excess. With memory.high, though, enforcement happens lazily
> after the charge, and OOM killing is never triggered. A lot of
> concurrent threads could have pushed, or could actively be pushing,
> the cgroup into excess. The dying task will enter reclaim on every
> allocation attempt, with little hope of restoring balance.
> 
> To fix this, skip synchronous memory.high enforcement on dying tasks
> altogether again. Update memory.high path documentation while at it.
> 
> Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

