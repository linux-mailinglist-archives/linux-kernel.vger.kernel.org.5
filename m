Return-Path: <linux-kernel+bounces-152759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9108AC3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D01C21785
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479D18633;
	Mon, 22 Apr 2024 05:50:07 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303210962;
	Mon, 22 Apr 2024 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765006; cv=none; b=j1BNa57OxcLC7tFh/sx/qLO/rju4CMdgqeY6plaQdIbUDLA7zbeg9PBrr57s8uejMCiDVx4ARQeKw/lmodYLVsY63M8rqFoeb8xLrdCF7po7Hu5iUBJRWcwTvWFVZLNA3ld+1s95djOLDdiTPp69xDnHJLoQtm90k/pITa93aTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765006; c=relaxed/simple;
	bh=8hfB51I5WggBatZTVJd71V6FL2koI9kpV4yuQcbXCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1lRb5Cw02FpColFJOYpEYgg/I1rl+wotlGUIawZhFt6BjULRXvhN7jkQYq8VaIIE9yFbchwm5ALrAy2nw9mioepgb2yz6U8MezMVg1kPRzSWCwDKQVep0tjE3j3YIYe/yiHpA7A21cV+MQwxvrgx+Y2iKsE7MFawWUnwv8uclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1713764970tsocclyn
X-QQ-Originating-IP: Ohk9oRQKVHYvOlgfuu5YoxdMIiITgce2kdIHRIvbTEM=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 13:49:29 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: pi5xsqT0CkRRBviJgB14N9yQRULqMbghUkUSRMKdCE+uLNiX8uvL8o3F8gxjQ
	/cvCBJ78sfOifp1fhRqjlL8xPT8BQEgmxBFfAUSU+yOgvaKecYJ/DqcCbm5ZjCYMqaTW49Q
	Hs/W7XDGJ2t1s9VCjrpxBFciJQcNzN/EnfMGBVlxWHJoERnRByRVNGJ6XD/xiWNjB7/FjNo
	tDixHz/uK9Ddb+0YU8I18Q2YFiyb6rlTIJ0gCgSSMZkO/mduPKXd5xx0W/5MJ8wylcucV46
	aScWnZeNgOU5hJimZG/uhZ1dKsrY2wOaLCAi4W8iDpw+Y/y0aAnXfL16EDSzpzfOdIVhveA
	9SCKAjF2PneJ3AY0+jTro0Hu8fTaStgWv1lKR9L7aTVWIL8wJGNFaKvunLEdrE+3m/CT0Fa
	n6qes2e7SB0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10875305432383325834
Date: Mon, 22 Apr 2024 13:49:28 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] sparc: Remove on-stack cpumask var
Message-ID: <966F5E5885D4F1D5+ZiX6aJqbscCJBrwU@centos8>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-6-dawei.li@shingroup.cn>
 <20240420082805.GE614130@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420082805.GE614130@ravnborg.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Sam,

Thanks for review.

On Sat, Apr 20, 2024 at 10:28:05AM +0200, Sam Ravnborg wrote:
> On Sat, Apr 20, 2024 at 01:15:45PM +0800, Dawei Li wrote:
> > In general it's preferable to avoid placing cpumasks on the stack, as
> > for large values of NR_CPUS these can consume significant amounts of
> > stack space and make stack overflows more likely.
> > 
> > Since the cpumask var resides in __init function, which means it's free
> > of any concurrenct access, it can be safely marked with static to get
> > rid of allocation on stack.
> > 
> > while at it, mark it with __initdata to keep it from persistently
> > consumed memory.
> 
> I do not see the need for this - it does not fix a bug and it
> complicates things.
> If the size is a real concern the normal pattern is to allocate
> and not declare it __initdata.
> 
> Yes - __initdata is used in some place.
> I suggest to leave it as is unless we are fixing a real bug here.

Acked. I will remove __initdata annotation.

Thanks,

    Dawei

> 
> 	Sam
> 
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  arch/sparc/mm/init_64.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> > index 1ca9054d9b97..088d9c103dcc 100644
> > --- a/arch/sparc/mm/init_64.c
> > +++ b/arch/sparc/mm/init_64.c
> > @@ -1438,7 +1438,7 @@ static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
> >  static int __init numa_parse_mdesc_group(struct mdesc_handle *md, u64 grp,
> >  					 int index)
> >  {
> > -	cpumask_t mask;
> > +	static cpumask_t mask __initdata;
> >  	int cpu;
> >  
> >  	numa_parse_mdesc_group_cpus(md, grp, &mask);
> > -- 
> > 2.27.0
> 

