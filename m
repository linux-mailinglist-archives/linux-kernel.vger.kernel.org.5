Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C579C05F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbjIKV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbjIKQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:12:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547DCCA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:12:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6515d44b562so30591436d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1694448739; x=1695053539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Fm3Bafxaxq7OSAQ9sLz+uyVn20YSYfcySqL/LZ4QTY=;
        b=xVoNK0QImeLqDCKRcU2xdLyyzVSwQ1SLU0z2IoV3hZPfoWgY4mSAq5oVhrIZQ1iF8m
         V+tN2tVKcrE2bnNbH3EiCAykqcyfNlQEEUri3xHrNKQD7+Gd8DzDHGM2DO4CsCMNGecr
         jVctEEq12U3kCHNsu/I+zRLLIxdnkhh4HyDNncnjTpt96TNoAV6Qu10hlL4g74611e0+
         reikrBecMJT3kiWE6JSxDPO1IUFdRXVQb5k06gO56C9RKegU73kFL1RPkvenXQp/GW3h
         Ju1+ftVUIqVUXZDQ6qUNtrFx5pMalb5+kwQpNlvmZeXCE7QMlkhTj1qc9fOy36khfZxh
         5adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448739; x=1695053539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Fm3Bafxaxq7OSAQ9sLz+uyVn20YSYfcySqL/LZ4QTY=;
        b=MIKX0vRZ8jXOYpslZA32IJDufU6v6CfFZv4fAz/mL5buDDljH07QL5RYNJXXVExsLn
         lufTdWWoHghF65Q3HEznK0n3zTos9tga9snAbnm6CDwWCiWXSAOvJYS0N7wKeVvKkW8z
         um6pEe6TdtcWFqulwaZHg1u9ypZc8YfXfagnM4+EwLzrjBKRl8mfoHLMKqNVcB58d8Fs
         x2eBvmjC6e602qBLsmzhpopPtYyDyIlO694JtP+nQ/K8wbdeB9Wxt+MQh6/jC7UeZmnv
         nvnCyuziH4+TSX5VLbQSwCZWkcXBkAbFOI0KI+zAtkYh83dlc7fLGJDi0VLhmdbDXZ3w
         8Png==
X-Gm-Message-State: AOJu0YzzsmdSlmaQRIyU3xVY0mnBODoTdqX8Ly/m+Durcpdvjbo3t9+I
        hTCFF5A/nkxnODNl8T+7Dr5Dzw==
X-Google-Smtp-Source: AGHT+IHfJzEj3YN+IDLa6c5OoOh5gMCnU53CNkVDYUfVOD27Y4SNqPHEBMqIhlGup6+WHXcBbS4pwQ==
X-Received: by 2002:a05:6214:12da:b0:64f:43b9:fe4c with SMTP id s26-20020a05621412da00b0064f43b9fe4cmr10140146qvv.47.1694448738736;
        Mon, 11 Sep 2023 09:12:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id e12-20020a0ce3cc000000b0063d30c10f1esm3038666qvl.70.2023.09.11.09.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:12:18 -0700 (PDT)
Message-ID: <827b859e3ff8176ef0b18c29bc17481b4105e368.camel@ndufresne.ca>
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel
 drivers can allocate dmabufs from specific heaps
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com
Date:   Mon, 11 Sep 2023 12:12:17 -0400
In-Reply-To: <20230911023038.30649-4-yong.wu@mediatek.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
         <20230911023038.30649-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 11 septembre 2023 =C3=A0 10:30 +0800, Yong Wu a =C3=A9crit=C2=A0:
> From: John Stultz <jstultz@google.com>
>=20
> This allows drivers who don't want to create their own
> DMA-BUF exporter to be able to allocate DMA-BUFs directly
> from existing DMA-BUF Heaps.
>=20
> There is some concern that the premise of DMA-BUF heaps is
> that userland knows better about what type of heap memory
> is needed for a pipeline, so it would likely be best for
> drivers to import and fill DMA-BUFs allocated by userland
> instead of allocating one themselves, but this is still
> up for debate.


Would be nice for the reviewers to provide the information about the user o=
f
this new in-kernel API. I noticed it because I was CCed, but strangely it d=
idn't
make it to the mailing list yet and its not clear in the cover what this is=
 used
with.=20

I can explain in my words though, my read is that this is used to allocate =
both
user visible and driver internal memory segments in MTK VCODEC driver.

I'm somewhat concerned that DMABuf objects are used to abstract secure memo=
ry
allocation from tee. For framebuffers that are going to be exported and sha=
red
its probably fair use, but it seems that internal shared memory and codec
specific reference buffers also endup with a dmabuf fd (often called a secu=
re fd
in the v4l2 patchset) for data that is not being shared, and requires a 1:1
mapping to a tee handle anyway. Is that the design we'd like to follow ? Ca=
n't
we directly allocate from the tee, adding needed helper to make this as sim=
ple
as allocating from a HEAP ?

Nicolas

>=20
> Signed-off-by: John Stultz <jstultz@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [Yong: Fix the checkpatch alignment warning]
> ---
>  drivers/dma-buf/dma-heap.c | 60 ++++++++++++++++++++++++++++----------
>  include/linux/dma-heap.h   | 25 ++++++++++++++++
>  2 files changed, 69 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index dcc0e38c61fa..908bb30dc864 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -53,12 +53,15 @@ static dev_t dma_heap_devt;
>  static struct class *dma_heap_class;
>  static DEFINE_XARRAY_ALLOC(dma_heap_minors);
> =20
> -static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> -				 unsigned int fd_flags,
> -				 unsigned int heap_flags)
> +struct dma_buf *dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				      unsigned int fd_flags,
> +				      unsigned int heap_flags)
>  {
> -	struct dma_buf *dmabuf;
> -	int fd;
> +	if (fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> +		return ERR_PTR(-EINVAL);
> =20
>  	/*
>  	 * Allocations from all heaps have to begin
> @@ -66,9 +69,20 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap=
, size_t len,
>  	 */
>  	len =3D PAGE_ALIGN(len);
>  	if (!len)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
> =20
> -	dmabuf =3D heap->ops->allocate(heap, len, fd_flags, heap_flags);
> +	return heap->ops->allocate(heap, len, fd_flags, heap_flags);
> +}
> +EXPORT_SYMBOL_GPL(dma_heap_buffer_alloc);
> +
> +static int dma_heap_bufferfd_alloc(struct dma_heap *heap, size_t len,
> +				   unsigned int fd_flags,
> +				   unsigned int heap_flags)
> +{
> +	struct dma_buf *dmabuf;
> +	int fd;
> +
> +	dmabuf =3D dma_heap_buffer_alloc(heap, len, fd_flags, heap_flags);
>  	if (IS_ERR(dmabuf))
>  		return PTR_ERR(dmabuf);
> =20
> @@ -106,15 +120,9 @@ static long dma_heap_ioctl_allocate(struct file *fil=
e, void *data)
>  	if (heap_allocation->fd)
>  		return -EINVAL;
> =20
> -	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
> -		return -EINVAL;
> -
> -	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> -		return -EINVAL;
> -
> -	fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> -				   heap_allocation->fd_flags,
> -				   heap_allocation->heap_flags);
> +	fd =3D dma_heap_bufferfd_alloc(heap, heap_allocation->len,
> +				     heap_allocation->fd_flags,
> +				     heap_allocation->heap_flags);
>  	if (fd < 0)
>  		return fd;
> =20
> @@ -205,6 +213,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  {
>  	return heap->name;
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_get_name);
> =20
>  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o)
>  {
> @@ -290,6 +299,24 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
export_info *exp_info)
>  	kfree(heap);
>  	return err_ret;
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_add);
> +
> +struct dma_heap *dma_heap_find(const char *name)
> +{
> +	struct dma_heap *h;
> +
> +	mutex_lock(&heap_list_lock);
> +	list_for_each_entry(h, &heap_list, list) {
> +		if (!strcmp(h->name, name)) {
> +			kref_get(&h->refcount);
> +			mutex_unlock(&heap_list_lock);
> +			return h;
> +		}
> +	}
> +	mutex_unlock(&heap_list_lock);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dma_heap_find);
> =20
>  static void dma_heap_release(struct kref *ref)
>  {
> @@ -315,6 +342,7 @@ void dma_heap_put(struct dma_heap *h)
>  	kref_put(&h->refcount, dma_heap_release);
>  	mutex_unlock(&heap_list_lock);
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_put);
> =20
>  static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
>  {
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> index f3c678892c5c..59e70f6c7a60 100644
> --- a/include/linux/dma-heap.h
> +++ b/include/linux/dma-heap.h
> @@ -64,10 +64,35 @@ const char *dma_heap_get_name(struct dma_heap *heap);
>   */
>  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o);
> =20
> +/**
> + * dma_heap_find - get the heap registered with the specified name
> + * @name: Name of the DMA-Heap to find
> + *
> + * Returns:
> + * The DMA-Heap with the provided name.
> + *
> + * NOTE: DMA-Heaps returned from this function MUST be released using
> + * dma_heap_put() when the user is done to enable the heap to be unloade=
d.
> + */
> +struct dma_heap *dma_heap_find(const char *name);
> +
>  /**
>   * dma_heap_put - drops a reference to a dmabuf heap, potentially freein=
g it
>   * @heap: the heap whose reference count to decrement
>   */
>  void dma_heap_put(struct dma_heap *heap);
> =20
> +/**
> + * dma_heap_buffer_alloc - Allocate dma-buf from a dma_heap
> + * @heap:	DMA-Heap to allocate from
> + * @len:	size to allocate in bytes
> + * @fd_flags:	flags to set on returned dma-buf fd
> + * @heap_flags: flags to pass to the dma heap
> + *
> + * This is for internal dma-buf allocations only. Free returned buffers =
with dma_buf_put().
> + */
> +struct dma_buf *dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				      unsigned int fd_flags,
> +				      unsigned int heap_flags);
> +
>  #endif /* _DMA_HEAPS_H */

