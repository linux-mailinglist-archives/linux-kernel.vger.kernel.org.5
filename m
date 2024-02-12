Return-Path: <linux-kernel+bounces-62476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DE852168
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA341C22141
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1884E1CC;
	Mon, 12 Feb 2024 22:27:48 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A64D9F8;
	Mon, 12 Feb 2024 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776867; cv=none; b=lLg2CVhWYM+F9T0hyywaHe/YEZwQvCc4c5BAoEPs3I3gAGlE7aZhXeOv9VT4y7o1tQq0tOMxCbRCL/rJrUp+MsWEbb/MWLyGu6lK3oI2j0xDDFS98ZpBGAB7ozEb1Kkwy0Qn58EWTrp34Fmpk9fMMwYh7jXNV8J/El3ybztS8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776867; c=relaxed/simple;
	bh=ZSuzM33K2Ivy+oNT+1PaHP0aBqjsDFTre27xJJRrBTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXUHhlTKXfYtnM6GwABQacUJcmPtHEB7PeGMDtD4rGEqQZX2vU4o1iAWQvusgjQuYQspxUYsb5+1mPdYydYdG8qMVWwhMZ3kONTX7setstX7GqgyFpuVbBngsmlsAi51IDOItksWbyIb17gmvgStt1ndVfX9UwMZqDIhSSUvFwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id B7642A02C7;
	Mon, 12 Feb 2024 23:21:56 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IdHNfV2igPni; Mon, 12 Feb 2024 23:21:56 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 1554AA02B1;
	Mon, 12 Feb 2024 23:21:56 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rZegV-0000000GUH9-1rnO;
	Mon, 12 Feb 2024 23:21:55 +0100
Date: Mon, 12 Feb 2024 23:21:55 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Tom Parkin <tparkin@katalix.com>
Cc: James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] PPPoL2TP: Add more code snippets
Message-ID: <20240212222155.shiacjlqupqoliym@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Tom Parkin <tparkin@katalix.com>,
	James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240203223513.f2nfgaamgffz6dno@begin>
 <ZcqMzP1RQye9o4eB@katalix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcqMzP1RQye9o4eB@katalix.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Hello,

Thanks for reviewing, I'll send a v4.

Tom Parkin, le lun. 12 févr. 2024 21:25:32 +0000, a ecrit:
> > +        ret = ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
> > +        if (ret < 0)
> > +                return -errno;
> > +
> > +        ret = ioctl(session_fd2, PPPIOCGCHAN, &chind2x);
> 
> I think we need to be clear here in this example what session_fd1 and
> session_fd2 are, and how they have come to be, since they haven't been
> mentioned in the examples so far.

Right (though it's called session_fd above), I have added explicit input
descriptions.

> I'm not sure whether it helps or not, but when we were working on l2tp-ktest
> initially we had tests for the bridge ioctl.  The tests bridged a PPPoE
> channel with a PPPoL2TP one (which was the original motivation for
> PPPIOCBRIDGECHAN).  The code is here:
> 
> https://github.com/katalix/l2tp-ktest/blob/master/src/util.c#L592
> 
> So in that codebase we have a pppoe fd and a pppol2tp fd, both of
> which have had been attached using PPPIOCATTCHAN.
> 
> We then bridge those two channels using PPPIOCBRIDGECHAN.
> 
> I think the bridging is a complex use-case for what is already quite
> an involved API (lots of file descriptors and indices to keep track
> of!).  So I think the code snippet needs to be as clear as we can make
> it.

Yes, I kept the simple l2tp-to-l2tp example, but mentioned that other
types of ppp channels can also be bridged.  The important part is that
the code snippets show exactly what kind of fd is expected where :)

Samuel

