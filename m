Return-Path: <linux-kernel+bounces-152758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891418AC3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB81D1C217C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105618633;
	Mon, 22 Apr 2024 05:47:45 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32418042;
	Mon, 22 Apr 2024 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764864; cv=none; b=syU4Asn5KQBHU+1PnaoVyx+6XkfIVET97o9NadzmvBAqFYy6+5B/JjZbKlu0wK9tri1gIqmOIW2tfh95wFLbgSn4H3glJsZAIISSluL119iSuHimJ6zCiVRe9BvaRIeHViow8lzIu+svt7vYZBBsuhdJHbWv6sTEjp52RNFgujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764864; c=relaxed/simple;
	bh=CPJ8hmz1NSv031GNi1i1JJdxjfv+UTld52TKHzK9QLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3bdN5g6U61cMJWBkg9HX+8IA1XOoU792PXk1gcBHrRNF8qAgA2BwoJM8CnMtho6yPP3o26FTG9sPBueBqt5R1UyHYZ5Ld47P/lN92x3y7YkhbFH7gl9t2m/6F5t2fAkMGxzyYLWObZOlIo1NneWw9J+4a4DLC7FuiQi28rQLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1713764790t2zbf2uk
X-QQ-Originating-IP: DpWM8cAKs4r/Ooi93xKKyAUIGVCHQnWBgMmTGe/LkxM=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 13:46:29 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: q8pcCawQh8Sfml57looHtYOgsSS/CXYG7p1ZqpXjl/UV5J4a5DQ0Sjfiby5tv
	2sidi/tEOqJldU0hRfzfmxPYIBd9cYUp5yRBTom+KCi/Zmey6GXrzUB+d5FXQPsS4LaKIc3
	Yutwss1aViXK3k2GEdElcgbZP0q2TZuB6eXDizI4y0SsXoE1K1insRGypqTEbrDAAlaDJO1
	C1SJc4TsDFPziGqlGqnAA4wP2bBHSduKAqHg4+XgsLrB1c9Vr9mVHjfhArz0pzVQkzvhJj5
	cuGMD0cuSALAhJzAbLn34jxGcYbZp+xut7KvphPDqsXkTRxyzS28FT/dPapDSKcES7D8Mpa
	fXBP/WeX1el8/CsO2wVKMrNyY/D7EQhI1s5rYW1Hoj/Jr2I0VeMF2/D7BctPAmCTMQTtfK3
	zx5YM3opgwE=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16241362233858428748
Date: Mon, 22 Apr 2024 13:46:28 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] sparc/srmmu: Remove on-stack cpumask var
Message-ID: <8932691918B6B5F5+ZiX5tIZF9bZKbiBp@centos8>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-2-dawei.li@shingroup.cn>
 <20240420075846.GA614130@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420075846.GA614130@ravnborg.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Sam,

Thanks for review.

On Sat, Apr 20, 2024 at 09:58:46AM +0200, Sam Ravnborg wrote:
> Hi Dawei,
> On Sat, Apr 20, 2024 at 01:15:41PM +0800, Dawei Li wrote:
> > In general it's preferable to avoid placing cpumasks on the stack, as
> > for large values of NR_CPUS these can consume significant amounts of
> > stack space and make stack overflows more likely.
> > 
> > Use cpumask_any_but() to avoid the need for a temporary cpumask on
> > the stack.
> 
> Another good argument for this patch is the simplification of the code.
> 
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  arch/sparc/mm/srmmu.c | 40 ++++++++++++----------------------------
> >  1 file changed, 12 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> > index 852085ada368..86fd20c878ae 100644
> > --- a/arch/sparc/mm/srmmu.c
> > +++ b/arch/sparc/mm/srmmu.c
> > @@ -1653,13 +1653,15 @@ static void smp_flush_tlb_all(void)
> >  	local_ops->tlb_all();
> >  }
> >  
> > +static bool cpumask_any_but_current(struct mm_struct *mm)
> > +{
> > +	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
> > +}
> 
> This helper is not a cpumask helper - the name should reflect what it is
> used for.
> 
> Something like:
> static bool any_other_mm_cpus(struct mm_struct *mm)
> {
> 	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
> }

Acked. I will rename the helper as you suggested.

> 
> The implementation is fine - it is only the naming that should be
> improve.
> With this change (or a better name):
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam

Thanks,

    Dawei
> 

