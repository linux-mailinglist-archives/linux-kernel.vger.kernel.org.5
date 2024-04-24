Return-Path: <linux-kernel+bounces-156833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38D8B08DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97D7B25097
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE015AAD6;
	Wed, 24 Apr 2024 12:05:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A170A159200
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960304; cv=none; b=WKWi90VVagfhlE0Ymo/St81gyafbER838cza2A7fhRjaJ/em+r5pJI+nCZzF7Bhq82JVzUkHRPaRukCj8d5kccmso3hU7n0nwxl5T5OZVAyrG1lt3A4sajaPNejZUkbQwtIkH0BGeZi3DX52W7cXyUQzLwMM0CGAQ21/GZmsjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960304; c=relaxed/simple;
	bh=8b7RkxQkPBrkIAdDZ7ByrfF2vRBQaDjBq6cRssq261s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/hAVIUL7I3sHKUkTMkPaQOgc0Yi88m4OP1dTJ4QpDtqTG6uiY1KuAyCt6eaeUT40dTFp/u1kLWGi9VRpRSKxgpfBcIdS4u08GdnvEbqpILEGwyhOlqV0K3QMpZyrxzTmweSoQESPYohthr18wNn+BpW6rlFaFK4fdHFGOxPgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDCC32F;
	Wed, 24 Apr 2024 05:05:25 -0700 (PDT)
Received: from [10.57.83.211] (unknown [10.57.83.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D4393F73F;
	Wed, 24 Apr 2024 05:04:56 -0700 (PDT)
Message-ID: <474a7db1-f576-46fc-a12a-b479e7045f37@arm.com>
Date: Wed, 24 Apr 2024 13:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Remove duplicate linux/amba/bus.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, suzuki.poulose@arm.com
Cc: mike.leach@linaro.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240424022420.58516-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240424022420.58516-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/04/2024 03:24, Jiapeng Chong wrote:
> ./include/linux/coresight.h: linux/amba/bus.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8869
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  include/linux/coresight.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 653f1712eb77..f09ace92176e 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -12,7 +12,6 @@
>  #include <linux/io.h>
>  #include <linux/perf_event.h>
>  #include <linux/sched.h>
> -#include <linux/amba/bus.h>
>  #include <linux/platform_device.h>
>  
>  /* Peripheral id registers (0xFD0-0xFEC) */

Reviewed-by: James Clark <james.clark@arm.com>

