Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1950767189
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjG1QJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjG1QJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:09:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA55FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:09:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c93abeb83so32532985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690560558; x=1691165358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ld+nM/1zXTAVwHrwzbKz7bP+9LjxWSIMdgn7IeyAbR8=;
        b=Q1vZsqxv5k0kwqXFUTHXkwZL29lzoohdebSIOXXNisvMD6xdGsUbEpCkB+XSwwjWMm
         /Ns+JNfM7+4Axhhk3fhP0MgExW12v4JCBJ644wecl8sLh38VIXNzWzN5L0V0272WF5/r
         Fv91fT87rJIHlHAloXHCvYtfwy3dCyNs29SN6ZjhT1ELZncyBNhM0WtBAAeQDzv68cYM
         FCr+3xW5BF23peeYy2ZuX9Bzwb/klEyt9+KdvKArmgR1uMzanM74p3TmW2I1RXmBSWq9
         V9z2YMV9/cIrtpTr41oQZDP9cSUJ9dEu8IZffa6aJUJBBupKu/x9PLkYD+Wo1nPMUX52
         GG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560558; x=1691165358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ld+nM/1zXTAVwHrwzbKz7bP+9LjxWSIMdgn7IeyAbR8=;
        b=afvKEcaulhq4kEWurI85LiXi3eFPKgUIScsbPh1VoEawAHPKGJAfKd/o/Oz0Z61gDq
         25iCRw5VON+Y09OWvC2CArcKZ84A7IUbJHHtn2Wob0m0dBTaohKwXzddo7nd6XP4RNCS
         sASdemaGogibQ3VHuOGyRF6+pfJ0sprMnZESAFOa1kFqz0zEcFmGzvt+BkS0NDyjD7No
         LOCv8N+HQAa5c9M5/dgmtncA8LNwgvpHtijjTTUm00dxhRVWxYi42h98i5OH0KV9eNtk
         og6cCUKzYNKWqPZnnmfX6X5BXTpkCzKjxSros1+cCM/9JKbtiIWPUFXziIr4imKl5Uce
         hVTg==
X-Gm-Message-State: ABy/qLbVgxsh0dD1Dg/f8eyi+AWdIhMc/90Jhi1e58sUXlt0g1E7ZzM9
        KoQkA4FJLTEXANIw6PrtNB75dA==
X-Google-Smtp-Source: APBJJlHueX+1xKQ98oP1u1VgAUbhw2UnG/8LAs2PsXCCzwwA1g1Sg6PY8mFaSyLUc/Hu9B7qJ5Unmg==
X-Received: by 2002:ad4:4e61:0:b0:621:170:68b7 with SMTP id ec1-20020ad44e61000000b00621017068b7mr2568136qvb.35.1690560558048;
        Fri, 28 Jul 2023 09:09:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:2688::7a9])
        by smtp.gmail.com with ESMTPSA id x11-20020a0ce24b000000b0063d06946b2bsm1319744qvl.100.2023.07.28.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:09:17 -0700 (PDT)
Message-ID: <40f67a27804be5d9e85ec01bf12646908caf15a3.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <randy.li@synaptics.com>
Cc:     linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 12:09:16 -0400
In-Reply-To: <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-3-randy.li@synaptics.com>
         <20230712093301.nkj2vok2x7esdhb3@chromium.org>
         <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
         <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
         <583e22718b80cc5e1ae631528c83c95e97de5cae.camel@ndufresne.ca>
         <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com>
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

Le vendredi 28 juillet 2023 =C3=A0 13:43 +0900, Tomasz Figa a =C3=A9crit=C2=
=A0:
> On Fri, Jul 28, 2023 at 1:58=E2=80=AFAM Nicolas Dufresne <nicolas@ndufres=
ne.ca> wrote:
> >=20
> > Le jeudi 27 juillet 2023 =C3=A0 16:43 +0900, Tomasz Figa a =C3=A9crit :
> > > On Mon, Jul 17, 2023 at 11:07=E2=80=AFPM Nicolas Dufresne <nicolas@nd=
ufresne.ca> wrote:
> > > >=20
> > > > Le mercredi 12 juillet 2023 =C3=A0 09:33 +0000, Tomasz Figa a =C3=
=A9crit :
> > > > > On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
> > > > > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > > > > >=20
> > > > > > Many drivers have to create its own buf_struct for a
> > > > > > vb2_queue to track such a state. Also driver has to
> > > > > > iterate over rdy_queue every times to find out a buffer
> > > > > > which is not sent to hardware(or firmware), this new
> > > > > > list just offers the driver a place to store the buffer
> > > > > > that hardware(firmware) has acknowledged.
> > > > > >=20
> > > > > > One important advance about this list, it doesn't like
> > > > > > rdy_queue which both bottom half of the user calling
> > > > > > could operate it, while the v4l2 worker would as well.
> > > > > > The v4l2 core could only operate this queue when its
> > > > > > v4l2_context is not running, the driver would only
> > > > > > access this new hw_queue in its own worker.
> > > > >=20
> > > > > Could you describe in what case such a list would be useful for a
> > > > > mem2mem driver?
> > > >=20
> > > > Today all driver must track buffers that are "owned by the hardware=
". This is a
> > > > concept dictated by the m2m framework and enforced through the ACTI=
VE flag. All
> > > > buffers from this list must be mark as done/error/queued after stre=
amoff of the
> > > > respective queue in order to acknowledge that they are no longer in=
 use by the
> > > > HW. Not doing so will warn:
> > > >=20
> > > >   videobuf2_common: driver bug: stop_streaming operation is leaving=
 buf ...
> > > >=20
> > > > Though, there is no queue to easily iterate them. All driver endup =
having their
> > > > own queue, or just leaving the buffers in the rdy_queue (which isn'=
t better).
> > > >=20
> > >=20
> > > Thanks for the explanation. I see how it could be useful now.
> > >=20
> > > Although I guess this is a problem specifically for hardware (or
> > > firmware) which can internally queue more than 1 buffer, right?
> > > Otherwise the current buffer could just stay at the top of the
> > > rdy_queue until it's removed by the driver's completion handler,
> > > timeout/error handler or context destruction.
> >=20
> > Correct, its only an issue when you need to process multiple src buffer=
s before
> > producing a dst buffer. If affects stateful decoder, stateful encoders =
and
> > deinterlacer as far as I'm aware.
>=20
> Is it actually necessary to keep those buffers in a list in that case, th=
ough?
> I can see that a deinterlacer would indeed need 2 input buffers to
> perform the deinterlacing operation, but those would be just known to
> the driver, since it's running the task currently.
> For a stateful decoder, wouldn't it just consume the bitstream buffer
> (producing something partially decoded to its own internal buffers)
> and return it shortly?

In practice, in stateful decoder, we pace the consumption of input buffers,
otherwise we just endup consuming the entire video into a ring buffer, whic=
h
makes operation like seeks quite heavy and cause CPU spikes.

That being said, I'm not sure how useful a list would be for bitstream buff=
ers.
At the moment, in my current work, I'm leaving buffers in the ready queue, =
and
just tagging the one I have already copied into the ring buffer. And I remo=
ve
them from the ready list, when the related data has been decoded. This is w=
hen I
actually copy the timestamp from src to dst buffer. So in short, I don't us=
e an
extra list, but use some marking on the buffers though, to remember which o=
ne
have already been copied. This is specific to ring buffer based codecs of
course.

The one where a second list helps is for display picture buffers.=C2=A0When=
 a buffer
has been filled, if its in the ready queue, I currently remove that buffer =
and
put it in a custom list. It will then be removed when/if the firmware decid=
es to
display it. It may also never be displayed, and reused by the firmware. I s=
hort,
these are the frame "owned" by the firmware and containing valid pixels. Th=
e rdy
list contains free pictures buffers, and the pixels are undefined.

Maybe, and I'm ready to try, I could also leave them in ready queue and opt=
 for
marking and a counter. As I'm using a job_ready() function, its my driver t=
hat
decides if a device_run() should be executed or not. So what matters is
basically if there is a free buffer for a new decode operation, and a count=
er of
filled but not displayed buffer could probably do that.

> The most realistic scenario would be for stateful encoders which could
> keep some input buffers as reference frames for further encoding, but
> then would this patch actually work for them? It would make
> __v4l2_m2m_try_queue never add the context to the job_queue if there
> are some buffers in that hw_queue list.

Encoders have 3 set of buffers, despite m2m having two queues. OUTPUT buffe=
rs
are the pictures, there is a set of internal reconstruction buffers, and fi=
nally
the CAPTURE buffers are the bitstream. Bitstream buffers are subject to
reordering, so conceptually the firmware holds more then 1, and reconstruct=
ion
buffers are completely hidden.

>=20
> Maybe what I need here are actual patches modifying some existing
> drivers. Randy, would you be able to include that in the next version?
> Thanks.

Agreed.

>=20
> Best regards,
> Tomasz
>=20
> >=20
> > Nicolas
> >=20
> > >=20
> > > Best regards,
> > > Tomasz
> > >=20
> > > > Nicolas
> > > > >=20
> > > > > >=20
> > > > > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > > > > ---
> > > > > >  drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++-=
-------
> > > > > >  include/media/v4l2-mem2mem.h           | 10 +++++++++-
> > > > > >  2 files changed, 26 insertions(+), 9 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/m=
edia/v4l2-core/v4l2-mem2mem.c
> > > > > > index c771aba42015..b4151147d5bd 100644
> > > > > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > > > @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v=
4l2_m2m_dev *m2m_dev,
> > > > > >             goto job_unlock;
> > > > > >     }
> > > > > >=20
> > > > > > -   src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > > > > > -   dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > > > > > -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > > > > > -           dprintk("No input buffers available\n");
> > > > > > -           goto job_unlock;
> > > > > > +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> > > > > > +           src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> > > > > > +
> > > > > > +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
> > > > > > +                   dprintk("No input buffers available\n");
> > > > > > +                   goto job_unlock;
> > > > > > +           }
> > > > > >     }
> > > > > > -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > > > > > -           dprintk("No output buffers available\n");
> > > > > > -           goto job_unlock;
> > > > > > +
> > > > > > +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> > > > > > +           dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> > > > > > +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> > > > > > +                   dprintk("No output buffers available\n");
> > > > > > +                   goto job_unlock;
> > > > > > +           }
> > > > > >     }
> > > > >=20
> > > > > src and dst would be referenced unitialized below if neither of t=
he
> > > > > above ifs hits...
> > > > >=20
> > > > > Best regards,
> > > > > Tomasz
> > > > >=20
> > > > > >=20
> > > > > >     m2m_ctx->new_frame =3D true;
> > > > > > @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, s=
truct v4l2_m2m_ctx *m2m_ctx,
> > > > > >     INIT_LIST_HEAD(&q_ctx->rdy_queue);
> > > > > >     q_ctx->num_rdy =3D 0;
> > > > > >     spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> > > > > > +   INIT_LIST_HEAD(&q_ctx->hw_queue);
> > > > > >=20
> > > > > >     if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
> > > > > >             m2m_dev->curr_ctx =3D NULL;
> > > > > > @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(st=
ruct v4l2_m2m_dev *m2m_dev,
> > > > > >=20
> > > > > >     INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
> > > > > >     INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> > > > > > +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> > > > > > +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
> > > > > >     spin_lock_init(&out_q_ctx->rdy_spinlock);
> > > > > >     spin_lock_init(&cap_q_ctx->rdy_spinlock);
> > > > > >=20
> > > > > > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-=
mem2mem.h
> > > > > > index d6c8eb2b5201..2342656e582d 100644
> > > > > > --- a/include/media/v4l2-mem2mem.h
> > > > > > +++ b/include/media/v4l2-mem2mem.h
> > > > > > @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
> > > > > >   * processed
> > > > > >   *
> > > > > >   * @q:             pointer to struct &vb2_queue
> > > > > > - * @rdy_queue:     List of V4L2 mem-to-mem queues
> > > > > > + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m=
_buf_queue() is
> > > > > > + *         called in struct vb2_ops->buf_queue(), the buffer e=
nqueued
> > > > > > + *         by user would be added to this list.
> > > > > >   * @rdy_spinlock: spin lock to protect the struct usage
> > > > > >   * @num_rdy:       number of buffers ready to be processed
> > > > > > + * @hw_queue:      A list for tracking the buffer is occupied =
by the hardware
> > > > > > + *                 (or device's firmware). A buffer could only=
 be in either
> > > > > > + *                 this list or @rdy_queue.
> > > > > > + *                 Driver may choose not to use this list whil=
e uses its own
> > > > > > + *                 private data to do this work.
> > > > > >   * @buffered:      is the queue buffered?
> > > > > >   *
> > > > > >   * Queue for buffers ready to be processed as soon as this
> > > > > > @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
> > > > > >     struct list_head        rdy_queue;
> > > > > >     spinlock_t              rdy_spinlock;
> > > > > >     u8                      num_rdy;
> > > > > > +   struct list_head        hw_queue;
> > > > > >     bool                    buffered;
> > > > > >  };
> > > > > >=20
> > > > > > --
> > > > > > 2.17.1
> > > > > >=20
> > > >=20
> >=20

