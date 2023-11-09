Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B37E6394
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjKIGMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:12:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65626A0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 22:12:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9becde9ea7bso335596766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699510356; x=1700115156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhQRJ2tsdSmsbr+tWtWTDDJ49tF/bwf8rgyCxeQj0go=;
        b=AIr8K5BWsSR/hGrBjtvIg5M5pRdEicyj1ZyWWKY+hYoq7Bb+YTim+Hyk+tNzIXFE/e
         uRLi7ilpWYdHMRMPs2pSeGSZpmkNaSKFCb3ZtHTUhruZdbRbn0/5tXTYQRsuIeKuiipQ
         5fzBKw55UgmLT8agASLeOdVKPhoDEwe908Csk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699510356; x=1700115156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhQRJ2tsdSmsbr+tWtWTDDJ49tF/bwf8rgyCxeQj0go=;
        b=CimC17oDxmvTPHWmF6ad5cHDCzm8HACkxYrQkARdBfuBWJgVDZbzMi6rox9FqV2OkH
         7UyvgzU5KllOTdPOgwhELWS8StA0cKqOB041LlruUxTtg/4FXe++boRujNRNAczypsL6
         GUysQkwkEOO8obvQSlatTLsHQWa/bMWEtQ50iXXVnBimkx+mfuPBmvqAYbbVAZofh6nm
         Aux7Cchs6OWC80WqJfEddP5RzVA/Qg5q5YwgYS6aPAhoQFMrUgmPmu1pFnUOtBtqXuJz
         NzTaorbOg0pnC27oQC9ujmGXM3ltGcGDCjV9riF5m009jp5eF1CQXrZuSEM92x2KZlp2
         9xlA==
X-Gm-Message-State: AOJu0YyCuGn8lP40SP2rg3rTQRqBWmS03vGi6fyzXyhoxYn+/t0ciVdY
        LFVd9/W/wKA5gQW45Vi+BiVhgKH7aThJBLsAL4otHUWg
X-Google-Smtp-Source: AGHT+IHtNu974+ShhD7S5WHd3QV1l/tX3eg++Fs+QB9Ypa7Kz27TzGGULqrX0+34EE7oOxEwRrX/GA==
X-Received: by 2002:a17:906:7498:b0:9a1:8993:9532 with SMTP id e24-20020a170906749800b009a189939532mr7589599ejl.30.1699510356458;
        Wed, 08 Nov 2023 22:12:36 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id f14-20020a05640214ce00b0053db0df6970sm7599972edx.54.2023.11.08.22.12.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 22:12:36 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso1083297a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 22:12:36 -0800 (PST)
X-Received: by 2002:a5d:648c:0:b0:32f:86e7:9bef with SMTP id
 o12-20020a5d648c000000b0032f86e79befmr5265032wri.8.1699509967695; Wed, 08 Nov
 2023 22:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20231106143940.324020-1-benjamin.gaignard@collabora.com>
 <20231108102444.4yp7y7mgsociy725@chromium.org> <1da380ce-aef9-4ed2-9581-21301833d556@collabora.com>
In-Reply-To: <1da380ce-aef9-4ed2-9581-21301833d556@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 9 Nov 2023 15:05:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDpqZc41qKF_6mzOF3YAR_c6swisVDNSjapRFxHz2s9Q@mail.gmail.com>
Message-ID: <CAAFQd5DDpqZc41qKF_6mzOF3YAR_c6swisVDNSjapRFxHz2s9Q@mail.gmail.com>
Subject: Re: [PATCH v14.1] media: videobuf2: Be more flexible on the number of
 queue stored buffers
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 10:56=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 08/11/2023 =C3=A0 11:24, Tomasz Figa a =C3=A9crit :
> > On Mon, Nov 06, 2023 at 03:39:40PM +0100, Benjamin Gaignard wrote:
> >> Add 'max_num_buffers' field in vb2_queue struct to let drivers decide
> >> how many buffers could be stored in a queue.
> >> This require 'bufs' array to be allocated at queue init time and freed
> >> when releasing the queue.
> >> By default VB2_MAX_FRAME remains the limit.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >> ---
> >> version 14.1:
> >> - Do not change the number of freed buffers in vb2_core_queue_release(=
).
> >>
> >>   .../media/common/videobuf2/videobuf2-core.c   | 39 +++++++++++++++--=
--
> >>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +--
> >>   include/media/videobuf2-core.h                | 10 ++++-
> >>   3 files changed, 43 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers=
/media/common/videobuf2/videobuf2-core.c
> >> index c5c5ae4d213d..5711c6a130fd 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >> @@ -416,7 +416,7 @@ static void init_buffer_cache_hints(struct vb2_que=
ue *q, struct vb2_buffer *vb)
> >>    */
> >>   static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buf=
fer *vb, unsigned int index)
> >>   {
> >> -    WARN_ON(index >=3D VB2_MAX_FRAME || q->bufs[index]);
> >> +    WARN_ON(index >=3D q->max_num_buffers || q->bufs[index]);
> >>
> >>      q->bufs[index] =3D vb;
> >>      vb->index =3D index;
> >> @@ -449,9 +449,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, =
enum vb2_memory memory,
> >>      struct vb2_buffer *vb;
> >>      int ret;
> >>
> >> -    /* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME =
*/
> >> +    /* Ensure that the number of already queue + num_buffers is below=
 q->max_num_buffers */
> > Perhaps "the number of buffers already in the queue"?
>
> I will do that in the next version.
>
> >
> >>      num_buffers =3D min_t(unsigned int, num_buffers,
> >> -                        VB2_MAX_FRAME - q_num_buffers);
> >> +                        q->max_num_buffers - q_num_buffers);
> >>
> >>      for (buffer =3D 0; buffer < num_buffers; ++buffer) {
> >>              /* Allocate vb2 buffer structures */
> >> @@ -813,7 +813,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2=
_memory memory,
> >>      unsigned plane_sizes[VB2_MAX_PLANES] =3D { };
> >>      bool non_coherent_mem =3D flags & V4L2_MEMORY_FLAG_NON_COHERENT;
> >>      unsigned int i;
> >> -    int ret;
> >> +    int ret =3D 0;
> >>
> >>      if (q->streaming) {
> >>              dprintk(q, 1, "streaming active\n");
> >> @@ -857,17 +857,22 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum v=
b2_memory memory,
> >>      /*
> >>       * Make sure the requested values and current defaults are sane.
> >>       */
> >> -    WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
> > Do we really want to remove this warning completely?
>
> Yes because VB2_MAX_FRAME is no more relevant.

Hmm, but we still have q->max_num_buffers. Although given your reply
to my other comment below, we may be able to just ensure the value is
valid in vb2_core_queue_init().

>
> >
> >>      num_buffers =3D max_t(unsigned int, *count, q->min_buffers_needed=
);
> >> -    num_buffers =3D min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
> >> +    num_buffers =3D min_t(unsigned int, num_buffers, q->max_num_buffe=
rs);
> >>      memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
> >>      /*
> >>       * Set this now to ensure that drivers see the correct q->memory =
value
> >>       * in the queue_setup op.
> >>       */
> >>      mutex_lock(&q->mmap_lock);
> >> +    if (!q->bufs)
> >> +            q->bufs =3D kcalloc(q->max_num_buffers, sizeof(*q->bufs),=
 GFP_KERNEL);
> > Shouldn't this happen in core code rather than the v4l2-specific ioctl
> > helper? Since we just allocate the maximum possible size, then maybe
> > vb2_core_queue_init()?
>
> Hans had already suggest that in a previous version but it appear that
> vb2_core_queue_init() and vb2_core_queue_release() aren't balanced so
> we got cases where queue aren't initialized before reqbufs or create_bufs
> that why I had to put this allocation here.

How about __vb2_queue_alloc()?

>
> >
> >> +    if (!q->bufs)
> >> +            ret =3D -ENOMEM;
> >>      q->memory =3D memory;
> >>      mutex_unlock(&q->mmap_lock);
> >> +    if (ret)
> >> +            return ret;
> >>      set_queue_coherency(q, non_coherent_mem);
> >>
> >>      /*
> >> @@ -976,7 +981,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum=
 vb2_memory memory,
> >>      bool no_previous_buffers =3D !q_num_bufs;
> >>      int ret =3D 0;
> >>
> >> -    if (q_num_bufs =3D=3D VB2_MAX_FRAME) {
> >> +    if (q->num_buffers =3D=3D q->max_num_buffers) {
> >>              dprintk(q, 1, "maximum number of buffers already allocate=
d\n");
> >>              return -ENOBUFS;
> >>      }
> >> @@ -993,7 +998,13 @@ int vb2_core_create_bufs(struct vb2_queue *q, enu=
m vb2_memory memory,
> >>               */
> >>              mutex_lock(&q->mmap_lock);
> >>              q->memory =3D memory;
> >> +            if (!q->bufs)
> >> +                    q->bufs =3D kcalloc(q->max_num_buffers, sizeof(*q=
->bufs), GFP_KERNEL);
> > Ditto.
> >
> >> +            if (!q->bufs)
> >> +                    ret =3D -ENOMEM;
> >>              mutex_unlock(&q->mmap_lock);
> >> +            if (ret)
> >> +                    return ret;
> >>              q->waiting_for_buffers =3D !q->is_output;
> >>              set_queue_coherency(q, non_coherent_mem);
> >>      } else {
> >> @@ -1005,7 +1016,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, en=
um vb2_memory memory,
> >>                      return -EINVAL;
> >>      }
> >>
> >> -    num_buffers =3D min(*count, VB2_MAX_FRAME - q_num_bufs);
> >> +    num_buffers =3D min(*count, q->max_num_buffers - q_num_bufs);
> >>
> >>      if (requested_planes && requested_sizes) {
> >>              num_planes =3D requested_planes;
> >> @@ -2465,6 +2476,12 @@ int vb2_core_queue_init(struct vb2_queue *q)
> >>      /*
> >>       * Sanity check
> >>       */
> >> +    if (!q->max_num_buffers)
> >> +            q->max_num_buffers =3D VB2_MAX_FRAME;
> > Can we add a comment here to explain that this is for backwards
> > compatibility with drivers which don't support more buffers?
> >
> > Actually, we should probably document in kerneldoc for vb2_queue that 0=
 is
> > an allowed and special value.
>
> I will do that.
>
> >
> >> +
> >> +    /* The maximum is limited by offset cookie encoding pattern */
> >> +    q->max_num_buffers =3D min_t(unsigned int, q->max_num_buffers, MA=
X_BUFFER_INDEX);
> >> +
> >>      if (WARN_ON(!q)                   ||
> >>          WARN_ON(!q->ops)              ||
> >>          WARN_ON(!q->mem_ops)          ||
> >> @@ -2474,6 +2491,10 @@ int vb2_core_queue_init(struct vb2_queue *q)
> >>          WARN_ON(!q->ops->buf_queue))
> >>              return -EINVAL;
> >>
> >> +    if (WARN_ON(q->max_num_buffers > MAX_BUFFER_INDEX) ||
> > Hmm, how is this possible?
>
> MAX_BUFFER_INDEX depends on PAGE_SHIFT and, on some architectures,
> it can goes up to 15. In this MAX_BUFFER_INDEX is only equal to 512,
> that why this check in needed.
>
> >
> >> +        WARN_ON(q->min_buffers_needed > q->max_num_buffers))
> >> +            return -EINVAL;
> > I have a loose recollection that it's allowed for a driver to change th=
is
> > value depending on the configuration. You may want to double check if a=
ny
> > driver doesn't do so already if we want to disallow that. (and also
> > document that it's not allowed)
>
> I don't think any driver change is value given the configuration but Hans=
 wants
> to clarify the usage of this field on another series.
>

Okay, thanks.

> >
> >> +
> >>      if (WARN_ON(q->requires_requests && !q->supports_requests))
> >>              return -EINVAL;
> >>
> >> @@ -2520,6 +2541,8 @@ void vb2_core_queue_release(struct vb2_queue *q)
> >>      __vb2_queue_cancel(q);
> >>      mutex_lock(&q->mmap_lock);
> >>      __vb2_queue_free(q, vb2_get_num_buffers(q));
> >> +    kfree(q->bufs);
> >> +    q->bufs =3D NULL;
> >>      q->num_buffers =3D 0;
> >>      mutex_unlock(&q->mmap_lock);
> >>   }
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers=
/media/common/videobuf2/videobuf2-v4l2.c
> >> index 7d798fb15c0b..f3cf4b235c1f 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >> @@ -627,7 +627,7 @@ struct vb2_buffer *vb2_find_buffer(struct vb2_queu=
e *q, u64 timestamp)
> >>       * This loop doesn't scale if there is a really large number of b=
uffers.
> >>       * Maybe something more efficient will be needed in this case.
> >>       */
> >> -    for (i =3D 0; i < vb2_get_num_buffers(q); i++) {
> >> +    for (i =3D 0; i < q->max_num_buffers; i++) {
> >>              vb2 =3D vb2_get_buffer(q, i);
> >>
> >>              if (!vb2)
> >> @@ -1142,7 +1142,7 @@ int _vb2_fop_release(struct file *file, struct m=
utex *lock)
> >>
> >>      if (lock)
> >>              mutex_lock(lock);
> >> -    if (file->private_data =3D=3D vdev->queue->owner) {
> >> +    if (!vdev->queue->owner || file->private_data =3D=3D vdev->queue-=
>owner) {
> >>              vb2_queue_release(vdev->queue);
> >>              vdev->queue->owner =3D NULL;
> >>      }
> >> @@ -1270,7 +1270,7 @@ void vb2_video_unregister_device(struct video_de=
vice *vdev)
> >>       */
> >>      get_device(&vdev->dev);
> >>      video_unregister_device(vdev);
> >> -    if (vdev->queue && vdev->queue->owner) {
> >> +    if (vdev->queue) {
> >>              struct mutex *lock =3D vdev->queue->lock ?
> >>                      vdev->queue->lock : vdev->lock;
> >>
> >> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-=
core.h
> >> index 8f9d9e4af5b1..e77a397195f2 100644
> >> --- a/include/media/videobuf2-core.h
> >> +++ b/include/media/videobuf2-core.h
> >> @@ -558,6 +558,7 @@ struct vb2_buf_ops {
> >>    * @dma_dir:       DMA mapping direction.
> >>    * @bufs:  videobuf2 buffer structures
> >>    * @num_buffers: number of allocated/used buffers
> >> + * @max_num_buffers: upper limit of number of allocated/used buffers
> >>    * @queued_list: list of buffers currently queued from userspace
> >>    * @queued_count: number of buffers queued and ready for streaming.
> >>    * @owned_by_drv_count: number of buffers owned by the driver
> >> @@ -619,8 +620,9 @@ struct vb2_queue {
> >>      struct mutex                    mmap_lock;
> >>      unsigned int                    memory;
> >>      enum dma_data_direction         dma_dir;
> >> -    struct vb2_buffer               *bufs[VB2_MAX_FRAME];
> >> +    struct vb2_buffer               **bufs;
> >>      unsigned int                    num_buffers;
> >> +    unsigned int                    max_num_buffers;
> >>
> >>      struct list_head                queued_list;
> >>      unsigned int                    queued_count;
> >> @@ -1248,6 +1250,12 @@ static inline void vb2_clear_last_buffer_dequeu=
ed(struct vb2_queue *q)
> >>   static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
> >>                                              unsigned int index)
> >>   {
> >> +    if (!q->bufs)
> >> +            return NULL;
> >> +
> >> +    if (index >=3D q->max_num_buffers)
> > Wouldn't this be already prevented by the condition below?
>
> yes but the series will remove q->num_buffers after this patch
> so for me it make sense to introduce this check now.
>

Yeah, I realized it later. Thanks.

Best regards,
Tomasz
