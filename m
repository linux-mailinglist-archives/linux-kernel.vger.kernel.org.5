Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0784800DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379253AbjLAOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379210AbjLAOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E1170B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701442345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M36H2ZE/zqK8RyhbzWXIquvsFKXeeJ9yx55a+Ipktnk=;
        b=NtDObL+hhBBz1ZYZ2HIO5hm6EiEYz4pESwTYHMqsPUnUo9WlFhqJmCFmL3paWMBXj5HbLq
        ikHVZV5MnZEBhrn7iztPydi6ANHqnDnefololhv+Sadjwx+Fi3x+cvS6Cu+amwD3DAY+Hr
        1e40bjTdjX1Q9NzcGeG53iutKPYRAE0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-KBwQtRSxMoakntv3Ca5i9A-1; Fri, 01 Dec 2023 09:52:23 -0500
X-MC-Unique: KBwQtRSxMoakntv3Ca5i9A-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d39d74bc14so24226267b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442343; x=1702047143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M36H2ZE/zqK8RyhbzWXIquvsFKXeeJ9yx55a+Ipktnk=;
        b=Y+SxAjDiefTtkafwxU6xZBIb9QFKax4IweorQNrQJ0EoAaFH9qn7dQbAU5RWH1P9Aa
         7vv5XikOcNAJDpn75fqCuoUY5NZ4yXrNyTSR9+pcGd6gSqjq2G0IHfliON+uDrh+fjrs
         rNuTduxGqZv8wIxLFysuLKSf+ROtpU8IE+WUQKinwgipOHrbzB1LBLLwjKhrA4+QSFLs
         SWjDEdlAguX4qmFmoURFhasa9FqaJ2DTxMNFK8j20OknsvJfLHM9QXy8sgdWz/VG4zDW
         9mshVmAbgH7Fb+FuxKx/1KMNDJv6xOrJAeC0nnH8lWsHAlk4beXmzgawzIO9WkVI/xdb
         X9ZQ==
X-Gm-Message-State: AOJu0YwwNm9fQeo2IglLaP6GdlPRUj4cJPIKUxC1Fhcm/Zq4aNafXIJU
        V5PGlwYiLYIw5PCc7SWUnhpL1jUyrQatN5ZEk5mdkR6cVncAZ7j2LCCMmCNDtoulRaYmIUdq8ZX
        t1Lq4cWOnHWcFBFLBAFVxw4O1a1ZvweEmN/hRXmyL
X-Received: by 2002:a81:b60a:0:b0:5ca:7a21:7e22 with SMTP id u10-20020a81b60a000000b005ca7a217e22mr5720820ywh.9.1701442343424;
        Fri, 01 Dec 2023 06:52:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH77WA6pWwX+ZGRLtEzkklrZy0mJdFDKrtFUrCDSSJGs7MmgNUt5HNm86oHzaOg6LxdBPjKZZLz92vapvRDZ/Y=
X-Received: by 2002:a81:b60a:0:b0:5ca:7a21:7e22 with SMTP id
 u10-20020a81b60a000000b005ca7a217e22mr5720796ywh.9.1701442343111; Fri, 01 Dec
 2023 06:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20231201104857.665737-1-dtatulea@nvidia.com> <20231201104857.665737-5-dtatulea@nvidia.com>
In-Reply-To: <20231201104857.665737-5-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 1 Dec 2023 15:51:47 +0100
Message-ID: <CAJaqyWcc2ZtnqUGNk6ox7S_kbnDGy3kWPyxC-7HT4F7aN22BRA@mail.gmail.com>
Subject: Re: [PATCH vhost 4/7] vdpa/mlx5: Introduce per vq and device resume
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gal Pressman <galp@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 11:50=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Implement vdpa vq and device resume if capability detected. Add support
> for suspend -> ready state change.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 67 +++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d06285e46fe2..68e534cb57e2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1170,7 +1170,12 @@ static int query_virtqueue(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtqueu
>         return err;
>  }
>
> -static bool is_valid_state_change(int oldstate, int newstate)
> +static bool is_resumable(struct mlx5_vdpa_net *ndev)
> +{
> +       return ndev->mvdev.vdev.config->resume;
> +}
> +
> +static bool is_valid_state_change(int oldstate, int newstate, bool resum=
able)
>  {
>         switch (oldstate) {
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> @@ -1178,6 +1183,7 @@ static bool is_valid_state_change(int oldstate, int=
 newstate)
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
>                 return newstate =3D=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUS=
PEND;
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +               return resumable ? newstate =3D=3D MLX5_VIRTIO_NET_Q_OBJE=
CT_STATE_RDY : false;
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
>         default:
>                 return false;
> @@ -1200,6 +1206,7 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev,
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(modify_virtio_net_q_out)] =3D {};
> +       bool state_change =3D false;
>         void *obj_context;
>         void *cmd_hdr;
>         void *in;
> @@ -1211,9 +1218,6 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev,
>         if (!modifiable_virtqueue_fields(mvq))
>                 return -EINVAL;
>
> -       if (!is_valid_state_change(mvq->fw_state, state))
> -               return -EINVAL;
> -
>         in =3D kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1226,17 +1230,29 @@ static int modify_virtqueue(struct mlx5_vdpa_net =
*ndev,
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.ui=
d);
>
>         obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q_in, in, obj_cont=
ext);
> -       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE)
> +
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE) {
> +               if (!is_valid_state_change(mvq->fw_state, state, is_resum=
able(ndev))) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +
>                 MLX5_SET(virtio_net_q_object, obj_context, state, state);
> +               state_change =3D true;
> +       }
>
>         MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
>         err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
> -       kfree(in);
> -       if (!err)
> +       if (err)
> +               goto done;
> +
> +       if (state_change)
>                 mvq->fw_state =3D state;
>
>         mvq->modified_fields =3D 0;
>
> +done:
> +       kfree(in);
>         return err;
>  }
>
> @@ -1430,6 +1446,24 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev=
)
>                 suspend_vq(ndev, &ndev->vqs[i]);
>  }
>
> +static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
> +{
> +       if (!mvq->initialized || !is_resumable(ndev))
> +               return;
> +
> +       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
> +               return;
> +
> +       if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_RDY))
> +               mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed\n")=
;
> +}
> +
> +static void resume_vqs(struct mlx5_vdpa_net *ndev)
> +{
> +       for (int i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +               resume_vq(ndev, &ndev->vqs[i]);
> +}
> +
>  static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_vir=
tqueue *mvq)
>  {
>         if (!mvq->initialized)
> @@ -3256,6 +3290,21 @@ static int mlx5_vdpa_suspend(struct vdpa_device *v=
dev)
>         return 0;
>  }
>
> +static int mlx5_vdpa_resume(struct vdpa_device *vdev)
> +{
> +       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +
> +       mlx5_vdpa_info(mvdev, "resuming device\n");
> +
> +       down_write(&ndev->reslock);
> +       mvdev->suspended =3D false;
> +       resume_vqs(ndev);
> +       register_link_notifier(ndev);
> +       up_write(&ndev->reslock);
> +       return 0;
> +}
> +
>  static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
>                                unsigned int asid)
>  {
> @@ -3312,6 +3361,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops =
=3D {
>         .get_vq_dma_dev =3D mlx5_get_vq_dma_dev,
>         .free =3D mlx5_vdpa_free,
>         .suspend =3D mlx5_vdpa_suspend,
> +       .resume =3D mlx5_vdpa_resume, /* Op disabled if not supported. */
>  };
>
>  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> @@ -3683,6 +3733,9 @@ static int mlx5v_probe(struct auxiliary_device *ade=
v,
>         if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, desc_group_mkey_supported)=
)
>                 mgtdev->vdpa_ops.get_vq_desc_group =3D NULL;
>
> +       if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, freeze_to_rdy_supported))
> +               mgtdev->vdpa_ops.resume =3D NULL;
> +
>         err =3D vdpa_mgmtdev_register(&mgtdev->mgtdev);
>         if (err)
>                 goto reg_err;
> --
> 2.42.0
>

