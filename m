Return-Path: <linux-kernel+bounces-127342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE2894A04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2461C2318F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719F168B9;
	Tue,  2 Apr 2024 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJYsoJ+V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C614286;
	Tue,  2 Apr 2024 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028836; cv=none; b=hkXcCpXk199KxtRCRGKUBt8rdT7T3q5IP2GWmJOTr/kEryOoIb9Zy/dxNRPq0tNxF2fpeDchq5WzkCVuB+RIjIXdQ1dONr3T9gvR3dpAZV+qpRyB/QsDic8EQ/Ug0KiFMlsZvFSFKeoysP8+PM33sBGaThw8Ufpjdihjux2Lw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028836; c=relaxed/simple;
	bh=nm+nAlqpw3ca2xRqXTLmgegLhY4MxsydF/vxsaUw2M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAU++oRdk8LUPi5Gpsc8DlvZKzHXDhjCYx0lhhgMBRWNuHk2AoDs1YfQ81DMBRJ9iXzKC+5IhpqcX8nwZekLQkwdt8eI/vB6H8NQhyhSW6b1anGFNnxlqZGGKjL61xxTpdp7xwSrSnksCXmy0WRKj+HYGa4z0K+HRbS/1rAnhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJYsoJ+V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712028835; x=1743564835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nm+nAlqpw3ca2xRqXTLmgegLhY4MxsydF/vxsaUw2M0=;
  b=VJYsoJ+VfIuaCv5r9auzCwKTzQOA8AxZZiy2DOP6dibSnqjl94erSl/u
   5KJn9USDVJ7CQaXCWqqBnsEEgkdzj8j1q3YXnfV46w6/JlWAGbBHXRQrD
   6hjTYQCuTCkL21FX5DkLAoEaG38v25e9SeRZ+zvUVFh6qf11IHU20xd0K
   uWt6ZQ18/CQC4o9TiV/LCpnZGkLz1yPUmeML34xr6a9we3IQ4xohw59g0
   UX/D+MTqtKueAg+PyjFlUDyXaZENF4DZiM77vPNtrEq2Oy/XPGldoMoNt
   VqNdO7I1mPhL3Q/5qt3od+hZlgV6IXs+tgC77wQOEBjyIaKjTPojIrwK5
   Q==;
X-CSE-ConnectionGUID: cOJwGq+CSjW5IU63M5OqUQ==
X-CSE-MsgGUID: 1UUT7MF/QJS/IqMqBbUcvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10997135"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="10997135"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 20:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22587250"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 01 Apr 2024 20:33:51 -0700
Date: Tue, 2 Apr 2024 11:29:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Message-ID: <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
References: <20240329000429.7493-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329000429.7493-1-peter.colberg@intel.com>

On Thu, Mar 28, 2024 at 08:04:29PM -0400, Peter Colberg wrote:
> Omit unneeded casts of u64 values to unsigned long long for use with
> printk() format specifier %llx. Unlike user space, the kernel defines
> u64 as unsigned long long for all architectures; see commit 2a7930bd77fe
> ("Documentation/printk-formats.txt: No casts needed for u64/s64").

The change is OK. But I suggest just delete the unnecessary dev_dbg()
since now people normally don't want these "Hello, I'm here!" info.

> 
> These changes are cosmetic only; no functional changes.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> This is an unmodified resend of the second patch only from the series
> "fpga: dfl: clean up string formatting for sysfs_emit() and dev_dbg()".

Why only pick this patch out of the series?

[...]

> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index ab228d8837a0..da3cb9c35de5 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -150,7 +150,7 @@ static int fme_mgr_write_init(struct fpga_manager *mgr,
>  	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
>  	if (priv->pr_error)
>  		dev_dbg(dev, "previous PR error detected %llx\n",
> -			(unsigned long long)priv->pr_error);
> +			priv->pr_error);

I'm not sure if this is an real problem. Maybe we could keep it.

>  
>  	dev_dbg(dev, "set PR port ID\n");
>  
> @@ -242,8 +242,7 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
>  	dev_dbg(dev, "PR operation complete, checking status\n");
>  	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
>  	if (priv->pr_error) {
> -		dev_dbg(dev, "PR error detected %llx\n",
> -			(unsigned long long)priv->pr_error);
> +		dev_dbg(dev, "PR error detected %llx\n", priv->pr_error);

This is a real problem, is it? Change to dev_err()?

Thanks,
Yilun

>  		return -EIO;
>  	}
>  
> -- 
> 2.44.0
> 
> 

