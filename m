Return-Path: <linux-kernel+bounces-46538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938AF844114
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A31D28FD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA580C08;
	Wed, 31 Jan 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6VBIkFJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFC80BF3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709230; cv=none; b=mY6ENtehTMQKOEGnlbq3kEhGJrWAqwBqAIa8idJBZAPJ5e1Mmms5HCb3cF3Tc8snagcPfWEgncSxnz5ZWoGFHD867iqNp9XGkaZkbaPI+3V2Gr5mgRpRI93Szcl5Jmrlc1it6ltLwmIt/OvzOSc+BouVw/JbTbRyYEVTYqxWUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709230; c=relaxed/simple;
	bh=1fsKiWzD4eBtpYRLLRU5ypafXrjCVp3jRWjh9i+qbLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKhZCD39yL/vqVVNbneOx/WY5gVMjuYyo5zDq/ffGwmilGgbQXgVwmdpSK0dV2lrbcL6qwiQtqUiqV4QFzGXTLmwW4S8xDIHxYDUqymLxj+mPqzqkYygWN8YRN7je4c0NNqopN3C3Tug4S6UvAp6TqktDho6TF68Oj5CajmH3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6VBIkFJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1725265a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706709226; x=1707314026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahOd0DsEgD/5LLUjuJjav5ZXUjQod+q+9a1w7vEMGKU=;
        b=V6VBIkFJ7jSyDUASutomTagEWexNPrxNMyF1x9NJIK0K7Ch5C2QaiEUtNHyTwbda8v
         9aEKPBVSUI4cVyc1T21TQyyByTJz39/mWMqank3uR7J6qhFTL9G6fefuU6TRZiiygFPx
         1DeqtmzE2CDu5wr84FT/fpUmsMLfI+8ZyHMc0CjCKWfUynmfUnn82QHwc7wDi3QpyIXp
         /c1OHhXt9JOA3yBqqxSsQtmLiriVsG0fY5rGEjzXp9Z/TVC3/wf8ikvtPXdfC58Q6HZx
         0mOEkyr5PVHyy6aMlwKB5DU0CIyWi0AoXVPuPc6lPac3mC7NN7zscHubIyakdubQUuLd
         rAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709226; x=1707314026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahOd0DsEgD/5LLUjuJjav5ZXUjQod+q+9a1w7vEMGKU=;
        b=r6GFz7jnGwSIBMtLHq3gK3gxdvbDs+0uZyCTZck91Dk9lR2x0pxMYhbRiVS2nJhW8D
         bO78fggjyMv50i53gg7nzuJala4Lr+V8n5X0pzpTP5eZM189PndrtKKlYz1usU5rZ/Ea
         eyMn9lxDhwiIGwbxUbKxf5ShTyx1W6rJwme4re1GOdUNa6Unu4PeBZRNYFUGnFxbqq6S
         CtKAGadkzDJwrsAictHSfq9j+8oSxgPNeS0e7VYP6njEzaXKJDLjXeh4wnXTlJinmEWG
         sVgD0oPpRVsjziDGb6vTV42fg5R94hOW6CGT6y24Doktgh8ButMCx2u2ut2Nq/jBXNuD
         Yqug==
X-Gm-Message-State: AOJu0YzZROu8yci0Bt/NkCiR/od8noY5xPZJNE8fqJ+Ea543r6714RZI
	fUPA/J8HDkbIbx/fPvnDof/S2FQAIMKjrrV4miH78iZ9pqCbz2W1Xtk5FR9lRBA=
X-Google-Smtp-Source: AGHT+IF/HhYD9uEpTmG0foPvY+xCTXKvk5obu0HsU61MTSjfgdbYBqyNsdDIta+ap8fzjTNneV6ulw==
X-Received: by 2002:a05:6402:26ce:b0:55f:992a:6214 with SMTP id x14-20020a05640226ce00b0055f992a6214mr544647edd.4.1706709226169;
        Wed, 31 Jan 2024 05:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUqIoHU49HCTb1rUovxV2gzF0kNXugLnZJeOYtS/NemWRrh0sE6nRlMpUq+1mJOwWQ4reR3QOaR4C3hI6SS4Kh4wZKVlDJ6uoiKBDU6GaEZZwuVqTSlfqoRX1FVckX34fLfeEqodIdgfqNacwxzO+JYfyzbocr4Tf59DtEwj01giG3YFJYFmtUtcG6AP90iDOC5tTEc867KA+4Emd3CN1m+cq3Dcnp1bMhe39oHkOf2V0jc4Bm3Bv6PK49WOdh4e/icTK6ccAzVCAvXM8v/flwcNq8frmo+e6JZeNhUY6YN1hwSWBx+UtwP0rMZbbaqwrgKeKmjD2tJSVyvIRoB22IZqQSA0oS+sFhSdh38PdbvFu5BAMPHZv/GJMNZp30c6wZ1ADFFk8hz9MQ3y+PNePEmHaVS9CRINxdCNihRo6E4sgFvNybrmAmsC9H269+TZOeVrhCndoEuH72nqlo1ERZTy5ElrRbIMG8cczjx3VcSNQBRpAh1bFq1MgJiK5+nY1mN/UQhps5E330KFEiv7gJSnXi/jK8jB8We7h/tnrp/0t23yaFt41Svs574zOCgtjvdO0u52EcTzEez9PatHNpm5lOxC8qYzIzcVI0R91u1nCmwKpYslmUYln4R7MnjewahTR+IYHmByVBXx0FTdOFqHCMcWcrlN39J5yYs1np2PrPxYyI3DIW1gi3OCDgZNdD5rVHlFc75iXOjasBH7eahPDFLcVx0p6BqqJ2mLLk4NTcoZIP85Zu5wI7g8IBiqrZJcWYGgNwTRryHRWokBw5XBe1BnY+ib53YyThWi+SlQrwBSm9ItKEaslSYUzPrVjWnl0hURKIOdO4Q1NPXPTGQdvnNoeFf6lkeqho5K0m8d5bIh8SAM9gkGTnBDlRsusQAZ8M5GG+Da2YhJoKqVc8P0u+gvHUcFdFxRqRfZjFVyBvK4UT6BKw+xELIa0Q+7Tc6t
 togPTrIj/XhTaCr9NEbPyyavGfIsDRv+PD
Received: from pop-os.localdomain (81-231-61-187-no276.tbcn.telia.com. [81.231.61.187])
        by smtp.gmail.com with ESMTPSA id ec37-20020a0564020d6500b0055f8adf1d6esm465420edb.47.2024.01.31.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:53:45 -0800 (PST)
Date: Wed, 31 Jan 2024 14:53:43 +0100
From: Joakim Bech <joakim.bech@linaro.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, christian.koenig@amd.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>, tjmercier@google.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>,
	Jeffrey Kardatzke <jkardatzke@google.com>,
	Pavel Machek <pavel@ucw.cz>, Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>, jianjiao.zeng@mediatek.com,
	kuohong.wang@mediatek.com, youlin.pei@mediatek.com
Subject: Re: [PATCH v4 3/7] dma-buf: heaps: restricted_heap: Add private heap
 ops
Message-ID: <20240131135343.rj6xlch6zcev2v47@pop-os.localdomain>
References: <20240112092014.23999-1-yong.wu@mediatek.com>
 <20240112092014.23999-4-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240112092014.23999-4-yong.wu@mediatek.com>

On Fri, Jan 12, 2024 at 05:20:10PM +0800, Yong Wu wrote:
> Add "struct restricted_heap_ops". For the restricted memory, totally there
> are two steps:
> a) memory_alloc: Allocate the buffer in kernel;
> b) memory_restrict: Restrict/Protect/Secure that buffer.
> The memory_alloc is mandatory while memory_restrict is optinal since it may
>
s/optinal/optional/

> be part of memory_alloc.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/dma-buf/heaps/restricted_heap.c | 41 ++++++++++++++++++++++++-
>  drivers/dma-buf/heaps/restricted_heap.h | 12 ++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/heaps/restricted_heap.c
> index fd7c82abd42e..8c266a0f6192 100644
> --- a/drivers/dma-buf/heaps/restricted_heap.c
> +++ b/drivers/dma-buf/heaps/restricted_heap.c
> @@ -12,10 +12,44 @@
>  
>  #include "restricted_heap.h"
>  
> +static int
> +restricted_heap_memory_allocate(struct restricted_heap *heap, struct restricted_buffer *buf)
> +{
> +	const struct restricted_heap_ops *ops = heap->ops;
> +	int ret;
> +
> +	ret = ops->memory_alloc(heap, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (ops->memory_restrict) {
> +		ret = ops->memory_restrict(heap, buf);
> +		if (ret)
> +			goto memory_free;
> +	}
> +	return 0;
> +
> +memory_free:
> +	ops->memory_free(heap, buf);
> +	return ret;
> +}
> +
> +static void
> +restricted_heap_memory_free(struct restricted_heap *heap, struct restricted_buffer *buf)
> +{
> +	const struct restricted_heap_ops *ops = heap->ops;
> +
> +	if (ops->memory_unrestrict)
> +		ops->memory_unrestrict(heap, buf);
> +
> +	ops->memory_free(heap, buf);
> +}
> +
>  static struct dma_buf *
>  restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
>  			 unsigned long fd_flags, unsigned long heap_flags)
>  {
> +	struct restricted_heap *restricted_heap = dma_heap_get_drvdata(heap);
>  	struct restricted_buffer *restricted_buf;
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct dma_buf *dmabuf;
> @@ -28,6 +62,9 @@ restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
>  	restricted_buf->size = ALIGN(size, PAGE_SIZE);
>  	restricted_buf->heap = heap;
>  
> +	ret = restricted_heap_memory_allocate(restricted_heap, restricted_buf);
>
Can we guarantee that "restricted_heap" here isn't NULL (i.e., heap->priv). If
not perhaps we should consider adding a check for NULL in the
restricted_heap_memory_allocate() function?

> +	if (ret)
> +		goto err_free_buf;
>  	exp_info.exp_name = dma_heap_get_name(heap);
>  	exp_info.size = restricted_buf->size;
>  	exp_info.flags = fd_flags;
> @@ -36,11 +73,13 @@ restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
>  	dmabuf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dmabuf)) {
>  		ret = PTR_ERR(dmabuf);
> -		goto err_free_buf;
> +		goto err_free_restricted_mem;
>  	}
>  
>  	return dmabuf;
>  
> +err_free_restricted_mem:
> +	restricted_heap_memory_free(restricted_heap, restricted_buf);
>  err_free_buf:
>  	kfree(restricted_buf);
>  	return ERR_PTR(ret);
> diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/heaps/restricted_heap.h
> index 443028f6ba3b..ddeaf9805708 100644
> --- a/drivers/dma-buf/heaps/restricted_heap.h
> +++ b/drivers/dma-buf/heaps/restricted_heap.h
> @@ -15,6 +15,18 @@ struct restricted_buffer {
>  
>  struct restricted_heap {
>  	const char		*name;
> +
> +	const struct restricted_heap_ops *ops;
> +};
> +
> +struct restricted_heap_ops {
>
This have the same name as used for the dma_heap_ops in the file
restricted_heap.c, this might be a little bit confusing, or?

> +	int	(*heap_init)(struct restricted_heap *heap);
> +
> +	int	(*memory_alloc)(struct restricted_heap *heap, struct restricted_buffer *buf);
> +	void	(*memory_free)(struct restricted_heap *heap, struct restricted_buffer *buf);
> +
> +	int	(*memory_restrict)(struct restricted_heap *heap, struct restricted_buffer *buf);
> +	void	(*memory_unrestrict)(struct restricted_heap *heap, struct restricted_buffer *buf);
>
Is the prefix "memory_" superfluous here in these ops?

Also related to a comment on the prior patch. The name here is "heap" for
restricted_heap, but below you use rstrd_heap. It's the same struct, so I would
advise to use the same name to avoid confusion when reading the code. As
mentioned before, I think the name "rheap" would be a good choice.

>  };
>  
>  int restricted_heap_add(struct restricted_heap *rstrd_heap);
> -- 
> 2.25.1
> 

-- 
// Regards
Joakim

