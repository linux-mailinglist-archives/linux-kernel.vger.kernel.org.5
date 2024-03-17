Return-Path: <linux-kernel+bounces-105359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09287DCA5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F3E1F21461
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44912B8B;
	Sun, 17 Mar 2024 08:52:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5186EEADB;
	Sun, 17 Mar 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710665527; cv=none; b=he38TTk4oO9B+kiZgFK0iGDcC60Bpi2IZvQfAGoqxRamLJ9x2OOU5Xio5b7STmNM+QSO3H7VWh0IvIX2K4gVVFltNmR/ZV+m7e+gzRQz0ocmE0Yo0N3687B/Dfh7y5Ho9azLQgvFGEhvXm0No69o3BUusKb5EFVudDN+zB2KeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710665527; c=relaxed/simple;
	bh=yvg4kCuIom6yTfrK0qEi2f12VR/mli2A17q7NQXqUYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/GjOBQgX/kYSdriSCqZNKymBdpFUmc6lbAFS3YRYD0fGg/wu5Zmc4lEMmdinjCjFmdVk5leSYwlRoMv/2Fo+toyrXbEC3lWxbJ1jxAyT3lRyq2wtvYBSDws30zUyMPu0X1Mndb8Qo57Br17PG2O+Z8412yq0B02kdJGpReeND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5b-65f6aba550e8
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
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
Date: Sun, 17 Mar 2024 17:36:29 +0900
Message-ID: <20240317083635.2085-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240307030550.47095-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC9ZZnke7S1d9SDT6v17WY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx+ewZZovFy9Us9nU8
	YLI4/PUNk8XkSwvYLF5MOcNocXLWZBaL2UfvsTsIeSw9/YbNY0MTkNg56y67R8u+W+weCzaV
	erQcecvqsXjPSyaPTas62Tw2fZrE7nFixm8Wj50PLT1ebJ7J6NHb/I7N4/MmuQC+KC6blNSc
	zLLUIn27BK6Mv/vXsBTclK/Yu2Q7awPjBYkuRk4OCQETiSVLPjF1MXKA2Qebk0DCbAJqElde
	TmICsUUEFCXOPb7I2sXIxcEssJBFovf7BrCEsECwxNyz/xlBbBYBVYnZL+6xgti8AmYS72ev
	ZIOYrynxePtPdhCbU8BY4uXL98wgtpAAj8SrDfsZIeoFJU7OfMICYjMLyEs0b53NDLJMQuAY
	u8SrHTOZIQZJShxccYNlAiP/LCQ9s5D0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGG3L
	av9E72D8dCH4EKMAB6MSD++F6V9ThVgTy4orcw8xSnAwK4nwuooBhXhTEiurUovy44tKc1KL
	DzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTCqfPo55Zl0wsdlEw6167qu5dkn17BG
	3Pp+oz1Pijvj7I+KAX+47Gc5L/nOfetE8Z5NHwQWvfJ/kL3yhPddsTIJ+wB5/r1Hyvr2zjz3
	JZmj8Pc3DiYu2c3Cu5Yndrl71Zo+WCa1+mxJeM55votXOo4Ll5sqP6lKL8yrOf7bTFz07AaJ
	y47GGf+VWIozEg21mIuKEwHP8YbesgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXCNUNLT3fp6m+pBgv6ZS0m9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovPz14zW3Q++c5ocXjuSVaLzu9LWSwu75rDZnFvzX9WiyPr
	z7JYbD57htli8XI1i0PXnrNa7Ot4wGRx+OsbJovJlxawWbyYcobR4uSsySwWs4/eY3cQ81h6
	+g2bx4YmILFz1l12j5Z9t9g9Fmwq9Wg58pbVY/Gel0wem1Z1snls+jSJ3ePEjN8sHjsfWnq8
	2DyT0aO3+R2bx7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoEr4+/+NSwFN+Ur9i7ZztrA
	eEGii5GDQ0LAROJgc1IXIycHm4CaxJWXk5hAbBEBRYlzjy+ydjFycTALLGSR6P2+ASwhLBAs
	Mffsf0YQm0VAVWL2i3usIDavgJnE+9kr2UBsCQFNicfbf7KD2JwCxhIvX75nBrGFBHgkXm3Y
	zwhRLyhxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZec
	n7uJERhhy2r/TNzB+OWy+yFGAQ5GJR7eC9O/pgqxJpYVV+YeYpTgYFYS4XUVAwrxpiRWVqUW
	5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwzuIuTjPZU2bSZzrDqHdO
	vdch/spaU1khdU3rlesOrnnUfexKgvYJ2V1mDzVkzj0OLf5wJfBOdliIAxOz7gOfkqDYEv8l
	s8yeKibrRi1gP3VSecqL00yfqyMeRhQzJHz8e+gox5XONZJPPhc3dpnyzFZIm9kYY50XIBX0
	N269x3WBn6VMZhVKLMUZiYZazEXFiQBjYalArAIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks for the confirmation.  I have a few comments on young filter so
please read the inline comments again.

On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> Hi Honggyu,
> 
> > > -----Original Message-----
> > > From: SeongJae Park <sj@kernel.org>
> > > Sent: Tuesday, March 12, 2024 3:33 AM
> > > To: Honggyu Kim <honggyu.kim@sk.com>
> > > Cc: SeongJae Park <sj@kernel.org>; kernel_team <kernel_team@skhynix.com>
> > > Subject: RE: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
> > >
> > > Hi Honggyu,
> > >
> > > On Mon, 11 Mar 2024 12:51:12 +0000 "honggyu.kim@sk.com" <honggyu.kim@sk.com> wrote:
> > >
> > > > Hi SeongJae,
> > > >
> > > > I've tested it again and found that "young" filter has to be set
> > > > differently as follows.
> > > > - demote action: set "young" filter with "matching" true
> > > > - promote action: set "young" filter with "matching" false
> > >
> > > DAMOS filter is basically for filtering "out" memory regions that matches to
> > > the condition.  Hence in your setup, young pages are not filtered out from
> > > demote action target.
> > 
> > I thought young filter true means "young pages ARE filtered out" for demotion.
> 
> You're correct.

Ack.

> > 
> > > That is, you're demoting pages that "not" young.
> > 
> > Your explanation here looks opposite to the previous statement.
> 
> Again, you're correct.  My intention was "non-young pages are not ..." but
> maybe I was out of my mind and mistakenly removed "non-" part.  Sorry for the
> confusion.

No problem.  I also think it's quite confusing.

> > 
> > > And vice versa, so you're applying promote to non-non-young (young) pages.
> > 
> > Yes, I understand "promote non-non-young pages" means "promote young pages".
> > This might be understood as "young pages are NOT filtered out" for promotion
> > but it doesn't mean that "old pages are filtered out" instead.
> > And we just rely hot detection only on DAMOS logics such as access frequency
> > and age. Am I correct?
> 
> You're correct.

Ack.  But if it doesn't mean that "old pages are filtered out" instead,
then do we really need this filter for promotion?  If not, maybe should
we create another "old" filter for promotion?  As of now, the promotion
is mostly done inaccurately, but the accurate migration is done at
demotion level.  To avoid this issue, I feel we should promotion only
"young" pages after filtering "old" pages out.

> > 
> > > I understand this is somewhat complex, but what we have for now.
> > 
> > Thanks for the explanation. I guess you mean my filter setup is correct.
> > Is it correct?
> 
> Again, you're correct.  Your filter setup is what I expected to :)

Thanks.  I see that it works fine, but I would like to have more
discussion about "young" filter.  What I think about filter is that if I
apply "young" filter "true" for demotion, then the action applies only
for "young" pages, but the current implementation works opposite.

I understand the function name of internal implementation is
"damos_pa_filter_out" so the basic action is filtering out, but the
cgroup filter works in the opposite way for now.

I would like to hear how you think about this.

> > 
> > > > Then, I see that "hot_cold" migrates hot/cold memory correctly.
> > >
> > > Thank you so much for sharing this great news!  My tests also show no bad
> > > signal so far.
> > >
> > > >
> > > > Could you please upload the "damon_folio_mkold" patch to LKML?
> > > > Then I will rebase our changes based on it and run the redis test again.
> > >
> > > I will do that soon.
> > 
> > Thanks a lot for sharing the RFC v2 for DAMOS young filter.
> > https://lore.kernel.org/damon/20240311204545.47097-1-sj@kernel.org/
> > 
> > I will rebase our work based on it and share the result.
> 
> Cool, looking forward to it!  Hopefully we will make it be merged into the
> mainline by v6.10!

I hope so.  Thanks for your help!

Honggyu

