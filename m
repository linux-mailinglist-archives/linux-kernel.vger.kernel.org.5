Return-Path: <linux-kernel+bounces-10629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11681D7AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9571F21C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474E110C;
	Sun, 24 Dec 2023 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwsqWzi0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C610E1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3e4637853so257755ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703386876; x=1703991676; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+F/gcQTO8i2i7S6SvYXe9DNREVuwkHj8qUrFkzAp/gM=;
        b=HwsqWzi0z9a3tiM4yJ6tsyRBjqmI7DzL9H0xyCxVfg5+UeK9UuBR3GSlafYBIVqeG0
         gTJhT5JiK0vHkcGvcvBq1A2kRlC4B+yjCP/rH8pIGxvinWnLfnEiKSPWcJNActr8ZQmw
         y2QvjS8CefT3kTrcm6elC6U0oInVTk/0HFdUJntKE6uyC9mwxGRjTvDJY6qzDovbgASf
         eLRLYP7tbJAE3wdbEi9iWXf0D2Cs9FLte3NqjhJ9brYLfcu4miwvdc8K29CExcY7rnqW
         HXxFv4XNeeRkhV2FaEFL+iblZna49cecQ87CqX4sHSR1yWFyNzuppHVIn93Brke3aVq+
         Li/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703386876; x=1703991676;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F/gcQTO8i2i7S6SvYXe9DNREVuwkHj8qUrFkzAp/gM=;
        b=XVyFds6QlmxItYYhK5V+77LmrNkI7vDI5DiTNULfidfp82q48nVpXkfwfOGxC1odQg
         Yg3/wwczEZli5PFBEZpovoGxfWS1NuN+ved0MvYqt+A4Wo5NED3qvHVWmNaTtQQtUHWd
         wctCsFVjj08jngH27ol31GufAiAawAGYRMVKcCm7m0eLRWPTpEXdfQ8qMuHkygxB5zq+
         mR752owP92Z9F1Fl2dJmzyv/66bL+TYQ6+PRZw4vC90keJwJqbheaSJ7/HhWYOILuSrT
         uHTyLTfo/HdraNgWyZw/HG6hLtyKi4km9Je2LoU+T/XQ+nQ8OVDZWrtl451Bv2GkHdS2
         65/w==
X-Gm-Message-State: AOJu0YzUydoFo+mQrvwOpP5nnft2ZnvwWQ1nPVj+VSQ1IOIA4CHos/kN
	bpMUlsLtDWRwo0y+T1eSVRSg/qGa10Jh
X-Google-Smtp-Source: AGHT+IFQZRwyjdadHfaO6XJLQwvgeaTJ9wxak9JiLpGUOKT4elJG7t1jjZrEBz0aO3Av7+dtK8DOGw==
X-Received: by 2002:a17:902:d584:b0:1d0:9fc7:6bdb with SMTP id k4-20020a170902d58400b001d09fc76bdbmr263654plh.0.1703386875783;
        Sat, 23 Dec 2023 19:01:15 -0800 (PST)
Received: from [2620:0:1008:15:ed14:1d0f:e856:8a58] ([2620:0:1008:15:ed14:1d0f:e856:8a58])
        by smtp.gmail.com with ESMTPSA id gx10-20020a056a001e0a00b006d9a6a9992dsm1576151pfb.123.2023.12.23.19.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 19:01:15 -0800 (PST)
Date: Sat, 23 Dec 2023 19:01:14 -0800 (PST)
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
In-Reply-To: <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
Message-ID: <0a052cb1-a5c5-4bee-5bd5-fd5569765012@google.com>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org> <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org> <ZYYY1VBKdLHH-Kl3@google.com> <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com>
 <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 23 Dec 2023, Chris Li wrote:

> > How do you quantify the impact of the delayed swap_entry_free()?
> >
> > Since the free and memcg uncharge are now delayed, is there not the
> > possibility that we stay under memory pressure for longer?  (Assuming at
> > least some users are swapping because of memory pressure.)
> >
> > I would assume that since the free and uncharge itself is delayed that in
> > the pathological case we'd actually be swapping *more* until the async
> > worker can run.
> 
> Thanks for raising this interesting question.
> 
> First of all, the swap_entry_free() does not impact "memory.current".
> It reduces "memory.swap.current". Technically it is the swap pressure
> not memory pressure that suffers the extra delay.
> 
> Secondly, we are talking about delaying up to 64 swap entries for a
> few microseconds.

What guarantees that the async freeing happens within a few microseconds?

> Where the swap slot cache itself delays the freeing
> of the entries for an arbitrary amount of time. It is not freed until
> the cache is full of 64 entries. This delay can be seconds or even
> minutes. Adding a few microseconds of  extra delay to existing seconds
> delay really makes no difference from the swap pressure point of view.
> 
> Chris
> 

