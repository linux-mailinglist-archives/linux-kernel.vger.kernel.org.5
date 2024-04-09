Return-Path: <linux-kernel+bounces-136222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B989D169
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2748A285FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98456465;
	Tue,  9 Apr 2024 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dm9GGJv3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4473F54776;
	Tue,  9 Apr 2024 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636005; cv=none; b=ggNxQRi6Vv5IGI4vWR2jg8HKVjGuoCxvUo5VZSehu3jUjP7UeIaLsdPjBk6JaRQhrFMHAhZD55JSlCogls5HiBWlM7mqeG4Zg0cjZJdIiMoolZF/Lseq9PJuyY2XoVOXKkrXrtDKIDPR9XGlykkzW7JCkTY6JezLwliwzt2pH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636005; c=relaxed/simple;
	bh=I0lKHzWxV6MoeO1Jk7W7Gqe1Y/mtW/GBhIxKaLefX84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6qlU5FjYLzf5GJDz5C74vL4EG1VK3Lz6ZzwSBic5yv2l4zR3crc+AsbomMzFXGIsGBJzLusgLF0z1o450tV8Su139wpNna4gZryBUhe5dVy3CjqvRLKrA4nD+Cmy+Bc0/FTQ7+zTpufLfHVAX7jNDj97Dh9wwldW3yiN7mfkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dm9GGJv3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712636003; x=1744172003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I0lKHzWxV6MoeO1Jk7W7Gqe1Y/mtW/GBhIxKaLefX84=;
  b=dm9GGJv3c8F1BaNPjQzf073dXsyymv7Englia+ILTWta8axP3LGkljWB
   UkKRHslcxsN0MT0FZsSnMFXQxGvsj1w6oCdc+xOlHh9w+2j0uxyaa8yZn
   U0JcE/cQY+BLGse9aSERyj/LVnj5mGws8VrPuF1tYisq5svXJyoiKX79e
   5HYJBcl3bzwAd/kozgEZHCVDabaHh5fwFbmxh3DAoWzR4+wfFUSaGpFPf
   T3s+IObw++mNBMlLpjXsJjasx5PF7PlnQGa1qeoZisVdtCWSMVdsPiyqs
   /iHfkbIYTDtljU8yf+QXB2qhhmIlAq6LAruJaK49qwch9KnU/eCLmVtfw
   Q==;
X-CSE-ConnectionGUID: RmP73uyjQbq13a3Wl16R3A==
X-CSE-MsgGUID: lMgcTiffR/CiwZA8xI5u2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="10912146"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="10912146"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 21:13:22 -0700
X-CSE-ConnectionGUID: 8otu2vYHTKaYIvkqvISh/w==
X-CSE-MsgGUID: 1uL0Mak2TpW3LOK/4aZpRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24588022"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 08 Apr 2024 21:13:20 -0700
Date: Tue, 9 Apr 2024 12:08:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: region: add owner module and take its refcount
Message-ID: <ZhS/M6pa9AHyvb0y@yilunxu-OptiPlex-7050>
References: <20240327160022.202934-1-marpagan@redhat.com>
 <Zgp/jNst2yuXEbpU@yilunxu-OptiPlex-7050>
 <64c1685a-b544-408e-97e4-8c3cff6aca6c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c1685a-b544-408e-97e4-8c3cff6aca6c@redhat.com>

On Wed, Apr 03, 2024 at 03:34:22PM +0200, Marco Pagani wrote:
> 
> 
> On 2024-04-01 11:34, Xu Yilun wrote:
> > On Wed, Mar 27, 2024 at 05:00:20PM +0100, Marco Pagani wrote:
> >> The current implementation of the fpga region assumes that the low-level
> >> module registers a driver for the parent device and uses its owner pointer
> >> to take the module's refcount. This approach is problematic since it can
> >> lead to a null pointer dereference while attempting to get the region
> >> during programming if the parent device does not have a driver.
> >>
> >> To address this problem, add a module owner pointer to the fpga_region
> >> struct and use it to take the module's refcount. Modify the functions for
> >> registering a region to take an additional owner module parameter and
> >> rename them to avoid conflicts. Use the old function names for helper
> >> macros that automatically set the module that registers the region as the
> >> owner. This ensures compatibility with existing low-level control modules
> >> and reduces the chances of registering a region without setting the owner.
> >>
> >> Also, update the documentation to keep it consistent with the new interface
> >> for registering an fpga region.
> >>
> >> Other changes: unlock the mutex before calling put_device() in
> >> fpga_region_put() to avoid potential use after release issues.
> > 
> > Please try not to mix different changes in one patch, especially for
> > a "bug fix" as you said.
> 
> You are right. I'll split out the change and eventually send it as a
> separate patch.
> 
> > And I do have concern about the fix, see below.
> > 
> > [...]
> > 
> >> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
> >>  	}
> >>  
> >>  	get_device(dev);
> >> -	if (!try_module_get(dev->parent->driver->owner)) {
> >> +	if (!try_module_get(region->br_owner)) {
> >>  		put_device(dev);
> >>  		mutex_unlock(&region->mutex);
> >>  		return ERR_PTR(-ENODEV);
> >> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
> >>  
> >>  	dev_dbg(dev, "put\n");
> >>  
> >> -	module_put(dev->parent->driver->owner);
> >> -	put_device(dev);
> >> +	module_put(region->br_owner);
> >>  	mutex_unlock(&region->mutex);
> > 
> > If there is concern the region would be freed after put_device(), then
> > why still keep the sequence in fpga_region_get()?
> 
> Ouch, sorry, I forgot to make the change also in fpga_region_get().
> 
> > And is it possible region is freed before get_device() in
> > fpga_region_get()?
> 
> If the user follows the usual pattern (i.e., waiting for

I can see the only safe way is fpga_region_program_fpga() or fpga_region_get()
should be included in:

  region = fpga_region_class_find();
  ...
  put_device(&region->dev);

That is to say, fpga_region_get() should not be called when there is no
region dev reference hold beforehand. In this case, no use after release
risk. That's why I was thinking about some documentation.

Another concern is we'd better keep the get/put operations symmetrical
for easy maintaining, as long as it doesn't cause problem.

Thanks,
Yilun

> fpga_region_program_fpga() to complete before calling
> fpga_region_unregister()) there should be no problem. However, I think
> releasing the device before unlocking the mutex contained in the context
> associated with the device makes the code brittle and more prone to
> problems.
> 
> > Or we should clearly document how/when to use these functions?
>  
> I think it is not necessary to change the documentation since the
> in-kernel programming API will not be affected by the change.
> 
> Thanks,
> Marco
> 

