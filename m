Return-Path: <linux-kernel+bounces-126528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4C89391F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B35F1F218BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B6DDA2;
	Mon,  1 Apr 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdPisCMo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25985B671;
	Mon,  1 Apr 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960972; cv=none; b=G/NIztz07wrnFKT8sqzI6w6lo5F6/MoTM7YVWdwzgj3IOh4ik6MbP2vn986uGZJ+XrbKvsGm5PhGzETpPsHfhGXRfQ1x6Q+w6t1PX+FG00bf+UuCUt3Wdz0xv+ZRsLRvd2ysTit6WOQF7YwYOUw5Ew2K06dwTcVcyhwHO/IGesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960972; c=relaxed/simple;
	bh=AI1XIUyqxzRSpghCdKpQAxauNOiZcpgN+8YqxMVM5Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRlMqcgXxdqPElDEuABaCUGhIUeXbhrEpvPr3mEbl6Fb9DDT5UiRHLmXtncarj7rFyr3Hvw6EBkmg0U+8xkUpbEjMpvPPwBeO1tSqjtmnBAK7dqJrhwKDp+70IE3U7+nHlGH29Bx95poIUuVkNdeI0I8EVXQyl9fMATJasDkwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdPisCMo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711960970; x=1743496970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AI1XIUyqxzRSpghCdKpQAxauNOiZcpgN+8YqxMVM5Ks=;
  b=LdPisCMovB+VN3g5BPPCthObRlU48PO5DqznrqkZmW+UG0mT5gL4xY6T
   e6heQGxJjQddNGMN8eAC+s44zpjcBpJ0hiSL3o0wlb0BFNNA+QNpu0WfP
   UCWwpwuJG867EAeoOxUDH8GRi0HQEMftblR5X2WwHAALxrO89vNJjuzIO
   uPWlUkJZIRYoP6Jv+h3LU2Y6fEvaKvL5to/BzU2TkpDTjLHS6Yx7sLiev
   prB+8U36EiBbTeSYsFF9JWhSwj/yNSIS3TdR8G9JTHHerGf1lyeWqZLh8
   O4c482G/ePAkkT8i0RBE1kuyRq501w+FM7u5FVFPxtkyT4JJWRYAPmkSt
   w==;
X-CSE-ConnectionGUID: yM/V7+wVQ1qp3a0WFWa1UQ==
X-CSE-MsgGUID: cxck2C41SaOMGPyXavtX3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7227301"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="7227301"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 01:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="18286664"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 01 Apr 2024 01:42:48 -0700
Date: Mon, 1 Apr 2024 16:37:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera: drop driver owner assignment
Message-ID: <ZgpyZldW+TTCbCcH@yilunxu-OptiPlex-7050>
References: <20240327174909.519796-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174909.519796-1-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 06:49:09PM +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> ---
>  drivers/fpga/altera-ps-spi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 740980e7cef8..d0ec3539b31f 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -284,7 +284,6 @@ MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
>  static struct spi_driver altera_ps_driver = {
>  	.driver = {
>  		.name = "altera-ps-spi",
> -		.owner = THIS_MODULE,
>  		.of_match_table = of_ef_match,
>  	},
>  	.id_table = altera_ps_spi_ids,
> -- 
> 2.34.1
> 
> 

