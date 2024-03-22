Return-Path: <linux-kernel+bounces-111179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697968868CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F21B285ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747D1CA80;
	Fri, 22 Mar 2024 09:02:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5481B7F1;
	Fri, 22 Mar 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098157; cv=none; b=EQJhyFsJllXcj+6I/wpyhgcWz3Ax0ptqJjkZd3mJ1tLgwGnJng5PfPs31RuG7xpQbNOozdlgKfEyfoH8hG4FZ045uiVtDedczgZpL3sy20O1Zjn+vy6ErNt2qoHD9oCe/2UkanfmoLVV3gJJVYJiLM9GPjhA6f/pgd/s8kM8W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098157; c=relaxed/simple;
	bh=uLRm+x/u06k/v7a4CovXxbNGCwI4mkizG4isyYjBp1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHj28daS6Bv1GruMCpKDqKqjMynfa9M9UfuKn9BhQm+SAHMQyo/QaixhmK3Hram/Eesx2jpzMRuMYxlSEH5bOYYvBWDxfhmwoW8lkPATZTGDRW2+2xqYCzLYJnenKUnXKDyn6PdVLAkfw3py8RD9ckB8AlGEE4rE4U/27zj1ziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ad-65fd4925a14a
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
	lizhijian@cn.fujitsu.com,
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
Date: Fri, 22 Mar 2024 18:02:23 +0900
Message-ID: <20240322090227.2253-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240227235121.153277-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsXC9ZZnoa6q599Ug/3zNC0m9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovO70tZLC7vmsNmcW/Nf1aLI+vPslisuwVkbT57htli8XI1
	i30dD5gsDn99w2Qx+dICNosXU84wWpycNZnFYvbRe+wOwh7/D05i9lh6+g2bx4YmILFz1l12
	j5Z9t9g9Fmwq9Wg58pbVY/Gel0wem1Z1snls+jSJ3ePEjN8sHjsfWnq82DyT0aO3+R2bx+dN
	cgH8UVw2Kak5mWWpRfp2CVwZTaeFCk63MVb8fHefrYHxbWoXIweHhICJxMX/jl2MnGDm3A9/
	2EBsNgE1iSsvJzGB2CICihLnHl9k7WLk4mAWmMkiceHsblaQhLBAsMTcs/8ZQWwWAVWJ5y8X
	gcV5Bcwkvry5zwIxVFPi8faf7CA2J9CCR/vugtULCfBIvNqwnxGiXlDi5MwnYPXMAvISzVtn
	M4MskxDYxy5xu/cW1CBJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNz
	NzECI3BZ7Z/oHYyfLgQfYhTgYFTi4TUQ/pMqxJpYVlyZe4hRgoNZSYR3x3+gEG9KYmVValF+
	fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsZ55ydY1PFGcNz+7Zoz4Wfp
	vl+r2RsKa7xLZlktUgidyCVfvaK7liclJFVc9FS8eKUcZ5nt+r6oE/HqlozzzIX/ajI5Ltxh
	9WtW+5Oi419CBdiyhDJ/LPyVmcOUZyYmo/4grG6DLdOTnq5VNzNPxf9O8VD7LcdhPntTUKXV
	29vXdvWcdvF9psRSnJFoqMVcVJwIAKNKttm8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCNUNLT1fV82+qwflXohYTewws5qxfw2ax
	60aIxf+9xxgtnvz/zWpx4mYjm0Xnk++MFofnnmS16Py+lMXi8q45bBb31vxntTiy/iyLxbpb
	QNbms2eYLRYvV7M4dO05q8W+jgdMFoe/vmGymHxpAZvFiylnGC1OzprMYjH76D12BzGP/wcn
	MXssPf2GzWNDE5DYOesuu0fLvlvsHgs2lXq0HHnL6rF4z0smj02rOtk8Nn2axO5xYsZvFo+d
	Dy09XmyeyejR2/yOzePbbQ+PxS8+MAUIRnHZpKTmZJalFunbJXBlNJ0WKjjdxljx8919tgbG
	t6ldjJwcEgImEnM//GEDsdkE1CSuvJzEBGKLCChKnHt8kbWLkYuDWWAmi8SFs7tZQRLCAsES
	c8/+ZwSxWQRUJZ6/XAQW5xUwk/jy5j4LxFBNicfbf7KD2JxACx7tuwtWLyTAI/Fqw35GiHpB
	iZMzn4DVMwvISzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKj
	bFntn4k7GL9cdj/EKMDBqMTDayH1J1WINbGsuDL3EKMEB7OSCO+O/0Ah3pTEyqrUovz4otKc
	1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxknKnP5fmRj9Teavy6n69m7StnlB
	c37cf2XDrJb7ccqEh02rOqeb/J+tyT3Xc7oVr5VaypK3vOIaC4us5FOOx66tLCxW/+lVevF6
	wql8th+XWZTEbju9v/J0cqGVG/8S6xvmF+buMHrz4cTlqJ/dJw7eMOXkS29/yfR6oS/79iie
	lISFXlohxUosxRmJhlrMRcWJAGQNlHiuAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

On Tue, 27 Feb 2024 15:51:20 -0800 SeongJae Park <sj@kernel.org> wrote:
> On Mon, 26 Feb 2024 23:05:46 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
> > 
> > It says there is no implementation of the demote/promote DAMOS action
> > are made.  This RFC is about its implementation for physical address
> > space.
> > 
> > 
> > Introduction
> > ============
> > 
> > With the advent of CXL/PCIe attached DRAM, which will be called simply
> > as CXL memory in this cover letter, some systems are becoming more
> > heterogeneous having memory systems with different latency and bandwidth
> > characteristics.  They are usually handled as different NUMA nodes in
> > separate memory tiers and CXL memory is used as slow tiers because of
> > its protocol overhead compared to local DRAM.
> > 
> > In this kind of systems, we need to be careful placing memory pages on
> > proper NUMA nodes based on the memory access frequency.  Otherwise, some
> > frequently accessed pages might reside on slow tiers and it makes
> > performance degradation unexpectedly.  Moreover, the memory access
> > patterns can be changed at runtime.
> > 
> > To handle this problem, we need a way to monitor the memory access
> > patterns and migrate pages based on their access temperature.  The
> > DAMON(Data Access MONitor) framework and its DAMOS(DAMON-based Operation
> > Schemes) can be useful features for monitoring and migrating pages.
> > DAMOS provides multiple actions based on DAMON monitoring results and it
> > can be used for proactive reclaim, which means swapping cold pages out
> > with DAMOS_PAGEOUT action, but it doesn't support migration actions such
> > as demotion and promotion between tiered memory nodes.
> > 
> > This series supports two new DAMOS actions; DAMOS_DEMOTE for demotion
> > from fast tiers and DAMOS_PROMOTE for promotion from slow tiers.  This
> > prevents hot pages from being stuck on slow tiers, which makes
> > performance degradation and cold pages can be proactively demoted to
> > slow tiers so that the system can increase the chance to allocate more
> > hot pages to fast tiers.
> > 
> > The DAMON provides various tuning knobs but we found that the proactive
> > demotion for cold pages is especially useful when the system is running
> > out of memory on its fast tier nodes.
> > 
> > Our evaluation result shows that it reduces the performance slowdown
> > compared to the default memory policy from 15~17% to 4~5% when the
> > system runs under high memory pressure on its fast tier DRAM nodes.
> > 
> > 
> > DAMON configuration
> > ===================
> > 
> > The specific DAMON configuration doesn't have to be in the scope of this
> > patch series, but some rough idea is better to be shared to explain the
> > evaluation result.
> > 
> > The DAMON provides many knobs for fine tuning but its configuration file
> > is generated by HMSDK[2].  It includes gen_config.py script that
> > generates a json file with the full config of DAMON knobs and it creates
> > multiple kdamonds for each NUMA node when the DAMON is enabled so that
> > it can run hot/cold based migration for tiered memory.
> 
> I was feeling a bit confused from here since DAMON doesn't receive parameters
> via a file.  To my understanding, the 'configuration file' means the input file
> for DAMON user-space tool, damo, not DAMON.  Just a trivial thing, but making
> it clear if possible could help readers in my opinion.
> 
> > 
> > 
> > Evaluation Workload
> > ===================
> > 
> > The performance evaluation is done with redis[3], which is a widely used
> > in-memory database and the memory access patterns are generated via
> > YCSB[4].  We have measured two different workloads with zipfian and
> > latest distributions but their configs are slightly modified to make
> > memory usage higher and execution time longer for better evaluation.
> > 
> > The idea of evaluation using these demote and promote actions covers
> > system-wide memory management rather than partitioning hot/cold pages of
> > a single workload.  The default memory allocation policy creates pages
> > to the fast tier DRAM node first, then allocates newly created pages to
> > the slow tier CXL node when the DRAM node has insufficient free space.
> > Once the page allocation is done then those pages never move between
> > NUMA nodes.  It's not true when using numa balancing, but it is not the
> > scope of this DAMON based 2-tier memory management support.
> > 
> > If the working set of redis can be fit fully into the DRAM node, then
> > the redis will access the fast DRAM only.  Since the performance of DRAM
> > only is faster than partially accessing CXL memory in slow tiers, this
> > environment is not useful to evaluate this patch series.
> > 
> > To make pages of redis be distributed across fast DRAM node and slow
> > CXL node to evaluate our demote and promote actions, we pre-allocate
> > some cold memory externally using mmap and memset before launching
> > redis-server.  We assumed that there are enough amount of cold memory in
> > datacenters as TMO[5] and TPP[6] papers mentioned.
> > 
> > The evaluation sequence is as follows.
> > 
> > 1. Turn on DAMON with DAMOS_DEMOTE action for DRAM node and
> >    DAMOS_PROMOTE action for CXL node.  It demotes cold pages on DRAM
> >    node and promotes hot pages on CXL node in a regular interval.
> > 2. Allocate a huge block of cold memory by calling mmap and memset at
> >    the fast tier DRAM node, then make the process sleep to make the fast
> >    tier has insufficient memory for redis-server.
> > 3. Launch redis-server and load prebaked snapshot image, dump.rdb.  The
> >    redis-server consumes 52GB of anon pages and 33GB of file pages, but
> >    due to the cold memory allocated at 2, it fails allocating the entire
> >    memory of redis-server on the fast tier DRAM node so it partially
> >    allocates the remaining on the slow tier CXL node.  The ratio of
> >    DRAM:CXL depends on the size of the pre-allocated cold memory.
> > 4. Run YCSB to make zipfian or latest distribution of memory accesses to
> >    redis-server, then measure its execution time when it's completed.
> > 5. Repeat 4 over 50 times to measure the average execution time for each
> >    run.
> > 6. Increase the cold memory size then repeat goes to 2.
> > 
> > For each test at 4 took about a minute so repeating it 50 times almost
> > took about 1 hour for each test with a specific cold memory from 440GB
> > to 500GB in 10GB increments for each evaluation.  So it took about more
> > than 10 hours for both zipfian and latest workloads to get the entire
> > evaluation results.  Repeating the same test set multiple times doesn't
> > show much difference so I think it might be enough to make the result
> > reliable.
> > 
> > 
> > Evaluation Results
> > ==================
> > 
> > All the result values are normalized to DRAM-only execution time because
> > the workload cannot be faster than DRAM-only unless the workload hits
> > the bandwidth peak but our redis test doesn't go beyond the bandwidth
> > limit.
> > 
> > So the DRAM-only execution time is the ideal result without affected by
> > the gap between DRAM and CXL performance difference.  The NUMA node
> > environment is as follows.
> > 
> >   node0 - local DRAM, 512GB with a CPU socket (fast tier)
> >   node1 - disabled
> >   node2 - CXL DRAM, 96GB, no CPU attached (slow tier)
> > 
> > The following is the result of generating zipfian distribution to
> > redis-server and the numbers are averaged by 50 times of execution.
> > 
> >   1. YCSB zipfian distribution read only workload
> >   memory pressure with cold memory on node0 with 512GB of local DRAM.
> >   =============+================================================+=========
> >                |       cold memory occupied by mmap and memset  |
> >                |   0G  440G  450G  460G  470G  480G  490G  500G |
> >   =============+================================================+=========
> >   Execution time normalized to DRAM-only values                 | GEOMEAN
> >   -------------+------------------------------------------------+---------
> >   DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
> >   CXL-only     | 1.21     -     -     -     -     -     -     - | 1.21
> >   default      |    -  1.09  1.10  1.13  1.15  1.18  1.21  1.21 | 1.15
> >   DAMON 2-tier |    -  1.02  1.04  1.05  1.04  1.05  1.05  1.06 | 1.04
> >   =============+================================================+=========
> >   CXL usage of redis-server in GB                               | AVERAGE
> >   -------------+------------------------------------------------+---------
> >   DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
> >   CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
> >   default      |    -  19.4  26.1  32.3  38.5  44.7  50.5  50.3 | 37.4
> >   DAMON 2-tier |    -   0.1   1.6   5.2   8.0   9.1  11.8  13.6 |  7.1
> >   =============+================================================+=========
> > 
> > Each test result is based on the exeuction environment as follows.
> > 
> >   DRAM-only   : redis-server uses only local DRAM memory.
> >   CXL-only    : redis-server uses only CXL memory.
> >   default     : default memory policy(MPOL_DEFAULT).
> >                 numa balancing disabled.
> >   DAMON 2-tier: DAMON enabled with DAMOS_DEMOTE for DRAM nodes and
> >                 DAMOS_PROMOTE for CXL nodes.
> > 
> > The above result shows the "default" execution time goes up as the size
> > of cold memory is increased from 440G to 500G because the more cold
> > memory used, the more CXL memory is used for the target redis workload
> > and this makes the execution time increase.
> > 
> > However, "DAMON 2-tier" result shows less slowdown because the
> > DAMOS_DEMOTE action at DRAM node proactively demotes pre-allocated cold
> > memory to CXL node and this free space at DRAM increases more chance to
> > allocate hot or warm pages of redis-server to fast DRAM node.  Moreover,
> > DEMOS_PROMOTE action at CXL node also promotes hot pages of redis-server
> > to DRAM node actively.
> > 
> > As a result, it makes more memory of redis-server stay in DRAM node
> > compared to "default" memory policy and this makes the performance
> > improvement.
> > 
> > The following result of latest distribution workload shows similar data.
> > 
> >   2. YCSB latest distribution read only workload
> >   memory pressure with cold memory on node0 with 512GB of local DRAM.
> >   =============+================================================+=========
> >                |       cold memory occupied by mmap and memset  |
> >                |   0G  440G  450G  460G  470G  480G  490G  500G |
> >   =============+================================================+=========
> >   Execution time normalized to DRAM-only values                 | GEOMEAN
> >   -------------+------------------------------------------------+---------
> >   DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
> >   CXL-only     | 1.18     -     -     -     -     -     -     - | 1.18
> >   default      |    -  1.16  1.15  1.17  1.18  1.16  1.18  1.15 | 1.17
> >   DAMON 2-tier |    -  1.04  1.04  1.05  1.05  1.06  1.05  1.06 | 1.05
> >   =============+================================================+=========
> >   CXL usage of redis-server in GB                               | AVERAGE
> >   -------------+------------------------------------------------+---------
> >   DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
> >   CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
> >   default      |    -  19.3  26.1  32.2  38.5  44.6  50.5  50.6 | 37.4
> >   DAMON 2-tier |    -   1.3   3.8   7.0   4.1   9.4  12.5  16.7 |  7.8
> >   =============+================================================+=========
> > 
> > In summary of both results, our evaluation shows that "DAMON 2-tier"
> > memory management reduces the performance slowdown compared to the
> > "default" memory policy from 15~17% to 4~5% when the system runs with
> > high memory pressure on its fast tier DRAM nodes.
> > 
> > The similar evaluation was done in another machine that has 256GB of
> > local DRAM and 96GB of CXL memory.  The performance slowdown is reduced
> > from 20~24% for "default" to 5~7% for "DAMON 2-tier".
> > 
> > Having these DAMOS_DEMOTE and DAMOS_PROMOTE actions can make 2-tier
> > memory systems run more efficiently under high memory pressures.
> 
> Thank you for running the tests again with the new version of the patches and
> sharing the results!

It's a bit late answer, but the result was from the previous evaluation.
I ran it again with RFC v2, but didn't see much difference so just
pasted the same result here.

> > 
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > 
> > [1] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org
> > [2] https://github.com/skhynix/hmsdk
> > [3] https://github.com/redis/redis/tree/7.0.0
> > [4] https://github.com/brianfrankcooper/YCSB/tree/0.17.0
> > [5] https://dl.acm.org/doi/10.1145/3503222.3507731
> > [6] https://dl.acm.org/doi/10.1145/3582016.3582063
> > 
> > Changes from RFC:
> >   1. Move most of implementation from mm/vmscan.c to mm/damon/paddr.c.
> >   2. Simplify some functions of vmscan.c and used in paddr.c, but need
> >      to be reviewed more in depth.
> >   3. Refactor most functions for common usage for both promote and
> >      demote actions and introduce an enum migration_mode for its control.
> >   4. Add "target_nid" sysfs knob for migration destination node for both
> >      promote and demote actions.
> >   5. Move DAMOS_PROMOTE before DAMOS_DEMOTE and move then even above
> >      DAMOS_STAT.
> 
> Thank you very much for addressing many of my comments.

Thanks for your feedback in details.

> > 
> > Honggyu Kim (3):
> >   mm/damon: refactor DAMOS_PAGEOUT with migration_mode
> >   mm: make alloc_demote_folio externally invokable for migration
> >   mm/damon: introduce DAMOS_DEMOTE action for demotion
> > 
> > Hyeongtak Ji (4):
> >   mm/memory-tiers: add next_promotion_node to find promotion target
> >   mm/damon: introduce DAMOS_PROMOTE action for promotion
> >   mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
> >   mm/damon/sysfs-schemes: apply target_nid for promote and demote
> >     actions
> 
> Honggyu joined DAMON Beer/Coffee/Tea Chat[1] yesterday, and we discussed about
> this patchset in high level.  Sharing the summary here for open discussion.  As
> also discussed on the first version of this patchset[2], we want to make single
> action for general page migration with minimum changes, but would like to keep
> page level access re-check.  We also agreed the previously proposed DAMOS
> filter-based approach could make sense for the purpose.

Thanks very much for the summary.  I have been trying to merge promote
and demote actions into a single migrate action, but I found an issue
regarding damon_pa_scheme_score.  It currently calls damon_cold_score()
for demote action and damon_hot_score() for promote action, but what
should we call when we use a single migrate action?

Thanks,
Honggyu

> Because I was anyway planning making such DAMOS filter for not only
> promotion/demotion but other types of DAMOS action, I will start developing the
> page level access re-check results based DAMOS filter.  Once the implementation
> of the prototype is done, I will share the early implementation.  Then, Honggyu
> will adjust their implementation based on the filter, and run their tests again
> and share the results.
> 
> [1] https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/
> [2] https://lore.kernel.org/damon/20240118171756.80356-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> > 
> >  include/linux/damon.h          |  15 +-
> >  include/linux/memory-tiers.h   |  11 ++
> >  include/linux/migrate_mode.h   |   1 +
> >  include/linux/vm_event_item.h  |   1 +
> >  include/trace/events/migrate.h |   3 +-
> >  mm/damon/core.c                |   5 +-
> >  mm/damon/dbgfs.c               |   2 +-
> >  mm/damon/lru_sort.c            |   3 +-
> >  mm/damon/paddr.c               | 282 ++++++++++++++++++++++++++++++++-
> >  mm/damon/reclaim.c             |   3 +-
> >  mm/damon/sysfs-schemes.c       |  39 ++++-
> >  mm/internal.h                  |   1 +
> >  mm/memory-tiers.c              |  43 +++++
> >  mm/vmscan.c                    |  10 +-
> >  mm/vmstat.c                    |   1 +
> >  15 files changed, 404 insertions(+), 16 deletions(-)
> > 
> > 
> > base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> > -- 
> > 2.34.1

