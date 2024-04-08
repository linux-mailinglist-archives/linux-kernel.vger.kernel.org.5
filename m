Return-Path: <linux-kernel+bounces-135462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4B89C408
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462BE284211
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9DA81751;
	Mon,  8 Apr 2024 13:41:37 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88D6A35A;
	Mon,  8 Apr 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583696; cv=none; b=S3cUHHCRDorVItQ1IKFhrFtbxYKXcFyf6/yuQn6ZSrJaXV848RfROhC4Za6X7URclHJbolHxgB7iixtXGeiteRArL7dbnubcrlNTFrUyRO2CjbMCUUMjPwoOO54E/nvUX4ZK5J2nD3jTChcy6mC0yATUsGug2atI/HD2zxDMmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583696; c=relaxed/simple;
	bh=zTxukDcymNLo4kdv3AYB9kakG77M4JYjFvwcAVkrN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+UeCeebfNlMXGCTSKzodjRynneJ0G6aNvla1xRi1gsMcJM6IL03jDG04vEjc8YURmYxxg0/A1EEuTKmwLvBe08drtPS2ksi3agiiz6KvBVvRDs3hwteWtH3KY0BqTKc6b4afIL7rMRk1GjWGaw7uObVQX+RKHbXdmOBmbEcs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-66-6613f40876fb
From: Honggyu Kim <honggyu.kim@sk.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: sj@kernel.org,
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
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL
Date: Mon,  8 Apr 2024 22:41:04 +0900
Message-ID: <20240408134108.2970-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <ZhAtLhcU3KfT/9i7@memverge.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsXC9ZZnoS7HF+E0g7Y9GhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLBqaHrFYdH5fymJxedccNot7a/6zWhxZf5bFYvPZ
	M8wWi5erWezreMBkcfjrGyaLyZcWsFm8mHKG0eLkrMksFrOP3mN3EPFYevoNm8eGJiCxc9Zd
	do+WfbfYPRZsKvVoOfKW1WPxnpdMHptWdbJ5bPo0id3jxIzfLB47H1p6vNg8k9Fj48f/7B69
	ze/YPD5vkgvgj+KySUnNySxLLdK3S+DK2H56AWvB9LKKg/NusTUwngvuYuTkkBAwkThzfD8L
	jH1g0XYwm01ATeLKy0lMXYwcHCICehIf/3t2MXJxMAusZJHYfncXG0iNsICPxJQ5HewgNouA
	qsSHGRBxXgEziffTljNDzNSUeLz9J1gNp4COxOlf18FsIQEeiVcb9jNC1AtKnJz5BGwvs4C8
	RPPW2cwgyyQETrFLzJ4xDeo4SYmDK26wTGDkn4WkZxaSngWMTKsYhTLzynITM3NM9DIq8zIr
	9JLzczcxAmNxWe2f6B2Mny4EH2IU4GBU4uG1uCqcJsSaWFZcmXuIUYKDWUmEN9hUME2INyWx
	siq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QD4zrmT5OzT66YnNbz
	ZuV7lh/bGfm8Vqo9MLhx95X6Fs//H79ZWZlpNpxrXGS24dxeqUl681dNq3i5qvp/aMz3z4oL
	zHYyfJr0tuqdZzkHexdH9opVq87WKtSpP79QVJVw51/170RN/6AVv+Xq09XORiwKncv1MMX8
	x13htCPpYZm+TexTzX0KApRYijMSDbWYi4oTAc9/WVTBAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXCNUNLT5fji3CawcYvghYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLBqaHrFYdD75zmhxeO5JVovO70tZLC7vmsNmcW/N
	f1aLI+vPslhsPnuG2WLxcjWLQ9ees1rs63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95j
	dxD3WHr6DZvHhiYgsXPWXXaPln232D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3ywe
	Ox9aerzYPJPRY+PH/+wevc3v2Dy+3fbwWPziA1OAYBSXTUpqTmZZapG+XQJXxvbTC1gLppdV
	HJx3i62B8VxwFyMnh4SAicSBRdtZQGw2ATWJKy8nMXUxcnCICOhJfPzv2cXIxcEssJJFYvvd
	XWwgNcICPhJT5nSwg9gsAqoSH2ZAxHkFzCTeT1vODDFTU+Lx9p9gNZwCOhKnf10Hs4UEeCRe
	bdjPCFEvKHFy5hOwvcwC8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq9
	5PzcTYzAaFtW+2fiDsYvl90PMQpwMCrx8DrcEU4TYk0sK67MPcQowcGsJMIbbCqYJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cAY80VYyexGv8H9yw2v
	3xytYXvV1h+o9ass/OqMX1388zNvOfRqRvxPmrE5+8dl9pmMa3XOp/y4efKK0NLAxvdn7syR
	X+qxQEM/d5PK+6Av4vstm8L+1h381i4s9bJBqnqtm+aOBZf9DxRdjfz45/ibJUn2kYaVgiUH
	T105F5c27QD3ootXfSValFiKMxINtZiLihMBXWtiZLICAAA=
X-CFilter-Loop: Reflected

Hi Gregory,

On Fri, 5 Apr 2024 12:56:14 -0400 Gregory Price <gregory.price@memverge.com> wrote:
> On Fri, Apr 05, 2024 at 03:08:49PM +0900, Honggyu Kim wrote:
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
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
> >   CXL-only     | 1.22     -     -     -     -     -     -     - | 1.22
> >   default      |    -  1.12  1.13  1.14  1.16  1.19  1.21  1.21 | 1.17 
> >   DAMON tiered |    -  1.04  1.03  1.04  1.06  1.05  1.05  1.05 | 1.05 
> >   =============+================================================+=========
> >   CXL usage of redis-server in GB                               | AVERAGE
> >   -------------+------------------------------------------------+---------
> >   DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
> >   CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
> >   default      |    -  20.4  27.0  33.1  39.5  45.6  50.5  50.3 | 38.1
> >   DAMON tiered |    -   0.1   0.3   0.8   0.6   0.7   1.3   0.9 |  0.7
> >   =============+================================================+=========
> > 
> > Each test result is based on the exeuction environment as follows.
> > 
> >   DRAM-only   : redis-server uses only local DRAM memory.
> >   CXL-only    : redis-server uses only CXL memory.
> >   default     : default memory policy(MPOL_DEFAULT).
> >                 numa balancing disabled.
> >   DAMON tiered: DAMON enabled with DAMOS_MIGRATE_COLD for DRAM nodes and
> >                 DAMOS_MIGRATE_HOT for CXL nodes.
> > 
> > The above result shows the "default" execution time goes up as the size
> > of cold memory is increased from 440G to 500G because the more cold
> > memory used, the more CXL memory is used for the target redis workload
> > and this makes the execution time increase.
> > 
> > However, "DAMON tiered" result shows less slowdown because the
> > DAMOS_MIGRATE_COLD action at DRAM node proactively demotes pre-allocated
> > cold memory to CXL node and this free space at DRAM increases more
> > chance to allocate hot or warm pages of redis-server to fast DRAM node.
> > Moreover, DAMOS_MIGRATE_HOT action at CXL node also promotes hot pages
> > of redis-server to DRAM node actively.
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
> >   default      |    -  1.18  1.19  1.18  1.18  1.17  1.19  1.18 | 1.18 
> >   DAMON tiered |    -  1.04  1.04  1.04  1.05  1.04  1.05  1.05 | 1.04 
> >   =============+================================================+=========
> >   CXL usage of redis-server in GB                               | AVERAGE
> >   -------------+------------------------------------------------+---------
> >   DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
> >   CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
> >   default      |    -  20.5  27.1  33.2  39.5  45.5  50.4  50.5 | 38.1
> >   DAMON tiered |    -   0.2   0.4   0.7   1.6   1.2   1.1   3.4 |  1.2
> >   =============+================================================+=========
> > 
> > In summary of both results, our evaluation shows that "DAMON tiered"
> > memory management reduces the performance slowdown compared to the
> > "default" memory policy from 17~18% to 4~5% when the system runs with
> > high memory pressure on its fast tier DRAM nodes.
> > 
> > Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
> > tiered memory systems run more efficiently under high memory pressures.
> > 
> 
> Hi,
> 
> It's hard to determine from your results whether the performance
> mitigation is being caused primarily by MIGRATE_COLD freeing up space
> for new allocations, or from some combination of HOT/COLD actions
> occurring during execution but after the database has already been
> warmed up.

Thanks for the question.  I didn't include all the details for the
evaluation result, but this is a chance to share more in details.

I would say the mitigation comes from both.  DAMOS_MIGRATE_COLD demotes
some cold data to CXL so redis can allocate more data on the fast DRAM
during launching time as the mmap+memset and redis launching takes
several minutes.  But it also promotes some redis data while running.

> Do you have test results which enable only DAMOS_MIGRATE_COLD actions
> but not DAMOS_MIGRATE_HOT actions? (and vice versa)
> 
> The question I have is exactly how often is MIGRATE_HOT actually being
> utilized, and how much data is being moved. Testing MIGRATE_COLD only
> would at least give a rough approximation of that.

To explain this, I better share more test results.  In the section of
"Evaluation Workload", the test sequence can be summarized as follows.

  *. "Turn on DAMON."
  1. Allocate cold memory(mmap+memset) at DRAM node, then make the
     process sleep.
  2. Launch redis-server and load prebaked snapshot image, dump.rdb.
     (85GB consumed: 52GB for anon and 33GB for file cache)
  3. Run YCSB to make zipfian distribution of memory accesses to
     redis-server, then measure execution time.
  4. Repeat 4 over 50 times to measure the average execution time for
     each run.
  5. Increase the cold memory size then repeat goes to 2.

I didn't want to make the evaluation too long in the cover letter, but
I have also evaluated another senario, which lazyly enabled DAMON just
before YCSB run at step 4.  I will call this test as "DAMON lazy".  This
is missing part from the cover letter.

  1. Allocate cold memory(mmap+memset) at DRAM node, then make the
     process sleep.
  2. Launch redis-server and load prebaked snapshot image, dump.rdb.
     (85GB consumed: 52GB for anon and 33GB for file cache)
  *. "Turn on DAMON."
  4. Run YCSB to make zipfian distribution of memory accesses to
     redis-server, then measure execution time.
  5. Repeat 4 over 50 times to measure the average execution time for
     each run.
  6. Increase the cold memory size then repeat goes to 2.

In the "DAMON lazy" senario, DAMON started monitoring late so the
initial redis-server placement is same as "default", but started to
demote cold data and promote redis data just before YCSB run.

The full test result is as follows.

  1. YCSB zipfian distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  =============+================================================+=========
               |       cold memory occupied by mmap and memset  |
               |   0G  440G  450G  460G  470G  480G  490G  500G |
  =============+================================================+=========
  Execution time normalized to DRAM-only values                 | GEOMEAN
  -------------+------------------------------------------------+---------
  DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only     | 1.22     -     -     -     -     -     -     - | 1.22
  default      |    -  1.12  1.13  1.14  1.16  1.19  1.21  1.21 | 1.17
  DAMON tiered |    -  1.04  1.03  1.04  1.06  1.05  1.05  1.05 | 1.05
  DAMON lazy   |    -  1.04  1.05  1.05  1.06  1.06  1.07  1.07 | 1.06
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  20.4  27.0  33.1  39.5  45.6  50.5  50.3 | 38.1
  DAMON tiered |    -   0.1   0.3   0.8   0.6   0.7   1.3   0.9 |  0.7
  DAMON lazy   |    -   2.9   3.1   3.7   4.7   6.6   8.2   9.7 |  5.6
  =============+================================================+=========
  Migration size in GB by DAMOS_MIGRATE_COLD(demotion) and      |
  DAMOS_MIGRATE_HOT(promotion)                                  | AVERAGE
  -------------+------------------------------------------------+---------
  DAMON tiered |                                                |
  - demotion   |    -   522   510   523   520   513   558   558 |  529
  - promotion  |    -   0.1   1.3   6.2   8.1   7.2    22    17 |  8.8
  DAMON lazy   |                                                |
  - demotion   |    -   288   277   322   343   315   312   320 |  311
  - promotion  |    -    33    44    41    55    73    89   101 |  5.6
  =============+================================================+=========

I have included "DAMON lazy" result and also the migration size by new
DAMOS migrate actions.  Please note that demotion size is way higher
than promotion because promotion target is only for redis data, but
demotion target includes huge cold memory allocated by mmap + memset.
(there could be some ping-pong issue though.)

As you mentioned, "DAMON tiered" case gets more benefit because new
redis allocations go to DRAM more than "default", but it also gets
benefit from promotion when it is under higher memory pressure as shown
in 490G and 500G cases.  It promotes 22GB and 17GB of redis data to DRAM
from CXL.

In the case of "DAMON lazy", it shows more promotion size as expected
and it gets increases as memory pressure goes higher from left to right.

I will share "latest" workload result as well and it shows similar
tendency.

  2. YCSB latest distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  =============+================================================+=========
               |       cold memory occupied by mmap and memset  |
               |   0G  440G  450G  460G  470G  480G  490G  500G |
  =============+================================================+=========
  Execution time normalized to DRAM-only values                 | GEOMEAN
  -------------+------------------------------------------------+---------
  DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only     | 1.18     -     -     -     -     -     -     - | 1.18
  default      |    -  1.18  1.19  1.18  1.18  1.17  1.19  1.18 | 1.18 
  DAMON tiered |    -  1.04  1.04  1.04  1.05  1.04  1.05  1.05 | 1.04 
  DAMON lazy   |    -  1.05  1.05  1.06  1.06  1.07  1.06  1.07 | 1.06
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  20.5  27.1  33.2  39.5  45.5  50.4  50.5 | 38.1
  DAMON tiered |    -   0.2   0.4   0.7   1.6   1.2   1.1   3.4 |  1.2
  DAMON lazy   |    -   5.3   4.1   3.9   6.4   8.8  10.1  11.3 |  7.1
  =============+================================================+=========
  Migration size in GB by DAMOS_MIGRATE_COLD(demotion) and      |
  DAMOS_MIGRATE_HOT(promotion)                                  | AVERAGE
  -------------+------------------------------------------------+---------
  DAMON tiered |                                                |
  - demotion   |    -   493   478   487   516   510   540   512 |  505
  - promotion  |    -   0.1   0.2   8.2   5.6   4.0   5.9    29 |  7.5
  DAMON lazy   |                                                |
  - demotion   |    -   315   318   293   290   308   322   286 |  305
  - promotion  |    -    36    45    38    56    74    91    99 |   63
  =============+================================================+=========

> Additionally, do you have any data on workloads that exceed the capacity
> of the DRAM tier?  Here you say you have 512GB of local DRAM, but only
> test a workload that caps out at 500G.  Have you run a test of, say,
> 550GB to see the effect of DAMON HOT/COLD migration actions when DRAM
> capacity is exceeded?

I didn't want to remove DRAM from my server so kept using 512GB of DRAM,
but I couldn't make a single workload that consumes more than the DRAM
size.

I wanted to use more realistic workload rather than micro benchmarks.
And the core concept of this test is to cover realisitic senarios with
the system wide view.  I think if the system has 512GB of local DRAM,
then it wouldn't be possible to make the entire 512GB of DRAM hot and
it'd have some amount of cold memory, which can be the target of
demotion.  Then we can find some workload that is actively used and
promote it as much as possible.  That's why I made the promotion policy
aggressively.

> Can you also provide the DRAM-only results for each test?  Presumably,
> as workload size increases from 440G to 500G, the system probably starts
> using some amount of swap/zswap/whatever.  It would be good to know how
> this system compares to swap small amounts of overflow.

It looks like my explanation doesn't correctly inform you.   The size
from 440GB to 500GB is for pre allocated cold data to give memory
pressure on the system so that redis-server cannot be fully allocated at
fast DRAM, then partially allocated at CXL memory as well.

And my evaluation environment doesn't have swap space to focus on
migration rather than swap.

> 
> ~Gregory

I hope my explanation is helpful for you to understand.  Please let me
know if you have more questions.

Thanks,
Honggyu


