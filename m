Return-Path: <linux-kernel+bounces-150243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BAD8A9C33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90479B20A22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A997165FB5;
	Thu, 18 Apr 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLT/7kK6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE91649CC;
	Thu, 18 Apr 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449106; cv=none; b=phoN6zvWbA2T/FUaXy5SLqGme4m+4zKRGC8OKYbWD6gz73IiW8nh71156yvP2ZQpu+k1FWlTsntOV/lX1VIXSnx1+ubY0uM7Y9RjDxGiyKNJHpMPI5ccKJ+QzAgMJp1cdl7ZNgkW226mEGM37mfiGJAqYk+U2zH8IRIQnKmZl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449106; c=relaxed/simple;
	bh=ffm9wt7h18bF8l/+SJ6vz1syVkmFX+Rsu+y3Rz24JkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1NXmpHqNGaDoJpCoO5mPkPCqwwAoop11g6oGyfAKiSs8BDQqazkw0MYfztxA3iy8jxJXgIlXwmu6aI8XV6lZbceDwVU/4YnY5WT/ixer7FnkDf4K1z6ISl3U4Fhu0PQ7GRFsJus72LZH8CTq0TVLALPYf9AlRdYwi5w39VRlGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLT/7kK6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449104; x=1744985104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ffm9wt7h18bF8l/+SJ6vz1syVkmFX+Rsu+y3Rz24JkA=;
  b=NLT/7kK6b6aPLGzo/JBOXhvXhp++ms7F4AjGj1H7begXvarAep1wb9HB
   i7p5SHMUGlULjM1xWnryvOozmmuQF/VibGebjesJREs84JgynEepe3Jcp
   W1jJksyqpNc+/FH43KYsKxdmeDxxoOSU4wf8BX4LMY5p3y1RUyXMlWEHR
   hmsifU766cezUACtQPK0IViHub5Ae9YGIOsnUmK6mRXtwBMYom2XQEFjy
   faDHGWkafOsSOBfa4eL4kMasadTrOtPF1iXg3bQielYxCjB1V9b8xnszd
   n1SFWXJ8yTVykj9Vydqe8ypYbd34qZYQH57GaRMibhsEAMLo+mZFUuB/6
   g==;
X-CSE-ConnectionGUID: fMTHk3asQhi8PLZUmcnvWQ==
X-CSE-MsgGUID: JiYMg8gRTIyAjjulDIHvAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="11939349"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="11939349"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:05:03 -0700
X-CSE-ConnectionGUID: QBTJWpBFTU2swZqG5+yixA==
X-CSE-MsgGUID: 3bqEiufyTRCSE/aXWa8VNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23076175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:05:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rxSNn-00000000LVr-1Jxr;
	Thu, 18 Apr 2024 17:04:59 +0300
Date: Thu, 18 Apr 2024 17:04:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: linus.walleij@linaro.org, dan.carpenter@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com
Subject: Re: [PATCH v2 resend] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <ZiEoiuHbIyyWs5hE@smile.fi.intel.com>
References: <20240418115813.93241-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418115813.93241-1-zengheng4@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 07:58:13PM +0800, Zeng Heng wrote:
> If we fail to allocate propname buffer, we need to drop the reference
> count we just took, otherwise it will lead reference leak. Here the
> error exit path is modified to jump to the err label and call
> pinctrl_dt_free_maps() which would drop the counter.
> 
> In the meantime, if it is found that the property 'pinctrl-0' is not
> present, ENODEV is returned and also jump to the err label and call the
> free function, in case the Smatch tool complains.

..

> ---
> v2: add a comment and modify the commit message, without any logical
>     changes.

You probably didn't get what I was saying...
Linus already applied your version, what is missing is the comment.
This should be done as a followup patch.

-- 
With Best Regards,
Andy Shevchenko



