Return-Path: <linux-kernel+bounces-148804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC48A87A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB57282ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9D146A6B;
	Wed, 17 Apr 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5wS2lLw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEC1422B9;
	Wed, 17 Apr 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367867; cv=none; b=FbyHXa6PhFH0WgixgbdSYw/67fjXaybuJLLo6+gi9oCxgckGS0N9lyBsTvgaOgQBwTl1Aq/5eCbd4TKcFPcpFf4Xa0PTb9x/th0kF5sWih01q3e1UiC+HGYtbWL9zY9zkIAmgXAdW9ddoMrZkWa72tf8rfztUYvQHv+v3QuDIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367867; c=relaxed/simple;
	bh=YsQ5IZ2W16YztF0/8x2HzACljlZJHuo/DFC48waRf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe9fEzQzGd//EwG7iZEB49sHxeERT6367+E1Skhe/W+BGMjHc/MZf90BkU8ZySR4VRr3AkfWm3bsKnJBkshCJQKm05IMPy7+WXr9uypXoQkdjOrzNsgjWshIjcvfHdzqTFMJ/GU14iIz5s2n0+21WUZlxmXyqDERHo+sxMRASIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5wS2lLw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713367866; x=1744903866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsQ5IZ2W16YztF0/8x2HzACljlZJHuo/DFC48waRf4E=;
  b=D5wS2lLwHjU9ddJQVVeDxMM90Ek8QpBs1cFGSwFnyV9jzFESOWok11pZ
   MDHLkgDn7PBChZBbwnTrULTUzsOpCzjx7SAhix208yzoUJDq71huKlEMH
   /nedIKRZekPkv9SGzPtt6+7fWBfBaRgenf2sSpIIYtQCyUcSDEypv5/EF
   MW0mTMPHk8hppLSCfaNFhP2DUQ8n3Kb0/sPcp3ter1AdYVugj+U5vcJPO
   Ksad1ayBWgQohc4Xpw8M+QVYoVH36oDaF2StF7yQuwV50JcxsLBHp41+Z
   4iOso9fUNSTlBoM0Yii8pcfxiBDKphbCnPK19W1hp/8/iDB4u/rk+PXCz
   g==;
X-CSE-ConnectionGUID: eBW8fFuVSEC4m9cv+8G4LA==
X-CSE-MsgGUID: PaDRVl2lQdefU8WAbr5nSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20291894"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20291894"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:31:05 -0700
X-CSE-ConnectionGUID: tp5cjKh/Sq2zUCozwLyAGA==
X-CSE-MsgGUID: NUzuJyeDSUCVp4ITbZqW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27091352"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:31:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rx7FU-000000005TK-0daw;
	Wed, 17 Apr 2024 18:31:00 +0300
Date: Wed, 17 Apr 2024 18:30:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
	xiexiuqi@huawei.com, linux-gpio@vger.kernel.org,
	weiyongjun1@huawei.com, dan.carpenter@linaro.org,
	liwei391@huawei.com
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <Zh_rM04PspfXxlv_@smile.fi.intel.com>
References: <20240415105328.3651441-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415105328.3651441-1-zengheng4@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 15, 2024 at 06:53:28PM +0800, Zeng Heng wrote:
> If we fail to allocate propname buffer, we need to drop the reference
> count we just took. Because the pinctrl_dt_free_maps() includes the
> droping operation, here we call it directly.

..

>  	for (state = 0; ; state++) {
>  		/* Retrieve the pinctrl-* property */
>  		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
> -		if (!propname)
> -			return -ENOMEM;
> +		if (!propname) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
>  		prop = of_find_property(np, propname, &size);
>  		kfree(propname);
>  		if (!prop) {
>  			if (state == 0) {
> -				of_node_put(np);
> -				return -ENODEV;
> +				ret = -ENODEV;
> +				goto err;

Has it been tested? How on earth is this a correct change?

We iterate over state numbers until we have properties available. This chunk is
_successful_ exit path, we may not free parsed maps! Am I wrong?

>  			}
>  			break;
>  		}

-- 
With Best Regards,
Andy Shevchenko



