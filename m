Return-Path: <linux-kernel+bounces-123168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EF890396
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904771F24DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63278130A42;
	Thu, 28 Mar 2024 15:41:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591F82D66
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640460; cv=none; b=OCGUeG2QgYo+2wQ9849ZeSOfZvAk7Gpjzh6Au2LwTXwUqJJG+lM9jN/PEx2gcDjBPXF2GkMjf3bxNZVI7LYSgswKWTwwiWlzQEQSuIa6my/ds5SSRI4iFbVZjz7AxyDhMTC8GCrTY67ORsgvQCL5ptVFnwxvn98w5V7cU/Iqipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640460; c=relaxed/simple;
	bh=kOYA+Mm9nvA63RxylVIDUBFnllMPZFbPt5tAKHzO3us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2S0Zcs1iKePxmLLge/RoYaFzu6HcImRe9icvQipTD8JeJIe6myHPcp2VlEUN8ZhNyV0rHKgR7cVbJS3k8cGEjZ7f1cXWwl6aEyrPTkTFvGg59fWQS9SmznA4DLAixjTginTo5RbIVTqjkcGJVU6Tc2v8l5ZkuqEQU4+Jo9le1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492D71476;
	Thu, 28 Mar 2024 08:41:30 -0700 (PDT)
Received: from [10.1.29.21] (e122027.cambridge.arm.com [10.1.29.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7FA43F7BD;
	Thu, 28 Mar 2024 08:40:55 -0700 (PDT)
Message-ID: <b3cdf391-87d8-4743-810a-1e85a4a0ddda@arm.com>
Date: Thu, 28 Mar 2024 15:40:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ABI: sysfs-driver-panfrost-profiling: fix indentation
 problem
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: kernel@collabora.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org
References: <20240326134812.4008775-1-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20240326134812.4008775-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 13:48, Adrián Larumbe wrote:
> Also add a newline character at the end of the last one.
> 
> Fixes: b12f3ea7c188 ("drm/panfrost: Replace fdinfo's profiling debugfs knob with sysfs")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/dri-devel/20240326160110.4c00e1e5@canb.auug.org.au/
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Queued to drm-misc-next

Thanks,

Steve

> ---
>  Documentation/ABI/testing/sysfs-driver-panfrost-profiling | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-panfrost-profiling b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> index 1d8bb0978920..7597c420e54b 100644
> --- a/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> +++ b/Documentation/ABI/testing/sysfs-driver-panfrost-profiling
> @@ -7,4 +7,4 @@ Description:
>  		Valid values are:
>  		0: Don't enable fdinfo job profiling sources.
>  		1: Enable fdinfo job profiling sources, this enables both the GPU's
> -		   timestamp and cycle counter registers.
> \ No newline at end of file
> +		timestamp and cycle counter registers.


