Return-Path: <linux-kernel+bounces-147973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543CA8A7C07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA5F1C2128C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768E535D5;
	Wed, 17 Apr 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1Y1CQib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D42209B;
	Wed, 17 Apr 2024 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333826; cv=none; b=FYUKP2so5Z79Dqs82qP1jkRQUkXbuwMKLAhRBN/MkIxxoON0NxgTtGwLXcIxgaGDW9XIzAR9SNKkmVZj5pS9N7sOOoznwx6Zj9JPnR99A0OGKzjJYLhc4ePEPIeBJkTlmJA+/7pkEkzr0rZ6i+YuLeAMbyMjKkJwpS3bM+x6v8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333826; c=relaxed/simple;
	bh=+Eq3FWKGrjqS7seNZKXEpLlxTviRiT6+OZ9xQJRqG4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWuhKfyxkxNJIZzYx9aduBXWAGPVVdxNPFSlakuE4CIuRtdjBlSgc9FR+T+Ii20ohH5Hsz6o3Fi167dgyahStD5rvOx4D9WVJdK8s3kcnOQIp2ks2HQodXQ+8P3JWeMAmnud272wkLnFkTBYVUCLJ5/Xh7pN99F92EPEUvr+yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1Y1CQib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC58CC072AA;
	Wed, 17 Apr 2024 06:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713333825;
	bh=+Eq3FWKGrjqS7seNZKXEpLlxTviRiT6+OZ9xQJRqG4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1Y1CQibHTdcudeq5dwRUa2vqa/wiYnKE6l4s7SxAT9G3vk5VhpLBiKTYvFBMhJeP
	 K8tGsbHguWZi1NE4p0IymTKorSlCRAz86GUra+tCkGeVW/LfGIzdzDm3tpePhvBjZn
	 4x67S+iZcpUHPVcAH03gFvPsIYznEGerpBYt+SQl4Oo/SvQCPzh8H1rwqaQgWKy+rm
	 w5hfRMrDxD5sRn9UZW0xOhUJkkvub4lJYOd3DU4Acj4WDSaenNL2RKiWDBE9wJ5n/3
	 8ekXq+wxbUqdoKd7QVf8HsvFbahBuA0TUGx4KvLfXVnnMizJ75ZnDllOJpQz5O8K2A
	 qC/e9wFfzWBQA==
Date: Wed, 17 Apr 2024 09:02:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: skseofh@gmail.com
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
Message-ID: <Zh9l_LpThq9aFUR7@kernel.org>
References: <linux-mm@kvack.org>
 <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416120635.361838-2-skseofh@gmail.com>

On Tue, Apr 16, 2024 at 09:06:35PM +0900, skseofh@gmail.com wrote:
> From: Daero Lee <daero_le.lee@samsung.com>
> 
> Like reserved-memory with the 'no-map' property and only 'size' property
> (w/o 'reg' property), there are memory regions need to be allocated in
> memblock.memory marked with the MEMBLOCK_NOMAP flag, but should not be
> allocated in memblock.reserved.

This still does not explain why you need such regions.

As Wei Yang explained, memblock does not allocate memory from
memblock.reserved. The memblock.reserved array represents memory that is in
use by firmware or by early kernel allocations and cannot be freed to page
allocator.

If you have a region that's _NOMAP in memblock.memory and is absent in
memblock.reserved it will not be mapped by the kernel page tables, but it
will be considered as free memory by the core mm. 

Is this really what you want?
 
> example : arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
>         reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
> 
>                 bman_fbpr: bman-fbpr {
>                         compatible = "shared-dma-pool";
>                         size = <0 0x1000000>;
>                         alignment = <0 0x1000000>;
>                         no-map;
>                 };
> 
>                 qman_fqd: qman-fqd {
>                         compatible = "shared-dma-pool";
>                         size = <0 0x400000>;
>                         alignment = <0 0x400000>;
>                         no-map;
>                 };
> 
>                 qman_pfdr: qman-pfdr {
>                         compatible = "shared-dma-pool";
>                         size = <0 0x2000000>;
>                         alignment = <0 0x2000000>;
>                         no-map;
>                 };
>         };
> 

-- 
Sincerely yours,
Mike.

