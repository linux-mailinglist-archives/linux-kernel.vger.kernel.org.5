Return-Path: <linux-kernel+bounces-10314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41281D29B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09D71F23240
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C76AB6;
	Sat, 23 Dec 2023 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yr6Yw+F/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CB63A0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso195615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703311905; x=1703916705; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Abo/6b6Ud8/ygj6vePFRQy4/FPhVI580YuqrRjDjYA=;
        b=yr6Yw+F/Bm1dDBUFwdCeaPusypN0rKg7YL38TqtATbmw+23h7IN7HrPODbZC5GPDOl
         NAydxZNYg3nlxCUCUE96JD7gtUqsC+hvgBS6mKKev6bJkos+wCA21y66ZQo9WibNN9Jl
         Ips/XUBBz1B3KD3Vd8mkKS8FlpNdCkZEc4diI87c3/EE+ugACb6YgzjzR4XlfWwfVTH/
         UephqtK2fUW0fKJZXig1o+nBu7mQZ3lwv6on44fB61UT5D88RybYzGnt29XoIBnrqZat
         VPMAAjXdi4lTEPFLihT04n673J5JVBBzynciIxTWtfTKwXBJFS4QdzmSGbtqpvH87T1/
         s8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703311905; x=1703916705;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Abo/6b6Ud8/ygj6vePFRQy4/FPhVI580YuqrRjDjYA=;
        b=AuLfYNEyMtyMIWNqU7vHvJ4KDQyCPaUT+oYu38tqY4/4m1s/+zveLuAYQ/6Ii0oIjJ
         jaqj+Q3quliqTuYKZIJSAif83MknAl1Dg2CQKRgQIEeNujVLszD//yp74OKgnbZZhzyw
         64GDLQHzSgTovMjXzPSb7x7bUT+3815wR488gL/1OmXvdjqmi2ljRWlAjc/vCDyxrGSq
         SYZEdByQ9KRbUEFt3k+SERyJ1p1rMFraWNRyuxA2zYmoWRNhiJGVosyLoTX8y2waQEkl
         eXuejOowNQtQ9HWwWJioAu03/O46s+Un2/WhVesgk0O876AbInD4wFdrHGiFmxF8OMvg
         oTiw==
X-Gm-Message-State: AOJu0YzSoJ/vRZNnAMH0qB3h9L7aXhMin5R1lYtE1krRe1JPfgznr35j
	gedU1pK/y0XO9GhiN9IswhRDiNgWvRPl
X-Google-Smtp-Source: AGHT+IE/W4mVw3DWpGmrlczeA0IjpfFgzLnX0g85PAh4xhNoYsEJy7KSW9tLOeVYqkIg5GlB52iHtw==
X-Received: by 2002:a17:902:f983:b0:1d3:d270:de8a with SMTP id ky3-20020a170902f98300b001d3d270de8amr181071plb.25.1703311904688;
        Fri, 22 Dec 2023 22:11:44 -0800 (PST)
Received: from [2620:0:1008:15:ed14:1d0f:e856:8a58] ([2620:0:1008:15:ed14:1d0f:e856:8a58])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001cf511aa772sm4373015plb.145.2023.12.22.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 22:11:44 -0800 (PST)
Date: Fri, 22 Dec 2023 22:11:43 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Chris Li <chrisl@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Wei Xu <weixugc@google.com>, 
    Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
    Chun-Tse Shao <ctshao@google.com>, Suren Baghdasaryan <surenb@google.com>, 
    Yosry Ahmed <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, 
    Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
    Zhongkun He <hezhongkun.hzk@bytedance.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>, 
    Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
In-Reply-To: <ZYYY1VBKdLHH-Kl3@google.com>
Message-ID: <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org> <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org> <ZYYY1VBKdLHH-Kl3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Dec 2023, Chris Li wrote:

> On Fri, Dec 22, 2023 at 11:52:08AM -0800, Andrew Morton wrote:
> > On Thu, 21 Dec 2023 22:25:39 -0800 Chris Li <chrisl@kernel.org> wrote:
> > 
> > > We discovered that 1% swap page fault is 100us+ while 50% of
> > > the swap fault is under 20us.
> > > 
> > > Further investigation show that a large portion of the time
> > > spent in the free_swap_slots() function for the long tail case.
> > > 
> > > The percpu cache of swap slots is freed in a batch of 64 entries
> > > inside free_swap_slots(). These cache entries are accumulated
> > > from previous page faults, which may not be related to the current
> > > process.
> > > 
> > > Doing the batch free in the page fault handler causes longer
> > > tail latencies and penalizes the current process.
> > > 
> > > Move free_swap_slots() outside of the swapin page fault handler into an
> > > async work queue to avoid such long tail latencies.
> > 
> > This will require a larger amount of total work than the current
> 
> Yes, there will be a tiny little bit of extra overhead to schedule the job
> on to the other work queue.
> 

How do you quantify the impact of the delayed swap_entry_free()?

Since the free and memcg uncharge are now delayed, is there not the 
possibility that we stay under memory pressure for longer?  (Assuming at 
least some users are swapping because of memory pressure.)

I would assume that since the free and uncharge itself is delayed that in 
the pathological case we'd actually be swapping *more* until the async 
worker can run.

