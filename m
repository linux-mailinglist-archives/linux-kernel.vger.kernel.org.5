Return-Path: <linux-kernel+bounces-166776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50E8B9F62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF37B2103F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E916FF3C;
	Thu,  2 May 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/IKTubw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8816D4C0;
	Thu,  2 May 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670574; cv=none; b=DAYp9Pq3nyxQGPMU3wChAM5cSUqep6k7vjoN11LtHOXo3/gzT3C+E9VlQhOMUnY06ye0nJhGymYxtH9f9sr7E8lGGJ5iDKjL821s/zlKkFlA8I5spRd40twbSx/7UUAvqDLWib0oAfjgUbBbDEVAvy0CWFxwph4n6k7pDSkYlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670574; c=relaxed/simple;
	bh=xxnRKRRsdiWLKlOgW8fmndRPG/Gun2yKWKn7YZ5of50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnXIadmIHEBQinxCRiYvQaraXyoiQBTghVbnQsd3GHxVfmX2RVug6yRlhrFHXBY5O5vPsaX4EyHXxQnTlm2EDN8iEKDysYcz+l3lA3xPs0wABeGSjkxiu+qVlT8A5YpTD/+2A5pljLIgmx29Tid+VhaSLNzayMAoIRU1boEBakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/IKTubw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714670572; x=1746206572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xxnRKRRsdiWLKlOgW8fmndRPG/Gun2yKWKn7YZ5of50=;
  b=B/IKTubwUDyIkmrSD+oGIPGtSgkysy0lGJMPjO2U7M8Wvq0V+tmOapGN
   m+vIvKlUEB/SAolxb+KjFoR8ntohzZ8+aWDCjieI7y5m1r1aROIp8npa5
   NK6JCugqJ2sM6juvKuM9Qe38bC7DbtTA6wf9NxIeiEkRIiCWyk9nfnt7t
   lcpeVd+xROUsK2faVNQ46XBCajEL/o1oGAs2nW+94xcXxDuxyNENYIjHb
   C2EofbcNR39DjPDQtVjSMV0MhM/0zXwWbXcB6huiBdBcFoIA1CTVIJbZ9
   RwTHk4SZKC2bKDmU25CE7IA/2TEcLm8TrnG/T+Lhfrbp6o8znu8sppWAQ
   w==;
X-CSE-ConnectionGUID: 67blkTPYSyu7Imb1EFavCA==
X-CSE-MsgGUID: wIu9iSBRTWGw/UQrn9wrCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10577993"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10577993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:22:52 -0700
X-CSE-ConnectionGUID: UDIwUJVaSWKh+oGahgMqJg==
X-CSE-MsgGUID: 5lm7PBVdS4K5zd38mdUaCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27199840"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:22:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2a8u-00000003Ojo-0Jhe;
	Thu, 02 May 2024 20:22:48 +0300
Date: Thu, 2 May 2024 20:22:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502114645.4445b3da@SWDEV2.connecttech.local>
 <ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
 <20240502120840.02c65f30@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502120840.02c65f30@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 12:08:40PM -0400, Parker Newman wrote:
> On Thu, 2 May 2024 19:01:01 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > > On Thu,  2 May 2024 17:43:54 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > After a rework for CONNTECH was done, the driver may need a bit of
> > > > love in order to become less verbose (in terms of indentation and
> > > > code duplication) and hence easier to read.
> > > >
> > > > This clean up series fixes a couple of (not so critical) issues and
> > > > cleans up the recently added code. No functional change indented by
> > > > the cleaning up part.
> > >
> > > Just an FYI I submitted a patch series that fixed several of these issues but I
> > > think it fell through the cracks (I know everyone is very busy!).
> > >
> > > Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pnewman@connecttech.com/
> > >
> > > I believe my previous patch series is no longer required. This one fixes
> > > everything.
> >
> > I haven't noticed that, if it contains duplicated patches, I may replace mine
> > with yours if you insist.
> >
> > In any case it's better to reply there that you prefer this series to be
> > applied, so Greg will not pick it up.
> >
> 
> I do not have a preference. I am fine with using yours if it is easier on
> the maintainers.

Up to you, there is no issue to take your patches in case they are the same
(or quite similar) as mine. I can pick them up, just tell me if you want this
to happen with a list of the patches (as mail Message-Id).

> I will send a reply on my previous series that it is not needed and link
> to this. I am new to the mailing lists so I didn't know what the procedure
> is for this situation.

It's not about mailing lists, it's just a common sense.

> Thanks for the fixes :),

You are welcome!

-- 
With Best Regards,
Andy Shevchenko



