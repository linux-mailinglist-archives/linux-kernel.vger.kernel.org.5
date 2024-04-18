Return-Path: <linux-kernel+bounces-149990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0018A98D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D19A1F23066
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134C15E803;
	Thu, 18 Apr 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQf7Pv7c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4356464;
	Thu, 18 Apr 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440471; cv=none; b=JK2xxejNhPj6y1IvJ1pSdZHHHyjP3c+HSAOLP8HD8OTkAt9PVzSot1WEWD7YTJsacMYnDcXSjrqU9iQYleO5sermqztER12aFU3z0q/2CPm5Y5JpmhIhpuNKgvoGzXkYIbwNinfojQTqRrruqv7jbMkGEJRuuNMm0G0dClVFSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440471; c=relaxed/simple;
	bh=29rZzXIWIenydqbQ7JXySEbe+bvaUMgnfeczXYGzGKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV/e/+ESm2pxpvVZdmtSpifUAW/CipVgEA9ASiGEDhSboYfehnb7RiVxT+VWhdwslO1Pse9bILLpffEDWdVj15/uBLmc27uDtChAv5ViBLZquAa+XH0hd0YHjw2A5VK15WQK8HduyRsxsgSOYZCC3zcAn/SLPDReqSU8T2v6PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQf7Pv7c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440470; x=1744976470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=29rZzXIWIenydqbQ7JXySEbe+bvaUMgnfeczXYGzGKw=;
  b=PQf7Pv7cRxIQLXhqmuCYzrrjD06iYHb9aVrajHey3qFAPsabWgYmvEmQ
   lGMZ2OMRebCQa7NZ50RIbQdpdPAnzeqegRGKjq+VRcHmushu221LGBdUw
   X8ED8sAMmnojI9pCIi2JMrIKHL+02nE1TtwGq/WnjijuiyBbt7WMSP2Sb
   rDZ8iONxq1FeocI5eW7H1bG/tZzgpCISqcEG8IMsbvW5Mo9VFHhxkGxLl
   N1aLkd7nWemdoar64VjsNzfS/PgEM/hMzLFNkK5QcuEiL5/HAANXI40Zd
   nly0zd3qYkHi5XWJfIxnye2UoYlDD9oyG9e2qRriuiGM6riNs9WrZ7C0M
   w==;
X-CSE-ConnectionGUID: hKwyDmSYQ2CluxN9qV36Xg==
X-CSE-MsgGUID: h5LJS9wwQtuXtvfDBVo2EQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8817178"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8817178"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:41:07 -0700
X-CSE-ConnectionGUID: CF7Wzp+YQN6vn4RSDXu8UQ==
X-CSE-MsgGUID: UJBlmCWVRjCuBNo1ZkNy4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="22823073"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:41:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rxQ8U-00000000JQI-22np;
	Thu, 18 Apr 2024 14:41:02 +0300
Date: Thu, 18 Apr 2024 14:41:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: linus.walleij@linaro.org, dan.carpenter@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com
Subject: Re: [PATCH v2] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <ZiEGzuVzV_fV52DR@smile.fi.intel.com>
References: <20240418113459.4182749-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418113459.4182749-1-zengheng4@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 07:34:59PM +0800, Zeng Heng wrote:
> If we fail to allocate propname buffer, we need to drop the reference
> count we just took, otherwise it will lead reference leak. Here the
> error exit path is modified to jump to the err label and call
> pinctrl_dt_free_maps() which would drop the counter.
> 
> In the meantime, if it is found that the property 'pinctrl-0' is not
> present, ENODEV is returned and also jump to the err label and call the
> free function, in case the Smatch tool complains.

> ---

You forgot a changelog, but I think this needs to be a followup.

-- 
With Best Regards,
Andy Shevchenko



