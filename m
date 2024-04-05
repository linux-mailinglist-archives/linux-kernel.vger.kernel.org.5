Return-Path: <linux-kernel+bounces-133271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAE89A17E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6860D1F219CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6A16FF33;
	Fri,  5 Apr 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtnnTpbp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548D16F8E7;
	Fri,  5 Apr 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331575; cv=none; b=EdQnkxD/z6FyaFyXpGGItlUIURQXhdf0d+9qTjWc3xmduzNheJPXB54ImoelNyiCf4NZvNTCAQxDbOAwssnDBa1M3SxEXPfUIj8ikq4ISOD9qPBCzxmDM/aK8pcK/vmTzHefWuXfkMU2vIlu7KLZXIUuBHf/wi9mxFBTL2lGIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331575; c=relaxed/simple;
	bh=9a5wWcb4/mZbxlW/jWQh98jPjoVQcPSfchAefa9YY+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG2Yhx6vahYkNsMWDScrzg5yieJ49Bq9UmMph2ZpPkMSFP/nGMLVCt02U/5s6S5SvGz06jIuep5mnzkoxA5WNi1jItqR2EJb9XqectSWLzQz41mWpwfpCWnxIXhfpjralgHnLqbymJa3td/TxOc04BOcpUs5rJvuatFOTql9nb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtnnTpbp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712331574; x=1743867574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9a5wWcb4/mZbxlW/jWQh98jPjoVQcPSfchAefa9YY+I=;
  b=JtnnTpbp5ObqP8r0KiHgmTeQdP0lFywsvQqjmQx7UP5Xj+Zans6DiIXS
   2mcoN1oV0Lh3qs50Iz98gnJJAG4q7bvQyt582KvtpnKHZvWVmMUl9XYqj
   N4yWnXI4M1O1Xbz0kc1uTTxnqk3KgNlP/32CQ2gAMIXAYNmzo9rWYl3JY
   cJJMnlBYXw9uBEJnKJHzcBxwJndv83lB3+AJTFcXP3hAJtgl5gP1CmJkL
   hIbCS7/Lz9YX+0DLJNgkjdMFctJ11kCfSgrzBBOZi8RvmUSHr52Xg0Jie
   IreXqg4trtU3SYCh8Okol7jxodqOkG5WQmELv9FjTaAtfITOFH3fp+iYd
   w==;
X-CSE-ConnectionGUID: hQCzJQIHTc+4865UYCegVw==
X-CSE-MsgGUID: 3qRpq0aPT3q/w47JB4dPxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7565967"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7565967"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915257320"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915257320"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:39:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rslf6-00000001mvK-3A78;
	Fri, 05 Apr 2024 18:39:28 +0300
Date: Fri, 5 Apr 2024 18:39:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peng Fan <peng.fan@nxp.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAbMA-ezv4hwBGn@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zg_IXLNPakLmbbc7@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg_IXLNPakLmbbc7@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 10:46:04AM +0100, Sudeep Holla wrote:
> On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> > > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > wrote:

..

> > > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret ==
> > > > > + -EOPNOTSUPP)
> > > >
> > > > TBH it's a bit odd to call an in-kernel API such as
> > > > pin_config_get_for_pin() and get -EOPNOTSUPP back. But it's not like I care
> > > a lot, so patch applied.
> > >
> > > Hmm... I would like actually to get this being consistent. The documentation
> > > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
> >
> > Would you please share me the documentation?
> 
> +1, I am interested in knowing more about this as I wasn't aware of this.

See my previous reply.

> > > This check opens a Pandora box.
> > >
> > > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > > them being moved to ENOTSUPP, rather this patch.
> >
> > I see many patches convert to use EOPNOTSUPP by checking git log.
> >
> > And checkpatch.pl reports warning for using ENOTSUPP.
> 
> Exactly, I do remember changing ENOTSUPP to EOPNOTSUPP based on checkpatch
> suggestion.

Sometimes suggestions can be wrong. Checkpatch is famous for false-positives as
it's a dumb tool, it can't know about everything.

> So either the checkpatch.pl or the document you are referring
> is inconsistent and needs fixing either way.

True.

-- 
With Best Regards,
Andy Shevchenko



