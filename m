Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C1C7E7FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjKJSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjKJR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB4DAF96
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:05:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c5249d55so2535129e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699607137; x=1700211937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m94eBI6bYBpkxdqoKn9i809EPBzgPCcT6b/n5iRJ8W0=;
        b=CwsfA5z/ei/zVZ0r2To+bFlqxo4ZtHhnkG0PLmko260j+KwiqvgWwp6xrOGYwmazUy
         daxXilQ/CPYZPKY06DbvmsirS/SWTrmtQNkyb4lbojtJ/QGXPlgHQmrNnR28JSgl6oLh
         fNTRjNU9ETcewYshtPlhZLOpqapGuo9c5HXhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607137; x=1700211937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m94eBI6bYBpkxdqoKn9i809EPBzgPCcT6b/n5iRJ8W0=;
        b=ogSVmwKNnISvLgmNJBbOu35Mw9aY593LrdhX7bgXUWUqCUYg0ggpRzWj/JeD0WKC/D
         wKFCPczVd7zKgWnrfFJiLMv+zLPcBv9/HwY8sS8Lv+Q963jhokg42spXd00RsQAYtzvx
         4wCRERnUPNif9TKQZWy2JLngVq9y0xiIuZniHySq8tWdeUIFa4v9RWzFQbLRF5K9Ypy9
         d6ghkBU/ij8Ucby/DFPIEiGBaKAv2Ki46fnnWrQkG2ptYh9Gw+t5u82++EyQ6GCiVOQE
         KtrLoR4oavobnXdYt5/G6Futaj2h/FPoVsu819hyjTBb+VAEDku0tlu/CVxMLFRX+GDR
         oABQ==
X-Gm-Message-State: AOJu0YwokOcUOXGyozG2/8l5U3+SuO36igaaIwCvDDkTs2FP6rTgXtzS
        z9nINmfobLgt3Cb+wuND6jEblyTAQ7nE12IUMJSTBg25
X-Google-Smtp-Source: AGHT+IHdVLZ46/Hm66mDoXEqycJ7T9V1AIh0s/R1N7E6PQFBX3yezWEdcAdsHXE1o+BelLLlOZHjKg==
X-Received: by 2002:ac2:410a:0:b0:509:8e86:909e with SMTP id b10-20020ac2410a000000b005098e86909emr3400950lfi.43.1699607136964;
        Fri, 10 Nov 2023 01:05:36 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y25-20020a0565123f1900b00501ce0cacb6sm1312928lfa.188.2023.11.10.01.05.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 01:05:36 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso22524181fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:05:36 -0800 (PST)
X-Received: by 2002:a5d:6c63:0:b0:32d:9fdc:a136 with SMTP id
 r3-20020a5d6c63000000b0032d9fdca136mr5837194wrz.11.1699606707000; Fri, 10 Nov
 2023 00:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-55-benjamin.gaignard@collabora.com>
 <20231109093045.ucitckitlgjj3kyw@chromium.org> <18ee19cc-e97b-4a5a-af7d-1e1bf7c91bc0@collabora.com>
In-Reply-To: <18ee19cc-e97b-4a5a-af7d-1e1bf7c91bc0@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 10 Nov 2023 17:58:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CSNbOsefMca-CXCSWrXy+3TqVRMZsUanJqJ7Mp4AK-2g@mail.gmail.com>
Message-ID: <CAAFQd5CSNbOsefMca-CXCSWrXy+3TqVRMZsUanJqJ7Mp4AK-2g@mail.gmail.com>
Subject: Re: [PATCH v14 54/56] media: v4l2: Add DELETE_BUFS ioctl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 7:10=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 09/11/2023 =C3=A0 10:30, Tomasz Figa a =C3=A9crit :
> > On Tue, Oct 31, 2023 at 05:31:02PM +0100, Benjamin Gaignard wrote:
> >> VIDIOC_DELETE_BUFS ioctl allows to delete buffers from a queue.
> >> The number of buffers to delete in given by count field of
> >> struct v4l2_delete_buffers and the range start at the index
> >> specified in the same structure.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> ---
> >>   .../userspace-api/media/v4l/user-func.rst     |  1 +
> >>   .../media/v4l/vidioc-delete-bufs.rst          | 80 +++++++++++++++++=
++
> >>   .../media/v4l/vidioc-reqbufs.rst              |  1 +
> >>   .../media/common/videobuf2/videobuf2-core.c   | 30 +++++++
> >>   .../media/common/videobuf2/videobuf2-v4l2.c   | 20 +++++
> >>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
> >>   drivers/media/v4l2-core/v4l2-ioctl.c          | 17 ++++
> >>   include/media/v4l2-ioctl.h                    |  4 +
> >>   include/media/videobuf2-core.h                | 12 +++
> >>   include/media/videobuf2-v4l2.h                | 13 +++
> >>   include/uapi/linux/videodev2.h                | 17 ++++
> >>   11 files changed, 196 insertions(+)
> >>   create mode 100644 Documentation/userspace-api/media/v4l/vidioc-dele=
te-bufs.rst
> >>
> >> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Doc=
umentation/userspace-api/media/v4l/user-func.rst
> >> index 15ff0bf7bbe6..3fd567695477 100644
> >> --- a/Documentation/userspace-api/media/v4l/user-func.rst
> >> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
> >> @@ -17,6 +17,7 @@ Function Reference
> >>       vidioc-dbg-g-chip-info
> >>       vidioc-dbg-g-register
> >>       vidioc-decoder-cmd
> >> +    vidioc-delete-bufs
> >>       vidioc-dqevent
> >>       vidioc-dv-timings-cap
> >>       vidioc-encoder-cmd
> >> diff --git a/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.=
rst b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
> >> new file mode 100644
> >> index 000000000000..4791df1395d6
> >> --- /dev/null
> >> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
> >> @@ -0,0 +1,80 @@
> >> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> >> +.. c:namespace:: V4L
> >> +
> >> +.. _VIDIOC_DELETE_BUFS:
> >> +
> >> +************************
> >> +ioctl VIDIOC_DELETE_BUFS
> >> +************************
> >> +
> >> +Name
> >> +=3D=3D=3D=3D
> >> +
> >> +VIDIOC_DELETE_BUFS - Deletes buffers from a queue
> >> +Drivers using this feature must expose the ``V4L2_BUF_CAP_SUPPORTS_DE=
LETE_BUFS``
> >> +capability on the queue :c:func:`VIDIOC_REQBUFS` or :c:func:`VIDIOC_C=
REATE_BUFS`
> >> +are invoked.
> >> +
> >> +Synopsis
> >> +=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +.. c:macro:: VIDIOC_DELETE_BUFs
> >> +
> >> +``int ioctl(int fd, VIDIOC_DELETE_BUFs, struct v4l2_delete_buffers *a=
rgp)``
> >> +
> >> +Arguments
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +``fd``
> >> +    File descriptor returned by :c:func:`open()`.
> >> +
> >> +``argp``
> >> +    Pointer to struct :c:type:`v4l2_delete_buffers`.
> >> +
> >> +Description
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUFS` ioctl =
to
> >> +delete buffers from a queue.
> >> +
> >> +.. c:type:: v4l2_delete_buffers
> >> +
> >> +.. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.5cm}|
> >> +
> >> +.. flat-table:: struct v4l2_delete_buffers
> >> +    :header-rows:  0
> >> +    :stub-columns: 0
> >> +    :widths:       1 1 2
> >> +
> >> +    * - __u32
> >> +      - ``index``
> >> +      - The starting buffer index to delete.
> >> +    * - __u32
> >> +      - ``count``
> >> +      - The number of buffers to be deleted with indices 'index' unti=
l 'index + count - 1'.
> >> +        All buffers in this range must be valid and in DEQUEUED state=
.
> > I wonder if this wouldn't be an inconvenience for the userspace. Would
> > there be anything wrong with allowing ranges with holes?
> > (Agreed about the DEQUEUED part of course.)
>
> For me a range as to be valid but the matter of taste.
>

@Hans Verkuil do you have an opinion?
I could imagine that applications may want to just delete multiple
disjoint ranges in one ioctl, which wouldn't be possible if we
prohibit holes in the ranges.

> >
> >> +        In error case errno is set to ``EINVAL`` error code and index=
 returns the index of
> >> +        the invalid buffer.
> >> +        If count and index are set to 0 :ref:`VIDIOC_DELETE_BUFS` wil=
l return 0.
> > Hmm, do we care about index if count is zero?
>
> No we don't I will change that.
>
> >
> >> +    * - __u32
> >> +      - ``type``
> >> +      - Type of the stream or buffers, this is the same as the struct
> >> +    :c:type:`v4l2_format` ``type`` field. See
> >> +    :c:type:`v4l2_buf_type` for valid values.
> >> +    * - __u32
> >> +      - ``reserved``\ [13]
> >> +      - A place holder for future extensions. Drivers and application=
s
> >> +    must set the array to zero.
> >> +
> >> +Return Value
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +On success 0 is returned, on error -1 and the ``errno`` variable is s=
et
> >> +appropriately. The generic error codes are described at the
> >> +:ref:`Generic Error Codes <gen-errors>` chapter.
> >> +
> >> +EBUSY
> >> +    File I/O is in progress.
> >> +
> >> +EINVAL
> >> +    The buffer ``index`` doesn't exist in the queue.
> >> diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst =
b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> >> index 0b3a41a45d05..14d4a49c2945 100644
> >> --- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> >> +++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> >> @@ -121,6 +121,7 @@ aborting or finishing any DMA in progress, an impl=
icit
> >>   .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
> >>   .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
> >>   .. _V4L2-BUF-CAP-SUPPORTS-MAX-NUM-BUFFERS:
> >> +.. _V4L2-BUF-CAP-SUPPORTS-DELETE-BUFS:
> >>
> >>   .. raw:: latex
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers=
/media/common/videobuf2/videobuf2-core.c
> >> index 010a8bca0240..7068930a0ba6 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >> @@ -1665,6 +1665,36 @@ int vb2_core_prepare_buf(struct vb2_queue *q, s=
truct vb2_buffer *vb, void *pb)
> >>   }
> >>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
> >>
> >> +int vb2_core_delete_bufs(struct vb2_queue *q, unsigned int start, uns=
igned int count)
> >> +{
> >> +    unsigned int i, ret =3D 0;
> >> +
> >> +    if (start =3D=3D 0 && count =3D=3D 0)
> > I guess related to the earlier comment, but why do we care about start
> > being zero?
> >
> >> +            return 0;
> >> +
> >> +    mutex_lock(&q->mmap_lock);
> >> +
> >> +    for (i =3D start; i < start + count && i < q->max_num_buffers; i+=
+) {
> >> +            struct vb2_buffer *vb =3D vb2_get_buffer(q, i);
> >> +
> >> +            if (!vb) {
> >> +                    ret =3D -EINVAL;
> >> +                    goto unlock;
> >> +            }
> >> +            if (vb->state !=3D VB2_BUF_STATE_DEQUEUED) {
> >> +                    ret =3D -EINVAL;
> >> +                    goto unlock;
> >> +            }
> >> +    }
> >> +    __vb2_queue_free(q, start, count);
> >> +    dprintk(q, 2, "buffers deleted\n");
> >> +
> >> +unlock:
> >> +    mutex_unlock(&q->mmap_lock);
> >> +    return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(vb2_core_delete_bufs);
> >> +
> >>   /*
> >>    * vb2_start_streaming() - Attempt to start streaming.
> >>    * @q:             videobuf2 queue
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers=
/media/common/videobuf2/videobuf2-v4l2.c
> >> index 56daf3b5b2ba..f003618efbc1 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> >> @@ -694,6 +694,8 @@ static void fill_buf_caps(struct vb2_queue *q, u32=
 *caps)
> >>      if (q->supports_requests)
> >>              *caps |=3D V4L2_BUF_CAP_SUPPORTS_REQUESTS;
> >>   #endif
> >> +    if (q->supports_delete_bufs)
> >> +            *caps |=3D V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS;
> >>   }
> >>
> >>   static void validate_memory_flags(struct vb2_queue *q,
> >> @@ -751,6 +753,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct m=
edia_device *mdev,
> >>   }
> >>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
> >>
> >> +int vb2_delete_bufs(struct vb2_queue *q, struct v4l2_delete_buffers *=
d)
> >> +{
> >> +    return vb2_core_delete_bufs(q, d->index, d->count);
> >> +}
> >> +EXPORT_SYMBOL_GPL(vb2_delete_bufs);
> >> +
> >>   int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers =
*create)
> >>   {
> >>      unsigned requested_planes =3D 1;
> >> @@ -1012,6 +1020,18 @@ EXPORT_SYMBOL_GPL(vb2_poll);
> >>
> >>   /* vb2 ioctl helpers */
> >>
> >> +int vb2_ioctl_delete_bufs(struct file *file, void *priv,
> >> +                      struct v4l2_delete_buffers *p)
> >> +{
> >> +    struct video_device *vdev =3D video_devdata(file);
> >> +
> >> +    if (vb2_queue_is_busy(vdev->queue, file))
> >> +            return -EBUSY;
> >> +
> >> +    return vb2_delete_bufs(vdev->queue, p);
> >> +}
> >> +EXPORT_SYMBOL_GPL(vb2_ioctl_delete_bufs);
> >> +
> >>   int vb2_ioctl_reqbufs(struct file *file, void *priv,
> >>                        struct v4l2_requestbuffers *p)
> >>   {
> >> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-c=
ore/v4l2-dev.c
> >> index f81279492682..215654fd6581 100644
> >> --- a/drivers/media/v4l2-core/v4l2-dev.c
> >> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> >> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct video_de=
vice *vdev)
> >>              SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF, vidioc_prepare_b=
uf);
> >>              SET_VALID_IOCTL(ops, VIDIOC_STREAMON, vidioc_streamon);
> >>              SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
> >> +            SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUFS, vidioc_delete_bu=
fs);
> >>      }
> >>
> >>      if (is_vid || is_vbi || is_meta) {
> >> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2=
-core/v4l2-ioctl.c
> >> index 4d90424cbfc4..e9dcf439f9f3 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> @@ -489,6 +489,13 @@ static void v4l_print_create_buffers(const void *=
arg, bool write_only)
> >>      v4l_print_format(&p->format, write_only);
> >>   }
> >>
> >> +static void v4l_print_delete_buffers(const void *arg, bool write_only=
)
> >> +{
> >> +    const struct v4l2_delete_buffers *p =3D arg;
> >> +
> >> +    pr_cont("index=3D%u, count=3D%u\n", p->index, p->count);
> >> +}
> >> +
> >>   static void v4l_print_streamparm(const void *arg, bool write_only)
> >>   {
> >>      const struct v4l2_streamparm *p =3D arg;
> >> @@ -2161,6 +2168,15 @@ static int v4l_prepare_buf(const struct v4l2_io=
ctl_ops *ops,
> >>      return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
> >>   }
> >>
> >> +static int v4l_delete_bufs(const struct v4l2_ioctl_ops *ops,
> >> +                       struct file *file, void *fh, void *arg)
> >> +{
> >> +    struct v4l2_delete_buffers *delete =3D arg;
> >> +    int ret =3D check_fmt(file, delete->type);
> > Should we also have
> >
> >       memset_after(delete, 0, type);
> >
> > here similar to how other ioctl handlers clear the reserved fields?
>
> I will add it.
>
> >
> >> +
> >> +    return ret ? ret : ops->vidioc_delete_bufs(file, fh, delete);
> >> +}
> >> +
> >>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
> >>                              struct file *file, void *fh, void *arg)
> >>   {
> >> @@ -2910,6 +2926,7 @@ static const struct v4l2_ioctl_info v4l2_ioctls[=
] =3D {
> >>      IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, v4l_print=
_freq_band, 0),
> >>      IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, v4l_print=
_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
> >>      IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, v4l_print_q=
uery_ext_ctrl, INFO_FL_CTRL | INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
> >> +    IOCTL_INFO(VIDIOC_DELETE_BUFS, v4l_delete_bufs, v4l_print_delete_=
buffers, INFO_FL_PRIO | INFO_FL_QUEUE | INFO_FL_CLEAR(v4l2_delete_buffers, =
type)),
> >>   };
> >>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
> >>
> >> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> >> index edb733f21604..55afbde54211 100644
> >> --- a/include/media/v4l2-ioctl.h
> >> +++ b/include/media/v4l2-ioctl.h
> >> @@ -163,6 +163,8 @@ struct v4l2_fh;
> >>    * :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
> >>    * @vidioc_prepare_buf: pointer to the function that implements
> >>    * :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
> >> + * @vidioc_delete_bufs: pointer to the function that implements
> >> + *  :ref:`VIDIOC_DELETE_BUFS <vidioc_delete_bufs>` ioctl
> >>    * @vidioc_overlay: pointer to the function that implements
> >>    * :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
> >>    * @vidioc_g_fbuf: pointer to the function that implements
> >> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
> >>                                struct v4l2_create_buffers *b);
> >>      int (*vidioc_prepare_buf)(struct file *file, void *fh,
> >>                                struct v4l2_buffer *b);
> >> +    int (*vidioc_delete_bufs)(struct file *file, void *fh,
> >> +                              struct v4l2_delete_buffers *d);
> >>
> >>      int (*vidioc_overlay)(struct file *file, void *fh, unsigned int i=
);
> >>      int (*vidioc_g_fbuf)(struct file *file, void *fh,
> >> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-=
core.h
> >> index 288477075a0e..db3bd986624e 100644
> >> --- a/include/media/videobuf2-core.h
> >> +++ b/include/media/videobuf2-core.h
> >> @@ -507,6 +507,7 @@ struct vb2_buf_ops {
> >>    * @supports_requests: this queue supports the Request API.
> >>    * @requires_requests: this queue requires the Request API. If this =
is set to 1,
> >>    *         then supports_requests must be set to 1 as well.
> >> + * @supports_delete_bufs: this queue supports DELETE_BUFS ioctl.
> >>    * @uses_qbuf:     qbuf was used directly for this queue. Set to 1 t=
he first
> >>    *         time this is called. Set to 0 when the queue is canceled.
> >>    *         If this is 1, then you cannot queue buffers from a reques=
t.
> >> @@ -595,6 +596,7 @@ struct vb2_queue {
> >>      unsigned int               quirk_poll_must_check_waiting_for_buff=
ers:1;
> >>      unsigned int                    supports_requests:1;
> >>      unsigned int                    requires_requests:1;
> >> +    unsigned int                    supports_delete_bufs:1;
> >>      unsigned int                    uses_qbuf:1;
> >>      unsigned int                    uses_requests:1;
> >>      unsigned int                    allow_cache_hints:1;
> >> @@ -846,6 +848,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enu=
m vb2_memory memory,
> >>    */
> >>   int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb,=
 void *pb);
> >>
> >> +/**
> >> + * vb2_core_delete_bufs() -
> >> + * @q:              pointer to &struct vb2_queue with videobuf2 queue=
.
> >> + * @start:  first index of the range of buffers to delete.
> >> + * @count:  number of buffers to delete.
> >> + *
> >> + *  Return: returns zero on success; an error code otherwise.
> >> + */
> >> +int vb2_core_delete_bufs(struct vb2_queue *q, unsigned int start, uns=
igned int count);
> >> +
> >>   /**
> >>    * vb2_core_qbuf() - Queue a buffer from userspace
> >>    *
> >> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-=
v4l2.h
> >> index 5a845887850b..79cea8459f52 100644
> >> --- a/include/media/videobuf2-v4l2.h
> >> +++ b/include/media/videobuf2-v4l2.h
> >> @@ -118,6 +118,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct v=
4l2_create_buffers *create);
> >>    */
> >>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
> >>                  struct v4l2_buffer *b);
> >> +/**
> >> + * vb2_delete_bufs() - Delete buffers from the queue
> >> + *
> >> + * @q:              pointer to &struct vb2_queue with videobuf2 queue=
.
> >> + * @d:              delete parameter, passed from userspace to
> >> + *          &v4l2_ioctl_ops->vidioc_delete_bufs handler in driver
> >> + *
> >> + * The return values from this function are intended to be directly r=
eturned
> >> + * from &v4l2_ioctl_ops->vidioc_delete_bufs handler in driver.
> >> + */
> >> +int vb2_delete_bufs(struct vb2_queue *q, struct v4l2_delete_buffers *=
d);
> >>
> >>   /**
> >>    * vb2_qbuf() - Queue a buffer from userspace
> >> @@ -334,6 +345,8 @@ int vb2_ioctl_streamon(struct file *file, void *pr=
iv, enum v4l2_buf_type i);
> >>   int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf=
_type i);
> >>   int vb2_ioctl_expbuf(struct file *file, void *priv,
> >>      struct v4l2_exportbuffer *p);
> >> +int vb2_ioctl_delete_bufs(struct file *file, void *priv,
> >> +                      struct v4l2_delete_buffers *p);
> >>
> >>   /* struct v4l2_file_operations helpers */
> >>
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/video=
dev2.h
> >> index 13ddb5abf584..96e105149906 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -1036,6 +1036,7 @@ struct v4l2_requestbuffers {
> >>   #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF (1 << 5)
> >>   #define V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS             (1 << 6)
> >>   #define V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS              (1 << 7)
> >> +#define V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS           (1 << 8)
> >>
> >>   /**
> >>    * struct v4l2_plane - plane info for multi-planar buffers
> >> @@ -2622,6 +2623,20 @@ struct v4l2_create_buffers {
> >>      __u32                   reserved[5];
> >>   };
> >>
> >> +/**
> >> + * struct v4l2_delete_buffers - VIDIOC_DELETE_BUFS argument
> >> + * @index:  the first buffer to be deleted
> >> + * @count:  number of buffers to delete
> >> + * @type:   enum v4l2_buf_type
> >> + * @reserved:       future extensions
> >> + */
> >> +struct v4l2_delete_buffers {
> >> +    __u32                   index;
> >> +    __u32                   count;
> >> +    __u32                   type;
> >> +    __u32                   reserved[13];
> >> +};
> >> +
> >>   /*
> >>    * I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
> >>    *
> >> @@ -2721,6 +2736,8 @@ struct v4l2_create_buffers {
> >>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct v4l2_dbg_chip=
_info)
> >>
> >>   #define VIDIOC_QUERY_EXT_CTRL      _IOWR('V', 103, struct v4l2_query=
_ext_ctrl)
> >> +#define VIDIOC_DELETE_BUFS  _IOWR('V', 104, struct v4l2_delete_buffer=
s)
> >> +
> >>
> >>   /* Reminder: when adding new ioctls please add support for them to
> >>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
> > Do we also need to add support for the new ioctl in there?
>
> It only use _u32, is aligned on cache boundary and doesn't use pointer.
> For me 32 and 64 bits structures are identical so it doesn't need to be c=
onvert.
> Maybe I'm wrong when testing it with pahole ?

Ah, right. I double checked the compat code and indeed if an ioctl is
not listed there, it will just use the default copy_from_user, so we
should be good.

Maybe one day we should update that comment to explain how to check if
it's necessary to add a compat handler.

Best regards,
Tomasz
