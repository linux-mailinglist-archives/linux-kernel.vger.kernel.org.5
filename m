Return-Path: <linux-kernel+bounces-60658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C6850820
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460D7283CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A652F82;
	Sun, 11 Feb 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0GR0ZBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FC52F65
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640278; cv=none; b=T+toIIXQT6ySZZMKmQTHmnOmzCBhcr8VrPEhUMAlvAZDO4Jh9neSFm5Xn1bVrs2O2knNLDBF+Vn41bLw1JupI86VlQ7exF8DCJtY/fH9udmCyysjCJRLCZYRUxbEPTTAqvWiXN/dhh52Y8AgNMOqJf6zWmriEPXT1uRbKp9o8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640278; c=relaxed/simple;
	bh=JqHQfILX+iph4O4lw4pSdkFqDOA1bddPCOQHKr6s+e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBPmpNH0oUTRWmncVt7X3HTRIebpFL3aYY1GS4Sb5A2rME/UZxTnYRt5/U+d5MiGi7mObesAJJlEtd15NshR/FaDS22wn+4VRfxUNyxDFExCk00EsegD/zOIclrqo86Jmyb35ht27t4U42OgZpFd71XLPNJOHQ4OLHR4CAFG+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0GR0ZBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC91C433C7;
	Sun, 11 Feb 2024 08:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707640277;
	bh=JqHQfILX+iph4O4lw4pSdkFqDOA1bddPCOQHKr6s+e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0GR0ZBtvm3Kyrp/pWG6uXis0qHHDSfT1DqyCceaowEFhVc9EpP+MBQmJF3UG5pDb
	 HHx7f37cxryI5UV9R/zCk0P4nMWVQ2kYiMvnM+gBkWIv5X2F2DTbkt72LRRxP6mgjB
	 1HnaIbzYEHGBKYzxCinDifzBuQvLhS6c9CotL3BAuk7x2xwXor5etWXUCUZ0Dy8wY7
	 YSP0RtpnHb6dSQlarS41ie0h0gstu5SlnNJVDJumJKo7zYmLiSViz4upcj7qHPZ/+H
	 be6j3nZVnE8tcneQPxfvFKByjkfrcwihlaKeEZ+yT0PnoGsBlp4qqADpo5ihZvV8ni
	 Cz9nPFkRAD/Mg==
Date: Sun, 11 Feb 2024 10:30:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: Add MEMBLOCK_RSRV_NOINIT into flagname[]
 array
Message-ID: <ZciFwCU9kz7Uko9j@kernel.org>
References: <20240209030912.1382251-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209030912.1382251-1-anshuman.khandual@arm.com>

On Fri, Feb 09, 2024 at 08:39:12AM +0530, Anshuman Khandual wrote:
> The commit 77e6c43e137c ("memblock: introduce MEMBLOCK_RSRV_NOINIT flag")
> skipped adding this newly introduced memblock flag into flagname[] array,
> thus preventing a correct memblock flags output for applicable memblock
> regions.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Fixes: 77e6c43e137c ("memblock: introduce MEMBLOCK_RSRV_NOINIT flag")
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> This applies on v6.8-rc3
> 
>  mm/memblock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 4dcb2ee35eca..d9f4b82cbffe 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2249,6 +2249,7 @@ static const char * const flagname[] = {
>  	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
>  	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
>  	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> +	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
>  };
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

