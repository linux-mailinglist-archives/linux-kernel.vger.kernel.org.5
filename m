Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3285B764F04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjG0JOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjG0JNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA8768F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690448387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03oOF7vVj5UKxL75ZQcK8QbPvXNKmVEl+3ApUJjoHnU=;
        b=M2/ZKM+871OqgSg50V4JbRzsozFDpRNoUyEgOps3UfT9OmyleowKyZWByN9PvPMPHj6cCX
        KMuVAVYZ3t32y5sPajHEyL3GM2ILh8ymx2HQbZbQ9t9J4UwMxZmokORGAQiE3356Vw0Zi6
        nepuTAH+81KIBR9H4a2erCmpt5g1VOQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-_MNswnj-M1CEwnOAVah_7Q-1; Thu, 27 Jul 2023 04:59:46 -0400
X-MC-Unique: _MNswnj-M1CEwnOAVah_7Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9b820c94fso6437191fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448384; x=1691053184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03oOF7vVj5UKxL75ZQcK8QbPvXNKmVEl+3ApUJjoHnU=;
        b=el6+6lK7vrhHXSzVbCcLoxQo8STDvb7c6++MclA8XwrkvK2e7hXn2YiwQ2DH+COLBp
         m+EpXGtP1bL6JeMmeOjSQCYNsyVlp7yp37DQ8XNZhaflrhouwpmzzw1Ro1GUH9/mf5GV
         xVQn6bYqhosb+U8B664PFKQ2CqSymfz8Fl92i0Ebv2MI6IaDkeBGqGUichoPNr7OqJJl
         KphBYoaSvoAEO9R2A/+OdkxHhVg/K718QRu+mKabhAnsAvsWNchMHQrnI8/lYLdhnqiy
         Kx9tBZL0OU5gKCCDCTW4TbYnNqwf7O96IpZ4LlRyU7G0KsnE7VZsnfIsA2zcZoI6rbaX
         GqXg==
X-Gm-Message-State: ABy/qLa+rM5MHDp3TxUrhSP6RfNBWphAziTHOnaOILJ56t6OM1NqqsRB
        aYCHUxtz6PRrhm616gqsYQU2Xo0uY34PNFaUOuCyMRtOLyzUyArkksPv24tb49cctXjMMwXgWGJ
        VGn3tef6q3weFUFDRID7W8uvDgOwzeLC/2Ei4OrP/
X-Received: by 2002:a2e:9c10:0:b0:2b6:e719:324e with SMTP id s16-20020a2e9c10000000b002b6e719324emr1191513lji.49.1690448384601;
        Thu, 27 Jul 2023 01:59:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHta/cwZDR4YvqZd7bkc+MnqB/nYdlybw3rLP1YeL9CwKygmbdMr6fEdy2Lpxr/bmjs7Sv7CuvCV3CAuMBEsOU=
X-Received: by 2002:a2e:9c10:0:b0:2b6:e719:324e with SMTP id
 s16-20020a2e9c10000000b002b6e719324emr1191498lji.49.1690448384237; Thu, 27
 Jul 2023 01:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org> <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org> <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org> <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org> <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727020930-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 27 Jul 2023 16:59:33 +0800
Message-ID: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 27, 2023 at 02:03:59PM +0800, Jason Wang wrote:
> > On Wed, Jul 26, 2023 at 7:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Jul 26, 2023 at 09:55:37AM +0800, Jason Wang wrote:
> > > > On Tue, Jul 25, 2023 at 3:36=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Jul 25, 2023 at 11:07:40AM +0800, Jason Wang wrote:
> > > > > > On Mon, Jul 24, 2023 at 3:17=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > > > > > > > On Sat, Jul 22, 2023 at 4:18=E2=80=AFAM Maxime Coquelin
> > > > > > > > <maxime.coquelin@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquel=
in wrote:
> > > > > > > > > >>
> > > > > > > > > >>
> > > > > > > > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > > > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coqu=
elin wrote:
> > > > > > > > > >>>>
> > > > > > > > > >>>>
> > > > > > > > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon N=
elson wrote:
> > > > > > > > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > > >>>>>>>
> > > > > > > > > >>>>>>> Adding cond_resched() to the command waiting loop=
 for a better
> > > > > > > > > >>>>>>> co-operation with the scheduler. This allows to g=
ive CPU a breath to
> > > > > > > > > >>>>>>> run other task(workqueue) instead of busy looping=
 when preemption is
> > > > > > > > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > > > > > > > >>>>>>>
> > > > > > > > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>> This still leaves hung processes, but at least it =
doesn't pin the CPU any
> > > > > > > > > >>>>>> more.  Thanks.
> > > > > > > > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.co=
m>
> > > > > > > > > >>>>>>
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> I'd like to see a full solution
> > > > > > > > > >>>>> 1- block until interrupt
> > > > > > > >
> > > > > > > > I remember in previous versions, you worried about the extr=
a MSI
> > > > > > > > vector. (Maybe I was wrong).
> > > > > > > >
> > > > > > > > > >>>>
> > > > > > > > > >>>> Would it make sense to also have a timeout?
> > > > > > > > > >>>> And when timeout expires, set FAILED bit in device s=
tatus?
> > > > > > > > > >>>
> > > > > > > > > >>> virtio spec does not set any limits on the timing of =
vq
> > > > > > > > > >>> processing.
> > > > > > > > > >>
> > > > > > > > > >> Indeed, but I thought the driver could decide it is to=
o long for it.
> > > > > > > > > >>
> > > > > > > > > >> The issue is we keep waiting with rtnl locked, it can =
quickly make the
> > > > > > > > > >> system unusable.
> > > > > > > > > >
> > > > > > > > > > if this is a problem we should find a way not to keep r=
tnl
> > > > > > > > > > locked indefinitely.
> > > > > > > >
> > > > > > > > Any ideas on this direction? Simply dropping rtnl during th=
e busy loop
> > > > > > > > will result in a lot of races. This seems to require non-tr=
ivial
> > > > > > > > changes in the networking core.
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  From the tests I have done, I think it is. With OVS, a r=
econfiguration
> > > > > > > > > is performed when the VDUSE device is added, and when a M=
LX5 device is
> > > > > > > > > in the same bridge, it ends up doing an ioctl() that trie=
s to take the
> > > > > > > > > rtnl lock. In this configuration, it is not possible to k=
ill OVS because
> > > > > > > > > it is stuck trying to acquire rtnl lock for mlx5 that is =
held by virtio-
> > > > > > > > > net.
> > > > > > > >
> > > > > > > > Yeah, basically, any RTNL users would be blocked forever.
> > > > > > > >
> > > > > > > > And the infinite loop has other side effects like it blocks=
 the freezer to work.
> > > > > > > >
> > > > > > > > To summarize, there are three issues
> > > > > > > >
> > > > > > > > 1) busy polling
> > > > > > > > 2) breaks freezer
> > > > > > > > 3) hold RTNL during the loop
> > > > > > > >
> > > > > > > > Solving 3 may help somehow for 2 e.g some pm routine e.g wi=
reguard or
> > > > > > > > even virtnet_restore() itself may try to hold the lock.
> > > > > > >
> > > > > > > Yep. So my feeling currently is, the only real fix is to actu=
ally
> > > > > > > queue up the work in software.
> > > > > >
> > > > > > Do you mean something like:
> > > > > >
> > > > > > rtnl_lock();
> > > > > > queue up the work
> > > > > > rtnl_unlock();
> > > > > > return success;
> > > > > >
> > > > > > ?
> > > > >
> > > > > yes
> > > >
> > > > We will lose the error reporting, is it a real problem or not?
> > >
> > > Fundamental isn't it? Maybe we want a per-device flag for a asynch co=
mmands,
> > > and vduse will set it while hardware virtio won't.
> > > this way we only lose error reporting for vduse.
> >
> > This problem is not VDUSE specific, DPUs/vDPA may suffer from this as
> > well. This might require more thoughts.
> >
> > Thanks
>
> They really shouldn't - any NIC that takes forever to
> program will create issues in the networking stack.

Unfortunately, it's not rare as the device/cvq could be implemented
via firmware or software.

> But if they do they can always set this flag too.

This may have false negatives and may confuse the management.

Maybe we can extend the networking core to allow some device specific
configurations to be done with device specific lock without rtnl. For
example, split the set_channels to

pre_set_channels
set_channels
post_set_channels

The device specific part could be done in pre and post without a rtnl lock?

Thanks



>
> > >
> > > > >
> > > > >
> > > > > > > It's mostly trivial to limit
> > > > > > > memory consumption, vid's is the
> > > > > > > only one where it would make sense to have more than
> > > > > > > 1 command of a given type outstanding.
> > > > > >
> > > > > > And rx mode so this implies we will fail any command if the pre=
vious
> > > > > > work is not finished.
> > > > >
> > > > > don't fail it, store it.
> > > >
> > > > Ok.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > have a tree
> > > > > > > or a bitmap with vids to add/remove?
> > > > > >
> > > > > > Probably.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >>>>> 2- still handle surprise removal correctly by wakin=
g in that case
> > > > > > > >
> > > > > > > > This is basically what version 1 did?
> > > > > > > >
> > > > > > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80=
368621@redhat.com/t/
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Yes - except the timeout part.
> > > > > > >
> > > > > > >
> > > > > > > > > >>>>>
> > > > > > > > > >>>>>
> > > > > > > > > >>>>>
> > > > > > > > > >>>>>>> ---
> > > > > > > > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(=
-)
> > > > > > > > > >>>>>>>
> > > > > > > > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/n=
et/virtio_net.c
> > > > > > > > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > > > > > > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > > > > > > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_c=
ommand(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > > >>>>>>>              * into the hypervisor, so the reques=
t should be handled immediately.
> > > > > > > > > >>>>>>>              */
> > > > > > > > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &t=
mp) &&
> > > > > > > > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > >>>>>>> +               cond_resched();
> > > > > > > > > >>>>>>>                     cpu_relax();
> > > > > > > > > >>>>>>> +       }
> > > > > > > > > >>>>>>>
> > > > > > > > > >>>>>>>             return vi->ctrl->status =3D=3D VIRTIO=
_NET_OK;
> > > > > > > > > >>>>>>>      }
> > > > > > > > > >>>>>>> --
> > > > > > > > > >>>>>>> 2.39.3
> > > > > > > > > >>>>>>>
> > > > > > > > > >>>>>>> _______________________________________________
> > > > > > > > > >>>>>>> Virtualization mailing list
> > > > > > > > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > > > > > > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinf=
o/virtualization
> > > > > > > > > >>>>>
> > > > > > > > > >>>
> > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

