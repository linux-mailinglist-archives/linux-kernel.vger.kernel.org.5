Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6F765950
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjG0Q6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjG0Q6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:58:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCAA9E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:58:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4052d327682so11263581cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690477083; x=1691081883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DGpD1fj0PXv450sjuK4bUou4/t1cGfwJ84zl83bJ1T0=;
        b=SEW+MFQo2D8TQfjQqYawou4aHfj4BYHAKdSeICESAHr+bt0jzpqTb3bYFysTLIHEjm
         TZA+dFp4mSVfKfEAkBtHOydfbRBguVRIqiCQbmOrLw3Gsy8uH0/iJ9w3/YJVyNEI4/nM
         brVwYh5au/ALLNdr5wfb5OyZsSEo6Ag2iPmOzB8QNLs82+iN3lIro6gDHGG+h8CtX6wa
         ywxwhUKgf1/wSb1wCZZqjKEvu+ettobE8uBg5G3l0wpGYSS9C9xzYB9lnxLU7jQnN8xJ
         IeCZ2hw+QfkDkxoa1nLh2I3UnIgcExpdgyXtDPK8TYkF0zUV6u9IxUTvV3uSwkqj5qi9
         jQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477083; x=1691081883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGpD1fj0PXv450sjuK4bUou4/t1cGfwJ84zl83bJ1T0=;
        b=hN8aVMR9QItkKp9d8kIXSlsS27YhvBimttzmhyz75yc3N90wwUjBGq3Cs+RA9i8Hdj
         XvjYdV1lB3lNYQ3Q2RhSRxUsvohvRTccTdzptp91XSVEaLMaPtFG1ch1xShsHrEtrwRb
         xs/wbCx453EFKTyk4GQr8KEaKKXv5ONlQ3WGe4u1qMl2E2uby8OSe/sNUTCTDd80rSqi
         U0V3vkrbTO+R64I8Okb0ZqN6Hl+NPCBJUZe1V81RhLH727CL0MSBSgwHDOPdkvWiynFi
         K6fl/4RiyozcZolzj8FNdEKej6K/o/Oawq9lZl1iAJkfWuvpNtnvkHvh2VIxMDVyRKXV
         cGhg==
X-Gm-Message-State: ABy/qLaq/JijHFFUUc8BoGeIlLteYk0VeY+/vJCS6BYm+wuMZkVFRaYZ
        lMT6WqkKms5EsfpDsTZikPVUOFBN9a9xl6Akoby7ZQ==
X-Google-Smtp-Source: APBJJlH5vVGzZ46pKLCUH8Mp+07XMUhph3BHbC5VIX35SbNLRle+mxNSsZoq0+kRNbMjZMX8U//0sA==
X-Received: by 2002:ad4:4eaa:0:b0:63c:f325:bb03 with SMTP id ed10-20020ad44eaa000000b0063cf325bb03mr866321qvb.8.1690477083581;
        Thu, 27 Jul 2023 09:58:03 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:580::7a9])
        by smtp.gmail.com with ESMTPSA id a18-20020a0cb352000000b006262de12a8csm547061qvf.65.2023.07.27.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:58:03 -0700 (PDT)
Message-ID: <583e22718b80cc5e1ae631528c83c95e97de5cae.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        ayaka@soulik.info, hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jul 2023 12:58:02 -0400
In-Reply-To: <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-3-randy.li@synaptics.com>
         <20230712093301.nkj2vok2x7esdhb3@chromium.org>
         <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
         <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 27 juillet 2023 =C3=A0 16:43 +0900, Tomasz Figa a =C3=A9crit=C2=A0=
:
> On Mon, Jul 17, 2023 at 11:07=E2=80=AFPM Nicolas Dufresne <nicolas@ndufre=
sne.ca> wrote:
> >=20
> > Le mercredi 12 juillet 2023 =C3=A0 09:33 +0000, Tomasz Figa a =C3=A9cri=
t :
> > > On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
> > > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > > >=20
> > > > Many drivers have to create its own buf_struct for a
> > > > vb2_queue to track such a state. Also driver has to
> > > > iterate over rdy_queue every times to find out a buffer
> > > > which is not sent to hardware(or firmware), this new
> > > > list just offers the driver a place to store the buffer
> > > > that hardware(firmware) has acknowledged.
> > > >=20
> > > > One important advance about this list, it doesn't like
> > > > rdy_queue which both bottom half of the user calling
> > > > could operate it, while the v4l2 worker would as well.
> > > > The v4l2 core could only operate this queue when its
> > > > v4l2_context is not running, the driver would only
> > > > access this new hw_queue in its own worker.
> > >=20
> > > Could you describe in what case such a list would be useful for a
> > > mem2mem driver?
> >=20
> > Today all driver must track buffers that are "owned by the hardware". T=
his is a
> > concept dictated by the m2m framework and enforced through the ACTIVE f=
lag. All
> > buffers from this list must be mark as done/error/queued after streamof=
f of the
> > respective queue in order to acknowledge that they are no longer in use=
 by the
> > HW. Not doing so will warn:
> >=20
> >   videobuf2_common: driver bug: stop_streaming operation is leaving buf=
 ...
> >=20
> > Though, there is no queue to easily iterate them. All driver endup havi=
ng their
> > own queue, or just leaving the buffers in the rdy_queue (which isn't be=
tter).
> >=20
>=20
> Thanks for the explanation. I see how it could be useful now.
>=20
> Although I guess this is a problem specifically for hardware (or
> firmware) which can internally queue more than 1 buffer, right?
> Otherwise the current buffer could just stay at the top of the
> rdy_queue until it's removed by the driver's completion handler,
> timeout/error handler or context destruction.

Correct, its only an issue when you need to process multiple src buffers be=
fore
producing a dst buffer. If affects stateful decoder, stateful encoders and
deinterlacer as far as I'm aware.

Nicolas

>=20
> Best regards,
> Tomasz
>=20
> > Nicolas
> > >=20
> > > >=20
> > > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > > ---
> > > >  drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++-----=
---
> > > >  include/media/v4l2-mem2mem.h           | 10 +++++++++-
> > > >  2 files changed, 26 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media=
/v4l2-core/v4l2-mem2mem.c
> > > > index c771aba42015..b4151147d5bd 100644
> > > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_=
m2m_dev *m2m_dev,
> > > >             goto job_unlock;
> > > >     }
> > > >=20
> > > > -   src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > > > -   dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > > > -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > > > -           dprintk("No input buffers available\n");
> > > > -           goto job_unlock;
> > > > +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> > > > +           src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > > > +
> > > > +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > > > +                   dprintk("No input buffers available\n");
> > > > +                   goto job_unlock;
> > > > +           }
> > > >     }
> > > > -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > > > -           dprintk("No output buffers available\n");
> > > > -           goto job_unlock;
> > > > +
> > > > +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> > > > +           dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > > > +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > > > +                   dprintk("No output buffers available\n");
> > > > +                   goto job_unlock;
> > > > +           }
> > > >     }
> > >=20
> > > src and dst would be referenced unitialized below if neither of the
> > > above ifs hits...
> > >=20
> > > Best regards,
> > > Tomasz
> > >=20
> > > >=20
> > > >     m2m_ctx->new_frame =3D true;
> > > > @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struc=
t v4l2_m2m_ctx *m2m_ctx,
> > > >     INIT_LIST_HEAD(&q_ctx->rdy_queue);
> > > >     q_ctx->num_rdy =3D 0;
> > > >     spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> > > > +   INIT_LIST_HEAD(&q_ctx->hw_queue);
> > > >=20
> > > >     if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
> > > >             m2m_dev->curr_ctx =3D NULL;
> > > > @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct=
 v4l2_m2m_dev *m2m_dev,
> > > >=20
> > > >     INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
> > > >     INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> > > > +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> > > > +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
> > > >     spin_lock_init(&out_q_ctx->rdy_spinlock);
> > > >     spin_lock_init(&cap_q_ctx->rdy_spinlock);
> > > >=20
> > > > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2=
mem.h
> > > > index d6c8eb2b5201..2342656e582d 100644
> > > > --- a/include/media/v4l2-mem2mem.h
> > > > +++ b/include/media/v4l2-mem2mem.h
> > > > @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
> > > >   * processed
> > > >   *
> > > >   * @q:             pointer to struct &vb2_queue
> > > > - * @rdy_queue:     List of V4L2 mem-to-mem queues
> > > > + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m_buf=
_queue() is
> > > > + *         called in struct vb2_ops->buf_queue(), the buffer enque=
ued
> > > > + *         by user would be added to this list.
> > > >   * @rdy_spinlock: spin lock to protect the struct usage
> > > >   * @num_rdy:       number of buffers ready to be processed
> > > > + * @hw_queue:      A list for tracking the buffer is occupied by t=
he hardware
> > > > + *                 (or device's firmware). A buffer could only be =
in either
> > > > + *                 this list or @rdy_queue.
> > > > + *                 Driver may choose not to use this list while us=
es its own
> > > > + *                 private data to do this work.
> > > >   * @buffered:      is the queue buffered?
> > > >   *
> > > >   * Queue for buffers ready to be processed as soon as this
> > > > @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
> > > >     struct list_head        rdy_queue;
> > > >     spinlock_t              rdy_spinlock;
> > > >     u8                      num_rdy;
> > > > +   struct list_head        hw_queue;
> > > >     bool                    buffered;
> > > >  };
> > > >=20
> > > > --
> > > > 2.17.1
> > > >=20
> >=20

