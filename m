Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22EA7F42E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjKVJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjKVJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:54:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E512A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:54:07 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cbd2cf3bbso5515501cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700646846; x=1701251646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqpYEFiVYvZlFazdN/UQMK6Ht63BG7ibp8wzUAhE94Q=;
        b=CrQm3wm1OwJfjag1w8DQg4Dk+3Jj85l4erIOutyZp7vjr0djhCg2kNQvMHSbCE+36C
         UrvKBgBff0Bq84m2ddnKNI1Izy2HpkbwpCUeL6DV9Lu/ycc01gP3UR8HbYtXLMQK6rm+
         7sl/tuyzP/Ed2Abd89lh8MOBRn1e8PdIE5XUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646846; x=1701251646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqpYEFiVYvZlFazdN/UQMK6Ht63BG7ibp8wzUAhE94Q=;
        b=ZjJXwUdDeX/TW17KYi7v2HHJd2EW61WtPkExCsXf3s/4VlI7toRfNwcyS+WLlU5nNL
         aT/70RzJAKOrBsr4SioXh3EsKBVYso7UTO8PBa2/F/xJaHTjZjzoEFmo/VSeDLfIpPTK
         jfJQo6halgNNSA9UdpPITxR7H2FC4DQgq29df25ql0O9SpeXrqVszTNXGXKQg2EngSXQ
         elyw9fKlI08JEQN9p/SQtS0AgD8ZRIaWHBlt8ARO1JsUNptXD/q3vgebombq0+g+F1UN
         dZKmCV3sS44PZ0YSRX+suLoQRE9Tp11rDQalkW3xCswU2eCL0EvQJDGG5uNLDeoiDUE9
         pARg==
X-Gm-Message-State: AOJu0YzcYtpwxMx2e4iIFYbS+1u9jW//wdG+g+z+ZnUKev1u3ZNiz+rQ
        0IS+OPQ5oCQPHDnThFGFLGI1ES2igbsKRXGSQgg6ww==
X-Google-Smtp-Source: AGHT+IH44RqaG+m0opzhBY9dpkI8M4C3ixxB2d0NWWJTvUGkV/M4rmsSCyDJQmgoD7w7bYVOheA9iw==
X-Received: by 2002:a05:6214:18e5:b0:679:da36:a6e0 with SMTP id ep5-20020a05621418e500b00679da36a6e0mr7603412qvb.25.1700646846088;
        Wed, 22 Nov 2023 01:54:06 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id df17-20020a056214081100b00677f34c4b4fsm4650000qvb.6.2023.11.22.01.54.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 01:54:05 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-677fba00a49so5518656d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:54:05 -0800 (PST)
X-Received: by 2002:a05:6214:1782:b0:66f:ac87:73b7 with SMTP id
 ct2-20020a056214178200b0066fac8773b7mr8770176qvb.15.1700646844595; Wed, 22
 Nov 2023 01:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org> <20231122072108.GA1465745@google.com>
 <CANiDSCunwy4wYL3-J5KNp4cG4mGsq8FtoyJ6hOr3VK+9+L2LgA@mail.gmail.com>
In-Reply-To: <CANiDSCunwy4wYL3-J5KNp4cG4mGsq8FtoyJ6hOr3VK+9+L2LgA@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 10:53:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCs9BZWOjDM6fxz-ipXqDAm9==aRw9giKRnk1XXyc1J35A@mail.gmail.com>
Message-ID: <CANiDSCs9BZWOjDM6fxz-ipXqDAm9==aRw9giKRnk1XXyc1J35A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Always use uvc_status_stop()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey

On Wed, 22 Nov 2023 at 08:35, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Sergey
>
> On Wed, 22 Nov 2023 at 08:21, Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (23/11/21 19:53), Ricardo Ribalda wrote:
> > > uvc_status_stop() handles properly the race conditions with the
> > > asynchronous worker.
> > > Let's use uvc_status_stop() for all the code paths that require stopping
> > > it.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_ctrl.c   | 4 ----
> > >  drivers/media/usb/uvc/uvc_status.c | 2 +-
> > >  2 files changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > index e59a463c2761..8e22a07e3e7b 100644
> > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > @@ -2765,10 +2765,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > >       struct uvc_entity *entity;
> > >       unsigned int i;
> > >
> > > -     /* Can be uninitialized if we are aborting on probe error. */
> > > -     if (dev->async_ctrl.work.func)
> > > -             cancel_work_sync(&dev->async_ctrl.work);
> > > -
> > >       /* Free controls and control mappings for all entities. */
> > >       list_for_each_entry(entity, &dev->entities, list) {
> > >               for (i = 0; i < entity->ncontrols; ++i) {
> > > diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> > > index a78a88c710e2..0208612a9f12 100644
> > > --- a/drivers/media/usb/uvc/uvc_status.c
> > > +++ b/drivers/media/usb/uvc/uvc_status.c
> > > @@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
> > >
> > >  void uvc_status_unregister(struct uvc_device *dev)
> > >  {
> > > -     usb_kill_urb(dev->int_urb);
> > > +     uvc_status_stop(dev);
> >
> > Sort of feels like this needs dev->lock somewhere here. Should we move 3/3
> > to the head of the series?
> >
> > The question is, can this be called in parallel with uvc_v4l2_release(),
> > for instance?
>
> I can be called in parallel with uvc_v4l2_release(), but
> uvc_status_stop() is thread-safe and does not take any locks after:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=619d9b710cf06f7a00a17120ca92333684ac45a8
>
> So this "should" be good. key-word here is should :P

To be on the safe side I am not going to run the async work on the
release path. will send a new revision

>
>
> >
> > >       uvc_input_unregister(dev);
> > >  }
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
