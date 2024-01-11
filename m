Return-Path: <linux-kernel+bounces-23525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102382AE00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB03AB21F65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10F156CE;
	Thu, 11 Jan 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUFkSZhz"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648B14F88;
	Thu, 11 Jan 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704974196; x=1736510196;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rxfB6CJ33YC73UGGmfDn7hZc0Y7X2EI0dmmGO62rrxA=;
  b=bUFkSZhz7q/+UU1fw7vtB9c5sVycqecMoBuDw8qhVn6w1c4fl3dRIQPO
   ccFkz29+qM4VlAl0Vh4ZK7l8h/eTMeQdIBbWgJhLF9+5Nt7Qv4ub1XsC1
   jkSJC4vxIbfiE1WwkZLaRMO/49+NyOPpBGSUzgSli8a29vQvH3qLnAVza
   OUrmv97CSFGrQcPtnDHnpI1gGMhD2kBRbgV2APqp1rfaMV/3eauP07evC
   cNuWvjAUlmCm+vLDkPc/FsH/Kam5i0m5wCZLh5xggkPtrIDSKtU7VDaPT
   a76gW4t7XJA20VRlOlp+XQ70lHpM/WI53V8jU454LWAK4BYkMIm7hhhzU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389261859"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="389261859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="758734850"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="758734850"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.201])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:56:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jan 2024 13:56:28 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Hans de Goede <hdegoede@redhat.com>, Henry Shi <henryshi2018@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86: silicom-platform: clean up a check
In-Reply-To: <0402e613-446a-40d1-b676-0422f6223aa8@moroto.mountain>
Message-ID: <90c2576b-006d-36eb-1fac-c4c4a6eccb4a@linux.intel.com>
References: <0402e613-446a-40d1-b676-0422f6223aa8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jan 2024, Dan Carpenter wrote:

> "value" is either non-zero, or zero.  There isn't a third option.
> Delete the unnecessary code.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/platform/x86/silicom-platform.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
> index 6ce43ccb3112..5cac698bf98d 100644
> --- a/drivers/platform/x86/silicom-platform.c
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -258,10 +258,8 @@ static void silicom_gpio_set(struct gpio_chip *gc,
>  
>  	if (value)
>  		silicom_mec_port_set(channel, 0);
> -	else if (value == 0)
> -		silicom_mec_port_set(channel, 1);
>  	else
> -		pr_err("Wrong argument value: %d\n", value);
> +		silicom_mec_port_set(channel, 1);

This covers both cases without if:

	silicom_mec_port_set(channel, !value);


-- 
 i.


