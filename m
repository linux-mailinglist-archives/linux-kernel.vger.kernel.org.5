Return-Path: <linux-kernel+bounces-166789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAC8B9F82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0838AB20BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800416FF4A;
	Thu,  2 May 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiZfa1AR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61216FF45
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670943; cv=none; b=NtgzUbTWIdbGz6DVChOeNIqXvNvkM5O76o1RBmmzGSFScv4UxJhjdeefK6/hf1GTLoHbULwNksXQPJJLr48MUGCLguJ0eT3dg5gG8+LuhOGATJR3tmpvXF/WDMqgLjWYXIcEJwSFIoe0McFsfeE4d2HtY9u3ighDhMHHDRSBSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670943; c=relaxed/simple;
	bh=W3wEH25DHJLHiCPlwZANF0yYSmqELTFyIGYQeEpRKmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLNJ9ff0tw5f7t59FhvTj/k+peHNa7Gzuy70lOtkCc4AjHOopRTz0lFa3k1Wa7oxku9i7NMTviwo1T+EX9nn26jv/sBWOW7qfNNPwAxQLO2Dmk08D7JeoUPJc8vXppQhW1FPHobJqOED5k6De/l30aWVI0iotbY/RGy1IfJX7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiZfa1AR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714670942; x=1746206942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3wEH25DHJLHiCPlwZANF0yYSmqELTFyIGYQeEpRKmA=;
  b=jiZfa1ARf0jy0two926KYQ11golknejWfHzu3Tmxav/v1ClQUH2m0Pf0
   40HI0YNgTGdbQR90h83k9fA99mGON3pUZqor1kKodEg+WGuHJcqauhPZ+
   cT3dqdc0+F8HAMSZSjFWOGBFONk8FgHXur1ZCi19cDgglbVeZV89Ig/2s
   6dChBwTbYs2ssWnmarreW2CcMeChMhHcQsuk4vIPulhblCky1kkhIqG4V
   7S5N2LnTPmp45sGkPY08j68sTfVLf2DEDuZsfKdHrt9B9iTYslNMKcRzz
   CClrfs7B7ibi0LMPdcPphkdC9huu0OMlImhHN1P9OCxxYRRL71R+MhyFa
   w==;
X-CSE-ConnectionGUID: 3chX9iwQSiy/hENRbh+UwA==
X-CSE-MsgGUID: V9vomwF9ROGTrRAeWm9pVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="13402595"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="13402595"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:29:01 -0700
X-CSE-ConnectionGUID: aCYIlScVTP2S9e6aZ/C8ew==
X-CSE-MsgGUID: lJ7oDaAsSfmEpLVMgls8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31987099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:28:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2aEl-00000003Op1-3di1;
	Thu, 02 May 2024 20:28:51 +0300
Date: Thu, 2 May 2024 20:28:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <ZjPNU24ZJIzGFDNg@smile.fi.intel.com>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
 <ZiqrLfezhns4UycR@smile.fi.intel.com>
 <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
 <ZjD8eoO3TmuCUj-a@smile.fi.intel.com>
 <9e69b129-7539-4403-a621-bf3775aab995@linux.dev>
 <ZjNPiBvLF3WcBftn@smile.fi.intel.com>
 <e1d01191-fd96-4b17-b223-7147eb427315@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d01191-fd96-4b17-b223-7147eb427315@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 12:25:17AM +0800, Sui Jingfeng wrote:
> On 2024/5/2 16:32, Andy Shevchenko wrote:
> > On Wed, May 01, 2024 at 12:27:14AM +0800, Sui Jingfeng wrote:
> > > On 2024/4/30 22:13, Andy Shevchenko wrote:
> > > > On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:

..

> > > > the former might be subdivided to "is it swnode backed or real fwnode one?"
> > > > 
> > > Yeah,
> > > On non-DT cases, it can be subdivided to swnode backed case and ACPI fwnode backed case.
> > > 
> > >   - For swnode backed case: the device_get_match_data() don't has a implemented backend.
> > >   - For ACPI fwnode backed case: the device_get_match_data() has a implemented backend.
> > > 
> > > But the driver has *neither* software node support
> > True.
> > 
> > > nor ACPI support,
> > Not true.
> 
> Why this is not true? Are you means that the panel-ilitek-ili9341 driver has ACPI support?

That's the idea (as far as I see the copy of the code from tinyDRM),
but broken over the copy'n'paste. This patch rectifies that to be
in align with the original code, which *does* support ACPI.

> I'm asking because I don't see struct acpi_device_id related stuff in that source file,
> am I miss something?

Yes, you are. I leave it for you to research.

> > So, slow down and take your time to get into the code and understand how it works.
> > 
> > > so that the rotation property can not get and ili9341_dpi_probe() will fails.
> > > So in total, this is not a 100% correct use of device property APIs.
> > > 
> > > But I'm fine that if you want to leave(ignore) those less frequent use cases temporarily,
> > > there may have programmers want to post patches, to complete the missing in the future.
> > > 
> > > So, there do have some gains on non-DT cases.
> > > 
> > >   - As you make it be able to compiled on X86 with the drm-misc-defconfig.
> > >   - You cleanup the code up (at least patch 2 in this series is no obvious problem).
> > >   - You allow people to modprobe it, and maybe half right and half undefined.
> > > 
> > > But you do helps moving something forward, so congratulations for the wake up.

-- 
With Best Regards,
Andy Shevchenko



