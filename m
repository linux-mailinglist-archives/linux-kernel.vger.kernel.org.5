Return-Path: <linux-kernel+bounces-112480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB4887A56
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FEB1F21E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833883D0B9;
	Sat, 23 Mar 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZaIhBrj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C775CB5;
	Sat, 23 Mar 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226633; cv=none; b=hi7CjbQ4kXommqiqditQ1W4AnITH8yHuvMClUPA6OeftJNkWZHir7kXirjmjKI+JQf+FANEJcirzYPgiA6HejKl16dJV127KZ35h9nz3fSp25GystNltz2SVs1Ha/CViQV7s6eYGkMQD2aP8e4aBMNey8KnrJUYhYBKRB18NphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226633; c=relaxed/simple;
	bh=7J83nDc0jpvLlG/MqtJFdTwHHLhkW4RHRwbfxlwcv8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoaCTgIn9B9MmpZ/AqqEjjIXXl/ERgtqLmZukuMShu0xZN/H2y8YTeoq7yAOfUT+jtKvu9xlWZi06OPkjqoe/cD28oCKUoRbIlK3UymNnOi0bLkHpgoaT7WkI8/VxTrm9g0hAkL2ylZlN4kKsx+S3sFNUGF+B/4KHbqJtAfn3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aZaIhBrj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fCPVmTKTDT9EyIJ0uHfdJM731Jbw/NCBwbfsJq5CekM=; b=aZaIhBrjz22jMwp0SM08sH/hLU
	1bFkboFc7sPTz8pg01jpLcH5dV8yN9VUI+ED0rTwa813vL3E/n5erXdu09eINZ7/sN8zweecNHRzX
	mvSjZ2NFZWrUBHnJjqaNglpLOnWma6AITNJSydKL2hT9QVZBHwUmyw1/oJl8VhsEYF1cFpTw/cUK8
	eWQ8GLG+ijPEnmz/l5eObr1eLnwYTivbg4BBp8gCRK8XGaEGgL6fWJzVdeeFM7iRndcWMQABZ76Ub
	xmJblPfdQBu/K9WUwJ4iseww5L9rgeOemIlHaK8XLugINBZGqTAQq89K6AIj56PiTs0c+kryHhLym
	useNT0sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro8DJ-0000000CWBj-2jRk;
	Sat, 23 Mar 2024 20:43:37 +0000
Date: Sat, 23 Mar 2024 20:43:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix duplicate C declaration warnings
Message-ID: <Zf8--QSkEMDe9zyp@casper.infradead.org>
References: <20240323163148.23497-1-amogh.linux.kernel.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323163148.23497-1-amogh.linux.kernel.dev@gmail.com>

On Sat, Mar 23, 2024 at 10:01:47PM +0530, Amogh Cheluvaraj wrote:
> Fix duplicate C declaration warnings at
> Documentation/gpu/drm-kms.rst that was found by
> compiling htmldocs

I'm sure this removes the warning, but it removes all kernel-doc
which exists in drivers/gpu/drm/drm_fourcc.c.  Isn't there a more
granular fix than this?

> /home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
> kms:360: ./drivers/gpu/drm/drm_fourcc.c:344: WARNING: Duplicate C
> declaration, also defined at gpu/drm-kms:39.
> Declaration is '.. c:function:: const struct drm_format_info *
> drm_format_info (u32 format)'.
> /home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
> kms:461: ./drivers/gpu/drm/drm_modeset_lock.c:392: WARNING: Duplicate C
> declaration, also defined at gpu/drm-kms:49.
> Declaration is '.. c:function:: int drm_modeset_lock (struct
> drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.
> 
> Signed-off-by: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
> ---
> 
> changes in v2
> - add warnings found after compilation
> - fix grammar in commit description
> 
> ---
>  Documentation/gpu/drm-kms.rst | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index 13d3627d8bc0..a4145f391e43 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -357,9 +357,6 @@ Format Functions Reference
>  .. kernel-doc:: include/drm/drm_fourcc.h
>     :internal:
>  
> -.. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
> -   :export:
> -
>  .. _kms_dumb_buffer_objects:
>  
>  Dumb Buffer Objects
> @@ -458,9 +455,6 @@ KMS Locking
>  .. kernel-doc:: include/drm/drm_modeset_lock.h
>     :internal:
>  
> -.. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
> -   :export:
> -
>  KMS Properties
>  ==============
>  
> -- 
> 2.44.0
> 
> 

