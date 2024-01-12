Return-Path: <linux-kernel+bounces-24493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA1982BD64
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03528286A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3357309;
	Fri, 12 Jan 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NDBTXbaZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1B51C2E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28f12a12e5so180338066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1705052477; x=1705657277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vipcplhMlhbtLQhB0mA3Dqq/xKRhLIIoRd1dJzj/OY=;
        b=NDBTXbaZ5KvhT8GWHP53frf5scYPkdnBhm+5ct9ywna3dZDqt4adA1cjzv+MnJYeFE
         G/pL4ai3iN2jVPFYpajcLwD/dz7xNMggpn/ky+3tXvCMvlJhzFxIecCNV6y/g1o8pEk/
         hX34l96Y9UbovbCC/ERIKHxHCDfFZS/7F/2kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052477; x=1705657277;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vipcplhMlhbtLQhB0mA3Dqq/xKRhLIIoRd1dJzj/OY=;
        b=JHkFE63XOjmmQ1IktY0zxxewF1Xyw0cUleUr/3vlPXhlLStO7GdQMkPmFE16u/SZCb
         KD5mtIAKZnCMdziCsx3MXT3bLFjVyJJWQpXIAAdprU3miFiJ/dxUnmY7cXua9fTBJlYe
         Ndo7EnesI4yfq5YdN9ylxVIAOdanJhnzz1rw8a8Jr7IG0p+rPjPHcT4G/KnRsazm1T2F
         HdDP8Aae7TW769Zi9y72x8JgM4XBlxWVJzI0KaqKrGs81YpCAgsY4SXoSkjlpKMhYDts
         L5bjDnrKmzLAe3nEyrqyQi2YJgD7ky2abgiQ7bCKUVMkOW9d/sQ33KYHrYu0N49ziopN
         Q6Rg==
X-Gm-Message-State: AOJu0Yy//OcxagEBxDXaACWzNMvVmOR88jXo8rtMDzeMANl22Y9khu2c
	sNvN9iSZPUaxdfDeZxf1m+28T6Yc7Sgx5A==
X-Google-Smtp-Source: AGHT+IFUrhEHLoxtmAPHlwzPSqcUm50dU47tJkMYj4SyQG2gZxwrNIyppWWPgxoz02QrYem4DZmo/w==
X-Received: by 2002:a17:907:1b0f:b0:a2c:ea34:5fa5 with SMTP id mp15-20020a1709071b0f00b00a2cea345fa5mr138146ejc.6.1705052476728;
        Fri, 12 Jan 2024 01:41:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906c08400b00a2b10e20292sm1597859ejz.215.2024.01.12.01.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:41:16 -0800 (PST)
Date: Fri, 12 Jan 2024 10:41:14 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, christian.koenig@amd.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>,
	Pavel Machek <pavel@ucw.cz>,
	Jeffrey Kardatzke <jkardatzke@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>,
	jianjiao.zeng@mediatek.com, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	Pekka Paalanen <ppaalanen@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Joakim Bech <joakim.bech@linaro.org>, tjmercier@google.com,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	youlin.pei@mediatek.com, kuohong.wang@mediatek.com,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 4/7] dma-buf: heaps: restricted_heap: Add dma_ops
Message-ID: <ZaEJOjXP2EJIe9rK@phenom.ffwll.local>
Mail-Followup-To: Yong Wu <yong.wu@mediatek.com>,
	Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, christian.koenig@amd.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>,
	Pavel Machek <pavel@ucw.cz>,
	Jeffrey Kardatzke <jkardatzke@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>,
	jianjiao.zeng@mediatek.com, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	Pekka Paalanen <ppaalanen@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Joakim Bech <joakim.bech@linaro.org>, tjmercier@google.com,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	youlin.pei@mediatek.com, kuohong.wang@mediatek.com,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
References: <20240112092014.23999-1-yong.wu@mediatek.com>
 <20240112092014.23999-5-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112092014.23999-5-yong.wu@mediatek.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Fri, Jan 12, 2024 at 05:20:11PM +0800, Yong Wu wrote:
> Add the dma_ops for this restricted heap. For restricted buffer,
> cache_ops/mmap are not allowed, thus return EPERM for them.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/dma-buf/heaps/restricted_heap.c | 103 ++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/heaps/restricted_heap.c
> index 8c266a0f6192..ec4c63d2112d 100644
> --- a/drivers/dma-buf/heaps/restricted_heap.c
> +++ b/drivers/dma-buf/heaps/restricted_heap.c
> @@ -12,6 +12,10 @@
>  
>  #include "restricted_heap.h"
>  
> +struct restricted_heap_attachment {
> +	struct sg_table			*table;
> +};
> +
>  static int
>  restricted_heap_memory_allocate(struct restricted_heap *heap, struct restricted_buffer *buf)
>  {
> @@ -45,6 +49,104 @@ restricted_heap_memory_free(struct restricted_heap *heap, struct restricted_buff
>  	ops->memory_free(heap, buf);
>  }
>  
> +static int restricted_heap_attach(struct dma_buf *dmabuf, struct dma_buf_attachment *attachment)
> +{
> +	struct restricted_buffer *restricted_buf = dmabuf->priv;
> +	struct restricted_heap_attachment *a;
> +	struct sg_table *table;
> +	int ret;
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	table = kzalloc(sizeof(*table), GFP_KERNEL);
> +	if (!table) {
> +		ret = -ENOMEM;
> +		goto err_free_attach;
> +	}
> +
> +	ret = sg_alloc_table(table, 1, GFP_KERNEL);
> +	if (ret)
> +		goto err_free_sgt;
> +	sg_set_page(table->sgl, NULL, restricted_buf->size, 0);

So this is definitely broken and violating the dma-buf api rules. You
cannot let attach succed and supply a dummy/invalid sg table.

Two options:

- Reject ->attach for all this buffers with -EBUSY and provide instead a
  private api for these secure buffers, similar to how virtio_dma_buf has
  private virto-specific apis. This interface would need to be
  standardized across all arm TEE users, so that we don't have a
  disastrous proliferation of apis.

- Allow ->attach, but _only_ for drivers/devices which can access the
  secure buffer correctly, and only if you can put the right secure buffer
  address into the sg table directly. If dma to a secure buffer for a
  given struct device * will not work correctly (i.e. without data
  corruption), you _must_ reject the attach attempt with -EBUSY.

The 2nd approach would be my preferred one, if it's technically possible.

Also my understanding is that arm TEE is standardized, so I think we'll at
least want some acks from other soc people whether this will work for them
too.

Finally the usual drill:
- this also needs the driver side support, if there's any changes needed.
  Just the new heap isn't enough.
- and for drm you need open userspace for this. Doesn't have to be the
  full content protection decode pipeline, the drivers in drm that landed
  secure buffer support thus far enabled it using the
  EGL_EXT_protected_content extension using gl, which side steps all the
  complications around content decryption keys and support

Cheers, Sima

> +
> +	a->table = table;
> +	attachment->priv = a;
> +
> +	return 0;
> +
> +err_free_sgt:
> +	kfree(table);
> +err_free_attach:
> +	kfree(a);
> +	return ret;
> +}
> +
> +static void restricted_heap_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attachment)
> +{
> +	struct restricted_heap_attachment *a = attachment->priv;
> +
> +	sg_free_table(a->table);
> +	kfree(a->table);
> +	kfree(a);
> +}
> +
> +static struct sg_table *
> +restricted_heap_map_dma_buf(struct dma_buf_attachment *attachment, enum dma_data_direction direct)
> +{
> +	struct restricted_heap_attachment *a = attachment->priv;
> +	struct sg_table *table = a->table;
> +
> +	return table;
> +}
> +
> +static void
> +restricted_heap_unmap_dma_buf(struct dma_buf_attachment *attachment, struct sg_table *table,
> +			      enum dma_data_direction direction)
> +{
> +	struct restricted_heap_attachment *a = attachment->priv;
> +
> +	WARN_ON(a->table != table);
> +}
> +
> +static int
> +restricted_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf, enum dma_data_direction direction)
> +{
> +	return -EPERM;
> +}
> +
> +static int
> +restricted_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf, enum dma_data_direction direction)
> +{
> +	return -EPERM;
> +}
> +
> +static int restricted_heap_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	return -EPERM;
> +}
> +
> +static void restricted_heap_free(struct dma_buf *dmabuf)
> +{
> +	struct restricted_buffer *restricted_buf = dmabuf->priv;
> +	struct restricted_heap *heap = dma_heap_get_drvdata(restricted_buf->heap);
> +
> +	restricted_heap_memory_free(heap, restricted_buf);
> +	kfree(restricted_buf);
> +}
> +
> +static const struct dma_buf_ops restricted_heap_buf_ops = {
> +	.attach		= restricted_heap_attach,
> +	.detach		= restricted_heap_detach,
> +	.map_dma_buf	= restricted_heap_map_dma_buf,
> +	.unmap_dma_buf	= restricted_heap_unmap_dma_buf,
> +	.begin_cpu_access = restricted_heap_dma_buf_begin_cpu_access,
> +	.end_cpu_access	= restricted_heap_dma_buf_end_cpu_access,
> +	.mmap		= restricted_heap_dma_buf_mmap,
> +	.release	= restricted_heap_free,
> +};
> +
>  static struct dma_buf *
>  restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
>  			 unsigned long fd_flags, unsigned long heap_flags)
> @@ -66,6 +168,7 @@ restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
>  	if (ret)
>  		goto err_free_buf;
>  	exp_info.exp_name = dma_heap_get_name(heap);
> +	exp_info.ops = &restricted_heap_buf_ops;
>  	exp_info.size = restricted_buf->size;
>  	exp_info.flags = fd_flags;
>  	exp_info.priv = restricted_buf;
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

