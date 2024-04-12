Return-Path: <linux-kernel+bounces-142945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F198A3262
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6CE1C231C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19F1482F0;
	Fri, 12 Apr 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKnYZYTU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6859B4D;
	Fri, 12 Apr 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935537; cv=none; b=eXCyGl4AHQBOd5VbEjRkqvg+veAztgUvxDAVmRYZJgGCUfjmxLFMnPSxWJAp9Z0/COfi0XkpJ1GvwoZPmUSykZY2//J2Y4XCFPrh3Czx/beoXymhGH9lNciahVD2zXIS326TvotTA6w+O7IXXJgYTwT7nyd5THs/td4lxBw69x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935537; c=relaxed/simple;
	bh=S7VlHsyelUFtnPDVEGGP64cpKaza4iYLGNQG1vXStlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNOHb/uDK0Cf7Pk2rw841+QsDHhK/WUcF4nwMTCfQvpT/2v9BhyjwdrXbK2LSI8PsrmwJcEcsaYAjmncMAaeLsOM2VLyu6kOBdzeG1gbhGk7F7o2Y2CPokAGZnostI0ehSA97xTdZg7gLzwNMOZ3yrZw8dv4+WKs8+nI3S+mkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKnYZYTU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712935536; x=1744471536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=S7VlHsyelUFtnPDVEGGP64cpKaza4iYLGNQG1vXStlA=;
  b=GKnYZYTUGebXahtTGce3t5k6JuuhXvYEj02j4Lk0Z3Mf8YYAIDPWsXMh
   gdDegLjNwzlroCSuwWARR+1nN6qoOEkjarP/expL0ZxuohDwqk3byO7er
   635GJULo6BDyoDXEeWN8cSS0VKwwyiKxTStCNPjaw0N/v29QJ5X/awSaR
   /i2erpSB6nH6kfGf1fQ2FH7gSQYBs8rfrW6+eLpz1qlRm5p4n/TSX4dBd
   Fgz4i+pJIK3+r/gTCkqKE+/osIAwWubarFn4XUBbRpv5p4b16gLNdy9q5
   0TScxHKsWTiRjs+O71Uh5cVs8WUhKgEEnPykJMsi6S6E/kULjcJ29yMVe
   A==;
X-CSE-ConnectionGUID: BNEQbgFhT3+ICi1Bzschgw==
X-CSE-MsgGUID: BeciHRa2RXGyOBeCw/4iAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8501292"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8501292"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:25:35 -0700
X-CSE-ConnectionGUID: Ja/542BbQrK9JUasDdDx8A==
X-CSE-MsgGUID: wm3UbjEVTWmdccyxEx2mtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="44521129"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:25:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvImP-00000003giR-0AId;
	Fri, 12 Apr 2024 18:25:29 +0300
Date: Fri, 12 Apr 2024 18:25:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
Message-ID: <ZhlSaFWlbE6OS7om@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 10:20:24AM +0200, Linus Walleij wrote:
> On Tue, Apr 9, 2024 at 1:17 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The GPIO_* flag definitions are *almost* duplicated in two files
> > (with unmatches OPEN_SOURCE / OPEN_DRAIN). Moreover, some code relies
> > on one set of definitions while the rest is on the other. Clean up
> > this mess by providing only one source of the definitions to all.
> >
> > Fixes: b424808115cb ("brcm80211: brcmsmac: Move LEDs to GPIO descriptors")
> > Fixes: 5923ea6c2ce6 ("gpio: pass lookup and descriptor flags to request_own")
> > Fixes: fed7026adc7c ("gpiolib: Make use of enum gpio_lookup_flags consistent")
> > Fixes: 4c0facddb7d8 ("gpio: core: Decouple open drain/source flag with active low/high")
> > Fixes: 69d301fdd196 ("gpio: add DT bindings for existing consumer flags")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The way the line lookup flags ("lflags") were conceived was through
> support for non-DT systems using descriptor tables, and that is how
> enum gpio_lookup_flags came to be.
> 
> When OF support was added it was bolted on on the side, in essence
> assuming that the DT/OF ABI was completely separate (and they/we
> sure like to think about it that way...) and thus needed translation from
> OF flags to kernel-internal enum gpio_lookup_flags.
> 
> The way *I* thought about this when writing it was certainly that the
> DT bindings was a separate thing (<dt-bindings/*.h> didn't even exist
> at the time I think) and that translation from OF to kernel-internal
> lflags would happen in *one* place.
> 
> The main reasoning still holds: the OF define is an ABI, so it can
> *never* be changed, but the enum gpio_lookup_flags is subject to
> Documentation/process/stable-api-nonsense.rst and that means
> that if we want to swap around the order of the definitions we can.
> 
> But admittedly this is a bit over-belief in process and separation of
> concerns and practical matters may be something else...

Got it. But we have a name clash and the mess added to the users.
I can redo this to separate these entities.

Note, that there is code in the kernel that *does* use
#include <dt-bindings/*.h>
for Linux internals.

$ git grep -lw '^#include <dt-bindings/.*\.h>' -- drivers/ | xargs dirname | cut -f 1,2 -d '/' | sort -u
drivers/bus
drivers/clk
drivers/clocksource
drivers/cpufreq
drivers/dma
drivers/firmware
drivers/gpio
drivers/gpu
drivers/hwtracing
drivers/i2c
drivers/iio
drivers/input
drivers/interconnect
drivers/iommu
drivers/irqchip
drivers/leds
drivers/mailbox
drivers/media
drivers/memory
drivers/mfd
drivers/net
drivers/phy
drivers/pinctrl
drivers/platform
drivers/pmdomain
drivers/power
drivers/pwm
drivers/regulator
drivers/remoteproc
drivers/reset
drivers/rtc
drivers/soc
drivers/spmi
drivers/thermal
drivers/tty
drivers/video
drivers/watchdog

P.S>
One of the patch this tries to fix is yours IIRC :-)


-- 
With Best Regards,
Andy Shevchenko



