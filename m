Return-Path: <linux-kernel+bounces-144757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 714F78A4A43
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1FF1F263B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039F374F5;
	Mon, 15 Apr 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KZZ/4lGt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942B3839E;
	Mon, 15 Apr 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169541; cv=none; b=nYLbPx1juXOIcjmcOBYD4hqn7M3ni8Dg2KX5vNYQvG5qx6ZxoVyuAjKcY0WxJlbbbdbxSsG10FqVTVAe3MIObPACQCDwG8YiNQ/QJ1U3CKfmJrJYLZWYDvRASWYfD8VrWb0w0Dm02suThH9N+9gcg1Ee6OzdobU+sRPiqTH2vfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169541; c=relaxed/simple;
	bh=ns4QpknxdZsUAAUIRXzTo+S6ANEZeLh9gJJwLTv3wkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nihlVq1TiaAi83omqQWXaFqXLIF7Hmsvy3VZ85MzWVFmWHJQPdBjw37jcyIohI76jubtBnyAWgbL2tk7ciIogXYvYK5yt3Y5my3lbSP7Ntg/jHXPdblaoPYKN3iJMjzlq2kafYTLK+AxfS6r9U4FPVP4yZheaVEOp8+48dxjV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KZZ/4lGt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6AFC65B2;
	Mon, 15 Apr 2024 10:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713169492;
	bh=ns4QpknxdZsUAAUIRXzTo+S6ANEZeLh9gJJwLTv3wkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZZ/4lGt0HgmdtsIoIUXLTeOP48QpzHxfYEz6Hx+zDmi3ILWQr//Yi+T01libb/AN
	 y/G0Fb2U96Oe3GdLDdgVKG/A2AOQ9Yclfb81yyV18y43SmyOFlF0LhqNcW8UDV98jV
	 cWHvKVSM9nl2ImxPqhV/ByYodjjduDIa8jp3Nw1Q=
Date: Mon, 15 Apr 2024 11:25:29 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alex Elder <elder@linaro.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <20240415082529.GD25078@pendragon.ideasonboard.com>
References: <20240414170850.148122-1-elder@linaro.org>
 <20240414194835.GA12561@pendragon.ideasonboard.com>
 <2024041503-affidavit-stopwatch-72d7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024041503-affidavit-stopwatch-72d7@gregkh>

Hi Greg,

On Mon, Apr 15, 2024 at 07:21:37AM +0200, Greg KH wrote:
> On Sun, Apr 14, 2024 at 10:48:35PM +0300, Laurent Pinchart wrote:
> > On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
> > > Several times recently Greg KH has admonished that variants of WARN()
> > > should not be used, because when the panic_on_warn kernel option is set,
> > > their use can lead to a panic. His reasoning was that the majority of
> > > Linux instances (including Android and cloud systems) run with this option
> > > enabled. And therefore a condition leading to a warning will frequently
> > > cause an undesirable panic.
> > > 
> > > The "coding-style.rst" document says not to worry about this kernel
> > > option.  Update it to provide a more nuanced explanation.
> > > 
> > > Signed-off-by: Alex Elder <elder@linaro.org>
> > > ---
> > >  Documentation/process/coding-style.rst | 21 +++++++++++----------
> > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > index 9c7cf73473943..bce43b01721cb 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
> > > @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
> > >  to trigger easily, for example, by user space actions. pr_warn_once() is a
> > >  possible alternative, if you need to notify the user of a problem.
> > >  
> > > -Do not worry about panic_on_warn users
> > > -**************************************
> > > +The panic_on_warn kernel option
> > > +********************************
> > >  
> > > -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> > > -available kernel option, and that many users set this option. This is why
> > > -there is a "Do not WARN lightly" writeup, above. However, the existence of
> > > -panic_on_warn users is not a valid reason to avoid the judicious use
> > > -WARN*(). That is because, whoever enables panic_on_warn has explicitly
> > > -asked the kernel to crash if a WARN*() fires, and such users must be
> > > -prepared to deal with the consequences of a system that is somewhat more
> > > -likely to crash.
> > > +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
> > > +a WARN*() call whose condition holds leads to a kernel panic.  Many users
> > > +(including Android and many cloud providers) set this option, and this is
> > > +why there is a "Do not WARN lightly" writeup, above.
> > > +
> > > +The existence of this option is not a valid reason to avoid the judicious
> > > +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
> > > +issue warnings but do **not** cause the kernel to crash. Use these if you
> > > +want to prevent such panics.
> > 
> > Those options are not equivalent, they print a single message, which is
> > much easier to ignore. WARN() is similar to -Werror in some sense, it
> > pushes vendors to fix the warnings. I have used WARN() in the past to
> > indicate usage of long-deprecated APIs that we were getting close to
> > removing for instance. dev_warn() wouldn't have had the same effect.
> 
> If you want to reboot a box because someone called an "improper" api,

I don't "want" to reboot. It came as a side effect when panic_on_warn
was added, and worsened when its adoption increased. I won't argued for
or against panic_on_warn, but WARN() serves some use cases today that I
consider valid. If we want to discourage its usage, we need another API
to cover those use cases.

> then sure, use WARN(), but that feels like a really bad idea.  Just
> remove the api and fix up all in-kernel users instead.  Why wait?

There are multiple use cases. One of them is to make sure no new user of
the old, deprecated behaviour is introduced. This is especially
important when driver development spans multiple kernel releases, the
development can start before the API behaviour changes, with the driver
merged after the API change. This is something we've done multiple times
in V4L2.

> If you want to show a traceback, then just print that out, but I've seen
> that totally ignored as well, removing the api is usually the only way
> to get people to actually notice, as then their builds break.

Does your experience tell that tracebacks are routinely ignored during
development too, not just in production ?

-- 
Regards,

Laurent Pinchart

