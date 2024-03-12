Return-Path: <linux-kernel+bounces-99958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5A878FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A592824BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDFA77F05;
	Tue, 12 Mar 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iQfbo45";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58qL5OOc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0377653;
	Tue, 12 Mar 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232828; cv=none; b=X87+84GnYW4ASkXJnWctiarR03wzb82vltqZB7+/6uwW3ZvFaWezv2WFlrwNeQkipwYOb0srmndJEwfnnS7e45Oq5G0FK5hnnF4Lk1RFRU6VubBaSZNKEe0/9eFNxeWZ3LMx7nzQynqLUtJ2xEkHKmqVgBmWHFC/eNbyEZWtuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232828; c=relaxed/simple;
	bh=uhupKSGZ8brO6SESSNZiXmPFnfE/zOMs9qWCvyo6Hp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMMxrehGRcp4VrTulySyJAvA3BPDZHKR7LcwdH45pWE5PlCsNjDHxpFOO7DibpK+8bGqF1PKIzcr2N8bazNX+77wkq9IzH0ZboouJSf/u1GR7fsW8RsRXfyMSjnrT4B/4rdiGXMePIVghy/SaUh3Aek8qsbTiclU8N98DrTIMWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iQfbo45; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58qL5OOc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 09:40:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710232817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhVeoon9Fn+c5RdP92l8KQA07KAunlR8dxh2qnkPF34=;
	b=0iQfbo45WVUn9rzAkxPoSIC+a94J1GcW0ystQxyXSeNgu47vU3Sp2NL5lnenFWzPKccutO
	B54+W4fFTO3rNdUbFVYarR3de3FMG6hdLaeGv+Ei3TFokqjN9EGQ+HReBU+mPPdb9nMAyK
	QPK82ecnL14Z5Jp8knZeE/lIlZU+xFZCxerLOvvwReeqTPxpGxZrj7mwDJrg0qSSfR9yMc
	HPuOivC2BFtVTmmRzPsEPiVtPKm1guJOxo6Fo/rvreI4tA8sBGcW+V8mqCnVCqpOXWhjBj
	zYClZqtmhoSoTOOVUwP1M2+aD/W0Q5UPzVAswLRvjmFulq7Tt7S4OpQcscNT5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710232817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhVeoon9Fn+c5RdP92l8KQA07KAunlR8dxh2qnkPF34=;
	b=58qL5OOcqms30JBQfobSKYyToJr6HupatuhIU1QW2oI0EsMdZl4cNK4nhU+mA0PksSV3sw
	2Ce1rj1JBiG82PAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>, 
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <20240312093238-3025dd50-b84c-4165-9d02-0568b440dd58@linutronix.de>
References: <20240131191732.3247996-1-cleech@redhat.com>
 <20240131191732.3247996-2-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131191732.3247996-2-cleech@redhat.com>

Hi,

On Wed, Jan 31, 2024 at 11:17:31AM -0800, Chris Leech wrote:
> Add a UIO memtype specifically for sharing dma_alloc_coherent
> memory with userspace, backed by dma_mmap_coherent.
> 
> This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
> are a few other uio drivers which map dma_alloc_coherent memory and
> could be converted to use dma_mmap_coherent as well.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>  drivers/uio/uio.c          | 40 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uio_driver.h |  3 +++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 2d572f6c8ec83..dde3f49855233 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -24,6 +24,7 @@

[..]

> +static int uio_mmap_dma_coherent(struct vm_area_struct *vma)
> +{
> +	struct uio_device *idev = vma->vm_private_data;
> +	struct uio_mem *mem;
> +	void *addr;
> +	int ret = 0;
> +	int mi;
> +
> +	mi = uio_find_mem_index(vma);
> +	if (mi < 0)
> +		return -EINVAL;
> +
> +	mem = idev->info->mem + mi;
> +
> +	if (mem->dma_addr & ~PAGE_MASK)
> +		return -ENODEV;
> +	if (vma->vm_end - vma->vm_start > mem->size)
> +		return -EINVAL;
> +
> +	/*
> +	 * UIO uses offset to index into the maps for a device.
> +	 * We need to clear vm_pgoff for dma_mmap_coherent.
> +	 */
> +	vma->vm_pgoff = 0;
> +
> +	addr = (void *)mem->addr;

This cast introduces a build error when building with
sizeof(void *) != sizeof(phys_addr_t).

For example on i386 with PHYS_ADDR_T_64BIT.
(Enabled through allmodconfig)

drivers/uio/uio.c: In function 'uio_mmap_dma_coherent':
drivers/uio/uio.c:795:16: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  795 |         addr = (void *)mem->addr;
      |                ^
drivers/uio/uio_pruss.c: In function 'pruss_probe':
drivers/uio/uio_pruss.c:194:34: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  194 |                 p->mem[2].addr = (phys_addr_t) gdev->ddr_vaddr;
      |                                  ^
drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
drivers/uio/uio_dmem_genirq.c:63:39: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   63 |                 uiomem->addr = addr ? (phys_addr_t) addr : DMEM_MAP_ERROR;
      |                                       ^
drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
drivers/uio/uio_dmem_genirq.c:92:43: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   92 |                                           (void *) uiomem->addr,

As you can see some other files are also affected, which seem to be
triggered by other but related patches.

This is on next-20240312.

> +	ret = dma_mmap_coherent(mem->dma_device,
> +				vma,
> +				addr,
> +				mem->dma_addr,
> +				vma->vm_end - vma->vm_start);
> +	vma->vm_pgoff = mi;
> +
> +	return ret;
> +}
> +

[..]

Thomas

