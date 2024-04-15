Return-Path: <linux-kernel+bounces-144442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A295B8A467B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48A51C216AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76179E3;
	Mon, 15 Apr 2024 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKQxXxQm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347E14A84;
	Mon, 15 Apr 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143611; cv=none; b=SKPZSaBYOjP3D1zuTfyl0Cp2qn0k3JjOqmfriD5ECMXrO8nBMh9Q/99suQgt+4KmzkuseOY4TxCEdUM8ES9AbXMbYVL86xXNUmdsZ17O+yD6DKDQbAyfkuMNK6o1VihjOwkpA6Q+ZCQ4Ol4QMOPz/LQ5RzcC80x7+wjDNqmFl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143611; c=relaxed/simple;
	bh=kzbxnprmViyV4GPGajUJ0UyOuQn77rMqLGGBVn8hrPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHdib7c1BFhe/wQxhwMCrWlKbA6N/7RDTYdEMp/N9xg2h5fMNkOhjvNNwVraNQfWrKg/RBGoazHhN2PcrdsASPaLgt+BsUFYxo/3f1HqcrPlkSm37Tzsnn5eflw9xU9WLP6l8yEn7Ihpj5DR9Sbzg09s71yHLVuWwBKfhG5qFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKQxXxQm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713143611; x=1744679611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kzbxnprmViyV4GPGajUJ0UyOuQn77rMqLGGBVn8hrPk=;
  b=dKQxXxQm2Gar0BoHidLOSqnuH/mh4gbG8H3xbGYrsP5/0kfUvE1fT0+k
   SPnwkhBeBGaVLtxPROdVIOQwQce7d6ZywAZdr51joyNHteKyHOoquuTOf
   6ZRI4N14p5kF67aiIpKwfEUX2lr8ATOCMVuDgz3JUrge96hxuuWSYsgzf
   SvlW5+62nDBePlMxVLCZekYX3ZfuLisX9255AL37WmK/O6w9m5TRkVecC
   InLWqLxaVZT1ZiKoJArAoRLEZPPknJf38uRha7W1c0/sJY+Ogr14gs/KE
   eaFge1RFXubmSoIyxrwA0OOUYVbW1qA4F87cPpIR0/bccani+CHqfyokM
   w==;
X-CSE-ConnectionGUID: 50zbtgvwQ4uBirekqXsnKw==
X-CSE-MsgGUID: rBA2/A2SRyOs8KCyKbH9LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8384979"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8384979"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 18:13:30 -0700
X-CSE-ConnectionGUID: NtOcI3GjQl+QtD+MzkRFaA==
X-CSE-MsgGUID: /DR2+x3MSnWUenUoObJD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21818814"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 18:13:29 -0700
Date: Sun, 14 Apr 2024 18:19:46 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux@roeck-us.net" <linux@roeck-us.net>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Neri, Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Message-ID: <20240415011946.GA12551@ranerica-svr.sc.intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
 <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
 <6411e721a1cd559f59aecd8ac57a941cdaa13ff1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6411e721a1cd559f59aecd8ac57a941cdaa13ff1.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Apr 07, 2024 at 08:24:40AM +0000, Zhang, Rui wrote:
> On Fri, 2024-04-05 at 18:04 -0700, Ricardo Neri wrote:
> > The Intel Software Development manual defines states the temperature
> 
> I failed to parse this, is the above "states" redundant?

Sorry Rui! I missed this repy.

Ah, the commit message is wrong. I will do s/defines//

> 
> [...]
> 
> > digital readout as the bits [22:16] of the
> > IA32_[PACKAGE]_THERM_STATUS
> > registers. In recent processor, however, the range is [23:16]. Use a
> > model-specific bitmask to extract the temperature readout correctly.
> > 
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 616bd1a5b864..5632e1b1dfb1 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/hwmon-sysfs.h>
> >  #include <linux/err.h>
> > +#include <linux/intel_tcc.h>
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/platform_device.h>
> > @@ -404,6 +405,8 @@ static ssize_t show_temp(struct device *dev,
> >         tjmax = get_tjmax(tdata, dev);
> >         /* Check whether the time interval has elapsed */
> >         if (time_after(jiffies, tdata->last_updated + HZ)) {
> > +               u32 mask =
> > intel_tcc_get_temp_mask(is_pkg_temp_data(tdata));
> > +
> >                 rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax,
> > &edx);
> >                 /*
> >                  * Ignore the valid bit. In all observed cases the
> > register
> > @@ -411,7 +414,7 @@ static ssize_t show_temp(struct device *dev,
> >                  * Return it instead of reporting an error which
> > doesn't
> >                  * really help at all.
> >                  */
> > -               tdata->temp = tjmax - ((eax >> 16) & 0x7f) * 1000;
> > +               tdata->temp = tjmax - ((eax >> 16) & mask) * 1000;
> >                 tdata->last_updated = jiffies;
> >         }
> > 
> Besides this one, we can also convert to use intel_tcc_get_tjmax() in
> get_tjmax().

I thought about this, but realized that the bitmask of TjMax is always
[23:16]; no need for a model check. If anything, intel_tcc_get_tjmax()
would remove some duplicated code. But coretemp.c would need to depend
on INTEL_TCC, which seems to be a non-starter.

