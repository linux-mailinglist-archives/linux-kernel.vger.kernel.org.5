Return-Path: <linux-kernel+bounces-30015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F383174F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31711C225D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D123760;
	Thu, 18 Jan 2024 10:55:43 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.skhynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B41B96D;
	Thu, 18 Jan 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575343; cv=none; b=tcHoxhT/9eLz8YD8f/kdy+WN+1bEe+6kZX+cTIfqL7DPEdN5UMNPvwxJ8eIlE8odaIijwvpJMlwnLE3NexEWxLSex6gQBS97iJsbAbP6wz3wx2CcIn8CO+fThxCcoQYYb0FliLZhyRbAXFpSN1bqfZg4/7Zrj5I0sd7f71d88Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575343; c=relaxed/simple;
	bh=62k+DYNYiAToaJmsoXZKLChah95X0PxNNmBWywU7twk=;
	h=X-AuditID:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Brightmail-Tracker:X-Brightmail-Tracker:X-CFilter-Loop; b=NPGtj5c+Z8j/Qd8POZQdpwzPU470YKVYyJi3MfRhLrGpb5HTaO6eFbRtRFifrF9lLNVnQ+rO6O4gEuBvi9ypwPIppJ0zPZYkM+tgs5I9vyeEfmUEu4kveZ5Axjyc+Xi3GY/1JbFWXZBmTQTCzOhkIPR+3t7u4Rr/MNT3+6B9UQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-bd5ff7000001c92b-70-65a9001d9683
From: Hyeongtak Ji <hyeongtak.ji@sk.com>
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
Date: Thu, 18 Jan 2024 19:40:16 +0900
Message-Id: <20240118104017.2098-1-hyeongtak.ji@sk.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240117211103.51806-1-sj@kernel.org>
References: <20240117211103.51806-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnka4sw8pUgwe/tCzmrF/DZrHrRojF
	/73HGC2e/P/NanHiZiObRef3pSwWl3fNYbO4t+Y/q8WR9WdZLNbdArI2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj/8HJzF7LD39hs1jQxOQaNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJXx53YnW8EnzYpfkw+yNDBOkOti5OSQEDCRuL7kIjuMvfLICiYQm01AQ2Jaw2Jm
	EFtEQFCi//EM1i5GLg5mgRksEhf3HAcrEhYIkHg85wxYEYuAqkTLgk4WEJtXwFxi5u41LBBD
	NSUmbJkDVs8pYCwx+cREsGVCAkYS29smskHUC0qcnPkErJ5ZQF6ieetsZpBlEgKH2CVWbVjD
	BDFIUuLgihssExj5ZyHpmYWkZwEj0ypGkcy8stzEzBxjveLsjMq8zAq95PzcTYzAqFtW+ydy
	B+O3C8GHGAU4GJV4eDOeLE8VYk0sK67MPcQowcGsJMLrb7AsVYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjhPXVy5c7udb/d02LtrKX1TU5sHLSLPZT
	tyRZr1bv39J+aGZTSLi7gu7+8+71h6/orFrqe/Pmzs/eh9f//OG2a7Kgtprb028lO5e+qyt8
	UTZxgsqiKWsuL3cvyfu1I5FjW/qsYnu3x0mV/QXsF6dcEunwaL0+w1L93/nA6NapItFaMxQm
	KpYsV2Ipzkg01GIuKk4EAA04c1+2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCNUPNU1eWYWWqwcW50hZz1q9hs9h1I8Ti
	/95jjBZP/v9mtThxs5HN4vOz18wWnU++M1ocnnuS1aLz+1IWi8u75rBZ3Fvzn9XiyPqzLBbr
	bgFZm8+eYbZYvFzN4tC156wW+zoeMFkc/vqGyWLypQVsFi+mnGG0ODlrMovF7KP32B3EPP4f
	nMTssfT0GzaPDU1AomXfLXaPBZtKPVqOvGX1WLznJZPHplWdbB6bPk1i9zgx4zeLx86Hlh4v
	Ns9k9Ohtfsfm8e22h8fiFx+YPD5vkgsQiOKySUnNySxLLdK3S+DK+HO7k63gk2bFr8kHWRoY
	J8h1MXJySAiYSKw8soIJxGYT0JCY1rCYGcQWERCU6H88g7WLkYuDWWAGi8TFPcfBioQFAiQe
	zzkDVsQioCrRsqCTBcTmFTCXmLl7DQvEUE2JCVvmgNVzChhLTD4xkR3EFhIwktjeNpENol5Q
	4uTMJ2D1zALyEs1bZzNPYOSZhSQ1C0lqASPTKkaRzLyy3MTMHDO94uyMyrzMCr3k/NxNjMAo
	W1b7Z9IOxm+X3Q8xCnAwKvHwdjxckSrEmlhWXJl7iFGCg1lJhNffYFmqEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2NFlpnYb70PZ7i5l0jdVFHMfLD2
	Tvp120lf3p2bI/1nh2CruuSsXqYYBu1jn0KbOft/Xw7v6n9RsevFU8VWz0/dRywL/rxiK2Iv
	3nrIZOPEu0pHP8bvWbTt/j3+61Uz6sVXhWX/zPX9ED5BZKYoU9pKmxdCBZFntH01rTS5f/Bs
	+ffZO+XUlDNKLMUZiYZazEXFiQBg223CrgIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On Wed, 17 Jan 2024 SeongJae Park <sj@kernel.org> wrote:

[...]
>> Let's say there are 3 nodes in the system and the first node0 and node1
>> are the first tier, and node2 is the second tier.
>> 
>>   $ cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
>>   0-1
>> 
>>   $ cat /sys/devices/virtual/memory_tiering/memory_tier22/nodelist
>>   2
>> 
>> Here is the result of partitioning hot/cold memory and I put execution
>> command at the right side of numastat result.  I initially ran each
>> hot_cold program with preferred setting so that they initially allocate
>> memory on one of node0 or node2, but they gradually migrated based on
>> their access frequencies.
>> 
>>   $ numastat -c -p hot_cold
>>   Per-node process memory usage (in MBs) 
>>   PID              Node 0 Node 1 Node 2 Total 
>>   ---------------  ------ ------ ------ ----- 
>>   754 (hot_cold)     1800      0   2000  3800    <- hot_cold 1800 2000 
>>   1184 (hot_cold)     300      0    500   800    <- hot_cold 300 500 
>>   1818 (hot_cold)     801      0   3199  4000    <- hot_cold 800 3200 
>>   30289 (hot_cold)      4      0      5    10    <- hot_cold 3 5 
>>   30325 (hot_cold)     31      0     51    81    <- hot_cold 30 50 
>>   ---------------  ------ ------ ------ ----- 
>>   Total              2938      0   5756  8695
>> 
>> The final node placement result shows that DAMON accurately migrated
>> pages by their hotness for multiple processes.
>
> What was the result when the corner cases handling logics were not applied?

This is the result of the same test that Honggyu did, but with an insufficient
corner cases handling logics.

  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  862 (hot_cold)    2256      0   1545  3801   <- hot_cold 1800 2000
  863 (hot_cold)     403      0    398   801   <- hot_cold 300 500
  864 (hot_cold)    1520      0   2482  4001   <- hot_cold 800 3200
  865 (hot_cold)       6      0      3     9   <- hot_cold 3 5
  866 (hot_cold)      29      0     52    81   <- hot_cold 30 50
  --------------  ------ ------ ------ -----
  Total             4215      0   4480  8695

As time goes by, DAMON keeps trying to split the hot/cold region, but it does
not seem to be enough.

  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  862 (hot_cold)    2022      0   1780  3801   <- hot_cold 1800 2000
  863 (hot_cold)     351      0    450   801   <- hot_cold 300 500
  864 (hot_cold)    1134      0   2868  4001   <- hot_cold 800 3200
  865 (hot_cold)       7      0      2     9   <- hot_cold 3 5
  866 (hot_cold)      43      0     39    81   <- hot_cold 30 50
  --------------  ------ ------ ------ -----
  Total             3557      0   5138  8695

>
> And, what are the corner cases handling logic that seemed essential?  I show
> the page granularity active/reference check could indeed provide many
> improvements, but that's only my humble assumption.

Yes, the page granularity active/reference check is essential.  To make the
above "insufficient" result, the only thing I did was to promote
inactive/not_referenced pages.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f03be320f9ad..c2aefb883c54 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1127,9 +1127,7 @@ static unsigned int __promote_folio_list(struct list_head *folio_list,
                VM_BUG_ON_FOLIO(folio_test_active(folio), folio);

                references = folio_check_references(folio, sc);
-               if (references == FOLIOREF_KEEP ||
-                   references == FOLIOREF_RECLAIM ||
-                   references == FOLIOREF_RECLAIM_CLEAN)
+               if (references == FOLIOREF_KEEP )
                        goto keep_locked;

                /* Relocate its contents to another node. */

>
> If the corner cases are indeed better to be applied in page granularity, I
> agree we need some more efforts since DAMON monitoring results are not page
> granularity aware by the design.  Users could increase min_nr_regions to make
> it more accurate, and we have plan to support page granularity monitoring,
> though.  But maybe the overhead could be unacceptable.
>
> Ideal solution would be making DAMON more accurate while keeping current level
> of overhead.  We indeed have TODO items for DAMON accuracy improvement, but
> this may take some time that might unacceptable for your case.
>
> If that's the case, I think the additional corner handling (or, page gran
> additional access check) could be made as DAMOS filters[1], since DAMOS filters
> can be applied in page granularity, and designed for this kind of handling of
> information that DAMON monitoring results cannot provide.  More specifically,
> we could have filters for promotion-qualifying pages and demotion-qualifying
> pages.  In this way, I think we can keep the action more flexible while the
> filters can be applied in creative ways.

Making corner handling as a new DAMOS filters is a good idea.  I'm just a bit
concerned if adding new filters might cause users to care more.

Kind regards,
Hyeongtak

