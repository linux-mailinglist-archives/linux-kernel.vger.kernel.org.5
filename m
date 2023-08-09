Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A534177507E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjHIBnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjHIBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB281982
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691545374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pa2LVSoDWp2k+eTV35Hp4pdi9W8RLvbM8EeGVoHpM5c=;
        b=G5QqJV2wjxvEiQXYXYePHioX6U6TcSRpCJMU58Qhkpb3EeR+SJOwbH6ucswfkhnAJ+LAFC
        hjWQRtpQYwKK31pFxRpdFv1qUXex93q3jlZkIlX4sXzYdKKBiSDql6mr+a1aVXxKhV7CRw
        UWfmAjrlMYsXTp2bC6ZBh+lZ3w5RdR8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-GZ6slvGYPQu1CZ6h868New-1; Tue, 08 Aug 2023 21:42:53 -0400
X-MC-Unique: GZ6slvGYPQu1CZ6h868New-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9b2fb9770so33987671fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691545372; x=1692150172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pa2LVSoDWp2k+eTV35Hp4pdi9W8RLvbM8EeGVoHpM5c=;
        b=HinNVzyXrVDATy7lEu8TfA3gBwhExYtPc1h3FWGkCnRJ6cOFM0ryGjAQvHngE5yj3l
         u0EXIl1LyS2Wa4Ip3DnkA2d9W3WeRdSdm5rOjK+JXNPHlct852vygGx/SHMKcD//CrR7
         /zOWJoEgjrtYJrQrMnWFtZsFoJL7sllRu2SE12SYGfCKo+B/DLKABK+kRudkWASpjK3Q
         xUL0Ye08s1i/FStGUiQtUED7UB5/9eAGZkWk5tZOhZk/ID5dMzPgcxQRrQzB6hLFjoTD
         Gk015nTgd1KMXJGx2hsBCzoYeqWsjlNsSR/1O5i1pKbWChG2YfUrGvFy6nPPMk+ihib7
         Wo5A==
X-Gm-Message-State: AOJu0YzzYqXG91LiMivQEqw4ZtCCZ7mQdBy1P02PR5Q6ylv9VgS8edFq
        1z04Z/iRJx0bQ8endbzwbbdW1v+VUR1GxKjUXgOa4FisccKBDFPxD2kzLK+sonZ8BYpl654cF3W
        9eu79QuLwXe9etAlBjBtOnqRKXtHiG7uD1WQV4hQo
X-Received: by 2002:a2e:9345:0:b0:2b6:fa8d:ff91 with SMTP id m5-20020a2e9345000000b002b6fa8dff91mr748548ljh.3.1691545371787;
        Tue, 08 Aug 2023 18:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGPiqXB2iMg3rd8On/takdRRDIG01o5eNOrBgpXP7IJN7g9X9X7bEgLfxq8C4t5goQ02D36hJKdKWsv0guOw=
X-Received: by 2002:a2e:9345:0:b0:2b6:fa8d:ff91 with SMTP id
 m5-20020a2e9345000000b002b6fa8dff91mr748539ljh.3.1691545371412; Tue, 08 Aug
 2023 18:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
 <CACGkMEvoE=1ac1EGxPd14AwCfuOTiZYzYgDQC_qZjSubt891sA@mail.gmail.com> <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
In-Reply-To: <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 9 Aug 2023 09:42:40 +0800
Message-ID: <CACGkMEt95WsDxuc-vGWNhZfZ5G9AGUykV5+kV8oDcGZQ4jD-Lg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 3:24=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Tue, 2023-08-08 at 10:57 +0800, Jason Wang wrote:
> > On Thu, Aug 3, 2023 at 7:40=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > On Thu, 2023-08-03 at 16:03 +0800, Jason Wang wrote:
> > > > On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvi=
dia.com> wrote:
> > > > >
> > > > > The mr->initialized flag is shared between the control vq and dat=
a vq
> > > > > part of the mr init/uninit. But if the control vq and data vq get=
 placed
> > > > > in different ASIDs, it can happen that initializing the control v=
q will
> > > > > prevent the data vq mr from being initialized.
> > > > >
> > > > > This patch consolidates the control and data vq init parts into t=
heir
> > > > > own init functions. The mr->initialized will now be used for the =
data vq
> > > > > only. The control vq currently doesn't need a flag.
> > > > >
> > > > > The uninitializing part is also taken care of: mlx5_vdpa_destroy_=
mr got
> > > > > split into data and control vq functions which are now also ASID =
aware.
> > > > >
> > > > > Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces=
 for
> > > > > control and data")
> > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > > ---
> > > > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> > > > >  drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---=
------
> > > > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > index 25fc4120b618..a0420be5059f 100644
> > > > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
> > > > >         struct list_head head;
> > > > >         unsigned long num_directs;
> > > > >         unsigned long num_klms;
> > > > > +       /* state of dvq mr */
> > > > >         bool initialized;
> > > > >
> > > > >         /* serialize mkey creation and destruction */
> > > > > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core=
/mr.c
> > > > > index 03e543229791..4ae14a248a4b 100644
> > > > > --- a/drivers/vdpa/mlx5/core/mr.c
> > > > > +++ b/drivers/vdpa/mlx5/core/mr.c
> > > > > @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vd=
pa_dev
> > > > > *mvdev, struct mlx5_vdpa_mr *mr
> > > > >         }
> > > > >  }
> > > > >
> > > > > -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > > +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvde=
v,
> > > > > unsigned
> > > > > int asid)
> > > > > +{
> > > > > +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> > > > > +               return;
> > > > > +
> > > > > +       prune_iotlb(mvdev);
> > > > > +}
> > > > > +
> > > > > +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvde=
v,
> > > > > unsigned
> > > > > int asid)
> > > > >  {
> > > > >         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > > > >
> > > > > -       mutex_lock(&mr->mkey_mtx);
> > > > > +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> > > > > +               return;
> > > > > +
> > > > >         if (!mr->initialized)
> > > > > -               goto out;
> > > > > +               return;
> > > > >
> > > > > -       prune_iotlb(mvdev);
> > > > >         if (mr->user_mr)
> > > > >                 destroy_user_mr(mvdev, mr);
> > > > >         else
> > > > >                 destroy_dma_mr(mvdev, mr);
> > > > >
> > > > >         mr->initialized =3D false;
> > > > > -out:
> > > > > +}
> > > > > +
> > > > > +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvde=
v,
> > > > > unsigned
> > > > > int asid)
> > > > > +{
> > > > > +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > > > > +
> > > > > +       mutex_lock(&mr->mkey_mtx);
> > > > > +
> > > > > +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> > > > > +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> > > > > +
> > > > >         mutex_unlock(&mr->mkey_mtx);
> > > > >  }
> > > > >
> > > > > -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> > > > > -                               struct vhost_iotlb *iotlb, unsign=
ed int
> > > > > asid)
> > > > > +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > > +{
> > > > > +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev-
> > > > > > group2asid[MLX5_VDPA_CVQ_GROUP]);
> > > > > +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev-
> > > > > > group2asid[MLX5_VDPA_DATAVQ_GROUP]);
> > > > > +}
> > > > > +
> > > > > +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
> > > > > +                                   struct vhost_iotlb *iotlb,
> > > > > +                                   unsigned int asid)
> > > > > +{
> > > > > +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> > > > > +               return 0;
> > > > > +
> > > > > +       return dup_iotlb(mvdev, iotlb);
> > > >
> > > > This worries me as conceptually, there should be no difference betw=
een
> > > > dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
> > > >
> > > Are you worried by the changes in this patch or about the possibility=
 of
> > > having
> > >
> > > The reason for this change is that I noticed if you create one mr in =
one
> > > asid
> > > you could be blocked out from creating another one in a different asi=
d due
> > > to
> > > mr->initialized being true. To me that seemed problematic. Is it not?
> >
> > My feeling is that mr.c should be device agnostic. It needs to know
> > nothing about the device details to work. But this patch seems to
> > break the layer.
> >
> But the same logic was there before (with the exception of cvq not having=
 an
> init flag anymore). So what am I missing here?

Nothing, I think you're right.

I think we can have this patch go first and tweak on top by moving CVQ
aware logic into the net specific codes.

Thanks

