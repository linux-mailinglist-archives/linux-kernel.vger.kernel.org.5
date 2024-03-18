Return-Path: <linux-kernel+bounces-106164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D587EA12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8726A1C21232
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4D487B4;
	Mon, 18 Mar 2024 13:28:13 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731247F62;
	Mon, 18 Mar 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768493; cv=none; b=tSbYfhYOIMpQYK75F9nbbXJzyKX/qU3HOlrrfsh+oY2h+z/aguUf71sEOMIEKPIRyR9j7JzcZpL8RE4X7s4TfWbONc0HxKOS1ZzPweL7O819dLCDMzylndiOd5J2BnzQ0yYoK7XdbMih4GOtCQeTBIT9VAkf9RuB0IpnVjd4Osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768493; c=relaxed/simple;
	bh=yu2Rxg3w0GQ6trFhV8+9efuCcTQUHgkprl4EnPs9NZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb/+XPpHkFMi2mAKki5+bgfi4N05wIpZHY9FXcGthY5fN3oP5nS/o67akavYkniBf7y50k15TGo4OBCLNRJOxdDG3ZqlSCkQBGUe+QZi8MolqeETyHnvwGzM7QT4REZzqVzVknNzPv+kwptjGaYw6PGhmLE4Qb7NqHGudUtoW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ab-65f841605bb6
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
Date: Mon, 18 Mar 2024 22:27:45 +0900
Message-ID: <20240318132749.2115-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240317153144.11931-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC9ZZnoW6i449Ug2U72Swm9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovO70tZLC7vmsNmcW/Nf1aLI+vPslhsPnuG2WLxcjWLfR0P
	mCwOf33DZDH50gI2ixdTzjBanJw1mcVi9tF77A5CHktPv2Hz2NAEJHbOusvu0bLvFrvHgk2l
	Hi1H3rJ6LN7zkslj06pONo9Nnyaxe5yY8ZvFY+dDS48Xm2cyevQ2v2Pz+LxJLoAvissmJTUn
	syy1SN8ugStj6s9jjAU/LCt2XH3D2sA4WaeLkZNDQsBEYt2xuaxdjBxg9tTFCiBhNgE1iSsv
	JzGB2CICihLnHl8EKuHiYBb4yyzxes45NpCEsECwxNyz/xlBbBYBVYkjPz6BzeEVMJPYs80P
	YrymxOPtP9lBbE4BY4m7nV+YQWwhAR6JVxv2g7XyCghKnJz5hAXEZhaQl2jeOpsZZJeEwCF2
	ieVr9rFCDJKUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEzx0QvozIvs0IvOT93EyMw1pbV
	/onewfjpQvAhRgEORiUe3gM6P1KFWBPLiitzDzFKcDArifC6in1NFeJNSaysSi3Kjy8qzUkt
	PsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDINU+9e2nh89wPjfvcJ1QknbkquX5f
	rsWmRw6/9CY4/PrI7RfZtySGO1EwUvlx/O0Hr6s/S5859Nx5V9pynyvLXA4znXMvX5bjkbHl
	jMexK2Zlf/fw3goVOF2hWnhF7J9opcnqGnGzhs851d968q5H89eInpJlrP3WcfV4Y+nKH+pL
	H2f6VU1WYinOSDTUYi4qTgQAAZZqN7ECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXCNUNLTzfB8Ueqwe9mU4uJPQYWc9avYbPY
	dSPE4v/eY4wWT/7/ZrU4cbORzaLzyXdGi8NzT7JadH5fymJxedccNot7a/6zWhxZf5bFYvPZ
	M8wWi5erWRy69pzVYl/HAyaLw1/fMFlMvrSAzeLFlDOMFidnTWaxmH30HruDqMfS02/YPDY0
	AYmds+6ye7Tsu8XusWBTqUfLkbesHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NLjxeaZjB69
	ze/YPL7d9vBY/OIDk8fnTXIBAlFcNimpOZllqUX6dglcGVN/HmMs+GFZsePqG9YGxsk6XYwc
	HBICJhJTFyt0MXJysAmoSVx5OYkJxBYRUJQ49/giaxcjFwezwF9middzzrGBJIQFgiXmnv3P
	CGKzCKhKHPnxiRVkDq+AmcSebX4gYQkBTYnH23+yg9icAsYSdzu/MIPYQgI8Eq827Adr5RUQ
	lDg58wkLiM0sIC/RvHU28wRGnllIUrOQpBYwMq1iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQI
	jKpltX8m7mD8ctn9EKMAB6MSD+8BnR+pQqyJZcWVuYcYJTiYlUR4XcW+pgrxpiRWVqUW5ccX
	leakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwzilq2bRxPa8t0/d89TOMrE8f
	FC4RKdHXWlM0geHPG+FrHqpViy2PJkoXC5xTXlDwSGu93BoDvVmuziKLvWcv7RH99a/MJXeD
	ZeDZhjun47733Dm89sXrbYVxauu/55k9Pu+YU8bCHdDvJZg1mSHyLdfyY1yHz2nt4Dw406iw
	752c5FaWK83nlViKMxINtZiLihMBLyYWiqYCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On Sun, 17 Mar 2024 08:31:44 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hi Honggyu,
> 
> On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > Thanks for the confirmation.  I have a few comments on young filter so
> > please read the inline comments again.
> > 
> > On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > Hi Honggyu,
> > > 
> > > > > -----Original Message-----
> > > > > From: SeongJae Park <sj@kernel.org>
> > > > > Sent: Tuesday, March 12, 2024 3:33 AM
> > > > > To: Honggyu Kim <honggyu.kim@sk.com>
> > > > > Cc: SeongJae Park <sj@kernel.org>; kernel_team <kernel_team@skhynix.com>
> > > > > Subject: RE: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
> > > > >
> > > > > Hi Honggyu,
> > > > >
> > > > > On Mon, 11 Mar 2024 12:51:12 +0000 "honggyu.kim@sk.com" <honggyu.kim@sk.com> wrote:
> > > > >
> > > > > > Hi SeongJae,
> > > > > >
> > > > > > I've tested it again and found that "young" filter has to be set
> > > > > > differently as follows.
> > > > > > - demote action: set "young" filter with "matching" true
> > > > > > - promote action: set "young" filter with "matching" false

Thinking it again, I feel like "matching" true or false looks quite
vague to me as a general user.

Instead, I would like to have more meaningful names for "matching" as
follows.

- matching "true" can be either (filter) "out" or "skip".
- matching "false" can be either (filter) "in" or "apply".

Internally, the type of "matching" can be boolean, but it'd be better
for general users have another ways to set it such as "out"/"in" or
"skip"/"apply" via sysfs interface.  I prefer "skip" and "apply" looks
more intuitive, but I don't have strong objection on "out" and "in" as
well.

I also feel the filter name "young" is more for developers not for
general users.  I think this can be changed to "accessed" filter
instead.

The demote and promote filters can be set as follows using these.

- demote action: set "accessed" filter with "matching" to "skip"
- promote action: set "accessed" filter with "matching" to "apply"

I also think that you can feel this is more complicated so I would like
to hear how you think about this.

> > > > >
> > > > > DAMOS filter is basically for filtering "out" memory regions that matches to
> > > > > the condition.

Right.  In other tools, I see filters are more used as filtering "in"
rather than filtering "out".  I feel this makes me more confused.

> > > > > Hence in your setup, young pages are not filtered out from
> > > > > demote action target.
> > > > 
> > > > I thought young filter true means "young pages ARE filtered out" for demotion.
> > > 
> > > You're correct.
> > 
> > Ack.
> > 
> > > > 
> > > > > That is, you're demoting pages that "not" young.
> > > > 
> > > > Your explanation here looks opposite to the previous statement.
> > > 
> > > Again, you're correct.  My intention was "non-young pages are not ..." but
> > > maybe I was out of my mind and mistakenly removed "non-" part.  Sorry for the
> > > confusion.
> > 
> > No problem.  I also think it's quite confusing.
> > 
> > > > 
> > > > > And vice versa, so you're applying promote to non-non-young (young) pages.
> > > > 
> > > > Yes, I understand "promote non-non-young pages" means "promote young pages".
> > > > This might be understood as "young pages are NOT filtered out" for promotion
> > > > but it doesn't mean that "old pages are filtered out" instead.
> > > > And we just rely hot detection only on DAMOS logics such as access frequency
> > > > and age. Am I correct?
> > > 
> > > You're correct.
> > 
> > Ack.  But if it doesn't mean that "old pages are filtered out" instead,
> 
> It does mean that.  Here, filtering is exclusive.  Hence, "filter-in a type of
> pages" means "filter-out pages of other types".  At least that's the intention.
> To quote the documentation
> (https://docs.kernel.org/mm/damon/design.html#filters),
> 
>     Each filter specifies the type of target memory, and whether it should
>     exclude the memory of the type (filter-out), or all except the memory of
>     the type (filter-in).

Thanks for the correction.

> > then do we really need this filter for promotion?  If not, maybe should
> > we create another "old" filter for promotion?  As of now, the promotion
> > is mostly done inaccurately, but the accurate migration is done at
> > demotion level.
> 
> Is this based on your theory?  Or, a real behavior that you're seeing from your
> setup?  If this is a real behavior, I think that should be a bug that need to
> be fixed.

I have observed this in the hot_cold example, but I also found that the
promotion is done very quickly because the age for promote action is set
to 0 to max in my json setup.  It makes most pages of the region are
young because there is not enough time for those pages being old.  That
means I was wrong.

> > To avoid this issue, I feel we should promotion only "young" pages after
> > filtering "old" pages out.
> > 
> > > > 
> > > > > I understand this is somewhat complex, but what we have for now.
> > > > 
> > > > Thanks for the explanation. I guess you mean my filter setup is correct.
> > > > Is it correct?
> > > 
> > > Again, you're correct.  Your filter setup is what I expected to :)
> > 
> > Thanks.  I see that it works fine, but I would like to have more
> > discussion about "young" filter.  What I think about filter is that if I
> > apply "young" filter "true" for demotion, then the action applies only
> > for "young" pages, but the current implementation works opposite.
> > 
> > I understand the function name of internal implementation is
> > "damos_pa_filter_out" so the basic action is filtering out, but the
> > cgroup filter works in the opposite way for now.
> 
> Does memcg filter works in the opposite way?  I don't think so because
> __damos_pa_filter_out() sets 'matches' as 'true' only if the the given folio is
> contained in the given memcg.  'young' filter also simply sets 'matches' as
> 'true' only if the given folio is young.
> 
> If it works in the opposite way, it's a bug that need to be fixed.  Please let
> me know if I'm missing something.

No, it was also my misunderstanding.  I used to set the matching false
using my script.

Thanks,
Honggyu

> > 
> > I would like to hear how you think about this.
> > 
> > > > 
> > > > > > Then, I see that "hot_cold" migrates hot/cold memory correctly.
> > > > >
> > > > > Thank you so much for sharing this great news!  My tests also show no bad
> > > > > signal so far.
> > > > >
> > > > > >
> > > > > > Could you please upload the "damon_folio_mkold" patch to LKML?
> > > > > > Then I will rebase our changes based on it and run the redis test again.
> > > > >
> > > > > I will do that soon.
> > > > 
> > > > Thanks a lot for sharing the RFC v2 for DAMOS young filter.
> > > > https://lore.kernel.org/damon/20240311204545.47097-1-sj@kernel.org/
> > > > 
> > > > I will rebase our work based on it and share the result.
> > > 
> > > Cool, looking forward to it!  Hopefully we will make it be merged into the
> > > mainline by v6.10!
> > 
> > I hope so.  Thanks for your help!
> > 
> > Honggyu
> 
> 
> Thanks,
> SJ

