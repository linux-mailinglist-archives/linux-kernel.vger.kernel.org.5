Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD797B8663
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbjJDRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJDRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52E3C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696440173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+wFhfcsXq24K3TFakmPQFnHsQGWz8m99Juo5ogTsi4=;
        b=YqRVCty4FIiZqfMLEXVR53MGtFvw+48xCcrjQdmMqRFH3Ve6Tx8t4QsrBe12rY17C7ln+r
        z8pOBuAGM5pz2VdzY8R1F9lrotVs6PMafDkphMP/EviTbw4PyIoz2cBk1wGrwKhAQrTB2P
        OKPSGSUOeMKLx/TaKWCHzCsYMpjI8R4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-k1Llq83sMKm1rqj8gr-Ukw-1; Wed, 04 Oct 2023 13:22:52 -0400
X-MC-Unique: k1Llq83sMKm1rqj8gr-Ukw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-d8191a1d5acso110295276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440171; x=1697044971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+wFhfcsXq24K3TFakmPQFnHsQGWz8m99Juo5ogTsi4=;
        b=qOHQi/3yu2J+C+TVumOwOnjZs9nOXwyQEysNWq1Uiu8BqAWQvcVCR/WdrBG5/oE+av
         ySRp/L2cgOjUJ3KQXq5o6TB52m6MAQJJZgNfDI0mPJR78nXyUu1199m6LCVN9Wigyyuv
         8H6GPBfT7gWK3PMTrv4S/xlXpfAo0ruOZ2A6iKFPfwJN0yP5vVO4aEJp/UvO3fDTxoCu
         tNvDjzbOWbgPnxgNHtRP4KKs/tbs5xSvSpDVOXGQPzPN3JB7kOOy58zz1rmkLnVTdx7B
         8uC5q1Pg6e6CJIPtvFTdomUPN/8OdpYBdQvV7wvAQuA6t8Zj78Ee5Rl+39vTo59Zr7C2
         Gd2Q==
X-Gm-Message-State: AOJu0YwxrYsr4nGJXdZM17Sp+d3Nx0C8Qfuf/Wjx63YXLEefg7a5PyyG
        Jq41PPQ5kK6XQn4ALPJbCv3qsBa2PvCA+aOWx2icq7ftyx48jRSo7vufWNUz4YY9+/C4VMVt/II
        CoFpjJwzF00CROmifv7PZfPnaEPxjdGv9XuVWQ2MgwMU+LSbw
X-Received: by 2002:a25:ac59:0:b0:d81:6f5b:b6d8 with SMTP id r25-20020a25ac59000000b00d816f5bb6d8mr2608524ybd.38.1696440171140;
        Wed, 04 Oct 2023 10:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP/4dSb/QbyWkHobZAsDh9erK6akB5r7xuWlVwSeanoQmeDmKRWGma+9Imt4mbfijymNgyJY+qnmqDzIwc5Gg=
X-Received: by 2002:a25:ac59:0:b0:d81:6f5b:b6d8 with SMTP id
 r25-20020a25ac59000000b00d816f5bb6d8mr2608507ybd.38.1696440170789; Wed, 04
 Oct 2023 10:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com> <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com> <20230704061356-mutt-send-email-mst@kernel.org>
 <CAJaqyWf7DzJMEUT0NcPeDLQyPkthEJZydnSSPztoCxF6PWEu1w@mail.gmail.com> <20231004122716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231004122716-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 19:22:14 +0200
Message-ID: <CAJaqyWfy0AJ88kHbJGJLxFK_F-d+x+z6bkW3timLjaicXXSV6Q@mail.gmail.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, linux-kernel@vger.kernel.org,
        Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
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

On Wed, Oct 4, 2023 at 6:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Oct 04, 2023 at 02:56:53PM +0200, Eugenio Perez Martin wrote:
> > On Tue, Jul 4, 2023 at 12:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> > > >
> > > >
> > > > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=C3=A9rez wrot=
e:
> > > > > > Offer this backend feature as mlx5 is compatible with it. It al=
lows it
> > > > > > to do live migration with CVQ, dynamically switching between pa=
ssthrough
> > > > > > and shadow virtqueue.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > Same comment.
> > > > to which?
> > > >
> > > > -Siwei
> > >
> > > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to co=
mmit to it
> > > as a kernel/userspace ABI: what if one wants to start rings in some
> > > other specific order?
> > > As was discussed on list, a better promise is not to access ring
> > > until the 1st kick. vdpa can then do a kick when it wants
> > > the device to start accessing rings.
> > >
> >
> > Friendly ping about this series,
> >
> > Now that VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK has been merged for
> > vdpa_sim, does it make sense for mlx too?
> >
> > Thanks!
>
> For sure. I was just busy with a qemu pull, will handle this next.
>

Sounds great, thanks!

> > > > >
> > > > > > ---
> > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > > > >   1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/m=
lx5/net/mlx5_vnet.c
> > > > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >   #include <uapi/linux/virtio_net.h>
> > > > > >   #include <uapi/linux/virtio_ids.h>
> > > > > >   #include <uapi/linux/vdpa.h>
> > > > > > +#include <uapi/linux/vhost_types.h>
> > > > > >   #include <linux/virtio_config.h>
> > > > > >   #include <linux/auxiliary_bus.h>
> > > > > >   #include <linux/mlx5/cq.h>
> > > > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(str=
uct mlx5_vdpa_net *ndev)
> > > > > >                   flush_workqueue(ndev->mvdev.wq);
> > > > > >   }
> > > > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_de=
vice *vdpa)
> > > > > > +{
> > > > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > > > +}
> > > > > > +
> > > > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *=
vdev, u64 features)
> > > > > >   {
> > > > > >           struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_=
vdpa_ops =3D {
> > > > > >           .get_vq_align =3D mlx5_vdpa_get_vq_align,
> > > > > >           .get_vq_group =3D mlx5_vdpa_get_vq_group,
> > > > > >           .get_device_features =3D mlx5_vdpa_get_device_feature=
s,
> > > > > > + .get_backend_features =3D mlx5_vdpa_get_backend_features,
> > > > > >           .set_driver_features =3D mlx5_vdpa_set_driver_feature=
s,
> > > > > >           .get_driver_features =3D mlx5_vdpa_get_driver_feature=
s,
> > > > > >           .set_config_cb =3D mlx5_vdpa_set_config_cb,
> > > > > > --
> > > > > > 2.39.3
> > >
>

