Return-Path: <linux-kernel+bounces-86630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF4786C80C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDBF1C21CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFDF7C095;
	Thu, 29 Feb 2024 11:28:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A27B3E9;
	Thu, 29 Feb 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206128; cv=none; b=bkgtj3AxuND6ky8pAbwHYRGyHE9uHeiwyDz9BXcGU8ifJEr0++SrjJV1La+m+M+yY+tHHyZQ8hKaevPoz742kRb5IbLuahOX3a0MkdSnmdgjTv0ReR+zspjF3ibsgXPjP9sZj4M8SbNQHAwXU+pQegpqMyISnzjxjciudBVv/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206128; c=relaxed/simple;
	bh=xwE5PwyGuUft3+D7xKnD2yaZb0FjCIJzwqD5+QQgNK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arLA6CS0vng4CR3ngbv/7VcOeaemB6x/6/ZrKh9cqBhtDiJczAjB3+QHyFcz29BIqqsk7+/RGhiCWMcZFNWhhKeSuPdI1ET0CoatoLQOxtG36IGHYWQbmHEqM/OBmOaeBdlnYgrBpktC83HXCqOxt9F1YwihNYDSuY9tPyAU10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD9E1FB;
	Thu, 29 Feb 2024 03:29:23 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DAF3F762;
	Thu, 29 Feb 2024 03:28:42 -0800 (PST)
Date: Thu, 29 Feb 2024 11:28:40 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, pierre.gondois@arm.com,
	dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
	viresh.kumar@linaro.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <ZeBqW04f8V4dHphn@pluto>
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-3-quic_sibis@quicinc.com>
 <f8bfc666-c216-44d5-a63b-99f04ff3b8ef@arm.com>
 <2608b2d8-f3b0-b4f5-f8e4-1f2242043ded@quicinc.com>
 <64c6a1bc-92f2-4f44-ab10-cbd2473746f3@arm.com>
 <18c249b2-ce8c-435b-8d65-a1770a1f294e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18c249b2-ce8c-435b-8d65-a1770a1f294e@arm.com>

On Thu, Feb 29, 2024 at 10:22:39AM +0000, Lukasz Luba wrote:
> 
> 
> On 2/29/24 09:59, Lukasz Luba wrote:
> > 
> > 
> > On 2/28/24 17:00, Sibi Sankar wrote:
> > > 
> > > 
> > > On 2/28/24 18:54, Lukasz Luba wrote:
> > > > 
> > > > 
> > > > On 2/27/24 18:16, Sibi Sankar wrote:
> > > > > Register for limit change notifications if supported and use
> > > > > the throttled
> > > > > frequency from the notification to apply HW pressure.
> > > 
> > > Lukasz,
> > > 
> > > Thanks for taking time to review the series!
> > > 
> > > > > 
> > > > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > > > ---
> > > > > 
> > > > > v3:
> > > > > * Sanitize range_max received from the notifier. [Pierre]
> > > > > * Update commit message.
> > > > > 
> > > > >   drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
> > > > >   1 file changed, 28 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/cpufreq/scmi-cpufreq.c
> > > > > b/drivers/cpufreq/scmi-cpufreq.c
> > > > > index 76a0ddbd9d24..78b87b72962d 100644
> > > > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > > > @@ -25,9 +25,13 @@ struct scmi_data {
> > > > >       int domain_id;
> > > > >       int nr_opp;
> > > > >       struct device *cpu_dev;
> > > > > +    struct cpufreq_policy *policy;
> > > > >       cpumask_var_t opp_shared_cpus;
> > > > > +    struct notifier_block limit_notify_nb;
> > > > >   };
> > > > > +const struct scmi_handle *handle;
> > 
> > I've missed this bit here.
> 
> So for this change we actually have to ask Cristian or Sudeep
> because I'm not sure if we have only one 'handle' instance
> for all cpufreq devices.
> 
> If we have different 'handle' we cannot move it to the
> global single pointer.
> 
> Sudeep, Cristian what do you think?

I was just replying noticing this :D .... since SCMI drivers can be
probed multiple times IF you defined multiple scmi top nodes in your DT
containing the same protocol nodes, they receive a distinct sdev/handle/ph
for each probe...so any attempt to globalize these wont work...BUT...

..this is a bit of a weird setup BUT it is not against the spec and it can
be used to parallelize more the SCMI accesses to disjont set of resources
within the same protocol (a long story here...) AND this type of setup is
something that it is already used by some other colleagues of Sibi working
on a different line of products (AFAIK)...

So, for these reasons, usually, all the other SCMI drivers have per-instance
non-global references to handle/sdev/ph....

..having said that, thought, looking at the structure of CPUFReq
drivers, I am not sure that they can stand such a similar setup
where multiple instances of this same driver are probed

... indeed the existent *ph refs above is already global....so it wont already
work anyway in case of multiple instances now...

..and if I look at how CPUFreq expects the signature of scmi_cpufreq_get_rate()
to be annd how it is implemented now using the global *ph reference, it is
clearly already not working cleanly on a multi-instance setup...

..now...I can imagine how to (maybe) fix the above removing the globals and
fixing this, BUT the question, more generally, is CPUFreq supposed to work at all in
this multi-probed mode of operation ?
Does it even make sense to be able to support this in CPUFREQ ?

(as an example in cpufreq,c there is static global cpufreq_driver
 pointing to the arch-specific configured driver BUT that also holds
 some .driver_data AND that cleraly wont be instance specific if you
 probe multiple times and register with CPUFreq multiple times...)

 More questions than answers here :D

 Thanks,
 Cristian

