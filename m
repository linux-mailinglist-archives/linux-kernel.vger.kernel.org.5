Return-Path: <linux-kernel+bounces-151488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054598AAF86
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9942C1F230E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1112AAEB;
	Fri, 19 Apr 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsUsr1Yc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE41E867;
	Fri, 19 Apr 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533922; cv=none; b=n0yZKTQ9+wmTUDdwlGO/GC0trdA4wPKWX4aeR0Manmp1kbbDAw4fmYcqJqwnFtv9KROwZ3B4fZ/HEaxwl5y4CvudzDX4LAbI4ndVN1mkfGF5ps3a9mDYHWwdHCNxR6SVued8akcTCw+q+QluNVQnYJyadvBbDAiom1MEwE5sv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533922; c=relaxed/simple;
	bh=jwbsC0fD3tXEBhZ8hH6zm5PCin5s6aGx9uVnk3yGJoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI7izlORX3CLzdXG3XhWIM0QS/MRry7AYkkvPb/WYHY9Pmv4UI2o6mHUBX7wNN0XPWkG3j837EzzC7BoQJSwLFgZBNFL4/h8QCdaLbv+PMRJxWqP2MYmOestg17GngxbGIXbPXmOSlSNOMCaEiGbNTeqDAc1iWeZuFeX/TmEw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsUsr1Yc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533920; x=1745069920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jwbsC0fD3tXEBhZ8hH6zm5PCin5s6aGx9uVnk3yGJoE=;
  b=WsUsr1YcUwFELYGPtH/dQoj8amASqcfIAnziqB0+uQXhVusUgogJC9qR
   SittbFdvzA8zzqX9hInxNmxYAu5ecMp0qW7IRZY27Sv8l8QoUIHO5KCwQ
   AA0BzTFVYgU9kds9fTXy96Ao0iEcnZVzEvuW2tCyFH6zLsBvf1gknCGCn
   W1tb8qUohWz/pfOQxfDcput96C1uQPhWTB9NxqaD+BFpJ1YhlRHbwP7uL
   o3N6oMLvoa2Bn/lhOwyVW66toSexVxQKlUrBwyPWIbDD8IVtQs/nZWIbc
   nzKwalQuNKOAjkLDIyNBHCn9tuQ88gYo174/Lkp0BVUJ3hUIZg6CVyj2j
   Q==;
X-CSE-ConnectionGUID: JuCOLS/rS2K6i3k2Iy1fqw==
X-CSE-MsgGUID: H04zGQCEQPSOisgUWM14Rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="19830663"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19830663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:38:39 -0700
X-CSE-ConnectionGUID: xGTWUNaqTR+mk2e2Z+b4iA==
X-CSE-MsgGUID: KBwfq0d6RR2PTnL9rUFSXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="60781831"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:38:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxoRk-00000000jUd-2VWl;
	Fri, 19 Apr 2024 16:38:32 +0300
Date: Fri, 19 Apr 2024 16:38:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
Message-ID: <ZiJz2KP8uNkwZ3vD@smile.fi.intel.com>
References: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com>
 <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
 <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
 <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
 <Zh-MMAjf6hhNOCpL@smile.fi.intel.com>
 <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
 <CACRpkdYHuw1K1VYbTH3YzvmZevt_whNsd1ce58wCSd1+B1np5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYHuw1K1VYbTH3YzvmZevt_whNsd1ce58wCSd1+B1np5A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 19, 2024 at 03:29:13PM +0200, Linus Walleij wrote:
> On Wed, Apr 17, 2024 at 8:40 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > Unfortunately my TODO list runneth over. :(
> 
> When in situations like this, patch the objective into
> drivers/gpio/TODO so others can pick it up, that's why
> I created the file, and it has actually helped a bit!
> 
> IMO you don't even need to send edits to this file for
> review, it's just a work document. Just edit and commit
> it in your tree.

Btw, good point and thanks for the reminder, I believe I also can use it,
but in my case I probably need to send a formal patch :-)

-- 
With Best Regards,
Andy Shevchenko



