Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4BA79D40D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjILOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjILOuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:50:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F2F1BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:50:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-412091b9035so39097551cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1694530235; x=1695135035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=24gu3xnStbF9tnpQJ0WbAGs3/nJ8XhTOFkMY3d7yv8A=;
        b=uiqtxSGd41W6BSyB5AQR+nLN2s94YmMW3XjmGaHG7bKEPkSqtvif21dFmySilK/CUi
         fP0twwxf2SZddAJ6l4DqTQ+M5EMS+PrBTCqxGwkUmRvR5BilmsrffW+BbzRusgw7S2C/
         Eyf7+Ql5PoUrLfxLBm4qAcXm77mDtQh7cIQHuyPAUdXcOhxGOte3YJg90RraxhI+T8tr
         /1W9df4HnjlIN1jYKFZJXwgPWMQ5gmeI+K+mqYpZAEhZUGkHgX3biJqIWjKprouV1HsQ
         /KtXesz44mAxuabzcTrfVCwoa9JYpcqU+8QQSeJK8GIp+94APCp4uhK93oxMcmKNf+W+
         t+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694530235; x=1695135035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24gu3xnStbF9tnpQJ0WbAGs3/nJ8XhTOFkMY3d7yv8A=;
        b=mScvUy5NlU8yX+DLBug8yKSzPmt9wQwZGZKuww00LC+dZG7vJOwLe2/VGEnDrhIHby
         cvWuX9S3Q1sF+rfOp8hqMfDXUXG0q3rMFdf3vUIVUiLELJMJMMcmj7Uw+BSjINQ0hHCm
         gGpVTyba7BrSwYADE8paGoAkp/RBjNlzmJnuJAoIvHSdhSNwMazZtt8IfXMgqeOtG5ty
         cnMsX5bqCIWWttdji73m7iVpV1CH5q9GMAEs2QaLRXo7gUiAhOa7HchJNeN7t1LYEfk/
         LnyHoEzXhEJXhoAfZUptfLJdMZ2QjdKF8+1/1De4/ywhldLV6Ybe+aQBkQyVsMwEhDmb
         MxGw==
X-Gm-Message-State: AOJu0YzL0xiJs+BOgLTItBwn6UDOWutJv4g1ZJe3eOG9DFpuB1FD53gU
        K+BLJT+e54IkKT0jM3e9EuRbwg==
X-Google-Smtp-Source: AGHT+IHIjqtGsqNdxfUolw+Ala7g5YjJUkbLvkQof93NfZ486WisLxIwvrHg6NzE7241vOgooQYo5w==
X-Received: by 2002:a05:622a:1811:b0:40d:1984:e231 with SMTP id t17-20020a05622a181100b0040d1984e231mr16719179qtc.43.1694530235641;
        Tue, 12 Sep 2023 07:50:35 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id v12-20020ac8578c000000b0040ff6194ef3sm3352524qta.70.2023.09.12.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:50:35 -0700 (PDT)
Message-ID: <bbb5af208d08acfb9c7b45283840be8719c4c4e2.camel@ndufresne.ca>
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel
 drivers can allocate dmabufs from specific heaps
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
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
Date:   Tue, 12 Sep 2023 10:50:34 -0400
In-Reply-To: <803846bc-fd1d-d2ec-2855-456af22c82f8@amd.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
         <20230911023038.30649-4-yong.wu@mediatek.com>
         <803846bc-fd1d-d2ec-2855-456af22c82f8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 11 septembre 2023 =C3=A0 12:13 +0200, Christian K=C3=B6nig a =C3=
=A9crit=C2=A0:
> Am 11.09.23 um 04:30 schrieb Yong Wu:
> > From: John Stultz <jstultz@google.com>
> >=20
> > This allows drivers who don't want to create their own
> > DMA-BUF exporter to be able to allocate DMA-BUFs directly
> > from existing DMA-BUF Heaps.
> >=20
> > There is some concern that the premise of DMA-BUF heaps is
> > that userland knows better about what type of heap memory
> > is needed for a pipeline, so it would likely be best for
> > drivers to import and fill DMA-BUFs allocated by userland
> > instead of allocating one themselves, but this is still
> > up for debate.
>=20
> The main design goal of having DMA-heaps in the first place is to avoid=
=20
> per driver allocation and this is not necessary because userland know=20
> better what type of memory it wants.

If the memory is user visible, yes. When I look at the MTK VCODEC changes, =
this
seems to be used for internal codec state and SHM buffers used to communica=
te
with firmware.

>=20
> The background is rather that we generally want to decouple allocation=
=20
> from having a device driver connection so that we have better chance=20
> that multiple devices can work with the same memory.
>=20
> I once create a prototype which gives userspace a hint which DMA-heap to=
=20
> user for which device:=20
> https://patchwork.kernel.org/project/linux-media/patch/20230123123756.401=
692-2-christian.koenig@amd.com/
>=20
> Problem is that I don't really have time to look into it and maintain=20
> that stuff, but I think from the high level design that is rather the=20
> general direction we should push at.
>=20
> Regards,
> Christian.
>=20
> >=20
> > Signed-off-by: John Stultz <jstultz@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > [Yong: Fix the checkpatch alignment warning]
> > ---
> >   drivers/dma-buf/dma-heap.c | 60 ++++++++++++++++++++++++++++---------=
-
> >   include/linux/dma-heap.h   | 25 ++++++++++++++++
> >   2 files changed, 69 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index dcc0e38c61fa..908bb30dc864 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -53,12 +53,15 @@ static dev_t dma_heap_devt;
> >   static struct class *dma_heap_class;
> >   static DEFINE_XARRAY_ALLOC(dma_heap_minors);
> >  =20
> > -static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > -				 unsigned int fd_flags,
> > -				 unsigned int heap_flags)
> > +struct dma_buf *dma_heap_buffer_alloc(struct dma_heap *heap, size_t le=
n,
> > +				      unsigned int fd_flags,
> > +				      unsigned int heap_flags)
> >   {
> > -	struct dma_buf *dmabuf;
> > -	int fd;
> > +	if (fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> > +		return ERR_PTR(-EINVAL);
> >  =20
> >   	/*
> >   	 * Allocations from all heaps have to begin
> > @@ -66,9 +69,20 @@ static int dma_heap_buffer_alloc(struct dma_heap *he=
ap, size_t len,
> >   	 */
> >   	len =3D PAGE_ALIGN(len);
> >   	if (!len)
> > -		return -EINVAL;
> > +		return ERR_PTR(-EINVAL);
> >  =20
> > -	dmabuf =3D heap->ops->allocate(heap, len, fd_flags, heap_flags);
> > +	return heap->ops->allocate(heap, len, fd_flags, heap_flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dma_heap_buffer_alloc);
> > +
> > +static int dma_heap_bufferfd_alloc(struct dma_heap *heap, size_t len,
> > +				   unsigned int fd_flags,
> > +				   unsigned int heap_flags)
> > +{
> > +	struct dma_buf *dmabuf;
> > +	int fd;
> > +
> > +	dmabuf =3D dma_heap_buffer_alloc(heap, len, fd_flags, heap_flags);
> >   	if (IS_ERR(dmabuf))
> >   		return PTR_ERR(dmabuf);
> >  =20
> > @@ -106,15 +120,9 @@ static long dma_heap_ioctl_allocate(struct file *f=
ile, void *data)
> >   	if (heap_allocation->fd)
> >   		return -EINVAL;
> >  =20
> > -	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
> > -		return -EINVAL;
> > -
> > -	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> > -		return -EINVAL;
> > -
> > -	fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> > -				   heap_allocation->fd_flags,
> > -				   heap_allocation->heap_flags);
> > +	fd =3D dma_heap_bufferfd_alloc(heap, heap_allocation->len,
> > +				     heap_allocation->fd_flags,
> > +				     heap_allocation->heap_flags);
> >   	if (fd < 0)
> >   		return fd;
> >  =20
> > @@ -205,6 +213,7 @@ const char *dma_heap_get_name(struct dma_heap *heap=
)
> >   {
> >   	return heap->name;
> >   }
> > +EXPORT_SYMBOL_GPL(dma_heap_get_name);
> >  =20
> >   struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_=
info)
> >   {
> > @@ -290,6 +299,24 @@ struct dma_heap *dma_heap_add(const struct dma_hea=
p_export_info *exp_info)
> >   	kfree(heap);
> >   	return err_ret;
> >   }
> > +EXPORT_SYMBOL_GPL(dma_heap_add);
> > +
> > +struct dma_heap *dma_heap_find(const char *name)
> > +{
> > +	struct dma_heap *h;
> > +
> > +	mutex_lock(&heap_list_lock);
> > +	list_for_each_entry(h, &heap_list, list) {
> > +		if (!strcmp(h->name, name)) {
> > +			kref_get(&h->refcount);
> > +			mutex_unlock(&heap_list_lock);
> > +			return h;
> > +		}
> > +	}
> > +	mutex_unlock(&heap_list_lock);
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(dma_heap_find);
> >  =20
> >   static void dma_heap_release(struct kref *ref)
> >   {
> > @@ -315,6 +342,7 @@ void dma_heap_put(struct dma_heap *h)
> >   	kref_put(&h->refcount, dma_heap_release);
> >   	mutex_unlock(&heap_list_lock);
> >   }
> > +EXPORT_SYMBOL_GPL(dma_heap_put);
> >  =20
> >   static char *dma_heap_devnode(const struct device *dev, umode_t *mode=
)
> >   {
> > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > index f3c678892c5c..59e70f6c7a60 100644
> > --- a/include/linux/dma-heap.h
> > +++ b/include/linux/dma-heap.h
> > @@ -64,10 +64,35 @@ const char *dma_heap_get_name(struct dma_heap *heap=
);
> >    */
> >   struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_=
info);
> >  =20
> > +/**
> > + * dma_heap_find - get the heap registered with the specified name
> > + * @name: Name of the DMA-Heap to find
> > + *
> > + * Returns:
> > + * The DMA-Heap with the provided name.
> > + *
> > + * NOTE: DMA-Heaps returned from this function MUST be released using
> > + * dma_heap_put() when the user is done to enable the heap to be unloa=
ded.
> > + */
> > +struct dma_heap *dma_heap_find(const char *name);
> > +
> >   /**
> >    * dma_heap_put - drops a reference to a dmabuf heap, potentially fre=
eing it
> >    * @heap: the heap whose reference count to decrement
> >    */
> >   void dma_heap_put(struct dma_heap *heap);
> >  =20
> > +/**
> > + * dma_heap_buffer_alloc - Allocate dma-buf from a dma_heap
> > + * @heap:	DMA-Heap to allocate from
> > + * @len:	size to allocate in bytes
> > + * @fd_flags:	flags to set on returned dma-buf fd
> > + * @heap_flags: flags to pass to the dma heap
> > + *
> > + * This is for internal dma-buf allocations only. Free returned buffer=
s with dma_buf_put().
> > + */
> > +struct dma_buf *dma_heap_buffer_alloc(struct dma_heap *heap, size_t le=
n,
> > +				      unsigned int fd_flags,
> > +				      unsigned int heap_flags);
> > +
> >   #endif /* _DMA_HEAPS_H */
>=20

