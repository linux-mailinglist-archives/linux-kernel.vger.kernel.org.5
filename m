Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0597B8AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbjJDSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjJDSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BDFB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696444865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IjFNUh3mUlHv41KVyG3Xy1uriUzmxiZ+I+ZHS7UtVA=;
        b=NSOllZrADCHqUpvK6FR9+8mtQusCbDEQQ8txy+itC9VBTstBibEDqXCde22B1macbnEpl1
        j+CBjQgdBg6VHkoVZhm6eXO+5Y1wIq2kjuBee/TFzUaPyp/GvBALpe/c8Jpg+PpX3dPPss
        D1d/4HRW3Qv0R+4xnIlWNPVJmrF9zVk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-dYwhpfTcMh6GpAm5t4hjOA-1; Wed, 04 Oct 2023 14:41:03 -0400
X-MC-Unique: dYwhpfTcMh6GpAm5t4hjOA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-59f4f2b6de8so1375067b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444863; x=1697049663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IjFNUh3mUlHv41KVyG3Xy1uriUzmxiZ+I+ZHS7UtVA=;
        b=K97EQ/U24ITDmMuPjh23DW1vQAJ4ePxCz5835yIeIcIkIL2XNBB/+67E/QA5FDSRv0
         PogFOv62IJ/+rVWwSsUE7oQxAN15HMSso5sxbNZaSE/NqB2NSy3ra7JNpRs2X1sD+97k
         SlsEDJHeKsJYhG0yX26YitEJ7hRPmNFUd0F57BNsBPtyloDE9q0p8iJtjTiUInQfekER
         H5wznQfNKY968E+ixCDuGGPAZ9KJT9NSr7WsdDPhVa0x/X0o1pB6/h3lCsc3/Vbvl9RB
         3tPOZTEjmGUvTJex+XYf/o6PBIe7jJk9cHKOxBnzD3kfMbmnmid+W7KpzLU5uQujYa8k
         +P8A==
X-Gm-Message-State: AOJu0YwLLJN1ZPElnGMkrTwknYqjeGhJV3kQ3u0P0ekgMFqfKDYBcvSE
        cK88MV2HxDscdqLG+ar/82bjzTH/eT2d6gdi580aOn2dSwqxy8i4xxn2Tpyexq5G+o0/cEDKcTB
        huPFq3/vcgoFpn+U1CJ9HQ0O52BsqdWiJQi9WAkJ/
X-Received: by 2002:a81:6cc2:0:b0:59b:5456:a9bb with SMTP id h185-20020a816cc2000000b0059b5456a9bbmr3719491ywc.42.1696444863318;
        Wed, 04 Oct 2023 11:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzoXiu5EdjQIhFYhSE5tQd3LI1HgMF64YGAD0PZN3xpKhVMWhNUeRhtlgp9FYU30qpYuU95iTpzhxB1ojkb00=
X-Received: by 2002:a81:6cc2:0:b0:59b:5456:a9bb with SMTP id
 h185-20020a816cc2000000b0059b5456a9bbmr3719478ywc.42.1696444863002; Wed, 04
 Oct 2023 11:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-9-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-9-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:40:27 +0200
Message-ID: <CAJaqyWdAxy7wOwpR=-jrqKL-BErarC1P+FmiDk_q7fpCLxU7pA@mail.gmail.com>
Subject: Re: [PATCH vhost 07/16] vdpa/mlx5: Take cvq iotlb lock during refresh
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     gal@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The reslock is taken while refresh is called but iommu_lock is more
> specific to this resource. So take the iommu_lock during cvq iotlb
> refresh.
>
> Based on Eugenio's patch [0].
>
> [0] https://lore.kernel.org/lkml/20230112142218.725622-4-eperezma@redhat.=
com/
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index fcb6ae32e9ed..587300e7c18e 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -590,11 +590,19 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev=
 *mvdev,
>                                 struct vhost_iotlb *iotlb,
>                                 unsigned int asid)
>  {
> +       int err;
> +
>         if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
>                 return 0;
>
> +       spin_lock(&mvdev->cvq.iommu_lock);
> +
>         prune_iotlb(mvdev);
> -       return dup_iotlb(mvdev, iotlb);
> +       err =3D dup_iotlb(mvdev, iotlb);
> +
> +       spin_unlock(&mvdev->cvq.iommu_lock);
> +
> +       return err;
>  }
>
>  int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
> --
> 2.41.0
>

