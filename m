Return-Path: <linux-kernel+bounces-64503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F9853FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E43282B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCDF629F7;
	Tue, 13 Feb 2024 23:03:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3376280B;
	Tue, 13 Feb 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865381; cv=none; b=jhNXvDDrdO1RcRg1FympqdC0bsv931hcXdOY1l9zrsOabqWLNdCBJH684SrmCUXlolV4SjIm3NW1rDw02SKJB74mBdCsAXT4lgRQcH14K39agDrA2LF5jVuhpl6n13SGWZPDdpVLDacL9QwJvZTDvMIlQtCWhIPHtxho5BPiTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865381; c=relaxed/simple;
	bh=OJ0p45/u+iQ1A9FdK/Chkglpl9TGkCxwoKgl4PhkCyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phs4k82Ydv9Ev30XLhkk1EPTqb58jXusmJEZCBU4jAjgWcck8Q5U/af/3FTzkuqewddRCAo3d60SFG9xPeBko7BBrmmL29lsvtsXyEkNFC2XE1VO0lY/mBAbfx8f6YVfkoemfZV2qDoyLxmSMXDsJVWwabRLjVzoZ+N2/HfpSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD1541FB;
	Tue, 13 Feb 2024 15:03:32 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4FE93F7B4;
	Tue, 13 Feb 2024 15:02:50 -0800 (PST)
Date: Tue, 13 Feb 2024 23:02:49 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: "lihuisong (C)" <lihuisong@huawei.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	sumitg@nvidia.com, zengheng4@huawei.com,
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com,
	liuyonglong@huawei.com, zhanjie9@hisilicon.com,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
Message-ID: <Zcv1GXN711uI6ykr@arm.com>
References: <9428a1ed-ba4d-1fe6-63e8-11e152bf1f09@huawei.com>
 <lnocwcitdbmgcyhd2dlczgdlhtfw4pfot2br2i3hqscnvr3xgq@nuxlauxum3nr>
 <d0f47e9d-6a58-8b46-89be-b3182abb69f0@huawei.com>
 <ZZwAmqp6hcmMF8aN@arm.com>
 <6505bdcb-5a5f-cba6-483b-75c51414a9c6@huawei.com>
 <ZaaOQzCpBjmW71xf@e129154.nice.arm.com>
 <a84a9749-97a5-a207-dfd3-8322a5a992d9@huawei.com>
 <Zbyi40XtqbqXm0CL@e129154.nice.arm.com>
 <4f66c62e-b089-a125-5a8d-4a98d4181618@huawei.com>
 <ZcYEjMO7IhSaLAAF@e129154.nice.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcYEjMO7IhSaLAAF@e129154.nice.arm.com>

Hi,

On Friday 09 Feb 2024 at 11:55:08 (+0100), Beata Michalska wrote:
> On Tue, Feb 06, 2024 at 04:02:15PM +0800, lihuisong (C) wrote:
[..]
> > > > > > 
> > > > > > > Would you be able to test [1] on your platform and usecase?
> > > > > > I has tested it on my platform (CPU number: 64, SMT: off and CPU base
> > > > > > frequency: 2.7GHz).
> > > > > > Accoding to the testing result,
> > > > > > 1> I found that patch [1] and [2] cannot cover the no housekeeping CPUs.
> > > > > > They still have to face the large frequency discrepancy issue my patch
> > > > > > mentioned.
> > > > > > 2> Additionally, the frequency value of all CPUs are almost the same by
> > > > > > using the 'arch_freq_scale' factor way. I'm not sure if it is ok.
> > > > > > 
> > > > > > The patch [1] has been modified silightly as below:
> > > > > > -->
> > > > > > @@ -1756,7 +1756,10 @@ static unsigned int
> > > > > > cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> > > > > >    {
> > > > > >           unsigned int new_freq;
> > > > > > 
> > > > > > -       new_freq = cpufreq_driver->get(policy->cpu);
> > > > > > +       new_freq = arch_freq_get_on_cpu(policy->cpu);
> > > > > > +       if (!new_freq)
> > > > > > +               new_freq = cpufreq_driver->get(policy->cpu);
> > > > > > +
> > > > > As pointed out this change will not make it to the next version of the patch.
> > > > > So I'd say you can safely ignore it and assume that arch_freq_get_on_cpu will
> > > > > only be wired for sysfs nodes for scaling_cur_freq/cpuinfo_cur_freq
> > > > > >           if (!new_freq)
> > > > > >                   return 0;
> > > > > > 
> > > > > > And the result is as follows:
> > > > > > *case 1:**No setting the nohz_full and cpufreq use performance governor*
> > > > > > *--> Step1: *read 'cpuinfo_cur_freq' in no pressure
> > > > > >     0: 2699264     2: 2699264     4: 2699264     6: 2699264
> > > > > >     8: 2696628    10: 2696628    12: 2696628    14: 2699264
> > > > > >    16: 2699264    18: 2696628    20: 2699264    22: 2696628
> > > > > >    24: 2699264    26: 2696628    28: 2699264    30: 2696628
> > > > > >    32: 2696628    34: 2696628    36: 2696628    38: 2696628
> > > > > >    40: 2699264    42: 2699264    44: 2696628    46: 2696628
> > > > > >    48: 2696628    50: 2699264    52: 2699264    54: 2696628
> > > > > >    56: 2696628    58: 2696628    60: 2696628    62: 2696628
> > > > > >    64: 2696628    66: 2699264    68: 2696628    70: 2696628
> > > > > >    72: 2699264    74: 2696628    76: 2696628    78: 2699264
> > > > > >    80: 2696628    82: 2696628    84: 2699264    86: 2696628
> > > > > >    88: 2696628    90: 2696628    92: 2696628    94: 2699264
> > > > > >    96: 2696628    98: 2699264   100: 2699264   102: 2696628
> > > > > > 104: 2699264   106: 2699264   108: 2699264   110: 2696628
> > > > > > 112: 2699264   114: 2699264   116: 2699264   118: 2699264
> > > > > > 120: 2696628   122: 2699264   124: 2696628   126: 2699264
> > > > > > Note: the frequency of all CPUs are almost the same.
> > > > > Were you expecting smth else ?
> > > > The frequency of each CPU might have a different value.
> > > > All value of all CPUs is the same under high pressure.
> > > > I don't know what the phenomenon is on other platform.
> > > > Do you know who else tested it?
> > > So I might have rushed a bit with my previous comment/question: apologies for
> > > that.
> > > The numbers above: those are on a fairly idle/lightly loaded system right?
> > Yes.
> > > Would you mind having another go with just the arch_freq_get_on_cpu
> > > implementation beign added and dropping the changes in the cpufreq and
> > All my tests are done when cpufreq policy is "performance" and OS isn't on a
> > high load.
> > Reading "scaling_cur_freq" or "scaling_cur_freq" for each physical core on
> > platform
> > 
> > The testing result for "cpuinfo_cur_freq" with your changes on a fairly idle
> > and high loaded system can also be found in this thread.
> > *A: the result with your changes*
> > --> Reading "scaling_cur_freq"
> >   0: 2688720     2: 2696628     4: 2699264     6: 2696628
> >   8: 2699264    10: 2696628    12: 2699264    14: 2699264
> >  16: 2699264    18: 2696628    20: 2696628    22: 2696628
> >  24: 2699264    26: 2696628    28: 2696628    30: 2696628
> >  32: 2699264    34: 2691356    36: 2696628    38: 2699264
> >  40: 2699264    42: 2696628    44: 2696628    46: 2699264
> >  48: 2699264    50: 2696628    52: 2696628    54: 2696628
> >  56: 2696628    58: 2699264    60: 2691356    62: 2696628
> >  64: 2696628    66: 2696628    68: 2696628    70: 2696628
> >  72: 2696628    74: 2696628    76: 2699264    78: 2696628
> >  80: 2696628    82: 2696628    84: 2699264    86: 2696628
> >  88: 2625456    90: 2696628    92: 2699264    94: 2696628
> >  96: 2696628    98: 2696628   100: 2699264   102: 2699264
> > 104: 2699264   106: 2696628   108: 2699264   110: 2696628
> > 112: 2699264   114: 2699264   116: 2696628   118: 2696628
> > 120: 2696628   122: 2699264   124: 2696628   126: 2696628
> > -->Reading  "cpuinfo_cur_freq"
> >   0: 2696628     2: 2696628     4: 2699264     6: 2688720
> >   8: 2699264    10: 2700000    12: 2696628    14: 2698322
> >  16: 2699264    18: 2699264    20: 2696628    22: 2699264
> >  24: 2699264    26: 2699264    28: 2699264    30: 2699264
> >  32: 2699264    34: 2693992    36: 2696628    38: 2696628
> >  40: 2699264    42: 2699264    44: 2699264    46: 2696628
> >  48: 2696628    50: 2699264    52: 2696628    54: 2696628
> >  56: 2699264    58: 2699264    60: 2696628    62: 2699264
> >  64: 2696628    66: 2699264    68: 2696628    70: 2699264
> >  72: 2696628    74: 2696628    76: 2696628    78: 2693992
> >  80: 2696628    82: 2696628    84: 2696628    86: 2696628
> >  88: 2696628    90: 2699264    92: 2696628    94: 2699264
> >  96: 2699264    98: 2696628   100: 2699264   102: 2699264
> > 104: 2691356   106: 2699264   108: 2699264   110: 2699264
> > 112: 2699264   114: 2696628   116: 2699264   118: 2699264
> > 120: 2696628   122: 2696628   124: 2696628   126: 2696628
> > 
> > *B: the result without your changes*
> > -->Reading "scaling_cur_freq"
> >   0: 2698245     2: 2706690     4: 2699649     6: 2702105
> >   8: 2704362    10: 2697993    12: 2701672    14: 2704362
> >  16: 2701052    18: 2701052    20: 2694385    22: 2699650
> >  24: 2706802    26: 2702389    28: 2698299    30: 2698299
> >  32: 2697333    34: 2697993    36: 2701337    38: 2699328
> >  40: 2700330    42: 2700330    44: 2698019    46: 2697697
> >  48: 2699659    50: 2701700    52: 2703401    54: 2701700
> >  56: 2704013    58: 2697658    60: 2695000    62: 2697666
> >  64: 2697902    66: 2701052    68: 2698245    70: 2695789
> >  72: 2701315    74: 2696655    76: 2693666    78: 2695317
> >  80: 2704912    82: 2699649    84: 2698245    86: 2695454
> >  88: 2697966    90: 2697959    92: 2699319    94: 2700680
> >  96: 2695317    98: 2698996   100: 2700000   102: 2700334
> > 104: 2701320   106: 2695065   108: 2700986   110: 2703960
> > 112: 2697635   114: 2704421   116: 2700680   118: 2702040
> > 120: 2700334   122: 2697993   124: 2700334   126: 2705351
> > -->Reading "cpuinfo_cur_freq"
> >   0: 2696853     2: 2695454     4: 2699649     6: 2706993
> >   8: 2706060    10: 2704362    12: 2704362    14: 2697658
> >  16: 2707719    18: 2697192    20: 2702456    22: 2699650
> >  24: 2705782    26: 2698299    28: 2703061    30: 2705802
> >  32: 2700000    34: 2700671    36: 2701337    38: 2697658
> >  40: 2700330    42: 2700330    44: 2699672    46: 2697697
> >  48: 2703061    50: 2696610    52: 2692542    54: 2704406
> >  56: 2695317    58: 2699331    60: 2698996    62: 2702675
> >  64: 2704912    66: 2703859    68: 2699649    70: 2698596
> >  72: 2703908    74: 2703355    76: 2697658    78: 2695317
> >  80: 2702105    82: 2707719    84: 2702105    86: 2699649
> >  88: 2697966    90: 2691525    92: 2701700    94: 2700680
> >  96: 2695317    98: 2698996   100: 2698666   102: 2700334
> > 104: 2690429   106: 2707590   108: 2700986   110: 2701320
> > 112: 2696283   114: 2692881   116: 2697627   118: 2704421
> > 120: 2698996   122: 2696321   124: 2696655   126: 2695000
> >
> So in both cases : whether you use arch_freq_get_on_cpu or not
> (so with and without the patch) you get roughly the same frequencies
> on all cores - or am I missing smth from the dump above ?
> And those are reflecting max freq you have provided earlier (?)
> Note that the arch_freq_get_on_cpu will return an average frequency for
> the last tick, so even if your system is roughly idle with your performance
> governor those numbers make sense (some/most of the cores might be idle
> but you will see the last freq the core was running at before going to idle).
> I do not think there is an agreement what should be shown for idle core when
> querying their freq through sysfs. Showing last known freq makes sense, even
> more than waking up core just to try to get one.
> 
> @Ionela: Please jump in if I got things wrong.

Yes, that's how I see things as well. When using the performance
governor, when the CPU is active, the frequency of the CPU should be the
maximum one (unless there has been firmware/hardware capping) and that
would be reflected by cpuinfo_cur_freq, either through the use of the
frequency scale factor (based on the samples on the last tick)  or the
driver's .get() function (having woken up the CPU to sample the
counters).

So the values above look alright to me.

Thanks,
Ionela.

> 
> > > then read 'scaling_cur_freq', doing several reads in some intervals ?
> > It seems that above phenomenon has not a lot to do with reading intervals.
> > > The change has been tested on RD-N2 model (Neoverse N2 ref platform),
> > > it has also been discussed here [1]
> > I doesn't get the testing result on this platform in its thread.
> It might be missing exact numbers but the conclusions should be here [1]
> 
> > > > > > *--> Step 2: *read 'cpuinfo_cur_freq' in the high memory access pressure.
> > > > > >     0: 2696628     2: 2696628     4: 2696628     6: 2696628
> > > > > >     8: 2696628    10: 2696628    12: 2696628    14: 2696628
> > > > > >    16: 2696628    18: 2696628    20: 2696628    22: 2696628
> > > > > >    24: 2696628    26: 2696628    28: 2696628    30: 2696628
> > > > > >    32: 2696628    34: 2696628    36: 2696628    38: 2696628
> > > > > >    40: 2696628    42: 2696628    44: 2696628    46: 2696628
> > > > > >    48: 2696628    50: 2696628    52: 2696628    54: 2696628
> > > > > >    56: 2696628    58: 2696628    60: 2696628    62: 2696628
> > > > > >    64: 2696628    66: 2696628    68: 2696628    70: 2696628
> > > > > >    72: 2696628    74: 2696628    76: 2696628    78: 2696628
> > > > > >    80: 2696628    82: 2696628    84: 2696628    86: 2696628
> > > > > >    88: 2696628    90: 2696628    92: 2696628    94: 2696628
> > > > > >    96: 2696628    98: 2696628   100: 2696628   102: 2696628
> > > > > > 104: 2696628   106: 2696628   108: 2696628   110: 2696628
> > > > > > 112: 2696628   114: 2696628   116: 2696628   118: 2696628
> > > > > > 120: 2696628   122: 2696628   124: 2696628   126: 2696628
> > > > > > 
> > > > > > *Case 2: setting nohz_full and cpufreq use ondemand governor*
> > > > > > There is "isolcpus=1-10,41-50 nohz_full=1-10,41-50 rcu_nocbs=1-10,41-50" in
> > > > > > /proc/cmdline.
> > > > > Right, so if I remember correctly nohz_full implies rcu_nocbs, so no need to
> > > > > set that one.
> > > > > Now, afair, isolcpus will make the selected CPUs to disappear from the
> > > > > schedulers view (no balancing, no migrating), so unless you affine smth
> > > > > explicitly to those CPUs, you will not see much of an activity there.
> > > > Correct.
> > > > > Need to double check though as it has been a while ...
> > > > > > *--> Step 1: *setting ondemand governor to all policy and query
> > > > > > 'cpuinfo_cur_freq' in no pressure case.
> > > > > > And the frequency of CPUs all are about 400MHz.
> > > > > > *--> Step 2:* read 'cpuinfo_cur_freq' in the high memory access pressure.
> > > > > > The high memory access pressure is from the command: "stress-ng -c 64
> > > > > > --cpu-load 100% --taskset 0-63"
> > > > > I'm not entirely convinced that this will affine to isolated cpus, especially
> > > > > that the affinity mask spans all available cpus. If that is the case, no wonder
> > > > > your isolated cpus are getting wasted being idle. But I would have to double
> > > > > check how this is being handled.
> > > > > > The result:
> > > > > >    0: 2696628     1:  400000     2:  400000     3:  400909
> > > > > >    4:  400000     5:  400000     6:  400000     7:  400000
> > > > > >    8:  400000     9:  400000    10:  400600    11: 2696628
> > > > > > 12: 2696628    13: 2696628    14: 2696628    15: 2696628
> > > > > > 16: 2696628    17: 2696628    18: 2696628    19: 2696628
> > > > > > 20: 2696628    21: 2696628    22: 2696628    23: 2696628
> > > > > > 24: 2696628    25: 2696628    26: 2696628    27: 2696628
> > > > > > 28: 2696628    29: 2696628    30: 2696628    31: 2696628
> > > > > > 32: 2696628    33: 2696628    34: 2696628    35: 2696628
> > > > > > 36: 2696628    37: 2696628    38: 2696628    39: 2696628
> > > > > > 40: 2696628    41:  400000    42:  400000    43:  400000
> > > > > > 44:  400000    45:  398847    46:  400000    47:  400000
> > > > > > 48:  400000    49:  400000    50:  400000    51: 2696628
> > > > > > 52: 2696628    53: 2696628    54: 2696628    55: 2696628
> > > > > > 56: 2696628    57: 2696628    58: 2696628    59: 2696628
> > > > > > 60: 2696628    61: 2696628    62: 2696628    63: 2699264
> > > > > > 
> > > > > > Note:
> > > > > > (1) The frequency of 1-10 and 41-50 CPUs work on the lowest frequency.
> > > > > >        It turned out that nohz full was already work.
> > > > > >        I guess that stress-ng cannot use the CPU in the range of nohz full.
> > > > > >        Because the CPU frequency will be increased to 2.7G by binding CPU to
> > > > > > other application.
> > > > > > (2) The frequency of the nohz full core is calculated by get() callback
> > > > > > according to ftrace.
> > > > > It is as there is no sched tick on those, and apparently there is nothing
> > > > > running on them either.
> > > > Yes.
> > > > If we select your approach and the above phenomenon is normal,
> > > > the large frequency discrepancy issue can be resolved for CPUs with sched
> > > > tick by the way.
> > > > But the nohz full cores still have to face this issue. So this patch is also
> > > > needed.
> > > > 
> > > Yes, nohz cores full have to be handled by the cpufreq driver.
> > Correct. So we still have to face the issue in this patch and push this
> > patch.
> > Beata, would you please review this patch?
> Just to clarify for my benefit (apologies but I do have to contex switch
> pretty often these days): by reviewing this patch do you mean:
> 1) review your changes (if so I think there are few comments already to be
> addressed, but I can try to have another look)
> 2) review changes for AMU-based arch_freq_get_on_cpu ?
> 
> *note: I will still try to have a look at the non-housekeeping cpus case
> 
> ---
> [1] https://lore.kernel.org/lkml/691d3eb2-cd93-f0fc-a7a4-2a8c0d44262c@nvidia.com/
> ---
> 
> BR
> Beata
> > 
> > 
> > /Huisong
> > > 
> [...]

