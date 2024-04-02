Return-Path: <linux-kernel+bounces-128065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50517895596
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CCE288F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5C8564B;
	Tue,  2 Apr 2024 13:41:33 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0E85285;
	Tue,  2 Apr 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065293; cv=none; b=MHTk3iGk0F1LgsXvIPlsD7qzrpQ0QHrjFOp3ZtjoKnYJViJRSAUStsANUtOlsHdWwrhjYfjP5xLf9pP7/o7TAI7ZgZh+qSnq9dbYYDFxOta/tytCYm7LAtCZs61R2ujSTP7MXeKtAQ+ctMZYuRBVBoWTRkTUK5/zqlQGb+6tk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065293; c=relaxed/simple;
	bh=qXxdVor5uXd8YNxYp/isrNRYhhWxs7u+gFLdY2RXpNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgenVgrRrmYmkkwOmF0eve4IVQrvxJg9bto+CLpIDUuCL5TtJckB/gbBqB+9wyPE+QB+lIvzmrxP8/FeiKi49i/gXh20x8OZQ6O5H4t0LYzbWnw8DuiA2juNbGQ0UZb1s7qBqaghp5xJAqJUZ8KoTAb65NHJkX08PO7scSy05TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp81t1712065210tpwhlyo1
X-QQ-Originating-IP: yDbBUvpK7jSUTaku6o3rrP2fuyoH+hdyO2Sc673Abrs=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 21:40:09 +0800 (CST)
X-QQ-SSF: 01400000000000704000000C0000000
X-QQ-FEAT: qcKkmz/zJhwKO7uO84H8MICt3oiHfhIRqQcEddlIPcnXa4UhXjD4Mi/qlTLDf
	ors901SIDj4uUrR7FQXfcYI0O4eTd3avOwZvhyn4LabdXRNfuQk5SwHH8yx0yqOGKeXqf1b
	L1c7669qp4GBeM2l0/uMZYsyvbsuOEPVyjveGxM34OcqMcvUju04R/KfR8few0/4d3b6O7x
	57DJTMj54IG3ukftw3kKyXdhfF2H1ckt6GeQmsSBBL7nmAxF9WcAf8vflfC9trKek9jznhk
	1/Ylj+VarFRl3EUSUpTbd3sW2PS8mLcvye8X+5wicq7BJwvBssImdmhF9+ck7h6OfqtNQdp
	8CGIj+F/aAs3xO4qc4ckzwio5fTkVSg8qqExpFONh7Q/fPIpNGp5UoQyYMU4w2bdd1yixFs
	M1ddlbbDkcw=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17939997509187438316
Date: Tue, 2 Apr 2024 21:40:08 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/9] perf: Avoid explicit cpumask var allocation from
 stack
Message-ID: <190FE91C35AB9AE8+ZgwKuORh3VzTkfeJ@centos8>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
 <ZgvoMunpbaE-x3jV@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgvoMunpbaE-x3jV@FVFF77S0Q05N>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Mark,

Thanks for the quick review.

On Tue, Apr 02, 2024 at 12:12:50PM +0100, Mark Rutland wrote:
> On Tue, Apr 02, 2024 at 06:56:01PM +0800, Dawei Li wrote:
> > Hi,
> > 
> > This series try to eliminate direct cpumask var allocation from stack
> > for perf subsystem.
> > 
> > Direct/explicit allocation of cpumask on stack could be dangerous since
> > it can lead to stack overflow for systems with big NR_CPUS or
> > CONFIG_CPUMASK_OFFSTACK=y.
> > 
> > For arm64, it's more urgent since commit 3fbd56f0e7c1 ("ARM64: Dynamically
> > allocate cpumasks and increase supported CPUs to 512").
> > 
> > It's sort of a pattern that almost every cpumask var in perf subystem
> > occurs in teardown callback of cpuhp. In which case, if dynamic
> > allocation failed(which is unlikely), we choose return 0 rather than
> > -ENOMEM to caller cuz:
> > @teardown is not supposed to fail and if it does, system crashes:
> 
> .. but we've left the system in an incorrect state, so that makes no sense.
> 
> As I commented on the first patch, NAK to dynamically allocating cpumasks in
> the CPUHP callbacks. Please allocate the necessry cpumasks up-front when we
> probe the PMU. At that time we can handle an allocation failure by cleaning up
> and failing to probe the PMU, and then the CPUHP callbacks don't need to
> allocate memory to offline a CPU...

Agreed that dynamically allocation in callbacks lead to inconsistency
to system.

My (original)alternative plan is simple but ugly, just make cpumask var
_static_ and add extra static lock to protect it.

The only difference between solution above and your proposal is static/
dynamic alloction. CPUHP's teardown cb is supposed to run in targetted
cpuhp thread for most cases, and it's racy. Even the cpumask var is
wrapped in dynamically allocated struct xxx_pmu, it's still shareable
between different threads/contexts and needs proper protection.

Simple as this(_untested_):

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7ef9c7e4836b..fa89c3db4d7d 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1950,18 +1950,24 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
        struct arm_cmn *cmn;
        unsigned int target;
        int node;
-       cpumask_t mask;
+       static cpumask_t mask;
+       static DEFINE_SPINLOCK(cpumask_lock);

        cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
        if (cpu != cmn->cpu)
                return 0;

+       spin_lock(&cpumask_lock);
+
        node = dev_to_node(cmn->dev);
        if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
            cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
                target = cpumask_any(&mask);
        else
                target = cpumask_any_but(cpu_online_mask, cpu);
+
+       spin_unlock(&cpumask_lock);
+
        if (target < nr_cpu_ids)
                arm_cmn_migrate(cmn, target);
        return 0;

And yes, static allocation is evil :) 


Thanks,

    Dawei

> 
> Also, for the titles it'd be better to say something like "avoid placing
> cpumasks on the stack", because "explicit cpumask var allocation" sounds like
> the use of alloc_cpumask_var().

Sound great! I will update it.

> 
> Mark.
> 
> > 
> > static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
> >                             struct hlist_node *node)
> > {
> >         struct cpuhp_step *sp = cpuhp_get_step(state);
> >         int ret;
> > 
> >         /*
> >          * If there's nothing to do, we done.
> >          * Relies on the union for multi_instance.
> >          */
> >         if (cpuhp_step_empty(bringup, sp))
> >                 return 0;
> >         /*
> >          * The non AP bound callbacks can fail on bringup. On teardown
> >          * e.g. module removal we crash for now.
> >          */
> > 	#ifdef CONFIG_SMP
> >         if (cpuhp_is_ap_state(state))
> >                 ret = cpuhp_invoke_ap_callback(cpu, state, bringup, node);
> >         else
> >                 ret = cpuhp_invoke_callback(cpu, state, bringup, node,
> > 		NULL);
> > 	#else
> >         ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> > 	#endif
> >         BUG_ON(ret && !bringup);
> >         return ret;
> > }
> > 
> > Dawei Li (9):
> >   perf/alibaba_uncore_drw: Avoid explicit cpumask var allocation from
> >     stack
> >   perf/arm-cmn: Avoid explicit cpumask var allocation from stack
> >   perf/arm_cspmu: Avoid explicit cpumask var allocation from stack
> >   perf/arm_dsu: Avoid explicit cpumask var allocation from stack
> >   perf/dwc_pcie: Avoid explicit cpumask var allocation from stack
> >   perf/hisi_pcie: Avoid explicit cpumask var allocation from stack
> >   perf/hisi_uncore: Avoid explicit cpumask var allocation from stack
> >   perf/qcom_l2: Avoid explicit cpumask var allocation from stack
> >   perf/thunder_x2: Avoid explicit cpumask var allocation from stack
> > 
> >  drivers/perf/alibaba_uncore_drw_pmu.c    | 13 +++++++++----
> >  drivers/perf/arm-cmn.c                   | 13 +++++++++----
> >  drivers/perf/arm_cspmu/arm_cspmu.c       | 13 +++++++++----
> >  drivers/perf/arm_dsu_pmu.c               | 18 +++++++++++++-----
> >  drivers/perf/dwc_pcie_pmu.c              | 17 +++++++++++------
> >  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 15 ++++++++++-----
> >  drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 +++++++++----
> >  drivers/perf/qcom_l2_pmu.c               | 15 ++++++++++-----
> >  drivers/perf/thunderx2_pmu.c             | 20 ++++++++++++--------
> >  9 files changed, 92 insertions(+), 45 deletions(-)
> > 
> > 
> > Thanks,
> > 
> >     Dawei
> > 
> > -- 
> > 2.27.0
> > 
> 

