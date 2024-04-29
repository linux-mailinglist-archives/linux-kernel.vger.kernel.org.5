Return-Path: <linux-kernel+bounces-161922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4897D8B535F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0111F21186
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25D17BC9;
	Mon, 29 Apr 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIUiM9cO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89B1773A;
	Mon, 29 Apr 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380293; cv=none; b=H/3/s5TNERzj+HIg+i3gnn+i8knarmcl80A2QdDdp/ydTEU8Nc9T9H7/E5Bl6CvfVgLzNHPyhqWtFYou1jcYSoNV+JSVUk1cG+hujbKrUmpjEa7ptzyRkCkRUOQK0spLnY6zftQmOyVAieFNiD1r7mrDF9j5TFXilYpgLg2sgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380293; c=relaxed/simple;
	bh=hKl+ddFweiXgM/nNkFP9yir7ry8EsSWt9YFq0r39Cyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgyI3Cf4JuS7Xr6sARfBCqHq6u2geeWxlGl7R8bHEG1WfvjB+ghoBWjazU2ogDM3N0YZq3T5C/v07+1xbClsM1uHgckK72zxF9z7KK7yLfBizxESRdiLvyQioU0xx/CaqEuEZP8Ic7qfs81+rPY7GtKOMi/biaYNTAKHazEydIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIUiM9cO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714380292; x=1745916292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKl+ddFweiXgM/nNkFP9yir7ry8EsSWt9YFq0r39Cyw=;
  b=KIUiM9cOvnxQv6HvFMIuwqQUcOaTK/AQGkkt76LX+nrdqEahoXagYicB
   KYEC23URVRYe3i2J9ROuz18ohN4zwpQijpIYRt5jY/cdyh/lr1WsFNxoQ
   Yx9oP0+Gf4vuWUef1d0Xzzj0mWb612uIoaBNMBRNwvwWaY+HElvAavlc4
   DW92YNJQPHhoTa3L3T0ni0avxT8bLpxeAEzg19g7tFhxvtlHvU2rQpusp
   fjzCFKCHHbGIHZpovRKGRM8EaTY0yWt5X5YL46wwy95mQ7SZymt+YUFjU
   Ic0bgqeCUMAR7gjZeNWZrhfWgrsiD0X1QFj73mjiE7ivLw2Lbs31Xc3rY
   w==;
X-CSE-ConnectionGUID: 9lBOt3H3Rw2wD1pTkIgO4A==
X-CSE-MsgGUID: ZadS+pj2SxOBvuiP8CGSDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13807782"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13807782"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:44:51 -0700
X-CSE-ConnectionGUID: M44kx3PiThKqJrrPXi7A9Q==
X-CSE-MsgGUID: lRoWaxVfSaKaTaCFY79CSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30702120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:44:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1Mcx-00000002G9e-1CEx;
	Mon, 29 Apr 2024 11:44:47 +0300
Date: Mon, 29 Apr 2024 11:44:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <Zi9d_4WUs9gows45@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <927c40c5-cfd7-4a22-a9c6-7b6f9592e4b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927c40c5-cfd7-4a22-a9c6-7b6f9592e4b0@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 29, 2024 at 09:35:18AM +0200, Krzysztof Kozlowski wrote:
> On 23/04/2024 15:19, Andy Shevchenko wrote:
> > The recommendation is based on the following rationale:
> > 
> > - it makes the commit messages much cleaner and easy to read, especially
> >   on the screens of the mobile devices;
> > 
> > - it reduces resources (memory, time, energy) to retrieve all these
> >   headers, which are barely needed by a mere user, as for automation
> >   they will be still available via mail archives, such as
> >   https://lore.kernel.org, assuming the Link: or Message-ID tag is
> >   provided.
> > 
> > Let's be environment friendly and save the planet!

..

> > +It's recommended to locate the additional Cc: tags after the cutter '---' line
> > +in the patches as it makes sure the commit message won't be polluted with them.
> > +At the same time they will be available via email headers on the mail archives,
> > +such as https://lore.kernel.org.
> 
> Manually added useful Cc-tags should be kept in commit msg, because it
> annotates who could be interested in the patch.
> 
> The problem is that people put output of get_maintainers.pl as Cc to the
> commit list. This is 100% redundant because it can be recreated any
> given time with 100% accuracy (for given kernel tree). Therefore I would
> propose to rephrase it to something:
> 
> ====
> It is recommended to not add autogenerated scripts/get_maintainer.pl
> CC-entries into the commit msg, but keep them under cutter '---'. There
> is no single need to store automated output of get_maintainers.pl in the
> git log. It can be easily re-created at any given time, thus its
> presence in the git history is redundant and obfuscates the log.

Right, but still even for non-automated output it might (may) be redundant,
however I can go for this compromise as most of the Cc indeed duplicate
the output of get_maintainer.pl.

-- 
With Best Regards,
Andy Shevchenko



