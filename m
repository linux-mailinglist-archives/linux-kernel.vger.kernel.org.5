Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C975B7C51E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjJKLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJKLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6619A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697023344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWsXSZHfRpUt5cI/8UbIGzMTuwjoV+7EBZN+hsLNNYQ=;
        b=Z19dKyp0WcjKXMI+FvEdZ3MV4UIkvMq5CstkhSF4NUwugWvNhNjLi+hwySXb0SO0vRnvaC
        SHBsHQhQW4btHKg/CZTmi5b8Pr2JPJ+OkyZLqzuOeSSknJ5woa3OZlHSSn0iZblszxwFRT
        HdAu02kON0tw6aE4kaQB1rYyWIF34VE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-D0s17JEHPN25l5aRrEpqTQ-1; Wed, 11 Oct 2023 07:22:23 -0400
X-MC-Unique: D0s17JEHPN25l5aRrEpqTQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7ed6903a6so2858837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023342; x=1697628142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWsXSZHfRpUt5cI/8UbIGzMTuwjoV+7EBZN+hsLNNYQ=;
        b=l8IQLV+kUo3zKxdxkJ6Cqed1HR0SsXMxffA6tzo46/D3gYSJBjjeSaxWVEDBUc/Mia
         R1PWmjpF9oHaM0qYwLF6+eGIpBLziP/5t2aerEu0T9dDc+G+F2GZQZaTYy9RxcFXSZmn
         Mzap9NEvRbTlm8N/B0tdZ0S/auUshCmr4zEbu7OKZ340NyN/Lxu19l9hxKcThYOUOjnL
         aeFE35AYgtMd5j5u9FrUAreA49v7JrguW0JNmqyl/tTzAtO1NHIZsvu/Ae3aUUIejRWS
         crAelvkEMVsMB9Y3dUk4oQKW4S+qXPT08CvlwNn/blsJDBkPfvaGop5t2aZvkI8Ll8Fb
         2AVg==
X-Gm-Message-State: AOJu0YxRRp26ZA5+LZMHeens+V269LA74AEZMtFnHnmAu6n/EvrmD4Lb
        vS5nWORmQx3wY+dwn64BLZmuVHe815FBlEGExybVO5Qky2zZE30kyBODqa74ZDFoWwgnIfVrqHq
        CtlyVBC0tYW4gVW7mAbowdwfkrTKgDVGXSH/ggzmY
X-Received: by 2002:a0d:cec4:0:b0:594:e439:d429 with SMTP id q187-20020a0dcec4000000b00594e439d429mr21914233ywd.37.1697023342635;
        Wed, 11 Oct 2023 04:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3M1nICE8wYPBMPJsblxDpQjYRWeF53PondB9FqjwBgXfXipYRI85u4LVQxvBG8zcyAy3/aITLmaQATCnxu/k=
X-Received: by 2002:a0d:cec4:0:b0:594:e439:d429 with SMTP id
 q187-20020a0dcec4000000b00594e439d429mr21914216ywd.37.1697023342387; Wed, 11
 Oct 2023 04:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com> <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 11 Oct 2023 13:21:46 +0200
Message-ID: <CAJaqyWe=RwotkcNKFuStvX=HxQh6sdtfsH23jhf994eXi3-2Og@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:05=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
> Devices with on-chip IOMMU or vendor specific IOTLB implementation
> may need to restore iotlb mapping to the initial or default state
> using the .reset_map op, as it's desirable for some parent devices
> to solely manipulate mappings by its own, independent of virtio device
> state. For instance, device reset does not cause mapping go away on
> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> is going away, give them a chance to reset iotlb back to the initial
> state in vhost_vdpa_cleanup().
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 851535f..a3f8160 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_a=
s(struct vhost_vdpa *v,
>         return vhost_vdpa_alloc_as(v, asid);
>  }
>
> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +
> +       if (ops->reset_map)
> +               ops->reset_map(vdpa, asid);
> +}
> +
>  static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>  {
>         struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v=
, u32 asid)
>
>         hlist_del(&as->hash_link);
>         vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);

Now I'm wondering, does this call to vhost_vdpa_iotlb_unmap sets a
different map (via .set_map) per element of the vhost_iotlb_itree? Not
a big deal since we're in the cleanup path, but it could be a nice
optimization on top as we're going to reset the map of the asid
anyway.

> +       /*
> +        * Devices with vendor specific IOMMU may need to restore
> +        * iotlb to the initial or default state which is not done
> +        * through device reset, as the IOTLB mapping manipulation
> +        * could be decoupled from the virtio device life cycle.
> +        */
> +       vhost_vdpa_reset_map(v, asid);
>         kfree(as);
>
>         return 0;
> --
> 1.8.3.1
>

