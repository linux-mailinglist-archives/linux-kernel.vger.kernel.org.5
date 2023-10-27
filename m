Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C77D8EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbjJ0GdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0GdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D531B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698388345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxDkgS0LFdb0zrxOK5z/6YMxINonlxbWmMRbtDHv7CM=;
        b=ODuodmcSIP1skji2BUgU1YBhNcEZql7o9VscOuRFjhiBB4Q/9maAoEF6X+3GTq+jMYtt8j
        iWuhsPF4dGMlS1tGBdoKNyxGqQT1r2Nz9Oarx/Di4X7UeXtaQlTSrbYXAP07t933HjF5lB
        hO1oCygMPG52SJAIaYuGyyGkGDmaSjc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-iPiiBQb-MlyJv0aUOz6TJw-1; Fri, 27 Oct 2023 02:32:08 -0400
X-MC-Unique: iPiiBQb-MlyJv0aUOz6TJw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507bd5f4b2dso1892943e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388327; x=1698993127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxDkgS0LFdb0zrxOK5z/6YMxINonlxbWmMRbtDHv7CM=;
        b=CvLD0B08bO3I/LSFrcuLeTtpuXgAJe+WEa8w7/sQII5yOPE2nBZv8u0NhMXg5TWajX
         kDToedhCOVHUealqBSZVY2P5WcDX+JsE7RekviDgbhvPds7Bom6qeWvAqMcIpAW34wN0
         2oWiWe9ujKWvnpyfifY536MzvAOvyYezNzb9fL9ID5aQZswiN8/QKDOaiispkUFHGYQS
         g/5sM6QCQKYc24Cc2aWAu7jnP2m6KdODA9GrVm5iW30vR9J313TPq9onRJgEEjfQdopp
         Wbpyi0EBAQ69r2KmGtuyqeWAPl54J8ENnIWYnPVa9tx1hAuGLSjtN6zV59Z8oeyYfGdS
         FRRA==
X-Gm-Message-State: AOJu0YzrhQzr5S2mK+4kES2eW/X8et3O8wjf2V4A1+xvSZoibFraB7PV
        8VEVFUNGdkTZSAPOv3c5rx4M56Us6IbvLnOgfPwyYqTwHER7ouAYKsULtmzpGk1SJyD06Uor8CK
        uek8lMtwBTb0+5fVT5uAwCtR5sOjYOxThnQPFQ30x
X-Received: by 2002:a19:ac01:0:b0:507:b15b:8b88 with SMTP id g1-20020a19ac01000000b00507b15b8b88mr1178195lfc.65.1698388327383;
        Thu, 26 Oct 2023 23:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYiELfA5C7GIEPjiLdoikmssHWmewGe+r2BT1FO6KFjk37oJ/xRsKtzheJyFQ2V4ExxBcUM65fs6HpyHCi300=
X-Received: by 2002:a19:ac01:0:b0:507:b15b:8b88 with SMTP id
 g1-20020a19ac01000000b00507b15b8b88mr1178176lfc.65.1698388327046; Thu, 26 Oct
 2023 23:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 27 Oct 2023 14:31:56 +0800
Message-ID: <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To:     Steve Sistare <steven.sistare@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 4:07=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> mlx5_vdpa does not preserve userland's view of vring base for the control
> queue in the following sequence:
>
> ioctl VHOST_SET_VRING_BASE
> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>   mlx5_vdpa_set_status()
>     setup_cvq_vring()
>       vringh_init_iotlb()
>         vringh_init_kern()
>           vrh->last_avail_idx =3D 0;
> ioctl VHOST_GET_VRING_BASE
>
> To fix, restore the value of cvq->vring.last_avail_idx after calling
> vringh_init_iotlb.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
>  drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
>  include/linux/vringh.h            |  2 ++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 946488b8989f..f64758143115 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *=
mvdev)
>         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
>         int err =3D 0;
>
> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> +               u16 last_avail_idx =3D cvq->vring.last_avail_idx;
> +
>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
>                                         MLX5_CVQ_MAX_ENT, false,
>                                         (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
>                                         (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
>                                         (struct vring_used *)(uintptr_t)c=
vq->device_addr);
>
> +               if (!err)
> +                       vringh_set_base_iotlb(&cvq->vring, last_avail_idx=
);

Btw, vringh_set_base_iotlb() deserves an independent patch and it
seems it is not specific to IOTLB, so we probably need an indirection
to have vringh_set_base() first.

Or I wonder if it's better to just introduce a new parameter to
vringh_init_iotlb()...

Thanks

> +       }
>         return err;
>  }
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 7b8fd977f71c..799762c83007 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct vr=
ingh *vrh,
>         }
>  }
>
> +static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
> +                           int (*putu16)(const struct vringh *vrh,
> +                               __virtio16 *p, u16 val))
> +{
> +    int ret;
> +
> +    ret =3D putu16(vrh, &vrh->vring.avail->idx, idx);
> +    if (ret)
> +        return ret;
> +
> +    ret =3D putu16(vrh, &vrh->vring.used->idx, idx);
> +    if (ret)
> +        return ret;
> +
> +    vrh->last_avail_idx =3D vrh->last_used_idx =3D idx;
> +    return 0;
> +}
> +
>  /* Userspace access helpers: in this case, addresses are really userspac=
e. */
>  static inline int getu16_user(const struct vringh *vrh, u16 *val, const =
__virtio16 *p)
>  {
> @@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struct v=
host_iotlb *iotlb,
>  }
>  EXPORT_SYMBOL(vringh_set_iotlb);
>
> +/**
> + * vringh_set_base_iotlb - set avail_idx and used_idx
> + * @vrh: the vring
> + * @idx: the value to set
> + */
> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
> +{
> +    return __vringh_set_base(vrh, idx, putu16_iotlb);
> +}
> +EXPORT_SYMBOL(vringh_set_base_iotlb);
> +
> +
>  /**
>   * vringh_getdesc_iotlb - get next available descriptor from ring with
>   * IOTLB.
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index c3a8117dabe8..e9b8af4e6a5e 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 feat=
ures,
>                          struct vring_avail *avail,
>                          struct vring_used *used);
>
> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
> +
>  int vringh_getdesc_iotlb(struct vringh *vrh,
>                          struct vringh_kiov *riov,
>                          struct vringh_kiov *wiov,
> --
> 2.39.3
>

