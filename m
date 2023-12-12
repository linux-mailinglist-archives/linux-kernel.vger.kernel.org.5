Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8480F590
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjLLSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjLLSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3704101
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702406015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DY4Ho2xtxV0ldC2dQ8P0wLgCZVZkQ1qv4NfOBypcZ+I=;
        b=Hq3D0jGberA1WPOBvVenxRaIT9HQzsYQUn7D7ZJMKTP/fBdVHRWS2pROUx2k08eg2tww0Q
        tB1XMbc2BCkC6qA/GJNiF/jnnTTmBNHKXPyv6vbqpW9aMaiyCgB8lo51FXZWxr1bmpghD8
        wCezzXmtj+A5nKHzAuiQiVJOvsMNnDk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-bqFvRLJONnqhwlFz4KMqhQ-1; Tue, 12 Dec 2023 13:33:34 -0500
X-MC-Unique: bqFvRLJONnqhwlFz4KMqhQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-db542ec49d9so6190844276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702406014; x=1703010814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY4Ho2xtxV0ldC2dQ8P0wLgCZVZkQ1qv4NfOBypcZ+I=;
        b=ntnqh2k8FxOkCorU8JbdipJgg2G6h+IsQ/yUNZYOEr+P4PPMb6yxyy2rK2tZucPWw2
         /gnaAp45oh1YCq6AKjnxaSybYJDlr/iYkBrvo8G+tda22igL2UxaAOZLQ2wiRIph43xr
         RovxVw4kO/toQiTzOMMvQWLLK2XfrwdC2ASJlBoJnOgwaERd5VZKaoEuNUz9DDCk0UUp
         73Dav//BP1AOyftMcxqbaYpT3YgGkoTkKhDI6s8ESWI3n6zv5vzMJ7KeMjOo4KIA2YbB
         Y24bUaoPag4wApfEMBznmuQBBaprTEHlY2QAccDKmcJKM8Bq4HIymDRdbii/7pHP8SrV
         +/LA==
X-Gm-Message-State: AOJu0YzImN0fNK8t5EpigavcbOo9Z6MoTwZehQqnAW2tUYsjT8ijF7Yf
        DlwLNm9sYJdomPmh8ZR8fXeoqLnIyNvJeNAalKAtrsDBFEm0Cl7fpXOmu4SkP3HdGuAGw6UTdTW
        rg8VxB7T7r9bENQ991Jm0E7kQJx+qgBhwDW+6xLDs
X-Received: by 2002:a25:694e:0:b0:db7:dad0:76d4 with SMTP id e75-20020a25694e000000b00db7dad076d4mr4083020ybc.112.1702406013892;
        Tue, 12 Dec 2023 10:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgHGmEdl6YUM2TV851wK+4D25Di/15UW9oEJOx2YbjevvT2YLhlXlylB0hU41DH45mMWlAUyKq8X2SP6Z8qeI=
X-Received: by 2002:a25:694e:0:b0:db7:dad0:76d4 with SMTP id
 e75-20020a25694e000000b00db7dad076d4mr4083010ybc.112.1702406013590; Tue, 12
 Dec 2023 10:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20231205104609.876194-1-dtatulea@nvidia.com> <20231205104609.876194-9-dtatulea@nvidia.com>
In-Reply-To: <20231205104609.876194-9-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 12 Dec 2023 19:32:57 +0100
Message-ID: <CAJaqyWcZou64q2VBgVdJMK3KbJVx9eduRiju8vjXnKa8gv52ng@mail.gmail.com>
Subject: Re: [PATCH vhost v2 8/8] vdpa/mlx5: Add mkey leak detection
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

On Tue, Dec 5, 2023 at 11:47=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Track allocated mrs in a list and show warning when leaks are detected
> on device free or reset.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 ++
>  drivers/vdpa/mlx5/core/mr.c        | 23 +++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  2 ++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 1a0d27b6e09a..50aac8fe57ef 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -37,6 +37,7 @@ struct mlx5_vdpa_mr {
>         bool user_mr;
>
>         refcount_t refcount;
> +       struct list_head mr_list;
>  };
>
>  struct mlx5_vdpa_resources {
> @@ -95,6 +96,7 @@ struct mlx5_vdpa_dev {
>         u32 generation;
>
>         struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
> +       struct list_head mr_list_head;
>         /* serialize mr access */
>         struct mutex mr_mtx;
>         struct mlx5_control_vq cvq;
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index c7dc8914354a..4758914ccf86 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -508,6 +508,8 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_de=
v *mvdev, struct mlx5_vdpa_
>
>         vhost_iotlb_free(mr->iotlb);
>
> +       list_del(&mr->mr_list);
> +
>         kfree(mr);
>  }
>
> @@ -560,12 +562,31 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvde=
v,
>         mutex_unlock(&mvdev->mr_mtx);
>  }
>
> +static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_vdpa_mr *mr;
> +
> +       mutex_lock(&mvdev->mr_mtx);
> +
> +       list_for_each_entry(mr, &mvdev->mr_list_head, mr_list) {
> +
> +               mlx5_vdpa_warn(mvdev, "mkey still alive after resource de=
lete: "
> +                                     "mr: %p, mkey: 0x%x, refcount: %u\n=
",
> +                                      mr, mr->mkey, refcount_read(&mr->r=
efcount));
> +       }
> +
> +       mutex_unlock(&mvdev->mr_mtx);
> +
> +}
> +
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
>         for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
>                 mlx5_vdpa_update_mr(mvdev, NULL, i);
>
>         prune_iotlb(mvdev->cvq.iotlb);
> +
> +       mlx5_vdpa_show_mr_leaks(mvdev);
>  }
>
>  static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -592,6 +613,8 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev =
*mvdev,
>         if (err)
>                 goto err_iotlb;
>
> +       list_add_tail(&mr->mr_list, &mvdev->mr_list_head);
> +
>         return 0;
>
>  err_iotlb:
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 133cbb66dcfe..778821bab7d9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3722,6 +3722,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         if (err)
>                 goto err_mpfs;
>
> +       INIT_LIST_HEAD(&mvdev->mr_list_head);
> +
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 err =3D mlx5_vdpa_create_dma_mr(mvdev);
>                 if (err)
> --
> 2.42.0
>

