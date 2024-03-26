Return-Path: <linux-kernel+bounces-119171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C388C513
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B1DB223BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099A12DDAC;
	Tue, 26 Mar 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/wzM7M9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4D12D765;
	Tue, 26 Mar 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463172; cv=none; b=J5GxT9RElCkGZgt7Au7mZBiKT+d+mzph5AlmutcbU2kGYp8hDN2nD0Y2T35oZiMXxXmF3jwmuKVqy664knSXCbMFuLwkA5sW0taFePDeHb5d3RAoddOUsV7vl/mI4RkIPJJE+4RMQ2HZhukibbFe+DWVk7Q9US/X/AAeMiIkr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463172; c=relaxed/simple;
	bh=DNYEsZRuoGx/2qbDmyHpkyB5ZHI17xCru1qD3J5O4jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3HvEvbLS3TdapyLGTCV2ktcbqVgkIejnbE7FLoagsDYAZD9prIlkCFppOV2+o63N17GNd7nfFF1Bti2JZ/q1BzhWLgK1OA7+PyU7IlyQEzgbliaPlr7znn4oav6auVFS4OfXhihGmn9MeoMrQd9L3kCewN4OUL6MnewuowZL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/wzM7M9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711463170; x=1742999170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DNYEsZRuoGx/2qbDmyHpkyB5ZHI17xCru1qD3J5O4jg=;
  b=B/wzM7M9x0f86zrrPd+RsJXL9Vw8BJWFT13P5SKQR2cpre4dct47cWyS
   W43LiR2ZMJ7aFbTnP14pKe4COeXkg337gZLaXRlB5dcU8ybcOsgq8bhD+
   zyQ9k7B/oiGvd+Gri/26eNhFPjTNFpULTv4gKr7WZayYGtAR7vBiWsCxp
   HSnigYjNJNGdNOOXYnFX7Jq3ktw4fBjxELYWRoDNvjbrkM0nPxWI0zlXe
   NDUWPllWd7t4Ad7jQdAG3CVW10KA3l8RzRMS9nlN3l41B4z4i+s8c337w
   tzF9MPf62Dkw4EQ0TbE+95+uuUToFOtTC4W+L7o3Sh7jfhmwcU82SxiXY
   w==;
X-CSE-ConnectionGUID: QkSKV1J5RVGv0fUnQ2DdTg==
X-CSE-MsgGUID: p/WmUXErSZ6efOWE8+waag==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17059745"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17059745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914881913"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914881913"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:26:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp7kb-0000000GKBr-03Jo;
	Tue, 26 Mar 2024 16:26:05 +0200
Date: Tue, 26 Mar 2024 16:26:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZgLa_ElceniDrlCW@smile.fi.intel.com>
References: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com>
 <20240325171804.3375280-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mcf0b0HwAcT=ZQ31rdsuWSDJkg=r9Z6Ni1Tcrg-KCsXsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcf0b0HwAcT=ZQ31rdsuWSDJkg=r9Z6Ni1Tcrg-KCsXsQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 12:58:40PM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 25, 2024 at 6:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> I queued this one for fixes. I will take patch 2/2 through the
> for-next tree as it's not really a fix.

But you asked me to sent them both at once... Whatever, thank you!

-- 
With Best Regards,
Andy Shevchenko



