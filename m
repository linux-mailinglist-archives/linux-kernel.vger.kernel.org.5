Return-Path: <linux-kernel+bounces-151510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551F8AAFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407922814F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEE12D1F9;
	Fri, 19 Apr 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vjrn+cMf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BCC1272DC;
	Fri, 19 Apr 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535085; cv=none; b=e79OuCYY2C4GzbE4N62oSFE7XlsTxz0d6/fKcBB9gwAd7CCJ+DoT1k5NUG52gjriEzRWmjY4eHfTvjITgkKUQg7IcWK5cCOyQmj+GXqloIekziW0VSneqGUX3yCQ0Vhb443+sobBLvMrahiTnsjj00JuoBdkc1E4GGFt2iP0pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535085; c=relaxed/simple;
	bh=JHxWds19aqDFUjVMMoCNRaeZ7ws21oxZ8puyfhKRBFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHjaD1BT31ANafYxHbKIElTUD75+GB7CXoZN6G/ZoF1C9P6ZYL5K/+E4R/HdCBz7NET31IgDi5AYqdMtgUB7YYc6/o767DGbM9IYYMzS05HVSfdoeOthyayhA4uiZnKFLLhrosdHJLRvvX0oVPhqvLreZZ8ipmwqr1O1WvnIWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vjrn+cMf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713535084; x=1745071084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JHxWds19aqDFUjVMMoCNRaeZ7ws21oxZ8puyfhKRBFo=;
  b=Vjrn+cMf5QHbDqGPBtUEmCahwsvinrNMdzJUUAkiCB6M2BBy9RaYdlz/
   HPOPGKcye32MYGEz/DzhKWRV3zDGlfRm3kRZKKl7A8nvFxB87zV7BM+Wy
   TKwWhHOBCzw2NOR+4MI93z2YCAWFn+oMKwq4LXUyRI/3xTSjYzUvLta/F
   HKUsKvPywd84fB/FNn4v6DtfXniJCz773jJCpalTqIS/8pRit1PHFB0+o
   /jcqoGwgV8NCTAEdeE63yE1Lo82EZXjFOAROZ9Ob1Cr+KZKs2B/YOlvMs
   m2h11BKhtk7UT2J8EB+SbRn3R4D2ywXV8i+yTfeYnMlEisdV/tFzKGc57
   Q==;
X-CSE-ConnectionGUID: mqUk3RtQRB2Q6nC4UoxJRA==
X-CSE-MsgGUID: WhGHvJVeT+GXO1SLZ5F8iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="8996546"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8996546"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:57:57 -0700
X-CSE-ConnectionGUID: 024tcXWeQV+Sl8lB28emrw==
X-CSE-MsgGUID: pyP4W8NCSWWM21NDimVSYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23842076"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:57:57 -0700
Received: from [10.212.13.6] (kliang2-mobl1.ccr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6EB44206DFDC;
	Fri, 19 Apr 2024 06:57:55 -0700 (PDT)
Message-ID: <b0a202f1-212e-4846-b472-1f1d1a3314cf@linux.intel.com>
Date: Fri, 19 Apr 2024 09:57:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/x86/intel/cstate: Fix
 Alderlake/Raptorlake/Meteorlake
To: Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ak@linux.intel.com
References: <20240419071019.1103953-1-rui.zhang@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240419071019.1103953-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-19 3:10 a.m., Zhang Rui wrote:
> The spec changes after the patch submitted and PC7/PC9 are removed from
> Alderlake and later client platforms.
> 
> Remove PC7/PC9 support in cstate PMU.
> 
> Fixes: d0ca946bcf84 ("perf/x86/cstate: Add Alder Lake CPU support")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>


The series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/cstate.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index 326c8cd5aa2d..b304430ba64a 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -81,7 +81,7 @@
>   *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
>   *			       perf code: 0x03
>   *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
> - *						KBL,CML,ICL,TGL,RKL,ADL,RPL,MTL
> + *						KBL,CML,ICL,TGL,RKL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
>   *			       perf code: 0x04
> @@ -90,8 +90,7 @@
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
>   *			       perf code: 0x05
> - *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
> - *						ADL,RPL,MTL
> + *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
>   *			       perf code: 0x06
> @@ -642,9 +641,7 @@ static const struct cstate_model adl_cstates __initconst = {
>  	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
>  				  BIT(PERF_CSTATE_PKG_C3_RES) |
>  				  BIT(PERF_CSTATE_PKG_C6_RES) |
> -				  BIT(PERF_CSTATE_PKG_C7_RES) |
>  				  BIT(PERF_CSTATE_PKG_C8_RES) |
> -				  BIT(PERF_CSTATE_PKG_C9_RES) |
>  				  BIT(PERF_CSTATE_PKG_C10_RES),
>  };
>  

