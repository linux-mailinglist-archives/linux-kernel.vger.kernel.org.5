Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6977F764666
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjG0GFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjG0GFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F4EC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690437854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERmF9zdnwQnncOVhFORT4PHWXzJ5Avyj/gIeOqR4Hrs=;
        b=bcXbyMGhpJd8oImhbEnlQ6coc0jQB8WOWAlR2fs4siaIbGCRYkaInNAyLMPcacRbkHRm0b
        xTK67uCyIrblU2tnTRNG/SvoOgB3QqP9ctnT1p/1mirzZRKqt4ZRNOkbl8BhHt25A4f+zb
        DXHEVejO0acfr0nXT3fKQc0XwcADjYc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-2K0QfvBsOB2rWVDxaUt7mA-1; Thu, 27 Jul 2023 02:04:13 -0400
X-MC-Unique: 2K0QfvBsOB2rWVDxaUt7mA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6fbed5189so4287991fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437851; x=1691042651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERmF9zdnwQnncOVhFORT4PHWXzJ5Avyj/gIeOqR4Hrs=;
        b=aQCJnTUzvYGdsx4elf8V5Cdds+kk+FWZwTPbgKW45gEGZirlg2mA76lfe8FzJVp1Sj
         UODtAMRtFTX0eYxDO2kERLtJs+834gAao3XxV03tIjweMpgPlbi+l6+tn2Sau9Zh7WVq
         8d/yAJ9mTT/a+Yjr/8xT7q9C2xX9TiDB71P6rVVV7TsD/0JH/SlNZ4EN7rLn3do60PPt
         PuyyKDq4oztjRy1mw/ZUb4bdxwc9r7nOJnvcueuDy6bpwzlPdkdwJ/ae0mHJX34wguZG
         H4ijXgNQtC1ekZO3r7+L8cbvYXka7CqleObksks+Fq5bsfNDTbkcatwKE7OAcOEmgvY/
         nrZA==
X-Gm-Message-State: ABy/qLZdD92v9nFKVJbCqgM80+i/56cJlWt/2TqSjxoqC+2EWzGM+GOn
        jUELM6hlLQPQ62dORUSXk/ob+Lzw+ItA5M9Mpp+oikRco20LFC4pxMi27z+KwHQkfW+w/MrjA70
        wRkg3WK6DOzOB0YQAgw9Xrx/A+3IkKE683gUVs6OplT/r4yXIcI0=
X-Received: by 2002:a2e:7d0f:0:b0:2a7:adf7:1781 with SMTP id y15-20020a2e7d0f000000b002a7adf71781mr886247ljc.2.1690437851568;
        Wed, 26 Jul 2023 23:04:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGJ+wg/Ce1LBxht0mOx0tsOAY3PdEIQoMv1e0/Q3XAPRgHquTlMcfPhw2vIjOSYB1sw2+IU/RGZq4y+QmqT41E=
X-Received: by 2002:a2e:7d0f:0:b0:2a7:adf7:1781 with SMTP id
 y15-20020a2e7d0f000000b002a7adf71781mr886220ljc.2.1690437851120; Wed, 26 Jul
 2023 23:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org> <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org> <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org> <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org> <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230726073453-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 27 Jul 2023 14:03:59 +0800
Message-ID: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 7:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 26, 2023 at 09:55:37AM +0800, Jason Wang wrote:
> > On Tue, Jul 25, 2023 at 3:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 11:07:40AM +0800, Jason Wang wrote:
> > > > On Mon, Jul 24, 2023 at 3:17=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > > > > > On Sat, Jul 22, 2023 at 4:18=E2=80=AFAM Maxime Coquelin
> > > > > > <maxime.coquelin@redhat.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin w=
rote:
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin=
 wrote:
> > > > > > > >>>>
> > > > > > > >>>>
> > > > > > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelso=
n wrote:
> > > > > > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> Adding cond_resched() to the command waiting loop for=
 a better
> > > > > > > >>>>>>> co-operation with the scheduler. This allows to give =
CPU a breath to
> > > > > > > >>>>>>> run other task(workqueue) instead of busy looping whe=
n preemption is
> > > > > > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > >>>>>>
> > > > > > > >>>>>> This still leaves hung processes, but at least it does=
n't pin the CPU any
> > > > > > > >>>>>> more.  Thanks.
> > > > > > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > >>>>>>
> > > > > > > >>>>>
> > > > > > > >>>>> I'd like to see a full solution
> > > > > > > >>>>> 1- block until interrupt
> > > > > >
> > > > > > I remember in previous versions, you worried about the extra MS=
I
> > > > > > vector. (Maybe I was wrong).
> > > > > >
> > > > > > > >>>>
> > > > > > > >>>> Would it make sense to also have a timeout?
> > > > > > > >>>> And when timeout expires, set FAILED bit in device statu=
s?
> > > > > > > >>>
> > > > > > > >>> virtio spec does not set any limits on the timing of vq
> > > > > > > >>> processing.
> > > > > > > >>
> > > > > > > >> Indeed, but I thought the driver could decide it is too lo=
ng for it.
> > > > > > > >>
> > > > > > > >> The issue is we keep waiting with rtnl locked, it can quic=
kly make the
> > > > > > > >> system unusable.
> > > > > > > >
> > > > > > > > if this is a problem we should find a way not to keep rtnl
> > > > > > > > locked indefinitely.
> > > > > >
> > > > > > Any ideas on this direction? Simply dropping rtnl during the bu=
sy loop
> > > > > > will result in a lot of races. This seems to require non-trivia=
l
> > > > > > changes in the networking core.
> > > > > >
> > > > > > >
> > > > > > >  From the tests I have done, I think it is. With OVS, a recon=
figuration
> > > > > > > is performed when the VDUSE device is added, and when a MLX5 =
device is
> > > > > > > in the same bridge, it ends up doing an ioctl() that tries to=
 take the
> > > > > > > rtnl lock. In this configuration, it is not possible to kill =
OVS because
> > > > > > > it is stuck trying to acquire rtnl lock for mlx5 that is held=
 by virtio-
> > > > > > > net.
> > > > > >
> > > > > > Yeah, basically, any RTNL users would be blocked forever.
> > > > > >
> > > > > > And the infinite loop has other side effects like it blocks the=
 freezer to work.
> > > > > >
> > > > > > To summarize, there are three issues
> > > > > >
> > > > > > 1) busy polling
> > > > > > 2) breaks freezer
> > > > > > 3) hold RTNL during the loop
> > > > > >
> > > > > > Solving 3 may help somehow for 2 e.g some pm routine e.g wiregu=
ard or
> > > > > > even virtnet_restore() itself may try to hold the lock.
> > > > >
> > > > > Yep. So my feeling currently is, the only real fix is to actually
> > > > > queue up the work in software.
> > > >
> > > > Do you mean something like:
> > > >
> > > > rtnl_lock();
> > > > queue up the work
> > > > rtnl_unlock();
> > > > return success;
> > > >
> > > > ?
> > >
> > > yes
> >
> > We will lose the error reporting, is it a real problem or not?
>
> Fundamental isn't it? Maybe we want a per-device flag for a asynch comman=
ds,
> and vduse will set it while hardware virtio won't.
> this way we only lose error reporting for vduse.

This problem is not VDUSE specific, DPUs/vDPA may suffer from this as
well. This might require more thoughts.

Thanks

>
> > >
> > >
> > > > > It's mostly trivial to limit
> > > > > memory consumption, vid's is the
> > > > > only one where it would make sense to have more than
> > > > > 1 command of a given type outstanding.
> > > >
> > > > And rx mode so this implies we will fail any command if the previou=
s
> > > > work is not finished.
> > >
> > > don't fail it, store it.
> >
> > Ok.
> >
> > Thanks
> >
> > >
> > > > > have a tree
> > > > > or a bitmap with vids to add/remove?
> > > >
> > > > Probably.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >>>>> 2- still handle surprise removal correctly by waking in=
 that case
> > > > > >
> > > > > > This is basically what version 1 did?
> > > > > >
> > > > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a803686=
21@redhat.com/t/
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Yes - except the timeout part.
> > > > >
> > > > >
> > > > > > > >>>>>
> > > > > > > >>>>>
> > > > > > > >>>>>
> > > > > > > >>>>>>> ---
> > > > > > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > > > > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/v=
irtio_net.c
> > > > > > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > > > > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > > > > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_comma=
nd(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > >>>>>>>              * into the hypervisor, so the request sh=
ould be handled immediately.
> > > > > > > >>>>>>>              */
> > > > > > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) =
&&
> > > > > > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > > > > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > >>>>>>> +               cond_resched();
> > > > > > > >>>>>>>                     cpu_relax();
> > > > > > > >>>>>>> +       }
> > > > > > > >>>>>>>
> > > > > > > >>>>>>>             return vi->ctrl->status =3D=3D VIRTIO_NET=
_OK;
> > > > > > > >>>>>>>      }
> > > > > > > >>>>>>> --
> > > > > > > >>>>>>> 2.39.3
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> _______________________________________________
> > > > > > > >>>>>>> Virtualization mailing list
> > > > > > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > > > > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/vi=
rtualization
> > > > > > > >>>>>
> > > > > > > >>>
> > > > > > > >
> > > > > > >
> > > > >
> > >
>

