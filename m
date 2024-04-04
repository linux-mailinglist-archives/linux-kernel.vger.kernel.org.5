Return-Path: <linux-kernel+bounces-132046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B4898F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318701C21C95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F013441C;
	Thu,  4 Apr 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9jmwMG3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF11311A3;
	Thu,  4 Apr 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259382; cv=none; b=gXKeYK/kf2e1gKB/dga+5uqw8xFMLjZBSgjCBIq0NqJFi7k3xVdVt4RJcwPwSMGncBSLowhCnpxtiHxHAhy62P/3i9a7NsNbeaNttNgIwC46PybCJ0bfoWxXszBZHD0DGarAZDNYMmpSeQtR9fdTa00JXhl8nJOhOuQNUsiXODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259382; c=relaxed/simple;
	bh=MstYzcyGUXpMjvIesH3P0JOixnzqDZN4TkdenMuVwr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npfMc4yNcIEVHgGLBfErX7zFW/9F/mti0faT0uEMsXh67x6CNZWllfauM8QjTCTIbko5jfwqgrTxv1ECsU5nQenlvtBFav208ZmDePnZ2c3ADZvgEbe4xGog+SW5XQux2RtYYLHVrVSPs2BVHKeDfFnxLQHACxmx4mH9zSmHoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9jmwMG3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712259381; x=1743795381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MstYzcyGUXpMjvIesH3P0JOixnzqDZN4TkdenMuVwr8=;
  b=O9jmwMG3x3wvR9/19nT7WDnCBNxsjDkl9B3/v7iMwuotxIR1JYHCjJF7
   4Ra5L23/2BWGjysWr3oM26dxsLCJu34Jj7JifhK5sHUbX2sVvvQ+GLrwB
   jxR4ERUl4059ukfBEzddifnbJCnyG6xTpxnEMNqFRpl/bTak0NqBZYj3I
   SpNuwes42w03DxJV6mVdm7n7kh/LQrG32bg2dXfpBxZbsTgnsFlGNTzUh
   WkXn7gCKhx+sp1NQdKdSu6xH+n5fCBczhZYgDZkn5wCdxIMCciZedgPnm
   1I3WIkt+wzGpuRWdFCexwAcvYxIMqZAAEcdsIYYJoYOcvJlT9qrfddhBh
   w==;
X-CSE-ConnectionGUID: ZSZQZbwXT1qxi8d5I0z0vA==
X-CSE-MsgGUID: SNUBVUB8R2quZIqFbeTZBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7698469"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7698469"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:36:21 -0700
X-CSE-ConnectionGUID: URAVo7AtRwKr1WSsfNnZ6w==
X-CSE-MsgGUID: TaCQw88bQd+WcjBkxXteMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18916555"
Received: from ypottimu-mobl.amr.corp.intel.com (HELO [10.209.51.123]) ([10.209.51.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:36:20 -0700
Message-ID: <5f040ba2-627b-4b5d-959a-59f97b6ad0af@linux.intel.com>
Date: Thu, 4 Apr 2024 12:36:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: lg-laptop: fix %s null argument warning
To: Gergo Koteles <soyer@irl.hu>, Matan Ziv-Av <matan@svgalib.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <33d40e976f08f82b9227d0ecae38c787fcc0c0b2.1712154684.git.soyer@irl.hu>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <33d40e976f08f82b9227d0ecae38c787fcc0c0b2.1712154684.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/3/24 7:34 AM, Gergo Koteles wrote:
> W=1 warns about null argument to kprintf:
> warning: ‘%s’ directive argument is null [-Wformat-overflow=]
> pr_info("product: %s  year: %d\n", product, year);
>
> Use "unknown" instead of NULL.
>
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/lg-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index ad3c39e9e9f5..e714ee6298dd 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -736,7 +736,7 @@ static int acpi_add(struct acpi_device *device)
>  		default:
>  			year = 2019;
>  		}
> -	pr_info("product: %s  year: %d\n", product, year);
> +	pr_info("product: %s  year: %d\n", product ?: "unknown", year);
>  
>  	if (year >= 2019)
>  		battery_limit_use_wmbb = 1;
>
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


