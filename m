Return-Path: <linux-kernel+bounces-36950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01483A94C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC71C21DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845C60DD4;
	Wed, 24 Jan 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1ikGent"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9D18622;
	Wed, 24 Jan 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098345; cv=none; b=h+nHvcUzns4imWLsx+Mosxa9D8g5MbLLXh43dOgBDRJJosgnyGLd59kPpfpk67CsDEi/bOItZlgU6sWc9mSP8xwm5n3kNlE8ZMp0HWnpLaqhaLVDB3Z31pqAbogZLbNPWSIFh+MIlqyhsDWhmiaLqPBtui17TcFxERnr+MSANYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098345; c=relaxed/simple;
	bh=NvFZcTkuq6TdnuxdMQv6/07eRqV9jkT+b+3hi2RFLD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njuN2URZgb4hDnQzzdUAXb2dO1poQ5NMd20mf2PoVmKUmy3ZJVse9TzHVJPndW9zADFXDoXdTVNurkxb5SYVT3TK0LvZcjx6t9f/DzLZk8VWZUpxitrNOPnHp6BN9mLAYbV1YHVVUVBFNEC9dGJZgaEjQ17rKqbPqBwa1YTjKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1ikGent; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2ADC433C7;
	Wed, 24 Jan 2024 12:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706098343;
	bh=NvFZcTkuq6TdnuxdMQv6/07eRqV9jkT+b+3hi2RFLD4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=I1ikGentxd5rtiAoXXcbDUTsVt74I0bcFtZUnfJAKicv9kLBIcjNIsU2B0EBQ0FPK
	 krEhw5xBqynIuWfF6mAZSZZXlzrAUvSTDO4A7+1JEMkMbEk78m7Z0XaNshrObBxWWK
	 qTmjtdNjg/M5LFA7rHfzTpuGMLCrUk2Q5rw0v5+Jkd5xK7E48mOgzJWGaFGR+6g6Dv
	 WsdXBotDkYAqQ01XaYdrCsMcE/DmxO6YsBHeS9Mjv4vFz1bdHkScVzYmN52aM8n4TT
	 hJs+9RkPgoaGHlipP9U8rb7Ohsvbud9HrPGU6oyYQJnmbdF1Sw3fNAcp4lxoZocKLc
	 UlRpOp34gZurA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 41C63CE0EDF; Wed, 24 Jan 2024 04:12:23 -0800 (PST)
Date: Wed, 24 Jan 2024 04:12:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <6b5c4acc-f184-4ad9-9029-dd7967fe4a04@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240124151743.052082af@canb.auug.org.au>
 <20240124094954.GL3303@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124094954.GL3303@incl>

On Wed, Jan 24, 2024 at 10:49:54AM +0100, Jiri Wiesner wrote:
> On Wed, Jan 24, 2024 at 03:17:43PM +1100, Stephen Rothwell wrote:
> > After merging the rcu tree, today's linux-next build (i386 defconfig)
> > failed like this:
> > In file included from include/linux/dev_printk.h:14,
> >                  from include/linux/device.h:15,
> >                  from kernel/time/clocksource.c:10:
> > kernel/time/clocksource.c: In function 'clocksource_watchdog':
> > kernel/time/clocksource.c:103:34: error: integer overflow in expression of type 'long int' results in '-1619276800' [-Werror=overflow]
> >   103 |                                  * NSEC_PER_SEC / HZ)
> >       |                                  ^
> > Caused by commit
> >   1a4545025600 ("clocksource: Skip watchdog check for large watchdog intervals")
> > I have used the rcu tree from next-20240123 for today.
> 
> This particular patch is still beging discussed on the LKML. This is the 
> latest submission with improved variable naming, increased threshold and 
> changes to the log and the warning message (as proposed by tglx):
> https://lore.kernel.org/lkml/20240122172350.GA740@incl/
> Especially the change to the message is important. I think this message 
> will be commonplace on 8 NUMA node (and larger) machines. If there is 
> anything else I can do to assist please let me know.

Here is the offending #define:

#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
				 * NSEC_PER_SEC / HZ)

The problem is that these things are int or long, and on i386, that
is only 32 bits.  NSEC_PER_SEC is one billion, and WATCHDOG_INTERVAL
is often 1000, which overflows.  The division by HZ gets this back in
range at about 1.5x10^9.

So this computation must be done in 64 bits even on 32-bit systems.
My thought would be a cast to u64, then back to long for the result.

Whatever approach, Jiri, would you like to send an updated patch?

In the meantime, I will rebase to exclude this one from -next.

							Thanx, Paul

