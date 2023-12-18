Return-Path: <linux-kernel+bounces-3750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE081708E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A10DB22795
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170D215AC0;
	Mon, 18 Dec 2023 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvOixr8Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAD8464;
	Mon, 18 Dec 2023 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702906573; x=1734442573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a5GDcbwHgcbglt1fXQlmKbTjDV6jAxY5nqgxK8s2H88=;
  b=kvOixr8YAjjkJSOLJyVqgzDncWx2Lmc2tPkXZ+eNsB2XWojuDKptQh17
   jO248OJ8ndkyClDWHEOCXtla5N4GwQUqlgjFm7MZX8f/1ppBkk/x52jEH
   xppg4CC3kt3V7mYx6LkaVS7Q3QHDdlsH6UqT6rxZyz/3zDrOgY+heRlVG
   dKBZWF2LSajuOdywvL0ZWJEPFYlYHqz+fgxH9k94DzhM+0lUCpRD99OuV
   biLpxbblehEDlFFTSsYN23DgBAsY3j2e2YPZ52ck8ydQWeJaquL41W6l5
   dgQ3DXWkE4yzw9ktrw4QIZoXIN8qKWbNL7zoyGUlC2He4LqtcKhR28ZOt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8956615"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="8956615"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:36:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="866222292"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="866222292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:36:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFDmw-00000006x2d-1Mv2;
	Mon, 18 Dec 2023 15:36:06 +0200
Date: Mon, 18 Dec 2023 15:36:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
Message-ID: <ZYBKxv_M23j0k_K-@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MfZm7TDHRRLrDmnyj3vmbscmpveR0fveYfsGz0SdaskKw@mail.gmail.com>
 <ZYBKn9UZIhY03DiV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYBKn9UZIhY03DiV@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 03:35:28PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 18, 2023 at 01:43:40PM +0100, Bartosz Golaszewski wrote:

...

> Thank you! I guess you forgot to add --sign-off to the `git merge ...`

Sorry, it's --signoff.

-- 
With Best Regards,
Andy Shevchenko



