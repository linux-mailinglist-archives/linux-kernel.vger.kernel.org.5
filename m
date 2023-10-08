Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E987BCC5A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 07:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjJHF3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 01:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjJHF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 01:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004BCF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 22:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696742908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpwgwXaEWYaaFsSNTMyBQD+39EpH2AOMJtj5zGk8lYE=;
        b=UuLGoTaaPNIrzb9jC7kAKsJfamWK0ZhOqkCjw6oijzsL9oYDKF7N/nO/Gjg2ZsUo98muA8
        u0vYRwhc4NB80pB/xna3FEhfTFQ/ayck0ervP+xVSFuiYEVoql0u/0rE0N90qibKwhtYWv
        s7qIo6l2FWShSycLkX8Iepqd+WIjWtM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-73IRhNdjNHyyhlUD6vvGBQ-1; Sun, 08 Oct 2023 01:28:26 -0400
X-MC-Unique: 73IRhNdjNHyyhlUD6vvGBQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5039413f4f9so286659e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 22:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742904; x=1697347704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpwgwXaEWYaaFsSNTMyBQD+39EpH2AOMJtj5zGk8lYE=;
        b=l758IRG8ob4ZqNLEbUwCa7o407JT5hbaWEwgPo7JLh6UzHGWAP8Rl2T3owI9SlfFAl
         pwO9wB1wTWycvP3gzBkGZmXpmL6DFzBKnKM/UN9YMpXuVThJU1ld8B8j0xczPx2aivvx
         vF8RfEvQmOQ4yuCGXpGL6XblaVmDSrk5Zt4Gu0bk92F+UDrnjLsQwW0to0azxF8BcOQz
         qouK/UAachfyVCI0hdnca2WoFbmMtrM+3I5xto8APL6K25k1MaHgCaqn2ZmIsIkHLONt
         ejdle2JJ+GnYOcg4VDhL38hGWhAlufXj7T48GGjWj3FI0AjptNIB32ckW4IRkeYHkQFP
         laFg==
X-Gm-Message-State: AOJu0YzL+0Dd8rdcu3dT2FEUxfsr5VXTQlDnpRrxgO+3wNOANJzNun6P
        lbzL4XLVDXY/iP7FyJ9kFNgsUiFuIg/c+5dOZ8e8uvVLJoXYPuZBre3EZtFoMt6LK3ajnk4+M6q
        QnHPBC3QT3J9bTl5zzfLCWUFkp7+1Zho+Z16dHJkcZp8JEKnJZIY=
X-Received: by 2002:a05:6512:ac8:b0:503:1aae:eca0 with SMTP id n8-20020a0565120ac800b005031aaeeca0mr13205996lfu.44.1696742904213;
        Sat, 07 Oct 2023 22:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkfgKx+SsS4nJgqunmdWhqRU27F8n/DJo7Eoi3C9DaLJia2YytDK0igSUNaJhTR/6Bwkn5zUkOK1fexckvwI=
X-Received: by 2002:a05:6512:ac8:b0:503:1aae:eca0 with SMTP id
 n8-20020a0565120ac800b005031aaeeca0mr13205990lfu.44.1696742904022; Sat, 07
 Oct 2023 22:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <2023100643-tricolor-citizen-6c2d@gregkh>
In-Reply-To: <2023100643-tricolor-citizen-6c2d@gregkh>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 8 Oct 2023 13:28:13 +0800
Message-ID: <CACGkMEt3Tneppu3qbKXCDLS-1Hw5bmspOdE29dPijwwkW5iKJw@mail.gmail.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
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

On Fri, Oct 6, 2023 at 10:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index df7869537ef1..0ddd4b8abecb 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -134,7 +134,6 @@ static DEFINE_MUTEX(vduse_lock);
>  static DEFINE_IDR(vduse_idr);
>
>  static dev_t vduse_major;
> -static struct class *vduse_class;
>  static struct cdev vduse_ctrl_cdev;
>  static struct cdev vduse_cdev;
>  static struct workqueue_struct *vduse_irq_wq;
> @@ -1528,6 +1527,16 @@ static const struct kobj_type vq_type =3D {
>         .default_groups =3D vq_groups,
>  };
>
> +static char *vduse_devnode(const struct device *dev, umode_t *mode)
> +{
> +       return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> +}
> +
> +static const struct class vduse_class =3D {
> +       .name =3D "vduse",
> +       .devnode =3D vduse_devnode,
> +};
> +
>  static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>  {
>         int i;
> @@ -1638,7 +1647,7 @@ static int vduse_destroy_dev(char *name)
>         mutex_unlock(&dev->lock);
>
>         vduse_dev_reset(dev);
> -       device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor)=
);
> +       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor=
));
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
>         vduse_dev_deinit_vqs(dev);
> @@ -1805,7 +1814,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>
>         dev->minor =3D ret;
>         dev->msg_timeout =3D VDUSE_MSG_DEFAULT_TIMEOUT;
> -       dev->dev =3D device_create_with_groups(vduse_class, NULL,
> +       dev->dev =3D device_create_with_groups(&vduse_class, NULL,
>                                 MKDEV(MAJOR(vduse_major), dev->minor),
>                                 dev, vduse_dev_groups, "%s", config->name=
);
>         if (IS_ERR(dev->dev)) {
> @@ -1821,7 +1830,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>
>         return 0;
>  err_vqs:
> -       device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor)=
);
> +       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor=
));
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> @@ -1934,11 +1943,6 @@ static const struct file_operations vduse_ctrl_fop=
s =3D {
>         .llseek         =3D noop_llseek,
>  };
>
> -static char *vduse_devnode(const struct device *dev, umode_t *mode)
> -{
> -       return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> -}
> -
>  struct vduse_mgmt_dev {
>         struct vdpa_mgmt_dev mgmt_dev;
>         struct device dev;
> @@ -2082,11 +2086,9 @@ static int vduse_init(void)
>         int ret;
>         struct device *dev;
>
> -       vduse_class =3D class_create("vduse");
> -       if (IS_ERR(vduse_class))
> -               return PTR_ERR(vduse_class);
> -
> -       vduse_class->devnode =3D vduse_devnode;
> +       ret =3D class_register(&vduse_class);
> +       if (ret)
> +               return ret;
>
>         ret =3D alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vdus=
e");
>         if (ret)
> @@ -2099,7 +2101,7 @@ static int vduse_init(void)
>         if (ret)
>                 goto err_ctrl_cdev;
>
> -       dev =3D device_create(vduse_class, NULL, vduse_major, NULL, "cont=
rol");
> +       dev =3D device_create(&vduse_class, NULL, vduse_major, NULL, "con=
trol");
>         if (IS_ERR(dev)) {
>                 ret =3D PTR_ERR(dev);
>                 goto err_device;
> @@ -2141,13 +2143,13 @@ static int vduse_init(void)
>  err_wq:
>         cdev_del(&vduse_cdev);
>  err_cdev:
> -       device_destroy(vduse_class, vduse_major);
> +       device_destroy(&vduse_class, vduse_major);
>  err_device:
>         cdev_del(&vduse_ctrl_cdev);
>  err_ctrl_cdev:
>         unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
>  err_chardev_region:
> -       class_destroy(vduse_class);
> +       class_unregister(&vduse_class);
>         return ret;
>  }
>  module_init(vduse_init);
> @@ -2159,10 +2161,10 @@ static void vduse_exit(void)
>         destroy_workqueue(vduse_irq_bound_wq);
>         destroy_workqueue(vduse_irq_wq);
>         cdev_del(&vduse_cdev);
> -       device_destroy(vduse_class, vduse_major);
> +       device_destroy(&vduse_class, vduse_major);
>         cdev_del(&vduse_ctrl_cdev);
>         unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
> -       class_destroy(vduse_class);
> +       class_unregister(&vduse_class);
>  }
>  module_exit(vduse_exit);
>
> --
> 2.42.0
>

