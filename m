Return-Path: <linux-kernel+bounces-87307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028B86D27E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168851F22EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8A7D08C;
	Thu, 29 Feb 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qYNCfL5i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77504405F9;
	Thu, 29 Feb 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232127; cv=none; b=oGOY65SboqY4cD7r0FYq1689Hie9UQnk19nXqetJFSL03Gv4GwIGRd0yjxeTXAjEbbRSjSPwEFAjknCQwI0jl1Ybh7ebL8OmQoxdCvyTosOrqZt7PNb5I0vbM2hn2nWq7OOtqjqB/OOtpY0iPkmfm+Z85mU30tGPPb0vSzLJKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232127; c=relaxed/simple;
	bh=6Q9YQ5JrvV5TT6WigJ4rpB2hWZ0gwkmwK4ue/OTgeDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIPLIo0YqlDf+uxfFr5zVEKtoY8Ky39HYHpBNi/VHEz1aipWhLfRSB7Dm8d8C8ORnGkv2/AeAysyZ72FKoHGYErhARcUAMy50tWnftvIkCizgcl/Y7QIfAvC6uphAEupC/w2/uvwHB+rpdn6nmwDcU/6bmelo4AnxAVv5T/20Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qYNCfL5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7468FC433C7;
	Thu, 29 Feb 2024 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709232127;
	bh=6Q9YQ5JrvV5TT6WigJ4rpB2hWZ0gwkmwK4ue/OTgeDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYNCfL5iUEJh5Vs4iY3aFLrDrVD/sF4EAiaLf5jJhIppNNRT29nJrpiZhHQLcu8oX
	 D8AIXFId6eiOW+TSCG3flvrVJ6hGcijI4K09+MWIrPO1KP7Bjbd/z5VH0Bx2pB74Fi
	 jvapwf1Fiw13fN+T7d9v2vT9Gv29PvdBmFNavqPs=
Date: Thu, 29 Feb 2024 19:42:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Message-ID: <2024022911-eatery-woven-f882@gregkh>
References: <20240227131615.098467438@linuxfoundation.org>
 <03a17f2d-ab8f-4241-8912-ebd903fb2c43@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a17f2d-ab8f-4241-8912-ebd903fb2c43@roeck-us.net>

On Thu, Feb 29, 2024 at 10:15:49AM -0800, Guenter Roeck wrote:
> On 2/27/24 05:23, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.150 release.
> > There are 245 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> > Anything received after that time might be too late.
> > 
> 
> $ git grep dma_fence_allocate_private_stub
> drivers/dma-buf/dma-fence-unwrap.c:             return dma_fence_allocate_private_stub(timestamp);
>                                                                                        ^^^^^^^^^
> drivers/dma-buf/dma-fence-unwrap.c:             tmp = dma_fence_allocate_private_stub(ktime_get());
>                                                                                       ^^^^^^^^^^^
> drivers/dma-buf/dma-fence.c: * dma_fence_allocate_private_stub - return a private, signaled fence
> drivers/dma-buf/dma-fence.c:struct dma_fence *dma_fence_allocate_private_stub(void)
>                                                                               ^^^^
> drivers/dma-buf/dma-fence.c:EXPORT_SYMBOL(dma_fence_allocate_private_stub);
> drivers/gpu/drm/drm_syncobj.c:  struct dma_fence *fence = dma_fence_allocate_private_stub();
> include/linux/dma-fence.h:struct dma_fence *dma_fence_allocate_private_stub(void);
>                                                                             ^^^^

How is any of this building then?  Does no one actually use
dma-fence-unwrap.c?

> This was introduced with commit 4e82b9c11d3cd ("dma-buf: add dma_fence_timestamp helper") in
> v5.15.149. The additional parameter to dma_fence_allocate_private_stub() was introduced in the
> upstream kernel with commit f781f661e8c99 ("dma-buf: keep the signaling time of merged fences
> v3") which is missing in v5.15.y.

f781f661e8c99 still uses an option to dma_fence_allocate_private_stub():
-               return dma_fence_get_stub();
+               return dma_fence_allocate_private_stub(timestamp);

So backporting that will continue the breakage, right?

confused,

greg k-h

