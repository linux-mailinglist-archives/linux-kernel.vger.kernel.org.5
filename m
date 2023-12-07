Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F11808378
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjLGIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLGIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F77C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701938785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+2ri2RfE9x9rjPAZOWROVlJM4hMm1UlqOiOyzBUhCU=;
        b=OJd6p/61+jpwBj5ldmAxlHPy6UFensKgYW93V8YP9cq69bH1eaSh9X4HL74W+kcoNXybaI
        bNwNqfcUYqgGMxlJNMMsvwUo6Rd33pJ2nIXDzlG3Kg2wlE47TASPX3xfQWk3nLeEHDDVUo
        nJeUJJ7WoTXuLeysmlWSLppHl+ROp5o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-zr30aDgtOx6XaHUaYAH5aw-1; Thu, 07 Dec 2023 03:46:23 -0500
X-MC-Unique: zr30aDgtOx6XaHUaYAH5aw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2869d112802so1360660a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938781; x=1702543581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+2ri2RfE9x9rjPAZOWROVlJM4hMm1UlqOiOyzBUhCU=;
        b=p2kkgAIssfNy2+43x/BfFueA1DnRt/BQm8Td7lr8Ha80ui0thHlGGKHy0asCZM+hW1
         3RN/5Q6tpIr249Xo9XDQbymUHIwxm54doxASkqkL+YVXd8LymFJ9uyg2ofc9WaGSF6Mx
         EC6CDosgaff/a3UQ2AAin+xpI3Ykho9AAcHNE0wTAoEFq0Zw4Tsii2TJjx4uDKrYzEB8
         4MF90w0iDpY+WUs28Sv2PyjNOUy71Daa4TF80O9C4vDIk+Q1GJC3bRvexvEvvj5c4tS+
         OPvYcNMjekzrUDKTR5YBkaqlHWmd3ilC+47gM/pXpB2bK3EpfKhBGSHl1KsYXojLI5j5
         atqA==
X-Gm-Message-State: AOJu0Yytflrpi495gkds0Y+6q9zjsVVcTNfRDAVG92jMnqZ6yV5U9MGC
        2HANs12MyClPoiWN3BNZwVrDG6nsuOLOAx1c3SCPq4t/dUn9l/FUIR3Xyvfb8aAdRfO7DHogppP
        +J2FdGQUIU9jyypRZFC0MzzxCkbtxYl9DLFGO2/jlWqEFFy3WGHcYqQ==
X-Received: by 2002:a17:90b:1088:b0:286:8daf:85b4 with SMTP id gj8-20020a17090b108800b002868daf85b4mr5195689pjb.2.1701938781077;
        Thu, 07 Dec 2023 00:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGq6roa5MiQyz7/cgRzNSB6XyNbmfMqmvBQIy6FtqU3138tk3mYeNW4OIcdOeeehOv5pKIUb3nKEXx4UKtpCE=
X-Received: by 2002:a17:90b:1088:b0:286:8daf:85b4 with SMTP id
 gj8-20020a17090b108800b002868daf85b4mr5195678pjb.2.1701938780737; Thu, 07 Dec
 2023 00:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20231205083444.3029239-1-lulu@redhat.com> <20231205083444.3029239-5-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-5-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 16:46:09 +0800
Message-ID: <CACGkMEuw890MU8vzqewZv-SaXtci62o1PQNr0grtHV0R7yyoJA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] vduse: Add function to get/free the pages for reconnection
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
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

On Tue, Dec 5, 2023 at 4:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function vduse_alloc_reconnnect_info_mem
> and vduse_alloc_reconnnect_info_mem
> These functions allow vduse to allocate and free memory for reconnection
> information. The amount of memory allocated is (vq_num + 1) pages.
>
> Page 0 is reserved for saving the dev reconnection information, which
> will be maintained by the Userspace App. Pages 1 to vq_num + 1 will be
> used to save the reconnection information for vqs.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 64 ++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index dd074a7b4bc7..52ccde636406 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -41,6 +41,7 @@
>  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +

Unnecessary changes.

>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -57,6 +58,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       unsigned long vdpa_reconnect_vaddr;
>  };
>
>  struct vduse_dev;
> @@ -106,6 +108,7 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       unsigned long vdpa_reconnect_vaddr;
>  };
>
>  struct vduse_dev_msg {
> @@ -1030,6 +1033,57 @@ static int vduse_dev_reg_umem(struct vduse_dev *de=
v,
>         return ret;
>  }
>
> +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +       unsigned long vaddr =3D 0;
> +       struct vduse_virtqueue *vq;
> +
> +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> +               if (i =3D=3D 0) {
> +                       vaddr =3D __get_free_pages(
> +                               GFP_KERNEL | __GFP_ZERO,
> +                               get_order(VDUSE_RECONNCT_MMAP_SIZE));

order 0 should be sufficient here or anything I missed?

> +                       if (vaddr =3D=3D 0)
> +                               return -ENOMEM;
> +                       dev->vdpa_reconnect_vaddr =3D vaddr;
> +               }
> +
> +               /*page 1~ vq_num + 1 save the reconnect info for vq*/
> +               vq =3D &dev->vqs[i];
> +               vaddr =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +                                        get_order(VDUSE_RECONNCT_MMAP_SI=
ZE));
> +               if (vaddr =3D=3D 0)
> +                       return -ENOMEM;
> +
> +               vq->vdpa_reconnect_vaddr =3D vaddr;
> +       }
> +
> +       return 0;
> +}
> +
> +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +       struct vduse_virtqueue *vq;
> +
> +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> +               if (i =3D=3D 0) {
> +                       if (dev->vdpa_reconnect_vaddr)
> +                               free_pages(dev->vdpa_reconnect_vaddr,
> +                                          get_order(VDUSE_RECONNCT_MMAP_=
SIZE));
> +                       dev->vdpa_reconnect_vaddr =3D 0;

Let's use NULL here.

> +               }
> +
> +               vq =3D &dev->vqs[i];
> +
> +               if (vq->vdpa_reconnect_vaddr)
> +                       free_pages(vq->vdpa_reconnect_vaddr,
> +                                  get_order(VDUSE_RECONNCT_MMAP_SIZE));
> +               vq->vdpa_reconnect_vaddr =3D 0;
> +       }
> +
> +       return 0;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -1411,6 +1465,8 @@ static int vduse_destroy_dev(char *name)
>                 mutex_unlock(&dev->lock);
>                 return -EBUSY;
>         }
> +       vduse_free_reconnnect_info_mem(dev);
> +
>         dev->connected =3D true;
>         mutex_unlock(&dev->lock);
>
> @@ -1563,9 +1619,17 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>                 ret =3D PTR_ERR(dev->dev);
>                 goto err_dev;
>         }
> +
> +       ret =3D vduse_alloc_reconnnect_info_mem(dev);
> +       if (ret < 0)
> +               goto err_mem;
> +
>         __module_get(THIS_MODULE);
>
>         return 0;
> +
> +err_mem:
> +       vduse_free_reconnnect_info_mem(dev);
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> --
> 2.34.3
>

Thanks

