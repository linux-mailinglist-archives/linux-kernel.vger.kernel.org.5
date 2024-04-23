Return-Path: <linux-kernel+bounces-155521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E58AF37F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32776B2511D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731C13CA85;
	Tue, 23 Apr 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvPB2hPk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF113CA89;
	Tue, 23 Apr 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888440; cv=none; b=Oe/XumGzoIPwsPRiyRWCfHfJu6Yh/W77aE+8Vor96WBzqXzOb6J2O/V6B2XrmujaSjVyinLB6HKdEzu+FG8vy7s9xplBmNsJmP3V52RCz7lghAXIhA15KogiBhoEaIOA1d+ns5H3zJwrjxkETNsGYImPmXCOZeFaBFVUVRdDZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888440; c=relaxed/simple;
	bh=8iQx8KlYOrmnV0TdoWdZZ7Rb29HLI1k+ibkPNJAowQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyCUkBocw2WUsVJcaA6mYxSZgCpG18dEGu97Ytr8Hbw2/YmoIp1rVOrr7zizBH70p0Il506fT0atCkCshQh1/4MtB61yAqMUVYlk4ptfwSySjwdY+2EpWh9q75HoTPlaECGXJCM9Gv1BK14ilUx9W5EJUc2sGaHmetXfrV8kDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvPB2hPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601B0C116B1;
	Tue, 23 Apr 2024 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713888439;
	bh=8iQx8KlYOrmnV0TdoWdZZ7Rb29HLI1k+ibkPNJAowQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvPB2hPkh/CwerF2ivKtVNxZeNZ/bJ8VPVyp7VIrFyY529DnH2JTzjR2SdtQAWl+b
	 fKfBhnMCB+mLtxbCkZJqqhxYYIR261/Sdbsic6DrUmHwCBauU4lPmlv94YqzMK6+mw
	 taITJ4k/p2WCEMQ6e/zmlulGekRjRkoWDwgcIzp0=
Date: Tue, 23 Apr 2024 09:07:09 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <2024042317-wolf-condition-dd5f@gregkh>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <2024042347-ellipse-overeater-9aff@gregkh>
 <ZifTrD-jY1LZIyfs@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZifTrD-jY1LZIyfs@smile.fi.intel.com>

On Tue, Apr 23, 2024 at 06:28:44PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 08:13:37AM -0700, Greg KH wrote:
> > On Tue, Apr 23, 2024 at 04:19:38PM +0300, Andy Shevchenko wrote:
> > > The recommendation is based on the following rationale:
> > > 
> > > - it makes the commit messages much cleaner and easy to read, especially
> > >   on the screens of the mobile devices;
> > 
> > Reading commits on a mobile device is not what kernel development is
> > optimized for, sorry.
> 
> The commit messages not always for the kernel development, some people may read
> them in order to understand code better or many other reasons. I.o.w. it's not
> the point.
> 
> > > - it reduces resources (memory, time, energy) to retrieve all these
> > >   headers, which are barely needed by a mere user, as for automation
> > >   they will be still available via mail archives, such as
> > >   https://lore.kernel.org, assuming the Link: or Message-ID tag is
> > >   provided.
> > > 
> > > Let's be environment friendly and save the planet!
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  Documentation/process/5.Posting.rst          | 4 ++++
> > >  Documentation/process/submitting-patches.rst | 5 +++++
> > >  2 files changed, 9 insertions(+)
> > 
> > This breaks my existing workflow, sorry.  I can't track cc: below the
> > --- line because obviously, git cuts that off.  So I put them above
> > where git send-email can see them,
> 
> git send-email _sees_ them very well there.

Sorry, yes, but git itself can't track them in the commit when I
rebase/squash/redo/etc.  That's the point I was trying to make before my
coffee kicked in...

thanks,

greg k-h

