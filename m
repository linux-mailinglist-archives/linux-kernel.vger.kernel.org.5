Return-Path: <linux-kernel+bounces-133301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BC89A1F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FE11C21B0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02837171060;
	Fri,  5 Apr 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHl3hekz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2616F82C;
	Fri,  5 Apr 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332542; cv=none; b=eFoXixmfVvtVDRe2QbAvU04kSak0FNwYNnHsBU1VYJ6yDlhCYTaHfwS67TPZh5zkflA9n0ZmtR91viPCuopWb3dao73vzrbIjYRSsbu84Oc4vZ/QyTaKKEpSnzt0gF01CZvxHKXXO8Hky1IhpwUaZtnE3wsT7U3B0U4cRvbn7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332542; c=relaxed/simple;
	bh=IeVzIxhCDd7OCAhIrOHOjZa0aKtNab8CgE1Nq2v+tZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKsv+NF82I91n5xWS3Xv9rtAZTszFTx07T8cCFFLWHMXARm2Bqev+KVAW7Pzw8vT9z3ei74BKOGG7rtdkehvvmfgXPp1ndyB5Yhk10/cjbsyGe61np0iI1gw+jpxPO0oQSP2G2bgaJf/6yz6dllxCHeZChcl+cdrU+Ev6YTwmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHl3hekz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712332541; x=1743868541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IeVzIxhCDd7OCAhIrOHOjZa0aKtNab8CgE1Nq2v+tZw=;
  b=BHl3hekzSokXBnfM70zu+gSqWvnbIB20fNVGBzK/oAN1nIkQicXwZ04/
   9lWIe7jy+cAoMdr1+xsVYJGyl0gk15qkng+28KEfDi90hcNEruWMgBF9u
   eAUVOUsytETeJcj7M8Y4aFCKQ55Wwfoiw9Ae9gHsTt4V/ji7DJh05sr2R
   MSpUCDKqEox1GdAcrQD4sYSxOI6htF1Zgjae+BUudLeu8kzwMVwlg+ClB
   R6tNv+IdGVN2cg55NI5vharzmUbL128Zf68jHPJLl6EZukgAAA24sSnUh
   zfGKQZfEuGVI/fE1DbIBpUL3GuoYGEv/+G9M7e5fuwnijrQWnKzRRu0TO
   w==;
X-CSE-ConnectionGUID: Hw6Q36LQQnGtwM/usVSjJw==
X-CSE-MsgGUID: SG1P5OhUT/aqlTuWebhBsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7568603"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7568603"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915257712"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915257712"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:55:37 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rslug-00000001n9M-2yqb;
	Fri, 05 Apr 2024 18:55:34 +0300
Date: Fri, 5 Apr 2024 18:55:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAe9oFz9wLQi4de@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
 <ZhAdB4T7sTa2Z7db@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAdB4T7sTa2Z7db@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 04:47:19PM +0100, Sudeep Holla wrote:
> On Fri, Apr 05, 2024 at 06:38:04PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> > > > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > > wrote:

..

> > > > This check opens a Pandora box.
> > > >
> > > > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > > > them being moved to ENOTSUPP, rather this patch.
> > >
> > > I see many patches convert to use EOPNOTSUPP by checking git log.
> >
> > How is that related? You mean for GPIO/pin control drivers?
> >
> > > And checkpatch.pl reports warning for using ENOTSUPP.
> >
> > checkpatch has false-positives, this is just one of them.
> 
> Fair enough.
> 
> > > BTW: is there any issue if using EOPNOTSUPP here?
> >
> > Yes. we don't want to be inconsistent. Using both in one subsystem is asking
> > for troubles. If you want EOPNOTSUPP, please convert *all* users and drop
> > ENOTSUPP completely (series out of ~100+ patches I believe :-), which probably
> > will be not welcome).
> 
> Well, I don't agree with that 100% now since this is GPIO/pinmux sub-system
> practice only.

	git grep -lw ENOTSUPP

utterly disagrees with you.

> What if we change the source/root error cause(SCMI) in this
> case and keep GPIO/pinmux happy today but tomorrow when this needs to be
> used in some other subsystem which uses EOPNOTSUPP by default/consistently.

This is different case. For that we may shadow error codes with explicit
comments.

> Now how do we address that then, hence I mentioned I am not 100% in agreement
> now while I was before knowing that this is GPIO/pinmux strategy.
> 
> I don't know how to proceed now 🙁.

KISS principle? There are only 10+ drivers to fix (I showed a rough list)
to use ENOTSUPP instead of 100s+ otherwise.

-- 
With Best Regards,
Andy Shevchenko



