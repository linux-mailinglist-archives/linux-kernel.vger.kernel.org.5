Return-Path: <linux-kernel+bounces-29760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F183130D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F71F264FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61556B653;
	Thu, 18 Jan 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtYmEIQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB7B641
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562393; cv=none; b=V5jmHkgVjK9+iddSfzsA2+gCg5dtkKvFun3mMm9RTJ9VNODU6wOekuk6oSVRMQBOKSp5LDdntebNP5hPf/TVnuxhI30+DKk2c2jhE+eBGUKA3I8f8RqSeNql/oN0omXiNqGuKa7VbyQX+D3t/fri/xZPpGKUpRCrmoqJ/z75T8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562393; c=relaxed/simple;
	bh=9iYUuLIbf3fi84BSVUmPSnRf0FjY/z7SyKwvtqefUgU=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=kKf2TShlPXaGAt92X7TrN9V1oFaxOYKjSRB3mPVxQLNU8zot59uAUQ1XjyQ2HxpbuP+hMtTIVpldszLVOz1CEr5saCZmvEj2MfC/gl4RvVPwIZP7tARCLH8IhBdvTX6fTq1BLR3kTd8TDQAL4N4cwsoF5ofBbrQoTqDMOOI6z/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtYmEIQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABC4C4166C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705562393;
	bh=9iYUuLIbf3fi84BSVUmPSnRf0FjY/z7SyKwvtqefUgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BtYmEIQCV5/7KEtxjqxNxCsp33tkeS2GKsZXmbvnL1jo0hA4lP2hUkTayONSdmuS4
	 OrewBVuS1r++WqIorcCokhOR9rGN8hcD9SYvUGa8nifI120yVG1/phOx9UqesLobFK
	 vKPLcE9BU23w8xycxLaOo3WvwWXi95UtoK1F7sYxMtDnilxPkjfVZ19Qh/JlBtiKqe
	 Q/0RaHgtp2BYl13TAS06ALS8WILg/RhHzTjj4GeqjorYrlKM+jmZI5wkT8MaJ2an5H
	 4XEE+u6s1VswvIz3rOKi8IXpkhXZ+uvdP5IRX5sHuhJsF43EwJQBDOL3JHtQlb5qhe
	 2XR2fa3M4ZqyQ==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290121b4922so504046a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:19:53 -0800 (PST)
X-Gm-Message-State: AOJu0YyDdpfQcOzCW3kwJSK5gihTcY3fKD4Ak/d02w+wiEQqjRa//svC
	qsiheZCZr09Z402TAyahzPBFWAc1H4SpmA8vKkZoYtk7vhOSv05JQKKVVySfY6dLIA5rUD0bM+A
	g2pR8Fp6gIT8zYc/8S2GY8SIQKniRf28GtZRN
X-Google-Smtp-Source: AGHT+IE9BdF2GQ+4HnXOISmbgKpJz3yobQO0y3C8t7OMIuUCG72y5Mw0a02r8pFUt7pLY2bzT3DRf/2Kgm1qdAr0OBY=
X-Received: by 2002:a17:90a:8048:b0:28f:ef30:804a with SMTP id
 e8-20020a17090a804800b0028fef30804amr337113pjw.35.1705562392267; Wed, 17 Jan
 2024 23:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CAJD7tkb7GmMARE9ueyOCZz9wBbANhofUOHnen+b28sxE9tDy1A@mail.gmail.com>
 <7f52ad78-e10b-438a-b380-49451bf6f64f@bytedance.com> <CAJD7tkaeBTforGTQ8ia_6-1fd5hf-zwkBcd_kW8Bk=zdO+Qnvw@mail.gmail.com>
In-Reply-To: <CAJD7tkaeBTforGTQ8ia_6-1fd5hf-zwkBcd_kW8Bk=zdO+Qnvw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 23:19:39 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNPPruLDOEqH-f-w1zw-TSuWkUZsQ43Qe_EtycapXgkbQ@mail.gmail.com>
Message-ID: <CAF8kJuNPPruLDOEqH-f-w1zw-TSuWkUZsQ43Qe_EtycapXgkbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jan 17, 2024 at 10:57=E2=80=AFPM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Hi Yosry and Chris,
> >
> > On 2024/1/18 14:39, Yosry Ahmed wrote:
> > > On Wed, Jan 17, 2024 at 10:01=E2=80=AFPM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> > >>
> > >> That's a long CC list for sure :)
> > >>
> > >> On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org>=
 wrote:
> > >>>
> > >>> The RB tree shows some contribution to the swap fault
> > >>> long tail latency due to two factors:
> > >>> 1) RB tree requires re-balance from time to time.
> > >>> 2) The zswap RB tree has a tree level spin lock protecting
> > >>> the tree access.
> > >>>
> > >>> The swap cache is using xarray. The break down the swap
> > >>> cache access does not have the similar long time as zswap
> > >>> RB tree.
> > >>
> > >> I think the comparison to the swap cache may not be valid as the swa=
p
> > >> cache has many trees per swapfile, while zswap has a single tree.
> > >>
> > >>>
> > >>> Moving the zswap entry to xarray enable read side
> > >>> take read RCU lock only.
> > >>
> > >> Nice.
> > >>
> > >>>
> > >>> The first patch adds the xarray alongside the RB tree.
> > >>> There is some debug check asserting the xarray agrees with
> > >>> the RB tree results.
> > >>>
> > >>> The second patch removes the zwap RB tree.
> > >>
> > >> The breakdown looks like something that would be a development step,
> > >> but for patch submission I think it makes more sense to have a singl=
e
> > >> patch replacing the rbtree with an xarray.
> > >>
> > >>>
> > >>> I expect to merge the zswap rb tree spin lock with the xarray
> > >>> lock in the follow up changes.
> > >>
> > >> Shouldn't this simply be changing uses of tree->lock to use
> > >> xa_{lock/unlock}? We also need to make sure we don't try to lock the
> > >> tree when operating on the xarray if the caller is already holding t=
he
> > >> lock, but this seems to be straightforward enough to be done as part
> > >> of this patch or this series at least.
> > >>
> > >> Am I missing something?
> > >
> > > Also, I assume we will only see performance improvements after the
> > > tree lock in its current form is removed so that we get loads
> > > protected only by RCU. Can we get some performance numbers to see how
> > > the latency improves with the xarray under contention (unless
> > > Chengming is already planning on testing this for his multi-tree
> > > patches).
> >
> > I just give it a try, the same test of kernel build in tmpfs with zswap
> > shrinker enabled, all based on the latest mm/mm-stable branch.
> >
> >                     mm-stable           zswap-split-tree    zswap-xarra=
y
> > real                1m10.442s           1m4.157s            1m9.962s
> > user                17m48.232s          17m41.477s          17m45.887s
> > sys                 8m13.517s           5m2.226s            7m59.305s
> >
> > Looks like the contention of concurrency is still there, I haven't
> > look into the code yet, will review it later.

Thanks for the quick test. Interesting to see the sys usage drop for
the xarray case even with the spin lock.
Not sure if the 13 second saving is statistically significant or not.

We might need to have both xarray and split trees for the zswap. It is
likely removing the spin lock wouldn't be able to make up the 35%
difference. That is just my guess. There is only one way to find out.

BTW, do you have a script I can run to replicate your results?

>
> I think that's expected with the current version because the tree
> spin_lock is still there and we are still doing lookups with a
> spinlock.

Right.

Chris

