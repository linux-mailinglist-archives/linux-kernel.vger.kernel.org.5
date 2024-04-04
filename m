Return-Path: <linux-kernel+bounces-132029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7044C898EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A1FB2911E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2813440A;
	Thu,  4 Apr 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7dHScuh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCC133413;
	Thu,  4 Apr 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258613; cv=none; b=pzjSM9jeK/ffeDOrDwKYis4SD+jMeh2HmFPUvxv7WcOu1dNuL7oHNRx/6J/GYtK0M++4UZmorgmRLODF1DSNjvhDgOKAthFf6rT+g1b307cq491EdobUz99klsOUPQ94+Pyh4F+h5hQx+vZXCmcSQ5dLu3CcJFxafHSNHuqLv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258613; c=relaxed/simple;
	bh=zUn2BFtvpGzp35925+pPKXzoZXaRiJJeRXXgLpCJrvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuT1gvHiQmcuRHSihmGSYsoNWXVXaRC+aQ5dTCQVFZzOSVSj9IKNN4Zj1yUtL0ZUwQkx5Pg1VdjwEpwObkPhuUzbEWlvJ8B20zAnI3rX3+BttJ3dWqWKE3SyP3QU49fqOrCNG/kaumJzSYS2vuf+8XuEDG+KmolaBABYA9w2BEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7dHScuh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258612; x=1743794612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zUn2BFtvpGzp35925+pPKXzoZXaRiJJeRXXgLpCJrvE=;
  b=K7dHScuhjryNgTGGHwbL1iN83V7KidPGdQXfD38Oarqe8IQxqGOsb6/o
   rY8smRN/JDghdE22OUPY+DXxXy5jGmjQUsO4dmPxgDETCAFtWHUV9J7Z6
   hoKSltTEXucULjDsgvdV/6IYqMAagPvdM2Hlp/jzzQ9SfwOGRJ8OwQJNQ
   240yTLPvFCE6k1Rzv76quZPtblviQyd69f/lcs6NW40Ehn/RSWIbNozJi
   2AOEs5dKwlE0L6c0+RBW8LkuBf937HGuMBaY6Qj8w2lM+vM9H38QUxYpM
   YnKnzS9ix7LkVvDEbaL1sCZvUWEyGhf7YUlzqlyH7a+01ja9xPxqbnAA5
   A==;
X-CSE-ConnectionGUID: b9BxSUtdS3OphypWRiFD5g==
X-CSE-MsgGUID: ZPvpUdhCQWmPbmliI1X5DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18177831"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18177831"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915227478"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="915227478"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:23:27 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsSgH-00000001YWz-1DO1;
	Thu, 04 Apr 2024 22:23:25 +0300
Date: Thu, 4 Apr 2024 22:23:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	cristian.marussi@arm.com, sudeep.holla@arm.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <Zg7-LOOf_021X2oP@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <CACRpkdYLqO1XGMiWuGhZoM5wn8T7kFOvJ9LkiUp9W6zPufiP0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYLqO1XGMiWuGhZoM5wn8T7kFOvJ9LkiUp9W6zPufiP0w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 09:03:02PM +0200, Linus Walleij wrote:
> On Thu, Apr 4, 2024 at 7:05 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > The SCMI error value SCMI_ERR_SUPPORT maps to linux error value
> > > > '-EOPNOTSUPP', so when dump configs, need check the error value
> > > > EOPNOTSUPP, otherwise there will be log "ERROR READING CONFIG SETTING".
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > (...)
> > > >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> > > >                 /* These are legal errors */
> > > > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret == -EOPNOTSUPP)
> > >
> > > TBH it's a bit odd to call an in-kernel API such as pin_config_get_for_pin()
> > > and get -EOPNOTSUPP back. But it's not like I care a lot, so patch applied.
> >
> > Hmm... I would like actually to get this being consistent. The documentation
> > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
> >
> > This check opens a Pandora box.
> >
> > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to
> > have them being moved to ENOTSUPP, rather this patch.

$ git grep -lw EOPNOTSUPP -- drivers/pinctrl/ drivers/gpio/
drivers/gpio/gpio-crystalcove.c
drivers/gpio/gpio-pcie-idio-24.c
drivers/gpio/gpio-regmap.c
drivers/gpio/gpio-wcove.c
// drivers/gpio/gpiolib-cdev.c <<< Here it goes to user space, no need to fix
drivers/pinctrl/actions/pinctrl-s500.c
drivers/pinctrl/mediatek/mtk-eint.c
drivers/pinctrl/mediatek/mtk-eint.h
drivers/pinctrl/nxp/pinctrl-s32cc.c
drivers/pinctrl/pinctrl-at91-pio4.c
// drivers/pinctrl/pinctrl-aw9523.c <<< Should be fixed in Linus' tree by me
drivers/pinctrl/pinctrl-ocelot.c
drivers/pinctrl/renesas/pinctrl-rzg2l.c
drivers/pinctrl/renesas/pinctrl-rzv2m.c
drivers/pinctrl/sunplus/sppctl.c
drivers/pinctrl/visconti/pinctrl-common.c

> Andy is one of the wisest men I know so I have taken out the patch.
> 
> Peng, what about fixing the problem at its source? Patch away,
> we will help you if need be.

Indeed.

-- 
With Best Regards,
Andy Shevchenko



