Return-Path: <linux-kernel+bounces-20786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1EA82853B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24B0B24511
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBBE37162;
	Tue,  9 Jan 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDsOpJZU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D41E4B1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704800333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2KHtwWJsxpW21yW1HeRr38zmDlSiokTXP6mx3ysxiI=;
	b=PDsOpJZUWfQ1c+TbjJiQKqrch9UNWOmBFuURiXq6XYSVCtEAI9xKIfcdd6ClbtzibEVuxN
	v4hUA3DiUSuLIwOEOid0iHcN9PFWJQLNF2qrdxdy4wVbn2za70C30ml8rmGsEI8KhTJq8m
	GlhPSxmikrwX5ge3bBOAPoRvkSryNyw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-6RqhJJM-N2K7flPK-Hm5vg-1; Tue, 09 Jan 2024 06:38:52 -0500
X-MC-Unique: 6RqhJJM-N2K7flPK-Hm5vg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5efb07ddb0fso37325437b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704800332; x=1705405132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2KHtwWJsxpW21yW1HeRr38zmDlSiokTXP6mx3ysxiI=;
        b=azRAP6W6zt+8XhbnIiuuCJx6mQWjeyrSM5isRfjLvH8nDcUFAiDZn/17QHk+PRXuxv
         XOv/0jZqNnFc6+HS0RU3s5CbpEP5lzXWNLF9jntIG5Yt0kDI4xkGxTvUAYBgLSTwhfbK
         qL2iVjvx9LTZJ+j+4E/nCLUzvXwseQLiVFYT8WdrdnUOXZeJlWE+tqVt0TFQEAqR5Mzv
         2G6hl72dxXkmYOGK2mWUm++uMnHXoGZZ+tNpR3R+kxBB8nLRWrCQYy4n0/8qg2e3sEWU
         ge0p61uOehVwM37LVjnoJAFCrMdDwNLW2JVgRUeN4sOKyTCr5HvYU0+l020aawIv5wRf
         OyiQ==
X-Gm-Message-State: AOJu0Yxv8rV29oEKzXjXIWBTFJralpl8/fZfxTyFgGk0aWoLsPJGhZAC
	aZBRhVqanIRcePJIF7ayqAYK5/emCC23oISj5RAyLOMqTS8YVm8pNYD9zN0mdG95wssvgBeUISN
	isPtrdvOjdrl6oqo0ikh3/1vKvZjXnLo4MTTzAjCSJM0P99qF7anjlGC28WY=
X-Received: by 2002:a81:7b07:0:b0:5f9:2256:5ad8 with SMTP id w7-20020a817b07000000b005f922565ad8mr1283427ywc.90.1704800331759;
        Tue, 09 Jan 2024 03:38:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrPfFI6jj8BO9UxzydSFzI12LofZZDf1mXLgqZA0eJByqMfyMiFqsUTjau9HOuPkP/s3h5jokc5K+rlk7t/sw=
X-Received: by 2002:a81:7b07:0:b0:5f9:2256:5ad8 with SMTP id
 w7-20020a817b07000000b005f922565ad8mr1283419ywc.90.1704800331475; Tue, 09 Jan
 2024 03:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-3-maxime.coquelin@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 9 Jan 2024 12:38:15 +0100
Message-ID: <CAJaqyWd9OYHqshDgYmP4X2pyvuAkQXuvttjKuAeMpvBira3FqQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vduse: Temporarily fail if control queue feature requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:11=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's fail features check if control-queue feature is
> requested.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index a5af6d4077b8..00f3f562ab5d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -8,6 +8,7 @@
>   *
>   */
>
> +#include "linux/virtio_net.h"
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/cdev.h>
> @@ -28,6 +29,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -1680,6 +1682,9 @@ static bool features_is_valid(struct vduse_dev_conf=
ig *config)
>         if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
>                         (config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_W=
CE)))
>                 return false;
> +       else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       (config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)=
))
> +               return false;
>
>         return true;
>  }
> --
> 2.43.0
>
>


