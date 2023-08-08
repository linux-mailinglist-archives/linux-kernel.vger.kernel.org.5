Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC43877372E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHHC6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHHC6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B0180
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691463482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26zDz72Dyl4oHNvc89T3j5xZBgM4jPhivLbmigTAUWg=;
        b=WdTecGvCmkiF7b6aXNnz1OzKICQBUvyqTsWgLFMOhzkorTOfIvDn0GU0MBs7P4/IhMdc4c
        /3qpndAqP9tIExfrwbJVI5uSN0eBF/PpxdR4gnFR8qDPpDfocYis/ay4hppiUGtHkSvMNh
        yqAVbcPcO8YTQ0+DcwxEhAEyRu/6swQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-E8jdnzeQNqmqE79LZ5TqCw-1; Mon, 07 Aug 2023 22:58:00 -0400
X-MC-Unique: E8jdnzeQNqmqE79LZ5TqCw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ba0f144938so56419231fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691463479; x=1692068279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26zDz72Dyl4oHNvc89T3j5xZBgM4jPhivLbmigTAUWg=;
        b=W3cKiVmcjbi556XsMn5d67ZrZcy/aJ2DA3ivXSWHvvO/PIeqGxv7WQes8mtmBNQDLQ
         tc55Y17JQlTJc3WQKuJXOjFmm+KWHYXG+YRPbwmZiCjdTbPVkm+tSqeRGbUVBUHN3Ud0
         wz3Q0NCAa9watBEXdfJaGJzDxZSlga/Cc92K/pSSXM4fdaKFdJUaPXwPetcQwVRKUXq7
         nqULmxW9rAoV0hBIZc9qJdB4HMXaYaZxzIm6bXfaJEXQVaS2o1tsTR95dqy5R2clQyRP
         2hGy+DmIW7ymSymyjqkFrFD/unGq3Jy2+idoXoCoWUZ7Y2S7wsbrBKEAJyv5tiubqFM5
         Axug==
X-Gm-Message-State: AOJu0YzebJ/GrB1NdFni7CNPekTF3S+zUKk1MW6ej9jFjPmwMYl1Fnhv
        ieaqBHy5QmanRcDKmjhHlGamSMVUiat4onCFKBIx9A9hLG1jbD52Bu+uzUFgWmekPw28hDT5sy6
        kWcG3sMfKnT7ev8XWouN6YaAvIKASH5+bgr/h9sZF
X-Received: by 2002:a2e:890b:0:b0:2b9:eaa7:c23f with SMTP id d11-20020a2e890b000000b002b9eaa7c23fmr7916096lji.49.1691463479159;
        Mon, 07 Aug 2023 19:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtMSQZJLjN/HAjlh7HCRVmdhR/MmQ+9zU7wkgJjMw2UI2Ixvm21/3BLhQMSg0MIh8Ts5fx6j+biv5yFEQXGSc=
X-Received: by 2002:a2e:890b:0:b0:2b9:eaa7:c23f with SMTP id
 d11-20020a2e890b000000b002b9eaa7c23fmr7916089lji.49.1691463478809; Mon, 07
 Aug 2023 19:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com> <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
In-Reply-To: <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Aug 2023 10:57:47 +0800
Message-ID: <CACGkMEvoE=1ac1EGxPd14AwCfuOTiZYzYgDQC_qZjSubt891sA@mail.gmail.com>
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

On Thu, Aug 3, 2023 at 7:40=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Thu, 2023-08-03 at 16:03 +0800, Jason Wang wrote:
> > On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > The mr->initialized flag is shared between the control vq and data vq
> > > part of the mr init/uninit. But if the control vq and data vq get pla=
ced
> > > in different ASIDs, it can happen that initializing the control vq wi=
ll
> > > prevent the data vq mr from being initialized.
> > >
> > > This patch consolidates the control and data vq init parts into their
> > > own init functions. The mr->initialized will now be used for the data=
 vq
> > > only. The control vq currently doesn't need a flag.
> > >
> > > The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr g=
ot
> > > split into data and control vq functions which are now also ASID awar=
e.
> > >
> > > Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for
> > > control and data")
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> > >  drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++-------=
--
> > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > index 25fc4120b618..a0420be5059f 100644
> > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
> > >         struct list_head head;
> > >         unsigned long num_directs;
> > >         unsigned long num_klms;
> > > +       /* state of dvq mr */
> > >         bool initialized;
> > >
> > >         /* serialize mkey creation and destruction */
> > > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.=
c
> > > index 03e543229791..4ae14a248a4b 100644
> > > --- a/drivers/vdpa/mlx5/core/mr.c
> > > +++ b/drivers/vdpa/mlx5/core/mr.c
> > > @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_d=
ev
> > > *mvdev, struct mlx5_vdpa_mr *mr
> > >         }
> > >  }
> > >
> > > -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, u=
nsigned
> > > int asid)
> > > +{
> > > +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> > > +               return;
> > > +
> > > +       prune_iotlb(mvdev);
> > > +}
> > > +
> > > +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, u=
nsigned
> > > int asid)
> > >  {
> > >         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > >
> > > -       mutex_lock(&mr->mkey_mtx);
> > > +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> > > +               return;
> > > +
> > >         if (!mr->initialized)
> > > -               goto out;
> > > +               return;
> > >
> > > -       prune_iotlb(mvdev);
> > >         if (mr->user_mr)
> > >                 destroy_user_mr(mvdev, mr);
> > >         else
> > >                 destroy_dma_mr(mvdev, mr);
> > >
> > >         mr->initialized =3D false;
> > > -out:
> > > +}
> > > +
> > > +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, u=
nsigned
> > > int asid)
> > > +{
> > > +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > > +
> > > +       mutex_lock(&mr->mkey_mtx);
> > > +
> > > +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> > > +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> > > +
> > >         mutex_unlock(&mr->mkey_mtx);
> > >  }
> > >
> > > -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> > > -                               struct vhost_iotlb *iotlb, unsigned i=
nt
> > > asid)
> > > +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > +{
> > > +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev-
> > > >group2asid[MLX5_VDPA_CVQ_GROUP]);
> > > +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev-
> > > >group2asid[MLX5_VDPA_DATAVQ_GROUP]);
> > > +}
> > > +
> > > +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
> > > +                                   struct vhost_iotlb *iotlb,
> > > +                                   unsigned int asid)
> > > +{
> > > +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> > > +               return 0;
> > > +
> > > +       return dup_iotlb(mvdev, iotlb);
> >
> > This worries me as conceptually, there should be no difference between
> > dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
> >
> Are you worried by the changes in this patch or about the possibility of =
having
>
> The reason for this change is that I noticed if you create one mr in one =
asid
> you could be blocked out from creating another one in a different asid du=
e to
> mr->initialized being true. To me that seemed problematic. Is it not?

My feeling is that mr.c should be device agnostic. It needs to know
nothing about the device details to work. But this patch seems to
break the layer.

>
> > One example is that, if we only do dup_iotlb() but not try to create
> > dma mr here, we will break virtio-vdpa:
> >
> How will that be possible? _mlx5_vdpa_create_mr calls _mlx5_vdpa_create_d=
vq_mr
> and _mlx5_vdpa_create_cvq_mr. The only thing that is different in this pa=
tch is
> that the cvq is not protected by an init flag. My understanding was that =
it
> would be ok to dup_iotlb again. Is it not? If not I could add an addition=
al
> initialized flag for the cvq mr.

You are right here.

Thanks


>
> Thanks,
> Dragos
>
> > commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
> > Author: Eli Cohen <elic@nvidia.com>
> > Date:   Wed Jun 2 11:58:54 2021 +0300
> >
> >     vdpa/mlx5: Add support for running with virtio_vdpa
> >
> >     In order to support running vdpa using vritio_vdpa driver, we need =
 to
> >     create a different kind of MR, one that has 1:1 mapping, since the
> >     addresses referring to virtqueues are dma addresses.
> >
> >     We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
> >     supports the general capability umem_uid_0. The reason for that is =
that
> >     1:1 MRs must be created with uid =3D=3D 0 while virtqueue objects c=
an be
> >     created with uid =3D=3D 0 only when the firmware capability is on.
> >
> >     If the set_map() callback is called with new translations provided
> >     through iotlb, the driver will destroy the 1:1 MR and create a regu=
lar
> >     one.
> >
> >     Signed-off-by: Eli Cohen <elic@nvidia.com>
> >     Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvidia.=
com
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >     Acked-by: Jason Wang <jasowang@redhat.com>
> >
> >
>
> > Thanks
> >
> >
>
> > > +}
> > > +
> > > +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
> > > +                                   struct vhost_iotlb *iotlb,
> > > +                                   unsigned int asid)
> > >  {
> > >         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > >         int err;
> > >
> > > -       if (mr->initialized)
> > > +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> > >                 return 0;
> > >
> > > -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> > > -               if (iotlb)
> > > -                       err =3D create_user_mr(mvdev, iotlb);
> > > -               else
> > > -                       err =3D create_dma_mr(mvdev, mr);
> > > +       if (mr->initialized)
> > > +               return 0;
> > >
> > > -               if (err)
> > > -                       return err;
> > > -       }
> > > +       if (iotlb)
> > > +               err =3D create_user_mr(mvdev, iotlb);
> > > +       else
> > > +               err =3D create_dma_mr(mvdev, mr);
> > >
> > > -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid) {
> > > -               err =3D dup_iotlb(mvdev, iotlb);
> > > -               if (err)
> > > -                       goto out_err;
> > > -       }
> > > +       if (err)
> > > +               return err;
> > >
> > >         mr->initialized =3D true;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> > > +                               struct vhost_iotlb *iotlb, unsigned i=
nt
> > > asid)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       err =3D _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
> > > +       if (err)
> > > +               goto out_err;
> > > +
> > >         return 0;
> > >
> > >  out_err:
> > > -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> > > -               if (iotlb)
> > > -                       destroy_user_mr(mvdev, mr);
> > > -               else
> > > -                       destroy_dma_mr(mvdev, mr);
> > > -       }
> > > +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> > >
> > >         return err;
> > >  }
> > > --
> > > 2.41.0
> > >
> >
>

