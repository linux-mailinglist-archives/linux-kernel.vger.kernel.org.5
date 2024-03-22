Return-Path: <linux-kernel+bounces-111122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94A88682E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430C71C239B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23B171CD;
	Fri, 22 Mar 2024 08:28:17 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11271171C9;
	Fri, 22 Mar 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096096; cv=none; b=PpqQUTiuLXBsLvG6qDloxwkN0rhwACvX/5ikcQFNXdXzKOVGkZzM0f1B03/wpCGZecoUEmjK+Jj3zn5hfv67dR6DbL9aRX+t4mePoPI8622XptXXfVnfLRNA9zy3wEwczPGs1b0+moH+JwL2Dx6liJ6k+6Rkdt/d389rX8rpvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096096; c=relaxed/simple;
	bh=UftWVjwy19WCwvccb70bC/mL8pOUa+OMVbElZ21oS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu83hw4/TCs8vEdbL57ngbvva4OMq2QGpUHXmAXVttrwzP79IIj0C0BGm7Ak+qr+LxfqWRJHq5q0Gg7RsLdNML89cd+44K/4UnGy4Op1osTKsi8PUBBHHbCyKdik9dtukUtIObIO1eSqhxDO/CbG408ZUHnqVyM0bTJd3mfxamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-96-65fd4111d96d
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
Date: Fri, 22 Mar 2024 17:27:34 +0900
Message-ID: <20240322082742.2233-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240320165619.71478-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsXC9ZZnoa6g499UgzlThCwm9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBn/d7SyF/woruh5do+xgXFJRBcjJ4eEgInEvc/b2GHsKQe2g9lsAmoS
	V15OYgKxRQQUJc49vsjaxcjFwSwwg0Xi8MIuRpCEsECwxNyz/8FsFgFVibdXn7B0MXJw8AqY
	SVx5kAQxU1Pi8fafYDM5BYwl7h7/wwZiCwnwSLzasB+slVdAUOLkTJBWTqD58hLNW2czg+yS
	EDjELnHj9ClmiEGSEgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIE
	xt2y2j/ROxg/XQg+xCjAwajEw2sg/CdViDWxrLgy9xCjBAezkgjvjv9AId6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYzhugtuhiju+8nXsU922xb5l5s3
	33jFe2263ny+jdEiBdMdAr9vmy14ddIC/RlaW2JfuGcdftQrv0raXLV7xZKelk/nF/wv6/vx
	MH33xUV1t18WWq0xtFmYMKfm6iOtWbW/l4Tv7FqaVZYbyzVVMeJanIBG11uP7mX25Q21G/81
	/F6ab+x5/aK7EktxRqKhFnNRcSIAFEJFrLcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXCNUNLT1fQ8W+qwWkHi4k9BhZz1q9hs9h1
	I8Ti/oPX7Bb/9x5jtHjy/zerxYmbjWwWnU++M1ocnnuS1aLz+1IWi8u75rBZ3Fvzn9XiyPqz
	LBabz55htli8XM3i0LXnrBb7Oh4wWRz++obJYvKlBWwWL6acYbQ4OWsyi8Xso/fYHcQ8lp5+
	w+axoQlI7Jx1l92jZd8tdo8Fm0o9Wo68ZfVYvOclk8emVZ1sHps+TWL3ODHjN4vHzoeWHi82
	z2T06G1+x+bx7baHx+IXH5g8Pm+SCxCI4rJJSc3JLEst0rdL4Mr4v6OVveBHcUXPs3uMDYxL
	IroYOTkkBEwkphzYzg5iswmoSVx5OYkJxBYRUJQ49/giaxcjFwezwAwWicMLuxhBEsICwRJz
	z/4Hs1kEVCXeXn3C0sXIwcErYCZx5UESxExNicfbf4LN5BQwlrh7/A8biC0kwCPxasN+sFZe
	AUGJkzNBWjmB5stLNG+dzTyBkWcWktQsJKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcx
	AuNrWe2fiTsYv1x2P8QowMGoxMNrIfUnVYg1say4MvcQowQHs5II747/QCHelMTKqtSi/Pii
	0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGAI2ZC1Z6H0zQn7peL73omYtf
	xBt+Ebu1Al3vNka8u7z4v1+3y/WnTFVaDGYGr/496szzKDnZor3isuj0pvoleq/3JMp9Wv3R
	VXhi0OmA+YFTjD4t/rLjrUSlfevnmYfK625Jy31N5D+4b33kw/W1bJUevI8+fPi2V8juEFdv
	Rsu9ZKX3x1vFlFiKMxINtZiLihMBo9XRcKsCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On Wed, 20 Mar 2024 09:56:19 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hi Honggyu,
> 
> On Wed, 20 Mar 2024 16:07:48 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > On Mon, 18 Mar 2024 12:07:21 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > On Mon, 18 Mar 2024 22:27:45 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > > 
> > > > Hi SeongJae,
> > > > 
> > > > On Sun, 17 Mar 2024 08:31:44 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > > Hi Honggyu,
> > > > > 
> > > > > On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > > > > 
> > > > > > Hi SeongJae,
> > > > > > 
> > > > > > Thanks for the confirmation.  I have a few comments on young filter so
> > > > > > please read the inline comments again.
> > > > > > 
> > > > > > On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > > > Hi Honggyu,
> > > > > > > 
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: SeongJae Park <sj@kernel.org>
> > > > > > > > > Sent: Tuesday, March 12, 2024 3:33 AM
> > > > > > > > > To: Honggyu Kim <honggyu.kim@sk.com>
> > > > > > > > > Cc: SeongJae Park <sj@kernel.org>; kernel_team <kernel_team@skhynix.com>
> > > > > > > > > Subject: RE: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
> > > > > > > > >
> > > > > > > > > Hi Honggyu,
> > > > > > > > >
> > > > > > > > > On Mon, 11 Mar 2024 12:51:12 +0000 "honggyu.kim@sk.com" <honggyu.kim@sk.com> wrote:
> > > > > > > > >
> > > > > > > > > > Hi SeongJae,
> > > > > > > > > >
> > > > > > > > > > I've tested it again and found that "young" filter has to be set
> > > > > > > > > > differently as follows.
> > > > > > > > > > - demote action: set "young" filter with "matching" true
> > > > > > > > > > - promote action: set "young" filter with "matching" false
> > > > 
> > > > Thinking it again, I feel like "matching" true or false looks quite
> > > > vague to me as a general user.
> > > > 
> > > > Instead, I would like to have more meaningful names for "matching" as
> > > > follows.
> > > > 
> > > > - matching "true" can be either (filter) "out" or "skip".
> > > > - matching "false" can be either (filter) "in" or "apply".
> > > 
> > > I agree the naming could be done much better.  And thank you for the nice
> > > suggestions.  I have a few concerns, though.
> > 
> > I don't think my suggestion is best.  I just would like to have more
> > discussion about it.
> 
> I also understand my naming sense is far from good :)  I'm grateful to have
> this constructive discussion!

Yeah, naming is always difficult. Thanks anyway :)

> > 
> > > Firstly, increasing the number of behavioral concepts.  DAMOS filter feature
> > > has only single behavior: excluding some types of memory from DAMOS action
> > > target.  The "matching" is to provide a flexible way for further specifying the
> > > target to exclude in a bit detail.  Without it, we would need non-variant for
> > > each filter type.  Comapred to the current terms, the new terms feel like
> > > implying there are two types of behaviors.  I think one behavior is easier to
> > > understand than two behaviors, and better match what internal code is doing.
> > > 
> > > Secondly, ambiguity in "in" and "apply".  To me, the terms sound like _adding_
> > > something more than _excluding_.
> > 
> > I understood that young filter "matching" "false" means apply action
> > only to young pages.  Do I misunderstood something here?  If not,
> 
> Technically speaking, having a DAMOS filter with 'matching' parameter as
> 'false' for 'young pages' type means you want DAMOS to "exclude pages that not
> young from the scheme's action target".  That's the only thing it truly does,
> and what it tries to guarantee.  Whether the action will be applied to young
> pages or not depends on more factors including additional filters and DAMOS
> parameter.  IOW, that's not what the simple setting promises.
> 
> Of course, I know you are assuming there is only the single filter.  Hence,
> effectively you're correct.  And the sentence may be a better wording for end
> users.  However, it tooke me a bit time to understand your assumption and
> concluding whether your sentence is correct or not, since I had to think about
> the assumptions.
> 
> I'd say this also reminds me the first concern that I raised on the previous
> mail.  IOW, I feel this sentence is introducing one more behavior and making it
> bit taking longer time to digest, for developers who should judge it based on
> the source code.  I'd suggest use only one behavioral term, "exclude", since it
> is what the code really does, unless it is wording for end users.

Okay, I will just think filter "exclude" something.

> > "apply" means _adding_ or _including_ only the matched pages for action.
> > It looks like you thought about _excluding_ non matched pages here.
> 
> Yes.  I'd prefer using only single term, _excluding_.  It fits with the code,
> and require one word less that "adding" or "including", since "adding" or
> "including" require one more word, "only".
> 
> Also, even with "only", the fact that there could be more filters makes me
> unsure what is the consequence of having it.  That is, if we have a filter that
> includes only pages of type A, but if there could be yet another filter that
> includes only pages of type B, would the consequence is the action being
> applied to pages of type A and B?  Or, type A or type B?
> 
> In my opinion, exclusion based approach is simpler for understanding the
> consequence of such combinational usage.
> 
> > 
> > > I think that might confuse people in some
> > > cases.  Actually, I have used the term "filter-out" and "filter-in" on
> > > this  and several threads.  When saying about "filter-in" scenario, I had to
> > > emphasize the fact that it is not adding something but excluding others.
> > 
> > Excluding others also means including matched pages.  I think we better
> > focus on what to do only for the matched pages.
> 
> I agree that is true for the end-users in many cases.  But I think that depends
> on the case, and at least this specific case (kernel ABI level discussion about
> DAMOS filters), I don't really feel that's better.

OK. It could be a matter of preference and the current filter is already
in the mainline so I won't insist more.

> > 
> > > I now think that was not a good approach.
> > > 
> > > Finally, "apply" sounds a bit deterministic.  I think it could be a bit
> > > confusing in some cases such as when using multiple filters in a combined way.
> > > For example, if we have two filters for 1) "apply" a memcg and 2) skip anon
> > > pages, the given DAMOS action will not be applied to anon pages of the memcg.
> > > I think this might be a bit confusing.
> > 
> > No objection on this.  If so, I think "in" sounds better than "apply".
> 
> Thanks for understanding.  I think allowlists or denylists might also been
> better names.

"allow" and "deny" sound good to me as well. We don't have to change it
though.

> > 
> > > > 
> > > > Internally, the type of "matching" can be boolean, but it'd be better
> > > > for general users have another ways to set it such as "out"/"in" or
> > > > "skip"/"apply" via sysfs interface.  I prefer "skip" and "apply" looks
> > > > more intuitive, but I don't have strong objection on "out" and "in" as
> > > > well.
> > > 
> > > Unfortunately, DAMON sysfs interface is an ABI that we want to keep stable.  Of
> > > course we could make some changes on it if really required.  But I'm unsure if
> > > the problem of current naming and benefit of the sugegsted change are big
> > > enough to outweighs the stability risk and additional efforts.
> > 
> > I don't ask to change the interface, but just provide another way for
> > the setting.  For example, the current "matching" accepts either 1,
> > true, or Y but internally keeps as "true" as a boolean type.
> > 
> >   $ cd /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/filters/0
> > 
> >   $ echo 1 | tee matching && cat matching
> >   1
> >   Y
> > 
> >   $ echo true | tee matching && cat matching
> >   true
> >   Y
> > 
> >   $ echo Y | tee matching && cat matching
> >   Y
> >   Y
> > 
> > I'm asking if it's okay making "matching" receive "out" or "skip" as
> > follows.
> > 
> >   $ echo out | tee matching && cat matching
> >   out
> >   Y
> > 
> >   $ echo skip | tee matching && cat matching
> >   skip
> >   Y
> 
> I have no strong concern about this.  But also not seeing significant benefit
> of this change.  This will definitely not regress user experience.  But it will
> require introducing more kernel code, though the amount will be fairly small.
> And this new interface will be something that we need to keep maintain, so
> adding a tiny bit of maintenance burden.  I'd prefer improving the documents or
> user-space tool and keep the kernel code simple.

OK. I will see if there is a way to improve damo tool for this instead
of making changes on the kernel side.

> IMHO, end users shouldn't deal directly with DAMOS filters at all, and kernel
> ABI document should be clear enough to avoid confusion.  But, if someone uses
> kernel ABI on production without reading the document, I'd say it might better
> to crash or OOPS to give clear warning and lessons.
> 
> > 
> > > Also, DAMON sysfs interface is arguably not for _very_ general users.  DAMON
> > > user-space tool is the one for _more_ general users.  To quote DAMON usage
> > > document,
> > > 
> > >     - *DAMON user space tool.*
> > >       `This <https://github.com/awslabs/damo>`_ is for privileged people such as
> > >       system administrators who want a just-working human-friendly interface.
> > >       [...]
> > >     - *sysfs interface.*
> > >       :ref:`This <sysfs_interface>` is for privileged user space programmers who
> > >       want more optimized use of DAMON. [...]
> > >  
> > > If the concept is that confused, I think we could improve the documentation, or
> > > the user space tool.  But for DAMON sysfs interface, I think we need more
> > > discussions for getting clear pros/cons that justifies the risk and the effort.
> > 
> > If my suggestion is not what you want in sysfs interface, then "damo"
> > can receive these more meaningful names and translate to "true" or
> > "false" when writing to sysfs.
> 
> Yes, I agree.  We could further hide filter concept at all.  For example, we
> could let damo user call "migrate" DAMOS action plus "non-young" filter as
> "promote" action.  Or, have a dedicated command for tiered-memory management.
> Similar to the gen_config.py of HMSDK
> (https://github.com/skhynix/hmsdk/blob/main/tools/gen_config.py).  But this
> would be something to further discuss on different threads.

Yeah, I made this thread too much about filter naming discussion rather
than tiered memory support.

> > 
> > > > 
> > > > I also feel the filter name "young" is more for developers not for
> > > > general users.  I think this can be changed to "accessed" filter
> > > > instead.
> > > 
> > > In my humble opinion, "accessed" might be confusing with the term that being
> > > used by DAMON, specifically, the concept of "nr_accesses".  I also thought
> > > about using more specific term such as "pg-accessed" or something else, but I
> > > felt it is still unclear or making it too verbose.
> > > 
> > > I agree "young" sounds more for developers.  But, again, DAMON sysfs is for not
> > > _very_ general users.
> > 
> > I worried the developer term is also going to be used for "damo" user
> > space tool as "young" filter.  But if you think it's good enough, then I
> > will follow the decision as I also think "accessed" is not the best term
> > for this.
> 
> The line is not very clear, but I think the line for "damo" should be different
> from that for DAMON sysfs interface.
> 
> [...]
> > > > > > > > > DAMOS filter is basically for filtering "out" memory regions that matches to
> > > > > > > > > the condition.
> > > > 
> > > > Right.  In other tools, I see filters are more used as filtering "in"
> > > > rather than filtering "out".  I feel this makes me more confused.
> > > 
> > > I understand that the word, "filtering", can be used for both, and therefore
> > > can be confused.  I was also spending no small times at naming since I was
> > > thinking about both coffee filters and color filters (of photoshop or glasses).
> > > But it turned out that I'm more familiar with coffee filters, and might be same
> > > for DAMON community, since the community is having beer/coffee/tea chat series
> > > ;) (https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/)
> > 
> > Yeah, I thought about filter for including pages for given config as
> > follows.
> > 
> >     \    /
> >      \  /     only matched items pass this filter.
> >       ||
> > 
> > But the current DAMOS filter is about excluding pages for given config
> > as follows just like a strainer.
> >       ___
> >      /###\
> >     |#####|   matched items are excluded via this filter.
> >      \###/
> >       ---
> > 
> > I think I won't get confused after keeping this difference in mind.
> 
> My mind model was describing it as "excluding" coffee beans, but I'd say these
> are just different perspectives, not a thing about right or wrong.  I'm
> grateful to learn one more perspective that is different from mine :)

I'm more familiar with the filter in ftrace, which is set to 
/sys/kernel/tracing/set_ftrace_filter and it means "including"
something.  But I will keep thinking DAMOS filter is different.

> > 
> > > That said, I think we may be able to make this better documented, or add a
> > > layer of abstraction on DAMON user-space tool.
> > > 
> [...]
> > > To summarize my opinion again,
> > > 
> > > 1. I agree the concept and names of DAMOS filters are confusing and not very
> > >    intuitive.
> > > 2. However, it's unclear if the problem and the benefit from the suggested new
> > >    names are huge enough to take the risk and effort on changing ABI.
> > > 3. We could improve documentation and/or user-space tool.
> > 
> > I think improving "damo" can be a good solution.
> 
> Looking forward to the discussion on it! :)
> 
> > 
> > > Thank you again for the suggestion and confirmations to my questions.
> > 
> > Likewise, thank you for the explanation in details.
> 
> My great pleasure, and thank you for patiently keeping this grateful
> discussion!

Thanks again for your feedback.

Honggyu

> Thanks,
> SJ
> 
> [...]

