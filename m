Return-Path: <linux-kernel+bounces-148167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429F8A7E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696E91F23759
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8972F129A73;
	Wed, 17 Apr 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4TxVyDj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F475139F;
	Wed, 17 Apr 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343555; cv=none; b=mJaMjywzc+juoQ1c8vZ4KzeJO/L2Zsuf9bevbsjHehMxaCR4wMhol1AjeJXbF0mz9Yj25Cn2Szc/LRHsTGS/BZquuY/PZG/F5xHXb4gUITKCM0WUWRRq/utH1MpxIClOkp8PzW2SoP8sGMCgNfrV3VB+xhbQoRDISgX19BZLyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343555; c=relaxed/simple;
	bh=DGDR1TQ4GEjxmU4I2WPT0qXg9Na4g1DIFeR8IF/YkD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as9avO8z9rZHw/F6aCZ/gwB8pdPExHPDYwfsoqOv7toRKZtqkyNaCsVlrC+JitdBlXsjpOEx2Ipy6XRX/jYha5kqnBmSyAYdSts/6nWtug3D0WskcJTl2/tRfyDU5gRscbFaQnYvY1ka9Pj6xrJjLeqSKnGa3eg3I/+9wJyvK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4TxVyDj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713343554; x=1744879554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DGDR1TQ4GEjxmU4I2WPT0qXg9Na4g1DIFeR8IF/YkD0=;
  b=O4TxVyDjf8GNGl0zqJOWEPEqjxdJ9iba+xWO6bn18OHZGAMr6VU2Odin
   W1/W6+NlRM+FjbhnVrImw93fYzWLNhRfl/eyD6xki6HbAu0zzuS+BnloW
   +T0o4gLEeFAU/CcLMxSrYkmr0EpcgPUOnJXKMeyGIBQJKUKLAwwtvzw94
   N/z3DeC9cMLXonDIoYR7mA9RF1Cmtj5FslQIcGMWsL2ire0ANcUV/tztn
   omDH857puFHCLCIy3fdIYNCIVDXM7pguBLb04knnwqE2VFiKXseTYBBCW
   /Eee2jjB3sFVdWoNTCdanzbAr0ymiF/deLle5bsLm8zPXiRm6eO9U3Sum
   g==;
X-CSE-ConnectionGUID: S6D2uqSZSemEaRVoq8TyIQ==
X-CSE-MsgGUID: lo/vW5hFT3SG50PRULtfvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9042939"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="9042939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:45:46 -0700
X-CSE-ConnectionGUID: ECKDBFvHTOS9kjeT29b6JQ==
X-CSE-MsgGUID: VqHYRbHcT+eYQVnX3Br7UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="53520463"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:45:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rx0vA-00000004y1K-2EOo;
	Wed, 17 Apr 2024 11:45:36 +0300
Date: Wed, 17 Apr 2024 11:45:36 +0300
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
Message-ID: <Zh-MMAjf6hhNOCpL@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com>
 <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
 <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
 <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 11:07:58PM +0200, Bartosz Golaszewski wrote:
> On Tue, Apr 16, 2024 at 4:05 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 02:22:09PM +0200, Linus Walleij wrote:
> > > On Fri, Apr 12, 2024 at 9:44 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > IIUC include/dt-bindings/ headers should only be used by DT sources
> > > > and code that parses the OF properties.
> > >
> > > That's what I have come to understand as well.
> > >
> > > I wonder if there is something that can be done to enforce it?
> > >
> > > Ideally the code that parses OF properties should have to
> > > opt in to get access to the <dt-bindings/*> namespace.
> >
> > Whatever you, guys, come up with as a solution, can it be fixed sooner than later?
> > I mean, I would appreciate if somebody got it done for v6.9-rcX/v6.10-rc1 so we don't
> > need to look into this again.
> 
> I'm not sure you got what I was saying. I don't think this can be
> fixed quickly. This is just another bunch of technical debt that will
> have to be addressed carefully on a case-by-case basis and run through
> autobuilders in all possible configurations.
> 
> This type of include-related issues is always brittle and will lead to
> build failures if we don't consider our moves.

I proposed a quick fix which was rejected. I think this is still doable in a
few steps:

- align constant values in DT and enum
- drop usage of DT in the kernel code (That's what you want IIUC, however
  I disagree with this from technical perspective as DT constants can be used
  in the code as long as they are mapped 1:1 to what code does. That's current
  state of affairs. OTOH semantically this may be an issue.)
- restore enum usage treewide (?)

Again, the problem now is only in open source / open drain configurations
and there are only a few users of these flags _in kernel_. I do not see
why it can not be done in one or two evenings time range.

P.S>
Most of the time I spent when prepared the proposed fix is digging the history
and trying to understand how comes that we have desynchronisation of the values
over the time. The output of that is the list of Fixes tags.

-- 
With Best Regards,
Andy Shevchenko



