Return-Path: <linux-kernel+bounces-150249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B027F8A9C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FB81F259F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D5165FD3;
	Thu, 18 Apr 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8ICvgq3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB3165FA1;
	Thu, 18 Apr 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449285; cv=none; b=DyZE0lZZgvwGSUR0mCP/Dm2Bz+7Oy2YU7aDXoguJI2ws5CKqQxaqPYOTvvK6mlcLCFh4M/fEP+NeY7nA0RtRmQO0YW4QFfQIBwdq7LTty2QfLZ5Onla3FJmI0fIe/POumoWa3gigZw/W9rQgYqtw9Q5ASUUXBmRSdD4gEPYkMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449285; c=relaxed/simple;
	bh=zLX+DON3azkOLqdmdsfponCDqrWHX+5LAnsUQ7fGmNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSzoZ1pH4EZf9KtNo8XmlpCy9ErPQQdNIRGh7F1FRX9Thhw6i6Vjmu3QL4a9HHR3X0BCVm5pS18aIZze8IqkmQV1PrhBr1gTESJVL34dGcmpgUt0zgYHKLamd3QM7GtUEWyHiCg2P4K1tu0djDHWcbavjOhuo++ZDLoH9o+uq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8ICvgq3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449284; x=1744985284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zLX+DON3azkOLqdmdsfponCDqrWHX+5LAnsUQ7fGmNA=;
  b=L8ICvgq30uKZbogIpeheLoVMhMkGHA8SIBKrJLywhX4DRTpuZOWkN2vW
   q90DNXQ2fyJlp0DB5BKFOTC8BhNf7kPLaqNhfYsejkBLNkNVrU89LZBD1
   AlbRgoxP51mTO8ydpwrM3oJQhVFqrl2LFssVo69A4l0l8cTze9k/vsQN6
   qBZ6OsXdRWtxiTzVQMai/JUcvnK0F0WxJ3pQhHqQrokzvUz5ip+WhAts+
   ufbQ+IqWdcrsWQFWCLRsFeTZbBpVLzZHTa8hcBnOteaf1FzOsmGGhz5TR
   Flymo1gEDvNaEucOpS3U4c2UsxPeNvFJe3zpJt7KHEayxkok7kXPhZa3l
   A==;
X-CSE-ConnectionGUID: +xGfLFcfQvGVuuggXY49Kw==
X-CSE-MsgGUID: 5Xrr6+cTTJ2bLkideGWQfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8865737"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8865737"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:08:03 -0700
X-CSE-ConnectionGUID: tFGmRLArREKBmJrkFNTbTw==
X-CSE-MsgGUID: AHn85mrNQpyZHTLRRfnMjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="22975260"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:08:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxSQf-00000000LY9-3Oft;
	Thu, 18 Apr 2024 17:07:57 +0300
Date: Thu, 18 Apr 2024 17:07:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Brady Norander <bradynorander@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14
 NBLB-WAX9N quirk detection
Message-ID: <ZiEpPVYoC1RqsdA9@smile.fi.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 09:48:27AM +0100, Mauro Carvalho Chehab wrote:
> Newer Matebook D14 model comes with essx8336 and supports SOF,
> but the initial models use the legacy driver, with a Realtek ALC 256
> AC97 chip on it.
> 
> The BIOS seems to be prepared to be used by both models, so
> it contains an entry for ESSX8336 on its DSDT table.
> 
> Add a quirk, as otherwise dspconfig driver will try to load
> SOF, causing audio probe to fail.

..

> +				.ident = "Huawei NBLB-WAX9N",
> +				.matches = {
> +					DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
> +					DMI_MATCH(DMI_PRODUCT_NAME, "NBLB-WAX9N"),
> +				}

I would leave a trailing comma to avoid unneeded churn in the future in case
this gets extended.

> +			},
> +			{}
> +		}

Ditto.

> +	},

-- 
With Best Regards,
Andy Shevchenko



