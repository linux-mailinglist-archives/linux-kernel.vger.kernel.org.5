Return-Path: <linux-kernel+bounces-29478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C68830F11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA8A1F248E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583B286B2;
	Wed, 17 Jan 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tvwo6hTy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FD225A1;
	Wed, 17 Jan 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529176; cv=none; b=P7kzLr3afNdpMc2xFBPolEgQMXLGEKR6KFncTLgpCFKUh9+wQh4NHfl9d0IjpTODudR4dY8rw1wD5DNFsLsxIDRupWwydfCqEwHC6GaQzGmBKVjC0enUvxvQcKSYtjHLeZx7KjQSd6Fy5tGUR9r6A1NwwmmQAxW88MyT9U0b5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529176; c=relaxed/simple;
	bh=5REtFEFzeTkryYu5lbfVoHopMCN9cMkQmbOfiJWDWso=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=uPg72wF+G73yUOfIFfgA7wj/iCUkZgSvc29j4/ojEC4a6i2ep4xhNExSBF/BarDLFUJ8xUW8xbQ6QI5AZtJ3F0JPWNx7BxKG+Fthx3JFeE4MnJehMaHqoLz4gZj7jwtq+NffJFoi1IxM4GiUUpvaOSPq/nCHiWQ2UM8QYHAU+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tvwo6hTy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705529174; x=1737065174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5REtFEFzeTkryYu5lbfVoHopMCN9cMkQmbOfiJWDWso=;
  b=Tvwo6hTy5e72sKLmWAWCZv59VIxEN8zxutb4P0EZhHlIZOZbavdFTo58
   wuD2T2LvWIFIEsdl3sVy7PdCeTsR7aubc2h3pouacteiGS5x2tuJRKf/H
   Jma0GPhT6Blv5YpNPKVAwZgcoXeCbY2xveQTqm84f38yuoWMy02TUWDAu
   PB+S56JYBwlvJ7BYGWD8uw4gMQNzpW6pGbaO87fXkbvOY3mPh3pEbwyqY
   aZEe63TV+mULc9mbtU3XFAsFc+Fx7aDwF4hjvbA19vNFuq8P2DnATflKb
   8junSmjXKUi4/IJmq/QBH9ZV9qFoUUwCvlu9USUUnNoTxOTyICDmm0M3d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="13641586"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="13641586"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="903627804"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="903627804"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:06:12 -0800
Date: Wed, 17 Jan 2024 14:07:42 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, mcgrof@kernel.org, peterz@infradead.org,
	j.granados@samsung.com, viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, LindaChai@zhaoxin.com
Subject: Re: [PATCH 1/3] ACPI: CPPC: Add get the highest perf register value
 support
Message-ID: <20240117220742.GC13777@ranerica-svr.sc.intel.com>
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
 <20231228075705.26652-2-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228075705.26652-2-TonyWWang-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Dec 28, 2023 at 03:57:03PM +0800, Tony W Wang-oc wrote:
> Add function cppc_get_highest_perf in generic CPPC driver to get the
> highest perf register value for specified core.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  drivers/acpi/cppc_acpi.c | 13 +++++++++++++
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..1a77c514d007 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>  
> +/**
> + * cppc_get_highest_perf - Get the highest performance register value.
> + * @cpunum: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_highest_perf);

The Intel P-State driver uses cppc_get_perf_caps(). You would not need to
export this function.

Having said that, the Intel P-State driver could also use this new
function, IMO. AFAICS, it does not *have* to use cppc_get_perf_caps().

