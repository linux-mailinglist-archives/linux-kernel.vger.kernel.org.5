Return-Path: <linux-kernel+bounces-117425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF688B039
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954F3B3F657
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684F80050;
	Mon, 25 Mar 2024 16:00:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8D5102F;
	Mon, 25 Mar 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382409; cv=none; b=GEcLpsBLgF6gjjYk1fwRaRdncNOJihce37dUEi4P1hXLI5CchiV/AqbhFh3RPHkJyJiYnqTD6tbErB37oXQXj5U8l1nS2CLWtvmoY4lkuP8pu7pcoMj7xafQoZhOQbcUDdcgu2EZgdvoUqxRldAx93oQmZhBEIFaeDAz3QcGyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382409; c=relaxed/simple;
	bh=vO5QORoLybtyN+zRULTiQd4OxdEoYQw7rjhXHbepr9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYzgXeiQBeGBgV9QKmjYtSiWBQClVR8R+f4nVT10MLpG0d2XLlBZ4RpxxpLR2rUOr+bZYLxur78Wk/ePfRgfoUlAo9AWg2/oHaCt1RPBxNimpg+BUPPBG6RBx8cqKFFtMFc/NnPudN4VzwG5i5BXfur0LloQEjjAXTtDcFqILEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="31830937"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="31830937"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914847525"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914847525"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:00:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1romjy-0000000G28F-0e7j;
	Mon, 25 Mar 2024 18:00:02 +0200
Date: Mon, 25 Mar 2024 18:00:01 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] gpiolib: use dev_err() when gpiod_configure_flags
 failed
Message-ID: <ZgGfgY2hITq_MDvl@smile.fi.intel.com>
References: <20240322073725.3338266-1-peng.fan@oss.nxp.com>
 <CAHp75Vds1dmjbaDa0D+Xxoyt_9CgHhoS2j0cR3EQdMp3sbwg5g@mail.gmail.com>
 <CAMRc=McYbsd8t1_6PDypGBme2OSyvy8erdjR51cUzVhM-qQXZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McYbsd8t1_6PDypGBme2OSyvy8erdjR51cUzVhM-qQXZg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 04:48:27PM +0100, Bartosz Golaszewski wrote:
> On Fri, Mar 22, 2024 at 4:59 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Mar 22, 2024 at 9:29 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

..

> > Bart, are you aware that this will add yet another possibility of
> > scary '(null)' in the error level, which is much likely visible to the
> > end users?
> >
> > I propose to apply my fix first to avoid this happening.
> > 20240320165930.1182653-1-andriy.shevchenko@linux.intel.com
> 
> I think you meant the v2[1]?

Yes!

> And sure, I will pick it up shortly.

Thank you!

> [1] https://lore.kernel.org/lkml/20240320165930.1182653-1-andriy.shevchenko@linux.intel.com/T/

I can update this patch (rebase it on top) if needed to make less burden on
the author's shoulders. Just tell me.

-- 
With Best Regards,
Andy Shevchenko



