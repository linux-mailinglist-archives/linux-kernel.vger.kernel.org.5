Return-Path: <linux-kernel+bounces-21685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBD8292C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DE2B21528
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D246A2;
	Wed, 10 Jan 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gJPLWTpe"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2C1FA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bc4f49a3b6so4093330b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704856864; x=1705461664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj6N1efk3sr0CxuJFT4Q8DbyNJU3YuHTNbSj/LQf1lo=;
        b=gJPLWTpeRGoQq/KxGYpgxSCNxuJgltXG5/iuAPw/ugglEeX2CIqYwhtb6VtH7M6Cqi
         vMnavgSeG3iN3+URxbkm6YP2BZFVR+h4KGvizgX+dgercYPYzHF+eGI3z8mL2NwL4IXE
         u1/gVAi7VcpX/A3Iy33+TcS9qRr269ZmGjhWhILuF5obaMzpdjnSQzYeUGWeEUKHSqpm
         mV4CC8fTXKvh5ndk5dhG/hFeSzzwEq5t//oaWWrqKp3Nd4K61bG7oLIXdbJPIUD56RM3
         Y8z7m3+c40bEi0KYs7d4WarfryZYV6IrRSjMD14WcqtE6TvlNlbvuMazrXo6zfnUGlHZ
         odIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704856864; x=1705461664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj6N1efk3sr0CxuJFT4Q8DbyNJU3YuHTNbSj/LQf1lo=;
        b=LcD08PFl1mUVSgrMXJyw5kUq6tiMyGoL1wE/H5jXtmBzUQ15feYJjG92I05Cb/vADq
         t/15Y7hPV4y55gtvUwHBowazpky3xnWpu0rXSqlrriS3it2EmMvSpSw6DKmVTYe8UgUC
         cdpIiq80qqy3EpdjrBj/k7RDiXoTW91lR/G70ITv4KUM1r8di4o03Q8yqCiau0jzLI6A
         xk6pMxTnh6PcqaW6u8MKOYom1ZtfattnWrR3C/GBdM8v64ZkbbFlsFubxAMtsrCJUO0O
         p+I440j/JUm8to64+UiHNnSXldNBgWDL+mNlnXrjfMYzkOMlkApzdAjKGdvjN0q3fpO2
         EwLQ==
X-Gm-Message-State: AOJu0YxZQ0Bzvc2c/23e//tQMytNvay9ygPoqGa8JF8zkBgj26XMZeDb
	LY+sNZHOTJaTfizbX+EXNvoXP3lGdrDHKyPomIe4l5CBPkT4noqQdME0gGs=
X-Google-Smtp-Source: AGHT+IGqXBEnKCM1dvGMoY/czMMwAslKtHfI0G8Legil0uTORf6Ps32W3HONIOQQ6Wj1YhsNUXuxTrWSMk4LPpxazTg=
X-Received: by 2002:a05:6808:1919:b0:3bc:9167:4e62 with SMTP id
 bf25-20020a056808191900b003bc91674e62mr507670oib.40.1704856864530; Tue, 09
 Jan 2024 19:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-3-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 10 Jan 2024 11:20:53 +0800
Message-ID: <CACycT3sjYzh7Df9M1Bfxk_pWc7Am6AmjQv8_vu6fA2fhP2+7mg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vduse: Temporarily fail if control queue feature requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, David Marchand <david.marchand@redhat.com>, 
	Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:10=E2=80=AFPM Maxime Coquelin
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

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

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

