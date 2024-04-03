Return-Path: <linux-kernel+bounces-129591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE59896CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00AA1C27F00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16467146A63;
	Wed,  3 Apr 2024 10:42:46 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A4137C47;
	Wed,  3 Apr 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140965; cv=none; b=T3QCpnlXzINdbPOyTEFe8dyoeRAl/IZxD8rbEeaRg+xZlWeCzOPaSDajD6cZPOpJrrFM42dy4d8IgBoc277fU+vde/GOGjZzX7w43poZ4fIObheAVOIGNOTmM24TCt40oK13KSwGcQwEFpKNE/aTx9+JIFv/wSvJAYt8z/9C46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140965; c=relaxed/simple;
	bh=LrWOs7QN3cbW0iHWCcnoaHMQcbUknlLUyq908zLCTGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3wDSb0Xe/fNTa8oZCKYrsRvkgMxgM+bSY2UP4+8L2CKReCycDN+0+LOgkL0HeQi7BBt3SkDNq70Mr9e+jzvvWxp8OUP4aTAXZm1L70s+z3tnY5xU5Bd5dgQAl2xO7Fz9Hyoi88FKDBRTb9kt6vTk7OtHF7efN3WDJuq+s7vMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1712140885thb88ns
X-QQ-Originating-IP: ztiKNQixsH4c7sYIGRQEBNcMOojXAnCirqDNEC45NgA=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 18:41:23 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: Q4gfBD3K7t8wHeDYavXxhf5YOLHjIdkwNKWKT7GcFWMI+vLM9qg+N9pqfvZ4o
	QZSjPGp82hbFPrM2d/QmyymkHJgx290UYaUmx1lhJNFUl3BRUkRHWtPm11sjHUVZEhVqDck
	4q6sl68SwYptDZNm1g+yvQU01fpiExn8Pq9vptvO5sf65otW0ivUwHmnuaFJNcrTcESBNh7
	EBV1kRO1xW5WRgNq52DF4KsphWVHub/2fJBHWVLL9qw/At48xc/YSikE39LJKEebPfrVBEm
	4N3V6K8h4EfH4K2b8A8yb8ePC+/7YBUdLuAWhonD60LBuOpIY3dNtZkd6h9Yb7BBVmaiOOR
	u0OHAo/z6saW7P8DrdM3LKmFZ8vVrRvfjg+Y8vvUk+/NhCe7u5yjSO6FgwZ5g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4992647798818292244
Date: Wed, 3 Apr 2024 18:41:23 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/9] perf: Avoid explicit cpumask var allocation from
 stack
Message-ID: <6D6795E4D37BB843+Zg0yU8SCf+sMNYqp@centos8>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
 <ZgvoMunpbaE-x3jV@FVFF77S0Q05N>
 <190FE91C35AB9AE8+ZgwKuORh3VzTkfeJ@centos8>
 <ZgwZL679Tc1S3AxH@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgwZL679Tc1S3AxH@FVFF77S0Q05N>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

On Tue, Apr 02, 2024 at 03:41:51PM +0100, Mark Rutland wrote:
> On Tue, Apr 02, 2024 at 09:40:08PM +0800, Dawei Li wrote:
> > Hi Mark,
> > 
> > Thanks for the quick review.
> > 
> > On Tue, Apr 02, 2024 at 12:12:50PM +0100, Mark Rutland wrote:
> > > On Tue, Apr 02, 2024 at 06:56:01PM +0800, Dawei Li wrote:
> > > > Hi,
> > > > 
> > > > This series try to eliminate direct cpumask var allocation from stack
> > > > for perf subsystem.
> > > > 
> > > > Direct/explicit allocation of cpumask on stack could be dangerous since
> > > > it can lead to stack overflow for systems with big NR_CPUS or
> > > > CONFIG_CPUMASK_OFFSTACK=y.
> > > > 
> > > > For arm64, it's more urgent since commit 3fbd56f0e7c1 ("ARM64: Dynamically
> > > > allocate cpumasks and increase supported CPUs to 512").
> > > > 
> > > > It's sort of a pattern that almost every cpumask var in perf subystem
> > > > occurs in teardown callback of cpuhp. In which case, if dynamic
> > > > allocation failed(which is unlikely), we choose return 0 rather than
> > > > -ENOMEM to caller cuz:
> > > > @teardown is not supposed to fail and if it does, system crashes:
> > > 
> > > .. but we've left the system in an incorrect state, so that makes no sense.
> > > 
> > > As I commented on the first patch, NAK to dynamically allocating cpumasks in
> > > the CPUHP callbacks. Please allocate the necessry cpumasks up-front when we
> > > probe the PMU. At that time we can handle an allocation failure by cleaning up
> > > and failing to probe the PMU, and then the CPUHP callbacks don't need to
> > > allocate memory to offline a CPU...
> > 
> > Agreed that dynamically allocation in callbacks lead to inconsistency
> > to system.
> > 
> > My (original)alternative plan is simple but ugly, just make cpumask var
> > _static_ and add extra static lock to protect it.
> > 
> > The only difference between solution above and your proposal is static/
> > dynamic alloction. CPUHP's teardown cb is supposed to run in targetted
> > cpuhp thread for most cases, and it's racy. Even the cpumask var is
> > wrapped in dynamically allocated struct xxx_pmu, it's still shareable
> > between different threads/contexts and needs proper protection.
> 
> I was under the impression that the cpuhp callbacks were *strictly* serialised.
> If that's not the case, the existing offlining callbacks are horrendously
> broken.
> 
> Are you *certain* these can race?
> 
> Regardless, adding additional locking here is not ok.
> 
> > Simple as this(_untested_):
> > 
> > diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> > index 7ef9c7e4836b..fa89c3db4d7d 100644
> > --- a/drivers/perf/arm-cmn.c
> > +++ b/drivers/perf/arm-cmn.c
> > @@ -1950,18 +1950,24 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
> >         struct arm_cmn *cmn;
> >         unsigned int target;
> >         int node;
> > -       cpumask_t mask;
> > +       static cpumask_t mask;
> > +       static DEFINE_SPINLOCK(cpumask_lock);
> > 
> >         cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
> >         if (cpu != cmn->cpu)
> >                 return 0;
> > 
> > +       spin_lock(&cpumask_lock);
> > +
> >         node = dev_to_node(cmn->dev);
> >         if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> >             cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> >                 target = cpumask_any(&mask);
> >         else
> >                 target = cpumask_any_but(cpu_online_mask, cpu);
> > +
> > +       spin_unlock(&cpumask_lock);
> > +
> >         if (target < nr_cpu_ids)
> >                 arm_cmn_migrate(cmn, target);
> >         return 0;
> 
> Looking at this case, the only reason we need the mask is because it made the
> logic a little easier to write. All we really want is to choose some CPU in the
> intersection of two masks ignoring a specific CPU, and there was no helper
> function to do that.
> 
> We can add a new helper to do that for us, which would avoid redundant work to
> manipulate the entire mask, and it would make the existing code simpler.  I had
> a series a few years back to add cpumask_any_and_but():
> 
>   https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/

Sounds a perfect idea!

Actually I am re-implementing new series on top of your seven-years-late-yet-still-helpful
patch, with minor update on it:

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..121f3ac757ff 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -388,6 +388,29 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
        return i;
 }

+/**
+ * cpumask_any_and_but - pick a "random" cpu from *mask1 & *mask2, but not this one.
+ * @mask1: the first input cpumask
+ * @mask2: the second input cpumask
+ * @cpu: the cpu to ignore
+ *
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+static inline
+unsigned int cpumask_any_and_but(const struct cpumask *mask1,
+                                const struct cpumask *mask2,
+                                unsigned int cpu)
+{
+       unsigned int i;
+
+       cpumask_check(cpu);
+       i = cpumask_first_and(mask1, mask2);
+       if (i != cpu)
+               return i;
+
+       return cpumask_next_and(cpu, mask1, mask2);
+}
+
 /**
  * cpumask_nth - get the Nth cpu in a cpumask
  * @srcp: the cpumask pointer

Change from your original version:
1 Moved to cpumask.h, just like other helpers.
2 Return value converted to unsigned int.
3 Remove EXPORT_SYMBOL, for obvious reason.

I will respin V2 as a whole as soon as possible.

Thanks,

    Dawei

> 
> .. and that's easy to use here, e.g.
> 
> | diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> | index 7ef9c7e4836b7..c6bbd387ccf8b 100644
> | --- a/drivers/perf/arm-cmn.c
> | +++ b/drivers/perf/arm-cmn.c
> | @@ -1950,17 +1950,15 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
> |         struct arm_cmn *cmn;
> |         unsigned int target;
> |         int node;
> | -       cpumask_t mask;
> |  
> |         cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
> |         if (cpu != cmn->cpu)
> |                 return 0;
> |  
> |         node = dev_to_node(cmn->dev);
> | -       if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> | -           cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> | -               target = cpumask_any(&mask);
> | -       else
> | +       target = cpumask_any_and_but(cpu_online_mask, cpumask_of_node(node),
> | +                                    cpu);
> | +       if (target >= nr_cpu_ids)
> |                 target = cpumask_any_but(cpu_online_mask, cpu);
> |         if (target < nr_cpu_ids)
> |                 arm_cmn_migrate(cmn, target);
> 
> It doesn't trivially rebase since the cpumask code has changed a fair amount,
> but I've managed to do that locally, and I can send that out as a
> seven-years-late v2 if it's useful.
> 
> From a quick scan, it looks like that'd handle all cases in this series. Are
> there any patterns in this series for which that would not be sufficient?
> 
> Mark.
> 
> > 
> > And yes, static allocation is evil :) 
> > 
> > 
> > Thanks,
> > 
> >     Dawei
> > 
> > > 
> > > Also, for the titles it'd be better to say something like "avoid placing
> > > cpumasks on the stack", because "explicit cpumask var allocation" sounds like
> > > the use of alloc_cpumask_var().
> > 
> > Sound great! I will update it.
> > 
> > > 
> > > Mark.
> > > 
> > > > 
> > > > static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
> > > >                             struct hlist_node *node)
> > > > {
> > > >         struct cpuhp_step *sp = cpuhp_get_step(state);
> > > >         int ret;
> > > > 
> > > >         /*
> > > >          * If there's nothing to do, we done.
> > > >          * Relies on the union for multi_instance.
> > > >          */
> > > >         if (cpuhp_step_empty(bringup, sp))
> > > >                 return 0;
> > > >         /*
> > > >          * The non AP bound callbacks can fail on bringup. On teardown
> > > >          * e.g. module removal we crash for now.
> > > >          */
> > > > 	#ifdef CONFIG_SMP
> > > >         if (cpuhp_is_ap_state(state))
> > > >                 ret = cpuhp_invoke_ap_callback(cpu, state, bringup, node);
> > > >         else
> > > >                 ret = cpuhp_invoke_callback(cpu, state, bringup, node,
> > > > 		NULL);
> > > > 	#else
> > > >         ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> > > > 	#endif
> > > >         BUG_ON(ret && !bringup);
> > > >         return ret;
> > > > }
> > > > 
> > > > Dawei Li (9):
> > > >   perf/alibaba_uncore_drw: Avoid explicit cpumask var allocation from
> > > >     stack
> > > >   perf/arm-cmn: Avoid explicit cpumask var allocation from stack
> > > >   perf/arm_cspmu: Avoid explicit cpumask var allocation from stack
> > > >   perf/arm_dsu: Avoid explicit cpumask var allocation from stack
> > > >   perf/dwc_pcie: Avoid explicit cpumask var allocation from stack
> > > >   perf/hisi_pcie: Avoid explicit cpumask var allocation from stack
> > > >   perf/hisi_uncore: Avoid explicit cpumask var allocation from stack
> > > >   perf/qcom_l2: Avoid explicit cpumask var allocation from stack
> > > >   perf/thunder_x2: Avoid explicit cpumask var allocation from stack
> > > > 
> > > >  drivers/perf/alibaba_uncore_drw_pmu.c    | 13 +++++++++----
> > > >  drivers/perf/arm-cmn.c                   | 13 +++++++++----
> > > >  drivers/perf/arm_cspmu/arm_cspmu.c       | 13 +++++++++----
> > > >  drivers/perf/arm_dsu_pmu.c               | 18 +++++++++++++-----
> > > >  drivers/perf/dwc_pcie_pmu.c              | 17 +++++++++++------
> > > >  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 15 ++++++++++-----
> > > >  drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 +++++++++----
> > > >  drivers/perf/qcom_l2_pmu.c               | 15 ++++++++++-----
> > > >  drivers/perf/thunderx2_pmu.c             | 20 ++++++++++++--------
> > > >  9 files changed, 92 insertions(+), 45 deletions(-)
> > > > 
> > > > 
> > > > Thanks,
> > > > 
> > > >     Dawei
> > > > 
> > > > -- 
> > > > 2.27.0
> > > > 
> > > 
> 

