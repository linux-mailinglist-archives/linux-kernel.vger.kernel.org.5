Return-Path: <linux-kernel+bounces-133333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3089A269
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368D91F2452A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C617108D;
	Fri,  5 Apr 2024 16:23:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C816F82C;
	Fri,  5 Apr 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334218; cv=none; b=oBLkx+SoYtKL+rddO42oIbWbGBTOebvLuC58F07IodstxsApjNBs8C/MbFZpuL8dcdzeBkRVaHdRo70m3jvUyEDwxi1mePyf32STJCEF068QGrXs34Ig+2WzO/PWAMPQuBHHgGzQRVuj0tO+ziKmLPN5mTiaD0tBXGMUe9JUtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334218; c=relaxed/simple;
	bh=UPv37TzvUi6i5rEA4aCj5ObZmslNLTryMSZkqevsCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udy+IllJkWQPt9vENKPBBH+ZNqu3ld0gkaox3rHMrozoNnvJv0oJcGA6Cy6vlKF3u2PCcKVoOis1CM6cUr2yxwpro2cvQb/MpmTMP/mW1Bkockv1mH+xPtGr9y4reswZ0bHNSfrsaHEWNLR7CsmCE4by9Vprc7HODLuIm6aZ+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 097E4FEC;
	Fri,  5 Apr 2024 09:24:06 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 209373F64C;
	Fri,  5 Apr 2024 09:23:34 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:23:31 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAlg0Zu_2uOQMk_@pluto>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
 <ZhAdB4T7sTa2Z7db@bogus>
 <ZhAhcI3g4xJ1ANzu@pluto>
 <ZhAj-LZWv4M3vS6F@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAj-LZWv4M3vS6F@smile.fi.intel.com>

On Fri, Apr 05, 2024 at 07:16:56PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 05:06:08PM +0100, Cristian Marussi wrote:
> > On Fri, Apr 05, 2024 at 04:47:19PM +0100, Sudeep Holla wrote:
> > > On Fri, Apr 05, 2024 at 06:38:04PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> > > > > > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > > > > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > > > > wrote:
> 
> ...
> 
> > > > > > > >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> > > > > > > >                 /* These are legal errors */
> > > > > > > > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > > > > > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret ==
> > > > > > > > + -EOPNOTSUPP)
> > > > > > >
> > > > > > > TBH it's a bit odd to call an in-kernel API such as
> > > > > > > pin_config_get_for_pin() and get -EOPNOTSUPP back. But it's not like I care
> > > > > > a lot, so patch applied.
> > > > > >
> > > > > > Hmm... I would like actually to get this being consistent. The documentation
> > > > > > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
> > > > >
> > > > > Would you please share me the documentation?
> > > >
> > > > Sure.
> > > > https://elixir.bootlin.com/linux/latest/source/include/linux/pinctrl/pinconf.h#L24
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2825
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2845
> > > >
> > > > I admit that this is not the best documented, feel free to produce a proper
> > > > documentation.
> > > 
> > > Ah OK, my bad. I assumed you were referring to the entire kernel tree and
> > > not just GPIO/pinux. Sorry for that.
> > 
> > ... from this thread, my understanding too was that this forbidden usage of
> > POSIX errors for in-kernel API was general to any subsystem...so the ask
> > for docs about this...
> > 
> > > > > > This check opens a Pandora box.
> > > > > >
> > > > > > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > > > > > them being moved to ENOTSUPP, rather this patch.
> > > > >
> > > > > I see many patches convert to use EOPNOTSUPP by checking git log.
> > > >
> > > > How is that related? You mean for GPIO/pin control drivers?
> > > >
> > > > > And checkpatch.pl reports warning for using ENOTSUPP.
> > > >
> > > > checkpatch has false-positives, this is just one of them.
> > > 
> > > Fair enough.
> > >
> > > > > BTW: is there any issue if using EOPNOTSUPP here?
> > > >
> > > > Yes. we don't want to be inconsistent. Using both in one subsystem is asking
> > > > for troubles. If you want EOPNOTSUPP, please convert *all* users and drop
> > > > ENOTSUPP completely (series out of ~100+ patches I believe :-), which probably
> > > > will be not welcome).
> > > 
> > > Well, I don't agree with that 100% now since this is GPIO/pinmux sub-system
> > > practice only. What if we change the source/root error cause(SCMI) in this
> > > case and keep GPIO/pinmux happy today but tomorrow when this needs to be
> > > used in some other subsystem which uses EOPNOTSUPP by default/consistently.
> > > Now how do we address that then, hence I mentioned I am not 100% in agreement
> > > now while I was before knowing that this is GPIO/pinmux strategy.
> > > 
> > > I don't know how to proceed now 🙁.
> > 
> > from checkpatch.pl:
> > 
> > # ENOTSUPP is not a standard error code and should be avoided in new patches.    
> > # Folks usually mean EOPNOTSUPP (also called ENOTSUP), when they type ENOTSUPP.  
> > # Similarly to ENOSYS warning a small number of false positives is expected.     
> >  
> > ...so it seems to me that the this is NOT a false positive BUT Pinctrl/GPIO
> > subsystem is an exception in these regards, since this is what is explcitly
> > state in checkpatch comments AND there is no generalized doc on this....
> 
> Checkpatch is false positive _in this case_.
> And in practice it's not the first and not the last false positive by checkpatch.
> Again, checkpatch is a recommendation, not a letter of law. Documentation is.
> 
> > ....but twe can happily oblige to Pinctrl expectations by remapping to ENOTSUPP
> > in the pinctrl protocol layer or driver...just I won't certainly do that at the
> > SCMI core layer at all at this point...as Sudeep said ...especially because there
> > is NO generalized docs for the above ban of POSIX errors for in-Linux kernel API...
> 
> There is no ban, we use POSIX error codes heavily in kernel.
> 
> If you think GPIO/pin control has a flaw, send patches. I'm not a maintainer there,
> perhaps conversion of all GPIO and pin control drivers to POSIX error code will be
> warmly welcome, who knows.
> 
> But before that, we want to have ENOTSUPP from callbacks that are used in
> GPIO/pin control drivers for the sake of consistency.
> 

Yes, my point was simply to say to fix the retcode of SCMI pinctrl to comply with
Pinctrl expectations, and definitely NOT to fix and move to ENOTSUPP all the SCMI
originated errors across all protocols, since it is NOT what is expected in general
by other susbsystems.

Thanks,
Cristian

