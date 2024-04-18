Return-Path: <linux-kernel+bounces-150018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65D8A9924
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906DBB24065
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946E15F30B;
	Thu, 18 Apr 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHibYdSt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD215B578
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441405; cv=none; b=CG1uZETetY5rkCKapH2JIRJJLGezJgsd0bOxQujG6oAE0EZgIfj2NL+nXIYK8DmwUzmpxGwTEix93T6aYnK2DEIaANed7HFZvC6n5Rpye260h5csZ68VWEgJCij7hn1DMt4RcX9X9wj6S2of3qKoxA3HUvxUXgZ8qco3mv2Ahcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441405; c=relaxed/simple;
	bh=Geu961+SVr9aZ7BLK4Mm8AQ6E9OjYikibtvsd2knVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9PEfosW+MVkOLS3SHhbZJmdUmLENErhgLQweybi0e/obZiVshhh/2235aSni6jsDyIst6XS7sx8LLMPogcA6q1iKucVXi1xZXQcv9gjKrFddPPKe4uyyom/sZRuY84b7VkkTC2qF5sbbLN7+XS3v5E28tSZDX5j0qiiIVK9W0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHibYdSt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713441404; x=1744977404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Geu961+SVr9aZ7BLK4Mm8AQ6E9OjYikibtvsd2knVAs=;
  b=OHibYdStON1vQz20JTySKcp0sijFp/QhFY9ZciCNHUwyQLetHfb9YsGx
   2W/eGzDdMeagLV+DLL4sV1f8Ofns6PqHSm6+doTdnT2gJrdhrxwqAbeY6
   s78xW89rSWfTUeYdU25C3kKa5hxneUpmwZTyeqiJij+bXDLNTMZ2neHRY
   GHipZrRbbG4n1yR5Q9F4XdP1dbA0Fc3msXd0wXL6p4DrXlu6iZZaNBF4r
   /B2oISD8bshAOVkzgmriFGPvcX0JrhIFR1t5x9gHALm5uhjV29tNFS0tR
   opJm/FQXCtCE6p6VwHRb10sljBd9Ix66lRLcRh/pVd6KsAxbiwB7BU+og
   w==;
X-CSE-ConnectionGUID: SFEI+ve6SGu5/bZPX0W14A==
X-CSE-MsgGUID: mAz2NvW+Qq+gjshuigdr7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20128123"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20128123"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:56:43 -0700
X-CSE-ConnectionGUID: ybbDpHq6RhaPbzSEQhiOAw==
X-CSE-MsgGUID: ZgfGlSTURE2FhXwvBTtjgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27732961"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:56:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxQNX-00000000Jfk-2mVN;
	Thu, 18 Apr 2024 14:56:35 +0300
Date: Thu, 18 Apr 2024 14:56:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-po@ti.com, niranjan.hy@ti.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification for add tas2781
 driver for SPI
Message-ID: <ZiEKc4OTVlOt8llU@smile.fi.intel.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
 <20240418040240.2337-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418040240.2337-2-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 12:02:37PM +0800, Baojun Xu wrote:
> Integrate tas2781 configs for HP Laptops. Every tas2781 in the laptop
> will work as a single speaker on SPI bus. The code support realtek as

Realtek

> the primary codec.

..

>  sound/pci/hda/Kconfig                           | 15 +++++++++++++++
>  sound/pci/hda/Makefile                          |  2 ++

Is this correct? You are adding a dead "code", isn't it?

..

The rest LGTM.

-- 
With Best Regards,
Andy Shevchenko



