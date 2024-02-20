Return-Path: <linux-kernel+bounces-72258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286185B13B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1BF281B84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1055E60;
	Tue, 20 Feb 2024 03:20:22 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EE5577E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399222; cv=none; b=hY/Nn4uAS4RmuU5eDlPkLt9uYYZN2oqY/P7BR2+EZF19XMaYt6ITSmPm0B15RzR1F9ihuEnGFAH/m8Jv9Ms8HC15l6Fpwxiwyc8hMmY6JBGrXG4xAiAmWNfa2rw53bk4Q0h2Vm/sRZB8o6j5AM/YuSeEFUYyAeY0OpaaORz7Rl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399222; c=relaxed/simple;
	bh=VAKH1Upa/t6P8HQUiji82M4GeUreev3pg+GtG5r1+/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lapbVfX0tFwkp53Gd3dF2emF5Tc+13ndUuRHRKk4EVPvSitLU8yXeToLKvZS0z/1xGkdKAAhWn+vmLS4xZEo8nCuNUHSEimpVOgwBqvIbDZdyNcQPsM/W5H2O2gkURcRbAFpf6YWK6zagLoc9NkiUzouGjU29zHGvVwVFvTIQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-83-65d41a6d8cd9
Date: Tue, 20 Feb 2024 12:20:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-ID: <20240220032008.GH65758@system.software.com>
References: <20240219041920.1183-1-byungchul@sk.com>
 <87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
 <20240220015343.GD65758@system.software.com>
 <20240219190520.b5e373273ec743aacbad263b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219190520.b5e373273ec743aacbad263b@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC9ZZnkW6u1JVUg63/jC3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFkc7z3AZLGv4wGTRceRb8wW
	W49+Z7c4OWsyiwOfx5p5axg9WvbdYvdYsKnUY/MKLY/Fe14yeWz6NInd4861PWweJ2b8ZvF4
	v+8qm8fm09UenzfJBXBHcdmkpOZklqUW6dslcGVc33KUueASd8WL/ZINjDM4uxg5OCQETCQm
	fY3rYuQEM7smn2QBsVkEVCWmtq1jBbHZBNQlbtz4yQxiiwjoSqx6vgvMZha4ziRx/V8hiC0s
	ECUxY8kXRhCbV8BC4sb1DvYuRi4OIYGZTBLffm6CSghKnJz5hAWiWUvixr+XTCA3MAtISyz/
	xwES5hTwlmju/cIEYosKKEsc2HacCWSOhEA7u8TX3llsEIdKShxccYNlAqPALCRjZyEZOwth
	7AJG5lWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgVG1rPZP9A7GTxeCDzEKcDAq8fA+iLucKsSa
	WFZcmXuIUYKDWUmE173pQqoQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakF
	qUUwWSYOTqkGxlrJObMTlNvL1m1e/ixN40/l/OtTM7e77rnNECIlrdk0WdR+R5uplKB+yTWu
	zC3BSWvNdhhy/6pkO9rAc8my51WRYcehkskMjF/rP00O2Wuw1G5ict+PbbscjaLcHHed2lHE
	OqMzzP/txaMPTlR9XZXVHu3tUqXtdszwjnzh9qb+SWUnTqecVWIpzkg01GIuKk4EALQAcKqm
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsXC5WfdrJsrdSXV4OA7eYs569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjjee4DJYl/HAyaL
	jiPfmC22Hv3ObnFy1mQWB36PNfPWMHq07LvF7rFgU6nH5hVaHov3vGTy2PRpErvHnWt72DxO
	zPjN4vF+31U2j8UvPjB5bD5d7fF5k1wATxSXTUpqTmZZapG+XQJXxvUtR5kLLnFXvNgv2cA4
	g7OLkZNDQsBEomvySRYQm0VAVWJq2zpWEJtNQF3ixo2fzCC2iICuxKrnu8BsZoHrTBLX/xWC
	2MICURIzlnxhBLF5BSwkblzvYO9i5OIQEpjJJPHt5yaohKDEyZlPWCCatSRu/HvJ1MXIAWRL
	Syz/xwES5hTwlmju/cIEYosKKEsc2HacaQIj7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84
	O6MyL7NCLzk/dxMjMEqW1f6ZuIPxy2X3Q4wCHIxKPLwP4i6nCrEmlhVX5h5ilOBgVhLhdW+6
	kCrEm5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAWP7VrCJs
	e9+qbKEJqvIJzaLbw+M2v3msxH7lzbar1np6FsLPEtnNTPj9pqZNPPn3z8IVi216N6zJ2fFp
	zezYGWyFMsk+b5YJfrWOfS5b0fbx35Rtuhnp/6JjHqqr83w/PGXLx7mPzt9Ot077O2nLg4Xb
	XWcaqci9m8o0gbv6T8nbGx1x0gmuM5RYijMSDbWYi4oTAaUpDKOOAgAA
X-CFilter-Loop: Reflected

On Mon, Feb 19, 2024 at 07:05:20PM -0800, Andrew Morton wrote:
> On Tue, 20 Feb 2024 10:53:43 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> > > > IIUC, you will use patch as fix to the issue in
> > > > 
> > > > https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> > > > 
> > > > If so, we need the Fixes: tag to make it land in -stable properly.
> > > 
> > > Yes, this changelog is missing rather a lot of important information.
> > 
> > This is not the root cause fix any more but just optimization.
> 
> It would have been helpful to have told us this in the changelog :(

Sorry for that and making you guys confused.

> > That's
> > why I didn't add Fixes: tag and cc stable@vger.kernel.org in here.
> > 
> > Instead, I added Fixes: tag and cc'ed stable@vger.kernel.org in the real
> > fix patch. check the following link please:
> > 
> > https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> 
> But doesn't this patch "sched/numa, mm: do not try to migrate memory to
> memoryless nodes" also fix the bug?  Do we truly need both?

Yes. The oops is gone with "sched/numa, mm: do not try to migrate memory
to memoryless nodes". However, as you know, wrongly manipulating array
index is very dangerous - what hackers are looking for. Even with security
in mind, both are necessary. Plus, no one gurantees the problematic code
is gone through with a numa node that has no managed zones in the future.

	Byungchul

