Return-Path: <linux-kernel+bounces-10825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61D81DC71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525681C20E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DBE56B;
	Sun, 24 Dec 2023 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtDIJmYI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729DDF63
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3e4637853so287365ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703452418; x=1704057218; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld/PwS9QxP35fVzGwf1si/oFabvWirIW5YkS+UkDPZo=;
        b=rtDIJmYI2gswWArQX4wkzjaK7+ATjuDkQvPSKYMSWlLp4EotOC/L/SII9C3oG8d583
         7OVLj4EOh2FFXeM1+PUu4OOm0fnFAOQI47hUfIZtg9UaSfdJlPPcx6BQDA5bSjBhO1G6
         Mgp6Ho1uu/KVk3tTIEm+eXBt8JhnZ64OsAO/wN5lLV3RLkNpKayPlMzpj979jrxLMhS8
         7wK1Mi/D+4V7NnFRpLtyb8wTi2WYeiVgE9Ba50nyqQ6lxA+lk1HnsgYLF30Hzv1Zlr2C
         jqoTzbZ4qbJ8F76mWfHeWMgXIPWYqYbgzGD3rAZAnMzxzKWrd70HekPqdy3gqZup4+Od
         +M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703452418; x=1704057218;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld/PwS9QxP35fVzGwf1si/oFabvWirIW5YkS+UkDPZo=;
        b=Q6jd4YuOJ+6RylnEcVWxHVE4I6ARb9p0kgELN+G5HeLwEmNPuH+EBNlGL7OnUSjsE4
         tGbquuNgqPH0wd2qu6q5ZU8RN229RLXtGj3apuNzcLZyQCciGnN9sXuZBov8J6huym6A
         EnbleF2WAU3fgRc9jIjugMtgioKVuYvCjL02dTD5YsBduWwe5/00biF9PN28PAI3Ws8c
         c7nS4UzHmbAnRe+RNb4VeganOVh684xmecroS9W5t1sLOnGH2fjHpLQ0jA4VPCRsGzJI
         U3P1IU27SBC0aAe68Wv9M6cgygniVjkILIG0msTDUYNcL6va3zlIaBxIOWggVB5Dyw9L
         jAOg==
X-Gm-Message-State: AOJu0Yx1NPSRNSQGi24QOa6lTd6njCvIcT3vJSB59KYIDbUVr/MkR5Yv
	OJ2jCTCvmOQ/9pg5jQMcjfm5kiVBMxMa
X-Google-Smtp-Source: AGHT+IHTFbA+Z+7qQ9NP2ATiactA8TghGwPXzMrtijnW9nT3cEmUm7J5fRWtR3iCcEvbT4ZBxFSz2g==
X-Received: by 2002:a17:902:ce85:b0:1d0:a45c:202 with SMTP id f5-20020a170902ce8500b001d0a45c0202mr286301plg.24.1703452417758;
        Sun, 24 Dec 2023 13:13:37 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001d078e31cd1sm6859208plg.259.2023.12.24.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:13:36 -0800 (PST)
Date: Sun, 24 Dec 2023 13:13:35 -0800 (PST)
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
In-Reply-To: <CAF8kJuM59_12VNZ9d4oXZiLbAQC4LGLXODHqZw+7jiCJYva6YQ@mail.gmail.com>
Message-ID: <d171f8a4-47ed-0e29-877d-6824d593d7ed@google.com>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org> <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org> <ZYYY1VBKdLHH-Kl3@google.com> <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com> <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
 <0a052cb1-a5c5-4bee-5bd5-fd5569765012@google.com> <CAF8kJuM59_12VNZ9d4oXZiLbAQC4LGLXODHqZw+7jiCJYva6YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003067076-2146640772-1703452416=:2161414"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003067076-2146640772-1703452416=:2161414
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 24 Dec 2023, Chris Li wrote:

> On Sat, Dec 23, 2023 at 7:01 PM David Rientjes <rientjes@google.com> wrote:
> >
> > On Sat, 23 Dec 2023, Chris Li wrote:
> >
> > > > How do you quantify the impact of the delayed swap_entry_free()?
> > > >
> > > > Since the free and memcg uncharge are now delayed, is there not the
> > > > possibility that we stay under memory pressure for longer?  (Assuming at
> > > > least some users are swapping because of memory pressure.)
> > > >
> > > > I would assume that since the free and uncharge itself is delayed that in
> > > > the pathological case we'd actually be swapping *more* until the async
> > > > worker can run.
> > >
> > > Thanks for raising this interesting question.
> > >
> > > First of all, the swap_entry_free() does not impact "memory.current".
> > > It reduces "memory.swap.current". Technically it is the swap pressure
> > > not memory pressure that suffers the extra delay.
> > >
> > > Secondly, we are talking about delaying up to 64 swap entries for a
> > > few microseconds.
> >
> > What guarantees that the async freeing happens within a few microseconds?
> 
> Linux kernel typically doesn't provide RT scheduling guarantees. You
> can change microseconds to milliseconds, my following reasoning still
> holds.
> 

What guarantees that the async freeing happens even within 10s?  Your 
responses are implying that there is some deadline by which this freeing 
absolutely must happen (us or ms), but I don't know of any strong 
guarantees.

If there are no absolute guarantees about when the freeing may now occur, 
I'm asking how the impact of the delayed swap_entry_free() can be 
quantified.

The benefit to the current implementation is that there *are* strong 
guarantees about when the freeing will occur and cannot grow exponentially 
before the async worker can do the freeing.
--2003067076-2146640772-1703452416=:2161414--

