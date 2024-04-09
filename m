Return-Path: <linux-kernel+bounces-136600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45E89D605
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325DE2849F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B98004F;
	Tue,  9 Apr 2024 09:54:47 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F057F46A;
	Tue,  9 Apr 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656486; cv=none; b=dXZ4T/hEFSLY83dTD9WXS/060Gzzdb6pysGCCUk5ip0WH9GWzYKMc9z6Mmwej311tIQOuxTuJKLYAVND9yMXyFfZzGxUZsK4ePBCzVOfM9W6F/FTiRARM1nTAMq3ku4HvWVFLUcBAzQQc/d6In0kx9le3XwwhuP0M4R7I3GmzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656486; c=relaxed/simple;
	bh=ZhL2S8X8G4T007S4qYVJLd7OiEopZB8XYTdXdhK/h44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBpNcNMttIxEJ0aOHgjFICaIcqK6f/WL+FrghSVFrpYjA8Z6i7t+tl8x2XMTzYBGv0dfR6VbEPr1O8vqIn5uGSunF5WiQxrsi4ihVxkpqSeX4In/PCnXkXZF/TQJS1DH73uwBhqShaj82J7On6n4TLVKy9t/A5e5NTAE5ypssaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ad-6615105f05cb
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
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [RFC PATCH v3 5/7] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Tue,  9 Apr 2024 18:54:14 +0900
Message-ID: <20240409095418.3051-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240408175228.91414-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsXC9ZZnkW6CgGiawduDzBYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLDq/L2WxuLxrDpvFvTX/WS2OrD/LYrH57Blmi8XL
	1Sz2dTxgsjj89Q2TxeRLC9gsXkw5w2hxctZkFovZR++xOwh7LD39hs1jQxOQ2DnrLrtHy75b
	7B4LNpV6tBx5y+qxeM9LJo9NqzrZPDZ9msTucWLGbxaPnQ8tPV5snsno0dv8js3j8ya5AL4o
	LpuU1JzMstQifbsEroz2iY8ZC07pVux4/J+9gfGeUhcjB4eEgInEpW6hLkZOMHPOo9csIDab
	gJrElZeTmEBsEQFFiXOPL7J2MXJxMAvsYZHoOvWGHSQhLJAg0XbjIyvIHBYBVYn7CxxBwrwC
	ZhJ/1u9kg5ipKfF4+0+wck4BY4lHUxcyg9hCAjwSrzbsZ4SoF5Q4OfMJ2F5mAXmJ5q2zmSF6
	T7FLrLvoBGFLShxccYNlAiP/LCQts5C0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGHPL
	av9E72D8dCH4EKMAB6MSD6/FVeE0IdbEsuLK3EOMEhzMSiK8waaCaUK8KYmVValF+fFFpTmp
	xYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoY193UT1c90T/j16fYV0kvPO681gpk
	4pm8U1SLUTlrh6JHlnvszqylgQwJTDf2ZJU/TG/J/ye52It1r0nhi7ty2XbH/C9LTPY5Erew
	jFlgU/XRdLfW2b139v7PflXV9t3lasnBV0nCRyceF7/8+MuEpfqJTfce8Ec81Zm92ukBf2zw
	oicvxcsmKrEUZyQaajEXFScCAM4Xchi1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLTzdeQDTN4MkyPYuJPQYWc9avYbPY
	dSPE4v6D1+wW//ceY7R48v83q8WJm41sFp+fvWa26HzyndHi8NyTrBad35eyWFzeNYfN4t6a
	/6wWR9afZbHYfPYMs8Xi5WoWh649Z7XY1/GAyeLw1zdMFpMvLWCzeDHlDKPFyVmTWSxmH73H
	7iDusfT0GzaPDU1AYuesu+weLftusXss2FTq0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8
	dj609HixeSajR2/zOzaPb7c9PBa/+MDk8XmTXIBAFJdNSmpOZllqkb5dAldG+8THjAWndCt2
	PP7P3sB4T6mLkZNDQsBEYs6j1ywgNpuAmsSVl5OYQGwRAUWJc48vsnYxcnEwC+xhkeg69YYd
	JCEskCDRduMjUIKDg0VAVeL+AkeQMK+AmcSf9TvZIGZqSjze/hOsnFPAWOLR1IXMILaQAI/E
	qw37GSHqBSVOznwCtpdZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mh
	l5yfu4kRGGvLav9M3MH45bL7IUYBDkYlHl6HO8JpQqyJZcWVuYcYJTiYlUR4g00F04R4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoY7b/XJ9fJXJ6y+eL5
	sGA2n38FZwT7xU5O+vbgTtuh3tqd03SOXNE/d7/t8zRBiZ62A/7tM8yOXZG6aDfl8IS2t/kq
	JQkL9766uPhTmMcES7G1LFNbp4vcc3vnx9n56lh5YW2Go7Dh7aeu5lZ1Z/vupD/wU1eRY039
	c9ppm2bgjRX7Ly+z4Sl/psRSnJFoqMVcVJwIAAtzjpaxAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

On Mon,  8 Apr 2024 10:52:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Mon,  8 Apr 2024 21:06:44 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > On Fri,  5 Apr 2024 12:24:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> [...]
> > > > Here is one of the example usage of this 'migrate_cold' action.
> > > > 
> > > >   $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
> > > >   $ cat contexts/<N>/schemes/<N>/action
> > > >   migrate_cold
> > > >   $ echo 2 > contexts/<N>/schemes/<N>/target_nid
> > > >   $ echo commit > state
> > > >   $ numactl -p 0 ./hot_cold 500M 600M &
> > > >   $ numastat -c -p hot_cold
> > > > 
> > > >   Per-node process memory usage (in MBs)
> > > >   PID             Node 0 Node 1 Node 2 Total
> > > >   --------------  ------ ------ ------ -----
> > > >   701 (hot_cold)     501      0    601  1101
> > > > 
> > > > Since there are some common routines with pageout, many functions have
> > > > similar logics between pageout and migrate cold.
> > > > 
> > > > damon_pa_migrate_folio_list() is a minimized version of
> > > > shrink_folio_list(), but it's minified only for demotion.
> > > 
> > > MIGRATE_COLD is not only for demotion, right?  I think the last two words are
> > > better to be removed for reducing unnecessary confuses.
> > 
> > You mean the last two sentences?  I will remove them if you feel it's
> > confusing.
> 
> Yes.  My real intended suggestion was 's/only for demotion/only for
> migration/', but entirely removing the sentences is also ok for me.

Ack.

> > 
> > > > 
> > > > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > > > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> > > > ---
> > > >  include/linux/damon.h    |   2 +
> > > >  mm/damon/paddr.c         | 146 ++++++++++++++++++++++++++++++++++++++-
> > > >  mm/damon/sysfs-schemes.c |   4 ++
> > > >  3 files changed, 151 insertions(+), 1 deletion(-)
> [...]
> > > > --- a/mm/damon/paddr.c
> > > > +++ b/mm/damon/paddr.c
> [...]
> > > > +{
> > > > +	unsigned int nr_succeeded;
> > > > +	nodemask_t allowed_mask = NODE_MASK_NONE;
> > > > +
> > > 
> > > I personally prefer not having empty lines in the middle of variable
> > > declarations/definitions.  Could we remove this empty line?
> > 
> > I can remove it, but I would like to have more discussion about this
> > issue.  The current implementation allows only a single migration
> > target with "target_nid", but users might want to provide fall back
> > migration target nids.
> > 
> > For example, if more than two CXL nodes exist in the system, users might
> > want to migrate cold pages to any CXL nodes.  In such cases, we might
> > have to make "target_nid" accept comma separated node IDs.  nodemask can
> > be better but we should provide a way to change the scanning order.
> > 
> > I would like to hear how you think about this.
> 
> Good point.  I think we could later extend the sysfs file to receive the
> comma-separated numbers, or even mask.  For simplicity, adding sysfs files
> dedicated for the different format of inputs could also be an option (e.g.,
> target_nids_list, target_nids_mask).  But starting from this single node as is
> now looks ok to me.

If you think we can start from a single node, then I will keep it as is.
But are you okay if I change the same 'target_nid' to accept
comma-separated numbers later?  Or do you want to introduce another knob
such as 'target_nids_list'?  What about rename 'target_nid' to
'target_nids' at the first place?

> [...]
> > > > +	/* 'folio_list' is always empty here */
> > > > +
> > > > +	/* Migrate folios selected for migration */
> > > > +	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, target_nid);
> > > > +	/* Folios that could not be migrated are still in @migrate_folios */
> > > > +	if (!list_empty(&migrate_folios)) {
> > > > +		/* Folios which weren't migrated go back on @folio_list */
> > > > +		list_splice_init(&migrate_folios, folio_list);
> > > > +	}
> > > 
> > > Let's not use braces for single statement
> > > (https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces).
> > 
> > Hmm.. I know the convention but left it as is because of the comment.
> > If I remove the braces, it would have a weird alignment for the two
> > lines for comment and statement lines.
> 
> I don't really hate such alignment.  But if you don't like it, how about moving
> the comment out of the if statement?  Having one comment for one-line if
> statement looks not bad to me.

Ack. I will manage this in the next revision.

> > 
> > > > +
> > > > +	try_to_unmap_flush();
> > > > +
> > > > +	list_splice(&ret_folios, folio_list);
> > > 
> > > Can't we move remaining folios in migrate_folios to ret_folios at once?
> > 
> > I will see if it's possible.
> 
> Thank you.  Not a strict request, though.
> 
> [...]
> > > > +	nid = folio_nid(lru_to_folio(folio_list));
> > > > +	do {
> > > > +		struct folio *folio = lru_to_folio(folio_list);
> > > > +
> > > > +		if (nid == folio_nid(folio)) {
> > > > +			folio_clear_active(folio);
> > > 
> > > I think this was necessary for demotion, but now this should be removed since
> > > this function is no more for demotion but for migrating random pages, right?
> > 
> > Yeah,  it can be removed because we do migration instead of demotion,
> > but I need to make sure if it doesn't change the performance evaluation
> > results.
> 
> Yes, please ensure the test results are valid :)

Sure. Thanks for your review in details!

Please note that I will be out of office this week so won't be able to
answer quickly.

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]
> 

