Return-Path: <linux-kernel+bounces-150246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD668A9C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5201C21DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A53165FC6;
	Thu, 18 Apr 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkXTxT0h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB11635BB;
	Thu, 18 Apr 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449187; cv=none; b=dMIt+jz/NuQDUVuRszd8XazMIxa02bEWJqE5OL8kpIQDUkV2dbjuv0+LmFZPubNVWXpHYRemZhhbP+1W7ZnyzIObt4fiCjSksLmidDNSok2u9jy4PAHGV1ZhvfFsru824BzKm49Rz3etriK3PojBRpq79pHx5Luv6sxUcLiF1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449187; c=relaxed/simple;
	bh=3YBAhug6qnYbrwHMU3AQlsVu+rP6SuLilqBbuRRIT2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlTI7TIVvQnzaPOmvZFA0CtUJ3JhU5h011ui1vzWxoqdGbEndevzfQ1a5u4i2IAZAn75yD/1jIouKQydQ43i9WS7S/KM3LOeoH6n2LoDRZLT/QIpqW7zkbymT7hrkeQ+lYmgdzHXuc5eKlfsB1YGE9MhddznHmX+kKt+fxwXGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkXTxT0h; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449186; x=1744985186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YBAhug6qnYbrwHMU3AQlsVu+rP6SuLilqBbuRRIT2M=;
  b=ZkXTxT0hFm+VChWonHa5JerPgtEO5fefUs57TOFhgvgzNi1efk3/7Wdy
   qnR2oerhm+0PlTZwqf1h8ALNhMfpLeSpsjxohxeGwZi9nmebaN1VW6Au/
   O/HnzEiDm1AsKmlMSPIl6oClYXSjUgA9aYGpsuAokoRIg/qw9eX+RGA6z
   k4Rr5iLgQ8ndJRgMGGobbR2iUexVYnWYd6AuMOaGb8z7vp2HGyEwoaH3Q
   lxDJwKJWTk0fg4w//VHgeGnV0kz3WiofuYpMsIAcDK12sRuO0TsQ+sjsx
   rTjZk1OK5H7iVMlxFiHkliXghhXKM8d7wIAbK4tRa5A/C7s3xmu1K01C3
   Q==;
X-CSE-ConnectionGUID: 8sLxLxgyT1Ok+SiUoG9OSQ==
X-CSE-MsgGUID: 4hZ/nmgRTpievIMDdjpXpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="11939548"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="11939548"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:06:06 -0700
X-CSE-ConnectionGUID: 839f+huFQmCuW6AHnr2wnA==
X-CSE-MsgGUID: etJULpyqTaO8NbFE1ejEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23076351"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:06:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxSOm-00000000LWm-29pS;
	Thu, 18 Apr 2024 17:06:00 +0300
Date: Thu, 18 Apr 2024 17:06:00 +0300
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
Message-ID: <ZiEoyDaRHPZkFI-T@smile.fi.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
 <20240418110453.10efcb60@sal.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418110453.10efcb60@sal.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 11:04:53AM +0100, Mauro Carvalho Chehab wrote:
> Em Thu, 18 Apr 2024 09:48:27 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> 
> > Newer Matebook D14 model comes with essx8336 and supports SOF,
> > but the initial models use the legacy driver, with a Realtek ALC 256
> > AC97 chip on it.
> > 
> > The BIOS seems to be prepared to be used by both models, so
> > it contains an entry for ESSX8336 on its DSDT table.
> > 
> > Add a quirk, as otherwise dspconfig driver will try to load
> > SOF, causing audio probe to fail.

..

> Worth to mention that I opened an issue on Github about that:
> 
> https://github.com/thesofproject/linux/issues/4934
> 
> I added there the ACPI DSDT table as a reference.

Yeah, please add a BugLink tag.

-- 
With Best Regards,
Andy Shevchenko



