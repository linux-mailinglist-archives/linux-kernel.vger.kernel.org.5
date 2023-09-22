Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257797AB902
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjIVSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjIVSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:20:06 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2178A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:19:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81b42a3108so2958806276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695406799; x=1696011599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJEfWMki53C0C9QhqoAya3sbRCJGrb7hvD0oAvB4tgE=;
        b=jo/nEkb9Z1XQ9LOih9S5e/6NYnc5Dizk2QYspjhKTRl0SFKM9otRXR3AYmkSGOeo9K
         bj2xXAEtGg/qBQ0KmT8rXMAV3X2/hJmlLt42SD3Wy48Aoh2X/XJ94QyRoFXG+0pgrJSP
         JkDAygKFp5NG5INLK/VmJyzkMwZ7i2ErDnyNSMhQOzWmhXQIe/RW22vXggOCzv34KPtD
         atBmx0SM8tDhBxxGyHqhdoOD/iXqXqq9bVU30AWr3IxvxnFwWoIT6Qt5m8E1iHzJMKHz
         h85GfZzfT5b8P2ti6dp7KS2nB4dOBElySsZJ88DpVTKbmAbkRtyB+H5GYZuKjFe5axip
         TqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406799; x=1696011599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJEfWMki53C0C9QhqoAya3sbRCJGrb7hvD0oAvB4tgE=;
        b=wYo6gRbKaywXXJtizH2Y1xPgsqJy/gqXOjnvRxrcW/nL63x1kTKmKoi7FsuFbqh7EV
         lJQURqUJByFjMVnN0kdHQJFYEzzDgA0SH35WQFdA5JEw/RXu8xxDl8wZxDLxUcWPYWhp
         eGhHDWOL6DMR4a8fB/EDceWS/jz2YW6SUKoXnOWGvJMYAyOkseYvBliwG8NtWk5n1RQn
         QQzvi67GsCLMHDLV5VKL+KQbRiY5lOQWXya911+tAz3BYmkdi/S8ikk/q9ekPzxm7ACu
         5zueKnamSRq5KsqvQoAScXKsmxHDbnoPIIASNBT8wD5l6uIPyC/Q0ZlFWzsQ+FWugQwx
         GcsA==
X-Gm-Message-State: AOJu0YxlG1a5T8iKeb+YfIflb4tGhNgt8LyHMIa57TXiMNvaItFsgvZ4
        jt8eDLyhnqUTn0wuets423U2a2otEuIFxZCKABjO5w==
X-Google-Smtp-Source: AGHT+IEHQohIXqITSfor/S743Ge1pG10gsNJCzDT+XFRdZSUhjj6xBKLS9Ve3hl88Y+oLZXD7F7ZDyjyqF5lKzjIhh8=
X-Received: by 2002:a25:9205:0:b0:d81:6344:540b with SMTP id
 b5-20020a259205000000b00d816344540bmr65049ybo.45.1695406798515; Fri, 22 Sep
 2023 11:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230911023038.30649-1-yong.wu@mediatek.com> <20230911023038.30649-3-yong.wu@mediatek.com>
 <71c435a6-ba43-5d26-e658-f55bddbb8b98@amd.com>
In-Reply-To: <71c435a6-ba43-5d26-e658-f55bddbb8b98@amd.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 22 Sep 2023 11:19:46 -0700
Message-ID: <CABdmKX1-5ujRRVQHNVMkoC4Ls0mruxE8GCXNavRLyywD7SobOw@mail.gmail.com>
Subject: Re: [PATCH 2/9] dma-heap: Add proper kref handling on dma-buf heaps
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 2:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 11.09.23 um 04:30 schrieb Yong Wu:
> > From: John Stultz <jstultz@google.com>
> >
> > Add proper refcounting on the dma_heap structure.
> > While existing heaps are built-in, we may eventually
> > have heaps loaded from modules, and we'll need to be
> > able to properly handle the references to the heaps
> >
> > Also moves minor tracking into the heap structure so
> > we can properly free things.
>
> This is completely unnecessary, see below.
>
> >
> > Signed-off-by: John Stultz <jstultz@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > [Yong: Just add comment for "minor" and "refcount"]
> > ---
> >   drivers/dma-buf/dma-heap.c | 38 ++++++++++++++++++++++++++++++++++---=
-
> >   include/linux/dma-heap.h   |  6 ++++++
> >   2 files changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 51030f6c9d6e..dcc0e38c61fa 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-heap.h>
> >   #include <linux/err.h>
> > +#include <linux/kref.h>
> >   #include <linux/list.h>
> >   #include <linux/nospec.h>
> >   #include <linux/syscalls.h>
> > @@ -30,6 +31,8 @@
> >    * @heap_devt:              heap device node
> >    * @list:           list head connecting to list of heaps
> >    * @heap_cdev:              heap char device
> > + * @minor:           heap device node minor number
> > + * @refcount:                reference counter for this heap device
> >    *
> >    * Represents a heap of memory from which buffers can be made.
> >    */
> > @@ -40,6 +43,8 @@ struct dma_heap {
> >       dev_t heap_devt;
> >       struct list_head list;
> >       struct cdev heap_cdev;
> > +     int minor;
> > +     struct kref refcount;
> >   };
> >
> >   static LIST_HEAD(heap_list);
> > @@ -205,7 +210,6 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >   {
> >       struct dma_heap *heap, *h, *err_ret;
> >       struct device *dev_ret;
> > -     unsigned int minor;
> >       int ret;
> >
> >       if (!exp_info->name || !strcmp(exp_info->name, "")) {
> > @@ -222,12 +226,13 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> >       if (!heap)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     kref_init(&heap->refcount);
> >       heap->name =3D exp_info->name;
> >       heap->ops =3D exp_info->ops;
> >       heap->priv =3D exp_info->priv;
> >
> >       /* Find unused minor number */
> > -     ret =3D xa_alloc(&dma_heap_minors, &minor, heap,
> > +     ret =3D xa_alloc(&dma_heap_minors, &heap->minor, heap,
> >                      XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
> >       if (ret < 0) {
> >               pr_err("dma_heap: Unable to get minor number for heap\n")=
;
> > @@ -236,7 +241,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >       }
> >
> >       /* Create device */
> > -     heap->heap_devt =3D MKDEV(MAJOR(dma_heap_devt), minor);
> > +     heap->heap_devt =3D MKDEV(MAJOR(dma_heap_devt), heap->minor);
> >
> >       cdev_init(&heap->heap_cdev, &dma_heap_fops);
> >       ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
> > @@ -280,12 +285,37 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> >   err2:
> >       cdev_del(&heap->heap_cdev);
> >   err1:
> > -     xa_erase(&dma_heap_minors, minor);
> > +     xa_erase(&dma_heap_minors, heap->minor);
> >   err0:
> >       kfree(heap);
> >       return err_ret;
> >   }
> >
> > +static void dma_heap_release(struct kref *ref)
> > +{
> > +     struct dma_heap *heap =3D container_of(ref, struct dma_heap, refc=
ount);
> > +
> > +     /* Note, we already holding the heap_list_lock here */
> > +     list_del(&heap->list);
> > +
> > +     device_destroy(dma_heap_class, heap->heap_devt);
> > +     cdev_del(&heap->heap_cdev);
> > +     xa_erase(&dma_heap_minors, heap->minor);
>
> You can just use MINOR(heap->heap_devt) here instead.
>
Got it, thanks.

> > +
> > +     kfree(heap);
> > +}
> > +
> > +void dma_heap_put(struct dma_heap *h)
> > +{
> > +     /*
> > +      * Take the heap_list_lock now to avoid racing with code
> > +      * scanning the list and then taking a kref.
> > +      */
>
> This is usually considered a bad idea since it makes the kref approach
> superfluous.
>
> There are multiple possibilities how handle this, the most common one is
> to use kref_get_unless_zero() in your list traversal code and ignore the
> entry when that fails.
>
> Alternatively you could use kref_put_mutex() instead. This gives you the
> same functionality as this here, but as far as I know it's normally only
> used in a couple of special cases.
>
Ok, I'll move this mutex acquisition to dma_heap_release so that it
guards just the list_del, and change dma_heap_find to use
kref_get_unless_zero. Thanks.

> > +     mutex_lock(&heap_list_lock);
> > +     kref_put(&h->refcount, dma_heap_release);
> > +     mutex_unlock(&heap_list_lock);
> > +}
> > +
> >   static char *dma_heap_devnode(const struct device *dev, umode_t *mode=
)
> >   {
> >       return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
> > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > index c7c29b724ad6..f3c678892c5c 100644
> > --- a/include/linux/dma-heap.h
> > +++ b/include/linux/dma-heap.h
> > @@ -64,4 +64,10 @@ const char *dma_heap_get_name(struct dma_heap *heap)=
;
> >    */
> >   struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_=
info);
> >
> > +/**
> > + * dma_heap_put - drops a reference to a dmabuf heap, potentially free=
ing it
> > + * @heap: the heap whose reference count to decrement
> > + */
>
> Please don't add kerneldoc to the definition, add it to the
> implementation of the function.
>
Will fix.




> Regards,
> Christian.
>
> > +void dma_heap_put(struct dma_heap *heap);
> > +
> >   #endif /* _DMA_HEAPS_H */
>
