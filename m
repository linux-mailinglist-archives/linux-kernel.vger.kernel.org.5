Return-Path: <linux-kernel+bounces-6340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB14819773
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AE6284A89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCFA15491;
	Wed, 20 Dec 2023 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXa7R4Xr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766B14AA0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGB9OQg5bjkn7TP5D/aYpmIW7Xo9iRJPncX1JD79MEo=;
	b=EXa7R4XrTG7MhW1KrswKDbwPJhKY7nvALtRFn7C4olJWqcW5JENRQbwdMogKor5boBHqlZ
	LOcJ76VNXl+ScFkYDs2D2JOkHsk3N8EvXTuC5QMoEZQeLnCEBLXJlCbJ9ZxzCPB3RxxZ40
	IbTwRT7tzaPHBXwcADD7Diui2TW4akg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-RlTLU0ggNCa106G8ZHtpGw-1; Tue, 19 Dec 2023 22:57:55 -0500
X-MC-Unique: RlTLU0ggNCa106G8ZHtpGw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ba2072052cso6587958b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044674; x=1703649474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGB9OQg5bjkn7TP5D/aYpmIW7Xo9iRJPncX1JD79MEo=;
        b=Jvkwqducrnp9Gb//bjJN2KGbZH0RxU8/f/9TtpPzFXsDK2MInBhFBwZqov7HHl/AiX
         o70VlC7acsk+utn3YwBAgQ/iRVs+djcS+g8V0PRJ2HQoU0WXgcfiCYn2O/qSqw/p4cdq
         Vw7564RxcuNuxyYfP8TzflUySJhX8DedSPF/lDbDWybqxAz65Zg8OZtX5ziNv5RbaGB7
         Q1A5zrTFCdRHNp3IJqNYKzUrCBrunRBzwmdQm8sx86vsKBtZNt9y8N09LByJiDiAKSl0
         QveZPU5cjZz14bztHKIL6FI9XRx1OMBYJyMRyHPD5mjtVXDGvZUqhnNzV0p4EYudQtLg
         dLTw==
X-Gm-Message-State: AOJu0YyN5rryVIZ9e0MdO8iizNGvL5R2U07bmAP8hhLvaeMQM2M4itkR
	w5bG6jIo3x9e3G0KMq4dDx6b6uKhsuHseY694R9zrLV1wRLBPalkPTcPFsPIHNz7l6igk4We8uX
	fDNGda+z2xNETGHj1hqpV53BvcT6hHQajVHu0mLqZ8xkWSIS1W2M=
X-Received: by 2002:a05:6808:2225:b0:3b9:de1e:17c2 with SMTP id bd37-20020a056808222500b003b9de1e17c2mr24722060oib.43.1703044674625;
        Tue, 19 Dec 2023 19:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBHszk26c2E8rxJ5eYpscabmiTkCBilA5/rsGNc2AubHn4l/QKcgkKQYrD/3vio7FZZEGnHDCtWORhj8swx3E=
X-Received: by 2002:a05:6808:2225:b0:3b9:de1e:17c2 with SMTP id
 bd37-20020a056808222500b003b9de1e17c2mr24722049oib.43.1703044674328; Tue, 19
 Dec 2023 19:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219071849.3912896-1-changyuanl@google.com>
In-Reply-To: <20231219071849.3912896-1-changyuanl@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:57:42 +0800
Message-ID: <CACGkMEuEY5xJyf6H6RgqSuD0PeY9kynYywxzM2+3W6MPaav0Zw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: support feature SHMEM_REGION
To: Changyuan Lyu <changyuanl@google.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 3:19=E2=80=AFPM Changyuan Lyu <changyuanl@google.co=
m> wrote:
>
> As per virtio spec 1.2 section 5.19.5.2, if the feature
> VIRTIO_PMEM_F_SHMEM_REGION has been negotiated, the driver MUST query
> shared memory ID 0 for the physical address ranges.
>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  drivers/nvdimm/virtio_pmem.c     | 29 +++++++++++++++++++++++++----
>  include/uapi/linux/virtio_pmem.h |  8 ++++++++
>  2 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index a92eb172f0e7..5b28d543728b 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -35,6 +35,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev=
)
>         struct nd_region *nd_region;
>         struct virtio_pmem *vpmem;
>         struct resource res;
> +       struct virtio_shm_region shm_reg;
> +       bool have_shm;
>         int err =3D 0;
>
>         if (!vdev->config->get) {
> @@ -57,10 +59,23 @@ static int virtio_pmem_probe(struct virtio_device *vd=
ev)
>                 goto out_err;
>         }
>
> -       virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> -                       start, &vpmem->start);
> -       virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> -                       size, &vpmem->size);
> +       if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
> +               have_shm =3D virtio_get_shm_region(vdev, &shm_reg,
> +                               (u8)VIRTIO_PMEM_SHMCAP_ID);
> +               if (!have_shm) {
> +                       dev_err(&vdev->dev, "failed to get shared memory =
region %d\n",
> +                                       VIRTIO_PMEM_SHMCAP_ID);
> +                       return -EINVAL;
> +               }
> +               vpmem->start =3D shm_reg.addr;
> +               vpmem->size =3D shm_reg.len;
> +       } else {
> +               virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> +                               start, &vpmem->start);
> +               virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> +                               size, &vpmem->size);
> +       }
> +
>
>         res.start =3D vpmem->start;
>         res.end   =3D vpmem->start + vpmem->size - 1;
> @@ -122,7 +137,13 @@ static void virtio_pmem_remove(struct virtio_device =
*vdev)
>         virtio_reset_device(vdev);
>  }
>
> +static unsigned int features[] =3D {
> +       VIRTIO_PMEM_F_SHMEM_REGION,
> +};
> +
>  static struct virtio_driver virtio_pmem_driver =3D {
> +       .feature_table          =3D features,
> +       .feature_table_size     =3D ARRAY_SIZE(features),
>         .driver.name            =3D KBUILD_MODNAME,
>         .driver.owner           =3D THIS_MODULE,
>         .id_table               =3D id_table,
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio=
_pmem.h
> index d676b3620383..025174f6eacf 100644
> --- a/include/uapi/linux/virtio_pmem.h
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -14,6 +14,14 @@
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
>
> +/* Feature bits */
> +#define VIRTIO_PMEM_F_SHMEM_REGION 0   /* guest physical address range w=
ill be
> +                                        * indicated as shared memory reg=
ion 0
> +                                        */
> +
> +/* shmid of the shared memory region corresponding to the pmem */
> +#define VIRTIO_PMEM_SHMCAP_ID 0

NIT: not a native speaker, but any reason for "CAP" here? Would it be
better to use SHMMEM_REGION_ID?

Thanks

> +
>  struct virtio_pmem_config {
>         __le64 start;
>         __le64 size;
> --
> 2.43.0.472.g3155946c3a-goog
>


