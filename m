Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13576E29D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjHCIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjHCINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A01A5D1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691049845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moxKMwUDbhA+vA1Ts0dJ3Yq4Q7IThf0mQEpJ1kG2LAM=;
        b=NM+14AH6cy6sbFqiGYWyJDyEl11GZTXdXe1PX//mSeCss04PebY4TsBJNVYSXZXazdqQNb
        GcVPdtJj5xH8l5Le01aU2LXdiN6cEgMof2msIenWi5cyy/UKCrM9T6ug9IuuJSYOALhwfn
        l78z8WUIyApOwvbdcp2VlBpj0dOPGww=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-_i5Yl9xcMdyA149h129LPw-1; Thu, 03 Aug 2023 04:04:02 -0400
X-MC-Unique: _i5Yl9xcMdyA149h129LPw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9e014111fso6700031fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691049840; x=1691654640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moxKMwUDbhA+vA1Ts0dJ3Yq4Q7IThf0mQEpJ1kG2LAM=;
        b=TPw2LbXzu5hiqIem62NN8JUhN3toIibOjT8Y9NDB3/sDs9GLXawCpjvjMkqajd3M4P
         jGZzEGVnPiJRtOUiMOl1QawyEX6bDwOCHU8PJGxO42Z/QiIZOye013gski2f5G1hhjy7
         xq9fnusX3l2fKD1d48wVdSFLY4bsBSc1hTxNhb2I2fz0GinIg8u0Pe918crR7FLEddfu
         bVjJYh/A59LY/SErS94KFZhCtHKd43Z4eIG7hKecgZxw1Xobk981W8a3k+8l47XqSCVL
         ybXfUcx7iP7G4f5h7iYy37XPbDWfqhQeb5elkPR1dGGz4WA3v8FpYEorNPOL1bGfmGXT
         OruQ==
X-Gm-Message-State: ABy/qLbYcD+RTlxFA7Lq1nC1XR2iGhgmRyVac+sWED2nE0XKoFYGy4Qr
        UuWoTt7SqWsL1DV8QV6b1rImFQvAwgxl099RtLLBBg2YuybcM5ZFANdjSv4drxFXvH3fSUM/8Ub
        JLuNEY36ixFs3RGc2cn8u4b906GnE8rICJQ+dphWK/naIXKM9fXBzeQ==
X-Received: by 2002:a2e:97c6:0:b0:2b7:2ea:33c3 with SMTP id m6-20020a2e97c6000000b002b702ea33c3mr7191833ljj.22.1691049840695;
        Thu, 03 Aug 2023 01:04:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMDxVwbeHqj4DgdHBE4iuwjdlVVHKrE3/GFhPOK7CvcNV780cC8GDmA4oCFP3zWPdRN0SaVbdmTAK/LBVxNQY=
X-Received: by 2002:a2e:97c6:0:b0:2b7:2ea:33c3 with SMTP id
 m6-20020a2e97c6000000b002b702ea33c3mr7191814ljj.22.1691049840334; Thu, 03 Aug
 2023 01:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
In-Reply-To: <20230802171231.11001-3-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 3 Aug 2023 16:03:48 +0800
Message-ID: <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> The mr->initialized flag is shared between the control vq and data vq
> part of the mr init/uninit. But if the control vq and data vq get placed
> in different ASIDs, it can happen that initializing the control vq will
> prevent the data vq mr from being initialized.
>
> This patch consolidates the control and data vq init parts into their
> own init functions. The mr->initialized will now be used for the data vq
> only. The control vq currently doesn't need a flag.
>
> The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
> split into data and control vq functions which are now also ASID aware.
>
> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for con=
trol and data")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>  drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>  2 files changed, 71 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 25fc4120b618..a0420be5059f 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
>         struct list_head head;
>         unsigned long num_directs;
>         unsigned long num_klms;
> +       /* state of dvq mr */
>         bool initialized;
>
>         /* serialize mkey creation and destruction */
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 03e543229791..4ae14a248a4b 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *=
mvdev, struct mlx5_vdpa_mr *mr
>         }
>  }
>
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsig=
ned int asid)
> +{
> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> +               return;
> +
> +       prune_iotlb(mvdev);
> +}
> +
> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsig=
ned int asid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>
> -       mutex_lock(&mr->mkey_mtx);
> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> +               return;
> +
>         if (!mr->initialized)
> -               goto out;
> +               return;
>
> -       prune_iotlb(mvdev);
>         if (mr->user_mr)
>                 destroy_user_mr(mvdev, mr);
>         else
>                 destroy_dma_mr(mvdev, mr);
>
>         mr->initialized =3D false;
> -out:
> +}
> +
> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsig=
ned int asid)
> +{
> +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> +
> +       mutex_lock(&mr->mkey_mtx);
> +
> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> +
>         mutex_unlock(&mr->mkey_mtx);
>  }
>
> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> -                               struct vhost_iotlb *iotlb, unsigned int a=
sid)
> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> +{
> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_=
GROUP]);
> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATA=
VQ_GROUP]);
> +}
> +
> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
> +                                   struct vhost_iotlb *iotlb,
> +                                   unsigned int asid)
> +{
> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> +               return 0;
> +
> +       return dup_iotlb(mvdev, iotlb);

This worries me as conceptually, there should be no difference between
dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.

One example is that, if we only do dup_iotlb() but not try to create
dma mr here, we will break virtio-vdpa:

commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
Author: Eli Cohen <elic@nvidia.com>
Date:   Wed Jun 2 11:58:54 2021 +0300

    vdpa/mlx5: Add support for running with virtio_vdpa

    In order to support running vdpa using vritio_vdpa driver, we need  to
    create a different kind of MR, one that has 1:1 mapping, since the
    addresses referring to virtqueues are dma addresses.

    We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
    supports the general capability umem_uid_0. The reason for that is that
    1:1 MRs must be created with uid =3D=3D 0 while virtqueue objects can b=
e
    created with uid =3D=3D 0 only when the firmware capability is on.

    If the set_map() callback is called with new translations provided
    through iotlb, the driver will destroy the 1:1 MR and create a regular
    one.

    Signed-off-by: Eli Cohen <elic@nvidia.com>
    Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvidia.com
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> +}
> +
> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
> +                                   struct vhost_iotlb *iotlb,
> +                                   unsigned int asid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         int err;
>
> -       if (mr->initialized)
> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
>                 return 0;
>
> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> -               if (iotlb)
> -                       err =3D create_user_mr(mvdev, iotlb);
> -               else
> -                       err =3D create_dma_mr(mvdev, mr);
> +       if (mr->initialized)
> +               return 0;
>
> -               if (err)
> -                       return err;
> -       }
> +       if (iotlb)
> +               err =3D create_user_mr(mvdev, iotlb);
> +       else
> +               err =3D create_dma_mr(mvdev, mr);
>
> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid) {
> -               err =3D dup_iotlb(mvdev, iotlb);
> -               if (err)
> -                       goto out_err;
> -       }
> +       if (err)
> +               return err;
>
>         mr->initialized =3D true;
> +
> +       return 0;
> +}
> +
> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> +                               struct vhost_iotlb *iotlb, unsigned int a=
sid)
> +{
> +       int err;
> +
> +       err =3D _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> +       if (err)
> +               return err;
> +
> +       err =3D _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
> +       if (err)
> +               goto out_err;
> +
>         return 0;
>
>  out_err:
> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> -               if (iotlb)
> -                       destroy_user_mr(mvdev, mr);
> -               else
> -                       destroy_dma_mr(mvdev, mr);
> -       }
> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>
>         return err;
>  }
> --
> 2.41.0
>

