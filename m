Return-Path: <linux-kernel+bounces-99535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D28789B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A05281D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7656B70;
	Mon, 11 Mar 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="kn7LzldE"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE354FA1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190011; cv=none; b=DjWTk96vSwZaCDzjXII+P7XslSUcoKp3L58XIoYhYDDS9nkFjKrV6ZPuGWGeaTQi1v2S6cZ5p+RQKNOvDgrou7EtWTuxQIwy8MHjk6Nv1cYnoS5POLBMZ2N9vzYFkYtF87DZrbIxk5mpL1/FpNDys+mAj6AOf574pm0R2xXFe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190011; c=relaxed/simple;
	bh=GL8gtGxJFo4rRuGjv65ntVbUl3g/4tkAZDn4iD3WG+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oFN2VJKVXYCTs8tRKCj9fdnZlcRmJjetk9plQUkUx4oiaZ0TKXrJaJqgfZa87UNeznT+F/UoKf4MPjZZgyfh0ei5fzjbBeP2kmU6v8CUGBlt4Syy0lRT0/dNaRTEbT04mKOkd/Zg2Mnf5JBmf6HuhS9azm8qDvcgvYzAtODD5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=kn7LzldE; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UxyrIsgqNyhoQiWr/nMWx3jRYkmIAK+lVYg1CgDwTXM=;
  b=kn7LzldE/uGw6D5aRqFQgu9J6KyWDUYUfiZUEbfhvym3wZVpa11CWDaL
   arj4iqlpT6h81UPWe9v89hafcBzQx9cNGXfLa/bo5ogumIMibJFATLwEJ
   HrwhKlYnugMd2AmcLpEcfqH4ApL2N6A5jpNo7L1PJ5Ax1CQ12ERABzBPt
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,117,1708383600"; 
   d="scan'208";a="81848605"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 21:46:39 +0100
Date: Mon, 11 Mar 2024 21:46:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
cc: "Felix N. Kimbu" <felixkimbu1@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
    outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: cfg80211: Remove parentheses
 prism2_get_station
In-Reply-To: <5f6b7fad-5ad3-44a0-9e10-3e1c13109abd@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2403112146230.3216@hadrien>
References: <Ze8LBf6xSjCRt4rd@MOLeToid> <4936c555-2c53-d421-126c-48804a26887d@inria.fr> <5f6b7fad-5ad3-44a0-9e10-3e1c13109abd@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 11 Mar 2024, Philipp Hortmann wrote:

> On 3/11/24 18:05, Julia Lawall wrote:
> >
> >
> > On Mon, 11 Mar 2024, Felix N. Kimbu wrote:
> >
> > > Remove unnecessary parentheses around 'wlandev->msdstate !=
> > > WLAN_MSD_RUNNING'
> > > in static int prism2_get_station(...)
> >
> > You don't need the name of the function in the subject line.  That
> > information doesn't help understand the patch.
> >
> > julia
>
> Hi Julia,
>
> I think we do not need the function name in the subject but we need something
> to distinguish between the patches. The subject line needs to be a little
> unique. Otherwise we will have 100 patches like "[PATCH] staging: cfg80211:
> Remove parentheses" when we are unlucky. Any better proposal for a Subject
> uniqueness is welcome.
>
> Function name for this purpose is OK for me.

OK, no problem.

thanks,
julia

>
> Thanks for your support.
>
> Bye Philipp
>
>
> >
> > >
> > > This change ensures adherence to coding style guidelines.
> > >
> > > Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> > > ---
> > >   drivers/staging/wlan-ng/cfg80211.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/wlan-ng/cfg80211.c
> > > b/drivers/staging/wlan-ng/cfg80211.c
> > > index 471bb310176f..7451fd2bb580 100644
> > > --- a/drivers/staging/wlan-ng/cfg80211.c
> > > +++ b/drivers/staging/wlan-ng/cfg80211.c
> > > @@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy,
> > > struct net_device *dev,
> > >
> > >   	memset(sinfo, 0, sizeof(*sinfo));
> > >
> > > -	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
> > > +	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
> > >   		return -EOPNOTSUPP;
> > >
> > >   	/* build request message */
> > > --
> > > 2.34.1
> > >
> > >
> > >
> >
>
>

