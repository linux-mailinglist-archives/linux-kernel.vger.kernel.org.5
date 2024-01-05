Return-Path: <linux-kernel+bounces-17431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306CB824D20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51363286AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1DE2109;
	Fri,  5 Jan 2024 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGNPx1de"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2A20EB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704422745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42T2XOYsv/Q/QxGLaFEK4T7TNmI9rS29RX3cDmclaks=;
	b=LGNPx1deMfUnI6QyNnLMc7eZBKQ5d39Oeoeh3QN0TVxhkAXQn7KVssH0bs785HOjKq0Pg+
	/enj+c73y+Khig7u59/0MRsMb9ziI05P/1E2APFP6PTC/DE8wn4ibNAqY+BjbzSZDpOfde
	1bv4lty6GjkBLfQCuT5yzmMJfmdSWWQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-jj1yqsfjNbaltjCNf3k7IA-1; Thu, 04 Jan 2024 21:45:44 -0500
X-MC-Unique: jj1yqsfjNbaltjCNf3k7IA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28bdc7e67b5so684447a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 18:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422743; x=1705027543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42T2XOYsv/Q/QxGLaFEK4T7TNmI9rS29RX3cDmclaks=;
        b=Iz3Jv+zLQYQPSLtdYP81RbrR8sP4snzmaEZkCKXMfrY71l8U/O6n/t/fgiE/Bdkikx
         sUxNQU80VE6trVQaQwhisIsGnaVirkqjGzAcjH6HYhMjAKLWM1qxfj0WQyH89XBGDyXn
         5YjNK+F2+1/TlTaCCn6i0M6ioQc9dE6sGa8PtvFQ+gBiSVkVlyjKWB9QofyqV37Xxfl/
         Vwb7xo5rSx67uB5KNY/aJ1jtnMQTIGh83NIH4NBWiYjkfn9HpSHs9BRiX+ZjGWl4KFFg
         GXGf6f+7QBvqDoZuGedM6vw4f8WEIvDQlOHd0+jQ7cFuHf4iFnoHhLRySRRGdF4af1gm
         AhSg==
X-Gm-Message-State: AOJu0Ywq9sfxoQps46+cblHcHQNhEDQt1htpbgQ/vARqbY6FeRsqaB8h
	7eLE+i+JoL+uhr3snMAkHnPnXN8i1ob3wfrx1t1V1L9Z7LcuXqLs0/EBgIJLpwEhcEnlHLkcJPO
	nTC8HPdE8HMCa+tcDzF/w/WItP+08Y9lEg4y6ue3AxorSqs4s
X-Received: by 2002:a17:90a:f2c2:b0:28c:f48c:c875 with SMTP id gt2-20020a17090af2c200b0028cf48cc875mr1383844pjb.45.1704422743331;
        Thu, 04 Jan 2024 18:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU4D4ZC5TBDtzGS71F/hn8ITZAmo7xpBZ+HC+qYcgCmxUeB9oZgTh3hKy8a98xMCSDKoul/pup8VWm2YAwB8E=
X-Received: by 2002:a17:90a:f2c2:b0:28c:f48c:c875 with SMTP id
 gt2-20020a17090af2c200b0028cf48cc875mr1383834pjb.45.1704422743011; Thu, 04
 Jan 2024 18:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-3-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Jan 2024 10:45:32 +0800
Message-ID: <CACGkMEtmTY0ux8pw8VQ8SAdgGty=rM1VRkh6c-qBVSaqhYuURw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] vduse: Temporarily fail if control queue features requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:38=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's fail features check if any control-queue related
> feature is requested.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0486ff672408..94f54ea2eb06 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -28,6 +28,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -46,6 +47,15 @@
>
>  #define IRQ_UNBOUND -1
>
> +#define VDUSE_NET_INVALID_FEATURES_MASK         \
> +       (BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |        \
> +        BIT_ULL(VIRTIO_NET_F_CTRL_RX)   |      \
> +        BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |      \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) | \
> +        BIT_ULL(VIRTIO_NET_F_MQ) |             \
> +        BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |  \
> +        BIT_ULL(VIRTIO_NET_F_RSS))

We need to make this as well:

VIRTIO_NET_F_CTRL_GUEST_OFFLOADS

Other than this,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -1680,6 +1690,9 @@ static bool features_is_valid(struct vduse_dev_conf=
ig *config)
>         if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
>                         (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
> +       else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       (config->features & VDUSE_NET_INVALID_FEATURES_MA=
SK))
> +               return false;
>
>         return true;
>  }
> --
> 2.43.0
>


