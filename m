Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41B800DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379232AbjLAOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379210AbjLAOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB911700
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701442077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0DKYjK3dHbWdZnT5RD7tpOx0HUXsQyGhREUzJYhZ0I=;
        b=Tudmxwsbx/ERxpd2WySW3EG5MXRj9pJxhxE/c75Ps7GEq+7BwzbIaC6r6TJH2VeOsD+OZf
        d1T9qCmkAOB9KjGd9LEAoFYNjQhifH+qymQYtpY5QviAv8JD8uzvMhO5NOu5Ry9t5mnGjs
        8u+BtJH41h5++ej23QBJKc4rZmrZ4i8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-92paGFiXMiCgD-J0l3OSbA-1; Fri, 01 Dec 2023 09:47:53 -0500
X-MC-Unique: 92paGFiXMiCgD-J0l3OSbA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d42c43d8daso4679627b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442072; x=1702046872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0DKYjK3dHbWdZnT5RD7tpOx0HUXsQyGhREUzJYhZ0I=;
        b=anA6fmTqHsZSWSNjJvhvuKDnaDe/j4M48pb996p4+NJ3zvLeo8KPL/TxUMjfwgFf2F
         2Ix2ysuMOk+m1teno1bfVE12vdQWaD1Rh0MxJhUNNiQQ/qqm43jDlj/dh0U+D2f4NZvv
         SxPGHLFGDKuXQNrWL9xgfNE4YjohEj7IdncsPZjWFJjelnM49+7HwoS6g0gfqI+sSsa6
         bRmg+D+NK1pC20JrUtpFL9Ouiv0+yX7xteIwJd1FrLmxujFYpNhUlphcO+GKXj73ayWN
         MNIoaDblPPjF7OFjsb9gHwEz/MqVnysnu+6EyeKBI+zlDVW7FkRgusMGkPvoDBWdArAR
         j/rg==
X-Gm-Message-State: AOJu0Yz3Gq9tR8KfQ5za9pl+cnFCahgb7aL94DoSbuasjDaMANII3/uj
        n2k46Lw38gb0OOIYNHRgZLWduJ85M70Vhk4PEK7Yu2AYxebMAGREaVNJYFstENPMqcQFLpnM0TY
        52g+OrZW+ItrunyLQVv22gyBXtYoJ23kpibILRn2V
X-Received: by 2002:a05:690c:2e07:b0:5ce:723:ae79 with SMTP id et7-20020a05690c2e0700b005ce0723ae79mr18248088ywb.15.1701442072633;
        Fri, 01 Dec 2023 06:47:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6DQyuGDAakubhth8noPl0UkdPsVbsGwXorIpn7CGnUTxYiRgTbbU+n27HzNui0D93AvLxUvxPpOLJR7x6Jy0=
X-Received: by 2002:a05:690c:2e07:b0:5ce:723:ae79 with SMTP id
 et7-20020a05690c2e0700b005ce0723ae79mr18248067ywb.15.1701442072363; Fri, 01
 Dec 2023 06:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20231201104857.665737-1-dtatulea@nvidia.com> <20231201104857.665737-4-dtatulea@nvidia.com>
In-Reply-To: <20231201104857.665737-4-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 1 Dec 2023 15:47:16 +0100
Message-ID: <CAJaqyWe_VZ8CsG5j75oAD1FdNi7dc4rLJwjm5AoQNBm4ABfAZA@mail.gmail.com>
Subject: Re: [PATCH vhost 3/7] vdpa/mlx5: Allow modifying multiple vq fields
 in one modify command
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 11:49=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Add a bitmask variable that tracks hw vq field changes that
> are supposed to be modified on next hw vq change command.
>
> This will be useful to set multiple vq fields when resuming the vq.
>
> The state needs to remain as a parameter as it doesn't make sense to
> make it part of the vq struct: fw_state is updated only after a
> successful command.
>

I don't get this paragraph, "modified_fields" is a member of
"mlx5_vdpa_virtqueue". Am I missing something?


> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 48 +++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 12ac3397f39b..d06285e46fe2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -120,6 +120,9 @@ struct mlx5_vdpa_virtqueue {
>         u16 avail_idx;
>         u16 used_idx;
>         int fw_state;
> +
> +       u64 modified_fields;
> +
>         struct msi_map map;
>
>         /* keep last in the struct */
> @@ -1181,7 +1184,19 @@ static bool is_valid_state_change(int oldstate, in=
t newstate)
>         }
>  }
>
> -static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa=
_virtqueue *mvq, int state)
> +static bool modifiable_virtqueue_fields(struct mlx5_vdpa_virtqueue *mvq)
> +{
> +       /* Only state is always modifiable */
> +       if (mvq->modified_fields & ~MLX5_VIRTQ_MODIFY_MASK_STATE)
> +               return mvq->fw_state =3D=3D MLX5_VIRTIO_NET_Q_OBJECT_STAT=
E_INIT ||
> +                      mvq->fw_state =3D=3D MLX5_VIRTIO_NET_Q_OBJECT_STAT=
E_SUSPEND;
> +
> +       return true;
> +}
> +
> +static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
> +                           struct mlx5_vdpa_virtqueue *mvq,
> +                           int state)
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(modify_virtio_net_q_out)] =3D {};
> @@ -1193,6 +1208,9 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtque
>         if (mvq->fw_state =3D=3D MLX5_VIRTIO_NET_Q_OBJECT_NONE)
>                 return 0;
>
> +       if (!modifiable_virtqueue_fields(mvq))
> +               return -EINVAL;
> +

I'm ok with this change, but since modified_fields is (or will be) a
bitmap tracking changes to state, addresses, mkey, etc, doesn't have
more sense to check it like:

if (modified_fields & 1<<change_1_flag)
  // perform change 1
if (modified_fields & 1<<change_2_flag)
  // perform change 2
if (modified_fields & 1<<change_3_flag)
  // perform change 13
---

Instead of:
if (!modified_fields)
  return

if (modified_fields & 1<<change_1_flag)
  // perform change 1
if (modified_fields & 1<<change_2_flag)
  // perform change 2

// perform change 3, no checking, as it is the only possible value of
modified_fields
---

Or am I missing something?

The rest looks good to me.

>         if (!is_valid_state_change(mvq->fw_state, state))
>                 return -EINVAL;
>
> @@ -1208,17 +1226,28 @@ static int modify_virtqueue(struct mlx5_vdpa_net =
*ndev, struct mlx5_vdpa_virtque
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.ui=
d);
>
>         obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q_in, in, obj_cont=
ext);
> -       MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,
> -                  MLX5_VIRTQ_MODIFY_MASK_STATE);
> -       MLX5_SET(virtio_net_q_object, obj_context, state, state);
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE)
> +               MLX5_SET(virtio_net_q_object, obj_context, state, state);
> +
> +       MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
>         err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
>         kfree(in);
>         if (!err)
>                 mvq->fw_state =3D state;
>
> +       mvq->modified_fields =3D 0;
> +
>         return err;
>  }
>
> +static int modify_virtqueue_state(struct mlx5_vdpa_net *ndev,
> +                                 struct mlx5_vdpa_virtqueue *mvq,
> +                                 unsigned int state)
> +{
> +       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_STATE;
> +       return modify_virtqueue(ndev, mvq, state);
> +}
> +
>  static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdp=
a_virtqueue *mvq)
>  {
>         u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] =3D {};
> @@ -1347,7 +1376,7 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, str=
uct mlx5_vdpa_virtqueue *mvq)
>                 goto err_vq;
>
>         if (mvq->ready) {
> -               err =3D modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJ=
ECT_STATE_RDY);
> +               err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET=
_Q_OBJECT_STATE_RDY);
>                 if (err) {
>                         mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to=
 ready vq idx %d(%d)\n",
>                                        idx, err);
> @@ -1382,7 +1411,7 @@ static void suspend_vq(struct mlx5_vdpa_net *ndev, =
struct mlx5_vdpa_virtqueue *m
>         if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
>                 return;
>
> -       if (modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SU=
SPEND))
> +       if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_SUSPEND))
>                 mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed\n"=
);
>
>         if (query_virtqueue(ndev, mvq, &attr)) {
> @@ -1407,6 +1436,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev,=
 struct mlx5_vdpa_virtqueue *
>                 return;
>
>         suspend_vq(ndev, mvq);
> +       mvq->modified_fields =3D 0;
>         destroy_virtqueue(ndev, mvq);
>         dealloc_vector(ndev, mvq);
>         counter_set_dealloc(ndev, mvq);
> @@ -2207,7 +2237,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_devi=
ce *vdev, u16 idx, bool ready
>         if (!ready) {
>                 suspend_vq(ndev, mvq);
>         } else {
> -               err =3D modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJ=
ECT_STATE_RDY);
> +               err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET=
_Q_OBJECT_STATE_RDY);
>                 if (err) {
>                         mlx5_vdpa_warn(mvdev, "modify VQ %d to ready fail=
ed (%d)\n", idx, err);
>                         ready =3D false;
> @@ -2804,8 +2834,10 @@ static void clear_vqs_ready(struct mlx5_vdpa_net *=
ndev)
>  {
>         int i;
>
> -       for (i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
>                 ndev->vqs[i].ready =3D false;
> +               ndev->vqs[i].modified_fields =3D 0;
> +       }
>
>         ndev->mvdev.cvq.ready =3D false;
>  }
> --
> 2.42.0
>

