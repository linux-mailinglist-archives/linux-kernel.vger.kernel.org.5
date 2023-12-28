Return-Path: <linux-kernel+bounces-12762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BA81F9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EE81F2443B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F5FF4FA;
	Thu, 28 Dec 2023 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iidfHTAN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D3F4E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-554dbe1857dso3741255a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703777651; x=1704382451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75j1Tuw2sMYHrBdwhMsY/vjsJuT8QMsKkqQlgA1wbFg=;
        b=iidfHTANKMHgrrvevNM5tzAq/QUTr5+RmTa/GH8Kqz+/utP08gsjCr86h2Z8WfAH5/
         G4WhFgvWBi9CZV227q5MmBabf0v1kQkHBLdhQblEkhf6MwA07gdsQWS0nJSNAeu5AHGo
         sWrWsskc4BzjhaUAjbnZm2e/HszExdHtvdFEJ/l0mJGWhr4Qs71tr547qjfVoN0FhEzp
         27zM46vAQfVjxpnzaWZRRsLF+oFZhqoYSCOGFsXoUobKVuN0b8cW9ByYfpkkqwUeOBy8
         +YHxTRhDQVSr26co81fBOKlEN411yK331JI/dNsggd9hRyZmx2YhokEJLjbeh8/O8pfu
         h8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703777651; x=1704382451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75j1Tuw2sMYHrBdwhMsY/vjsJuT8QMsKkqQlgA1wbFg=;
        b=tJlDzzPG9UghnStr37g224K0A1rXHS5cp50N7PIEJMEOiYXN9wfPAkJYF1Xz3zf2Xn
         ITYQdqskSE4/D8szM4AKcE9kqhnIdnsIWEIZnoii9dTc2FOp2Bvjyt48IZbEjU3dvlHU
         NoUv3o3eiRbkr/nnovgfescQC7LhQ1T/HgcJZb3XUH8DjP62czvWYNkeTGbZBtHRe0Au
         COLitay8OqYC9MPnrc99oxEkvA6UILd/C/RDR+MzdceJLYR58YQGikhH4dEJMuD9r/IV
         lL/wPF4VJJpCCyFdrsyQz4mbtMuMrpbnHPmrrKYUd3uJrmd48KjBX+ZCmFQn/4DdEgd4
         6Hxw==
X-Gm-Message-State: AOJu0YzIMiWvlGUWrrvV+m17sN83R5Unn7oUqYfjdiFZHRUMhONVmZXX
	SMizU3zVEYvoFJppHlXXngPki1zmRtA99iSckghCiM8itJme
X-Google-Smtp-Source: AGHT+IEVdgeTgEcIj//cXTspyGF7Se6NK2vltYXoZjZd9YUDK9xPQVKpC7XTmsxWy7ooa1IF1ltop0GyQm2+l6XbOMA=
X-Received: by 2002:a17:906:fb01:b0:a23:6143:61b5 with SMTP id
 lz1-20020a170906fb0100b00a23614361b5mr6356178ejb.129.1703777650946; Thu, 28
 Dec 2023 07:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
In-Reply-To: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Dec 2023 07:33:34 -0800
Message-ID: <CAJD7tkY6XF_rhnAzqhZ-mo8yw-W4hOjxFsbvH04oqVr0u8mOzQ@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	=?UTF-8?B?WXUgWmhhb++/vA==?= <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:25=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
>
> Further investigation show that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
>
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
>
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
>
> Move free_swap_slots() outside of the swapin page fault handler into an
> async work queue to avoid such long tail latencies.
>
> Testing:
>
> Chun-Tse did some benchmark in chromebook, showing that
> zram_wait_metrics improve about 15% with 80% and 95% confidence.
>
> I recently ran some experiments on about 1000 Google production
> machines. It shows swapin latency drops in the long tail
> 100us - 500us bucket dramatically.
>
> platform        (100-500us)             (0-100us)
> A               1.12% -> 0.36%          98.47% -> 99.22%
> B               0.65% -> 0.15%          98.96% -> 99.46%
> C               0.61% -> 0.23%          98.96% -> 99.38%

I recall you mentioning that mem_cgroup_uncharge_swap() is the most
expensive part of the batched freeing. If that's the case, I am
curious what happens if we move that call outside of the batching
(i.e. once the swap entry is no longer used and will be returned to
the cache). This should amortize the cost of memcg uncharging and
reduce the tail fault latency without extra work. Arguably, it could
increase the average fault latency, but not necessarily in a
significant way.

Ying pointed out something similar if I understand correctly (and
other operations that can be moved).

Also, if we choose to follow this route, I think there we should flush
the async worker in drain_slots_cache_cpu(), right?

