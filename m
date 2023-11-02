Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF87DED18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjKBHLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBHLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179B112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698909048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bK15Xlf6x1r+5SfUL3gCTdGcT9jq4iV8XquyHF6fFBo=;
        b=Ta1hgaHqxX1j4fc2jPeGvKQWbGTPR48DyxChY3mxw9Y2X2ftU6gwap6Fp8tVU/LWTHtIv3
        mUpax8fhEgxv6oZut/pXgXNRwVEFf8khniOImzAoCv8wUPK7p6HYF+vK/mvujOwkV8PFs6
        tLgXCgXp7gIXWzPuxeciK3MJXLOBcfE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-lfQkBLVsPtOYjvRLgxmGvw-1; Thu, 02 Nov 2023 03:10:47 -0400
X-MC-Unique: lfQkBLVsPtOYjvRLgxmGvw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7b9e83b70so5252577b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909046; x=1699513846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bK15Xlf6x1r+5SfUL3gCTdGcT9jq4iV8XquyHF6fFBo=;
        b=DLjG87Yj3cqHEJ0uOtDB5a98gIHjKiFXvwCAbXGTvYAzihoPhl59igxb+FzCB5ZQr2
         blX27+U1shSDiWEp+Bmnn1ehk2DoSaIgN5s9t8e7mGpafBYulw9FfgdcrtZTEvC90zIf
         KLge+4jTG3eyeoSqR3HPhAXY4DkbQ/cj6owaL5O97OkpaulJq4i2b7fxoUujVy5948pW
         4kotV/qXe/jeqtQpHXX1e+UDY2sTuXSoGunmk0Ycfozh8qoCrYPojyAgiohmsZRQ1QSq
         LNZATHJkInsMQq44b49auWVdMSu11M0Zkv2/iNLH7bOkTMyKXvcP6hfZEQ81ZcPs73lq
         9Ojw==
X-Gm-Message-State: AOJu0YwcABQSLZKGuluONp3Oj+nk0g/+YBXgnDiZ6Jo6HYTtOoLsx/Uv
        YtdkFX00dUzpY4avVDrDeok52eamIt9UTi/zcDBGmjetvYNlK7tBx9Tj2RMfRVFqh9CID1I9eod
        1oft7el8y79N8rQVGHnPcKh966I+os8XUN/R5xu8X
X-Received: by 2002:a81:4c51:0:b0:5b1:f0b8:45f6 with SMTP id z78-20020a814c51000000b005b1f0b845f6mr3903851ywa.3.1698909046730;
        Thu, 02 Nov 2023 00:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDmV4Oz8wLJqoiGGrk5GBjroG7adnupt9SKOGegNodVU14hLergfOIwr4oWFc30FEKnjUYoYbQZzbS4JPEYFE=
X-Received: by 2002:a81:4c51:0:b0:5b1:f0b8:45f6 with SMTP id
 z78-20020a814c51000000b005b1f0b845f6mr3903843ywa.3.1698909046491; Thu, 02 Nov
 2023 00:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <1698854083-136016-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1698854083-136016-1-git-send-email-steven.sistare@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 2 Nov 2023 08:10:10 +0100
Message-ID: <CAJaqyWfpgQcYbvRgYkvVAq5SiFVVJdWF9PLfOnvd7ipGcjYghA@mail.gmail.com>
Subject: Re: [PATCH V2] vdpa/mlx5: preserve CVQ vringh index
To:     Steve Sistare <steven.sistare@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 4:55=E2=80=AFPM Steve Sistare <steven.sistare@oracle=
.com> wrote:
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

Fixes tag missing?

Apart from that,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 946488b8989f..ca972af3c89a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *=
mvdev)
>         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
>         int err =3D 0;
>
> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> +               u16 idx =3D cvq->vring.last_avail_idx;
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
> +                       cvq->vring.last_avail_idx =3D cvq->vring.last_use=
d_idx =3D idx;
> +       }
>         return err;
>  }
>
> --
> 2.39.3
>

