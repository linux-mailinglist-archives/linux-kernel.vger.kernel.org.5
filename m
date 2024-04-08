Return-Path: <linux-kernel+bounces-135496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956D89C6B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BDD1F21EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120986AF4;
	Mon,  8 Apr 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbfgDgdU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57485C5D;
	Mon,  8 Apr 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585862; cv=none; b=Tu6ROJo0KSOu2+0+iWBjupffqndsdw2ScEPC9MsF/c54SkiybJNd1Ny0shjMkTSex+7DhjK8PMdGX4Y6qIY249yket61QNk9AI0BlVTYEPbPw65EnPmfW1MZccrLVloy8MQBVj1b12sFfE1b5tz6O6sVaZ1sSXC/qJq/F1r3cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585862; c=relaxed/simple;
	bh=xtO+UZtPh4czwtwpsw4636hm7erzTR79z/J1kew+UD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcS9XiPfovuhDjufv+76xoe29TVSYo5g8C7MDKSRCY720iXGiGB3bRrjuwtK6v6/rV7pHqm3FB/DzKqEtS5D6x3OO4EH1g0el64vEZixnFwAaYWc441uJ0HbPSzIP3jEDePeKzeU7VNMVCvezg//G+VEXhNq3O2UhZ5MfjkuFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbfgDgdU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712585860; x=1744121860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xtO+UZtPh4czwtwpsw4636hm7erzTR79z/J1kew+UD0=;
  b=TbfgDgdUU/tq5uIBmxNKpN38YLdLjRZfSSve2yqIsOWbZOqgwevtAdhY
   whc7k5AI2Bci1pQLqF45/PxB5jG8Rl67XP08PgUMHS/TXYysvhdcmUEPM
   kOQedDN11HWA8ifWUv/58XxwtznIbgp5BmP1j8b3UAAXl3WsWGyQP7UQy
   U+r3C4Z4zOq0Fz4kx/cWNNgHH72HJ4x9zEsUts70SdUEP96cDxuHVGwnP
   BZogcjBIvF61A9uuF4h6nJ5giytxGHrEyA4OzSIny45ChtVo/mCrfMkj9
   cS4DXADy6ehtw54MTm1ZJcOlCsoufRAdItvMrcXzab6Szybx+S0kWYZC4
   A==;
X-CSE-ConnectionGUID: ivye9XGxST63o2z1FifjeQ==
X-CSE-MsgGUID: SHAp5hWxSs+T2kYy2O+IYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7731985"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7731985"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:17:39 -0700
X-CSE-ConnectionGUID: ILCau2wjQ6+WB29dITlcHg==
X-CSE-MsgGUID: SgHdLwAUS9SBYniORcWUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24390367"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:17:39 -0700
Date: Mon, 8 Apr 2024 07:23:43 -0700
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
Subject: Re: [PATCH 1/3] thermal: intel: intel_tcc: Add model checks for
 temperature registers
Message-ID: <20240408142343.GA16542@ranerica-svr.sc.intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
 <20240406010416.4821-2-ricardo.neri-calderon@linux.intel.com>
 <5e86524413ec2cfeb1096f49851bf18837c7e50b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e86524413ec2cfeb1096f49851bf18837c7e50b.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Apr 07, 2024 at 08:13:28AM +0000, Zhang, Rui wrote:
> > +
> > +#define TCC_FAM6_MODEL_TEMP_MASKS

Thank your your review, Rui!

> 
> Future non FAM6 processors can still use this macro, right?
> So I'd prefer to remove FAM6_MODEL in the macro name.

Yes, it is true, FAM6_MODEL it is restrictive and also not needed here.
I will update accodingly.
 
> [...]
> > 
> > +
> > +/**
> > + * get_tcc_offset_mask() - Returns the model-specific bitmask for
> > TCC offset
> > + *
> > + * Get the model-specific bitmask to extract TCC_OFFSET from the
> > MSR_TEMPERATURE_
> > + * TARGET register. If the mask is 0, it means the processor does
> > not support TCC offset.
> > + *
> > + * Return: The model-specific bitmask for TCC offset.
> > + */
> > +u32 get_tcc_offset_mask(void)
> > +{
> > +       return intel_tcc_temp_masks.tcc_offset;
> > +}
> > +EXPORT_SYMBOL_NS(get_tcc_offset_mask, INTEL_TCC);
> 
> the name is not consistent with the other intel_tcc APIs.
> 
> how about intel_tcc_get_offset_mask()?

Sure. I can make this change.

> 
> [...]
> 
> > diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
> > index 8ff8eabb4a98..e281cf06aeab 100644
> > --- a/include/linux/intel_tcc.h
> > +++ b/include/linux/intel_tcc.h
> > @@ -14,5 +14,13 @@ int intel_tcc_get_tjmax(int cpu);
> >  int intel_tcc_get_offset(int cpu);
> >  int intel_tcc_set_offset(int cpu, int offset);
> >  int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
> > +#ifdef CONFIG_INTEL_TCC
> > +u32 get_tcc_offset_mask(void);
> > +u32 intel_tcc_get_temp_mask(bool pkg);
> > +#else
> > +static inline u32 get_tcc_offset_mask(void) { return 0; }
> > +/* Use the architectural bitmask of the temperature readout. No
> > model checks. */
> > +static inline u32 intel_tcc_get_temp_mask(bool pkg) { return 0x7f; }
> > +#endif
> 
> for intel_tcc_get_temp_mask()
>    1. with CONFIG_INTEL_TCC
>       a) for a platform in the model list, return the hardcoded value
>       b) for a platform not in the model list, return 0xff
>    2. without CONFIG_INTEL_TCC, return 0x7f
> 
> This is a bit confusing. IMO, at least we should leave a comment about
> this difference.

If we don't do model checks, I think we should rely on what is architectural
as per the SDM. Hence the 0x7f value.

Perhaps I can expand the comment in this hunk to detail what we do when we
do model checks.


