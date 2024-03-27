Return-Path: <linux-kernel+bounces-121583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FA88EA23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608F11F285A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2912F585;
	Wed, 27 Mar 2024 16:00:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B611A12F39A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555246; cv=none; b=FnCi8q1bbqlbYhhe4FtebvlWgv6xVHW57Cpu0ApYBlOjfJoRW8QLXkyaVD6BAWlWB8PFWv1raX1izHQRtkEwWmfpf8qID793rJfRWgDpcq5Gz1cK+k1nY2wrDeznY1Y9tBqNSlcMbePkB/9Ltapdv+SRf69doND41arzp4clvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555246; c=relaxed/simple;
	bh=JS5thebpPvWinK71tE9YoMKI5Q+RqwPZBFTYA15xw9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0RZlN6pfsXISLWfHy/47TiecoPB9ZvC+L/rxqWCD2YY6OBx5ZdWsx0RhwUXFNG7wWHxr0G3RQSM1K9puYyQ1AEdjVT3XZIVWg5q1F/1PabYp6TCEC8X99niXNRrhTWpKRaOpc8go7mb+BxU+StZa40cjubUeU1V28SvYBNxPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03CD22F4;
	Wed, 27 Mar 2024 09:01:17 -0700 (PDT)
Received: from [10.57.14.133] (unknown [10.57.14.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FAB3F64C;
	Wed, 27 Mar 2024 09:00:41 -0700 (PDT)
Message-ID: <14f5c4e4-6f8b-4e4d-9aa1-01819355ea07@arm.com>
Date: Wed, 27 Mar 2024 16:00:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ABI: sysfs-driver-panfrost-profiling: fix indentation
 problem
Content-Language: en-GB
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: kernel@collabora.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org
References: <20240326134812.4008775-1-adrian.larumbe@collabora.com>
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

Looks reasonable, the other option is to make this a proper ReST list,
but it's probably not worth it with just two values.

Reviewed-by: Steven Price <steven.price@arm.com>

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


