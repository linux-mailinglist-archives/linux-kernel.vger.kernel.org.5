Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14FC7606D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjGYDmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGYDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818E171E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690256525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBqWvh4jP/z/tTFxDwlL4w0kgC2AYOxSmuBfBsWmpVQ=;
        b=hRh8w6bK7v0cpG0pjygfpCtN/l1tKixrPp1Vhqh3YQB1OYfTgDO9cgpIT+zt5dT9z3/1ro
        5sP3UmuPWi5VCp40xTUHjrXLiJq8SmJz98w3p9hLODsQ7YqUpgPC5w5uEwTgeK+Id2b1Tm
        1LvKpQFA5Ek967XXdRgpJD+lt0lN8uA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-kQnW3-a7PaaToeLjpUvq-w-1; Mon, 24 Jul 2023 23:42:03 -0400
X-MC-Unique: kQnW3-a7PaaToeLjpUvq-w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb76659cacso4305022e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690256522; x=1690861322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBqWvh4jP/z/tTFxDwlL4w0kgC2AYOxSmuBfBsWmpVQ=;
        b=kN0x+QhdOSZY9PmkkzctwY0pd542MOiOcpN99/kkL9U1UQFQGD1hMjYS40sFW4fUEF
         ZR3kKW8/Dqp+oDZq7gaud6q49/MQtMmrX2q5BF64X3w9MapPvet8UC2HRvwswjzZyzHr
         m89pX/EclCBaHHzldEe9bfpsbskVsHhGBSDV6oYdPyz6R/s6wq6Vgrn/pBHhUpohZutz
         GRjderiNsO6qwDF4UbezHjKun3dSBmyznUji3JiKl70dhVLD+No2HIXRduJr3yWY2wOe
         DmoXBdof6Gi9+ThZH2zdINgo940HnTsFANSPSGoumitFPSre3t553gRfmRLsCjU+7fn3
         2x4A==
X-Gm-Message-State: ABy/qLZbCXjtr/Noe6eB7pJ8i9xJzcimSBJVjSa1870Wn/8UOLsLFpC3
        Hx+PNVmb4qtq5Eyb/DuGU28o1IbDDLYxDTT3nVDjTb4n/VcID7WiKW858cKtc3Qkg2WL0VISEuZ
        r4OEyZMTrQXp2kt6cGTddBatGaGDVoYUFAVjlzRYf
X-Received: by 2002:a05:6512:3dac:b0:4f9:556b:93c2 with SMTP id k44-20020a0565123dac00b004f9556b93c2mr7717117lfv.1.1690256521813;
        Mon, 24 Jul 2023 20:42:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWkHAVooO54bT1EHw02WmRL4kluBNDiEY/6H7dlW6/a0ZQV+weSwSX6KySDaHy9vgTvfNUvxt936MezoEyD9w=
X-Received: by 2002:a05:6512:3dac:b0:4f9:556b:93c2 with SMTP id
 k44-20020a0565123dac00b004f9556b93c2mr7717108lfv.1.1690256521512; Mon, 24 Jul
 2023 20:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230719154550.79536-1-feliu@nvidia.com> <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
 <20230720131423-mutt-send-email-mst@kernel.org> <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
In-Reply-To: <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 25 Jul 2023 11:41:50 +0800
Message-ID: <CACGkMEuk2aBhnViZkAi8tbNc8AnJ1FY9uk9rCnmmiWVGwYsLUA@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in probe
To:     Feng Liu <feliu@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
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

On Mon, Jul 24, 2023 at 9:14=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
>
>
> On 2023-07-20 p.m.1:14, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Jul 20, 2023 at 10:27:04AM +0800, Jason Wang wrote:
> >> On Wed, Jul 19, 2023 at 11:46=E2=80=AFPM Feng Liu <feliu@nvidia.com> w=
rote:
> >>>
> >>> The 'is_legacy' flag is used to differentiate between legacy vs moder=
n
> >>> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
> >>> However, due to the shared memory of the union between struct
> >>> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
> >>> virtio_pci_modern_probe modifies the content of struct
> >>> virtio_pci_modern_device, it affects the content of struct
> >>> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
> >>> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
> >>> device is probed, mark 'is_legacy' as true, when modern device is
> >>> probed, keep 'is_legacy' as false.
> >>>
> >>> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structur=
e size")
> >>> Signed-off-by: Feng Liu <feliu@nvidia.com>
> >>> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>> ---
> >>>   drivers/virtio/virtio_pci_common.c | 2 --
> >>>   drivers/virtio/virtio_pci_legacy.c | 1 +
> >>>   2 files changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virt=
io_pci_common.c
> >>> index a6c86f916dbd..c2524a7207cf 100644
> >>> --- a/drivers/virtio/virtio_pci_common.c
> >>> +++ b/drivers/virtio/virtio_pci_common.c
> >>> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_d=
ev,
> >>>
> >>>          pci_set_master(pci_dev);
> >>>
> >>> -       vp_dev->is_legacy =3D vp_dev->ldev.ioaddr ? true : false;
> >>> -
> >>>          rc =3D register_virtio_device(&vp_dev->vdev);
> >>>          reg_dev =3D vp_dev;
> >>>          if (rc)
> >>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virt=
io_pci_legacy.c
> >>> index 2257f1b3d8ae..d9cbb02b35a1 100644
> >>> --- a/drivers/virtio/virtio_pci_legacy.c
> >>> +++ b/drivers/virtio/virtio_pci_legacy.c
> >>> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_dev=
ice *vp_dev)
> >>>          vp_dev->config_vector =3D vp_config_vector;
> >>>          vp_dev->setup_vq =3D setup_vq;
> >>>          vp_dev->del_vq =3D del_vq;
> >>> +       vp_dev->is_legacy =3D true;
> >>
> >> This seems break force_legacy for modern device:
> >>
> >>          if (force_legacy) {
> >>                  rc =3D virtio_pci_legacy_probe(vp_dev);
> >>                  /* Also try modern mode if we can't map BAR0 (no IO s=
pace). */
> >>                  if (rc =3D=3D -ENODEV || rc =3D=3D -ENOMEM)
> >>                          rc =3D virtio_pci_modern_probe(vp_dev);
> >>
> >> Thanks
> >
> > don't see the breakage here - can you explain a bit more?
> >
> Hi, Jason
>
> I also think there is no breakage herea and gave an explanation in
> another email, please have a see.

I think I've made a mistake, the patch should be fine.

>
> So are there any comments about this bug fix patch? Can this patch pass
> the review?

Yes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks
> Feng
>
> >>>
> >>>          return 0;
> >>>   }
> >>> --
> >>> 2.37.1 (Apple Git-137.1)
> >>>
> >
>

