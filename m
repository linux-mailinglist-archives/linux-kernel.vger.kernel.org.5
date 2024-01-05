Return-Path: <linux-kernel+bounces-17705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3AA825163
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DD71C22CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E424B41;
	Fri,  5 Jan 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KewQG6iP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1124B2A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704448841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDTL7eZEwQEt4FJfs0Pl8u53p2yeEWxqLY7MxE4u220=;
	b=KewQG6iPXpJuDfKWMbPm6ULwRUVPKh/4beMbSgpxdINHdmev9GTaNqUdnSbAb7kvyGbdss
	RFTvZmSC4HYaLl3xast5TE/62Alt59rV5wVcDZ6V/KfsW5WyE/k+qGBhbOsQUPe/Z8cprS
	HjanMcXOhbfMk7GDpV7jGwOtgB2cuKE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-gX1yPgAVNl-dvWVBgZCDRg-1; Fri, 05 Jan 2024 05:00:38 -0500
X-MC-Unique: gX1yPgAVNl-dvWVBgZCDRg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5ee11c69bb8so30062627b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448838; x=1705053638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDTL7eZEwQEt4FJfs0Pl8u53p2yeEWxqLY7MxE4u220=;
        b=scGK6x4iSmyIzfa8DXISxl7T4jvqAQHlkaUdENQ1cyuEh8LyA5hksdXYaBZqTtl9Bc
         aSTb7KFccN+BXMwgmuMJIg7PKE7C0PoJ5Bk7NGrqkELa4xCm/Uv8xSSn39kTXxqJyRgv
         oYJ901XSaahdUJYEMItdx/CF97Spc6r6z/dlPFOE0nAgKfLuDQoishVr3MzgdqKOvZ/2
         T9/vqqQvAg8bbig3tEYkm+Fb7H4D9EdY9hhGQAqJp60Ib/5eGYbhl99HhAxNI8PZmwW2
         g/f6UFUMHtCZc01TIdnPX8dEdloUgdBZyLO2/weYuGZhe/xAAKCFQwpd/MHfM/VCktdd
         8iQg==
X-Gm-Message-State: AOJu0Yw3is6aONOcejwa3X7LC9Xy0H4mV+iK5OrbYIjLaP/KjN5vLEFe
	yXRfGQhn5JFR4aHGNlRONyTaLSqj74/ECdfhbUOt+apc8rvZlQNDPpdoY36I0lM0nzo4FnwKddh
	VK0H1xQ2Xlg3780bIZqx9Fgg8m4SSXB+hvtlHFP5SI6LI4qfffvsRZeFYu3M=
X-Received: by 2002:a81:5c07:0:b0:5e7:a7f6:47ee with SMTP id q7-20020a815c07000000b005e7a7f647eemr1962168ywb.80.1704448838218;
        Fri, 05 Jan 2024 02:00:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp80U4Fd+oLUI0ZzXKfeVM274HiCmXkNGJQljLBxBgi1oqb8H43lLPLE8Q4KVwka5d4Qc9Wk8GVOawxsKqLKk=
X-Received: by 2002:a81:5c07:0:b0:5e7:a7f6:47ee with SMTP id
 q7-20020a815c07000000b005e7a7f647eemr1962155ywb.80.1704448837970; Fri, 05 Jan
 2024 02:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-4-maxime.coquelin@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Jan 2024 11:00:01 +0100
Message-ID: <CAJaqyWeMwC9-GFq4VpaES1NDTNziUnQ7PkD3xPfoYvVsCSvaqg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:39=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types.
>
> Initialization fails if the device does not support
> VIRTIO_F_VERSION_1 feature, in order to guarantee the
> configuration space is read-only. It also fails with
> -EPERM if the CAP_NET_ADMIN is missing.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 94f54ea2eb06..4057b34ff995 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -151,6 +151,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] =3D {
>         VIRTIO_ID_BLOCK,
> +       VIRTIO_ID_NET,
>  };
>
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> @@ -1694,6 +1695,10 @@ static bool features_is_valid(struct vduse_dev_con=
fig *config)
>                         (config->features & VDUSE_NET_INVALID_FEATURES_MA=
SK))
>                 return false;
>
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       !(config->features & (1ULL << VIRTIO_F_VERSION_1)=
))
> +               return false;
> +
>         return true;
>  }
>
> @@ -1801,6 +1806,10 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         int ret;
>         struct vduse_dev *dev;
>
> +       ret =3D -EPERM;
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) && !capable(CAP_NET_=
ADMIN))
> +               goto err;
> +
>         ret =3D -EEXIST;
>         if (vduse_find_dev(config->name))
>                 goto err;
> @@ -2044,6 +2053,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtd=
ev_ops =3D {
>
>  static struct virtio_device_id id_table[] =3D {
>         { VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
> +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>         { 0 },
>  };
>
> --
> 2.43.0
>
>


