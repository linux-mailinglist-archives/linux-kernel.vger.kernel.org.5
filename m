Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A96800A04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378595AbjLALrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85F1B3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701431243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uHVtje56LWat5Vmv+PcEyAck+di+XL9VN6HEiOJE+M=;
        b=cpgMDxSzDZ0GU5naCPN+Zw1Hm/HvfEp5RiIe/Z9ZYzovUW+9lG6Hd+Sy4Mu/+qdIJpBZiM
        R63J8fzLMIbFJVHCszWTGSsLlVbXZrEsht35pdXB603J4wMTDfmyAfHubD/InsJUgWwwvJ
        SBVwU/Eq6SQ9rM76MH2B1YN26S2SzaM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-QrJ49SLzMZWsOdh1H5s26A-1; Fri, 01 Dec 2023 06:47:22 -0500
X-MC-Unique: QrJ49SLzMZWsOdh1H5s26A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5d6b751dabcso2349057b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 03:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431242; x=1702036042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uHVtje56LWat5Vmv+PcEyAck+di+XL9VN6HEiOJE+M=;
        b=k2cS/VeJezRbzJ7MPQoL5O3OG00GWqal5dhuQiVerd3swEwhsxPDe+r1rT3jx4jltn
         EgVwYq1S8PsxkDfExtZfGJtOwCu8BpbZtQh1oG6Ih7DUaXtHxXiCdUtCM3meXMwwYG3U
         zQBwP2I/yfY4m2f5wRyclgdaJXxJUFkANIiLlK8WtxrO7jBsgYHmtYNLeJneKcaB7DR5
         HSnqJBmlAc6cYIty6E1+ycJ8L7VyrRIjZ0v7xu1/Cfkag8Zy/sfK7OLqaKgitNGo+NjJ
         hamKgv3/W0bdXohh726T4f68ILff1yV49K5fZayGVRsYVwAnzcENc+jdaHoQV3RUnV7q
         wH5g==
X-Gm-Message-State: AOJu0YzsGaV+T6W+Ng2NWT+bh12tCcXyMMlUh9FzAGLfRhOBR7QR8HZi
        DD6D3IFbOJSN8ZOzRCMKqyq7qwhl6gSpF4i6raqoSNipxUqzVZE6DM226RtLIzd+H9P0SC8vhiE
        dBQyEPM34L4UlYfUtAJKW/OoyIeFmNUnqABHI6tN+
X-Received: by 2002:a81:b60c:0:b0:5d4:226f:69a4 with SMTP id u12-20020a81b60c000000b005d4226f69a4mr1446066ywh.28.1701431241865;
        Fri, 01 Dec 2023 03:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg2MuyiMF1tTj3uUQulmb0jD2AozD8K6xVD0pM3BW790ulvznuBYypSmkNfOvOQQkPXQZjksPtzVYkngc8Se0=
X-Received: by 2002:a81:b60c:0:b0:5d4:226f:69a4 with SMTP id
 u12-20020a81b60c000000b005d4226f69a4mr1446054ywh.28.1701431241604; Fri, 01
 Dec 2023 03:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20231201104857.665737-1-dtatulea@nvidia.com> <20231201104857.665737-3-dtatulea@nvidia.com>
In-Reply-To: <20231201104857.665737-3-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 1 Dec 2023 12:46:45 +0100
Message-ID: <CAJaqyWc3Xa9abmS+MxFbgQHUao0_=tcx4mres2AeDWqvtmZ5Jg@mail.gmail.com>
Subject: Re: [PATCH vhost 2/7] vdpa/mlx5: Split function into locked and
 unlocked variants
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 11:49=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> mlx5_vdpa_destroy_mr contains more logic than _mlx5_vdpa_destroy_mr.
> There is no reason for this to be the case. All the logic can go into
> the unlocked variant.
>
> Using the unlocked version is needed in a follow-up patch. And it also
> makes it more consistent with mlx5_vdpa_create_mr.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mr.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 2197c46e563a..8c80d9e77935 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -498,32 +498,32 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_mr *mr
>
>  static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct ml=
x5_vdpa_mr *mr)
>  {
> +       if (!mr)
> +               return;
> +
>         if (mr->user_mr)
>                 destroy_user_mr(mvdev, mr);
>         else
>                 destroy_dma_mr(mvdev, mr);
>
> +       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++) {
> +               if (mvdev->mr[i] =3D=3D mr)
> +                       mvdev->mr[i] =3D NULL;
> +       }
> +
>         vhost_iotlb_free(mr->iotlb);
> +
> +       kfree(mr);
>  }
>
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
>                           struct mlx5_vdpa_mr *mr)
>  {
> -       if (!mr)
> -               return;
> -
>         mutex_lock(&mvdev->mr_mtx);
>
>         _mlx5_vdpa_destroy_mr(mvdev, mr);
>
> -       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++) {
> -               if (mvdev->mr[i] =3D=3D mr)
> -                       mvdev->mr[i] =3D NULL;
> -       }
> -
>         mutex_unlock(&mvdev->mr_mtx);
> -
> -       kfree(mr);
>  }
>
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -535,10 +535,7 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev=
,
>         mutex_lock(&mvdev->mr_mtx);
>
>         mvdev->mr[asid] =3D new_mr;
> -       if (old_mr) {
> -               _mlx5_vdpa_destroy_mr(mvdev, old_mr);
> -               kfree(old_mr);
> -       }
> +       _mlx5_vdpa_destroy_mr(mvdev, old_mr);
>
>         mutex_unlock(&mvdev->mr_mtx);
>
> @@ -546,8 +543,12 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev=
,
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
> +       mutex_lock(&mvdev->mr_mtx);
> +
>         for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
> -               mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
> +               _mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
> +
> +       mutex_unlock(&mvdev->mr_mtx);
>
>         prune_iotlb(mvdev->cvq.iotlb);
>  }
> --
> 2.42.0
>

