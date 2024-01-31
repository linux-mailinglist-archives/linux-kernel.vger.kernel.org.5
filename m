Return-Path: <linux-kernel+bounces-46488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFECB844086
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70905B2D683
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B687D400;
	Wed, 31 Jan 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdgQK+lp"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6987BAFC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707447; cv=none; b=O2fzr49c3y+ts6HI9EkUTTOsy+Ay5IlTKo5xYU8P+9LCuRwOfn2GXQ1mdPzo/iH+q3oay57mmJMj0d7OaO0WnkA3asyHCjwf2efLVSlBzMWUjWT9/+3NwWwKj/Pke+TGOUfStRsETO54+2EBqcbeVPEGGVAJTICjuToNmXS7TG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707447; c=relaxed/simple;
	bh=dyfkhaaGalerYvo8OYQBwEHcVXTNO0xd7s0BMAtU0XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbodE/+CIF/+b8sW+/dqj7dItcFBnV9hP0rHjf2/iVwo3++aoXxEUJIPJHeoWb/bUk2s2Bg+OYznryy7Qwf9PBTXLoz3WYS4i8b9/a4m2l3RntU5fDr/jhFlOQP6Lig3z9VpYyp1teZvHbmM8KR4+gEhQWMh6n53bz4TNAKXkSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdgQK+lp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso4768594a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706707443; x=1707312243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MUD9HTI1e0BY5P2+rcAvV/RfzBprzDJcgshNjTcI5g=;
        b=CdgQK+lpwdsYgodZ6YXku7D81f87J0dm54pprlewPzm7s+0l7gVNxH577oRt82588D
         0Es/Q7h+wl/f1xTLtVYYUJ3mT+U62+DQlOzLAzt6YNOdS1QEmhFQOmvYJARbhIV7z7VN
         pKRfq+WaZ6lyZfYrYlPfAsCZ1M08d4oZci0ICiITnypAu2Wn4RP9qipGjjrSccAmYIAd
         2RaGIAEgA6ExKCHcm2Y3Eo9WqB3zhYOki9Gi2nRjWJoYGppZNcpnLQY+pAp4cxp8UnB4
         sfx4HNkHiKPURbNoNKFXxgBSZIWMih868a/0Zpl+f7gxCiOgC3rZfLQEst02xIoNUgHJ
         W/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707443; x=1707312243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MUD9HTI1e0BY5P2+rcAvV/RfzBprzDJcgshNjTcI5g=;
        b=o7W8lyJ/OhOK3yeR+PHnIHASmDVTqxcy471g58qQWq1jExntbIgB2kijGMLnD5blko
         n/pVgw7+sZqW8bBhc1IiDw2Ke0CrKdWKq+C2a/W3KM8lj7nUOdK/wMGez/68EYpGpOEn
         MOJBj57CM2hi1ONmtll+bQxJ3b65w+wBgbS9bpPdAGIlBPdUa7/aB64w1kgPEaRHNm0Q
         4AcTT7wtqpIDpd4/zVuwORkhsDDIYiphUrO8vIoTsPR1SARYZC3mmUQ1CzDjS03DIhmi
         RhTQoyx5zGnoB1u3xSawIGtgijoUhO59lMwzplVyigmhA6M9976CaQIqeBwcMMfynzc9
         TE2w==
X-Gm-Message-State: AOJu0YxWuN+9zqhWFEvPiwzZCH9s22G5H7VnznCnTprzCoGtYL9klFc1
	TrtagXBkApPT923fsIUq9fTVO8sXEH/DsaesTUCJYrele108A+9Hls19sdjmqjQ=
X-Google-Smtp-Source: AGHT+IGsArhQ0W4XwCtuYHmCXvO2RCbEUYwLVnXG7bbJ2f+RWm7qp6uth4/WrrGNVLWi0nMCiDAGlA==
X-Received: by 2002:a05:6402:5213:b0:55f:7fe9:c567 with SMTP id s19-20020a056402521300b0055f7fe9c567mr1328202edd.1.1706707443454;
        Wed, 31 Jan 2024 05:24:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXAPb1qAxujL6HdXhhSE+sVLYyv05T+1t6zsGllhHznYzX/PMaaMWlWlwdKflV/rE2cW6o74D6P5/MgaRBL50x8hpKC6rdV3SXCT9jg9Ji7TUTPz1pNeBhWMlWC+IfLrPd0B2vhwyNDuizmS32810JX3sqf5JT7V+AQ99g6Rel+10bREe21Sb5EO1A/Omzzjn3QIfCT/mujA2BEUIiu1zZv+0CqUv1MaxkOh7cqm9rocuXEHmjyBszU0xvEJlv0mjNYLCS1XoDJxpzUAq/rfM/zz5jpOFPEGrdjrd9xf/22brANqKdr5Qe7xJD4RBSiEgBrJJf/AkA4q95VBK8PXrnB0jaX78Q7eDv8e+05u79LxxjkpSzKapxDjRADUQkvVUGL4Bo/Fj0g6gCjTSX4jQxfKFGNVzoFUx5kWAFx1+ygTUek7Rz2OKpqQXwb937CLkXtvDD2DA7yqDKv1A+/fqrKg8HBoUNNJECbkjLwH8g99VV5sbLqL0YhV3CLc4Xcu7CMQMVNnwPCTGD4XqyeQSQ8hrz1YCxpBWplY+sPHVREe6iy1/GkJs/OwqCglwcC7CFTSolo9DSTLmRDrk1UhGOFe31qbec+gOCKSWxxr4s6abJlSI8f+navK+6YHoPncMiXIizZv3QIiI1Z4891Tkb4pYAedqs2PA0AE1Wv9C7i3ka9bfYsDX09/hNrgQkhQ1xjUVADtWzUmG0UrwpYOJEmhjfGBkgglntxHOt+hgbn4N4VuA1QdBjYw1CU8N7CJzmVLwtLZaliIjELEvthoIM2ibY5DXpSs5qu9XM59tf609gL0qEP4IFy3iwMydPTmAqogjjmV03dipumTSNdoFHa55YPC2eQ3OyH5nA5YOEQrE4ElC5koxoXVb43SA5OoTdRfnAD93eKIz+BlAAfzx/hqxYe+pKpm1gX8Qh3wS2YqK9fF05r6BlYh117YgypN339P3
 9xHWP4A+bTltjSuhLbMpZNEOGvejoeqZB4
Received: from pop-os.localdomain (81-231-61-187-no276.tbcn.telia.com. [81.231.61.187])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0055eeb5f0efcsm3641516edb.58.2024.01.31.05.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:24:02 -0800 (PST)
Date: Wed, 31 Jan 2024 14:24:00 +0100
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
Subject: Re: [PATCH v4 2/7] dma-buf: heaps: Initialize a restricted heap
Message-ID: <20240131132400.h3hklvnjjp3pelqz@pop-os.localdomain>
References: <20240112092014.23999-1-yong.wu@mediatek.com>
 <20240112092014.23999-3-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240112092014.23999-3-yong.wu@mediatek.com>

On Fri, Jan 12, 2024 at 05:20:09PM +0800, Yong Wu wrote:
> Initialize a restricted heap. Currently just add a null heap, Prepare for
> the later patches.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/dma-buf/heaps/Kconfig           |  9 ++++
>  drivers/dma-buf/heaps/Makefile          |  3 +-
>  drivers/dma-buf/heaps/restricted_heap.c | 67 +++++++++++++++++++++++++
>  drivers/dma-buf/heaps/restricted_heap.h | 22 ++++++++
>  4 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap.c
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap.h
> 
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index a5eef06c4226..e54506f480ea 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -12,3 +12,12 @@ config DMABUF_HEAPS_CMA
>  	  Choose this option to enable dma-buf CMA heap. This heap is backed
>  	  by the Contiguous Memory Allocator (CMA). If your system has these
>  	  regions, you should say Y here.
> +
> +config DMABUF_HEAPS_RESTRICTED
> +	bool "DMA-BUF Restricted Heap"
> +	depends on DMABUF_HEAPS
> +	help
> +	  Choose this option to enable dma-buf restricted heap. The purpose of this
> +	  heap is to manage buffers that are inaccessible to the kernel and user space.
> +	  There may be several ways to restrict it, for example it may be encrypted or
> +	  protected by a TEE or hypervisor. If in doubt, say N.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> index 974467791032..a2437c1817e2 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
> +obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED)	+= restricted_heap.o
> +obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
> diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/heaps/restricted_heap.c
> new file mode 100644
> index 000000000000..fd7c82abd42e
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/restricted_heap.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF restricted heap exporter
> + *
> + * Copyright (C) 2024 MediaTek Inc.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include "restricted_heap.h"
> +
> +static struct dma_buf *
> +restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
> +			 unsigned long fd_flags, unsigned long heap_flags)
> +{
> +	struct restricted_buffer *restricted_buf;
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	restricted_buf = kzalloc(sizeof(*restricted_buf), GFP_KERNEL);
> +	if (!restricted_buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	restricted_buf->size = ALIGN(size, PAGE_SIZE);
> +	restricted_buf->heap = heap;
> +
> +	exp_info.exp_name = dma_heap_get_name(heap);
> +	exp_info.size = restricted_buf->size;
> +	exp_info.flags = fd_flags;
> +	exp_info.priv = restricted_buf;
> +
> +	dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto err_free_buf;
> +	}
> +
> +	return dmabuf;
> +
> +err_free_buf:
> +	kfree(restricted_buf);
> +	return ERR_PTR(ret);
> +}
> +
> +static const struct dma_heap_ops restricted_heap_ops = {
> +	.allocate = restricted_heap_allocate,
> +};
> +
> +int restricted_heap_add(struct restricted_heap *rstrd_heap)
>
Nothing wrong, but what about shortening rstrd_heap throughout the patch
set to "rheap", I would find that easier to read.

> +{
> +	struct dma_heap_export_info exp_info;
> +	struct dma_heap *heap;
> +
> +	exp_info.name = rstrd_heap->name;
> +	exp_info.ops = &restricted_heap_ops;
> +	exp_info.priv = (void *)rstrd_heap;
> +
> +	heap = dma_heap_add(&exp_info);
> +	if (IS_ERR(heap))
> +		return PTR_ERR(heap);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(restricted_heap_add);
> diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/heaps/restricted_heap.h
> new file mode 100644
> index 000000000000..443028f6ba3b
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/restricted_heap.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Restricted heap Header.
> + *
> + * Copyright (C) 2024 MediaTek, Inc.
> + */
> +
> +#ifndef _DMABUF_RESTRICTED_HEAP_H_
> +#define _DMABUF_RESTRICTED_HEAP_H_
> +
> +struct restricted_buffer {
> +	struct dma_heap		*heap;
> +	size_t			size;
> +};
> +
> +struct restricted_heap {
> +	const char		*name;
> +};
> +
> +int restricted_heap_add(struct restricted_heap *rstrd_heap);
> +
> +#endif
> -- 
> 2.25.1
> 

-- 
// Regards
Joakim

