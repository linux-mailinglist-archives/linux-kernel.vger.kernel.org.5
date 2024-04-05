Return-Path: <linux-kernel+bounces-133267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B344789A178
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F0C1C21A46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54317107F;
	Fri,  5 Apr 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgzLfTYk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDED171076;
	Fri,  5 Apr 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331492; cv=none; b=ISDP2fIuIXV2JsDNsTqe7nPdtuL3C38C8lQops3KbbpTcerhemFozayoX4P8V+uPnDuxzRfoGWlkRw+0tG9Ud7/oTUCXw+UbYmAkG4P7bfXRkfmK1WpT2BcEeQBf90bzQdNEmz3mFwwdtxtGQTum1BVooS+1TGcvk96Wd1zBGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331492; c=relaxed/simple;
	bh=yEYVeHEInPzW3a9z6mWy7L2Kno4mtCimXz7h7++XBBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwYiqoVRnRCAgIiNNA+wWvjX0azLSxPxv3Z/lR0gbBrIRSH++AmrBYOzRAl2gjkqoUJHv00aJxiwrlYhWV9CiD0dx7siEU67DaMpgC871TW+5zYtI3voaH9xF7xGRPUvovioZ6fpW2Zusy8e2DajAT2f0kOkGsqt/TcH7lWa5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgzLfTYk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712331490; x=1743867490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yEYVeHEInPzW3a9z6mWy7L2Kno4mtCimXz7h7++XBBc=;
  b=PgzLfTYkw5kG2DbUkiNBAMMyYGPQx+x2FAd/zyGHwBbDYaGVb/CpuNUn
   WtRn2WAZtUojcMp4Fsp4zTMaYGZO3VznqX4mFxizEHLEvA3PnWIAUN0RH
   /WDCWCWr48jdt7UbMc5RvNHhyIXqdOV5QIJ8tswx7NTmBvXJ8kn22Uyom
   LZO9elyD40U0aimobO030Fjuzh6Q1Hj05uPsSJgsr2oTGXx+V59O+LFfd
   /m4SG8gNizfhk8moY/bf/h8sMQLOf72Ms4hXaZXP3FPgMqjmavtVQO+ZI
   s9pNNedJU/Y30+m8y4AtDFVHcqaduZSYf7RyhGayDzafM1H1CJymV71tF
   A==;
X-CSE-ConnectionGUID: dEkJQMzfSOa6SIbleYfT6g==
X-CSE-MsgGUID: 9++S5BVFSja9DNx6xxh8Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7565738"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7565738"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915257297"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915257297"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:38:07 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsldk-00000001muZ-3UUC;
	Fri, 05 Apr 2024 18:38:04 +0300
Date: Fri, 5 Apr 2024 18:38:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAa3NPO19mINYJP@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:

..

> > > >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> > > >                 /* These are legal errors */
> > > > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret ==
> > > > + -EOPNOTSUPP)
> > >
> > > TBH it's a bit odd to call an in-kernel API such as
> > > pin_config_get_for_pin() and get -EOPNOTSUPP back. But it's not like I care
> > a lot, so patch applied.
> > 
> > Hmm... I would like actually to get this being consistent. The documentation
> > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
> 
> Would you please share me the documentation?

Sure.
https://elixir.bootlin.com/linux/latest/source/include/linux/pinctrl/pinconf.h#L24
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2825
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2845

I admit that this is not the best documented, feel free to produce a proper
documentation.

> > This check opens a Pandora box.
> > 
> > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > them being moved to ENOTSUPP, rather this patch.
> 
> I see many patches convert to use EOPNOTSUPP by checking git log.

How is that related? You mean for GPIO/pin control drivers?

> And checkpatch.pl reports warning for using ENOTSUPP.

checkpatch has false-positives, this is just one of them.

> BTW: is there any issue if using EOPNOTSUPP here?

Yes. we don't want to be inconsistent. Using both in one subsystem is asking
for troubles. If you want EOPNOTSUPP, please convert *all* users and drop
ENOTSUPP completely (series out of ~100+ patches I believe :-), which probably
will be not welcome).

-- 
With Best Regards,
Andy Shevchenko



