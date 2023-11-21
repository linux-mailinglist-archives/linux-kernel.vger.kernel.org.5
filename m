Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242CA7F26A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKUHul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKUHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C752F116
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700552434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btk5PFJVEM3+qQpJy98Ir5AUr2+WhihqrbyG2lX5mHg=;
        b=M2znojdqoTKr3r0b3EY1U7ns53PzYoRl2LlAz4GK+0v22cMUpIgipls2F8GlAEGX59WjBc
        fHQXyOB7Op7ztQGmxaYXode07aD4QlBBE5rGH4rKHQEshbwmJsmBnKJRn0xwp7NGNDIUSx
        2dvN7/khIvkcGgXuzby7KeplLyECvAk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Z3NPIQIvNROhyewsTo932Q-1; Tue, 21 Nov 2023 02:40:30 -0500
X-MC-Unique: Z3NPIQIvNROhyewsTo932Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c6f33ee403so48548591fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552428; x=1701157228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btk5PFJVEM3+qQpJy98Ir5AUr2+WhihqrbyG2lX5mHg=;
        b=P/pU1yqgjOT8OFjTztfGO/rrOmlyl8LsCMcUZYdfBZLObU1rf1TPv6qpCPVR/6LDrl
         8IaudeilhGNPKLxNlgv2PQCS6gKhhRP4ZtLczZUk+p+xT6DMPjIEbUy5NY4G976Kqk7B
         cnseTCiYvhJtXBkhfwZTkUCHrteIP/YL0EP2E65mE62CG8fr8OaLc0CEN4zE1fDepS/+
         igMD40DMrOiz7hAASYD3VBfIe1UkO0eIGbkLZyCARMVXbdJAQQ7yLPaS2S5AN3Y4keQc
         fFFnXHWma7i4iLn/UvaF4GhTzbNi2fjlXHEIiJzIRtqwDeyld3UkbmzvXm2WEtoVHN+K
         MIRw==
X-Gm-Message-State: AOJu0YwHcu2K/FndLaboOVhUTdNYuZ5B+tShhb5n2i+iqbYa9/InVCgD
        Z+pGz4TIbPX/UYBHRqexagtkNkz3MEsNfMX8c19apmBHHNYMXd5s6sJhMOlPl4SiX1/gDBaWyyU
        JvV7OfuEa7WM7wZtixq/2RP998kWMBNmTpvZ8edti
X-Received: by 2002:a19:7519:0:b0:503:1913:ed8e with SMTP id y25-20020a197519000000b005031913ed8emr6576763lfe.61.1700552428778;
        Mon, 20 Nov 2023 23:40:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5quDDF1etAkYKHklDT6zvb0Svk8HaZiN9UE0iQ/R2AzTEf4symv9gLPlpcMPRS0tNeNfz9EFNUyYy60x5xwY=
X-Received: by 2002:a19:7519:0:b0:503:1913:ed8e with SMTP id
 y25-20020a197519000000b005031913ed8emr6576752lfe.61.1700552428474; Mon, 20
 Nov 2023 23:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-3-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-3-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 21 Nov 2023 15:40:16 +0800
Message-ID: <CACGkMEsSAvUpkxCutX69fPS5B5ChEUP+KutP1OtgcWE6Job61g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vduse: Add file operation for mmap
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the operation for mmap, The user space APP will
> use this function to map the pages to userspace
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 79 ++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 6209e2f00278..ccb30e98bab5 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1376,6 +1376,83 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
int minor)
>         return dev;
>  }
>
> +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> +{
> +       struct vduse_dev *dev =3D vmf->vma->vm_file->private_data;
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       u16 index =3D vma->vm_pgoff;
> +       struct vduse_virtqueue *vq;
> +       struct vdpa_reconnect_info *info;
> +
> +       /* index 0  page reserved for vduse status*/
> +       if (index =3D=3D 0) {
> +               info =3D &dev->reconnect_info;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> +                           PFN_DOWN(virt_to_phys((void *)info->vaddr)),
> +                           PAGE_SIZE, vma->vm_page_prot))
> +               return VM_FAULT_SIGBUS;
> +       return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vduse_vm_ops =3D {
> +       .fault =3D vduse_vm_fault,
> +};
> +
> +static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct vduse_dev *dev =3D file->private_data;
> +       struct vdpa_reconnect_info *info;
> +       unsigned long index =3D vma->vm_pgoff;
> +       struct vduse_virtqueue *vq;
> +
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EINVAL;
> +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> +               return -EINVAL;
> +
> +       /*check if Userspace App map the page number larger than kernel a=
llocated*/
> +       if (index > dev->vq_num + 1)
> +               return -EINVAL;
> +
> +       /* index 0  page reserved for vduse status*/
> +       if (index =3D=3D 0) {
> +               info =3D &dev->reconnect_info;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +       /*check if map pages was allocated and inited by kernel */
> +       if (info->vaddr =3D=3D 0)
> +               return -EOPNOTSUPP;
> +
> +       /* check if the address is page aligned, if not,
> +        * this address maybe damaged
> +        */
> +       if (virt_to_phys((void *)info->vaddr) & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       /* check if Userspace App mapped the correct size
> +        * the userspace App should map one page each time
> +        */
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EOPNOTSUPP;
> +       /* VM_IO: set as a memory-mapped I/O region,This will for vq info=
rmation
> +        * VM_PFNMAP: only need  the pure PFN
> +        * VM_DONTEXPAND: do not need to use mremap() in this function
> +        * VM_DONTDUMP:Do not include in the core dump
> +        */

Instead of duplicating the semantic, you need to explain why it is needed.

For example I don't see how the following is useful:

VM_IO: the page is not backed by any I/O page
VM_PFNMAP: we need map it to usespace for sure, for it's not a pure PFN
VM_DONTDUMP: including this in core dump may help to debug the
userspace process for sure

Thanks

> +       vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP=
);
> +       vma->vm_ops =3D &vduse_vm_ops;
> +
> +       return 0;
> +}
> +
>  static int vduse_dev_open(struct inode *inode, struct file *file)
>  {
>         int ret;
> @@ -1408,6 +1485,8 @@ static const struct file_operations vduse_dev_fops =
=3D {
>         .unlocked_ioctl =3D vduse_dev_ioctl,
>         .compat_ioctl   =3D compat_ptr_ioctl,
>         .llseek         =3D noop_llseek,
> +       .mmap           =3D vduse_dev_mmap,
> +
>  };
>
>  static struct vduse_dev *vduse_dev_create(void)
> --
> 2.34.3
>

