Return-Path: <linux-kernel+bounces-28930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D168304C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E821F24805
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05FD1DFD7;
	Wed, 17 Jan 2024 11:50:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF11DFCA;
	Wed, 17 Jan 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492226; cv=none; b=c2HUni/OqN6MUBTWAsSFUq5nckGAoRY4SusA+s4iomhO2RXGXQUZCiuf+fA03DhA053Rp5ti2D8xMdOueAQ+tcITFL3E0BsyLZjOAmf1prFIlthdxjvSIg8tlhBP6Q0Jz88x+g96UKitHIBCF10IAIus2epTtJUrNGLF3MU6e3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492226; c=relaxed/simple;
	bh=25knBT9VTw+U0/GeKpzOO1VvtIKW+nrpysiNA4cLf18=;
	h=X-AuditID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Brightmail-Tracker:X-Brightmail-Tracker:X-CFilter-Loop; b=jaBoJJY6WOTWBdx42fSROUR40/CjRXqoF6ko5EPfiUcJGHNfR0HbAUIyA4xv7DUuDihWJ8MzhzErOJ4YEfZwQmrhJmO5Jci677/LsFSjYob+aWj1lTs4ZIu6LM+K6yC2OOCM5Ctr0MxnCG4siZyZrneH8USd01rIDhEHzeL6ADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-af-65a7bef58307
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 0/4] DAMON based 2-tier memory management for CXL memory
Date: Wed, 17 Jan 2024 20:49:25 +0900
Message-ID: <20240117114926.1895-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240116203159.52826-1-sj@kernel.org>
References: <20240116203159.52826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsXC9ZZnoe63fctTDaYoW8xZv4bNYteNEIv/
	e48xWjz5/5vV4sTNRjaLzu9LWSwu75rDZnFvzX9WiyPrz7JYrLsFZG0+e4bZYvFyNYt9HQ+Y
	LA5/fcNkMfnSAjaLF1POMFqcnDWZxWL20XvsDkIe/w9OYvZYevoNm8eGJiDRsu8Wu8eCTaUe
	LUfesnos3vOSyWPTqk42j02fJrF7nJjxm8Vj50NLjxebZzJ69Da/Y/P4vEkugC+KyyYlNSez
	LLVI3y6BK+P0qrPMBe90Kha2rGNpYJyu3MXIySEhYCKxbNl6Rhj7+t8jrCA2m4CaxJWXk5hA
	bBEBQYn+xzOA4lwczAIzWCQu7jkOlhAWCJB4POcMM4jNIqAqMX35OrBmXgEziUsTp7FADNWU
	eLz9JzuIzSlgLLHv6TWwXiEBI4ln318zQ9QLSpyc+QSsnllAXqJ562xmkGUSAvvYJT59fQQ1
	SFLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMB4W1b7J3oH46cL
	wYcYBTgYlXh4JeYtTxViTSwrrsw9xCjBwawkwutvsCxViDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA+PMnKhJYaqddu+W5pqs29XOkd1Rc3NH1Lt0cwbT
	Ln6zEJXoT+bvWp782ag2fekSPbui7T92+KRfl7362I5BWKD+QPUMr7y0HVeiddoMDix+EBpZ
	f/O/xa1lD7faO85uc3r/88Z9ycurv0o+3Xw9QO2hLPuvqsu6C/IVbcs/l7b+blObV7QzQUqJ
	pTgj0VCLuag4EQC9qooJswIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCNUNLT/frvuWpBpP36lrMWb+GzWLXjRCL
	/3uPMVo8+f+b1eLEzUY2i8/PXjNbdD75zmhxeO5JVovO70tZLC7vmsNmcW/Nf1aLI+vPslis
	uwVkbT57htli8XI1i0PXnrNa7Ot4wGRx+OsbJovJlxawWbyYcobR4uSsySwWs4/eY3cQ8/h/
	cBKzx9LTb9g8NjQBiZZ9t9g9Fmwq9Wg58pbVY/Gel0wem1Z1snls+jSJ3ePEjN8sHjsfWnq8
	2DyT0aO3+R2bx7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoEr4/Sqs8wF73QqFrasY2lg
	nK7cxcjJISFgInH97xFWEJtNQE3iystJTCC2iICgRP/jGUBxLg5mgRksEhf3HAdLCAsESDye
	c4YZxGYRUJWYvnwdWDOvgJnEpYnTWCCGako83v6THcTmFDCW2Pf0GlivkICRxLPvr5kh6gUl
	Ts58AlbPLCAv0bx1NvMERp5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECIyy
	ZbV/Ju5g/HLZ/RCjAAejEg/vgfxlqUKsiWXFlbmHGCU4mJVEeP0NgEK8KYmVValF+fFFpTmp
	xYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2M6+s5N1UFqf9dIZP/4/WZ2OQnvlf3
	F97QTGWpWnxV85bt2qvWM3bfWPRuupqE/4z/tYEXzqztMdBjzfvXtTu97Xm/9ZFDpaXiF0Pk
	ZFR1ox/f2dLyaLPFt/tHRJoSM26tjGkTrXunkdDW3jx3ziHxB4x2TqUJjHtS2tmZO5Q+h+eL
	/u2w4DBTYinOSDTUYi4qTgQA4IDdUa4CAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks very much for your comments in details.

On Tue, 16 Jan 2024 12:31:59 -0800 SeongJae Park <sj@kernel.org> wrote:

> Thank you so much for this great patches and the above nice test results.  I
> believe the test setup and results make sense, and merging a revised version of
> this patchset would provide real benefits to the users.

Glad to hear that!

> In a high level, I think it might better to separate DAMON internal changes
> from DAMON external changes.

I agree.  I can't guarantee but I can move all the external changes
inside mm/damon, but will try that as much as possible.

> For DAMON part changes, I have no big concern other than trivial coding style
> level comments.

Sure.  I will fix those.

> For DAMON-external changes that implementing demote_pages() and
> promote_pages(), I'm unsure if the implementation is reusing appropriate
> functions, and if those are placee in right source file.  Especially, I'm
> unsure if vmscan.c is the right place for promotion code.  Also I don't know if
> there is a good agreement on the promotion/demotion target node decision.  That
> should be because I'm not that familiar with the areas and the files, but I
> feel this might because our discussions on the promotion and the demotion
> operations are having rooms for being more matured.  Because I'm not very
> faimiliar with the part, I'd like to hear others' comments, too.

I would also like to hear others' comments, but this might not be needed
if most of external code can be moved to mm/damon.

> To this end, I feel the problem might be able te be simpler, because this
> patchset is trying to provide two sophisticated operations, while I think a
> simpler approach might be possible.  My humble simpler idea is adding a DAMOS
> operation for moving pages to a given node (like sys_move_phy_pages RFC[1]),
> instead of the promote/demote.  Because the general pages migration can handle
> multiple cases including the promote/demote in my humble assumption.

My initial implementation was similar but I found that it's not accurate
enough due to the nature of inaccuracy of DAMON regions.  I saw that
many pages were demoted and promoted back and forth because migration
target regions include both hot and cold pages together.

So I have implemented the demotion and promotion logics based on the
shrink_folio_list, which contains many corner case handling logics for
reclaim.

Having the current demotion and promotion logics makes the hot/cold
migration pretty accurate as expected.  We made a simple program called
"hot_cold" and it receives 2 arguments for hot size and cold size in MB.
For example, "hot_cold 200 500" allocates 200MB of hot memory and 500MB
of cold memory.  It basically allocates 2 large blocks of memory with
mmap, then repeat memset for the initial 200MB to make it accessed in an
infinite loop.

Let's say there are 3 nodes in the system and the first node0 and node1
are the first tier, and node2 is the second tier.

  $ cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
  0-1

  $ cat /sys/devices/virtual/memory_tiering/memory_tier22/nodelist
  2

Here is the result of partitioning hot/cold memory and I put execution
command at the right side of numastat result.  I initially ran each
hot_cold program with preferred setting so that they initially allocate
memory on one of node0 or node2, but they gradually migrated based on
their access frequencies.

  $ numastat -c -p hot_cold
  Per-node process memory usage (in MBs) 
  PID              Node 0 Node 1 Node 2 Total 
  ---------------  ------ ------ ------ ----- 
  754 (hot_cold)     1800      0   2000  3800    <- hot_cold 1800 2000 
  1184 (hot_cold)     300      0    500   800    <- hot_cold 300 500 
  1818 (hot_cold)     801      0   3199  4000    <- hot_cold 800 3200 
  30289 (hot_cold)      4      0      5    10    <- hot_cold 3 5 
  30325 (hot_cold)     31      0     51    81    <- hot_cold 30 50 
  ---------------  ------ ------ ------ ----- 
  Total              2938      0   5756  8695

The final node placement result shows that DAMON accurately migrated
pages by their hotness for multiple processes.

> In more detail, users could decide which is the appropriate node for promotion
> or demotion and use the new DAMOS action to do promotion and demotion.  Users
> would requested to decide which node is the proper promotion/demotion target
> nodes, but that decision wouldn't be that hard in my opinion.
> 
> For this, 'struct damos' would need to be updated for such argument-dependent
> actions, like 'struct damos_filter' is haing a union.

That might be a better solution.  I will think about it.

> In future, we could extend the operation to the promotion and the demotion
> after the dicussion around the promotion and demotion is matured, if required.
> And assuming DAMON be extended for originating CPU-aware access monitoring, the
> new DAMOS action would also cover more use cases such as general NUMA nodes
> balancing (extending DAMON for CPU-aware monitoring would required), and some
> complex configurations where having both CPU affinity and tiered memory.  I
> also think that may well fit with my RFC idea[2] for tiered memory management.
> 
> Looking forward to opinions from you and others.  I admig I miss many things,
> and more than happy to be enlightened.
> 
> [1] https://lwn.net/Articles/944007/
> [2] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org/

Thanks very much for your comments.  I will need a few more days for the
update but will try to address your concerns as much as possible.

Thanks,
Honggyu

