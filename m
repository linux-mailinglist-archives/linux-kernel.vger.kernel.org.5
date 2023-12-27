Return-Path: <linux-kernel+bounces-12184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F581F106
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BD91F230F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158646540;
	Wed, 27 Dec 2023 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ialvzlAj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA346529
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698848; x=1735234848;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4QCvqb/DyCWRJ65wrTNfN4lRFG+d66oV+D8MH++z4YY=;
  b=ialvzlAjRGXIuvnpe35lTYbbt+0vGgukIUpgPixT9YdL2I4vC1pSpnTW
   KH+IihMTYbZVm26uOlbcW8mzkjlUGJiBPcWmDgcOvIenYYBRQD3SADlN8
   XF34nedWna881Egc5jcj1uv2rAjd6Rl4ndMcH4ckMW6dUEC7hhUn6UwnU
   PbkB3Biyye1RSIl7HPX15Irf3MRp8wr2nNdOhhvAYSkPoYT07JdOtF7lT
   wNLWpI/qQWKuJKoEda8sYpm/dTOTkYTfyFIuj9UALH3Vj7lOHOgT4SZDr
   EpwFLoWcnSjXWpjULctA0YLmd5FVCKHrb43mAnezZ2kOLU0n1LE9iDv+o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="399256616"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="399256616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="921885365"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="921885365"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:40:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rIXtY-00000009TgB-43dz;
	Wed, 27 Dec 2023 19:40:40 +0200
Date: Wed, 27 Dec 2023 19:40:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Joel Stanley <joel@jms.id.au>,
	Walker Chen <walker.chen@starfivetech.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Huisong Li <lihuisong@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Wei Xu <xuwei5@hisilicon.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/40] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <ZYxhmDlShZG23u-Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Sat, Dec 23, 2023 at 01:06:04PM +0300, Nikita Shubin wrote:
> On Wed, 2023-12-13 at 20:37 +0200, Andy Shevchenko wrote:
> > On Tue, Dec 12, 2023 at 11:20:25AM +0300, Nikita Shubin wrote:

...

> > > +       dev_info(dev, "EP93xx SoC revision %s\n", attrs->revision);
> > 
> > Hmm... Is this message anyhow useful?
> 
> Can we keep it please ? It makes us happy when we see it in logs for
> historical reasons - it's been there since 2.4.

Maybe it's good to add in the comment area / cover letter why this is useful.

-- 
With Best Regards,
Andy Shevchenko


