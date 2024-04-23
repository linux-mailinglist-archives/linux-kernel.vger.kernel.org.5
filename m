Return-Path: <linux-kernel+bounces-155474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E88AEB05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FCA3B22847
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDAB13C66C;
	Tue, 23 Apr 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acvuE8pF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F925FDA6;
	Tue, 23 Apr 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886130; cv=none; b=HPtZMzJ97KEGhnw/WI5mN+c2zPMndlAM1EfV9uhphMsyZ5D7RgaRGgpdUKKlWKR84V9yGLfisSbP9pEY82qLZwjPz4fTUf9iL85h+iVtD2G+mL76M8vBERzQ4NTzP1uzrh/cbddGA4c6fVQNj7EDhGy84yQUafpWyDYekTBBT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886130; c=relaxed/simple;
	bh=b2hdcRjk2UI+cmL/UIloH6qLoxe82MU3yxaag3Tg+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LusU325tBNfMttZs6j/NwsaZacd6OU1JR2u9GL4SZ+jS4MCgvwFVpuhcWeAzjmmQwYEpmkguoEdN+m/JPUO78pf9/pP7RkhYV2B7sf7P7UiZQU2K5MxfMsZfHpb1A3YqJL5aKIAECtgLK8u6gt1QQN2CmH24eOYj6m1imXvUCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acvuE8pF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713886129; x=1745422129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2hdcRjk2UI+cmL/UIloH6qLoxe82MU3yxaag3Tg+HY=;
  b=acvuE8pF1Y3VuZxF7LV1RPDqs5bgPZwiEsfdI3qZ0b+eZu5JTobbD9sk
   Czssqvn3MVE0ePeXcF4ZGqQ+qYkVdv5+sVAWAXsxAd8GyU/rgARnxI1BA
   /tuZYVhPiQ+3llJ8HqTIGAiWtQ2eKN0qgeGtcRjCtZThpOeRWhoJ59IAp
   BdQ/pM9gu70Cjg9GEX+u87/UIyZQZjQsgdqQyQYiBEszYnY1XG5c41qrm
   R38kEwu+SYuHOr2G9i6ElqK/TbGhkn3y0brAmGF20Hnfq6+z1v7YkUKYC
   6BH4lLn77aOSk/IL4NsNX2ZhZrtRAN7xrtiRrKL7tnfO2XFmSRpdwRz6Y
   w==;
X-CSE-ConnectionGUID: VC6Jxaj6SOuelSnD74Q1TQ==
X-CSE-MsgGUID: mHFXQYZfTR+Y2lzXGaoxFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9647458"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9647458"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:28:48 -0700
X-CSE-ConnectionGUID: jzqYOQiTTBOQ6VsOqB1vUA==
X-CSE-MsgGUID: nub6UW4gRCax6pfcX5DoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47684757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:28:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzI4a-00000000NO2-3Fd7;
	Tue, 23 Apr 2024 18:28:44 +0300
Date: Tue, 23 Apr 2024 18:28:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <ZifTrD-jY1LZIyfs@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <2024042347-ellipse-overeater-9aff@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024042347-ellipse-overeater-9aff@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 08:13:37AM -0700, Greg KH wrote:
> On Tue, Apr 23, 2024 at 04:19:38PM +0300, Andy Shevchenko wrote:
> > The recommendation is based on the following rationale:
> > 
> > - it makes the commit messages much cleaner and easy to read, especially
> >   on the screens of the mobile devices;
> 
> Reading commits on a mobile device is not what kernel development is
> optimized for, sorry.

The commit messages not always for the kernel development, some people may read
them in order to understand code better or many other reasons. I.o.w. it's not
the point.

> > - it reduces resources (memory, time, energy) to retrieve all these
> >   headers, which are barely needed by a mere user, as for automation
> >   they will be still available via mail archives, such as
> >   https://lore.kernel.org, assuming the Link: or Message-ID tag is
> >   provided.
> > 
> > Let's be environment friendly and save the planet!
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/process/5.Posting.rst          | 4 ++++
> >  Documentation/process/submitting-patches.rst | 5 +++++
> >  2 files changed, 9 insertions(+)
> 
> This breaks my existing workflow, sorry.  I can't track cc: below the
> --- line because obviously, git cuts that off.  So I put them above
> where git send-email can see them,

git send-email _sees_ them very well there.

> AND where git can handle them when I
> rebase/revise/etc.

> Also, as Jon points out, the "environmental" argument seems very odd,
> it's not like bits cost more to send around (they keep getting cheaper
> in power and money), and processing power is pretty constant for servers
> handling email, so I don't understand the power consumption argument.
> Without some sort of data to back that up, I'd be loath to repeat it.

-- 
With Best Regards,
Andy Shevchenko



