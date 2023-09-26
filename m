Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DCF7AE3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjIZCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjIZCs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A66116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695696453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztxwBiWjNYtfi79s4jLwwVHnBkUaOUXQf9uizWvEnN8=;
        b=bKnk2ofOcd+2bX+OsN9owZ/CuPnN9pRYqcNn43XYGqWKQECgCqQ3PFe3WqmFbi8k9NEJpT
        tr7dIOKZQ4oKZBVERp8SxqktOFrJELWblJZWNdMfs5jciBk8m6b7VSBzJeUuPA/vYQFyos
        ew5Gg5P8lqOtFzhbE+oU5B0lRs9RdNw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-7ZU4E1wRO4-Q-aegUga9sQ-1; Mon, 25 Sep 2023 22:47:31 -0400
X-MC-Unique: 7ZU4E1wRO4-Q-aegUga9sQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5042178944eso6970969e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696450; x=1696301250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztxwBiWjNYtfi79s4jLwwVHnBkUaOUXQf9uizWvEnN8=;
        b=ebo/MnBeiKr+NJqKZT7A7T7moZ8Xq8uI5iAGVA2TEI6GHZbDkB9Gu+NdmsfYzQOP6U
         H9y7Eq6q48QnRMBMO5c1YceMC57uvMc3ba5JnNvZ7VSSwyAsiKBomdw7A2hdpF9UT/Dz
         LQOsKLqqwotuTVmPBtITHlhBBOUwCPF3GmOD/4lkqmwQ8aSi+Ow3VO42OkQSFEoDA+J7
         YqOk1rnkSb4vP3TJKjJn4AMhyGb+hbU8rWM0Pc2Nz8iYixUd8nUCT3VOHs3FEurPaP3B
         NKz4c2tfB/uj4uvI+3R9mGvhuSjLXpc49r7egJEsr+3PsOIiPNFq9UE5fhRMkRGq6pJT
         nsBQ==
X-Gm-Message-State: AOJu0Yyw1DnRoca+31PE4hKHLRZZ/8hqf052dRDJKy9r/wGNT1K8yx9j
        SmOna5XlcaJXAc2L7m5AnxzV1WUb9UqWoG9MSepO32o/J8GLBMrrRMJ56i9Yt81Xfnn+dH40ksi
        GBWK/qufemZ7eemDrpGh/irwfkh+D+wcTMtm1HWLt
X-Received: by 2002:a05:6512:39d6:b0:501:ba04:f352 with SMTP id k22-20020a05651239d600b00501ba04f352mr487397lfu.1.1695696450314;
        Mon, 25 Sep 2023 19:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6CBnbXdSxs5iiUHc9AWqZr29LCRBHXUdN1dRWPuxmiiGV9XdjBZfsAAUTJRVIU06fUsZpKVpseSRShGAY5BU=
X-Received: by 2002:a05:6512:39d6:b0:501:ba04:f352 with SMTP id
 k22-20020a05651239d600b00501ba04f352mr487392lfu.1.1695696449930; Mon, 25 Sep
 2023 19:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-4-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 10:47:19 +0800
Message-ID: <CACGkMEt4zsQdZXUTa2Yv+D2udyHan9h3OkK8mDJR2sjtSSROGQ@mail.gmail.com>
Subject: Re: [RFC 3/7] vhost: Add 3 new uapi to support iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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

On Sun, Sep 24, 2023 at 1:05=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
>
> VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> address space specified by IOAS id.
>
> VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> from the iommufd address space
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vdpa.c       | 191 +++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h |  71 ++++++++++++++
>  2 files changed, 262 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ec32f785dfde..91da012084e9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> +#include <linux/iommufd.h>
>  #include <linux/uuid.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> @@ -25,6 +26,8 @@
>
>  #include "vhost.h"
>
> +MODULE_IMPORT_NS(IOMMUFD);
> +
>  enum {
>         VHOST_VDPA_BACKEND_FEATURES =3D
>         (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
> @@ -69,6 +72,15 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *=
v,
>                                    struct vhost_iotlb *iotlb, u64 start,
>                                    u64 last, u32 asid);
>
> +void vhost_vdpa_lockdep_assert_held(struct vdpa_device *vdpa)
> +{
> +       struct vhost_vdpa *v =3D vdpa_get_drvdata(vdpa);
> +
> +       if (WARN_ON(!v))
> +               return;
> +       lockdep_assert_held(&v->vdev.mutex);
> +}
> +
>  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
>  {
>         struct vhost_vdpa_as *as =3D container_of(iotlb, struct
> @@ -497,6 +509,173 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
>
>         return ops->suspend(vdpa);
>  }
> +static long vhost_vdpa_tmp_set_iommufd(struct vhost_vdpa *v, void __user=
 *argp)
> +{
> +       struct device *dma_dev =3D vdpa_get_dma_dev(v->vdpa);
> +       struct vhost_vdpa_set_iommufd set_iommufd;
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       struct iommufd_ctx *ictx;
> +       unsigned long minsz;
> +       u32 pt_id, dev_id;
> +       struct fd f;
> +       long r =3D 0;
> +       int idx;
> +
> +       minsz =3D offsetofend(struct vhost_vdpa_set_iommufd, ioas_id);
> +       if (copy_from_user(&set_iommufd, argp, minsz))
> +               return -EFAULT;
> +
> +       if (set_iommufd.group_id >=3D v->nvqs)
> +               return -ENOBUFS;

Needs to be v->ngroups but as replied below, but I think it should be asid.

> +
> +       idx =3D array_index_nospec(set_iommufd.group_id, v->nvqs);
> +
> +       /* Unset IOMMUFD */
> +       if (set_iommufd.iommufd < 0) {
> +               if (!test_bit(idx, vdpa->vq_bitmap))
> +                       return -EINVAL;
> +
> +               if (!vdpa->iommufd_ictx || !vdpa->iommufd_device)
> +                       return -EINVAL;
> +               if (atomic_read(&vdpa->iommufd_users)) {
> +                       atomic_dec(&vdpa->iommufd_users);
> +                       return 0;
> +               }
> +               vdpa_iommufd_unbind(v->vdpa);
> +               vdpa->iommufd_device =3D NULL;
> +               vdpa->iommufd_ictx =3D NULL;
> +               clear_bit(idx, vdpa->vq_bitmap);
> +               return iommu_attach_device(v->domain, dma_dev);
> +       }
> +       /* First opened virtqueue of this vdpa device */
> +
> +       if (!vdpa->vq_bitmap) {
> +               vdpa->vq_bitmap =3D bitmap_alloc(v->nvqs, GFP_KERNEL);
> +       }
> +       ///if (test_bit(idx, vdpa->vq_bitmap))
> +       //return -EBUSY;
> +
> +       /* For same device but different groups, ++refcount only */
> +       if (vdpa->iommufd_device)
> +               goto out_inc;
> +
> +       r =3D -EBADF;
> +       f =3D fdget(set_iommufd.iommufd);
> +       if (!f.file)
> +               goto out_bitmap_free;
> +
> +       r =3D -EINVAL;
> +       ictx =3D iommufd_ctx_from_file(f.file);
> +       if (IS_ERR(ictx))
> +               goto out_fdput;
> +
> +       if (v->domain)
> +               iommu_detach_device(v->domain, dma_dev);
> +
> +#if 0
> +       iommu_group_add_device(iommu_group_alloc(), &vdpa->dev);
> +#endif
> +       pt_id =3D set_iommufd.ioas_id;
> +       r =3D vdpa_iommufd_bind(vdpa, ictx, &pt_id, &dev_id);
> +       if (r)
> +               goto out_reattach;
> +
> +       set_iommufd.out_dev_id =3D dev_id;
> +       set_iommufd.out_hwpt_id =3D pt_id;
> +       r =3D copy_to_user(argp + minsz, &set_iommufd.out_dev_id,
> +                        sizeof(set_iommufd.out_dev_id) +
> +                                sizeof(set_iommufd.out_hwpt_id)) ?
> +                   -EFAULT :
> +                   0;
> +       if (r)
> +               goto out_device_unbind;
> +       printk(KERN_ERR "[%s] %d called %p\n", __func__, __LINE__,
> +              vdpa->iommufd_ictx);
> +
> +       vdpa->iommufd_ictx =3D ictx;
> +
> +out_inc:
> +       atomic_inc(&vdpa->iommufd_users);
> +       set_bit(idx, vdpa->vq_bitmap);
> +
> +       goto out_fdput;
> +
> +out_device_unbind:
> +
> +       vdpa_iommufd_unbind(vdpa);
> +out_reattach:
> +
> +       iommu_attach_device(v->domain, dma_dev);
> +       iommufd_ctx_put(ictx);
> +out_fdput:
> +       fdput(f);
> +out_bitmap_free:
> +       bitmap_free(vdpa->vq_bitmap);
> +       return r;
> +}
> +int vdpa_ioctl_device_attach(struct vhost_vdpa *v, void __user *arg)
> +{
> +       struct vdpa_device_attach_iommufd_as attach;
> +       unsigned long minsz;
> +       int ret;
> +
> +       minsz =3D offsetofend(struct vdpa_device_attach_iommufd_as, ioas_=
id);
> +
> +       if (copy_from_user(&attach, (void __user *)arg, minsz))
> +               return -EFAULT;
> +
> +       if (attach.argsz < minsz || attach.flags ||
> +           attach.ioas_id =3D=3D IOMMUFD_INVALID_ID)
> +               return -EINVAL;
> +
> +       if (!v->vdpa->config->bind_iommufd)
> +               return -ENODEV;
> +
> +       if (!v->vdpa->iommufd_ictx) {
> +               ret =3D -EINVAL;
> +               return ret;
> +       }
> +
> +       ret =3D v->vdpa->config->attach_ioas(v->vdpa, &attach.ioas_id);
> +
> +       if (ret)
> +               return ret;
> +
> +       ret =3D copy_to_user(
> +                     (void __user *)arg +
> +                             offsetofend(struct vdpa_device_attach_iommu=
fd_as,
> +                                         flags),
> +                     &attach.ioas_id, sizeof(attach.ioas_id)) ?
> +                     -EFAULT :
> +                     0;
> +
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +int vdpa_ioctl_device_detach(struct vhost_vdpa *v, void __user *arg)
> +{
> +       struct vdpa_device_detach_iommufd_as detach;
> +       unsigned long minsz;
> +
> +       minsz =3D offsetofend(struct vdpa_device_detach_iommufd_as, flags=
);
> +
> +       if (copy_from_user(&detach, (void __user *)arg, minsz))
> +               return -EFAULT;
> +
> +       if (detach.argsz < minsz || detach.flags)
> +               return -EINVAL;
> +
> +       if (!v->vdpa->config->bind_iommufd)
> +               return -ENODEV;
> +
> +       if (v->vdpa->iommufd_ictx) {
> +               return -EINVAL;
> +       }
> +       return v->vdpa->config->detach_ioas(v->vdpa);
> +}
>
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>                                    void __user *argp)
> @@ -655,6 +834,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *f=
ilep,
>         case VHOST_SET_LOG_FD:
>                 r =3D -ENOIOCTLCMD;
>                 break;
> +       case VHOST_VDPA_SET_IOMMU_FD:
> +
> +               r =3D vhost_vdpa_tmp_set_iommufd(v, argp);
> +               break;
> +       case VDPA_DEVICE_ATTACH_IOMMUFD_AS:
> +               r =3D vdpa_ioctl_device_attach(v, (void __user *)arg);
> +               break;
> +
> +       case VDPA_DEVICE_DETACH_IOMMUFD_AS:
> +               r =3D vdpa_ioctl_device_detach(v, (void __user *)arg);
> +               break;
> +
>         case VHOST_VDPA_SET_CONFIG_CALL:
>                 r =3D vhost_vdpa_set_config_call(v, argp);
>                 break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index f9f115a7c75b..cdda0c1860d8 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -45,6 +45,7 @@
>  #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
>  /* Specify an eventfd file descriptor to signal on log write. */
>  #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
> +/* Specify an iommufd file descriptor for IO address translation */
>
>  /* Ring setup. */
>  /* Set number of descriptors in ring. This parameter can not
> @@ -180,4 +181,74 @@
>   */
>  #define VHOST_VDPA_SUSPEND             _IO(VHOST_VIRTIO, 0x7D)
>
> +/* vhost vdpa set iommufd
> + * Input parameters:
> + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> + * @group_id: identifier of the group that a virtqueue belongs to
> + * @ioas_id: IOAS identifier returned from ioctl(IOMMU_IOAS_ALLOC)
> + * Output parameters:
> + * @out_dev_id: device identifier
> + * @out_hwpt_id: hardware IO pagetable identifier
> + */
> +struct vhost_vdpa_set_iommufd {
> +       __s32 iommufd;
> +       __u32 group_id;

This needs to be ASID of a vdpa device, as the current address space
could be shared among various groups. And the device do translation
based on:

virtqueue -> group -> AS -> IOAS of iommufd

Thanks



> +       __u32 ioas_id;
> +       __u32 out_dev_id;
> +       __u32 out_hwpt_id;
> +};
> +
> +#define VHOST_VDPA_SET_IOMMU_FD \
> +       _IOW(VHOST_VIRTIO, 0x7e, struct vhost_vdpa_set_iommufd)
> +
> +/*
> + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> + *
> + * Attach a vdpa device to an iommufd address space specified by IOAS
> + * id.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> + *
> + * @argsz:     user filled size of this data.
> + * @flags:     must be 0.
> + * @ioas_id:   Input the target id which can represent an ioas
> + *             allocated via iommufd subsystem.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_attach_iommufd_as {
> +       __u32 argsz;
> +       __u32 flags;
> +       __u32 ioas_id;
> +};
> +
> +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> +       _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> +
> +/*
> + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> + *
> + * Detach a vdpa device from the iommufd address space it has been
> + * attached to. After it, device should be in a blocking DMA state.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * @argsz:     user filled size of this data.
> + * @flags:     must be 0.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_detach_iommufd_as {
> +       __u32 argsz;
> +       __u32 flags;
> +};
> +
> +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as)
> +
>  #endif
> --
> 2.34.3
>

