Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395617648CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjG0HgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjG0Hfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:35:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0653AD31
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:25:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76571dae5feso58608585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690442714; x=1691047514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6qbtNcmszQ6EQo0mvb3858AOVM9yDgbycyUD/QntYs=;
        b=TBeDFHw2o1PPT5oMbU+NDPXsSrWYU3P2m4Mdr7KGxZTUTGIIRKl8iOw9Xef7A5De3V
         lfBCHyxkPS086WdwtSKG/K2m/tVqSDPVr0+F+0PFSDki3rnCPm8D5nXRR4gnR+1GzQ8S
         Hmh4heKpIKs+6LN1VtUFl9O8QW4jj15NCAeio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690442714; x=1691047514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6qbtNcmszQ6EQo0mvb3858AOVM9yDgbycyUD/QntYs=;
        b=k1jkglw57um09798jyI6eJeG0WgTxjCEpiUwuOxe7/cNpixNzxI3C/5LkU5Fh0CE8S
         HeKnd0Dqo24UjuSzWIHjMnVcntiqJ4gPzrHJA5L8Pka97NoTbK4Ka9VaJL31X4x7VHTg
         YocrpbWEEEceC16TGEZCxHRhtm9vyb9yJKYzoAQmZ4WYiSFl+ukKfEhy9GOOZf9VDs2T
         qGrIuBmun3pQhD1oAXRAkniIhD4r4xnGlkQ6L0/PX4u9M2aSqTXxqdVRcaKi8HQCn7qV
         u79U6DEiku7HrqBnaEAZSaBW081Vg801kYZtikqVGmS66O1Eyx5gsHYu72YHhbj6gUIl
         NjZA==
X-Gm-Message-State: ABy/qLbvCMdmr+Ccd2y07HYY10z9VPq8q1ENsHvbxzw7P1CjlTOWGhvT
        MsYjFAvsy9fwfbQSsk7sC6S5Znl69xHeU68qqlU4tQ==
X-Google-Smtp-Source: APBJJlFZV7VqpRyq1DtvMNloSWgtrEOWEiQ5B0GdM36rx0w1bCzEpMyCSHAd6clg+IcT4vx48+1akg==
X-Received: by 2002:a05:620a:2546:b0:767:f49c:1d67 with SMTP id s6-20020a05620a254600b00767f49c1d67mr4775126qko.1.1690442714176;
        Thu, 27 Jul 2023 00:25:14 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id s11-20020ae9f70b000000b00767b0c35c15sm225959qkg.91.2023.07.27.00.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:25:13 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-63d30b90197so4587046d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:25:12 -0700 (PDT)
X-Received: by 2002:a0c:dd0b:0:b0:63d:212e:8ae7 with SMTP id
 u11-20020a0cdd0b000000b0063d212e8ae7mr3764157qvk.14.1690442712330; Thu, 27
 Jul 2023 00:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com> <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <4e70c8b8-d459-2b79-2b3d-40875f701d97@synaptics.com>
In-Reply-To: <4e70c8b8-d459-2b79-2b3d-40875f701d97@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 27 Jul 2023 16:25:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CGO4iiC7HX9wTetuzjZyaAsKStFOpxqcFkZ_o-eJOPtg@mail.gmail.com>
Message-ID: <CAAFQd5CGO4iiC7HX9wTetuzjZyaAsKStFOpxqcFkZ_o-eJOPtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        nicolas@ndufresne.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 4:15=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
>
>
> On 7/12/23 17:33, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
> >> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> >>
> >> Many drivers have to create its own buf_struct for a
> >> vb2_queue to track such a state. Also driver has to
> >> iterate over rdy_queue every times to find out a buffer
> >> which is not sent to hardware(or firmware), this new
> >> list just offers the driver a place to store the buffer
> >> that hardware(firmware) has acknowledged.
> >>
> >> One important advance about this list, it doesn't like
> >> rdy_queue which both bottom half of the user calling
> >> could operate it, while the v4l2 worker would as well.
> >> The v4l2 core could only operate this queue when its
> >> v4l2_context is not running, the driver would only
> >> access this new hw_queue in its own worker.
> > Could you describe in what case such a list would be useful for a
> > mem2mem driver?
>
> This list, as its description, just for saving us from creating a
> private buffer struct to track buffer state.
>
> The queue in the kernel is not the queue that hardware(codec firmware)
> are using.
>

Sorry, I find the description difficult to understand. It might make
sense to have the text proofread by someone experienced in writing
technical documentation in English before posting in the future.
Thanks.

I think I got the point from Nicolas' explanation, though.

>
> >> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> >> ---
> >>   drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++-------=
-
> >>   include/media/v4l2-mem2mem.h           | 10 +++++++++-
> >>   2 files changed, 26 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4=
l2-core/v4l2-mem2mem.c
> >> index c771aba42015..b4151147d5bd 100644
> >> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> >> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> >> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m=
_dev *m2m_dev,
> >>                goto job_unlock;
> >>        }
> >>
> >> -     src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> >> -     dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> >> -     if (!src && !m2m_ctx->out_q_ctx.buffered) {
> >> -             dprintk("No input buffers available\n");
> >> -             goto job_unlock;
> >> +     if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> >> +             src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> >> +
> >> +             if (!src && !m2m_ctx->out_q_ctx.buffered) {
> >> +                     dprintk("No input buffers available\n");
> >> +                     goto job_unlock;
> >> +             }
> >>        }
> >> -     if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> >> -             dprintk("No output buffers available\n");
> >> -             goto job_unlock;
> >> +
> >> +     if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> >> +             dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> >> +             if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> >> +                     dprintk("No output buffers available\n");
> >> +                     goto job_unlock;
> >> +             }
> >>        }
> > src and dst would be referenced unitialized below if neither of the
> > above ifs hits...
> I think they have been initialized at v4l2_m2m_ctx_init()

What do you mean? They are local variables in this function.

> >
> > Best regards,
> > Tomasz
> >
> >>        m2m_ctx->new_frame =3D true;
> >> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v=
4l2_m2m_ctx *m2m_ctx,
> >>        INIT_LIST_HEAD(&q_ctx->rdy_queue);
> >>        q_ctx->num_rdy =3D 0;
> >>        spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> >> +     INIT_LIST_HEAD(&q_ctx->hw_queue);
> >>
> >>        if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
> >>                m2m_dev->curr_ctx =3D NULL;
> >> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4=
l2_m2m_dev *m2m_dev,
> >>
> >>        INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
> >>        INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> >> +     INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> >> +     INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
> >>        spin_lock_init(&out_q_ctx->rdy_spinlock);
> >>        spin_lock_init(&cap_q_ctx->rdy_spinlock);
> >>
> >> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem=
.h
> >> index d6c8eb2b5201..2342656e582d 100644
> >> --- a/include/media/v4l2-mem2mem.h
> >> +++ b/include/media/v4l2-mem2mem.h
> >> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
> >>    *   processed
> >>    *
> >>    * @q:               pointer to struct &vb2_queue
> >> - * @rdy_queue:       List of V4L2 mem-to-mem queues
> >> + * @rdy_queue:       List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_=
queue() is
> >> + *           called in struct vb2_ops->buf_queue(), the buffer enqueu=
ed
> >> + *           by user would be added to this list.
> >>    * @rdy_spinlock: spin lock to protect the struct usage
> >>    * @num_rdy: number of buffers ready to be processed
> >> + * @hw_queue:        A list for tracking the buffer is occupied by th=
e hardware
> >> + *           (or device's firmware). A buffer could only be in either
> >> + *           this list or @rdy_queue.
> >> + *           Driver may choose not to use this list while uses its ow=
n
> >> + *           private data to do this work.
> >>    * @buffered:        is the queue buffered?
> >>    *
> >>    * Queue for buffers ready to be processed as soon as this
> >> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
> >>        struct list_head        rdy_queue;
> >>        spinlock_t              rdy_spinlock;
> >>        u8                      num_rdy;
> >> +     struct list_head        hw_queue;
> >>        bool                    buffered;
> >>   };
> >>
> >> --
> >> 2.17.1
> >>
> --
> Hsia-Jun(Randy) Li
>
