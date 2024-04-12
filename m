Return-Path: <linux-kernel+bounces-142957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A108A3282
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B5D28694E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366391482FE;
	Fri, 12 Apr 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQTzucsK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393F5914E;
	Fri, 12 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935963; cv=none; b=VOS5mlO32hobdswFKlWcNIMOPtyJmq513/DAHCKiRW3kdUu7hXt2M8gTLBGjuTVDz3WM2WH4bMRUyJoEIvZUa6Ort1neO4UAwWrrXDfB9WSd0k0ghn7SO2hVNtJQQOJee/GfmMmPp7XaBucfIGdTrrfXwXl39nHs/KcxvGLnRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935963; c=relaxed/simple;
	bh=YcGVppXDTZpBYsq3LZQl0x3tHjY0EsDlBXQF4JKc2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuyLgd2RWS26quuH+GgWqzl7+s/kcJVY14K9zolc6r3i9aAFuwVPH5mYUS9zN8H/M72M4Z91Neyeug1XGD8mCRogCXECEDW2+oAH0C5oA1znuQ6n+D9MAhtzaMnZVMwYvzZm9lxtMUnomgSENBuw3hH8+0z3J5cQW5eMM3m8Slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQTzucsK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712935963; x=1744471963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YcGVppXDTZpBYsq3LZQl0x3tHjY0EsDlBXQF4JKc2kc=;
  b=RQTzucsKX3lYIBDM375wr2Up04GfAjKxuUExlcVegO/xo3viWpc+XmIG
   glqfjZu6vCVFYF+ijwFkbyldTdcrnYQ5D8X65Ue7CZAYX1wWCkeelER3c
   waiVYOJ1MTwRiW8xBwb6AmDgfqxIN95eSFnUF/D5Ckg+kDIQucI80m1PJ
   pG+h4rIP2Ls/kQ7AoUk6xPrDm5g3bygfJbGTx9w6bEbANDACtm00kuNZZ
   u7lxIl/Uc/oMlfUt8Gy6XA5sQQeFPee3C6iC1RYuKRF1XU3dpFqDzPj/x
   94a8oyL8W3j1ofHAaAnvXrajwJtPfSro8WIKc6UjtltkhwrzJAif9hJVs
   w==;
X-CSE-ConnectionGUID: FTjBeGz5QhWWrYm9wimVcg==
X-CSE-MsgGUID: czIS+8+qTlu2MzrZDz23/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="30875189"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="30875189"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:32:42 -0700
X-CSE-ConnectionGUID: 0zUC7aeoQt+hygbpFCOnvQ==
X-CSE-MsgGUID: akgacc3/RCez8p0U9pOJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21838477"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:32:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvItJ-00000003goC-3FW9;
	Fri, 12 Apr 2024 18:32:37 +0300
Date: Fri, 12 Apr 2024 18:32:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <ZhlUFZDTQum5-AIR@smile.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 01:12:48PM +0200, Uwe Kleine-König wrote:
> On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:

..

> > +struct dwc_pwm_drvdata {
> > +	const struct dwc_pwm_info *info;
> > +	void __iomem *io_base;
> 
> .io_base is only used during init time and so doesn't need to be tracked
> in driver data.

It's me who asked for this specific change and I think it's still beneficial
as it allows to simplify the code.

-- 
With Best Regards,
Andy Shevchenko



