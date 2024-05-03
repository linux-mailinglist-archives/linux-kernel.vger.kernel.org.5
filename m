Return-Path: <linux-kernel+bounces-167852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D268BB03D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472381F2343E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DD154441;
	Fri,  3 May 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKTYnEB3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4622E827
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751170; cv=none; b=DtYG15z8QKwhV15NY9oUKqz1fhVe6nPlVaofrMaTOQDBZzS6sOctKzyfYivWieb3zqfZKWV7WXYA8pP2acrCLIeb8uev1QiXQiuiU5gp2vlSYuWWtsvjvTwSqSxYjW4IA0In02DV8R08jvWlWhPFvmhmLXaaIsckeJ+ArSWV6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751170; c=relaxed/simple;
	bh=6qkIQL5v3S2njbRTTPohfz7nDTUUHJuFC7dc+uHtgaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY+eX+X63xTNkEH86V8eAPocnr6HqGJVtFv8ChY1BGj2V+yiZs5BVyyvpFhbnIY+Qw8whRBj0n1cQQ3Ck/gtxUNfSgC/LSJ5wBq/tp574CGlbVOsJ21wHBc08pm++2z7rxJmApibmVVg9kffP20EGr+EVbzFCv+sSWqnlwi7Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKTYnEB3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714751167; x=1746287167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qkIQL5v3S2njbRTTPohfz7nDTUUHJuFC7dc+uHtgaA=;
  b=bKTYnEB3v+avEaST6PUQp75tRMCB75m7rr53d1vSd81xI2MOxFcgix/q
   C3HkKSrLVvJ5CknASk1ukWzUKCaPZaAoxepfVVToL8aMAL4ytbx+PmHOr
   aYXxl7h8yRCZKD+k/t18PzPv51oUfXtI0TuRsBmXpjV6VVtyBdmE/yfLB
   l/c9FCNTh3v76mdERfVCwjLwFtQHWxuSNkXfBZ8EAO8XrPavb2NTb81Hy
   fJmTkSeOEc4bR+OLnqrPzYE+PqaKxyPuYUyopOdhfk/qVJh9l/El99LQ2
   HzqGfWNGnRDzXAJlp6tw9m+cG3jQOFE8I6XEzVJL1RdLHf59coZuQIzmp
   A==;
X-CSE-ConnectionGUID: 26ELPrnBRu6PZPvY+WRCkA==
X-CSE-MsgGUID: Ha/8/z9tSxGzhR3TOI4U/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28038407"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28038407"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:46:07 -0700
X-CSE-ConnectionGUID: fqWA1A5EQmupe0GZIVoW4A==
X-CSE-MsgGUID: YaTUMS4MSHC/Y6O07af/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58681897"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:46:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2v6m-00000003h0l-36ft;
	Fri, 03 May 2024 18:46:00 +0300
Date: Fri, 3 May 2024 18:46:00 +0300
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
Message-ID: <ZjUGuKGm7IdtwKgg@smile.fi.intel.com>
References: <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
 <ZiqrLfezhns4UycR@smile.fi.intel.com>
 <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
 <ZjD8eoO3TmuCUj-a@smile.fi.intel.com>
 <9e69b129-7539-4403-a621-bf3775aab995@linux.dev>
 <ZjNPiBvLF3WcBftn@smile.fi.intel.com>
 <e1d01191-fd96-4b17-b223-7147eb427315@linux.dev>
 <ZjPNU24ZJIzGFDNg@smile.fi.intel.com>
 <a8509e96-bfe2-4c50-8624-8f418c88edfa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8509e96-bfe2-4c50-8624-8f418c88edfa@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 12:57:33PM +0800, Sui Jingfeng wrote:
> On 2024/5/3 01:28, Andy Shevchenko wrote:
> > On Fri, May 03, 2024 at 12:25:17AM +0800, Sui Jingfeng wrote:
> > > On 2024/5/2 16:32, Andy Shevchenko wrote:
> > > > On Wed, May 01, 2024 at 12:27:14AM +0800, Sui Jingfeng wrote:
> > > > > On 2024/4/30 22:13, Andy Shevchenko wrote:
> > > > > > On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:

..

> > > > > > the former might be subdivided to "is it swnode backed or real fwnode one?"
> > > > > > 
> > > > > Yeah,
> > > > > On non-DT cases, it can be subdivided to swnode backed case and ACPI fwnode backed case.
> > > > > 
> > > > >    - For swnode backed case: the device_get_match_data() don't has a implemented backend.
> > > > >    - For ACPI fwnode backed case: the device_get_match_data() has a implemented backend.
> > > > > 
> > > > > But the driver has *neither* software node support
> > > > True.
> > > > 
> > > > > nor ACPI support,
> > > > Not true.
> > > Why this is not true? Are you means that the panel-ilitek-ili9341 driver has ACPI support?
> > That's the idea (as far as I see the copy of the code from tinyDRM),
> > but broken over the copy'n'paste. This patch rectifies that to be
> > in align with the original code, which *does* support ACPI.
> > 
> > > I'm asking because I don't see struct acpi_device_id related stuff in that source file,
> > > am I miss something?
> > Yes, you are. I leave it for you to research.
> 
> After researching a few hours I still don't understand how does
> the panel-ilitek-ili9341 driver has the ACPI support and be able
> to ACPI probed when compiled as module.
> 
> As far as I know, drivers that has the ACPI support *must* has the
> .acpi_match_table hooked, so that be able to be probed when the
> driver is compiled as a module.

No, and this is the thing. Hint: there is a glue code to reuse compatible
strings from OF, that's why dependency to OF prevents *some* systems from
being able to use that. But it's easy to fix by enabling OF in the
configuration, however the ID tables are orthogonal to the environment.
That's why all those ACPI_PTR() and of_match_ptr() are design mistakes
that are going to be removed eventually (the work is ongoing, btw,
as well as killing specific *_device_get_match_data() calls).

> For example, see commit 75a1b44a54bd9 ("spi: tegra210-quad: add acpi support")
> to get a feel what a SPI device with *real* ACPI support looks like.

If under *real* you assume the allocated _HID in use, yes, that's how it's
done. But there is the other tricky way of achieving similar effect w/o
allocating a new / custom ACPI _HID.

Hint: it's all documented in kernel under firmware-guide/acpi/.

> I have double checked the panel-ilitek-ili9341 driver, it doesn't
> has acpi_match_table hooked, which means that this driver won't
> even be able probed. And probed as pure SPI device still out of
> the scope of "correct use of device property APIs". Because SPI
> device specific method don't belong to the device property API.
> I don't really know what's we are missing, but we already intend
> to let it go, thanks.
> 
> > > > So, slow down and take your time to get into the code and understand how it works.
> > > > 
> > > > > so that the rotation property can not get and ili9341_dpi_probe() will fails.
> > > > > So in total, this is not a 100% correct use of device property APIs.
> > > > > 
> > > > > But I'm fine that if you want to leave(ignore) those less frequent use cases temporarily,
> > > > > there may have programmers want to post patches, to complete the missing in the future.
> > > > > 
> > > > > So, there do have some gains on non-DT cases.
> > > > > 
> > > > >    - As you make it be able to compiled on X86 with the drm-misc-defconfig.
> > > > >    - You cleanup the code up (at least patch 2 in this series is no obvious problem).
> > > > >    - You allow people to modprobe it, and maybe half right and half undefined.
> > > > > 
> > > > > But you do helps moving something forward, so congratulations for the wake up.

-- 
With Best Regards,
Andy Shevchenko



