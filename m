Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE717F48E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjKVOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjKVOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:24:13 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D503110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:24:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d264e67d8so25100736d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700663047; x=1701267847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Og4EFSaRcRZwQb7ZB9EfTRcPKXoxx1MGlRvBC/11KF4=;
        b=ga4TlkBoQQVGbhF9fXEh5PRYzhmu4j69xhfKeamcewRoaW09XoXCvIya/uAta2Fxnx
         yX4TAHljm1oV9a4q2/gOH0V7sSOUObpxoEQLTxKy6vFCkRjc9hIdsqfcq2keDWMW/nar
         bioD8bVjhfWF/U4s/EJoLmkp2cj1C8LFZ9CbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663047; x=1701267847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og4EFSaRcRZwQb7ZB9EfTRcPKXoxx1MGlRvBC/11KF4=;
        b=KtFf3/slZsxWhTQnft6MiCwpWYHmGuyVF/euxGxSZKeKy00IVJRE0dwXn8lIcKAkvv
         Yu9dZrtzKTK73rONB7nlht1tmyrkxKXI865jfWxiDdwRiz86/LfD7Z3mwQ6MZcefxtGA
         LZZqy/MyDz9UXPBSmDu9pSE249MCU3a8dCTTqGuK5k3fNo0x9MN3mQQ3jzsrQU5gFCjl
         6ulXcPjItIJ7ok6e5+D/TZxxm9g7AQJdFB/3FBTv267BV3RoHXW5JhIr9r9Z4yuE4y9F
         /Lb9jz81UzE0eP5/knDwwbCqOZlKrWsJI0enXQ8mFwrn1Z9iY5VXlL//qWLWkaScf17K
         4o0A==
X-Gm-Message-State: AOJu0YylSqqOQxXtR4CEKwClmtKPXW64vK9+F9ZHp9tlIHf5m++3237q
        iFNKlNmWwwDlaU85cf3MkL1IlAhfnodj60o585JwVw==
X-Google-Smtp-Source: AGHT+IFgmGFC7cqUBZc1gWfPEFtC1tb+beU1jdkGcz62Zj/D93xvLifED6h5hogrJo/TD532IbOchA==
X-Received: by 2002:a05:6214:5008:b0:679:e77f:5e84 with SMTP id jo8-20020a056214500800b00679e77f5e84mr2635134qvb.53.1700663047552;
        Wed, 22 Nov 2023 06:24:07 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id eu2-20020ad44f42000000b00679fb23c6edsm301211qvb.86.2023.11.22.06.24.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:24:07 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-677f832d844so25021886d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:24:07 -0800 (PST)
X-Received: by 2002:a0c:8f19:0:b0:679:e320:9918 with SMTP id
 z25-20020a0c8f19000000b00679e3209918mr2086373qvd.16.1700663046718; Wed, 22
 Nov 2023 06:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-3-d8a5eae2312b@chromium.org> <ZV3WEDZ0EfdYrImE@valkosipuli.retiisi.eu>
 <20231122131455.GC3909@pendragon.ideasonboard.com> <CANiDSCs9wQyrDt8i7Rk8yFVdBEzdE_AcJWKU4m9iX5EHn8ATqQ@mail.gmail.com>
 <20231122140419.GF3909@pendragon.ideasonboard.com>
In-Reply-To: <20231122140419.GF3909@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 15:23:51 +0100
X-Gmail-Original-Message-ID: <CANiDSCsdgAHv9J4Zk8Hz289Lq-rhWJq0VxA=+MbiBLkJRv6d9A@mail.gmail.com>
Message-ID: <CANiDSCsdgAHv9J4Zk8Hz289Lq-rhWJq0VxA=+MbiBLkJRv6d9A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] media: uvcvideo: Lock video streams and queues
 while unregistering
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, 22 Nov 2023 at 15:04, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Wed, Nov 22, 2023 at 02:59:31PM +0100, Ricardo Ribalda wrote:
> > On Wed, 22 Nov 2023 at 14:14, Laurent Pinchart wrote:
> > > On Wed, Nov 22, 2023 at 10:21:04AM +0000, Sakari Ailus wrote:
> > > > On Tue, Nov 21, 2023 at 07:53:50PM +0000, Ricardo Ribalda wrote:
> > > > > From: Guenter Roeck <linux@roeck-us.net>
> > > > >
> > > > > The call to uvc_disconnect() is not protected by any mutex.
> > > > > This means it can and will be called while other accesses to the video
> > > > > device are in progress. This can cause all kinds of race conditions,
> > > > > including crashes such as the following.
> > > > >
> > > > > usb 1-4: USB disconnect, device number 3
> > > > > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > > > > PGD 0 P4D 0
> > > > > Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
> > > > > Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
> > > > > RIP: 0010:usb_ifnum_to_if+0x29/0x40
> > > > > Code: <...>
> > > > > RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> > > > > RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> > > > > RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> > > > > R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> > > > > R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> > > > > FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
> > > > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> > > > > Call Trace:
> > > > >  usb_hcd_alloc_bandwidth+0x1ee/0x30f
> > > > >  usb_set_interface+0x1a3/0x2b7
> > > > >  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
> > > > >  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
> > > > >  uvc_start_streaming+0x28/0x5d [uvcvideo]
> > > > >  vb2_start_streaming+0x61/0x143 [videobuf2_common]
> > > > >  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
> > > > >  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
> > > > >  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
> > > > >  __video_do_ioctl+0x33d/0x42a
> > > > >  video_usercopy+0x34e/0x5ff
> > > > >  ? video_ioctl2+0x16/0x16
> > > > >  v4l2_ioctl+0x46/0x53
> > > > >  do_vfs_ioctl+0x50a/0x76f
> > > > >  ksys_ioctl+0x58/0x83
> > > > >  __x64_sys_ioctl+0x1a/0x1e
> > > > >  do_syscall_64+0x54/0xde
> > > > >
> > > > > usb_set_interface() should not be called after the USB device has been
> > > > > unregistered. However, in the above case the disconnect happened after
> > > > > v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().
> > > > >
> > > > > Acquire various mutexes in uvc_unregister_video() to fix the majority
> > > > > (maybe all) of the observed race conditions.
> > > > >
> > > > > The uvc_device lock prevents races against suspend and resume calls
> > > > > and the poll function.
> > > > >
> > > > > The uvc_streaming lock prevents races against stream related functions;
> > > > > for the most part, those are ioctls. This lock also requires other
> > > > > functions using this lock to check if a video device is still registered
> > > > > after acquiring it. For example, it was observed that the video device
> > > > > was already unregistered by the time the stream lock was acquired in
> > > > > uvc_ioctl_streamon().
> > > > >
> > > > > The uvc_queue lock prevents races against queue functions, Most of
> > > > > those are already protected by the uvc_streaming lock, but some
> > > > > are called directly. This is done as added protection; an actual race
> > > > > was not (yet) observed.
> > > > >
> > > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > > > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > > > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > index 413c32867617..3408b865d346 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > @@ -1907,14 +1907,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
> > > > >  {
> > > > >     struct uvc_streaming *stream;
> > > > >
> > > > > +   mutex_lock(&dev->lock);
> > > > > +
> > > > >     list_for_each_entry(stream, &dev->streams, list) {
> > > > >             if (!video_is_registered(&stream->vdev))
> > > > >                     continue;
> > > > >
> > > > > +           mutex_lock(&stream->mutex);
> > > > > +           mutex_lock(&stream->queue.mutex);
> > > > > +
> > > > >             video_unregister_device(&stream->vdev);
> > > > >             video_unregister_device(&stream->meta.vdev);
> > > > >
> > > > >             uvc_debugfs_cleanup_stream(stream);
> > > > > +
> > > > > +           mutex_unlock(&stream->queue.mutex);
> > > > > +           mutex_unlock(&stream->mutex);
> > > > >     }
> > > > >
> > > > >     uvc_status_unregister(dev);
> > > > > @@ -1925,6 +1933,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
> > > > >     if (media_devnode_is_registered(dev->mdev.devnode))
> > > > >             media_device_unregister(&dev->mdev);
> > > > >  #endif
> > > > > +   mutex_unlock(&dev->lock);
> > > > >  }
> > > > >
> > > > >  int uvc_register_video_device(struct uvc_device *dev,
> > > > >
> > > >
> > > > Instead of acquiring all the possible locks, could you instead take the
> > > > same approach as you do with ISP? It should use refcount_t btw.
> > > > <URL:https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/kcam-6.1/drivers/isp/isp-device.c:
> > >
> > > The right approach, as I've said countless of times, is to fix this at
> > > the cdev and V4L2 level. Dan Williams has done some ground work on this
> > > a while ago ([1]), and before that I posted an RFC series that
> > > overlapped with Dan's work (with a more naive and less efficient
> > > implementation of refcounting, see [2]).
> > >
> > > [1] https://lore.kernel.org/all/161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > [2] https://lore.kernel.org/linux-media/20171116003349.19235-2-laurent.pinchart+renesas@ideasonboard.com/
> >
> > The UVC driver is violating the USB driver API [1] causing crashes and
> > probably security vulnerabilities. It has to be fixed.
> >
> > If there was a different way TODAY to do this, I would very happily
> > implement it differently. But your patchset is 6 years old and Dan's 2
> > and they have not landed. How many kernel versions is ok to put our
> > users willingly at risk?
> >
> > This patch simply serialises unregister_video? How can this patch
> > affect the viability of your patchset or Dan's patch? If this patch is
> > not needed in the future we can simply revert it.
> >
> > When/If there is a better way to implement this, I would very happily
> > send a follow-up patch to use that framework.
>
> What I'm asking is that you, or someone else at your time, take over
> these patches from Dan and myself and help with the huge backlog we have
> in V4L2. You can't expect maintainers to fix everything in their spare
> time. Helping there is a good way to lower the pressure on maintainers
> and get patches reviewed more quickly.

I do not think that this is a fair comment.
I am already reviewing all the uvc patches in the ML. Most of the time
in my spare time.
How much more help do you need there?

We know for over 4 years that there is a NULL deref issue in the uvc
driver. There is a 10 lines fix for it, that has been both reviewed
and tested.
What else is needed from a driver point of view?

It feels that by your position you are just pressuring to get a global
solution, that is a noble cause. But that is not the responsibility or
the role of a driver maintainer.

>
> > [1] https://www.kernel.org/doc/html/latest/driver-api/usb/callbacks.html#the-disconnect-callback
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
