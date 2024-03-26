Return-Path: <linux-kernel+bounces-118393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310788BA22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D491C31B49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DF12AAE2;
	Tue, 26 Mar 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ng1+AK/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29612A17C;
	Tue, 26 Mar 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432881; cv=none; b=VZ2pUrfK0MqMShHoXtUIBYnAJz39GU6cgSoW969dnjkLKY3aWNRPmTKxALv6YQrba0jyHttKWRx/DnjRjcd4/5BaP5UH/UAR2/oZtLFVjFNMgeS8wFkmWaGYbMPwl0sFkUVTr0DHP1QDTAgBm5vmhIqKYcn1c+QBRj5NQIwatcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432881; c=relaxed/simple;
	bh=qgGNM7YDx4QuvVzn2GLYxRd8W1OXbS051VV6j3gye+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCfnuJXBRA/iWKO2cgh0NR0VDhbQGV0A0NcOr9mzR1UbnIrKs17OdFkdy9EVDNM4H4dCO3U47UH2/Vb9IyuoPKuspe0eHQaANJdlIw/Qy0fIDvJ6NRVZfup9CyMs+AaiNxWMWF8aG9n7YMtHK5n3BisjzpqQWpxnX6Wyib4zmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ng1+AK/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42842C433C7;
	Tue, 26 Mar 2024 06:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711432880;
	bh=qgGNM7YDx4QuvVzn2GLYxRd8W1OXbS051VV6j3gye+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ng1+AK/AhaIZtK5RfYY79+Bb7IxC2A4RTCcElGzNrWmfLa2RqhhpTCWk8LXdeAF6i
	 R1PQ324trKJ0tdjQ8RZ5q5MW1GO+qrZnbTVAggb5FOlW85BmiEJCqWVY+hlXTplQHf
	 byNumE/KKNJQ/3Dnsf5CsL6I70IQT/KGSJRhAg6w=
Date: Tue, 26 Mar 2024 07:01:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shahar Avidar <ikobh7@gmail.com>, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: pi433: Fix includes & macros.
Message-ID: <2024032651-ankle-wireless-bec5@gregkh>
References: <20240324093201.793485-1-ikobh7@gmail.com>
 <ZgFBch_ccGnZBCmz@smile.fi.intel.com>
 <2024032520-implosion-living-d148@gregkh>
 <ZgHFbosacLDyhgaY@smile.fi.intel.com>
 <2024032504-unruly-starship-3967@gregkh>
 <ZgHMkIX6RvP5dqyp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHMkIX6RvP5dqyp@smile.fi.intel.com>

On Mon, Mar 25, 2024 at 09:12:16PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 07:51:16PM +0100, Greg KH wrote:
> > On Mon, Mar 25, 2024 at 08:41:50PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 25, 2024 at 07:05:46PM +0100, Greg KH wrote:
> > > > On Mon, Mar 25, 2024 at 11:18:42AM +0200, Andy Shevchenko wrote:
> > > > > On Sun, Mar 24, 2024 at 11:31:58AM +0200, Shahar Avidar wrote:
> > > > > > 1. Untangle include hierarchy. 
> > > > > > 2. Update #minors the driver can accept.
> > > > > > 3. Make use of general macro instead of magic number.
> > > > > 
> > > > > > Shahar Avidar (3):
> > > > > >   staging: pi433: Use headers in appropriate files.
> > > > > >   staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
> > > > > >   staging: pi433: Make use of spi mode macro instead of magic number.
> > > > > 
> > > > > For patches 1 and 3
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > That's impossible for b4 to parse, it would have applied this to all of
> > > > the commits if I had taken them :(
> > > 
> > > You can apply only patches 1 and 3 as long as they are independent to patch 2.
> > > 
> > > 	b4 am -st -P 1,3 ...
> > 
> > I don't do that, it would not scale at all :)
> 
> Yeah, this requires too much maintainer's involvement.
> 
> Alternative option, in case you are fine with patch 2, is to drop my tags and
> apply.

I wasn't fine with them, I'll wait for a new version of this series to
be posted before looking at them again.

thanks,

greg k-h

