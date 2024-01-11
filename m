Return-Path: <linux-kernel+bounces-23015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6982E82A65E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9D7B277B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6FB1C31;
	Thu, 11 Jan 2024 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcKOvIjn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777517C1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVa1KzmyYYorAZDdtVUttYweORkac6xnCaVp9EWXlys=;
	b=VcKOvIjnQwBpGyoM13caKUw7e74471acqUMlpVHtGqLh1uJ5BjZfDOL5VdKMNaKpxmCdW3
	qVvGewyM1KkVBJCS/ipKdph3g3kTOgwH0SSchQXwLUCBD58AvOUBGwdSw4+q8wZXGRP4Xq
	CMOQNkVGoSL1NM/V9T7q6LPoCmUn8oU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-B-yQeYg1MmWc-tLReNmEIA-1; Wed, 10 Jan 2024 22:11:08 -0500
X-MC-Unique: B-yQeYg1MmWc-tLReNmEIA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dde701a6ccso2544917a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942667; x=1705547467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVa1KzmyYYorAZDdtVUttYweORkac6xnCaVp9EWXlys=;
        b=hBFx2LREm04Qgxj2UBA4jXNU523sOO5RPsNfGFwTXo79g+6bpLvnoQrTvKFf9Rqhz6
         E2O6xH7sAAr8AeuCDnowWrENc80uxwgGXIicRl4o+FpH7ydMVHFBjecuA53WqECIQama
         vSADnlsbgDkpebJrvOckyiiCkB50wpF+2l7xh2Q6b2np1M0BR9rkzBI/lmJK8qNKexNi
         6jju0bWvO4bGbhizUlKFYb2oD8TCpHntkv/OPBn2p/B+huo8koeqOME+aCOPKViBCBiB
         cs/rxxRjCz6KbETym15C+hcUuXHN6LqvHQ+CzmcxWNG+xvEGRxGSwYKEg9c0ycAdrHc0
         YBTg==
X-Gm-Message-State: AOJu0Yy2K54axk8NgrYk/vlnFFWY73IU2gV1KbHl9vooGg+cSZUL+AMd
	dZt6JGUyOf3XfiR8lDsQKDr/UxFpAoqxRZIWoAUPwL2AVccNamtaGbLKnJdu3bEm38S4g8H1DgV
	09sj4FWZuR4hCER4pisGVuyu6EJVFQ/2eWyfZ4DbbeIvzA96cZg+wvrLX
X-Received: by 2002:a9d:5e04:0:b0:6dc:4f4:f4e0 with SMTP id d4-20020a9d5e04000000b006dc04f4f4e0mr513024oti.45.1704942667345;
        Wed, 10 Jan 2024 19:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3wjIYR0PBvhYK3NGeTYrBLBnxAsEX+Am38TXiw81014PUC3WFBBHfaa4wMD9BO+8kt2Y+dPM3b702gUqtdwI=
X-Received: by 2002:a9d:5e04:0:b0:6dc:4f4:f4e0 with SMTP id
 d4-20020a9d5e04000000b006dc04f4f4e0mr513017oti.45.1704942667121; Wed, 10 Jan
 2024 19:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-3-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:10:56 +0800
Message-ID: <CACGkMEuOCAKwn-4dC4pd8qbBP+0sYCBa4-TpVabN238-WOFUBw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vduse: Temporarily fail if control queue feature requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com
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

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

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


