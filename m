Return-Path: <linux-kernel+bounces-51577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04646848CBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FEB1F22304
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95081B7F6;
	Sun,  4 Feb 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnzcaKaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FA1B59C;
	Sun,  4 Feb 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042056; cv=none; b=AkEQAaH0sh6mBK8pEM8uovnOSvdjc8J9TRtiyjJ3x9iSxtpLic/06Blyvsjw1TfyGFbVjeyOAyuloH9CO/WSy2qwGGanM0GnCn9uEdEMVwmN4BJsiWGR1YfyZWKCcRkrNtTeXTmFjOGKjK2GliKd3M/dMIEnyWrkAfedlgDjBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042056; c=relaxed/simple;
	bh=FlDUZIVR1R9thyOlKJz8I0F2dcW/QljUsBEVwxTgjgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv8+nXsGzvYbHGAIoyNCf4OXu7MctY45zvlEaY5Bdaslwkzfcc54LVabQNj7L4IDh+RmDy7S/ac5MDl695vMDRoiQD+YzpptS2H+j+RMO36jHuMixMCXJ630lF6/aAVzXDyrtAfMX2NtMEY1qdMlunE0GeDuTIaauSOkjeWEeTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnzcaKaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEB2C433F1;
	Sun,  4 Feb 2024 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707042055;
	bh=FlDUZIVR1R9thyOlKJz8I0F2dcW/QljUsBEVwxTgjgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnzcaKaNQX/+UF88IZHG2lIi7bb8FcePwmS/5scU2yYOtiptiq/obKXco+vQAKzOs
	 tQ3qSGozkOqNLFrEhDE/RM7C9Gavnj/kys8afk0SOjFqSswgFnyV5TlCdrnHw3cTbT
	 JwHWrezcaiV+6PjOrNe6U5Yq/NEIWwwGodDbCfKyHwPwW3iJ4PymFtz6KksQ7iBZRN
	 uZoWv/EO7K55STCqABIOn/G7tJ2vQo6k/R++uAT2/JUIw/kXSB0OHScYlFZ9vTd3sH
	 iY7c07mK105jWY8ptBvIVWVOXKpgK+l/zKfPUsN89x5GLsmvaRVEl+k8EO1n4tSV1B
	 a+OAKtvPSlAcA==
Date: Sun, 4 Feb 2024 10:20:50 +0000
From: Simon Horman <horms@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 1/4] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <20240204102050.GB916983@kernel.org>
References: <20240201233400.3394996-1-cleech@redhat.com>
 <20240201233400.3394996-2-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201233400.3394996-2-cleech@redhat.com>

On Thu, Feb 01, 2024 at 03:33:57PM -0800, Chris Leech wrote:
> Add a UIO memtype specifically for sharing dma_alloc_coherent
> memory with userspace, backed by dma_mmap_coherent.
> 
> This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
> are a few other uio drivers which map dma_alloc_coherent memory and will
> be converted to use dma_mmap_coherent as well.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

..

> diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
> index 47c5962b876b0..a7756f909dd01 100644
> --- a/include/linux/uio_driver.h
> +++ b/include/linux/uio_driver.h
> @@ -37,10 +37,12 @@ struct uio_map;
>  struct uio_mem {
>  	const char		*name;
>  	phys_addr_t		addr;
> +	dma_addr_t		dma_addr;
>  	unsigned long		offs;
>  	resource_size_t		size;
>  	int			memtype;
>  	void __iomem		*internal_addr;
> +	struct device		*dma_device;
>  	struct uio_map		*map;
>  };

Hi Chris,

please consider adding these new fields to the kernel doc for this
structure, which appears just above in uio_driver.h.

..

