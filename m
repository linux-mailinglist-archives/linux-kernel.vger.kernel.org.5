Return-Path: <linux-kernel+bounces-9993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3481CE46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859041F22E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559742C1A0;
	Fri, 22 Dec 2023 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYOUwc4E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9BB2C186
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703268409; x=1734804409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OTkHZtigUt4nvfL8RVPC1l7hn5WRdg7Ve8eBBtnbUqE=;
  b=cYOUwc4Eu9yqosWuHyCf+NAl0dATEx6wV6s38opjTIi4aDt9pJRsE/Kx
   Pp9QVEyd97cxrsK8oRDVodphfhRm0n/ROQEo3irkpiGMDEp0Yh4XarcJr
   J8TMoZyXmjx30amWkGZtqoBg7SV53CExxktjzq9M+ywy0SCFM3GHo70Db
   ksZwiRvVp9ZtHGqsrlSjsDUdG7D135iZB1fIqX8zc5u8ZMhZtMgY7PP22
   zROxJOTKxJcT3bk9N4xNZmzJEg9V+gZZdaPdW1W8VoWW8jF9qkBdXjIL/
   x2FifZb8tASavfhkmdb3gYs6qVkuukWEgetLxwaXKOByzMh45nb38Q/DO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="17711002"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="17711002"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024259085"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="1024259085"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:06:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGjv2-00000008ElL-1iwq;
	Fri, 22 Dec 2023 20:06:44 +0200
Date: Fri, 22 Dec 2023 20:06:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: Step down as a reviewer
Message-ID: <ZYXQNK27Y0IYP6yv@smile.fi.intel.com>
References: <20231222140017.2887224-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb9vd4_Cdv8LnhpyC5N8Cs+CSvwYGzG9Hw+z=Wv_moK2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb9vd4_Cdv8LnhpyC5N8Cs+CSvwYGzG9Hw+z=Wv_moK2w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 06:34:40PM +0100, Linus Walleij wrote:
> On Fri, Dec 22, 2023 at 3:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Too many things are going on, and reviewing GPIO related code
> > seems not the best I can do, hence step down as a reviewer of
> > the GPIO subsystem.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Fully understandable.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I hope we can still loop you in for anything ACPI-related?
> I would feel lost without you there :/

Sure, I continue maintaining Intel GPIO stuff along with helping Mika and
Bart with ACPI part.

-- 
With Best Regards,
Andy Shevchenko



