Return-Path: <linux-kernel+bounces-86616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96E86C7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2861C215B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E17B3DB;
	Thu, 29 Feb 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYRn2x1v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665A79DA7;
	Thu, 29 Feb 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205355; cv=none; b=EHiSUCvlaena6Yq7MXgnPJs5zx+t3ijTzBZq8XAHIy0xC6KMJgGorEJfhGPvKY7Z1xjpaZAJRomrsIkSsMDKF4rNZQ+l/yzgMWx6CkxGvUygV70apeFvTLrzbn8in0aBRppQSekVpTcxs51lMneLUiXFHgDZzrNReKqGqEU8qIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205355; c=relaxed/simple;
	bh=kSg5s07sAS2oPjs5L+tzUrFY7l5odKVVpQ4QLkplBxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeevtkXlwWE4qSIuT4sCXMhIDbvVQlvdNi/2Dczk/JvOQJX4m9WnepGiugZSrUh6Pkg2TIipsxJ6kWCSrZ90GLiQYnBGk5Y/ZveJafP9P3VG+QCscts+tNljByErCfqwlqYKSoeLuTTNxz6ip9OqmHr46erLZPvESif9HGS6Z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYRn2x1v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709205353; x=1740741353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kSg5s07sAS2oPjs5L+tzUrFY7l5odKVVpQ4QLkplBxc=;
  b=JYRn2x1vTptOgQeYPetNDNCHpwzcEWRdJy0ZH0OC5OdO+iEt8vt66Wv7
   i2iFdgTSTSfj6dg7+0WUmUrOldIHaj+thFHRv+VwSpLJEMZRaVfqJDyrE
   djL+nIHModY5YjyHFdiGf8ZASk28TrsyU0bGu/eXdu/2z+rSXjWPS3kBv
   yc3RvSElyOKB2OFiP9yX1H+Fc6C1ofh7FUL66s2GKPykYBfLgMOu77p4A
   CFGC2cGcnHAsPqWJMDpgWIveQsRDXmVrlolDGRGNL28YC3xSlhoSKPVdM
   eINYbmt95wAC3oh/uMPjESLe2lXPQZZeAtq29W9+lvE6b1Aq2dY0bC++i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3791382"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3791382"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913979423"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913979423"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:15:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfeO8-00000008eOC-0rnF;
	Thu, 29 Feb 2024 13:15:44 +0200
Date: Thu, 29 Feb 2024 13:15:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
Message-ID: <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
 <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 03:33:29PM +0100, Théo Lebrun wrote:
> On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Théo Lebrun wrote:

[...]

> > > +	depends on OF
> >
> > Since it's a functional dependency, why not allow compile test without OF
> > being enabled?
> 
> I'd do this then:
> 
> 	depends on OF || COMPILE_TEST
> 
> Which is better than removing the depend line. I wouldn't want the
> kernel to build fine with OF=n even though we need it. OK for you?

Yes!

[...]

> > > +	u32		reg;	/* next 8 bytes are r0 and r1 */
> >
> > Not sure this comments gives any clarification to a mere reader of the code.
> > Perhaps you want to name this as reg64 (at least it will show that you have
> > 8 bytes, but I have no clue what is the semantic relationship between r0 and
> > r1, it's quite cryptic to me). Or maybe it should be reg_0_1?
> 
> Clocks are defined by two 32-bit registers. We only store the first
> register offset because they always follow each other.

> I like the reg64 name and will remove the comment. This straight forward
> code is found in the rest of the code, I don't think it is anything
> hard to understand (ie does not need a comment):
> 
> 	u32 r0 = readl(base_plls + pll->reg);
> 	u32 r1 = readl(base_plls + pll->reg + sizeof(r0));

Btw, why readq()/writeq() (with probably the inclusion of io-64-nonatomic-lo-hi.h)
can be used in this case? It will be much better overall and be aligned with
reg64 name.

[...]

> > I didn't get. If eq5c_init() was finished successfully, why do you need to
> > seems repeat what it already done? What did I miss?
> 
> The key here is that eq5c_init() iterates on eq5c_early_plls[] while
> eq5c_probe() iterates on eq5c_plls[]. I've tried to hint at this in the
> commit message:
> 
> > Two PLLs are required early on and are therefore registered at
> > of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
> > UARTs.
> 
> Doing everything in eq5c_init() is not clean because we expect all new
> clock provider drivers to be standard platform drivers. Doing
> everything from a platform driver probe doesn't work because some
> clocks are required earlier than platform bus init. We therefore do a
> mix.

Am I missing something or these two pieces are using the same IO resources?
This looks like a lot of code duplication without clear benefit. Perhaps
you can have a helper?

> This has been approved by Stephen Boyd in this email:
> https://lore.kernel.org/lkml/fa32e6fae168e10d42051b89197855e9.sboyd@kernel.org/

OK!

[...]

> > > +		eq5c_clk_data->hws[pll->index] = hw;
> > > +		if (IS_ERR(hw))
> >
> > > +			dev_err_probe(dev, PTR_ERR(hw), "failed registering %s\n",
> > > +				      pll->name);
> >
> > Missed return statement?
> 
> No, we still try to register all clocks even if one failed. I guess we
> can call this being optimistic.

But how critical these clocks are? I believe we should panic it we have no
critical calls be available. Otherwise, why '_err_'? Shouldn't be dev_warn()?

-- 
With Best Regards,
Andy Shevchenko



