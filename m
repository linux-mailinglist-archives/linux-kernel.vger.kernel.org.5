Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675F47CD389
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbjJRF2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJRF2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4198DC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697606840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ollVqSStLsVJatOIN7vznzZdWtrCE/bS0EYy1MvvR4E=;
        b=QVvq8SZ7xMplfzM3JhdMm24ivsAJaicHx0TIddRQ8Lal6i9nZE3cjUPB1BO4vrnYElm6ge
        R5Qq6vVfHb5U1Fc74miA0KPyTPmN/8kBzShe//fSuVZ9jKKjk7OP3/qWznXDUap/2xxTLx
        h9GLDtB2makhrpQGc6CdpcvZft2YYUw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-P2SSfNhEPJ6oVCkUt4HRRg-1; Wed, 18 Oct 2023 01:27:18 -0400
X-MC-Unique: P2SSfNhEPJ6oVCkUt4HRRg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507b9078aaaso2086873e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697606837; x=1698211637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ollVqSStLsVJatOIN7vznzZdWtrCE/bS0EYy1MvvR4E=;
        b=EqK+JnLLA+SaKFYETleB9VORjGksF+qyYDB1QYJTTCdFUfEqD0z/JAajLz959D3UQJ
         3SggQ1wMepLzBvhgQ3MuuOH+v5BDbxG2RKYhPgAroux2xpGDTX8m6JNZhlaJtUz9WPi/
         q/9pZSi/6puYQ7m39ScOAQFHggB801NeNxGUN/ANW3wtzscQHxtw8ct0+HIt4x3RByLS
         NKGcAdlxDT8rJmxMrkIbiQSz8w/VWx3ysRDPPPxWB8OJ1pPyZPgQBYjow6+5QBlDENIa
         0cIy8Y7T50diLByqmiV3jDm5RRdaq6Ygqr6eEiaqd8cqZWi6TsSfJI2ENzV56O3wDyzU
         Sm+A==
X-Gm-Message-State: AOJu0YwVcrxpcGwbAmGS9hawxPG6tg6Gc7Dby2+TCCCbk3G4pqPczuFD
        Tb8J0XiWurcMUtJ00zChVOIWDXyi7VuiYNylAJmCVJl7EJLcf73o/OqJ5ECEF21eaXbS8VIBc/v
        IArY2lRAMPjBsdscIOg6XBfHwN8Na1gEA3MO/YjhM
X-Received: by 2002:a05:6512:318c:b0:507:984e:9f17 with SMTP id i12-20020a056512318c00b00507984e9f17mr3892157lfe.34.1697606837083;
        Tue, 17 Oct 2023 22:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6t8lhjmaY0LoqYW8ClgebuDF1WzMvRdRwo9piVz2J0NxkTT54KAGqmdTmiKSAQ8WL3CEOk//URGfbakVWzJ8=
X-Received: by 2002:a05:6512:318c:b0:507:984e:9f17 with SMTP id
 i12-20020a056512318c00b00507984e9f17mr3892137lfe.34.1697606836672; Tue, 17
 Oct 2023 22:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
In-Reply-To: <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 13:27:05 +0800
Message-ID: <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 12:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 10/16/2023 7:35 PM, Jason Wang wrote:
> > On Tue, Oct 17, 2023 at 4:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
> >>> On Mon, Oct 16, 2023 at 8:33=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>> On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>>
> >>>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
> >>>>>> On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@ora=
cle.com> wrote:
> >>>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementatio=
n
> >>>>>>> may need to restore iotlb mapping to the initial or default state
> >>>>>>> using the .reset_map op, as it's desirable for some parent device=
s
> >>>>>>> to solely manipulate mappings by its own, independent of virtio d=
evice
> >>>>>>> state. For instance, device reset does not cause mapping go away =
on
> >>>>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> >>>>>>> is going away, give them a chance to reset iotlb back to the init=
ial
> >>>>>>> state in vhost_vdpa_cleanup().
> >>>>>>>
> >>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>>>> ---
> >>>>>>>     drivers/vhost/vdpa.c | 16 ++++++++++++++++
> >>>>>>>     1 file changed, 16 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>>>>> index 851535f..a3f8160 100644
> >>>>>>> --- a/drivers/vhost/vdpa.c
> >>>>>>> +++ b/drivers/vhost/vdpa.c
> >>>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find=
_alloc_as(struct vhost_vdpa *v,
> >>>>>>>            return vhost_vdpa_alloc_as(v, asid);
> >>>>>>>     }
> >>>>>>>
> >>>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> >>>>>>> +{
> >>>>>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> >>>>>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >>>>>>> +
> >>>>>>> +       if (ops->reset_map)
> >>>>>>> +               ops->reset_map(vdpa, asid);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>     static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asi=
d)
> >>>>>>>     {
> >>>>>>>            struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> >>>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost=
_vdpa *v, u32 asid)
> >>>>>>>
> >>>>>>>            hlist_del(&as->hash_link);
> >>>>>>>            vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, =
asid);
> >>>>>>> +       /*
> >>>>>>> +        * Devices with vendor specific IOMMU may need to restore
> >>>>>>> +        * iotlb to the initial or default state which is not don=
e
> >>>>>>> +        * through device reset, as the IOTLB mapping manipulatio=
n
> >>>>>>> +        * could be decoupled from the virtio device life cycle.
> >>>>>>> +        */
> >>>>>> Should we do this according to whether IOTLB_PRESIST is set?
> >>>>> Well, in theory this seems like so but it's unnecessary code change
> >>>>> actually, as that is the way how vDPA parent behind platform IOMMU =
works
> >>>>> today, and userspace doesn't break as of today. :)
> >>>> Well, this is one question I've ever asked before. You have explaine=
d
> >>>> that one of the reason that we don't break userspace is that they ma=
y
> >>>> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
> >>>>
> >>>>> As explained in previous threads [1][2], when IOTLB_PERSIST is not =
set
> >>>>> it doesn't necessarily mean the iotlb will definitely be destroyed
> >>>>> across reset (think about the platform IOMMU case), so userspace to=
day
> >>>>> is already tolerating enough with either good or bad IOMMU.
> > I'm confused, how to define tolerating here?
>
> Tolerating defined as QEMU has to proactively unmap before reset just to
> workaround the driver bug (on-chip maps out of sync), unconditionally
> for platform or on-chip. While we all know it doesn't have to do so for
> platform IOMMU, though userspace has no means to distinguish. That said,
> userspace is sacrificing reset time performance on platform IOMMU setup
> just for working around buggy implementation in the other setup.

Ok, so what you actually mean is that userspace can tolerate the "bug"
with the performance penalty.


>
> > For example, if it has tolerance, why bother?
> I'm not sure I get the question. But I think userspace is compromising
> because of buggy implementation in a few drivers doesn't mean we should
> uniformly enforce such behavior for all set_map/dma_map implementations.

This is not my point. I meant, we can fix we need a negotiation in
order to let some "buggy" old user space to survive from the changes.

>
> >
> >>>> This code of
> >>>>> not checking IOTLB_PERSIST being set is intentional, there's no poi=
nt to
> >>>>> emulate bad IOMMU behavior even for older userspace (with improper
> >>>>> emulation to be done it would result in even worse performance).
> > I can easily imagine a case:
> >
> > The old Qemu that works only with a setup like mlx5_vdpa.
> Noted, seems to me there's no such case of a userspace implementation
> that only works with mlx5_vdpa or its friends, but doesn't work with the
> others e.g. platform IOMMU, or well behaving on-chip IOMMU
> implementations.

It's not hard to think of a case where:

1) the environment has mlx5_vdpa only
2) kernel doc can't have endless details, so when developing
application, the author notice IOTLB is cleared during reset

> The Unmap+remap trick around vdpa reset works totally
> fine for platform IOMMU, except with sub-optimal performance. Other than
> this trick, I cannot easily think of other means or iotlb message
> sequence for userspace to recover the bogus state and make iotlb back to
> work again after reset.

Yes for sure, but we can't audit every user space, no?

> Are we talking about hypnosis that has no real
> basis to exist in the real world?

Instead of trying to answer these hard questions, I would go another
way. That is, stick to the old behaviour when IOTLB_PRESISIT is not
set by the backend. This is much easier.

>
> >   If we do
> > this without a negotiation, IOTLB will not be clear but the Qemu will
> > try to re-program the IOTLB after reset. Which will break?
> >
> > 1) stick the exact old behaviour with just one line of check
> It's not just one line of check here, the old behavior emulation has to
> be done as Eugenio illustrated in the other email.

For vhost-vDPA it's just

if (IOTLB_PERSIST is acked by userspace)
    reset_map()

For parent, it's somehow similar:

during .reset()

if (IOTLB_PERSIST is not acked by userspace)
        reset_vendor_mappings()

Anything I missed here?

> In addition, the
> emulation has to limit to those buggy drivers as I don't feel this
> emulation should apply uniformly to all future set_map/dma_map
> implementations.

Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
don't have a better choice. Or we can fail the probe if userspace
doesn't ack this feature.

> > 2) audit all the possible cases to avoid a one line of code
> >
> > 1) seems much easier than 2)
> You see it's more than just one line of code, and I'm uncertain if the
> additional complexity is warranted or necessary, particularly if added
> this piece of compatibility code will linger for quite a long time.

This is a must as long as it can be noticed by userspace. Doing
something conservative makes more sense to me.

> Instead of adding hypothetical code change for no specific good reason
> and no real use case,

It's not adding something new or new behaviours, it's just making the
IOTLB reset conditional based on vDPA reset.

> I'd like to add the code when we find out a
> specific use case that may get impacted or already being affected,

It doesn't conflict with what you proposed here. Old behaviours have
their users, no?

> then
> we will have good understanding how to code up the fix and emulate
> properly for compatibility, while not affecting other good implementation=
s.

The issue is, even if we can't find a userspace now. It doesn't mean
we can't have one in the future. Then it might be too late or too
tricky to fix them. We had a lot of lessons in the past.

Thanks

>
> Thanks,
> -Siwe/i/
>
> >
> >>>> For two reasons:
> >>>>
> >>>> 1) backend features need acked by userspace this is by design
> >>>> 2) keep the odd behaviour seems to be more safe as we can't audit
> >>>> every userspace program
> >>>>
> >>> The old behavior (without flag ack) cannot be trusted already, as:
> > Possibly but the point is to unbreak userspace no matter how weird the
> > behaviour we've ever had.
> >
> >>> * Devices using platform IOMMU (in other words, not implementing
> >>> neither .set_map nor .dma_map) does not unmap memory at virtio reset.
> >>> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
> >>> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
> >>> called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
> >>> now all backends work the same as far as I know., which was (and is)
> >>> the way devices using the platform IOMMU works.
> >>>
> >>> The difference in behavior did not matter as QEMU unmaps all the
> >>> memory unregistering the memory listener at vhost_vdpa_dev_start(...,
> >>> started =3D false),
> >> Exactly. It's not just QEMU, but any (older) userspace manipulates
> >> mappings through the vhost-vdpa iotlb interface has to unmap all
> >> mappings to workaround the vdpa parent driver bug.
> > Just to clarify, from userspace, it's the (odd) behaviour of the curren=
t uAPI.
> >
> >> If they don't do
> >> explicit unmap, it would cause state inconsistency between vhost-vdpa
> >> and parent driver, then old mappings can't be restored, and new mappin=
g
> >> can be added to iotlb after vDPA reset. There's no point to preserve
> >> this broken and inconsistent behavior between vhost-vdpa and parent
> >> driver, as userspace doesn't care at all!
> > It's a userspace notice change so we can't fix it silently:
> >
> > https://lkml.org/lkml/2012/12/23/75
> >
> > Another example which is related to vhost-vDPA:
> >
> > https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@redha=
t.com/T/
> >
> > Thanks
> >
> >>> but the backend acknowledging this feature flag
> >>> allows QEMU to make sure it is safe to skip this unmap & map in the
> >>> case of vhost stop & start cycle.
> >>>
> >>> In that sense, this feature flag is actually a signal for userspace t=
o
> >>> know that the bug has been solved.
> >> Right, I couldn't say it better than you do, thanks! The feature flag =
is
> >> more of an unusual means to indicating kernel bug having been fixed,
> >> rather than introduce a new feature or new kernel behavior ending up i=
n
> >> change of userspace's expectation.
> >>
> >>> Not offering it indicates that
> >>> userspace cannot trust the kernel will retain the maps.
> >>>
> >>> Si-Wei or Dragos, please correct me if I've missed something. Feel
> >>> free to use the text in case you find more clear in doc or patch log.
> >> Sure, will do, thank you! Will post v2 adding these to the log.
> >>
> >> Thanks,
> >> -Siwei
> >>
> >>
> >>
> >>> Thanks!
> >>>
> >>>> Thanks
> >>>>
> >>>>> I think
> >>>>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100=
%
> >>>>> certainty of persistent iotlb mapping not getting lost across vdpa =
reset.
> >>>>>
> >>>>> Thanks,
> >>>>> -Siwei
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78=
152e47fd@oracle.com/
> >>>>> [2]
> >>>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5=
473f1f2e@oracle.com/
> >>>>>>     Otherwise
> >>>>>> we may break old userspace.
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>>> +       vhost_vdpa_reset_map(v, asid);
> >>>>>>>            kfree(as);
> >>>>>>>
> >>>>>>>            return 0;
> >>>>>>> --
> >>>>>>> 1.8.3.1
> >>>>>>>
>

