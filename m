Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870667CC568
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbjJQOAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjJQOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09845FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697551158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QR10qKKeWFbp9jH/4RLMtlbt90NbOmMmcKVXypBNdI=;
        b=By7FaWfkTA9qywOSMoIp2ufZypzDsYwiLi9S0/Lvcchr+hsfhYsoK5ZjyCx0Bwz62iAoF8
        PUTYi6gn4cPqR+D8sna+Hb1xvmiKEVrtezEGYjSSOVGzpn9hrPoCgZiSSEshFuCvj0Mnpn
        Hp9j5W6yxnRg//SMFEFDrGytZvFelDc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Y4h8rr8-PXiocwxWDSJe5w-1; Tue, 17 Oct 2023 09:59:16 -0400
X-MC-Unique: Y4h8rr8-PXiocwxWDSJe5w-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a7bcbb95b2so87791967b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551156; x=1698155956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QR10qKKeWFbp9jH/4RLMtlbt90NbOmMmcKVXypBNdI=;
        b=Y3LkLjEaJwALkbwThj5OtxzEP73AllgXCnb0axK9qStHoboW6nGvrT73ruyAJo+Meb
         wTdUu1FKvTqrZGiBLK6XjIzSSMPdK13ry4JqcFeP7iKiNpBmZ2qfdYartQFcKrG1hj26
         pvQamqxN9FlcsM3bYV4sezbywLtqMEp9urqyfff/26Wp5n2JNK87NI77ZfwZ3t218OZ1
         zE1ouqpYs7GXetOP03juYOdhT1Y3ysd0tpUsv4/JCf74dgp6VrbWILGyNNsPB274aYH3
         BCjxo3FboYjzgYlyJgFI5F0/KDvKtmTh0AV742OAvG2ymYLyxwAagr3G1dTnVJ7JPPqj
         m+ZQ==
X-Gm-Message-State: AOJu0Yxo2yrGEnVUtO0KtcaeAv15zepwmDmBr76AOT3ASg49hcRkOykc
        8MQkn8DpdpDzVkdkBRN+yTzMAdQDZ/tE69yJXTU6cEPKU3F2HcMgvM35H/DjUgMpEqiP7uTYAqN
        bzgLbCnrKZUWmOnRZKHvcGiuD3tCUIQpadFTQj3bXGdMTNqbE+gc=
X-Received: by 2002:a81:6c17:0:b0:5a7:bcbb:b948 with SMTP id h23-20020a816c17000000b005a7bcbbb948mr2385004ywc.15.1697551155933;
        Tue, 17 Oct 2023 06:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6vu9gBuG9axxk+vppFq7zu6ka/Zjjb4JAGrUinmtw+kzq6DjYZ5dp4wePG2jackKiVOOvHLcqoeI00z+zQIw=
X-Received: by 2002:a81:6c17:0:b0:5a7:bcbb:b948 with SMTP id
 h23-20020a816c17000000b005a7bcbbb948mr2384976ywc.15.1697551155371; Tue, 17
 Oct 2023 06:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
In-Reply-To: <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 17 Oct 2023 15:58:39 +0200
Message-ID: <CAJaqyWew6CC7EwUEyto91zMNH8OQqDAvYCyk0-vM4j0K6jwbmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Jason Wang <jasowang@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 4:35=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Oct 17, 2023 at 4:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com=
> wrote:
> >
> >
> >
> > On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
> > > On Mon, Oct 16, 2023 at 8:33=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > >> On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> > >>>
> > >>>
> > >>> On 10/12/2023 8:01 PM, Jason Wang wrote:
> > >>>> On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@ora=
cle.com> wrote:
> > >>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementatio=
n
> > >>>>> may need to restore iotlb mapping to the initial or default state
> > >>>>> using the .reset_map op, as it's desirable for some parent device=
s
> > >>>>> to solely manipulate mappings by its own, independent of virtio d=
evice
> > >>>>> state. For instance, device reset does not cause mapping go away =
on
> > >>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> > >>>>> is going away, give them a chance to reset iotlb back to the init=
ial
> > >>>>> state in vhost_vdpa_cleanup().
> > >>>>>
> > >>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > >>>>> ---
> > >>>>>    drivers/vhost/vdpa.c | 16 ++++++++++++++++
> > >>>>>    1 file changed, 16 insertions(+)
> > >>>>>
> > >>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > >>>>> index 851535f..a3f8160 100644
> > >>>>> --- a/drivers/vhost/vdpa.c
> > >>>>> +++ b/drivers/vhost/vdpa.c
> > >>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find=
_alloc_as(struct vhost_vdpa *v,
> > >>>>>           return vhost_vdpa_alloc_as(v, asid);
> > >>>>>    }
> > >>>>>
> > >>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> > >>>>> +{
> > >>>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> > >>>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> > >>>>> +
> > >>>>> +       if (ops->reset_map)
> > >>>>> +               ops->reset_map(vdpa, asid);
> > >>>>> +}
> > >>>>> +
> > >>>>>    static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid=
)
> > >>>>>    {
> > >>>>>           struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> > >>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost=
_vdpa *v, u32 asid)
> > >>>>>
> > >>>>>           hlist_del(&as->hash_link);
> > >>>>>           vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, a=
sid);
> > >>>>> +       /*
> > >>>>> +        * Devices with vendor specific IOMMU may need to restore
> > >>>>> +        * iotlb to the initial or default state which is not don=
e
> > >>>>> +        * through device reset, as the IOTLB mapping manipulatio=
n
> > >>>>> +        * could be decoupled from the virtio device life cycle.
> > >>>>> +        */
> > >>>> Should we do this according to whether IOTLB_PRESIST is set?
> > >>> Well, in theory this seems like so but it's unnecessary code change
> > >>> actually, as that is the way how vDPA parent behind platform IOMMU =
works
> > >>> today, and userspace doesn't break as of today. :)
> > >> Well, this is one question I've ever asked before. You have explaine=
d
> > >> that one of the reason that we don't break userspace is that they ma=
y
> > >> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
> > >>
> > >>> As explained in previous threads [1][2], when IOTLB_PERSIST is not =
set
> > >>> it doesn't necessarily mean the iotlb will definitely be destroyed
> > >>> across reset (think about the platform IOMMU case), so userspace to=
day
> > >>> is already tolerating enough with either good or bad IOMMU.
>
> I'm confused, how to define tolerating here? For example, if it has
> tolerance, why bother?
>
> > >>This code of
> > >>> not checking IOTLB_PERSIST being set is intentional, there's no poi=
nt to
> > >>> emulate bad IOMMU behavior even for older userspace (with improper
> > >>> emulation to be done it would result in even worse performance).
>
> I can easily imagine a case:
>
> The old Qemu that works only with a setup like mlx5_vdpa.

I think it is a fair point, but QEMU in particular already unmapped
everything before set_status(0). Other userspace apps that have
trusted vdpa_sim and/or mlx5 behavior could fail, yes.

> If we do
> this without a negotiation, IOTLB will not be clear but the Qemu will
> try to re-program the IOTLB after reset. Which will break?
>
> 1) stick the exact old behaviour with just one line of check
> 2) audit all the possible cases to avoid a one line of code
>
> 1) seems much easier than 2)
>
> > >> For two reasons:
> > >>
> > >> 1) backend features need acked by userspace this is by design
> > >> 2) keep the odd behaviour seems to be more safe as we can't audit
> > >> every userspace program
> > >>
> > > The old behavior (without flag ack) cannot be trusted already, as:
>
> Possibly but the point is to unbreak userspace no matter how weird the
> behaviour we've ever had.
>
> > > * Devices using platform IOMMU (in other words, not implementing
> > > neither .set_map nor .dma_map) does not unmap memory at virtio reset.
> > > * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
> > > reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
> > > called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
> > > now all backends work the same as far as I know., which was (and is)
> > > the way devices using the platform IOMMU works.
> > >
> > > The difference in behavior did not matter as QEMU unmaps all the
> > > memory unregistering the memory listener at vhost_vdpa_dev_start(...,
> > > started =3D false),
> > Exactly. It's not just QEMU, but any (older) userspace manipulates
> > mappings through the vhost-vdpa iotlb interface has to unmap all
> > mappings to workaround the vdpa parent driver bug.
>
> Just to clarify, from userspace, it's the (odd) behaviour of the current =
uAPI.
>
> > If they don't do
> > explicit unmap, it would cause state inconsistency between vhost-vdpa
> > and parent driver, then old mappings can't be restored, and new mapping
> > can be added to iotlb after vDPA reset. There's no point to preserve
> > this broken and inconsistent behavior between vhost-vdpa and parent
> > driver, as userspace doesn't care at all!
>
> It's a userspace notice change so we can't fix it silently:
>
> https://lkml.org/lkml/2012/12/23/75
>
> Another example which is related to vhost-vDPA:
>
> https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@redhat.=
com/T/
>

So let's say it's just a matter of checking if IOTLB_PERSIST has been
acked and then call vhost_vdpa_reset_map in set_status(0) as long as
the backend uses .set_map or .dma_map. Both mlx5 and vdpa_sim will
have old behavior, but future parent drivers that use (.set_map ||
.dma_map) will also reset map with old qemu.

I think it is acceptable. Am I missing something?

Thanks!

> Thanks
>
> >
> > > but the backend acknowledging this feature flag
> > > allows QEMU to make sure it is safe to skip this unmap & map in the
> > > case of vhost stop & start cycle.
> > >
> > > In that sense, this feature flag is actually a signal for userspace t=
o
> > > know that the bug has been solved.
> > Right, I couldn't say it better than you do, thanks! The feature flag i=
s
> > more of an unusual means to indicating kernel bug having been fixed,
> > rather than introduce a new feature or new kernel behavior ending up in
> > change of userspace's expectation.
> >
> > > Not offering it indicates that
> > > userspace cannot trust the kernel will retain the maps.
> > >
> > > Si-Wei or Dragos, please correct me if I've missed something. Feel
> > > free to use the text in case you find more clear in doc or patch log.
> > Sure, will do, thank you! Will post v2 adding these to the log.
> >
> > Thanks,
> > -Siwei
> >
> >
> >
> > >
> > > Thanks!
> > >
> > >> Thanks
> > >>
> > >>> I think
> > >>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100=
%
> > >>> certainty of persistent iotlb mapping not getting lost across vdpa =
reset.
> > >>>
> > >>> Thanks,
> > >>> -Siwei
> > >>>
> > >>> [1]
> > >>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78=
152e47fd@oracle.com/
> > >>> [2]
> > >>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5=
473f1f2e@oracle.com/
> > >>>>    Otherwise
> > >>>> we may break old userspace.
> > >>>>
> > >>>> Thanks
> > >>>>
> > >>>>> +       vhost_vdpa_reset_map(v, asid);
> > >>>>>           kfree(as);
> > >>>>>
> > >>>>>           return 0;
> > >>>>> --
> > >>>>> 1.8.3.1
> > >>>>>
> >
>

