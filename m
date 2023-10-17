Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3E67CB877
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjJQCgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjJQCgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D9E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697510140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mW1BZf2+mVnELVNomZ2VvovAQnQI7E146NIn7slbu8Q=;
        b=LTaUwAC3MFDelMa8vSmU3ylBCJpNgJ/vwlAsFCOEm2tQ/fR8WzrnBbWVC8AaV9i9Z1xM/4
        OTbct6hHv60On6/TUKq/lRKzB0boCLxWl/TlIOtIOpOrdRjwjdZJsef8UiPMMZp4UpUYEd
        Loq/uY57VhzDHQgXPgZCSSJoN1FtO7U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325--_jl4Vr4PL6cDQkOFNCQCQ-1; Mon, 16 Oct 2023 22:35:38 -0400
X-MC-Unique: -_jl4Vr4PL6cDQkOFNCQCQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507968e3953so3555667e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510137; x=1698114937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mW1BZf2+mVnELVNomZ2VvovAQnQI7E146NIn7slbu8Q=;
        b=thZ4oJ7nxWnEsbbQaVnBZjJ7UCPXCtq4Oi6PKIm/ja39n5MXcehm7k+ohlHqXYYNlb
         vun9dTS/j++EB4pncICUDsbTpoMS5p5SyMYCs2C26vGlNLdpVQdlZsPGcGcFydSBEr7V
         am8SohORD1A2Vh7nDO75h0yWyAgzPZN6+fG4Qh5rkrvL4COqWR3SqVVYOmM5eGrwl784
         EemuSxmSm7aUdvWeJcQXO6Ad7G2uOjGk1jOkRks5pDbjDRRWnc9255ii+hnc1oIFCSm9
         54u0GWnP4wSzFQMLiCb87kr3r47mmB9Adry8/3y2qLQMv4Y3nYYrOV9rGy9zGAHMCegr
         0pJw==
X-Gm-Message-State: AOJu0YxVDf5iNU59EeyPIE6sG43fdWU63URG1bY6GBloFzTCOPn2IEHB
        VKNNp9mAyKaVYeWWqmk4vjp8e6rJ2W2Xx+oAQfiSnMmCwbEIcE0HR3ZGCw+NdyNDlTttZxfaikB
        VXQYLyWssPeYRidayfLd4INa3tzYXr92iknqpjiph
X-Received: by 2002:a05:6512:31d6:b0:4fe:3724:fdb6 with SMTP id j22-20020a05651231d600b004fe3724fdb6mr330140lfe.30.1697510137376;
        Mon, 16 Oct 2023 19:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQEtlEeNJVxhOeEdzuK7wWZszdkfLGmbrTuQLxJRDTpKdsiJD4gXiPZ9trC/OfGRGWGeSxObfEwhF1UFIyuss=
X-Received: by 2002:a05:6512:31d6:b0:4fe:3724:fdb6 with SMTP id
 j22-20020a05651231d600b004fe3724fdb6mr330134lfe.30.1697510136966; Mon, 16 Oct
 2023 19:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com> <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
In-Reply-To: <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 17 Oct 2023 10:35:25 +0800
Message-ID: <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
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

On Tue, Oct 17, 2023 at 4:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
> > On Mon, Oct 16, 2023 at 8:33=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >> On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>>
> >>>
> >>> On 10/12/2023 8:01 PM, Jason Wang wrote:
> >>>> On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
> >>>>> may need to restore iotlb mapping to the initial or default state
> >>>>> using the .reset_map op, as it's desirable for some parent devices
> >>>>> to solely manipulate mappings by its own, independent of virtio dev=
ice
> >>>>> state. For instance, device reset does not cause mapping go away on
> >>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> >>>>> is going away, give them a chance to reset iotlb back to the initia=
l
> >>>>> state in vhost_vdpa_cleanup().
> >>>>>
> >>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>> ---
> >>>>>    drivers/vhost/vdpa.c | 16 ++++++++++++++++
> >>>>>    1 file changed, 16 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>>> index 851535f..a3f8160 100644
> >>>>> --- a/drivers/vhost/vdpa.c
> >>>>> +++ b/drivers/vhost/vdpa.c
> >>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_a=
lloc_as(struct vhost_vdpa *v,
> >>>>>           return vhost_vdpa_alloc_as(v, asid);
> >>>>>    }
> >>>>>
> >>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> >>>>> +{
> >>>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> >>>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >>>>> +
> >>>>> +       if (ops->reset_map)
> >>>>> +               ops->reset_map(vdpa, asid);
> >>>>> +}
> >>>>> +
> >>>>>    static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> >>>>>    {
> >>>>>           struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> >>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_v=
dpa *v, u32 asid)
> >>>>>
> >>>>>           hlist_del(&as->hash_link);
> >>>>>           vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asi=
d);
> >>>>> +       /*
> >>>>> +        * Devices with vendor specific IOMMU may need to restore
> >>>>> +        * iotlb to the initial or default state which is not done
> >>>>> +        * through device reset, as the IOTLB mapping manipulation
> >>>>> +        * could be decoupled from the virtio device life cycle.
> >>>>> +        */
> >>>> Should we do this according to whether IOTLB_PRESIST is set?
> >>> Well, in theory this seems like so but it's unnecessary code change
> >>> actually, as that is the way how vDPA parent behind platform IOMMU wo=
rks
> >>> today, and userspace doesn't break as of today. :)
> >> Well, this is one question I've ever asked before. You have explained
> >> that one of the reason that we don't break userspace is that they may
> >> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
> >>
> >>> As explained in previous threads [1][2], when IOTLB_PERSIST is not se=
t
> >>> it doesn't necessarily mean the iotlb will definitely be destroyed
> >>> across reset (think about the platform IOMMU case), so userspace toda=
y
> >>> is already tolerating enough with either good or bad IOMMU.

I'm confused, how to define tolerating here? For example, if it has
tolerance, why bother?

> >>This code of
> >>> not checking IOTLB_PERSIST being set is intentional, there's no point=
 to
> >>> emulate bad IOMMU behavior even for older userspace (with improper
> >>> emulation to be done it would result in even worse performance).

I can easily imagine a case:

The old Qemu that works only with a setup like mlx5_vdpa. If we do
this without a negotiation, IOTLB will not be clear but the Qemu will
try to re-program the IOTLB after reset. Which will break?

1) stick the exact old behaviour with just one line of check
2) audit all the possible cases to avoid a one line of code

1) seems much easier than 2)

> >> For two reasons:
> >>
> >> 1) backend features need acked by userspace this is by design
> >> 2) keep the odd behaviour seems to be more safe as we can't audit
> >> every userspace program
> >>
> > The old behavior (without flag ack) cannot be trusted already, as:

Possibly but the point is to unbreak userspace no matter how weird the
behaviour we've ever had.

> > * Devices using platform IOMMU (in other words, not implementing
> > neither .set_map nor .dma_map) does not unmap memory at virtio reset.
> > * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
> > reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
> > called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
> > now all backends work the same as far as I know., which was (and is)
> > the way devices using the platform IOMMU works.
> >
> > The difference in behavior did not matter as QEMU unmaps all the
> > memory unregistering the memory listener at vhost_vdpa_dev_start(...,
> > started =3D false),
> Exactly. It's not just QEMU, but any (older) userspace manipulates
> mappings through the vhost-vdpa iotlb interface has to unmap all
> mappings to workaround the vdpa parent driver bug.

Just to clarify, from userspace, it's the (odd) behaviour of the current uA=
PI.

> If they don't do
> explicit unmap, it would cause state inconsistency between vhost-vdpa
> and parent driver, then old mappings can't be restored, and new mapping
> can be added to iotlb after vDPA reset. There's no point to preserve
> this broken and inconsistent behavior between vhost-vdpa and parent
> driver, as userspace doesn't care at all!

It's a userspace notice change so we can't fix it silently:

https://lkml.org/lkml/2012/12/23/75

Another example which is related to vhost-vDPA:

https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@redhat.co=
m/T/

Thanks

>
> > but the backend acknowledging this feature flag
> > allows QEMU to make sure it is safe to skip this unmap & map in the
> > case of vhost stop & start cycle.
> >
> > In that sense, this feature flag is actually a signal for userspace to
> > know that the bug has been solved.
> Right, I couldn't say it better than you do, thanks! The feature flag is
> more of an unusual means to indicating kernel bug having been fixed,
> rather than introduce a new feature or new kernel behavior ending up in
> change of userspace's expectation.
>
> > Not offering it indicates that
> > userspace cannot trust the kernel will retain the maps.
> >
> > Si-Wei or Dragos, please correct me if I've missed something. Feel
> > free to use the text in case you find more clear in doc or patch log.
> Sure, will do, thank you! Will post v2 adding these to the log.
>
> Thanks,
> -Siwei
>
>
>
> >
> > Thanks!
> >
> >> Thanks
> >>
> >>> I think
> >>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
> >>> certainty of persistent iotlb mapping not getting lost across vdpa re=
set.
> >>>
> >>> Thanks,
> >>> -Siwei
> >>>
> >>> [1]
> >>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be7815=
2e47fd@oracle.com/
> >>> [2]
> >>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe547=
3f1f2e@oracle.com/
> >>>>    Otherwise
> >>>> we may break old userspace.
> >>>>
> >>>> Thanks
> >>>>
> >>>>> +       vhost_vdpa_reset_map(v, asid);
> >>>>>           kfree(as);
> >>>>>
> >>>>>           return 0;
> >>>>> --
> >>>>> 1.8.3.1
> >>>>>
>

