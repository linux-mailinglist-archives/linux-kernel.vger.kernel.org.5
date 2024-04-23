Return-Path: <linux-kernel+bounces-155384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F868AE9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEA11F2509F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FC84FC5;
	Tue, 23 Apr 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCacEaZ6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81C1B815;
	Tue, 23 Apr 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883045; cv=none; b=buBE2uMWrOuodH1QsLApXhGMyU/YO4QLGixkwnHxsVPiHRCTNG6AccyCPPj+QZsUJUnbajeXiZ/hUcFn4xTZQvG+m90iaP2Lvb9sQtBWZBJXOMJ3hJXYxdlAKQKmw7RqIWIvF+fY/S8+scQAMB4gmghERmZGz1IKGsXOF07173g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883045; c=relaxed/simple;
	bh=aQ0ENn3iVqRW6h2IWGFzijLW4RgbLKhy6rpRynm6x78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEaPzoY+4riQq3OwfRP860/y4Lxj22I/nb0Za6qmhcWoUCXCrKOJ1eYVym+stl0sfr4YYCVTAPFn6WMnETBXnW88tsz7Smkw5i3qyHhue5DtFf/esFYA4hBmu7LFFxXl5UZqjYhiExpxbfpAwPZX+Y99q5nneMjKPytMEt0bqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCacEaZ6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713883044; x=1745419044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQ0ENn3iVqRW6h2IWGFzijLW4RgbLKhy6rpRynm6x78=;
  b=UCacEaZ6N08Cck0AM7f5UwyU2mFo1KreycV8ww+EozEMCw4uV47KowHC
   g1nae74Hp4+JS5jyq+vtaC8CS3tdDFTkm8CJG2sMiGKkJV0e8/FDgeXT+
   IoRmTFPN0vwxCnzvHswf/dYAKHgM//V1+mZS0gwS1Yb8xiIW5GhrQfKFi
   72NpOBY2u4dKmlarkGJZqc9Nhe9PqVJ5ABstPPKU+x5AYMcka+ls33kO4
   fCZwl7e8UBwuJn3C3LcOfxP15WcUIwbL/ZPKLUSEOVRxw9O0q9s155qV+
   mdO5AbaT9SlQQw9wklogmnyEWZCheO3TSMMrNlccYkqOLQSyolVvqLtoQ
   A==;
X-CSE-ConnectionGUID: PH0kRgA6Q82d8N0cHVDMOw==
X-CSE-MsgGUID: zLzZScFDSgym8lRzbLhrAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26985765"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26985765"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:37:23 -0700
X-CSE-ConnectionGUID: q3ocQ6L1QgiwX8xh61lC4w==
X-CSE-MsgGUID: j+UE+l6OSEmPziXhflB1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24436634"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:37:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzHGq-00000000Mdk-0WKi;
	Tue, 23 Apr 2024 17:37:20 +0300
Date: Tue, 23 Apr 2024 17:37:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <ZifHnw1cxgP77MKx@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q6wrw12.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 05:30:49PM +0300, Jani Nikula wrote:
> On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
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
> 
> I find the information in the commit message useful, and it tells me who
> were explicitly included in the discussion.
> 
> For example when fixing a regression I'd like to Cc everyone who was
> Cc'd in the regressing commit. The drm subsystem maintainer tool
> actually has a helper for doing just that. 'dim fixes <sha1>' digs up
> all the relevant info.

> The Cc's on the mailing list archive are harder to dig up, and do not
> accurately reflect the same information.

How comes? These Cc: are 1:1 mapped to the Cc: email headers.

> A lot of patches get sent with
> more Cc's in the mail message than in the commit message.

Note, this is the recommendation as it's stated. You can continue polluting
the environment on your wish.

> > Let's be environment friendly and save the planet!

-- 
With Best Regards,
Andy Shevchenko



