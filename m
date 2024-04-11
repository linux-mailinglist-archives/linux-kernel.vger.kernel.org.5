Return-Path: <linux-kernel+bounces-140151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24C8A0C18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B371F216AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B541442FF;
	Thu, 11 Apr 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoIk+CP1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21A143C51;
	Thu, 11 Apr 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827012; cv=none; b=pws5G/Q+a5cCyxCpBBvyAzjOccgB9ocolGtMdFijgjCzt8rOABjONtO7B3GrIqAZjb7oeBDct+dIbM1i1fjypAYJh6EL/lZlTLoSUJGGbVUE/NYrGZGMk/MqsUGEw6Si+uJ70aaxhFiBjxYrJdRmCOQG3BXsXqMoIM4gB9fxl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827012; c=relaxed/simple;
	bh=hYm53TXlQfcyeB+z5vDUlyedpFv/vu34UbEEPPHY+XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROmw8WazikpYpOxxFHaNyV1qkTstG9VuPJpU5kC7rctQTIbbc9oKEe9XlcA+puwvN3Dirv4VkQyuRbxAa6bxCN4gIMLGs9wFv2S3wItD9Ad9GLOjSe2GF9qpqvuEykS5VkzmVkHwlZCnnP0BZA5Qr98RfehaxI6QXjoYlxvqpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoIk+CP1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712827011; x=1744363011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hYm53TXlQfcyeB+z5vDUlyedpFv/vu34UbEEPPHY+XE=;
  b=PoIk+CP13PNb+y6MSoFicDJzZIQyW8Hk9FBtHIuUO0KE85dTN6LHsLGs
   Akdf7XKHnqb3kjZ6fmJJ+bbCBZ41tlm1j4rZPsGUdMq6HUgAXQP012SSQ
   rjNz/K0yYfmzdJ0Hsl+ZuYPLepI/XD+BQVXSPMPwiu/Dwq1RbumLL//gw
   C799E9B9kiETTBdcyhfviraOd/UoT9tzARxADcz4F8D7q3J1Wbb6ICDof
   7M9B0TIgYWSUo4p3peKszgr5a2t1G02lCl153JDPFuM5tPa1mQtfiVMqw
   fOyCtROQU9A8SwybRT9PR3qsy5odNwyMCnHURl8vJRMbCO3FXULEEWYsM
   A==;
X-CSE-ConnectionGUID: du3qVAslQUa9NNgrEpIxfQ==
X-CSE-MsgGUID: b4o/dJqiQhCp70JHU5q8Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11187719"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11187719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:16:50 -0700
X-CSE-ConnectionGUID: AoAFNDtVSGCeodYJQe9kWw==
X-CSE-MsgGUID: 2hhegYBSSI6eLdjjaGCipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20803972"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 11 Apr 2024 02:16:47 -0700
Date: Thu, 11 Apr 2024 17:11:43 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: region: add owner module and take its refcount
Message-ID: <ZhepT8emGl27Fo5N@yilunxu-OptiPlex-7050>
References: <20240327160022.202934-1-marpagan@redhat.com>
 <Zgp/jNst2yuXEbpU@yilunxu-OptiPlex-7050>
 <64c1685a-b544-408e-97e4-8c3cff6aca6c@redhat.com>
 <ZhS/M6pa9AHyvb0y@yilunxu-OptiPlex-7050>
 <9d016f83-8e7f-4bdf-8610-e3d0b49f7097@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d016f83-8e7f-4bdf-8610-e3d0b49f7097@redhat.com>

On Wed, Apr 10, 2024 at 11:42:23AM +0200, Marco Pagani wrote:
> 
> 
> On 2024-04-09 06:08, Xu Yilun wrote:
> > On Wed, Apr 03, 2024 at 03:34:22PM +0200, Marco Pagani wrote:
> >>
> >>
> >> On 2024-04-01 11:34, Xu Yilun wrote:
> >>> On Wed, Mar 27, 2024 at 05:00:20PM +0100, Marco Pagani wrote:
> >>>> The current implementation of the fpga region assumes that the low-level
> >>>> module registers a driver for the parent device and uses its owner pointer
> >>>> to take the module's refcount. This approach is problematic since it can
> >>>> lead to a null pointer dereference while attempting to get the region
> >>>> during programming if the parent device does not have a driver.
> >>>>
> >>>> To address this problem, add a module owner pointer to the fpga_region
> >>>> struct and use it to take the module's refcount. Modify the functions for
> >>>> registering a region to take an additional owner module parameter and
> >>>> rename them to avoid conflicts. Use the old function names for helper
> >>>> macros that automatically set the module that registers the region as the
> >>>> owner. This ensures compatibility with existing low-level control modules
> >>>> and reduces the chances of registering a region without setting the owner.
> >>>>
> >>>> Also, update the documentation to keep it consistent with the new interface
> >>>> for registering an fpga region.
> >>>>
> >>>> Other changes: unlock the mutex before calling put_device() in
> >>>> fpga_region_put() to avoid potential use after release issues.
> >>>
> >>> Please try not to mix different changes in one patch, especially for
> >>> a "bug fix" as you said.
> >>
> >> You are right. I'll split out the change and eventually send it as a
> >> separate patch.
> >>
> >>> And I do have concern about the fix, see below.
> >>>
> >>> [...]
> >>>
> >>>> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
> >>>>  	}
> >>>>  
> >>>>  	get_device(dev);
> >>>> -	if (!try_module_get(dev->parent->driver->owner)) {
> >>>> +	if (!try_module_get(region->br_owner)) {
> >>>>  		put_device(dev);
> >>>>  		mutex_unlock(&region->mutex);
> >>>>  		return ERR_PTR(-ENODEV);
> >>>> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
> >>>>  
> >>>>  	dev_dbg(dev, "put\n");
> >>>>  
> >>>> -	module_put(dev->parent->driver->owner);
> >>>> -	put_device(dev);
> >>>> +	module_put(region->br_owner);
> >>>>  	mutex_unlock(&region->mutex);
> >>>
> >>> If there is concern the region would be freed after put_device(), then
> >>> why still keep the sequence in fpga_region_get()?
> >>
> >> Ouch, sorry, I forgot to make the change also in fpga_region_get().
> >>
> >>> And is it possible region is freed before get_device() in
> >>> fpga_region_get()?
> >>
> >> If the user follows the usual pattern (i.e., waiting for
> > 
> > I can see the only safe way is fpga_region_program_fpga() or fpga_region_get()
> > should be included in:
> > 
> >   region = fpga_region_class_find();
> >   ...
> >   put_device(&region->dev);
> > 
> > That is to say, fpga_region_get() should not be called when there is no
> > region dev reference hold beforehand. In this case, no use after release
> > risk. That's why I was thinking about some documentation.
> > 
> > Another concern is we'd better keep the get/put operations symmetrical
> > for easy maintaining, as long as it doesn't cause problem.
> 
> Now I see your point. So, you suggest changing only the docs to clarify
> that the region must be taken with fpga_region_class_find() before
> programming it with fpga_region_program_fpga()?

Like:

The reference to the region must already been hold. E.g. by
fpga_region_class_find().

> 
> That's fine by me. However, this made me wonder why we need to take the
> region dev with get_device() in fpga_region_program_fpga()->fpga_region_get().
> If we assume that the user must always call fpga_region_class_find()
> before programming with fpga_region_program_fpga(), why do we need the
> double get?

Yeah, I have the same concern when I visit this part. I don't think it
is necessary.

Thanks,
Yilun

> 
> Thanks,
> Marco
>  
> >> fpga_region_program_fpga() to complete before calling
> >> fpga_region_unregister()) there should be no problem. However, I think
> >> releasing the device before unlocking the mutex contained in the context
> >> associated with the device makes the code brittle and more prone to
> >> problems.
> >>
> >>> Or we should clearly document how/when to use these functions?
> >>  
> >> I think it is not necessary to change the documentation since the
> >> in-kernel programming API will not be affected by the change.
> >>
> [...]
> 

