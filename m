Return-Path: <linux-kernel+bounces-148348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2CC8A8142
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6806E2813E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9313C68A;
	Wed, 17 Apr 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWdzLCmT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934313C679;
	Wed, 17 Apr 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350809; cv=none; b=L+lInuyK1F1Oi/J98SfU+8DLYFUuh5VHIcyfLElETDrnL+UW0okKFgNHAuVGY9RL2S8TzG/773liHf9Ztz4EShjZh7GAAlAEIKcvlXdWCNKWy0469RgGhkaZOIkHq9WH1NTqzVZMTfyZRHZI7CLOSOUXAYhLuAxy1JNAEquYTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350809; c=relaxed/simple;
	bh=zRUl1g1oCuh2NUNoJLoN8viN6QzNopdu5zeZVVRrzQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfxxSiph5BJGZh9VDvtd4lS5Feb9kpnuKCxk3J8FiNq3uHxjKFk1Hu+gPtpOvTEIYjUsNIsy4QtxM9h5dy78oS3rzZyHiz0C5AXyhJEY/MnrK55NvYZK8JVm90prGzuBNgDjEv2p11iNOZqlymBO7YBIyON8uruwPoyN911wP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWdzLCmT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713350808; x=1744886808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zRUl1g1oCuh2NUNoJLoN8viN6QzNopdu5zeZVVRrzQM=;
  b=PWdzLCmT6FuV9yGDScsua9hS0vKA5dCWz2HpWv2nmbLxFVTCUtrzBW/c
   P+wtzumMLz7ncBXaf/qATdSic5TUsV8dH4++Rmu5abZMLx4vUUdgk9zJo
   ASATKIakH1qFeH0jc+Ct3cz+aLx/P0kz0DeQ3hKe8c8GVNt8Io+qtspDA
   wlhuJgO7V46rC+ikphE2964ROXvtHBP7i42GD+EfJ+rVcH+WO4oobHmAo
   x8Tz02ySELpUQ3BUH8VjD7kSoXWD+PkUgWEYKRkllJiKdZAqwHHvYxVya
   NU3fm0nVAFKMSrBibzM53wK/GZfEk339YDpmNw44000dP8rr1d67DWPz5
   w==;
X-CSE-ConnectionGUID: eIC3Qzc1Rpmhh7e3DEYplA==
X-CSE-MsgGUID: CJZXqm2SRdqWTrPyWOlXnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9384934"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9384934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:46:48 -0700
X-CSE-ConnectionGUID: 7xesHoykSlmDYwOgGmdBNQ==
X-CSE-MsgGUID: 0o9K/sRaR/iYccEKwJwRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="53539555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:46:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rx2oN-00000004zgo-17WX;
	Wed, 17 Apr 2024 13:46:43 +0300
Date: Wed, 17 Apr 2024 13:46:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [rfc, PATCH v1 1/1] gpiolib: Get rid of never false
 gpio_is_valid() calls
Message-ID: <Zh-oku-XzpcH_8FH@smile.fi.intel.com>
References: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mfh-ojboNUELXfszKUbZRfeZn9vsN-HMTdMQv6my6ZrdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfh-ojboNUELXfszKUbZRfeZn9vsN-HMTdMQv6my6ZrdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 02:06:05PM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 21, 2024 at 10:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > In the cases when gpio_is_valid() is called with unsigned parameter
> > the result is always true in the GPIO library code, hence the check
> > for false won't ever be true. Get rid of such calls.
> >
> > While at it, move GPIO device base to be unsigned to clearly show
> > it won't ever be negative. This requires a new definition for the
> > maximum GPIO number in the system.

> > ---
> 
> It looks like a risky change that late in the release cycle. I want to
> avoid some CI problems at rc6. Please resend it once v6.9-rc1 is
> tagged.

Not sure why resend, but I missed that somehow. Can you consider applying it?

-- 
With Best Regards,
Andy Shevchenko



