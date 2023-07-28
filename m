Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E76766549
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjG1H1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjG1H0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:26:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9435BF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:26:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d10da0f26so11909256d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690529196; x=1691133996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5Ii7ufrZNlWy4S5bZsqj51LE8m/vOxyVNH0bsHeuCU=;
        b=LVHeXgXSQB2TiDD1D89D/FzvgUKb+IUc3M5+9L51EXItItaUNoWKRjldAy0YAD4XRg
         JilHldiHriU9R5E/Szk7zB4+WzXX2jQI84MWil7sUq5PbUBHycx4xZNdksUg4YIpvZLd
         lN1D31X589RyLKBu60nJnlDZKK+U/BchTGfpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529196; x=1691133996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5Ii7ufrZNlWy4S5bZsqj51LE8m/vOxyVNH0bsHeuCU=;
        b=b0hyb1pZaezA6vQeKJw5lvDH9DnXzVg+ZaL2zR6rnC7DcrQfHE446k4yx71z79LmrM
         8BF6hXvT2vWeIvg4FouoQPCL32Y0F0H20t/uHPoIiKxFpLPQUHkma9kBHeECo6AWN+YJ
         Psmx+noz3CmHldMX747B6IzUxSkF0z4g4ESlp42Zz60ek16/b5ZiaclSGORd85I9Q+6q
         suNP1NlqVGZ/LArzTA7VYUGELPp771nVRh2qxIXoMl4TvJYGhtQWhtzePWIpl3VH5IOS
         nfsRedavT3a9xY8jv03XxlLpLBV6qJ14wWgNerzRxxhNl4FIx5kKn904xdWRSPw/yU3V
         9m5w==
X-Gm-Message-State: ABy/qLZZqw5T/iycg5/CvJ4aTGUN7bUDO1GVf1flADhs2d/byTXdfpmt
        utNRJaFXacYofPn5GBIefkMBJesFDWnN0Zf9xpEptQvs
X-Google-Smtp-Source: APBJJlHwJ9JLJI10hifS8H8j7uFh4ybKhrbPWsUAWQ2Np8DzmGC56WBfKifNirP0wotT2Tdx+h8lsg==
X-Received: by 2002:a05:622a:8e:b0:403:fee8:7fdc with SMTP id o14-20020a05622a008e00b00403fee87fdcmr1782650qtw.39.1690529195790;
        Fri, 28 Jul 2023 00:26:35 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id o8-20020a0c8c48000000b0063d152e5d9asm1024344qvb.120.2023.07.28.00.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:26:35 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-63cf6b21035so11965696d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:26:35 -0700 (PDT)
X-Received: by 2002:a0c:e0cb:0:b0:639:91be:2f26 with SMTP id
 x11-20020a0ce0cb000000b0063991be2f26mr1637324qvk.55.1690529194671; Fri, 28
 Jul 2023 00:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com> <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
 <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
 <583e22718b80cc5e1ae631528c83c95e97de5cae.camel@ndufresne.ca>
 <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com> <7d340df3-e14c-24de-4fc2-b7dca619447c@synaptics.com>
In-Reply-To: <7d340df3-e14c-24de-4fc2-b7dca619447c@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 28 Jul 2023 16:26:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BKHQPNVpDvpQaFn-q721BJknJCUB72urc2=EKsAH=OCg@mail.gmail.com>
Message-ID: <CAAFQd5BKHQPNVpDvpQaFn-q721BJknJCUB72urc2=EKsAH=OCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:09=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
>
>
>
> On 7/28/23 12:43, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Fri, Jul 28, 2023 at 1:58=E2=80=AFAM Nicolas Dufresne <nicolas@ndufr=
esne.ca> wrote:
> >>
> >> Le jeudi 27 juillet 2023 =C3=A0 16:43 +0900, Tomasz Figa a =C3=A9crit =
:
> >>> On Mon, Jul 17, 2023 at 11:07=E2=80=AFPM Nicolas Dufresne <nicolas@nd=
ufresne.ca> wrote:
> >>>>
> >>>> Le mercredi 12 juillet 2023 =C3=A0 09:33 +0000, Tomasz Figa a =C3=A9=
crit :
> >>>>> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
> >>>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> >>>>>>
> >>>>>> Many drivers have to create its own buf_struct for a
> >>>>>> vb2_queue to track such a state. Also driver has to
> >>>>>> iterate over rdy_queue every times to find out a buffer
> >>>>>> which is not sent to hardware(or firmware), this new
> >>>>>> list just offers the driver a place to store the buffer
> >>>>>> that hardware(firmware) has acknowledged.
> >>>>>>
> >>>>>> One important advance about this list, it doesn't like
> >>>>>> rdy_queue which both bottom half of the user calling
> >>>>>> could operate it, while the v4l2 worker would as well.
> >>>>>> The v4l2 core could only operate this queue when its
> >>>>>> v4l2_context is not running, the driver would only
> >>>>>> access this new hw_queue in its own worker.
> >>>>>
> >>>>> Could you describe in what case such a list would be useful for a
> >>>>> mem2mem driver?
> >>>>
> >>>> Today all driver must track buffers that are "owned by the hardware"=
. This is a
> >>>> concept dictated by the m2m framework and enforced through the ACTIV=
E flag. All
> >>>> buffers from this list must be mark as done/error/queued after strea=
moff of the
> >>>> respective queue in order to acknowledge that they are no longer in =
use by the
> >>>> HW. Not doing so will warn:
> >>>>
> >>>>    videobuf2_common: driver bug: stop_streaming operation is leaving=
 buf ...
> >>>>
> >>>> Though, there is no queue to easily iterate them. All driver endup h=
aving their
> >>>> own queue, or just leaving the buffers in the rdy_queue (which isn't=
 better).
> >>>>
> >>>
> >>> Thanks for the explanation. I see how it could be useful now.
> >>>
> >>> Although I guess this is a problem specifically for hardware (or
> >>> firmware) which can internally queue more than 1 buffer, right?
> >>> Otherwise the current buffer could just stay at the top of the
> >>> rdy_queue until it's removed by the driver's completion handler,
> >>> timeout/error handler or context destruction.
> >>
> >> Correct, its only an issue when you need to process multiple src buffe=
rs before
> >> producing a dst buffer. If affects stateful decoder, stateful encoders=
 and
> >> deinterlacer as far as I'm aware.
> >
> > Is it actually necessary to keep those buffers in a list in that case, =
though?
> > I can see that a deinterlacer would indeed need 2 input buffers to
> > perform the deinterlacing operation, but those would be just known to
> > the driver, since it's running the task currently.
> > For a stateful decoder, wouldn't it just consume the bitstream buffer
> > (producing something partially decoded to its own internal buffers)
> > and return it shortly?
> Display re-order. Firmware could do such batch work, taking a few
> bitstream buffer, then output a list graphics buffer in the display
> order also discard the usage of the non-display buffer when it is
> removed from dpb.
>
> Even in one input and one output mode, firmware need to do redo, let the
> driver know when a graphics buffer could be display, so firmware would
> usually hold the graphics buffer(frame) until its display time.
>

Okay, so that hold would be for frame buffers, not bitstream buffers, right=
?
But yeah, I see that then it could hold onto those buffers until it's
their turn to display and it could be a bigger number of frames,
depending on the complexity of the codec.

> Besides, I hate the driver occupied a large of memory without user's
> order. I would like to drop those internal buffers.

I think this is one reason to migrate to the stateless decoder design.

> > The most realistic scenario would be for stateful encoders which could
> > keep some input buffers as reference frames for further encoding, but
> > then would this patch actually work for them? It would make
> > __v4l2_m2m_try_queue never add the context to the job_queue if there
> > are some buffers in that hw_queue list.
> why?
> >
> > Maybe what I need here are actual patches modifying some existing
> > drivers. Randy, would you be able to include that in the next version?
> May not. The Synaptics VideoSmart is a secure video platform(DRM), I
> could release a snapshot of the driver when I got the permission, that
> would be after the official release of the SDK.
> But you may not be able to compile it because we have our own TEE
> interface(not optee), also running it because the trusted app would be
> signed with a per-device key.

Could you modify another, already existing driver then?

> > Thanks.
> >
> > Best regards,
> > Tomasz
> >
> >>
> >> Nicolas
> >>
> >>>
> >>> Best regards,
> >>> Tomasz
> >>>
> >>>> Nicolas
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> >>>>>> ---
> >>>>>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++---=
-----
> >>>>>>   include/media/v4l2-mem2mem.h           | 10 +++++++++-
> >>>>>>   2 files changed, 26 insertions(+), 9 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/medi=
a/v4l2-core/v4l2-mem2mem.c
> >>>>>> index c771aba42015..b4151147d5bd 100644
> >>>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> >>>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> >>>>>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2=
_m2m_dev *m2m_dev,
> >>>>>>              goto job_unlock;
> >>>>>>      }
> >>>>>>
> >>>>>> -   src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> >>>>>> -   dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> >>>>>> -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
> >>>>>> -           dprintk("No input buffers available\n");
> >>>>>> -           goto job_unlock;
> >>>>>> +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> >>>>>> +           src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> >>>>>> +
> >>>>>> +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
> >>>>>> +                   dprintk("No input buffers available\n");
> >>>>>> +                   goto job_unlock;
> >>>>>> +           }
> >>>>>>      }
> >>>>>> -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> >>>>>> -           dprintk("No output buffers available\n");
> >>>>>> -           goto job_unlock;
> >>>>>> +
> >>>>>> +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> >>>>>> +           dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> >>>>>> +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> >>>>>> +                   dprintk("No output buffers available\n");
> >>>>>> +                   goto job_unlock;
> >>>>>> +           }
> >>>>>>      }
> >>>>>
> >>>>> src and dst would be referenced unitialized below if neither of the
> >>>>> above ifs hits...
> >>>>>
> >>>>> Best regards,
> >>>>> Tomasz
> >>>>>
> >>>>>>
> >>>>>>      m2m_ctx->new_frame =3D true;
> >>>>>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, stru=
ct v4l2_m2m_ctx *m2m_ctx,
> >>>>>>      INIT_LIST_HEAD(&q_ctx->rdy_queue);
> >>>>>>      q_ctx->num_rdy =3D 0;
> >>>>>>      spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> >>>>>> +   INIT_LIST_HEAD(&q_ctx->hw_queue);
> >>>>>>
> >>>>>>      if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
> >>>>>>              m2m_dev->curr_ctx =3D NULL;
> >>>>>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struc=
t v4l2_m2m_dev *m2m_dev,
> >>>>>>
> >>>>>>      INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
> >>>>>>      INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> >>>>>> +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> >>>>>> +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
> >>>>>>      spin_lock_init(&out_q_ctx->rdy_spinlock);
> >>>>>>      spin_lock_init(&cap_q_ctx->rdy_spinlock);
> >>>>>>
> >>>>>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem=
2mem.h
> >>>>>> index d6c8eb2b5201..2342656e582d 100644
> >>>>>> --- a/include/media/v4l2-mem2mem.h
> >>>>>> +++ b/include/media/v4l2-mem2mem.h
> >>>>>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
> >>>>>>    * processed
> >>>>>>    *
> >>>>>>    * @q:             pointer to struct &vb2_queue
> >>>>>> - * @rdy_queue:     List of V4L2 mem-to-mem queues
> >>>>>> + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m_bu=
f_queue() is
> >>>>>> + *         called in struct vb2_ops->buf_queue(), the buffer enqu=
eued
> >>>>>> + *         by user would be added to this list.
> >>>>>>    * @rdy_spinlock: spin lock to protect the struct usage
> >>>>>>    * @num_rdy:       number of buffers ready to be processed
> >>>>>> + * @hw_queue:      A list for tracking the buffer is occupied by =
the hardware
> >>>>>> + *                 (or device's firmware). A buffer could only be=
 in either
> >>>>>> + *                 this list or @rdy_queue.
> >>>>>> + *                 Driver may choose not to use this list while u=
ses its own
> >>>>>> + *                 private data to do this work.
> >>>>>>    * @buffered:      is the queue buffered?
> >>>>>>    *
> >>>>>>    * Queue for buffers ready to be processed as soon as this
> >>>>>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
> >>>>>>      struct list_head        rdy_queue;
> >>>>>>      spinlock_t              rdy_spinlock;
> >>>>>>      u8                      num_rdy;
> >>>>>> +   struct list_head        hw_queue;
> >>>>>>      bool                    buffered;
> >>>>>>   };
> >>>>>>
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>>
> >>
>
> --
> Hsia-Jun(Randy) Li
