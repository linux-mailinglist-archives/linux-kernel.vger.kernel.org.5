Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C437E1B28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjKFH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKFH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAE5123
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699255546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnPjZZzSQXWY9ANNSnV7yHw6hBbYFuGXz/mnxSTQkCQ=;
        b=UqVoVO5Zv/o0yYIDctr0hnOWwDP4lufiHinrAs/zd8daoZj8jJkvB5rkxJnWqz5p8z90gy
        k2+FnjjjW8eBrI7ghjCrFtmfA1jTlR37U5FCBKE7R5bdVfsibheIFpRGVEvA0NT1vBMnIs
        IMvql2x2akgeLDst86MdxvB41jhCqX4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-REWeUbp0Ox24it6pVWG0Kg-1; Mon, 06 Nov 2023 02:25:45 -0500
X-MC-Unique: REWeUbp0Ox24it6pVWG0Kg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507d208be33so4178287e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255544; x=1699860344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnPjZZzSQXWY9ANNSnV7yHw6hBbYFuGXz/mnxSTQkCQ=;
        b=Y7VUbK4vYI4Hchkz/PoyTFYi5EqKQLIB7QKJ0DFzoyPmJtUEjt8jAh2kthSNywKlTD
         VfIG7fGz3K00WVMWvFvcNqYCse58BqGqwNldc0PXG5VbDnxK7g8mXB2y6DJsAw4kslAp
         /CwHzV5R0U9oJvjpEggd6QQ8xzIvEbFzCzIBxJOXUxNQcqk+M8NugSWlG6Evn/WB/0i6
         gmI56xLMEWKD7cm3zpcjR9B1iUidjpFAd2n6DK2rNh7brItFNAulhB5dai3yXjj8VV85
         /YWb0N4TCo735kQSSW0D+1jknz6hTxyaPFczdMsDidx69o77pUsG2/gQZoYmZtDTQYMZ
         pmlw==
X-Gm-Message-State: AOJu0Yy1Ux88euYOvlYoY2fycDQTf+ZPK5zesUO/fVVwG0+F9wSZIYHA
        rUJXyTH/Z8JZ8TyuoMm7QBK9yUdyTlBzOhfTiFtoCiveZzYRdxHtvSev4OV/O30n1dfI2K8N6PK
        Kk+WFxhOa2u7rVLhjFPKIet7rOxUQ/UiBO9+73ZvI
X-Received: by 2002:ac2:57c4:0:b0:4fd:c715:5667 with SMTP id k4-20020ac257c4000000b004fdc7155667mr18797011lfo.20.1699255543989;
        Sun, 05 Nov 2023 23:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGupcEpyFhjhM0FIOwp9UBm5oZuh57MUCs1hrDYjzMwG3NN6dklFvm80eN8mYejg9VfW1D3EymTIZw6vWamomw=
X-Received: by 2002:ac2:57c4:0:b0:4fd:c715:5667 with SMTP id
 k4-20020ac257c4000000b004fdc7155667mr18797001lfo.20.1699255543700; Sun, 05
 Nov 2023 23:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-8-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-8-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Nov 2023 15:25:32 +0800
Message-ID: <CACGkMEuEpQinKo4zMVJ_MohPH8PkG9vx0MrhX4B_9d4UKkoV-w@mail.gmail.com>
Subject: Re: [RFC v1 7/8] vp_vdpa::Add support for iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new vdpa_config_ops function to support iommufd
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..dd2c372d36a6 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -460,6 +460,10 @@ static const struct vdpa_config_ops vp_vdpa_ops =3D =
{
>         .set_config     =3D vp_vdpa_set_config,
>         .set_config_cb  =3D vp_vdpa_set_config_cb,
>         .get_vq_irq     =3D vp_vdpa_get_vq_irq,
> +       .bind_iommufd =3D vdpa_iommufd_physical_bind,
> +       .unbind_iommufd =3D vdpa_iommufd_physical_unbind,
> +       .attach_ioas =3D vdpa_iommufd_physical_attach_ioas,
> +       .detach_ioas =3D vdpa_iommufd_physical_detach_ioas,

For the device that depends on the platform IOMMU, any reason we still
bother a per device config ops here just as an indirection?

Thanks

>  };
>
>  static void vp_vdpa_free_irq_vectors(void *data)
> --
> 2.34.3
>

