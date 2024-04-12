Return-Path: <linux-kernel+bounces-143114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C98A347A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74D21C2337A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8614D702;
	Fri, 12 Apr 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b10B7Zi0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566A14D431
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941657; cv=none; b=IS1pykVbykByu+dsbWPP6RHIkPxJpYVrlTA7RR+HUH08A9gey1Umz/W3gxZvs5lL5CSAChHWbo1A8DlIbHNQNXrb2RjspC9xazhChv+nu8uEl9MNgFlKyhs3eL0HuBVfjN6S/gecMq880S2LaR5I+VUKJE0cuaWb1/0PZRQvtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941657; c=relaxed/simple;
	bh=B04EjOgsZVPqyEh4DH0TEKubNhHXrgRXG0HP80hbpPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWMORwkRYH2uRFLVhYyYRLO8AeL+IBNMfGrSFechGJ1zkbQJZCZkqdeHlRRmD93GQqrExXuV8wK+aJ4KoZB/sIXAv3FOmPO4eJkWeodW4AJqjddTVNlP52KJo29hJAtato29yFmO+9gsG+ZjYJ7kanASkI72j9JN4a1HWmjJ6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b10B7Zi0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712941655; x=1744477655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B04EjOgsZVPqyEh4DH0TEKubNhHXrgRXG0HP80hbpPM=;
  b=b10B7Zi0lnKMtSy1RA3NDLHw5qy0Ro2cTRDPrw6o0VSlaIGrw0w4BAQS
   jPdQj6EGPuo+IU5mAyHu9bsW6rwx5frf03ioygOtaQukmujVEhZIgSfid
   yfi+luUfQ1ZGEXw5AqeG3cUpS1hBpnJy8aPEyen6IldC8YOqQtO9RFsJv
   DGHWO7F7/YOVhtKKJG4oy73A4Mx1XJfNmLV3toAiqaVGghKzwbnQik9r3
   Uoj7XVzN0wLl5iHCipNxd9rYMOAtBIMo3MUbhRhYAAwQdGTDwl88ncslo
   tNcNc68Sr70Xxb85h8KY38z65cA3HbdXsF2enMdlXLeDZBBbeSsb/kykD
   A==;
X-CSE-ConnectionGUID: Rd8mZuETSky9+C9Yn7z5CQ==
X-CSE-MsgGUID: MBIRj0M3SEiXo6L2IlDyoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8958757"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8958757"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:07:34 -0700
X-CSE-ConnectionGUID: 1+gUySJsSrWAvD9uZENAsg==
X-CSE-MsgGUID: 8FxrbthFQo6bvN8zu8QswA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25976939"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:07:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvKN8-00000003iHk-0Gx1;
	Fri, 12 Apr 2024 20:07:30 +0300
Date: Fri, 12 Apr 2024 20:07:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <ZhlqUdywIur4dzgE@smile.fi.intel.com>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
 <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
 <cl5fmton3n5ayzr7ondnw7lzjaxoppyqhnoervj2fn4et75ish@cyko4abxbslg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cl5fmton3n5ayzr7ondnw7lzjaxoppyqhnoervj2fn4et75ish@cyko4abxbslg>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 07:03:01PM +0200, Uwe Kleine-König wrote:
> On Fri, Apr 12, 2024 at 07:51:48PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 12, 2024 at 06:44:05PM +0200, Uwe Kleine-König wrote:
> > > For an out-of-memory error there should be no additional output. Adapt
> > > dev_err_probe() to not emit the error message when err is -ENOMEM.
> > > This simplifies handling errors that might among others be -ENOMEM.

> > ...
> > 
> > 	BUILD_BUG_ON(err == -ENOMEM);
> > 
> > Done!
> 
> Well no, that doesn't do the trick. Consider for example device_add().
> That function can return (at least) -EINVAL and -ENOMEM. To properly
> ensure that the error handling is silent with the current
> dev_err_probe(), we'd need to do:
> 
> 	ret = device_add(...);
> 	if (ret) {
> 		if (ret != -ENOMEM)
> 			return dev_err_probe(...);
> 		else
> 			return ret;
> 	}
> 
> With my suggested patch this can be reduced to:
> 
> 	ret = device_add(...);
> 	if (ret)
> 		return dev_err_probe(...);

Fair enough, but these two should be combined.
Mine is for the rejecting a dead code on the phase of the submission.

-- 
With Best Regards,
Andy Shevchenko



