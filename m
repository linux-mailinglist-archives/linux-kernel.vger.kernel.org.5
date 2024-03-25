Return-Path: <linux-kernel+bounces-116961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB288A586
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41221F35598
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2113B2B1;
	Mon, 25 Mar 2024 12:11:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38324184EF3;
	Mon, 25 Mar 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368083; cv=none; b=lc71AeqMdtAQBfr0i69YqOV9vV46c0nWYUtNg6ncic6LvhPi9MMSZqm0/SVSim/hJax2Q2YWcDxBxb1Zr4fuX50XfJlLUe78/eYW0Nf/gU8ZzurJqIVaogZCeW9PWpI44MSq+OiNgEL4uJjyUM2M9cdhVhYIihJQOT73aBXsLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368083; c=relaxed/simple;
	bh=xNG1ygbpXGYY1nx407tvVJZqYfru8GJYQcuUl1vrWco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGcMEBnyntzyNh9cqtKC9oZ56G0QJ7B5WALOSPo7ethtU4WK+/JZRKSNr7kUfCUD0zKOHT1+wEyu/Maoy84rzCsz60ui3UAt8bTfn/g+cgvfWNRe554fro7JEU9q+oEsKcN4QIhqeAmYq+aPWWDP7Yzm6a0FchKTwkwgKhTMkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-72-660167861140
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Mon, 25 Mar 2024 21:01:04 +0900
Message-ID: <20240325120108.2328-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240322163223.68414-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC9ZZnoW5bOmOawZwnKhYTewws5qxfw2ax
	60aIxf+9xxgtnvz/zWpx4mYjm0Xn96UsFpd3zWGzuLfmP6vFkfVnWSw2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj6Wn37B5bGgCEjtn3WX3aNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJXx/MwJloI7KhUr3nA0ML6Q6WLk5JAQMJG4t+EQI4z9dFoXO4jNJqAmceXlJCYQ
	W0RAUeLc44usXYxcHMwCf5klXs85xwaSEBYIlph79j9YM4uAqsT8u9fAbF4BM4lnvz6yQAzV
	lHi8/SfYUE4BY4kNsx+BDRUS4JF4tWE/VL2gxMmZT8DqmQXkJZq3zmYGWSYhsItdomfeMWaI
	QZISB1fcYJnAyD8LSc8sJD0LGJlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgRG27LaP9E7GD9d
	CD7EKMDBqMTDa5HAmCbEmlhWXJl7iFGCg1lJhLflC0OaEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkZFxeuTvJh2Zpe4qGqUCsiem78gLsH3WqxioqDS
	3itKiR+sF35yYmaYl+vx5cyxgrvPXKd0PKl95Km7O/1ez51Vhr+8JT7sOXDi8tR5m5K6DVeI
	7++8unPH8oN9CsmLZx1b/zj5zK0ow4i9zRts6m50hF74vmblrS7Xicve6eTfCys+am90Ofm2
	EktxRqKhFnNRcSIAQ1tOFbICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXCNUNLT7ctnTHNoPuMiMXEHgOLOevXsFns
	uhFi8X/vMUaLJ/9/s1qcuNnIZtH55DujxeG5J1ktOr8vZbG4vGsOm8W9Nf9ZLY6sP8tisfns
	GWaLxcvVLA5de85qsa/jAZPF4a9vmCwmX1rAZvFiyhlGi5OzJrNYzD56j91B1GPp6TdsHhua
	gMTOWXfZPVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e
	5ndsHt9ue3gsfvGByePzJrkAgSgum5TUnMyy1CJ9uwSujOdnTrAU3FGpWPGGo4HxhUwXIyeH
	hICJxNNpXewgNpuAmsSVl5OYQGwRAUWJc48vsnYxcnEwC/xllng95xwbSEJYIFhi7tn/jCA2
	i4CqxPy718BsXgEziWe/PrJADNWUeLz9J9hQTgFjiQ2zH4ENFRLgkXi1YT9UvaDEyZlPwOqZ
	BeQlmrfOZp7AyDMLSWoWktQCRqZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgXG1rPbPxB2M
	Xy67H2IU4GBU4uG1SGBME2JNLCuuzD3EKMHBrCTC2/KFIU2INyWxsiq1KD++qDQntfgQozQH
	i5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBcceZj8t03hbOPG5lN+XxY9blBzlSa8+IzS/8
	ez7Tfd63FdxyTopy7crhkc+lZ5089dJ0zVJpj0UMKT8eG3+NTvpw9N7Dz5uc2z51563Z2+Us
	xnhnY3tX+HfF8xcidVcFWSds1vM1qn09z1k9xMN9mdQZpkezF7e7XQtddTP48+dMV/1HP5xr
	3imxFGckGmoxFxUnAgC6+TBEpwIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On Fri, 22 Mar 2024 09:32:23 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Fri, 22 Mar 2024 18:02:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > On Tue, 27 Feb 2024 15:51:20 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > On Mon, 26 Feb 2024 23:05:46 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > > 
> > > > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > > > posted at [1].
> > > > 
> > > > It says there is no implementation of the demote/promote DAMOS action
> > > > are made.  This RFC is about its implementation for physical address
> > > > space.
> > > > 
> > > > 
> [...]
> > > Thank you for running the tests again with the new version of the patches and
> > > sharing the results!
> > 
> > It's a bit late answer, but the result was from the previous evaluation.
> > I ran it again with RFC v2, but didn't see much difference so just
> > pasted the same result here.
> 
> No problem, thank you for clarifying :)
> 
> [...]
> > > > Honggyu Kim (3):
> > > >   mm/damon: refactor DAMOS_PAGEOUT with migration_mode
> > > >   mm: make alloc_demote_folio externally invokable for migration
> > > >   mm/damon: introduce DAMOS_DEMOTE action for demotion
> > > > 
> > > > Hyeongtak Ji (4):
> > > >   mm/memory-tiers: add next_promotion_node to find promotion target
> > > >   mm/damon: introduce DAMOS_PROMOTE action for promotion
> > > >   mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
> > > >   mm/damon/sysfs-schemes: apply target_nid for promote and demote
> > > >     actions
> > > 
> > > Honggyu joined DAMON Beer/Coffee/Tea Chat[1] yesterday, and we discussed about
> > > this patchset in high level.  Sharing the summary here for open discussion.  As
> > > also discussed on the first version of this patchset[2], we want to make single
> > > action for general page migration with minimum changes, but would like to keep
> > > page level access re-check.  We also agreed the previously proposed DAMOS
> > > filter-based approach could make sense for the purpose.
> > 
> > Thanks very much for the summary.  I have been trying to merge promote
> > and demote actions into a single migrate action, but I found an issue
> > regarding damon_pa_scheme_score.  It currently calls damon_cold_score()
> > for demote action and damon_hot_score() for promote action, but what
> > should we call when we use a single migrate action?
> 
> Good point!  This is what I didn't think about when suggesting that.  Thank you
> for letting me know this gap!  I think there could be two approach, off the top
> of my head.
> 
> The first one would be extending the interface so that the user can select the
> score function.  This would let flexible usage, but I'm bit concerned if this
> could make things unnecessarily complex, and would really useful in many
> general use case.

I also think this looks complicated and may not be useful for general
users.

> The second approach would be letting DAMON infer the intention.  In this case,
> I think we could know the intention is the demotion if the scheme has a youg
> pages exclusion filter.  Then, we could use the cold_score().  And vice versa.
> To cover a case that there is no filter at all, I think we could have one
> assumption.  My humble intuition says the new action (migrate) may be used more
> for promotion use case.  So, in damon_pa_scheme_score(), if the action of the
> given scheme is the new one (say, MIGRATE), the function will further check if
> the scheme has a filter for excluding young pages.  If so, the function will
> use cold_score().  Otherwise, the function will use hot_score().

Thanks for suggesting many ideas but I'm afraid that I feel this doesn't
look good.  Thinking it again, I think we can think about keep using
DAMOS_PROMOTE and DAMOS_DEMOTE, but I can make them directly call
damon_folio_young() for access check instead of using young filter.

And we can internally handle the complicated combination such as demote
action sets "young" filter with "matching" true and promote action sets
"young" filter with "matching" false.  IMHO, this will make the usage
simpler.

I would like to hear how you think about this.

> So I'd more prefer the second approach.  I think it would be not too late to
> consider the first approach after waiting for it turns out more actions have
> such ambiguity and need more general interface for explicitly set the score
> function.

I will join the DAMON Beer/Coffee/Tea Chat tomorrow as scheduled so I
can talk more about this issue.

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]

