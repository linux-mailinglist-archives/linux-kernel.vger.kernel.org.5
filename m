Return-Path: <linux-kernel+bounces-24992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D917982C5B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0B4285D43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158215ADB;
	Fri, 12 Jan 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFiytkCm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48716404
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d47fae33e0so14735ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705086258; x=1705691058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeDNfRNz+QBqCGpkSmD12YuuNM7kkG4W5cbld1c18MA=;
        b=kFiytkCm1R+8c1q7yaCct2NDajQr5TXQqcmRVgDjOk0tUjkAIxVvMRG0cOu0ZoweY0
         RHvHgkFF9Sjp8t1tyWsEjRGX6QQ2QNxL4aNIsGT23/bYmsyDpGYaf5vqvjlJKuVezZyS
         BDtBt1afEK31mgyn8w7MCvzJSuatLCsa/lvBsoEWv1MJFnXmAoEJzSOMADOhi5rQndd9
         P9VRElRhyt12785V6U/RQtvQjBkVgRF793bJkHgHDOg9kf9L+huaSo4XQkY+cs7/2yJs
         sJxbX1EQypf/uqv4jVxhAh1AJt1JPq00u9JGD4GulfWYKFbvQeQjLs5ISwRr6ilDW6FC
         Vc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705086258; x=1705691058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeDNfRNz+QBqCGpkSmD12YuuNM7kkG4W5cbld1c18MA=;
        b=K7f2BtnYd8SbPOVr0OBB+8MAQ4C0uiN1SJtwkjEP1efWRcE18toXtt26Jh1EdnPzD/
         8+WzmND/RQyudSYUp0PGw0z4HpZt2mJGfQaNC+tsZ4yRG+3JMt1acEyCBfEi3+zUOQPx
         1USz64n3QWBTZSLvYkqbXCIf/8t9u3k+nhhlOf3M605jNa/46guza1YzUZhov3qAjvzI
         u+Iq0ZKjRxet+Qr+JHIj3y2k4g3nFMugqp5AUXPuh6xVVqSctYZZThjb5bpKOAdXHGZB
         wiwgHogg/SzrV5zp9PECEqKiq4XpwBIQpd/fxNoijgJv5ajyLsZTr7jDoQOdr3Jrd0bH
         qBWw==
X-Gm-Message-State: AOJu0YwHiTVgtF6YGshV0FNnxcJLm2/LBs68CGCGvo3DUbgo/UU1yPDs
	EpO7KcDGN7Z9llr6S6JOn4tZYXjrLfOeHfVYR5bvjowUG3vV
X-Google-Smtp-Source: AGHT+IHmDtIiBSAvIHSBY0fw1ypkyv9G7sKc3LzyfT2UTtNc9WEqtghWjTCXS9f8DCtoFJq1xC6QuTVb3XSU99Lf5Rw=
X-Received: by 2002:a17:902:d4c5:b0:1d0:7052:aa20 with SMTP id
 o5-20020a170902d4c500b001d07052aa20mr451697plg.12.1705086257476; Fri, 12 Jan
 2024 11:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111132902.389862-1-hannes@cmpxchg.org> <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
In-Reply-To: <20240111192807.GA424308@cmpxchg.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 12 Jan 2024 11:04:06 -0800
Message-ID: <CALvZod6eb2uPPW+y=CnB_KumOW-MJjqJK=zOqfzwwJ-JX9eP0g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:28=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
[...]
>
> From 6124a13cb073f5ff06b9c1309505bc937d65d6e5 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 11 Jan 2024 07:18:47 -0500
> Subject: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.hig=
h
>
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
> Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large =
overcharges")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

I am wondering if you have seen or suspected a similar issue but for
remote memcg charging. For example pageout on a global reclaim which
has to allocate buffers for some other memcg.

