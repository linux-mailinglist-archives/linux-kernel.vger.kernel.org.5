Return-Path: <linux-kernel+bounces-131869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B40898CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5A6B26B70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E419125B9;
	Thu,  4 Apr 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERmAQndG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538251C6BC;
	Thu,  4 Apr 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250314; cv=none; b=GrBSE3sxk8GguurQMl/Bwnf64uL9v9w5fMurR84zTB04AxApaXqRa0Ew3GN7kWrtzZ5TrRCDw49SenDASpqmzHAzhJ2DqkafdULMMqaZ8yEkUyqQFFbxtsFQk2KcaMj0etrJda/bsqFtoeOp+6QQYUrHYfq1+ruACzuY+ucVHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250314; c=relaxed/simple;
	bh=ciuhxV+lxpulzdqgBI0ASX/tPUFRGPCHizIhzVA75GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyMzruATG6zB/uS+DMZxziQQhuOR+2ya7E4m9CxFbORgPhnLlR0wXhBZdW4vqmqTYpR5vebw6MOnHc7t/2/Go5flZs+89CMjRvctmj9zm/1KEjxKTna/t31ot4jekI/SAqQiwQMfYs77RirgpGffrzxc9oV7Hf36wddsatxiEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERmAQndG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712250312; x=1743786312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ciuhxV+lxpulzdqgBI0ASX/tPUFRGPCHizIhzVA75GQ=;
  b=ERmAQndGdDzEZ37USJLxIjNOOJidrSz6xozPYe+HJeV4a54cqtXGts0f
   PGXGlVIncBJQPcs1hBsZqLa0ZXhs8QyRKNlEivDCd8YBgfaaGcQ7C2vWr
   Dd4pH8v5FsezWA/5mjIDU5LdHX/TMnxq+xnzZuzCvR7VbRWWIeJEFRC60
   5N2daMzVX7FFUCof8EeXuQkQNEkKm04pWM4RogTwdckZdT7u/1R8HBjm6
   PV5vYipZHnp2RYBj/Y5bQK4hU0ggZHHHwb+92Kb3iEHlhAZJrJAzG4Uam
   4ZYZ+rhtQgosIAR/La+WNOWkAanklD/jl07jdNk7CMQaeEyyCi/p24MBw
   w==;
X-CSE-ConnectionGUID: p3iTTt48TzKiYiVCax8MDQ==
X-CSE-MsgGUID: eXPQlIF5TLuEhKpVDDOfrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="32949982"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="32949982"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915223889"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915223889"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:05:08 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsQWP-00000001WTh-3noL;
	Thu, 04 Apr 2024 20:05:05 +0300
Date: Thu, 4 Apr 2024 20:05:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	cristian.marussi@arm.com, sudeep.holla@arm.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> 
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The SCMI error value SCMI_ERR_SUPPORT maps to linux error value
> > '-EOPNOTSUPP', so when dump configs, need check the error value
> > EOPNOTSUPP, otherwise there will be log "ERROR READING CONFIG SETTING".
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> (...)
> >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> >                 /* These are legal errors */
> > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret == -EOPNOTSUPP)
> 
> TBH it's a bit odd to call an in-kernel API such as pin_config_get_for_pin()
> and get -EOPNOTSUPP back. But it's not like I care a lot, so patch applied.

Hmm... I would like actually to get this being consistent. The documentation
explicitly says that in-kernel APIs uses Linux error code and not POSIX one.

This check opens a Pandora box.

FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to
have them being moved to ENOTSUPP, rather this patch.

-- 
With Best Regards,
Andy Shevchenko



