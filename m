Return-Path: <linux-kernel+bounces-131105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FA898324
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595281F293E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D26CDD8;
	Thu,  4 Apr 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFC5w/yB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5A6BFCC;
	Thu,  4 Apr 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219294; cv=none; b=ej4IetPixpqCahJ1G4Aipl10izdGqmD13jVLZusRHpLHtEztJzoo33+05vNgMU7WUtfagwNVFhoxGIObwlmy+lh/rjcSXKKdicglrmkO8NupEWoQJ15Dm5FrNe32wSCGDsUWmXeQHBQIW4nCgLHZYhwHrDI0xbuTrHAZBZ0bDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219294; c=relaxed/simple;
	bh=sD6RtlBPbKLG4Miu1anUoY1sEP2SdHrFZXRUTVb7RsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFI6Q2Ym3cu4+v2LE+J7l2nMFKYQwIKo10XabAsPuaGWVpY/6hExHMQ+8L2xgm5c5yG7E0ojc6mbHX2laeCD9CosUElvWfhaKl4g+5A/wgUNacvg/ZjlNFSv7FHDaJOWDfW8Z8t6M4TOuqOvKrvgoUt71OxhzJfZ8g+BVX+ejzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFC5w/yB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712219288; x=1743755288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sD6RtlBPbKLG4Miu1anUoY1sEP2SdHrFZXRUTVb7RsY=;
  b=KFC5w/yB9beaiAz14ragxRK3Yiyg1MzrimPJlZy9SMg+XrsPTjJWumwu
   DcRm35M+bU5JmgzxrYvDthr4pi8w4ZeCDK4O6mhbzxMgfgvS2XBQAv0vB
   78wnhD3AVhOMnqM9K7CQ2ZIUS0KKKuMvtCNIbjm3YVQKb8Zsa2dvzb9Cq
   HrddVsEETQR9HBS15OM2gQhObVi4vHgLIxeW/Uq5GioKr4MY+dOh3C/Cx
   1qsU5sPmeBQqMG/CjGLx1aQQZ5jPdcTstz6FYi3JfBKF6q8KQQknktQFr
   i1GVfpk8hAlYMS31DE0Ggmr5th2sQFYeKnTvzpFvys12SA/zsw8fPfL1Z
   Q==;
X-CSE-ConnectionGUID: JGboZk4pQrOh/kYhq6zBsQ==
X-CSE-MsgGUID: Sp2eeWJ1SFmE5hBti0kcTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18841861"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18841861"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 01:28:07 -0700
X-CSE-ConnectionGUID: Nq0OVzEYQ8WHHHgWiZAkDg==
X-CSE-MsgGUID: d32LXMPVQ5KQKV+msMWlrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23397357"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.213.127])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 01:28:05 -0700
Message-ID: <ff94997b-e01d-44e5-881f-9ecdeed78bc5@intel.com>
Date: Thu, 4 Apr 2024 11:28:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop
 count to 128
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Drew Fustini <drew@pdp7.com>, Xi Ruoyao <xry111@xry111.site>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402093539.184287-1-bigunclemax@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240402093539.184287-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/04/24 12:35, Maksim Kiselev wrote:
> Fix SD card tuning error by increasing tuning loop count
> from 40(MAX_TUNING_LOOP) to 128.
> 
> For some reason the tuning algorithm requires to move through all the taps
> of delay line even if the THRESHOLD_MODE (bit 2 in AT_CTRL_R) is used
> instead of the LARGEST_WIN_MODE.
> 
> Tested-by: Drew Fustini <drew@pdp7.com>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Previous discussion was here:
> https://lore.kernel.org/lkml/CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com/
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8d6cfb648096..1001b6ea1a89 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
>  
>  	/* perform tuning */
>  	sdhci_start_tuning(host);
> +	host->tuning_loop_count = 128;
>  	host->tuning_err = __sdhci_execute_tuning(host, opcode);
>  	if (host->tuning_err) {
>  		/* disable auto-tuning upon tuning error */


