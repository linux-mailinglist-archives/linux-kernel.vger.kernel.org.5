Return-Path: <linux-kernel+bounces-137845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCC89E838
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E517D28827B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDBBE49;
	Wed, 10 Apr 2024 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUaGherb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B4BA2E;
	Wed, 10 Apr 2024 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716377; cv=none; b=gV02vnribvfa6JJrzvm4ZwEYh0yHrmHMvsFA5LZIvdz7S/LoK9dw87vQ4lG3XlQIQoACTV9SidHeinU2Nk4mFew5wxmfiU7A4HzD6SAQ0bzxO/SznqeTYpeLuSqPzzqOY4zCNL2WwNi5BnY9uNevsHVXn3IpifW/ngpMw25NeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716377; c=relaxed/simple;
	bh=ScsLn2QVzQBveqF59yy04O8I8ch6/UBRUmnuXTuXCkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAX7hhy1WLBch5qhceKBehjpDbznJKsTAzsSIntnmXtfa+8F939LBwlZNjLufnz60ej7VBKKdiL6ZhrZLj1HuZ8j5xilpeVRpuW101pfPHaqvncN+yilDlWLonTPJ2Sp5rU1hgccnvv7KDCLretP7/HaOMUPCRSzJQNV7nMIwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUaGherb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712716375; x=1744252375;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ScsLn2QVzQBveqF59yy04O8I8ch6/UBRUmnuXTuXCkY=;
  b=bUaGherb9LYUqVAhsBhk7X0ZgR8zH61kAkZseSINgUUY4QzwduUctQNz
   2NUes+vRSLtHUKAPsb8regUXgaOjZjYrJcAaLmGDqXLzMUTuTCz3H3NjV
   UeiZuC6gAI/Yzev/lLASmSGOw6+oGuuLlorQmuJ+Uluw3NGolNsT7M5ZD
   dE6cbdhlSTXj+4P8FhlohozZ5Ow4TRl/uefy5UgCtn9cej5qUJVKpTrHZ
   sDiCyF3G7YsE/BkNoVuYBQPgKb1Z2JvOB1ZGUEWERVgH/Frb8uga44rRJ
   tEDxHO/5zQOMoGyqc61/X3LUOeUZIfakIFxqF7WV3zKKu+19WDHXd5d+Y
   g==;
X-CSE-ConnectionGUID: 1KIjWQzXTCep5l9gJL14Kw==
X-CSE-MsgGUID: D+XzXz3mR6a7wbTBw+pceA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11834436"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11834436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:32:55 -0700
X-CSE-ConnectionGUID: vqaprlaOT1+aD0p8Oc9Q3w==
X-CSE-MsgGUID: C0kf41mLSwerSyvWdpaN6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20482433"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:32:49 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Gregory Price
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
  mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  Alistair Popple <apopple@nvidia.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  SeongJae Park <sj@kernel.org>,  Dan Williams
 <dan.j.williams@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Dave Jiang <dave.jiang@intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  nvdimm@lists.linux.dev,
  linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,  Linux Memory
 Management List <linux-mm@kvack.org>,  "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
  qemu-devel@nongnu.org,  Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
In-Reply-To: <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
	(Ho-Ren Chuang's message of "Fri, 5 Apr 2024 15:43:47 -0700")
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
	<20240405000707.2670063-3-horenchuang@bytedance.com>
	<20240405150244.00004b49@Huawei.com>
	<CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
Date: Wed, 10 Apr 2024 10:30:56 +0800
Message-ID: <87ttka54pr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>>
>> On Fri,  5 Apr 2024 00:07:06 +0000
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>>
>> > The current implementation treats emulated memory devices, such as
>> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal m=
emory
>> > (E820_TYPE_RAM). However, these emulated devices have different
>> > characteristics than traditional DRAM, making it important to
>> > distinguish them. Thus, we modify the tiered memory initialization pro=
cess
>> > to introduce a delay specifically for CPUless NUMA nodes. This delay
>> > ensures that the memory tier initialization for these nodes is deferred
>> > until HMAT information is obtained during the boot process. Finally,
>> > demotion tables are recalculated at the end.
>> >
>> > * late_initcall(memory_tier_late_init);
>> > Some device drivers may have initialized memory tiers between
>> > `memory_tier_init()` and `memory_tier_late_init()`, potentially bringi=
ng
>> > online memory nodes and configuring memory tiers. They should be exclu=
ded
>> > in the late init.
>> >
>> > * Handle cases where there is no HMAT when creating memory tiers
>> > There is a scenario where a CPUless node does not provide HMAT informa=
tion.
>> > If no HMAT is specified, it falls back to using the default DRAM tier.
>> >
>> > * Introduce another new lock `default_dram_perf_lock` for adist calcul=
ation
>> > In the current implementation, iterating through CPUlist nodes requires
>> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will en=
d up
>> > trying to acquire the same lock, leading to a potential deadlock.
>> > Therefore, we propose introducing a standalone `default_dram_perf_lock=
` to
>> > protect `default_dram_perf_*`. This approach not only avoids deadlock
>> > but also prevents holding a large lock simultaneously.
>> >
>> > * Upgrade `set_node_memory_tier` to support additional cases, including
>> >   default DRAM, late CPUless, and hot-plugged initializations.
>> > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
>> > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` =
to
>> > handle cases where memtype is not initialized and where HMAT informati=
on is
>> > available.
>> >
>> > * Introduce `default_memory_types` for those memory types that are not
>> >   initialized by device drivers.
>> > Because late initialized memory and default DRAM memory need to be man=
aged,
>> > a default memory type is created for storing all memory types that are
>> > not initialized by device drivers and as a fallback.
>> >
>> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>
>> Hi - one remaining question. Why can't we delay init for all nodes
>> to either drivers or your fallback late_initcall code.
>> It would be nice to reduce possible code paths.
>
> I try not to change too much of the existing code structure in
> this patchset.
>
> To me, postponing/moving all memory tier registrations to
> late_initcall() is another possible action item for the next patchset.
>
> After tier_mem(), hmat_init() is called, which requires registering
> `default_dram_type` info. This is when `default_dram_type` is needed.
> However, it is indeed possible to postpone the latter part,
> set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> indeed be split into two parts, and the latter part can be moved to
> late_initcall() to be processed together.

I don't think that it's good to move all memory_tier initialization in
drivers to late_initcall().  It's natural to keep them in
device_initcall() level.

If so, we can allocate default_dram_type in memory_tier_init(), and call
set_node_memory_tier() only in memory_tier_lateinit().  We can call
memory_tier_lateinit() in device_initcall() level too.

--
Best Regards,
Huang, Ying

> Doing this all memory-type drivers have to call late_initcall() to
> register a memory tier. I=E2=80=99m not sure how many they are?
>
> What do you guys think?
>
>>
>> Jonathan
>>
>>
>> > ---
>> >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++------------
>> >  1 file changed, 70 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> > index 516b144fd45a..6632102bd5c9 100644
>> > --- a/mm/memory-tiers.c
>> > +++ b/mm/memory-tiers.c
>>
>>
>>
>> > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
>> >        * For now we can have 4 faster memory tiers with smaller adista=
nce
>> >        * than default DRAM tier.
>> >        */
>> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
>> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANC=
E_DRAM,
>> > +                                                   &default_memory_ty=
pes);
>> >       if (IS_ERR(default_dram_type))
>> >               panic("%s() failed to allocate default DRAM tier\n", __f=
unc__);
>> >
>> > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
>> >        * types assigned.
>> >        */
>> >       for_each_node_state(node, N_MEMORY) {
>> > +             if (!node_state(node, N_CPU))
>> > +                     /*
>> > +                      * Defer memory tier initialization on
>> > +                      * CPUless numa nodes. These will be initialized
>> > +                      * after firmware and devices are initialized.
>>
>> Could the comment also say why we can't defer them all?
>>
>> (In an odd coincidence we have a similar issue for some CPU hotplug
>>  related bring up where review feedback was move all cases later).
>>
>> > +                      */
>> > +                     continue;
>> > +
>> >               memtier =3D set_node_memory_tier(node);
>> >               if (IS_ERR(memtier))
>> >                       /*
>>

