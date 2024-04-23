Return-Path: <linux-kernel+bounces-155530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4438AF39C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF4F1C2351B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4113CF8E;
	Tue, 23 Apr 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJQYKDW7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018413BC29;
	Tue, 23 Apr 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888781; cv=none; b=T0zYpUXm5CFNdzOoPCEhO4YGADNIg1sB2ZiiFfdB79rEt6F4ItkENkEc0yQdmBMYLnjToJPE/VCl7RuRJGJpb66qudVwXudkqXUCsIlVRLjrTEn/6l785dRSa0JfHYZJrouv36nVCo76TCql42aGdozx2Fsm2ddwtcB88xMMChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888781; c=relaxed/simple;
	bh=JMZZ3gcVPa767Qfvto7OizS7Ykmh/j3FMPZAU0c0ugo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvqm9LMdtulr/9v2KZgcWxJBe9NPyMwUcUoJyIPqGHlXxAVxW/O9u+ennew0EvGrAZsBnRpr2nRjiYgnyApIzP60UwOEVLBC6udjHRZmz86xUWLmTJLCCYQmgV/vAIZVza3MJWTz40fI44DeuP6M86QeMI34O0mAwBs8ZzezN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJQYKDW7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888781; x=1745424781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMZZ3gcVPa767Qfvto7OizS7Ykmh/j3FMPZAU0c0ugo=;
  b=TJQYKDW7hRUH+grS771+QijZFsDN2haWlqQCVdWfbX3AKLX3qQbs/4zv
   LHbcdqIZGz2nnqSiYRiq4VhtW5r4K9c1MfQfjzFWQtzD0MSm+duBRDBf2
   dinVDKSfyKK/D/V4N0QX8WO8aSFAkIFSeKjs41Dl2jXOaHm9Jxy0viGWc
   o22UXUy+Ghnbt/axfSzxtjJLIozAp6ptANIdVD9I4Iucc1HVogU4j3pGL
   DUSxebi9n3tk5kRtsGVba8Gtv4XK53CGaFOkrb3XW8bm0jJmlrhHwdN6L
   38ktzotJZoA6d5SZarr60PX4LLpskocMxAMJIaCdNxCAfYE0zbLdz1cSc
   w==;
X-CSE-ConnectionGUID: p8/idohpR/yurdHn4MRnMw==
X-CSE-MsgGUID: x4cSMRywScGQQTGMuKhd2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26941405"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26941405"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:13:00 -0700
X-CSE-ConnectionGUID: xqtEIRwNTm+zTkhisprLFw==
X-CSE-MsgGUID: o7ULhN2uT76//FgyuiluyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24934354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:12:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzIlL-00000000O7B-3IDM;
	Tue, 23 Apr 2024 19:12:55 +0300
Date: Tue, 23 Apr 2024 19:12:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <ZifeB_7DLa10BU__@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <2024042347-ellipse-overeater-9aff@gregkh>
 <ZifTrD-jY1LZIyfs@smile.fi.intel.com>
 <2024042317-wolf-condition-dd5f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024042317-wolf-condition-dd5f@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 09:07:09AM -0700, Greg KH wrote:
> On Tue, Apr 23, 2024 at 06:28:44PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 08:13:37AM -0700, Greg KH wrote:
> > > On Tue, Apr 23, 2024 at 04:19:38PM +0300, Andy Shevchenko wrote:
> > > > The recommendation is based on the following rationale:
> > > > 
> > > > - it makes the commit messages much cleaner and easy to read, especially
> > > >   on the screens of the mobile devices;
> > > 
> > > Reading commits on a mobile device is not what kernel development is
> > > optimized for, sorry.
> > 
> > The commit messages not always for the kernel development, some people may read
> > them in order to understand code better or many other reasons. I.o.w. it's not
> > the point.
> > 
> > > > - it reduces resources (memory, time, energy) to retrieve all these
> > > >   headers, which are barely needed by a mere user, as for automation
> > > >   they will be still available via mail archives, such as
> > > >   https://lore.kernel.org, assuming the Link: or Message-ID tag is
> > > >   provided.
> > > > 
> > > > Let's be environment friendly and save the planet!
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  Documentation/process/5.Posting.rst          | 4 ++++
> > > >  Documentation/process/submitting-patches.rst | 5 +++++
> > > >  2 files changed, 9 insertions(+)
> > > 
> > > This breaks my existing workflow, sorry.  I can't track cc: below the
> > > --- line because obviously, git cuts that off.  So I put them above
> > > where git send-email can see them,
> > 
> > git send-email _sees_ them very well there.
> 
> Sorry, yes, but git itself can't track them in the commit when I
> rebase/squash/redo/etc.  That's the point I was trying to make before my
> coffee kicked in...

It can in your _local_ repo if you have it as

  Signed-off-by:
  ---
  Cc:
  Cc:

in the commit message. It won't go to the final commit message if you sending
it out and apply via `git am`, or reapply with the latter locally instead of
cherry-picking.

-- 
With Best Regards,
Andy Shevchenko



