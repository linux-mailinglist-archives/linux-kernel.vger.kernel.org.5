Return-Path: <linux-kernel+bounces-149865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0F8A96F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01821C22034
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DA15B962;
	Thu, 18 Apr 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/RpJc/K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23115B55D;
	Thu, 18 Apr 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434732; cv=none; b=rVahcLSosSdFAq3YVdM9RQNxu64z5NKUi1Tr6xBRlavSFrmRJ9C+ud4Z0dwcSdtBOPBHyUA65ewlNzNG/5qd0aKCEcUceZrPmCuuKr1GK6cuhcTPNTZQnSxIKQINho2vYap3P6bIXEDaO0fhNKaJkr8le9q1TdMZNAYJaVYVmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434732; c=relaxed/simple;
	bh=ZVDmlHfsA6ASP3gtkKW9PH6qXzB94xtz3znACVrZ57Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DivQyBU0MBSDnwqPzvaN2HgmAbnXGHwtRlpMrJmnFacs+7Im8ZbtL28LSDsPl3FK55xb0Sc1CifxAZl0t4Yurn+sZ3ZTrTA8OGdJyBObt9LPDEKRktCn5pCFc0qrrjG0W6tG8Xz/vvu6CF/pxSpTLQGpTcOcdUZvCnFfPiaxlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/RpJc/K; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713434730; x=1744970730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVDmlHfsA6ASP3gtkKW9PH6qXzB94xtz3znACVrZ57Q=;
  b=X/RpJc/KdnEaklXNMyMZ2CZinVgsiD4tqCGwm4OquMjENJNqaCGeanF5
   v0Dg/joczBd3bdtcuWaDzWELVR4aMqIbZGdU8Ug7F6gozcvNsGfoHwdUx
   xjcvzddHOrKtA7t+1ybY2/5fGixyFHR8+uWD1l2tIUXDKOzdLXydQLTgi
   rPOiS1xfaiM+JbVvnrLHwOE215Mh9q7aLfREVDfhLgJyGQ7FleVga/Nbx
   GXd5u+i+plj95BpZdCsrEHWG7RkhtCSK2epiTD5/LRRjpups0t4YSzTOw
   6XZIHZ/83rBpKTfCe9lS3ADv7Osp5Ik8WdZ9ZiFnqWt8osTLJZxs2xj6a
   A==;
X-CSE-ConnectionGUID: 64S/wltrQLuUZNCj0+D/1w==
X-CSE-MsgGUID: Sz/y8zeZRyu1woe+o9mAjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="11914747"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="11914747"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 03:05:29 -0700
X-CSE-ConnectionGUID: MgzVA2yhRaWsJua/oiLlRA==
X-CSE-MsgGUID: 80JK7GM9QKC9OXLjhRS1hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="60356866"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 03:05:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rxOdw-00000000IAL-367P;
	Thu, 18 Apr 2024 13:05:24 +0300
Date: Thu, 18 Apr 2024 13:05:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zeng Heng <zengheng4@huawei.com>, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
	linux-gpio@vger.kernel.org, weiyongjun1@huawei.com,
	liwei391@huawei.com
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <ZiDwZGY-MF5OdVmH@smile.fi.intel.com>
References: <20240415105328.3651441-1-zengheng4@huawei.com>
 <Zh_rM04PspfXxlv_@smile.fi.intel.com>
 <d80e09d8-5f35-4865-9fe8-195b86527972@moroto.mountain>
 <ZiAC9zzSWume8063@smile.fi.intel.com>
 <fe83e07f-ca28-4c00-9b1b-7d16c63bad62@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe83e07f-ca28-4c00-9b1b-7d16c63bad62@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 08:49:42PM +0300, Dan Carpenter wrote:
> On Wed, Apr 17, 2024 at 08:12:23PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 17, 2024 at 06:38:46PM +0300, Dan Carpenter wrote:
> > > On Wed, Apr 17, 2024 at 06:30:59PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Apr 15, 2024 at 06:53:28PM +0800, Zeng Heng wrote:

..

> > > > >  	for (state = 0; ; state++) {
> > > > >  		/* Retrieve the pinctrl-* property */
> > > > >  		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
> > > > > -		if (!propname)
> > > > > -			return -ENOMEM;
> > > > > +		if (!propname) {
> > > > > +			ret = -ENOMEM;
> > > > > +			goto err;
> > > > > +		}
> > > > >  		prop = of_find_property(np, propname, &size);
> > > > >  		kfree(propname);
> > > > >  		if (!prop) {
> > > > >  			if (state == 0) {
> > > > > -				of_node_put(np);
> > > > > -				return -ENODEV;
> > > > > +				ret = -ENODEV;
> > > > > +				goto err;
> > > > 
> > > > Has it been tested? How on earth is this a correct change?
> > > > 
> > > > We iterate over state numbers until we have properties available. This chunk is
> > > > _successful_ exit path, we may not free parsed maps! Am I wrong?
> > > 
> > > In this path state == 0 so we haven't had a successful iteration yet.
> > 
> > Ah, indeed, this is not a status. Okay, makes sense, but calling that free
> > function for the purpose of the putting of_node seems an overkill...
> 
> Sure, that's one way to look at it, but it's suspicious looking when
> there is a direct return which is surrounded by gotos.  As I write this,
> I remember that Smatch has a warning for code like that.
> 
> Probably we should add a comment to say:
> 
> 	/* Return -ENODEV if the property 'pinctrl-0' is not present. */

Good idea, go for it!

-- 
With Best Regards,
Andy Shevchenko



