Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A7751CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGMJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjGMJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:10:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9B1FD2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:09:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8a8154f9cso2929905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689239389; x=1691831389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x8UOfbxvNdamXtzpCp3XMuBEd5XeIGuCTHCPnoAiyHo=;
        b=fmmlYQBdBMXpbpbndHBdFMGZy4H7HDWpUBDoJEOWmdqnUe2eUAjGxsFbx+nmvKIz4k
         +iw2MOCd5cFXZo5wTa4ivccpV2JxCKlGJUgGxMXIsz11bGt9Un1ZWT0wQOvWYMzpPe5O
         Pa+T3JEycm1WATU2gWDNIn9bXoyvSWq1sL41I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239389; x=1691831389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8UOfbxvNdamXtzpCp3XMuBEd5XeIGuCTHCPnoAiyHo=;
        b=jh30cHyg8AvY30I2nufebkarguQ+iMFDZ/0NnfOH+dyUm/xQOBIX9Ti1BH4YkZT6JA
         HSBJ8mnlLb8GsSFL5yn6MO+Z7O/pKEQ90Fywq7lCY/MLPumbF3YJkN8EZyVMySarUu+p
         uqQo/m0YL6xD5CV7ILzs5DvvSMhDokGVHYfoUTfnFfVIJPh2LiGkatUHf/dj9VgpW1N9
         ou9R7mq01Guvi94arMNWY99p5b/fADtWIgx3ymebF2TknDxM4V3CsaxuJT4XF7QzXy4p
         SzHCCAbTBR5e2EiwUFubEOc84cPgX6jznXrY0i1n6RfFNweZc8p4s8l1Jv8HpnzJVZfI
         VMdA==
X-Gm-Message-State: ABy/qLagHPwUm0FBHTN0sXYPR0vpJ33JXbcubcs1JW5UtFmzCHJYCuLJ
        +Y+u60sGBbr7kfD6q4L565Kwzg==
X-Google-Smtp-Source: APBJJlFU2bgaQ2CREOQIz5EJRphX87BFDB2j4eugHHQTD3MFC9OasKiPG81qT/B8w7BnYj8Yd+WEgA==
X-Received: by 2002:a17:903:32c8:b0:1b8:a67f:1c15 with SMTP id i8-20020a17090332c800b001b8a67f1c15mr6317098plr.25.1689239389333;
        Thu, 13 Jul 2023 02:09:49 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id z8-20020a63b048000000b0053031f7a367sm722558pgo.85.2023.07.13.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:09:48 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:09:44 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, ming.qian@nxp.com,
        hverkuil-cisco@xs4all.nl, gregkh@linuxfoundation.org,
        ezequiel@vanguardiasur.com.ar,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, nicolas.dufresne@collabora.com,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        ayaka <ayaka@soulik.info>
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
Message-ID: <20230713090944.3gxrxt7lqnozhu7r@chromium.org>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-11-benjamin.gaignard@collabora.com>
 <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
 <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
 <3b22fda9-4a0e-2c03-2f12-19e5e3239235@synaptics.com>
 <54833256-7d88-9316-4f0f-b8c57552cd7b@synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54833256-7d88-9316-4f0f-b8c57552cd7b@synaptics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:43:51PM +0800, Hsia-Jun Li wrote:
> 
> On 6/27/23 16:47, Hsia-Jun Li wrote:
> > CAUTION: Email originated externally, do not click links or open
> > attachments unless you recognize the sender and know the content is
> > safe.
> > 
> > 
> > On 6/27/23 16:43, Benjamin Gaignard wrote:
> > > CAUTION: Email originated externally, do not click links or open
> > > attachments unless you recognize the sender and know the content is
> > > safe.
> > > 
> > > 
> > > Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
> > > > 
> > > > On 6/22/23 21:13, Benjamin Gaignard wrote:
> > > > > CAUTION: Email originated externally, do not click links or open
> > > > > attachments unless you recognize the sender and know the content is
> > > > > safe.
> > > > > 
> > > > > 
> > > > > VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
> > > > > 
> > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > > > ---
> > > > >   .../userspace-api/media/v4l/user-func.rst     |  1 +
> > > > >   .../media/v4l/vidioc-delete-buf.rst           | 51
> > > > > +++++++++++++++++++
> > > > >   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
> > > > >   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
> > > > >   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
> > > > >   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
> > > > >   include/media/v4l2-ioctl.h                    |  4 ++
> > > > >   include/media/videobuf2-core.h                |  9 ++++
> > > > >   include/media/videobuf2-v4l2.h                | 11 ++++
> > > > >   include/uapi/linux/videodev2.h                |  2 +
> > > > >   10 files changed, 128 insertions(+)
> > > > >   create mode 100644
> > > > > Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> > > > > 
> > > > > diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
> > > > > b/Documentation/userspace-api/media/v4l/user-func.rst
> > > > > index 15ff0bf7bbe6..8c74016e12fd 100644
> > > > > --- a/Documentation/userspace-api/media/v4l/user-func.rst
> > > > > +++ b/Documentation/userspace-api/media/v4l/user-func.rst
> > > > > @@ -17,6 +17,7 @@ Function Reference
> > > > >       vidioc-dbg-g-chip-info
> > > > >       vidioc-dbg-g-register
> > > > >       vidioc-decoder-cmd
> > > > > +    vidioc-delete-buf
> > > > >       vidioc-dqevent
> > > > >       vidioc-dv-timings-cap
> > > > >       vidioc-encoder-cmd
> > > > > diff --git
> > > > > a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> > > > > b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> > > > > new file mode 100644
> > > > > index 000000000000..0e7ce58f91bc
> > > > > --- /dev/null
> > > > > +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> > > > > @@ -0,0 +1,51 @@
> > > > > +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> > > > > +.. c:namespace:: V4L
> > > > > +
> > > > > +.. _VIDIOC_DELETE_BUF:
> > > > > +
> > > > > +************************
> > > > > +ioctl VIDIOC_DELETE_BUF
> > > > > +************************
> > > > > +
> > > > > +Name
> > > > > +====
> > > > > +
> > > > > +VIDIOC_DELETE_BUF - Delete a buffer from a queue
> > > > > +
> > > > > +Synopsis
> > > > > +========
> > > > > +
> > > > > +.. c:macro:: VIDIOC_DELETE_BUF
> > > > > +
> > > > > +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
> > > > > +
> > > > > +Arguments
> > > > > +=========
> > > > > +
> > > > > +``fd``
> > > > > +    File descriptor returned by :c:func:`open()`.
> > > > > +
> > > > > +``argp``
> > > > > +    Pointer to struct :c:type:`v4l2_buffer`.
> > > > > +
> > > > > +Description
> > > > > +===========
> > > > > +
> > > > > +Applications can optionally call the
> > > > > :ref:`VIDIOC_DELETE_BUF` ioctl to
> > > > > +delete a buffer from a queue.
> > > > > +
> > > > > +The struct :c:type:`v4l2_buffer` structure is specified in
> > > > > +:ref:`buffer`.
> > > > > +
> > > > > +Return Value
> > > > > +============
> > > > > +
> > > > > +On success 0 is returned, on error -1 and the ``errno`` variable is
> > > > > set
> > > > > +appropriately. The generic error codes are described at the
> > > > > +:ref:`Generic Error Codes <gen-errors>` chapter.
> > > > > +
> > > > > +EBUSY
> > > > > +    File I/O is in progress.
> > > > > +
> > > > > +EINVAL
> > > > > +    The buffer ``index`` doesn't exist in the queue.
> > > > > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
> > > > > b/drivers/media/common/videobuf2/videobuf2-core.c
> > > > > index 899783f67580..aa546c972c3d 100644
> > > > > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > > > > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > > > > @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q,
> > > > > unsigned int index, void *pb)
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
> > > > > 
> > > > > +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
> > > > > +{
> > > > > +       struct vb2_buffer *vb;
> > > > > +
> > > > > +       vb = vb2_get_buffer(q, index);
> > > > > +       if (!vb) {
> > > > > +               dprintk(q, 1, "invalid buffer index %d\n", index);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
> > > > > +               dprintk(q, 1, "can't delete non dequeued buffer index
> > > > > %d\n", index);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > I know the driver could implement its own
> > > > v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
> > > > used by the hardware as a future reference frame.
> > > > But I think we need a flag to let the user know which buffer is still
> > > > used by the hardware.
> > > > Alternative ref case is safe, we only know it's existing when it is
> > > > dequeued in current V4L2 buffer mechanism.
> > > > While the Golden reference frame, such long term reference frame could
> > > > last much longer.
> > > 
> > > It is up to userland stack to know frames life time, it got the
> > > information for that.
> > 
> > That is true for the stateless codec driver.
> > 
> > While application for stateful decoder could never do that. It also
> > breaks what the document said:
> > 
> > "The backing memory of |CAPTURE| buffers that are used as reference
> > frames by the stream may be read by the hardware even after they are
> > dequeued. Consequently, the client should avoid writing into this memory
> > while the |CAPTURE| queue is streaming. Failure to observe this may
> > result in corruption of decoded frames."
> > 
> > > 
> > > > > +       if (vb->planes[0].mem_priv)
> > > > > +               call_void_vb_qop(vb, buf_cleanup, vb);
> > > > > +
> > > > > +       /* Free MMAP buffers or release USERPTR buffers */
> > > > > +       if (q->memory == VB2_MEMORY_MMAP)
> > > > > +               __vb2_buf_mem_free(vb);
> 
> Here is another problem for the existing application, the mmap() from the
> mmap offset or exportbuffer fd would not create a reference to buffer in
> this step(while the exportbuffer would create one itself).
> 
> When you delete a buffer, you may not release it from its virtual memory
> space, leaving a corrupted virtual memory space.

What do you mean? __vb2_buf_mem_free() doesn't unconditionally free the
memory, it just decrements a reference counter. The VMA holds its own,
so the buffer is only fully released when the application calls
munmap().

Best regards,
Tomasz

> Also this behavior is
> right, because mmap(2) says:
> 
> "After  the  mmap()  call has returned, the file descriptor, fd, can be
> closed immediately without invalidating the map‐ping."
> 
> > > > > +       else if (q->memory == VB2_MEMORY_DMABUF)
> > > > > +               __vb2_buf_dmabuf_put(vb);
> > > > > +       else
> > > > > +               __vb2_buf_userptr_put(vb);
> > > > > +
> > > > > +       vb2_queue_remove_buffer(q, vb);
> > > > > +       kfree(vb);
> > > > > +
> > > > > +       dprintk(q, 2, "buffer %d deleted\n", index);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >   /*
> > > > >    * vb2_start_streaming() - Attempt to start streaming.
> > > > >    * @q:         videobuf2 queue
> > > > > diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > > > > b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > > > > index 724135d41f7f..cea666c17b41 100644
> > > > > --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > > > > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > > > > @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct
> > > > > media_device *mdev,
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
> > > > > 
> > > > > +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
> > > > > +{
> > > > > +       return vb2_core_delete_buf(q, b->index);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(vb2_delete_buf);
> > > > > +
> > > > >   int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers
> > > > > *create)
> > > > >   {
> > > > >          unsigned requested_planes = 1;
> > > > > diff --git a/drivers/media/v4l2-core/v4l2-dev.c
> > > > > b/drivers/media/v4l2-core/v4l2-dev.c
> > > > > index f81279492682..80ace2e1e932 100644
> > > > > --- a/drivers/media/v4l2-core/v4l2-dev.c
> > > > > +++ b/drivers/media/v4l2-core/v4l2-dev.c
> > > > > @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
> > > > > video_device *vdev)
> > > > >                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
> > > > > vidioc_prepare_buf);
> > > > >                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
> > > > > vidioc_streamon);
> > > > >                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
> > > > > vidioc_streamoff);
> > > > > +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
> > > > > vidioc_delete_buf);
> > > > >          }
> > > > > 
> > > > >          if (is_vid || is_vbi || is_meta) {
> > > > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > index a858acea6547..1c737279d3ef 100644
> > > > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
> > > > > v4l2_ioctl_ops *ops,
> > > > >          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
> > > > >   }
> > > > > 
> > > > > +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
> > > > > +                         struct file *file, void *fh, void *arg)
> > > > > +{
> > > > > +       struct v4l2_buffer *b = arg;
> > > > > +       int ret = check_fmt(file, b->type);
> > > > > +
> > > > > +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
> > > > > +}
> > > > > +
> > > > >   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
> > > > >                                  struct file *file, void *fh, void
> > > > > *arg)
> > > > >   {
> > > > > @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
> > > > > v4l2_ioctls[] = {
> > > > >          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
> > > > > v4l_print_freq_band, 0),
> > > > >          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
> > > > > v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
> > > > >          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
> > > > > v4l_print_query_ext_ctrl, INFO_FL_CTRL |
> > > > > INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
> > > > > +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
> > > > > v4l_print_buffer, INFO_FL_QUEUE),
> > > > >   };
> > > > >   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
> > > > > 
> > > > > diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> > > > > index edb733f21604..2f232ed884c7 100644
> > > > > --- a/include/media/v4l2-ioctl.h
> > > > > +++ b/include/media/v4l2-ioctl.h
> > > > > @@ -163,6 +163,8 @@ struct v4l2_fh;
> > > > >    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
> > > > >    * @vidioc_prepare_buf: pointer to the function that implements
> > > > >    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
> > > > > + * @vidioc_delete_buf: pointer to the function that implements
> > > > > + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
> > > > >    * @vidioc_overlay: pointer to the function that implements
> > > > >    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
> > > > >    * @vidioc_g_fbuf: pointer to the function that implements
> > > > > @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
> > > > >                                    struct v4l2_create_buffers *b);
> > > > >          int (*vidioc_prepare_buf)(struct file *file, void *fh,
> > > > >                                    struct v4l2_buffer *b);
> > > > > +       int (*vidioc_delete_buf)(struct file *file, void *fh,
> > > > > +                                struct v4l2_buffer *b);
> > > > > 
> > > > >          int (*vidioc_overlay)(struct file *file, void *fh, unsigned
> > > > > int i);
> > > > >          int (*vidioc_g_fbuf)(struct file *file, void *fh,
> > > > > diff --git a/include/media/videobuf2-core.h
> > > > > b/include/media/videobuf2-core.h
> > > > > index 080b783d608d..0f9e68f76b77 100644
> > > > > --- a/include/media/videobuf2-core.h
> > > > > +++ b/include/media/videobuf2-core.h
> > > > > @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
> > > > > enum vb2_memory memory,
> > > > >    */
> > > > >   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index,
> > > > > void *pb);
> > > > > 
> > > > > +/**
> > > > > + * vb2_core_delete_buf() -
> > > > > + * @q: pointer to &struct vb2_queue with videobuf2 queue.
> > > > > + * @index:     id number of the buffer.
> > > > > + *
> > > > > + *  Return: returns zero on success; an error code otherwise.
> > > > > + */
> > > > > +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
> > > > > +
> > > > >   /**
> > > > >    * vb2_core_qbuf() - Queue a buffer from userspace
> > > > >    *
> > > > > diff --git a/include/media/videobuf2-v4l2.h
> > > > > b/include/media/videobuf2-v4l2.h
> > > > > index 88a7a565170e..3beeb4c735f0 100644
> > > > > --- a/include/media/videobuf2-v4l2.h
> > > > > +++ b/include/media/videobuf2-v4l2.h
> > > > > @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct
> > > > > v4l2_create_buffers *create);
> > > > >    */
> > > > >   int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
> > > > >                      struct v4l2_buffer *b);
> > > > > +/**
> > > > > + * vb2_delete_buf() - Delete the buffer from the queue
> > > > > + *
> > > > > + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
> > > > > + * @b:         buffer structure passed from userspace to
> > > > > + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
> > > > > + *
> > > > > + * The return values from this function are intended to be directly
> > > > > returned
> > > > > + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
> > > > > + */
> > > > > +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
> > > > > 
> > > > >   /**
> > > > >    * vb2_qbuf() - Queue a buffer from userspace
> > > > > diff --git a/include/uapi/linux/videodev2.h
> > > > > b/include/uapi/linux/videodev2.h
> > > > > index aee75eb9e686..31bba1915642 100644
> > > > > --- a/include/uapi/linux/videodev2.h
> > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
> > > > >   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
> > > > > v4l2_dbg_chip_info)
> > > > > 
> > > > >   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
> > > > > v4l2_query_ext_ctrl)
> > > > > +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
> > > > > +
> > > > > 
> > > > >   /* Reminder: when adding new ioctls please add support for them to
> > > > >      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
> > > > > -- 
> > > > > 2.39.2
> > > > > 
> > -- 
> > Hsia-Jun(Randy) Li
> > 
> -- 
> Hsia-Jun(Randy) Li
> 
