Return-Path: <linux-kernel+bounces-150014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F718A9917
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8059BB226B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B0615EFBB;
	Thu, 18 Apr 2024 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwFPhtlP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984315E7FA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441227; cv=none; b=A9OVr4R0v/wSm6uHxYF/V5oHo77hbtFaaQp4xlX4aBz/SmkUM5OHSFfKBd0aY5NvnAisrMK5rVvSSUHNjZqImPlOvOcRVXVTd5o4RaqGrwXTRhKlCCIxgR7uLpsZZUgPWGPkahnGrNtA3K45N2pkJFKdR8GSclLsnchzSLSgWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441227; c=relaxed/simple;
	bh=tkl33SZf8yom7WU4rICjpTPTPslg5lqttSlZkZ3e+8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opcejzvQUBZWBbcSkbAOMbLvFj6MiVVJU9jy3wcp8s2Db0mnX8KYMEXeie3YMiIepWgtfJ+qeGiyWSW+Ww9P3QlPxU558C3SV1I+wZdU8h7uzDxkyF13CHFREZWadmRL3tZp4RIXrCpwBFIfY9284hzr2/2/nESINW5qellGLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwFPhtlP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713441226; x=1744977226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tkl33SZf8yom7WU4rICjpTPTPslg5lqttSlZkZ3e+8s=;
  b=QwFPhtlPLY8m46ELX8Cf1hQDY2Vu63yPH2Di/qolQiXp+sHMswzp/Znl
   wxOQDPA4BeGoXuFD+ycfPy7Yop1Kfuyr+ijYXaABKtYewUgHZHxGp48VU
   S8s/RQsh2dXhU9RY0v3JYBFRKdr3nbMyIXzOXIwfOgdhLICEyrGh1jlRi
   1fziPv9fXROAg+UWx2GtrUMgMnRr1du0hdau5Hm7YrvXmL8HOl7JkQVSv
   uXRk4aah/oMOMC/HNWjGtgbs/T24ICzxcb9U6nwgVH7OPn0wG9TotDWbq
   Tx2rn3tB8bxwusJbSGnmrvKC2BW/UqEG4lHNUFc/dzNjekZBJxqVdQXFW
   w==;
X-CSE-ConnectionGUID: 8XMRLcu4TC+JhpIY1QFUlA==
X-CSE-MsgGUID: 8+Umx3eXSsWkiC2ZAM9oKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12766879"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12766879"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:53:45 -0700
X-CSE-ConnectionGUID: 0oftRFAaTVSyIA87JqdqZw==
X-CSE-MsgGUID: j30FugN4QeWRlkXR6gDe2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27773357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:53:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxQKg-00000000JdM-3CI3;
	Thu, 18 Apr 2024 14:53:38 +0300
Date: Thu, 18 Apr 2024 14:53:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/3] ALSA: hda/tas2781: Main code of
 tas2781 driver for SPI
Message-ID: <ZiEJwr5iv77wLkwd@smile.fi.intel.com>
References: <20240409024816.1180-1-baojun.xu@ti.com>
 <20240409024816.1180-3-baojun.xu@ti.com>
 <ZhVA1_HTET4Q4T9d@smile.fi.intel.com>
 <e3f73d92d1fa466cb70e3d738a7926c9@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3f73d92d1fa466cb70e3d738a7926c9@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 05:12:03AM +0000, Xu, Baojun wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 09 April 2024 21:21
> > To: Xu, Baojun
> > On Tue, Apr 09, 2024 at 10: 48: 14AM +0800, Baojun Xu wrote:
> > On Tue, Apr 09, 2024 at 10:48:14AM +0800, Baojun Xu wrote:

..

> > > +#ifndef __TAS2781_SPI_H__
> > > +#define __TAS2781_SPI_H__
> > 
> > + bits.h
> > + mutex.h
> > + time.h? (for struct tm)
> > + types.h
> > 
> > struct calidata is from?..
> > 
> > > +#include <sound/tas2781-dsp.h>
> > 
> > Not sure how this is being used.
> 
> Was used for firmware binary file parser, all of file format information
> was defined in this header file. It can be shared between SPI & I2C.

_This header_ file seems not using anything from it, does it?

> > Also some forward declarations:
> > 
> > + struct device;
> > + struct firmware;
> > + struct gpio_desc;
> > + struct regmap;

-- 
With Best Regards,
Andy Shevchenko



