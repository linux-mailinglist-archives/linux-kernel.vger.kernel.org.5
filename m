Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD27BC607
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjJGIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:22:20 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC8BF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 01:21:57 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b6a7e0deeso1715267eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696666916; x=1697271716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAz8xXmhRswI9Wfo/147YMtE0iio01uYuGksIL2zD0E=;
        b=ZuqRX91nRAQQljq+JabndT4iMYfy2DwAm39ZFH/d71nSoA4p1SGzHOjorTZrN3AEJD
         VCfJpHFVnVaQ3T5Se1uJG9vXVsFKjk6uec5vR8mhvzuxTD5fWRp+Nm2UER0j3Nupj7V5
         ni/JgPbBLWKvPIGjg0eVnl3iU084cf8pHbbGkw/JMA//3lTxzCJ3ogOzLdf1Tk/YutPr
         +44eAxLtRA9/vwPseir/6pKB4poiwEydrK/JvZ8c0ldAZG9WhPOULzmHc8DF9zn2wZGE
         Gns92ozM5PdqTz0KDJWfznNg1O2Sfc2LbPBPcFEACZWown09WneMEyPDqgpFseyQkDi4
         C/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696666916; x=1697271716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAz8xXmhRswI9Wfo/147YMtE0iio01uYuGksIL2zD0E=;
        b=r6/RjsSdmy4TAWpZo96ddkKauULLhrXL8bwgq8tHAE5JaVQcFd9w1/KOfEmlxZGoNl
         cGuvPzT19fUQ6lYwn3mwpMqAoyNiUNl95uuHyQGbPk/M2G2ESyz68iZt8Jf5I7Oy+uVp
         LZoPeRCs4zOtIsPHN9n0SE+xF52e2WHFHuKyGdhgRif7j8Hhi6jw+OGP6K7wcZ4BKV8C
         XtkwMQMMuEl1yZHvKIIkveRffiqgCVvdp6TAIOTikRApH60N8G9wu1Rc4/pBzSZsnbXw
         IxPhD+YPB95xe73GYPUOH4cm22scxDbFsg7PWD3SfD8cKc8R9utVxjn0C+sPPWsMQMe8
         85yQ==
X-Gm-Message-State: AOJu0YwBwdtUJ2gm7sUG1nju6nPfxUV2qgSwvCmJ9zwYLUw+matg97m7
        BeyByID1DQgKh39xtxhPfevqXVKD/hiPx3bdsd7j
X-Google-Smtp-Source: AGHT+IE7NTXPfDByfkgjF+uRhEZF4rdAVodoIp0h/JlhwCqfXkSUG6t8a5UGL1bEVtTGFHY+lL75JI8pMCWBqc0GOOM=
X-Received: by 2002:a05:6358:52c2:b0:143:1063:d1ed with SMTP id
 z2-20020a05635852c200b001431063d1edmr11416237rwz.26.1696666916406; Sat, 07
 Oct 2023 01:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <2023100643-tricolor-citizen-6c2d@gregkh>
In-Reply-To: <2023100643-tricolor-citizen-6c2d@gregkh>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sat, 7 Oct 2023 16:21:45 +0800
Message-ID: <CACycT3s6BqcsRSL6aVf34_v-SV_owNrUmYuypS5XsUTtkQXm7A@mail.gmail.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

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
