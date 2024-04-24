Return-Path: <linux-kernel+bounces-156831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E08B08DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F187B1F254A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5E15AAB3;
	Wed, 24 Apr 2024 12:03:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57EF15A4A3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960203; cv=none; b=hPxvcNSups+fpPEUREscMyN+Fbdk5nVXjdTT9c9YZh5xyUph3xQjDM6SO0eQHIkWvkdaG8G3po+4MFG1hYJjcybQ2wMkPRg78n2qOgCpvePeyO3bAWbDnke+uX4DstY8FbUpUJ8x5GuBFY+JnNmcoTfd4Nv2iZ5NFJkItgv1iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960203; c=relaxed/simple;
	bh=3qyohKYVkP7EHUOoY0LvHy7ZraBXvemIJsK/JJLsIq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFbumN3/YpiPBw8tOPRmgHSkCj0rnfQYpJRjx+3rFkhoD4Fjs05JVUlfVHy54VAfJ8AcOroLkm+ZHTZRIAplAiLPKeTm8/AoBY8IDOOkG6iywjNuvLhQIn4zDr0NketbcF7TQ6yqvVeUanapzWygrYMiQT6saSRrP3DLAFT+/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613FA2F;
	Wed, 24 Apr 2024 05:03:44 -0700 (PDT)
Received: from [10.57.83.211] (unknown [10.57.83.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2B33F73F;
	Wed, 24 Apr 2024 05:03:14 -0700 (PDT)
Message-ID: <97a016d3-5398-48cc-a0cc-571bf50d2b11@arm.com>
Date: Wed, 24 Apr 2024 13:03:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: stm: Remove duplicate linux/acpi.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, suzuki.poulose@arm.com
Cc: mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240424023605.90489-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240424023605.90489-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/04/2024 03:36, Jiapeng Chong wrote:
> ./drivers/hwtracing/coresight/coresight-stm.c: linux/acpi.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8871
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index cbf7f17556f8..9ca04fac53fa 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -30,7 +30,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/stm.h>
>  #include <linux/platform_device.h>
> -#include <linux/acpi.h>
>  
>  #include "coresight-priv.h"
>  #include "coresight-trace-id.h"

Reviewed-by: James Clark <james.clark@arm.com>


