Return-Path: <linux-kernel+bounces-138587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BF89F415
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D507F1F2CCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A916C45C;
	Wed, 10 Apr 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amlRCAAy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650916131C;
	Wed, 10 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755213; cv=none; b=bVqE+FeO33Ntxo8FcetkH9vEe/9xXlv4xZxrWvNjIFZaZaKJ3x0SuH6ZREAk4qtoq0fkYlhC6NAgtAfE4E0hby320rdj0M4hjYWjirItwUbHOxwzaVwzneG8+9bKxNbe9LBBpi0JkU6wi6Gi4i1XhVmbPxwQ9Mp4bXVoHtOqTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755213; c=relaxed/simple;
	bh=uHVxn6S6zS02geIFwmBs5SHYJUz02pa08bMj+uvJEIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM269erX+HQnG2+JC6DhYHeewdERzal8Op7wzfvTUZ/Xo4bRKzl5Qny5oVsgCqL+0QhPXxlbrG+imqQ0Je96e45yhlUaBunLlDG8YwRfFoaE/vca0O4SQe5kZr3He+CyT5c/DxV8fmNXt28skkFl3ZY393JomPJ6ZKQFwm6jQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amlRCAAy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712755211; x=1744291211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uHVxn6S6zS02geIFwmBs5SHYJUz02pa08bMj+uvJEIw=;
  b=amlRCAAyA6a+vy7q/6P0ppurWsVmJLsuPuxAkvvM7lTLVmfDfgGPaITe
   AuQnwqo2KaudXKWuJtktTZ+a8Z7mApoIuQ6RXOySEIMbOqjOmIXMS+3th
   94N41a3qunFc9aDmGhNX0zLPCWXhiiJ0tk1i5+6nYg9THpLsbWuwSVsYW
   uKpczIv3/Bm92mER6ESggqPWIOe333moWx/v7sTBF/w2F0tQ3GFmXA63r
   KofUuymui/WaYlk1OB79jTiRZ6ffgGwM4W8MZuURlteiVcy55849qfDvS
   YY0ub/nKkUggmCdowGkxmPZ1f/VnywtcesPxyP0OkDNnFCyWxUWqDMJJd
   Q==;
X-CSE-ConnectionGUID: WHiwNWEZRoyME+MhgQ4zTw==
X-CSE-MsgGUID: Wh8fovDJRVG3S4sICspMVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7988973"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7988973"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:20:10 -0700
X-CSE-ConnectionGUID: eycmoRiYS8y3Zs+HD8krtA==
X-CSE-MsgGUID: AHdQNHWLRXqZQdb/dwvMfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25186819"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:20:10 -0700
Received: from [10.212.84.148] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0066920B573A;
	Wed, 10 Apr 2024 06:20:08 -0700 (PDT)
Message-ID: <55528313-d858-41d2-b438-77bbc0e514f0@linux.intel.com>
Date: Wed, 10 Apr 2024 09:20:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Arrow Lake
To: Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ak@linux.intel.com
References: <20240410124554.448987-1-rui.zhang@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240410124554.448987-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-10 8:45 a.m., Zhang Rui wrote:
> Arrow Lake RAPL support is the same as previous Sky Lake.
> Add Arrow Lake model for RAPL.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

The series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  arch/x86/events/rapl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index fb2b1961e5a3..6bfb78d5b37e 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -808,6 +808,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
>  	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
>  	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
> +	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&model_skl),
> +	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&model_skl),
>  	{},
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);

