Return-Path: <linux-kernel+bounces-148978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F338A8A04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3697284B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307517166F;
	Wed, 17 Apr 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlaO4mSr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57145171099;
	Wed, 17 Apr 2024 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373952; cv=none; b=JHI9W5ufy2Zx/2aQiszDzub4JSV84tJO3eKVab63CZvl+7quvMqD7rMocsbucUhlTVNYlOGHh6TKeHjiBN4j/8fyT8O3pVExZzgQw6E9TJnw+eEcJLriYzHvIs/HhMsSwF1i3wuHBBxYJtVIxgLSWDZKpF2wQHZiuBRdNnnoGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373952; c=relaxed/simple;
	bh=6Rgdty3l2h9c4NV+OETwu3ybe5GZRw0d788qons41U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL9BXHyez0Zmi6Bo0B6G2LgA0ULk3AtRDofWinowd0CUcJ2YaayZLaD4kqLmZnfOWQBd71Lg5ywt+tCZR2teKOqv34j0gx/EOAmXTHmaOPWpXaz6AWgVbPMSNHu39YNJYLZNQRZmPvhSUSSqVrXEY6T3nn150mjW6VOkXkEANiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlaO4mSr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373951; x=1744909951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Rgdty3l2h9c4NV+OETwu3ybe5GZRw0d788qons41U0=;
  b=TlaO4mSrMsSpqx2LSfchIgCNY87rKkOrdzOqh0dEHRNWXxAVyfq3C0v7
   UuLCu2UvCl/Ahc6fH/Jq3E+pIitEMd4mqSZc6FqvDxkxFZ1Hx4vbC5eUQ
   5bmELjti78TjCi2xm+8USGJg19nC5X6igZ7QxwOCRzA8qsaZJhlzz59K4
   4/qB+tjAYyjqpTiSUnmngz7ojehw03KPjrWf8PsiwKBDPDXRzJle0mh8U
   lot4kmP+KEyLiLRRewe9ZqWmxRr3IefftwG2B0rOLGgNcSlh/EelfuTO5
   scXO4UH3P+AdA9zm8RLuUUVw/S+Jei2hYpJterl+hR7PED7vjVwsVvn5w
   Q==;
X-CSE-ConnectionGUID: jEVoOGWxRbmJGQHdYPmN7A==
X-CSE-MsgGUID: Fzfy4OuPQPu1tw847rQQKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20305107"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20305107"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:12:29 -0700
X-CSE-ConnectionGUID: gfIcyiGjRz+xk6kJyUi7fA==
X-CSE-MsgGUID: ZmKqP9Z4QTSfSz59x3IAHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27481311"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:12:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rx8pb-000000006lA-43Kd;
	Wed, 17 Apr 2024 20:12:23 +0300
Date: Wed, 17 Apr 2024 20:12:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zeng Heng <zengheng4@huawei.com>, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
	linux-gpio@vger.kernel.org, weiyongjun1@huawei.com,
	liwei391@huawei.com
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Message-ID: <ZiAC9zzSWume8063@smile.fi.intel.com>
References: <20240415105328.3651441-1-zengheng4@huawei.com>
 <Zh_rM04PspfXxlv_@smile.fi.intel.com>
 <d80e09d8-5f35-4865-9fe8-195b86527972@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80e09d8-5f35-4865-9fe8-195b86527972@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 06:38:46PM +0300, Dan Carpenter wrote:
> On Wed, Apr 17, 2024 at 06:30:59PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 15, 2024 at 06:53:28PM +0800, Zeng Heng wrote:

..

> > >  	for (state = 0; ; state++) {
> > >  		/* Retrieve the pinctrl-* property */
> > >  		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
> > > -		if (!propname)
> > > -			return -ENOMEM;
> > > +		if (!propname) {
> > > +			ret = -ENOMEM;
> > > +			goto err;
> > > +		}
> > >  		prop = of_find_property(np, propname, &size);
> > >  		kfree(propname);
> > >  		if (!prop) {
> > >  			if (state == 0) {
> > > -				of_node_put(np);
> > > -				return -ENODEV;
> > > +				ret = -ENODEV;
> > > +				goto err;
> > 
> > Has it been tested? How on earth is this a correct change?
> > 
> > We iterate over state numbers until we have properties available. This chunk is
> > _successful_ exit path, we may not free parsed maps! Am I wrong?
> 
> In this path state == 0 so we haven't had a successful iteration yet.

Ah, indeed, this is not a status. Okay, makes sense, but calling that free
function for the purpose of the putting of_node seems an overkill...

-- 
With Best Regards,
Andy Shevchenko



