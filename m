Return-Path: <linux-kernel+bounces-129609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61E896D28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B3128F890
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B31411DA;
	Wed,  3 Apr 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAWv6Ycz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE52259C;
	Wed,  3 Apr 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141437; cv=none; b=UHupAO/49cSzjeK0slpNZMWcaYdfDqoFINmc8vd6O//Jeb1mScBq/EEPF+XPFIx+XSm+59O3Jex4pjwU5HPgJr3Y/10ZzDkenGmPOh2GR5uRUfOAsaoVEcC2unqVOsYycmUnugexOe+qV54CQ7L+3FU2aizT4jxA67zm6pv9v2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141437; c=relaxed/simple;
	bh=g6dc0Rf3RsM/c0X8Hx5ZYkJET+AMXU/vkjfKAnotBsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJIvcdtVNnYOJjTBxbLzYYneQuc8VU2WOZoDffaFIL6D0o60RfaJw84g2fRfLyKNzc8lzutKBpR41DVuxAAox7+cIEWIAfULpD2eY/RjBxh9LDpWQRRl7E+wX5BftZOtB4X52TeH7JTtLKfW2MxghfY94i6/XC7ZzuLdXtLqWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAWv6Ycz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141436; x=1743677436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6dc0Rf3RsM/c0X8Hx5ZYkJET+AMXU/vkjfKAnotBsk=;
  b=mAWv6Ycz24FosUWWWFq+dWloJUihC8YcGzG0NnAGsnSQrLvpXrYLzr5S
   mIIthywfeBz1BkaPi8AlbnbHyJWWm6gLbw9jk994ArYoST8NmgMSgsZy6
   6g2tn9KS3Ao0qPsTtjfqv200mYxcRXgYC0+F5RrkLYSw3jIt7RSVUsBqQ
   3vzAUHINwgtMkItCJKTFZXLj9KOpv65uFj6R5yqnMs99Pa667G4BbOAzM
   f0O7Zy3jcj1Ut+boXz+geRd8gRxh+lF6vIQtU+2M2T/g+yqgizMcG5ItO
   IqPcKIGgEFEiO7PBXfqW0oDj98UJQong/Oz4czbCJWK5/56bu4bjpcf/u
   w==;
X-CSE-ConnectionGUID: sXKTVtFFRli0ZWUP/X5fag==
X-CSE-MsgGUID: AMZK0LYpSBKSZ1vv8l6Xug==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7590424"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7590424"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915178807"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915178807"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:50:33 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rryCM-0000000162m-2SvB;
	Wed, 03 Apr 2024 13:50:30 +0300
Date: Wed, 3 Apr 2024 13:50:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 0/2] gpiolib: in-kernel documentation updates
Message-ID: <Zg00djT3MXSW9UUg@smile.fi.intel.com>
References: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 08:11:19PM +0200, Andy Shevchenko wrote:
> While looking for something I have noticed that in-kernel documentation
> for gpiolib implementation may be updated to reflect the current state
> of affairs. Hence these two patches.

Bart, do you have any comments here?

-- 
With Best Regards,
Andy Shevchenko



