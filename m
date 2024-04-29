Return-Path: <linux-kernel+bounces-161696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF58B4FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C2B1F21A40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870E8F6A;
	Mon, 29 Apr 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJCp7i9P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB28BEC;
	Mon, 29 Apr 2024 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714360783; cv=none; b=duaffHrnK91GmNBMb4Jh5/382YGnKCbZd+ltdMzVEXONFnGcLtEI0dJb7nqFzpZ8/6CmYMm3uo7Zw+k6TSmRmEblVc+6nm0K4cXLKNWd1AtuUPlP30VyVlKdvOZererof0vri7xbg4pGFvR26u40ubPDUNqcOBhxktnm12r8rNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714360783; c=relaxed/simple;
	bh=hcBy8KBLGpmqDcJu/8Kra/+TTVV/W23KaHdONXzXp3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfk4DOz5voJ0tMNHPtB8VmGk6sZaR8NAivNhQdxroHtwL8Tdeg41BKeVSeBNzK6RpwtFBuIxHg654GCVQVFX8lmGPxY3HZwtS/kDlDmrLjoSO/oT4aqv7vaJNU/tij+NRTNvMlX2sOaM9OKH/kPQCuBKwhMooOOjy4WNO69qXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJCp7i9P; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714360782; x=1745896782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hcBy8KBLGpmqDcJu/8Kra/+TTVV/W23KaHdONXzXp3s=;
  b=FJCp7i9PC+r6hfiHHVw9BmX3vV0Bbu4rpo7gp3MXEVq7dBCcfggJspfb
   DXc/gxuLEODwE5zF1kGqc2tSr04J8H0AvIslc1BWNSXsHW1dX+5Et+yj7
   RCAuKmFu24e7Z8a/DS8D+sfPcYLx0qjN8yMYjr7C+0UP7QJzlNPdbQQHw
   5rjoJBRP0bfXB0FcXG4JWgbynDXvU3kG1qTsBcyC/ZHDnuQUa+ovIAx2T
   yaDQgnaQjZr3mcmih0sQLqf1uGTHkazT1d20JMj734/U8EV3XTy/8ImVI
   1yum/RyzIOruaciHp7obXk4CTeqBzuKPDgAgWS0ruvTIZZki/fWoETLIh
   w==;
X-CSE-ConnectionGUID: blUjCAS+T0KIv8fLtTKj7w==
X-CSE-MsgGUID: rnjdqlyiS8KFXG0WXn8nQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10547580"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="10547580"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 20:19:41 -0700
X-CSE-ConnectionGUID: Lye3sIonSZmI12SduFNr4Q==
X-CSE-MsgGUID: zSPNO42wT/qM4Mt935SwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="49201472"
Received: from kscheema-mobl.amr.corp.intel.com (HELO [10.251.17.13]) ([10.251.17.13])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 20:19:40 -0700
Message-ID: <88428faf-edae-4c43-96b3-a6d6bf7e3c83@linux.intel.com>
Date: Sun, 28 Apr 2024 20:19:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 59/71] platform/x86: intel_scu_wdt: Switch to new Intel
 CPU model defines
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181538.42292-1-tony.luck@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240424181538.42292-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/24/24 11:15 AM, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/intel_scu_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
> index a5031a25632e..d0b6637861d3 100644
> --- a/drivers/platform/x86/intel_scu_wdt.c
> +++ b/drivers/platform/x86/intel_scu_wdt.c
> @@ -50,7 +50,7 @@ static struct intel_mid_wdt_pdata tangier_pdata = {
>  };
>  
>  static const struct x86_cpu_id intel_mid_cpu_ids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &tangier_pdata),
> +	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &tangier_pdata),
>  	{}
>  };
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


