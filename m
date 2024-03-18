Return-Path: <linux-kernel+bounces-106168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB887EA26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4551A2814A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1E481AE;
	Mon, 18 Mar 2024 13:33:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0020315;
	Mon, 18 Mar 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768828; cv=none; b=EebzyFUlcb5NRx6t9SIxCuyUWQvhyJHJ/r4Xrzo5WMIDtiIctpj/qmCMx8HQVr1g6zEAE+MCPw8p2m+07+R0g6QXw5eFlRzAD1ASP6LHWS3MzVCfVW8kcLSnO4O7/DLqXpWRAfO6jrg5O6whckAWXdmRhhOweLR2XASdzL55BI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768828; c=relaxed/simple;
	bh=q0xLpqYTqkB9ibXN1mY5JqcfX9PKUlK+8T5l2q2RBq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=On5KFJ0aRgxwuARNdyISbVdN1TCJMzLrcznfkdNX9dQlCwelS1AIZWP7HoiTVTk90gLYKETrCrWqg2hO0MVdshnNV5EBHaWOzNq3cB9a+qIKXiIisVc5EdTvwuUAjZlj7lGWWDRs6rLh0/Y3qBTCkjHabF8CSB1yo+K+iGKuZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7a-65f842b48e22
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
Date: Mon, 18 Mar 2024 22:33:34 +0900
Message-ID: <20240318133338.2135-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240317191358.97578-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC9ZZnke4Wpx+pBs+6lS0m9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovO70tZLC7vmsNmcW/Nf1aLI+vPslhsPnuG2WLxcjWLfR0P
	mCwOf33DZDH50gI2ixdTzjBanJw1mcVi9tF77A5CHktPv2Hz2NAEJHbOusvu0bLvFrvHgk2l
	Hi1H3rJ6LN7zkslj06pONo9Nnyaxe5yY8ZvFY+dDS48Xm2cyevQ2v2Pz+LxJLoAvissmJTUn
	syy1SN8ugStjxcu3zAVdEhX9J1ezNDBOF+pi5OSQEDCRWLf8NhuM/fBbNzuIzSagJnHl5SQm
	EFtEQFHi3OOLrF2MXBzMAgtZJHq/bwBLCAsES8w9+5+xi5GDg0VAVeLGLl6QMK+AmcT+M8cZ
	IWZqSjze/hNsJqeAscT6BU1gtpAAj8SrDfsZIeoFJU7OfMICYjMLyEs0b53NDNF7iF3i8npH
	CFtS4uCKGywTGPlnIWmZhaRlASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAWFtW+yd6B+On
	C8GHGAU4GJV4eA/o/EgVYk0sK67MPcQowcGsJMLrKvY1VYg3JbGyKrUoP76oNCe1+BCjNAeL
	kjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjQ/qcys2LU1YKRdSH1Jnf3rwkv2LdvdPdoV/8
	5tgUq+5tzE9adfb0ksDtlRUFVmp/P7UfU2x/EzZlzr5CyYA1EbW3ud/vMmPiPdg/f1rJ7G/8
	lxPFz59cP7tcRf1A/zvDbzI7y5u+Lm3P0moOfaka+cFQJ6Fn06SNL54vnfKwic272nravw/p
	SizFGYmGWsxFxYkAt5lNN7ECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXCNUNLT3eL049Ug+5nIhYTewws5qxfw2ax
	60aIxf+9xxgtnvz/zWpx4mYjm8XnZ6+ZLTqffGe0ODz3JKtF5/elLBaXd81hs7i35j+rxZH1
	Z1ksNp89w2yxeLmaxaFrz1kt9nU8YLI4/PUNk8XkSwvYLF5MOcNocXLWZBaL2UfvsTuIeSw9
	/YbNY0MTkNg56y67R8u+W+weCzaVerQcecvqsXjPSyaPTas62Tw2fZrE7nFixm8Wj50PLT1e
	bJ7J6NHb/I7N49ttD4/FLz4weXzeJBcgEMVlk5Kak1mWWqRvl8CVseLlW+aCLomK/pOrWRoY
	pwt1MXJySAiYSDz81s0OYrMJqElceTmJCcQWEVCUOPf4ImsXIxcHs8BCFone7xvAEsICwRJz
	z/5n7GLk4GARUJW4sYsXJMwrYCax/8xxRoiZmhKPt/8Em8kpYCyxfkETmC0kwCPxasN+Roh6
	QYmTM5+wgNjMAvISzVtnM09g5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2M
	wAhbVvtn4g7GL5fdDzEKcDAq8fAe0PmRKsSaWFZcmXuIUYKDWUmE11Xsa6oQb0piZVVqUX58
	UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QD4yR+9nk/bxYF/6qWNjOTrcy8
	s+TuJYFpxy8edpookeYfaFbUp58d6rf1U+a3/gmrV7sEb+fLf9uTu1RrjYIOP8eWjsy66lUr
	tEt32SX2vatL/dfM84FlZdbSlq0nP7H+2/vd7fVdrxdbT1jLv/s5TViMa+aqlFyOUBeZ8+3r
	1rw2k5VNjbm8RYmlOCPRUIu5qDgRAHvKqbKsAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

On Sun, 17 Mar 2024 12:13:57 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Sun, 17 Mar 2024 08:31:44 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi Honggyu,
> > 
> > On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > Hi SeongJae,
> > > 
> > > Thanks for the confirmation.  I have a few comments on young filter so
> > > please read the inline comments again.
> > > 
> > > On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > Hi Honggyu,
> [...]
> > > Thanks.  I see that it works fine, but I would like to have more
> > > discussion about "young" filter.  What I think about filter is that if I
> > > apply "young" filter "true" for demotion, then the action applies only
> > > for "young" pages, but the current implementation works opposite.
> > > 
> > > I understand the function name of internal implementation is
> > > "damos_pa_filter_out" so the basic action is filtering out, but the
> > > cgroup filter works in the opposite way for now.
> > 
> > Does memcg filter works in the opposite way?  I don't think so because
> > __damos_pa_filter_out() sets 'matches' as 'true' only if the the given folio is
> > contained in the given memcg.  'young' filter also simply sets 'matches' as
> > 'true' only if the given folio is young.
> > 
> > If it works in the opposite way, it's a bug that need to be fixed.  Please let
> > me know if I'm missing something.
> 
> I just read the DAMOS filters part of the documentation for DAMON sysfs
> interface again.  I believe it is explaining the meaning of 'matching' as I
> intended to, as below:
> 
>     You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
>     or does not match to the type, respectively.  Then, the scheme's action will
>     not be applied to the pages that specified to be filtered out.
> 
> But, I found the following example for memcg filter is wrong, as below:
> 
>     For example, below restricts a DAMOS action to be applied to only non-anonymous
>     pages of all memory cgroups except ``/having_care_already``.::
>     
>         # echo 2 > nr_filters
>         # # filter out anonymous pages
>         echo anon > 0/type
>         echo Y > 0/matching
>         # # further filter out all cgroups except one at '/having_care_already'
>         echo memcg > 1/type
>         echo /having_care_already > 1/memcg_path
>         echo N > 1/matching
> 
> Specifically, the last line of the commands should write 'Y' instead of 'N' to
> do what explained.  Without the fix, the action will be applied to only
> non-anonymous pages of 'having_care_already' memcg.  This is definitely wrong.
> I will fix this soon.  I'm unsure if this is what made you to believe memcg
> DAMOS filter is working in the opposite way, though.

I got confused not because of this.  I just think it again that this
user interface is better to be more intuitive as I mentioned in the
previous thread.

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]

