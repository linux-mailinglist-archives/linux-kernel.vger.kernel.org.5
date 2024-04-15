Return-Path: <linux-kernel+bounces-144574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C528A47E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D00283B95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D6F9F0;
	Mon, 15 Apr 2024 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPWiVVor"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA83101F2;
	Mon, 15 Apr 2024 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161688; cv=none; b=VxEtPYFjlE2YYKm2KZQWwItIPAYVxNvpO9rCSjZOB3f2tIEmpEySL1JB3Zzup2bPN/miigMZ/8j5s31q8TpE+CiQVTMtfas+vhxbzITqD5bdgjwdOwDWTxSjQIQiQtKD6KoPf582MLDJSKzb5c14CW9wWtwRRFIKa17LWmmxOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161688; c=relaxed/simple;
	bh=GFa0lGEpYNo+aijXf2Yf6B8UN2SloT78dIDOCwLdz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o45HtPH3ED3JdSOkKKmoEnOs/yy4E0tzI11QLqykq208NFOdpGsdGhf2uA4Ym8V5npP5/aYWT9bS3O5G8o5CGCVvQ//uZZt1ZRKJFvBayUJaw0QViM+/Vt7azxlsAoRABKJY7CAhCEXj1E78Sr73AnLQOSKPWvMFfEzmoIQQWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPWiVVor; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713161687; x=1744697687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GFa0lGEpYNo+aijXf2Yf6B8UN2SloT78dIDOCwLdz/4=;
  b=DPWiVVorgb2BIHOdV6NZvhfHXRKoUPKTDG8oHUrW/SsQehkLkrREvLgo
   L7mEwUk+kwKglZYlBiajPxzBl75IoQ2IcMlKJ15qrImocBZG/Z81+MSsy
   WhQ1L/7ulAqbxc9SwggNGr5A9JYLCLaN+6fdubhCMA8p5FaSIJpFRTJSO
   wvJ2wSTd1wBbaZwWVFFVMtVrSeDy9BMG4hdlp5vn8CiL4lQGQbpi0OOMb
   SMLMpf8orQg9AZ8KFmjn1FEFM0rwmDct1lb063vCP8Q9B7nmcAZvhhrez
   16n0J3lpxwtopaIwmntlMJxQ1X170pXJpjZern2AjhB3cXtLOXXnmq+kS
   w==;
X-CSE-ConnectionGUID: sFQzhL6wR5uv+xG7QeZcKQ==
X-CSE-MsgGUID: DPLptfLiTZC9QCPtAEpA0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8391032"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8391032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:14:46 -0700
X-CSE-ConnectionGUID: 2r7GoXcEQ3msVx1eloCMgQ==
X-CSE-MsgGUID: 89rSIiyaRvGPiJpe3jRosA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52751817"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.19])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:14:44 -0700
Message-ID: <fda632a1-e0b1-4b88-82a6-03f476c73ac9@intel.com>
Date: Mon, 15 Apr 2024 09:14:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Remove useless "&" of
 th1520_execute_tuning
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240414164357.2841-1-jszhang@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240414164357.2841-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/24 19:43, Jisheng Zhang wrote:
> The preceding "&" before th1520_execute_tuning is useless, remove it.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 7b55acd9830c..6206ff7615e8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -822,7 +822,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>  	.reset			= th1520_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  	.voltage_switch		= dwcmshc_phy_1_8v_init,
> -	.platform_execute_tuning = &th1520_execute_tuning,
> +	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  
>  static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {


