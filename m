Return-Path: <linux-kernel+bounces-26293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D482DE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A601C21EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD571862B;
	Mon, 15 Jan 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsWaigLg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A2182A7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705338516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1P61my+Bw8+fnvo70xyLGssKK24tkeqWAOxKcUoi5E=;
	b=IsWaigLgBWnJWUMDVhFaXIa8BS+0Bw+khEWGsMx7gZaO68OmcPX5/aFYiydQLc3smFITt7
	p3re+pWPMyqk78dBlTuwWNn11aStIEEhA/DTF7DZI46/ROae85e2S9pCPzY3FMGj9GlQsg
	WBMwMXbk9oftjTTQDvLodMnxrmKVN/Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Y5a0MTknPy6oZrCgfBbapw-1; Mon, 15 Jan 2024 12:08:35 -0500
X-MC-Unique: Y5a0MTknPy6oZrCgfBbapw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-429abac743fso93551391cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338515; x=1705943315;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1P61my+Bw8+fnvo70xyLGssKK24tkeqWAOxKcUoi5E=;
        b=SDUKKXXz4zDsg1jf/iXp/Z2H/bYnFymcXjWYet+ALbNFEfYmNW9LSWLFHT1mOlLUZ6
         JzxHC0h3x/v+o4UyYznQv+6Odq/TmuSvgq/m7veGBupBPWfyALApi9OZIlIAoLmkGiqv
         c2pOXZxKEw6Pv1qKa4JPzyUJF6QnrGTbJsuyNrmtIMRwRhSWjaE1896G2U4gUA5/MAK3
         Kzl8cvz1jjUbYQQBgienojvxGKWTJSSMKMbCYU8mANaO7mPIcyav5kKi9xpurNwV71Ho
         ilRko0vXQr6JxsgihggFpffx7tIXwjeWTX5qKEcsLsTKqjSKdrCM2i8W3qBQ5AKL3Clb
         9ClA==
X-Gm-Message-State: AOJu0Yzn4970am1FdMtmwGX6ls5D2Te+cVT1nxX19v0Y6sx/0P2qpZNI
	ezZdegaUB+kYDvPmak4h0T4wt5B1LXYdASAc1P0Q8CzMb9RoMrAa+1m5ewKVk80i4EUqx7LFTkU
	GsZVXB3QvodmZ7lpczSoeDDXaHUqjIB4=
X-Received: by 2002:a05:622a:1b9e:b0:429:cfa7:2694 with SMTP id bp30-20020a05622a1b9e00b00429cfa72694mr8278451qtb.132.1705338514908;
        Mon, 15 Jan 2024 09:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSo27e4aZe4IMLfNfuibFhqawYh2aJcFoKYMMlbNu9QIdvCFbQvArA0Ru5fOqmfL7xiIx6vQ==
X-Received: by 2002:a05:622a:1b9e:b0:429:cfa7:2694 with SMTP id bp30-20020a05622a1b9e00b00429cfa72694mr8278439qtb.132.1705338514643;
        Mon, 15 Jan 2024 09:08:34 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id fv11-20020a05622a4a0b00b00427fb1d6b44sm4089985qtb.5.2024.01.15.09.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 09:08:34 -0800 (PST)
Message-ID: <12b50394-3d02-4fe2-9b00-97788b2a64ef@redhat.com>
Date: Mon, 15 Jan 2024 18:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC 1/2] fpga: support loading from a pre-allocated buffer
To: Nava kishore Manne <nava.kishore.manne@amd.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org
References: <20231122053035.3758124-1-nava.kishore.manne@amd.com>
 <20231122053035.3758124-2-nava.kishore.manne@amd.com>
Content-Language: en-US
In-Reply-To: <20231122053035.3758124-2-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-11-22 06:30, Nava kishore Manne wrote:
> Some systems are memory constrained but they need to load very
> large Configuration files. The FPGA subsystem allows drivers to
> request this Configuration image be loaded from the filesystem,
> but this requires that the entire configuration data be loaded
> into kernel memory first before it's provided to the driver.
> This can lead to a situation where we map the configuration
> data twice, once to load the configuration data into kernel
> memory and once to copy the configuration data into the final
> resting place which is nothing but a dma-able continuous buffer.
> 
> This creates needless memory pressure and delays due to multiple
> copies. Let's add a dmabuf handling support to the fpga manager
> framework that allows drivers to load the Configuration data
> directly from a pre-allocated buffer. This skips the intermediate
> step of allocating a buffer in kernel memory to hold the
> Configuration data.

Sharing images/bitstreams using dma-buf to avoid multiple copies
make sense to me to have a fast path for partial reconfiguration.
However, implementing the userspace interface for importing the
buffer at the manager level seems questionable, considering that
the manager should be responsible only for writing images.

Wouldn't it be conceptually cleaner to implement the interface for
importing dma-buf as a separate layer on top of the manager? Such a
layer could then program the FPGA using the standard write_sg 
interface exported by the manager. In this way, each component would
have its own responsibility.

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 113 ++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h |  10 +++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 06651389c592..23d2b4d45827 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -8,6 +8,8 @@
>   * With code from the mailing list:
>   * Copyright (C) 2013 Xilinx, Inc.
>   */
> +#include <linux/dma-buf.h>
> +#include <linux/dma-map-ops.h>
>  #include <linux/firmware.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/idr.h>
> @@ -519,6 +521,39 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
>  	return rc;
>  }
>  
> +static int fpga_dmabuf_load(struct fpga_manager *mgr,
> +			    struct fpga_image_info *info)
> +{
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	/* create attachment for dmabuf with the user device */
> +	attach = dma_buf_attach(mgr->dmabuf, &mgr->dev);
> +	if (IS_ERR(attach)) {
> +		pr_err("failed to attach dmabuf\n");
> +		ret = PTR_ERR(attach);
> +		goto fail_put;
> +	}
> +
> +	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto fail_detach;
> +	}
> +
> +	info->sgt = sgt;
> +	ret = fpga_mgr_buf_load_sg(mgr, info, info->sgt);
> +	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
> +
> +fail_detach:
> +	dma_buf_detach(mgr->dmabuf, attach);
> +fail_put:
> +	dma_buf_put(mgr->dmabuf);
> +
> +	return ret;
> +}
> +
>  /**
>   * fpga_mgr_firmware_load - request firmware and load to fpga
>   * @mgr:	fpga manager
> @@ -573,6 +608,8 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
>  {
>  	info->header_size = mgr->mops->initial_header_size;
>  
> +	if (mgr->flags & FPGA_MGR_CONFIG_DMA_BUF)
> +		return fpga_dmabuf_load(mgr, info);

I'm not understanding the whole picture. After the dma-buf has been
imported from userspace, who is supposed to call fpga_mgr_load() or
fpga_region_program_fpga()? And who should load and export the dma-buf
containing the image in the first place?

I think it would be interesting to have a system that buffers a set of
alternative configurations for each (reconfigurable) region. Alternative
configurations could be represented and activated through a sysfs
interface. The user could request a specific configuration by writing in
the corresponding sysfs file, and the system would use the preloaded
image and optionally the overlay to configure the region. What do you
think?

> [...]

Thanks,
Marco


