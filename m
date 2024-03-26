Return-Path: <linux-kernel+bounces-119655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A019488CBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D53254C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0795126F1E;
	Tue, 26 Mar 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KMTIgxRg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9D86AC0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476588; cv=none; b=Xf7/gTh5/1k6nfnpE0Btb45BzudsxJIaxd3PkKAJWz1fqXyTpoNfrLF/peFhHG6nzFzeeSHYkJW3h7jFmIozBRfK8Gq30gm2TVzc2Rw5+YYk+bCgI5CiIoR++Dz2bzZGbHohx5TKNR9aPFfPZwvrGDtmz2ixud2R+VHwhDhFIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476588; c=relaxed/simple;
	bh=1EHd+ySuj6GLNRY/ECwc/xd+Jk3dMNq2LecG5fHRgAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiDZ/efNmlhJ43VKwV6ExKbDjd2BKxExCRYW431cNdFCGCFUKfZJXkLgpY2GmIcwDZt4YOtAQ+d4cTB/sxExXKvww4TOYQCiTFhzb2Ag4FZ0XqXX84O9KfPXxVV0ELNf1K9PhBzXjuFcYMmF5NgxUi231/qQwAzfMRU9v9uo0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KMTIgxRg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Vi8I/4BXaR9ev7e/70xnVfH6HdvqRrXorFjJaNFUx6s=; b=KMTIgxRgpDYVkg5iw/MnfWNCML
	q5AXTvtZ95ufQj4dRRXQrFee4KLSlFGr88CghlA5tNg2kPamU0hbC9x+YDlgLxxBuu+dqAat6CC+Q
	9aAMgG+y+0scG4yNySHRZ7b0m4g8qvUCmKUbLO4G/JflwNb9gmluOFFjzXczc8ZUMFRWaW1yOvUJk
	mQ/b3k7v4T1MCSm7QameGo+2h6jtU3/QFwEKF3zzo2MRGRZLW3ENzadW4x+mbzPPlHbxuDOEwaMrU
	pOfaqbVQumCeq/q62SQb/iENFsMaXLJGUtPd5BCRrxXD/30vWj1YK2CUL2BT7IWPDFFF56iyTlAPT
	U4o4fI2A==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpBF3-00000005s9C-0NNi;
	Tue, 26 Mar 2024 18:09:45 +0000
Message-ID: <7a446e06-7adc-4c65-a97a-20832072556e@infradead.org>
Date: Tue, 26 Mar 2024 11:09:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ABI: sysfs-driver-panfrost-profiling: fix indentation
 problem
Content-Language: en-US
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>
Cc: kernel@collabora.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org
References: <20240326134812.4008775-1-adrian.larumbe@collabora.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240326134812.4008775-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/24 06:48, Adrián Larumbe wrote:
> Also add a newline character at the end of the last one.
> 
> Fixes: b12f3ea7c188 ("drm/panfrost: Replace fdinfo's profiling debugfs knob with sysfs")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/dri-devel/20240326160110.4c00e1e5@canb.auug.org.au/
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
 
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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

-- 
#Randy

