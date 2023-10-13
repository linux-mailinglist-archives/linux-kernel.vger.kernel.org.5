Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80A7C7BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJMCuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97ADDA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697165401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5FuoAUO1vZjh0QIJ7411fph+3bIJecTmF2BuvxTUhQ=;
        b=KQuPwFGhd0Kju8LmDocDtvcKjEsM7C9czs/vVKjHBfT1R5T7DZdx6StZLYDOHvh0RvNIR+
        oUBfLfrBYN6HBr5fh972Lku41K01SBJ7QdnHk6ThaPqL6yOZEDpraT4dJCjmZ91AO2nFwQ
        j07r5NVykk9uxBJTS9vBYDNaMPPbl0Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-YEYwSzVyNdymQFRvh-_bKA-1; Thu, 12 Oct 2023 22:50:00 -0400
X-MC-Unique: YEYwSzVyNdymQFRvh-_bKA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5043353efbdso1491894e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697165398; x=1697770198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5FuoAUO1vZjh0QIJ7411fph+3bIJecTmF2BuvxTUhQ=;
        b=ISBArH9Wc9tp6znK4mcd2hzM0EN2gEVyZVCLVljArPwLZpFbs1I2vsq6jTTUH0/DCE
         TExUHeDY0FKtzLc7754vDANAbBn558VAEI9pAHi9g7uGbus/6TiIAgy+9MEolZUSnS5A
         XUr02pEojUvoGWd9vA2eclqSiPXL18cFx9StbE7HuHyjruPAGa64aR/aQpiy3V3ZeX6y
         s1cJb1HCV8WFjr69tF+cE8v3NWkouaZNVPDaWVlfVNwOZjqMvuDawH43PFH9m1BeYOsT
         8VnpSIuHcFPXJda1uheHPQehk1nAK4G7L+lpewlo3b8kBU4MJ5MMqt4hKcfQEeI+hYSW
         vH8g==
X-Gm-Message-State: AOJu0YwGUssSkaEboPzV9x9ikxETUYW/MRxf4R35h4Y8IiLY2uUirFM8
        gr0ARLes6I3HjaraXOTX9hsxCo+xeHV+BK78jsMhMnlOyY8yh4TE9+JIHRreFBG75sgP0MwyiBp
        hS5fBf2TTYNWBalsvmbWh6K7ndhbWFduhHbnXG2R8
X-Received: by 2002:ac2:4a65:0:b0:500:c2d7:3ab4 with SMTP id q5-20020ac24a65000000b00500c2d73ab4mr19306002lfp.8.1697165398557;
        Thu, 12 Oct 2023 19:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuyWlud6dJUVf6eUQGkFXb/2X27fcpZPK132CMGlMD3rfYyKfUG3wuXKXdFaK8jTXPnDawEZkCiisbaVSKO7A=
X-Received: by 2002:ac2:4a65:0:b0:500:c2d7:3ab4 with SMTP id
 q5-20020ac24a65000000b00500c2d73ab4mr19305996lfp.8.1697165398235; Thu, 12 Oct
 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com> <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 13 Oct 2023 10:49:45 +0800
Message-ID: <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
Subject: Re: [PATCH 1/4] vdpa: introduce .reset_map operation callback
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Device specific IOMMU parent driver who wishes to see mapping to be
> decoupled from virtio or vdpa device life cycle (device reset) can use
> it to restore memory mapping in the device IOMMU to the initial or
> default state. The reset of mapping is done per address space basis.
>
> The reason why a separate .reset_map op is introduced is because this
> allows a simple on-chip IOMMU model without exposing too much device
> implementation details to the upper vdpa layer. The .dma_map/unmap or
> .set_map driver API is meant to be used to manipulate the IOTLB mappings,
> and has been abstracted in a way similar to how a real IOMMU device maps
> or unmaps pages for certain memory ranges. However, apart from this there
> also exists other mapping needs, in which case 1:1 passthrough mapping
> has to be used by other users (read virtio-vdpa). To ease parent/vendor
> driver implementation and to avoid abusing DMA ops in an unexpacted way,
> these on-chip IOMMU devices can start with 1:1 passthrough mapping mode
> initially at the he time of creation. Then the .reset_map op can be used
> to switch iotlb back to this initial state without having to expose a
> complex two-dimensional IOMMU device model.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/linux/vdpa.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index d376309..26ae6ae 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -327,6 +327,15 @@ struct vdpa_map_file {
>   *                             @iova: iova to be unmapped
>   *                             @size: size of the area
>   *                             Returns integer: success (0) or error (< =
0)
> + * @reset_map:                 Reset device memory mapping to the defaul=
t
> + *                             state (optional)

I think we need to mention that this is a must for parents that use set_map=
()?

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> + *                             Needed for devices that are using device
> + *                             specific DMA translation and prefer mappi=
ng
> + *                             to be decoupled from the virtio life cycl=
e,
> + *                             i.e. device .reset op does not reset mapp=
ing
> + *                             @vdev: vdpa device
> + *                             @asid: address space identifier
> + *                             Returns integer: success (0) or error (< =
0)
>   * @get_vq_dma_dev:            Get the dma device for a specific
>   *                             virtqueue (optional)
>   *                             @vdev: vdpa device
> @@ -405,6 +414,7 @@ struct vdpa_config_ops {
>                        u64 iova, u64 size, u64 pa, u32 perm, void *opaque=
);
>         int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>                          u64 iova, u64 size);
> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
>         struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 id=
x);
> --
> 1.8.3.1
>

