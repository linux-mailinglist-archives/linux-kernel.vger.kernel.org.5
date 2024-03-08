Return-Path: <linux-kernel+bounces-96652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29890875F85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA831C218CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C81D69E;
	Fri,  8 Mar 2024 08:31:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AA1CD3D;
	Fri,  8 Mar 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886709; cv=none; b=X1Hdq5v7Gdmt4PukQqL7Pd2GfeXLec5lwA1S3SzJDyTLU+6UkFhAyjNmBDG40eqTs05j1LP5ycqxMwoAerTTUjRgM8macVCEGnTniuxJWt2VcPGJzMphkprJC0xUTYb3xFkEW/CAK6jO0VYbaRJpsCVxDRtKw5cnZNjepesSLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886709; c=relaxed/simple;
	bh=hDfMG2qxYuktOsweK4dW0+1dH+uTHvPFBUTxH/5FjMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1Kgf7yK38EwfmLSTRWAGyVjJFXWJ3gv6O3KKO2Ig4hUn8x/vzNGB+tu2aaCnjeohggQMxyIms+4OGuzbAePIu30mMaAQoX32nBzusnqhtHA5nCmASzvcrKQfRAC/PzbTi3JryD5V2fIUR0tUKa6XDUYCWNO7prWBXCigLDIBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7f-65eacce93237
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
Subject: Re: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Fri,  8 Mar 2024 17:31:25 +0900
Message-ID: <20240308083129.1796-1-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC9ZZnoe6rM69SDX4sZbeY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx+ewZZovFy9Us9nU8
	YLI4/PUNk8XkSwvYLF5MOcNocXLWZBaL2UfvsTsIeSw9/YbNY0MTkNg56y67R8u+W+weCzaV
	erQcecvqsXjPSyaPTas62Tw2fZrE7nFixm8Wj50PLT1ebJ7J6NHb/I7N4/MmuQC+KC6blNSc
	zLLUIn27BK6MqdubWAqeCVS8/vGKuYFxHW8XIyeHhICJxK47vWww9rJXN1hBbDYBNYkrLycx
	gdgiAooS5x5fBIpzcTALLGSR6P2+ASwhLBAucarpNXMXIzsHi4CqxNZEkCivgJnEousTWCFG
	ako83v6THcTmFDCWePnyPTOILSTAI/Fqw35GiHpBiZMzn7CA2MwC8hLNW2czg6ySEDjELrFz
	1Q9GiEGSEgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIExtqy2j/R
	Oxg/XQg+xCjAwajEw1tx92WqEGtiWXFl7iFGCQ5mJRFeFgugEG9KYmVValF+fFFpTmrxIUZp
	DhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBka2zmn+3wNOSZQfaj3AY3RF5k7IbMPCybt2
	OSRmadsH7+SNmROrvP1k4d6vN1y2hB27fe3HFceag+xbOw1LW3bPe3Gq+xNf8r2zbt2eQZpb
	IyZqXnDtXMIx56nh7IuG/9ddaFnwyOmKfn8/k9rtzb+7Az9zWcoGK7Xnch/eLKP35Fxv42n3
	KxeVWIozEg21mIuKEwHxr/zSsQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXCNUNLT/flmVepBjvazSwm9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovPz14zW3Q++c5ocXjuSVaLzu9LWSwu75rDZnFvzX9WiyPr
	z7JYbD57htli8XI1i0PXnrNa7Ot4wGRx+OsbJovJlxawWbyYcobR4uSsySwWs4/eY3cQ81h6
	+g2bx4YmILFz1l12j5Z9t9g9Fmwq9Wg58pbVY/Gel0wem1Z1snls+jSJ3ePEjN8sHjsfWnq8
	2DyT0aO3+R2bx7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoErY+r2JpaCZwIVr3+8Ym5g
	XMfbxcjJISFgIrHs1Q1WEJtNQE3iystJTCC2iICixLnHF4HiXBzMAgtZJHq/bwBLCAuES5xq
	es3cxcjOwSKgKrE1ESTKK2Amsej6BFaIkZoSj7f/ZAexOQWMJV6+fM8MYgsJ8Ei82rCfEaJe
	UOLkzCcsIDazgLxE89bZzBMYeWYhSc1CklrAyLSKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMj
	ML6W1f6ZuIPxy2X3Q4wCHIxKPLwVd1+mCrEmlhVX5h5ilOBgVhLhZbEACvGmJFZWpRblxxeV
	5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTD2e7KsOxDObuh5wr3bdqpo7+Wv
	7x/XmBgqzDNsuqf398KjnYvPGl7wkH/O8fLv01zpNYfMzxix7tVsMbo+LSL5wcPz3+1YZCL9
	Ky+FWka8WGJXzsNz2fJT8Yx0tQD9F6Lbv/OcU9Fluvh8q9PpAoN71zcefRu49adNX81Spbw8
	vpl3mnewvipVYinOSDTUYi4qTgQAsqCBdasCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

I couldn't send email to LKML properly due to internal system issues,
but it's better now so I will be able to communicate better.

On Wed,  6 Mar 2024 19:05:50 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> Hello,
> 
> On Tue, 27 Feb 2024 15:51:20 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 26 Feb 2024 23:05:46 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > > posted at [1].
> > > 
> > > It says there is no implementation of the demote/promote DAMOS action
> > > are made.  This RFC is about its implementation for physical address
> > > space.
> [...]
> > Honggyu joined DAMON Beer/Coffee/Tea Chat[1] yesterday, and we discussed about
> > this patchset in high level.  Sharing the summary here for open discussion.  As
> > also discussed on the first version of this patchset[2], we want to make single
> > action for general page migration with minimum changes, but would like to keep
> > page level access re-check.  We also agreed the previously proposed DAMOS
> > filter-based approach could make sense for the purpose.
> > 
> > Because I was anyway planning making such DAMOS filter for not only
> > promotion/demotion but other types of DAMOS action, I will start developing the
> > page level access re-check results based DAMOS filter.  Once the implementation
> > of the prototype is done, I will share the early implementation.  Then, Honggyu
> > will adjust their implementation based on the filter, and run their tests again
> > and share the results.
> 
> I just posted an RFC patchset for the page level access re-check DAMOS filter:
> https://lore.kernel.org/r/20240307030013.47041-1-sj@kernel.org
> 
> I hope it to help you better understanding and testing the idea.

Thanks very much for your work! I will test it based on your changes.

Thanks,
Honggyu

> 
> > 
> > [1] https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/
> > [2] https://lore.kernel.org/damon/20240118171756.80356-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]
> 
> 
> 

