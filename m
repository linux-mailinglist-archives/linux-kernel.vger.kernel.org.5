Return-Path: <linux-kernel+bounces-150013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6E8A9916
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497F31F2102B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1FB15F320;
	Thu, 18 Apr 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiiJ4opM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D615ECCC;
	Thu, 18 Apr 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441132; cv=none; b=e1G6UEtMb9E7+EnrmZBHmbzdO0XTzju2y6nff1H0p4qRWu/6H4dCgIcnI8MdBqNySylG00y1QC6N54Sn066RW0FOb+Uxw1DpbEXvjLHwZ1GKwtSq+/A1jJfoXeK6+1FYw4vFygepcrOvRhPWz8tr4pTP2+a+2ZVZT3uh4nllyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441132; c=relaxed/simple;
	bh=NNLjt8tWDXIZVT3SCOlsS+2zQ3f4L2mZhjbwYH3fVHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XegtpbgPKDTNUl4yJBoJz8eSCuMBZuCr7QDI+vUca6643m4lr5OMh/iyhmH8yt/q6X9wkHyvuoKtCfWkfQ/WoSy77L3j1VWLZCdU9W6Ecww51fM4UQm1pbcrg8t1eugJH+NMmDQLWZnvHzGc1Eqee5YGXrhxGup3nun4tQOsAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiiJ4opM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713441130; x=1744977130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NNLjt8tWDXIZVT3SCOlsS+2zQ3f4L2mZhjbwYH3fVHY=;
  b=AiiJ4opMGlKAGTQ7+vdBqKchWhTjGGxHGC90tvdDz5c8xv8kvcZ0ISZt
   46wzDYGVNmpKzvajLurrbCYseosL9E3CMnF2A0ix3ZcE3vWtz+U9c17SL
   QGm8LFR1knx6ermiMPJ7+4JobZujKgehkzAKCS+8EWUOYSGoP96hhi8H0
   MYxsOlvCu+hGnLBkqfCxwyEyI8KJOFp+cIMxS2qXPcCk35vASSpXmeNI2
   7n3WG7BQ6hvnUQYP2HLI9Dz0DJSDzBQIqK8R1yLTVKtirMupX0wtVdI6+
   4PQX87FhBhVMPkrS6GVmjB0371F3H5dkpf49LE7kkq9BwT8N6JeG6xsP6
   Q==;
X-CSE-ConnectionGUID: MedRW+rRS/qUqf7fXQiSiw==
X-CSE-MsgGUID: 7yT2wxYGT86weIhOW8WxoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19681133"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19681133"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:52:10 -0700
X-CSE-ConnectionGUID: tFOkMf+JQ6ijNWjkG/hSmA==
X-CSE-MsgGUID: qFJqIMf5QP2xm/Krp1j0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23567364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:52:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxQJ9-00000000JcA-0NbX;
	Thu, 18 Apr 2024 14:52:03 +0300
Date: Thu, 18 Apr 2024 14:52:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <ZiEJYiNNnx_gYvm1@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com>
 <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
 <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
 <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
 <Zh-MMAjf6hhNOCpL@smile.fi.intel.com>
 <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 08:39:52PM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 17, 2024 at 10:45 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 16, 2024 at 11:07:58PM +0200, Bartosz Golaszewski wrote:

..

> > Again, the problem now is only in open source / open drain configurations
> > and there are only a few users of these flags _in kernel_. I do not see
> > why it can not be done in one or two evenings time range.
> 
> So you know what needs doing. I'm at a conference now, I'll be off for
> a week in April and I also have another conference scheduled for May.
> If you believe this needs addressing urgently, then I suggest you do
> it right. Otherwise, I'll get to it when I have the time.
> Unfortunately my TODO list runneth over. :(

I have started already as you may have noticed.

> But I have to say, I suspect it won't be as easy as you present it
> because we have so many build configs that may fail.

Let's see (with a hope)...

-- 
With Best Regards,
Andy Shevchenko



