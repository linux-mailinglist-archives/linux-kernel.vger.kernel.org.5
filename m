Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226837A1692
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjIOGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjIOGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EAE1271B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694760831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yo/ltbu6gyQyMT5IUFnw0353h8EE843EVbYpVcgDCY=;
        b=fOfXgsebTK24AKu48VUFmPQaBhoEL2/paJzt4YQFC4rePPYNqgzrpQH5YhiiF7ifXDhUg5
        ahuLpicKzwKKgvDrQEazRGc9ZlcNIL6ZjXaYn48yT9PY3Qn221/QvYIMuZvNpoE8bJV14W
        Mjyx7NsQ7KCcHXbhPkq1qnkibETjLX4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-33B9WMTWPjmwKj1D5zy3Lg-1; Fri, 15 Sep 2023 02:53:48 -0400
X-MC-Unique: 33B9WMTWPjmwKj1D5zy3Lg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-500c67585acso2096529e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760827; x=1695365627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yo/ltbu6gyQyMT5IUFnw0353h8EE843EVbYpVcgDCY=;
        b=TY/WHiKu8KQV/Lb7F1IhWveeAKF+UtKlwyZcNUqAzlMeKBB0o+XEX8k48GDQ8dxw0z
         wfptYrnQQn2aqg8DDWzVQ+xrhVZn6nahik/PGYUcO+iEKYyHdUNsuxLPgH3EwJIQdtT2
         ORj7mWeGtn89DFEzpgYEEv8BAG47SLtgTMKcy7Rx56ypyy5ggv3+yZcL+azeeb/7e62b
         trOxaD6ZdPkHjsgMcJujHgx+39IKdgoIU95Nv8L9lGuT8xutwrSre0hJvx5fu9wY/D3n
         CwC+x1VGVgRk/AeEML5KuJOD5sONRDAaqjGPBfh7iBR0gdmlfxTyiBJa0diBuuAFDj2O
         RWaA==
X-Gm-Message-State: AOJu0YwA+z+/0jGnoO7dMgwTrq9srbTRD3Kqva+NCWzEes9HrsE+kYwL
        AwV2pvMNRNLxCAd+7Z5vC8GQeaE8IYskOQFCQgph+080Os3AUlE/6Awg60w/RGYTubx7BsHt5Ev
        gw/ASqIKqDU0Pie2SUQ+KZ9RxJKPvs28qsJQK/aoq
X-Received: by 2002:a05:6512:2118:b0:4fb:bef0:948e with SMTP id q24-20020a056512211800b004fbbef0948emr756377lfr.5.1694760826848;
        Thu, 14 Sep 2023 23:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUH4I6aV5QreN6mk31ZBMA6OFB1mVM2TE0phoCc5O/m60tRNYb9K8GAZYxOqPql8v8ND7yp1NfW/D+aXFo530=
X-Received: by 2002:a05:6512:2118:b0:4fb:bef0:948e with SMTP id
 q24-20020a056512211800b004fbbef0948emr756367lfr.5.1694760826555; Thu, 14 Sep
 2023 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230829174014.928189-2-dtatulea@nvidia.com>
In-Reply-To: <20230829174014.928189-2-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 15 Sep 2023 14:53:35 +0800
Message-ID: <CACGkMEuQHsWi=FkKyRQk_tg8-gBjLfr9K48LzK9t9DKbaHga5w@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix double release of debugfs entry
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Gal Pressman <gal@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 30, 2023 at 1:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The error path in setup_driver deletes the debugfs entry but doesn't
> clear the pointer. During .dev_del the invalid pointer will be released
> again causing a crash.
>
> This patch fixes the issue by always clearing the debugfs entry in
> mlx5_vdpa_remove_debugfs. Also, stop removing the debugfs entry in
> .dev_del op: the debugfs entry is already handled within the
> setup_driver/teardown_driver scope.
>
> Fixes: f0417e72add5 ("vdpa/mlx5: Add and remove debugfs in setup/teardown=
 driver")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/debug.c     | 5 +++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++-----
>  drivers/vdpa/mlx5/net/mlx5_vnet.h | 2 +-
>  3 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.=
c
> index 60d6ac68cdc4..9c85162c19fc 100644
> --- a/drivers/vdpa/mlx5/net/debug.c
> +++ b/drivers/vdpa/mlx5/net/debug.c
> @@ -146,7 +146,8 @@ void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev=
)
>                 ndev->rx_dent =3D debugfs_create_dir("rx", ndev->debugfs)=
;
>  }
>
> -void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
> +void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev)
>  {
> -       debugfs_remove_recursive(dbg);
> +       debugfs_remove_recursive(ndev->debugfs);
> +       ndev->debugfs =3D NULL;
>  }
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 37be945a0230..f91c938b4be1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2713,7 +2713,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev=
)
>  err_rqt:
>         teardown_virtqueues(ndev);
>  err_setup:
> -       mlx5_vdpa_remove_debugfs(ndev->debugfs);
> +       mlx5_vdpa_remove_debugfs(ndev);
>  out:
>         return err;
>  }
> @@ -2727,8 +2727,7 @@ static void teardown_driver(struct mlx5_vdpa_net *n=
dev)
>         if (!ndev->setup)
>                 return;
>
> -       mlx5_vdpa_remove_debugfs(ndev->debugfs);
> -       ndev->debugfs =3D NULL;
> +       mlx5_vdpa_remove_debugfs(ndev);
>         teardown_steering(ndev);
>         destroy_tir(ndev);
>         destroy_rqt(ndev);
> @@ -3489,8 +3488,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev =
*v_mdev, struct vdpa_device *
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         struct workqueue_struct *wq;
>
> -       mlx5_vdpa_remove_debugfs(ndev->debugfs);
> -       ndev->debugfs =3D NULL;
>         unregister_link_notifier(ndev);
>         _vdpa_unregister_device(dev);
>         wq =3D mvdev->wq;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/ml=
x5_vnet.h
> index 36c44d9fdd16..60cdbc903037 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -88,7 +88,7 @@ struct macvlan_node {
>  };
>
>  void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> -void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
> +void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
> --
> 2.41.0
>

