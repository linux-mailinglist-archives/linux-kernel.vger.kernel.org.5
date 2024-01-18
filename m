Return-Path: <linux-kernel+bounces-29762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B26831316
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E294E1F226F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFAB645;
	Thu, 18 Jan 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dndPNy9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20C947E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562913; cv=none; b=Cj+g3QlzNfBmZsTHjrtoEVVKo4qYeNlOm8UAGRSXwh0cJbdLs0J5hNGiysFIO7EJSbJG33JB/ELE+uTA5GsFuY6ED88Ln3sIZRIhBMLYzYJy3kQ0kbteI9EDasHLclVHnnZAWNgqtPvnF9WFI16ovXiBljU7AALVkWg5X7SRZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562913; c=relaxed/simple;
	bh=Q4W73qGRou9IGq3hjJrftt/KTtPOdqFsTzXiRX/xyJE=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=ANDvFCqGjmwrwApwJZKHs13wLn7l4r9f41ymdauD9dFbpFeqy5yPu46heHZ+H87eKFmmAp6araUH8agqbjCXJq2TaUBhzcBEJiKu3YWC2udOIAV4CzgS7RsBl5RVj6mWOIsxGjT36ebheooDXPCvc49XnpqE9desVtPgiACa2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dndPNy9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C2EC43394
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705562912;
	bh=Q4W73qGRou9IGq3hjJrftt/KTtPOdqFsTzXiRX/xyJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dndPNy9VJENMWrIKU2nCk5fC4X0VE+7job5eWhxWkfIfUsyr+MHu6dQhDn76BKxxL
	 8YFfaVZ+lz4/bArAngZSIsd6w825idl4a4MWVKTdfd87WRyouNp84snfvEWUNXlrK2
	 6qEK8a9yXOml2xrIV/+npFbUZiAV+9VZxUv71SXwcw4jW3QB19aNXqOEZDeKRf6h75
	 Mwp5KFYZDZATcQfEDBNX3aovFDFYTf9bNy/CKmzYgt65fPxpylvN+fxttxgNwVMwNf
	 HfdPykCLMr2hcCQm9okjrLNM954PWz77MmOcPF8bbc44g5Mwojkg/aCgf7vpbGt7nl
	 lR/nCoHj6hCJw==
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso8898146b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:28:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yw2DM2VAqfNygY73akxc6fJl5p47aOy1hGmIfbqCLE0TKW52O8m
	oa0MMr6iOQOWjUXPTpswxETgY3dbnuTsBmDoSxxMu0sVPEbelKdzIDk9KaJZbGSTOkgnCA57U52
	pda0DET8/SqL17cvX+s6bgCd1K7HbgHu+h9lm
X-Google-Smtp-Source: AGHT+IEFemehfe6/DrMAtEG1vHhXUhrk5g2FOHwJRKu30v09T4UMg5r5CLMLptOB1U7v9XuMrZyw0+GtWyo3BdDb7Lc=
X-Received: by 2002:a05:6a20:d80c:b0:19a:4073:e178 with SMTP id
 iv12-20020a056a20d80c00b0019a4073e178mr526568pzb.25.1705562911908; Wed, 17
 Jan 2024 23:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com> <CAJD7tkaTZz9-rtYab+pvf31dprjMLstnHeXk6HZ_0C-8Np=06A@mail.gmail.com>
In-Reply-To: <CAJD7tkaTZz9-rtYab+pvf31dprjMLstnHeXk6HZ_0C-8Np=06A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 23:28:17 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN0WQ_n0VWub+90rj68UYGoMNG32h8OxbvLgpDrKrB1Hg@mail.gmail.com>
Message-ID: <CAF8kJuN0WQ_n0VWub+90rj68UYGoMNG32h8OxbvLgpDrKrB1Hg@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> The name changes from Chris to Christopher are confusing :D
>
> >
> > I think it makes the review easier. The code adding and removing does
> > not have much overlap. Combining it to a single patch does not save
> > patch size. Having the assert check would be useful for some bisecting
> > to narrow down which step causing the problem. I am fine with squash
> > it to one patch as well.
>
> I think having two patches is unnecessarily noisy, and we add some
> debug code in this patch that we remove in the next patch anyway.
> Let's see what others think, but personally I prefer a single patch.
>
> > >
> > > >
> > > > I expect to merge the zswap rb tree spin lock with the xarray
> > > > lock in the follow up changes.
> > >
> > > Shouldn't this simply be changing uses of tree->lock to use
> > > xa_{lock/unlock}? We also need to make sure we don't try to lock the
> > > tree when operating on the xarray if the caller is already holding th=
e
> > > lock, but this seems to be straightforward enough to be done as part
> > > of this patch or this series at least.
> > >
> > > Am I missing something?
> >
> > Currently the zswap entry refcount is protected by the zswap tree spin
> > lock as well. Can't remove the tree spin lock without changing the
> > refcount code. I think the zswap search entry should just return the
> > entry with refcount atomic increase, inside the RCU read() or xarray
> > lock. The previous zswap code does the find_and_get entry() which is
> > closer to what I want.
>
> I think this can be done in an RCU read section surrounding xa_load()

xa_load() already has RCU read lock inside. If you do that you might
just as well use some XAS API to work with the lock directly.

> and the refcount increment. Didn't look closely to check how much
> complexity this adds to manage refcounts with RCU, but I think there
> should be a lot of examples all around the kernel.

The complexity is not adding the refcount inside xa_load(). It is on
the zswap code that calls zswap_search() and zswap_{insert,erase}().
As far as I can tell, those codes need some tricky changes to go along
with the refcount change.

>
> IIUC, there are no performance benefits from this conversion until we
> remove the tree spinlock, right?

The original intent is helping the long tail case. RB tree has worse
long tails than xarray. I expect it will help the page fault long tail
even without removing the tree spinlock.

Chris

