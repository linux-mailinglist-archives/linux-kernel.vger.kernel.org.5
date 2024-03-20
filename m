Return-Path: <linux-kernel+bounces-108525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD67880BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C1E1F24400
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B71EB52;
	Wed, 20 Mar 2024 07:09:24 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95F1EB20;
	Wed, 20 Mar 2024 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918563; cv=none; b=g03REQJ1/unRQOdEu8IGfS22ZNyZd9bkt/n8CMAYgV+/Ia1AGyahIBs//6tL6bxLpFOUO0d5b7mryc2fRMHBdTljm6RE/34RvZ32jWyZdTkH2oSK6+EvoeGJJhao5BwLUK1sjbBd+bzgnPDDBod1meqorCJVw1GLj1YI1hLt0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918563; c=relaxed/simple;
	bh=3JcxhHqF0FJTo1LntgxX+dfhU4qmTx4jVFmS8El1CNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWjvZsBzm2YfrQ/BEcUdFj5lUYQouUo0W4Cymk68WdC13jMc2xbH4jgcCi1+Op56+7JxW/xcireRoR3Lb1l3UvqDZrpOKDY9rchxtwocyv9HqD42tP7GTw94uwd7BajVfCIb7VO9M/oBuqxvrEz01bzUcRvF0HN5UO5Qp8P4Ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-32-65fa8b94d389
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
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Wed, 20 Mar 2024 16:07:48 +0900
Message-ID: <20240320070754.2165-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240318190721.99659-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsXC9ZZnoe7U7l+pBtdOcVlM7DGwmLN+DZvF
	rhshFvcfvGa3+L/3GKPFk/+/WS1O3Gxks+j8vpTF4vKuOWwW99b8Z7U4sv4si8Xms2eYLRYv
	V7PY1/GAyeLw1zdMFpMvLWCzeDHlDKPFyVmTWSxmH73H7iDssfT0GzaPDU1AYuesu+weLftu
	sXss2FTq0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8dj609HixeSajR2/zOzaPz5vkAvii
	uGxSUnMyy1KL9O0SuDL2PMkpeJRQcXRJRQNjj1cXIyeHhICJxNHD+xlh7PMnFrOD2GwCahJX
	Xk5iArFFBBQlzj2+yNrFyMXBLDCDReLwwi6wBmGBYIm5Z/+D2SwCqhLnG3YDFXFw8AqYSdzd
	LQYxU1Pi8fafYDM5BYwlfm09BGYLCfBIvNoAsZdXQFDi5MwnLCA2s4C8RPPW2cwguyQE9rFL
	LD3fygQxSFLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMCYW1b7
	J3oH46cLwYcYBTgYlXh4DQp+pgqxJpYVV+YeYpTgYFYS4WXnBgrxpiRWVqUW5ccXleakFh9i
	lOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgjJjwUOdywst/blacv7/WX77XMy+YMSKm
	2lBC5uedY7f9n3Efeyr7s9Oev/7e8ttuNmUdyzYUNv/2CY/9sifzyWspjx/MDMfO/FK75dp3
	4vm5vbzzkzp5dyyQ2jw5/3uIn/d9NenFXDcMdj24Ok0kTfD5UwafdVuzeZSnXH7FePvGF87P
	x3cU2CuxFGckGmoxFxUnAgCBe6AwtQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXCNUNLT3dK969Ug45uS4uJPQYWc9avYbPY
	dSPE4v6D1+wW//ceY7R48v83q8WJm41sFp1PvjNaHJ57ktWi8/tSFovLu+awWdxb85/V4sj6
	sywWm8+eYbZYvFzN4tC156wW+zoeMFkc/vqGyWLypQVsFi+mnGG0ODlrMovF7KP32B3EPJae
	fsPmsaEJSOycdZfdo2XfLXaPBZtKPVqOvGX1WLznJZPHplWdbB6bPk1i9zgx4zeLx86Hlh4v
	Ns9k9Ohtfsfm8e22h8fiFx+YPD5vkgsQiOKySUnNySxLLdK3S+DK2PMkp+BRQsXRJRUNjD1e
	XYycHBICJhLnTyxmB7HZBNQkrrycxARiiwgoSpx7fJG1i5GLg1lgBovE4YVdjCAJYYFgibln
	/4PZLAKqEucbdgMVcXDwCphJ3N0tBjFTU+Lx9p9gMzkFjCV+bT0EZgsJ8Ei82rAfrJVXQFDi
	5MwnLCA2s4C8RPPW2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzC6
	ltX+mbiD8ctl90OMAhyMSjy8BgU/U4VYE8uKK3MPMUpwMCuJ8LJzA4V4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYdU/tfbS62Hk9I1/P9OJFllcsJ39k
	/evDaltdXSZ7QoNtpmfZ5Fn5ujO2nVl6bIq4Cu/9jrMhPg1KK2xWxF5uft3ruDjt/5MyZQmb
	1n+cTaVFuXOCee13MkpyrvgXfbemzu+ZorvDHasJX1w/iErs8sw+HHgniu/4fesVrG9FSzwC
	0lqfxu5TYinOSDTUYi4qTgQACV31OaoCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On Mon, 18 Mar 2024 12:07:21 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Mon, 18 Mar 2024 22:27:45 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > On Sun, 17 Mar 2024 08:31:44 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > Hi Honggyu,
> > > 
> > > On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > > 
> > > > Hi SeongJae,
> > > > 
> > > > Thanks for the confirmation.  I have a few comments on young filter so
> > > > please read the inline comments again.
> > > > 
> > > > On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > Hi Honggyu,
> > > > > 
> > > > > > > -----Original Message-----
> > > > > > > From: SeongJae Park <sj@kernel.org>
> > > > > > > Sent: Tuesday, March 12, 2024 3:33 AM
> > > > > > > To: Honggyu Kim <honggyu.kim@sk.com>
> > > > > > > Cc: SeongJae Park <sj@kernel.org>; kernel_team <kernel_team@skhynix.com>
> > > > > > > Subject: RE: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
> > > > > > >
> > > > > > > Hi Honggyu,
> > > > > > >
> > > > > > > On Mon, 11 Mar 2024 12:51:12 +0000 "honggyu.kim@sk.com" <honggyu.kim@sk.com> wrote:
> > > > > > >
> > > > > > > > Hi SeongJae,
> > > > > > > >
> > > > > > > > I've tested it again and found that "young" filter has to be set
> > > > > > > > differently as follows.
> > > > > > > > - demote action: set "young" filter with "matching" true
> > > > > > > > - promote action: set "young" filter with "matching" false
> > 
> > Thinking it again, I feel like "matching" true or false looks quite
> > vague to me as a general user.
> > 
> > Instead, I would like to have more meaningful names for "matching" as
> > follows.
> > 
> > - matching "true" can be either (filter) "out" or "skip".
> > - matching "false" can be either (filter) "in" or "apply".
> 
> I agree the naming could be done much better.  And thank you for the nice
> suggestions.  I have a few concerns, though.

I don't think my suggestion is best.  I just would like to have more
discussion about it.

> Firstly, increasing the number of behavioral concepts.  DAMOS filter feature
> has only single behavior: excluding some types of memory from DAMOS action
> target.  The "matching" is to provide a flexible way for further specifying the
> target to exclude in a bit detail.  Without it, we would need non-variant for
> each filter type.  Comapred to the current terms, the new terms feel like
> implying there are two types of behaviors.  I think one behavior is easier to
> understand than two behaviors, and better match what internal code is doing.
> 
> Secondly, ambiguity in "in" and "apply".  To me, the terms sound like _adding_
> something more than _excluding_.

I understood that young filter "matching" "false" means apply action
only to young pages.  Do I misunderstood something here?  If not,
"apply" means _adding_ or _including_ only the matched pages for action.
It looks like you thought about _excluding_ non matched pages here.

> I think that might confuse people in some
> cases.  Actually, I have used the term "filter-out" and "filter-in" on
> this  and several threads.  When saying about "filter-in" scenario, I had to
> emphasize the fact that it is not adding something but excluding others.

Excluding others also means including matched pages.  I think we better
focus on what to do only for the matched pages.

> I now think that was not a good approach.
> 
> Finally, "apply" sounds a bit deterministic.  I think it could be a bit
> confusing in some cases such as when using multiple filters in a combined way.
> For example, if we have two filters for 1) "apply" a memcg and 2) skip anon
> pages, the given DAMOS action will not be applied to anon pages of the memcg.
> I think this might be a bit confusing.

No objection on this.  If so, I think "in" sounds better than "apply".

> > 
> > Internally, the type of "matching" can be boolean, but it'd be better
> > for general users have another ways to set it such as "out"/"in" or
> > "skip"/"apply" via sysfs interface.  I prefer "skip" and "apply" looks
> > more intuitive, but I don't have strong objection on "out" and "in" as
> > well.
> 
> Unfortunately, DAMON sysfs interface is an ABI that we want to keep stable.  Of
> course we could make some changes on it if really required.  But I'm unsure if
> the problem of current naming and benefit of the sugegsted change are big
> enough to outweighs the stability risk and additional efforts.

I don't ask to change the interface, but just provide another way for
the setting.  For example, the current "matching" accepts either 1,
true, or Y but internally keeps as "true" as a boolean type.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/filters/0

  $ echo 1 | tee matching && cat matching
  1
  Y

  $ echo true | tee matching && cat matching
  true
  Y

  $ echo Y | tee matching && cat matching
  Y
  Y

I'm asking if it's okay making "matching" receive "out" or "skip" as
follows.

  $ echo out | tee matching && cat matching
  out
  Y

  $ echo skip | tee matching && cat matching
  skip
  Y

> Also, DAMON sysfs interface is arguably not for _very_ general users.  DAMON
> user-space tool is the one for _more_ general users.  To quote DAMON usage
> document,
> 
>     - *DAMON user space tool.*
>       `This <https://github.com/awslabs/damo>`_ is for privileged people such as
>       system administrators who want a just-working human-friendly interface.
>       [...]
>     - *sysfs interface.*
>       :ref:`This <sysfs_interface>` is for privileged user space programmers who
>       want more optimized use of DAMON. [...]
>  
> If the concept is that confused, I think we could improve the documentation, or
> the user space tool.  But for DAMON sysfs interface, I think we need more
> discussions for getting clear pros/cons that justifies the risk and the effort.

If my suggestion is not what you want in sysfs interface, then "damo"
can receive these more meaningful names and translate to "true" or
"false" when writing to sysfs.

> > 
> > I also feel the filter name "young" is more for developers not for
> > general users.  I think this can be changed to "accessed" filter
> > instead.
> 
> In my humble opinion, "accessed" might be confusing with the term that being
> used by DAMON, specifically, the concept of "nr_accesses".  I also thought
> about using more specific term such as "pg-accessed" or something else, but I
> felt it is still unclear or making it too verbose.
> 
> I agree "young" sounds more for developers.  But, again, DAMON sysfs is for not
> _very_ general users.

I worried the developer term is also going to be used for "damo" user
space tool as "young" filter.  But if you think it's good enough, then I
will follow the decision as I also think "accessed" is not the best term
for this.

> And the term is used commonly on relcaimation part and
> LRU, so I think this is not too bad as long as we provide nice documentation or
> abstraction from user-space tool.
> 
> > 
> > The demote and promote filters can be set as follows using these.
> > 
> > - demote action: set "accessed" filter with "matching" to "skip"
> > - promote action: set "accessed" filter with "matching" to "apply"
> > 
> > I also think that you can feel this is more complicated so I would like
> > to hear how you think about this.
> 
> To my humble brain, this looks intuitive for this use case.  But as I also
> mentioned above, I worry if this could keep simple and intuitive in complicated
> filter usages.
> 
> > 
> > > > > > >
> > > > > > > DAMOS filter is basically for filtering "out" memory regions that matches to
> > > > > > > the condition.
> > 
> > Right.  In other tools, I see filters are more used as filtering "in"
> > rather than filtering "out".  I feel this makes me more confused.
> 
> I understand that the word, "filtering", can be used for both, and therefore
> can be confused.  I was also spending no small times at naming since I was
> thinking about both coffee filters and color filters (of photoshop or glasses).
> But it turned out that I'm more familiar with coffee filters, and might be same
> for DAMON community, since the community is having beer/coffee/tea chat series
> ;) (https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/)

Yeah, I thought about filter for including pages for given config as
follows.

    \    /
     \  /     only matched items pass this filter.
      ||

But the current DAMOS filter is about excluding pages for given config
as follows just like a strainer.
      ___
     /###\
    |#####|   matched items are excluded via this filter.
     \###/
      ---

I think I won't get confused after keeping this difference in mind.

> That said, I think we may be able to make this better documented, or add a
> layer of abstraction on DAMON user-space tool.
> 
> [...]
> > > > > > Yes, I understand "promote non-non-young pages" means "promote young pages".
> > > > > > This might be understood as "young pages are NOT filtered out" for promotion
> > > > > > but it doesn't mean that "old pages are filtered out" instead.
> > > > > > And we just rely hot detection only on DAMOS logics such as access frequency
> > > > > > and age. Am I correct?
> > > > > 
> > > > > You're correct.
> > > > 
> > > > Ack.  But if it doesn't mean that "old pages are filtered out" instead,
> > > 
> > > It does mean that.  Here, filtering is exclusive.  Hence, "filter-in a type of
> > > pages" means "filter-out pages of other types".  At least that's the intention.
> > > To quote the documentation
> > > (https://docs.kernel.org/mm/damon/design.html#filters),
> > > 
> > >     Each filter specifies the type of target memory, and whether it should
> > >     exclude the memory of the type (filter-out), or all except the memory of
> > >     the type (filter-in).
> > 
> > Thanks for the correction.
> > 
> > > > then do we really need this filter for promotion?  If not, maybe should
> > > > we create another "old" filter for promotion?  As of now, the promotion
> > > > is mostly done inaccurately, but the accurate migration is done at
> > > > demotion level.
> > > 
> > > Is this based on your theory?  Or, a real behavior that you're seeing from your
> > > setup?  If this is a real behavior, I think that should be a bug that need to
> > > be fixed.
> > 
> > I have observed this in the hot_cold example, but I also found that the
> > promotion is done very quickly because the age for promote action is set
> > to 0 to max in my json setup.  It makes most pages of the region are
> > young because there is not enough time for those pages being old.  That
> > means I was wrong.
> [...]
> > > > I understand the function name of internal implementation is
> > > > "damos_pa_filter_out" so the basic action is filtering out, but the
> > > > cgroup filter works in the opposite way for now.
> > > 
> > > Does memcg filter works in the opposite way?  I don't think so because
> > > __damos_pa_filter_out() sets 'matches' as 'true' only if the the given folio is
> > > contained in the given memcg.  'young' filter also simply sets 'matches' as
> > > 'true' only if the given folio is young.
> > > 
> > > If it works in the opposite way, it's a bug that need to be fixed.  Please let
> > > me know if I'm missing something.
> > 
> > No, it was also my misunderstanding.  I used to set the matching false
> > using my script.
> 
> Thank you for confirming.  I understand we found no bug at the moment.
> 
> 
> To summarize my opinion again,
> 
> 1. I agree the concept and names of DAMOS filters are confusing and not very
>    intuitive.
> 2. However, it's unclear if the problem and the benefit from the suggested new
>    names are huge enough to take the risk and effort on changing ABI.
> 3. We could improve documentation and/or user-space tool.

I think improving "damo" can be a good solution.

> Thank you again for the suggestion and confirmations to my questions.

Likewise, thank you for the explanation in details.

Honggyu

> 
> 
> Thanks,
> SJ
> 
> [...]

