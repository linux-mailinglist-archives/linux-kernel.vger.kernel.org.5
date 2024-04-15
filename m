Return-Path: <linux-kernel+bounces-144762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85868A4A65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843CD282A77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67040381C7;
	Mon, 15 Apr 2024 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uvkGJcsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687942F52;
	Mon, 15 Apr 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170025; cv=none; b=qDo7dS36fF2b+UcBwKYRAqpO4WzzD2/1aKKrB9UlF3WYpL0VpnApreu6HRo4Uj2+VUIlSo7KhqjBJagr0LBDil/ek5wX74SmIvkUPFjU2cHzLoXUUTNM9CrD5RsXfj/iEDYKW/aEiS+8dcHP5cy2fRa86uKqJ9t3M71RYmWTyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170025; c=relaxed/simple;
	bh=NPapd/95avKcGkL+zF4/m02fnaTGkOB2tCBiHzBKv7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8eiVz98ae+Bg5WNBEMsVaXNsYedZ/O1vLfM6mm+fplBNgXI/XbVVr7HgvsPZABJjPeNAptGze/iM42BZAhVGe9cLMrLa2lbDfJuvxoUWdKF0fLFu6QXQI/lDFiU2G0Srbw1rAt5fiKJwU0NCZZADZPATnZ61ULRLy9b9XfUBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uvkGJcsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EDEC113CC;
	Mon, 15 Apr 2024 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713170025;
	bh=NPapd/95avKcGkL+zF4/m02fnaTGkOB2tCBiHzBKv7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvkGJcsiNryIjOdLvq79Pl7lZD4Th8DSjU4LG0YnF6tORvXgk944uxgSnwKfJMGtZ
	 Hv0NbzsI32xWS57nDOn9JWA7v0HUEDILLmBvTgnbaMWh2c4TnBes+zVV7SExNoHWhC
	 5qFGnPFqU49d+rEgJCoDI0WZreANMlVCWdcpNEZU=
Date: Mon, 15 Apr 2024 10:33:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alex Elder <elder@linaro.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <2024041511-goldmine-persevere-68f4@gregkh>
References: <20240414170850.148122-1-elder@linaro.org>
 <20240414194835.GA12561@pendragon.ideasonboard.com>
 <2024041503-affidavit-stopwatch-72d7@gregkh>
 <20240415082529.GD25078@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415082529.GD25078@pendragon.ideasonboard.com>

On Mon, Apr 15, 2024 at 11:25:29AM +0300, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Mon, Apr 15, 2024 at 07:21:37AM +0200, Greg KH wrote:
> > On Sun, Apr 14, 2024 at 10:48:35PM +0300, Laurent Pinchart wrote:
> > > On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
> > > > Several times recently Greg KH has admonished that variants of WARN()
> > > > should not be used, because when the panic_on_warn kernel option is set,
> > > > their use can lead to a panic. His reasoning was that the majority of
> > > > Linux instances (including Android and cloud systems) run with this option
> > > > enabled. And therefore a condition leading to a warning will frequently
> > > > cause an undesirable panic.
> > > > 
> > > > The "coding-style.rst" document says not to worry about this kernel
> > > > option.  Update it to provide a more nuanced explanation.
> > > > 
> > > > Signed-off-by: Alex Elder <elder@linaro.org>
> > > > ---
> > > >  Documentation/process/coding-style.rst | 21 +++++++++++----------
> > > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > > index 9c7cf73473943..bce43b01721cb 100644
> > > > --- a/Documentation/process/coding-style.rst
> > > > +++ b/Documentation/process/coding-style.rst
> > > > @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
> > > >  to trigger easily, for example, by user space actions. pr_warn_once() is a
> > > >  possible alternative, if you need to notify the user of a problem.
> > > >  
> > > > -Do not worry about panic_on_warn users
> > > > -**************************************
> > > > +The panic_on_warn kernel option
> > > > +********************************
> > > >  
> > > > -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> > > > -available kernel option, and that many users set this option. This is why
> > > > -there is a "Do not WARN lightly" writeup, above. However, the existence of
> > > > -panic_on_warn users is not a valid reason to avoid the judicious use
> > > > -WARN*(). That is because, whoever enables panic_on_warn has explicitly
> > > > -asked the kernel to crash if a WARN*() fires, and such users must be
> > > > -prepared to deal with the consequences of a system that is somewhat more
> > > > -likely to crash.
> > > > +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
> > > > +a WARN*() call whose condition holds leads to a kernel panic.  Many users
> > > > +(including Android and many cloud providers) set this option, and this is
> > > > +why there is a "Do not WARN lightly" writeup, above.
> > > > +
> > > > +The existence of this option is not a valid reason to avoid the judicious
> > > > +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
> > > > +issue warnings but do **not** cause the kernel to crash. Use these if you
> > > > +want to prevent such panics.
> > > 
> > > Those options are not equivalent, they print a single message, which is
> > > much easier to ignore. WARN() is similar to -Werror in some sense, it
> > > pushes vendors to fix the warnings. I have used WARN() in the past to
> > > indicate usage of long-deprecated APIs that we were getting close to
> > > removing for instance. dev_warn() wouldn't have had the same effect.
> > 
> > If you want to reboot a box because someone called an "improper" api,
> 
> I don't "want" to reboot. It came as a side effect when panic_on_warn
> was added, and worsened when its adoption increased. I won't argued for
> or against panic_on_warn, but WARN() serves some use cases today that I
> consider valid. If we want to discourage its usage, we need another API
> to cover those use cases.
> 
> > then sure, use WARN(), but that feels like a really bad idea.  Just
> > remove the api and fix up all in-kernel users instead.  Why wait?
> 
> There are multiple use cases. One of them is to make sure no new user of
> the old, deprecated behaviour is introduced. This is especially
> important when driver development spans multiple kernel releases, the
> development can start before the API behaviour changes, with the driver
> merged after the API change. This is something we've done multiple times
> in V4L2.
> 
> > If you want to show a traceback, then just print that out, but I've seen
> > that totally ignored as well, removing the api is usually the only way
> > to get people to actually notice, as then their builds break.
> 
> Does your experience tell that tracebacks are routinely ignored during
> development too, not just in production ?

Yes, we have done this in the past in some driver core apis and nothing
ever changed until we actually deleted the apis.

thanks,

greg k-h

