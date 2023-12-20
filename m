Return-Path: <linux-kernel+bounces-7266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E36E81A41E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9921F2114B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AD848CF6;
	Wed, 20 Dec 2023 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aebkrGNh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD14482E5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr8MPAJHFdPTjh5Rq/GtMEvXBHCwBjyrhMG94FUnKkw=;
	b=aebkrGNh9WmHcmDeknJslmjagQcTDGfHwHmRiLNTbIHx/AAocSg5W3wCViZRgxIAXKJ6fV
	wBQsCkiE3oEo0L9b1D8sh8ojJRuAcS6xEnIF/3ghUK13xE3spueagLTksdPOUa45QkGCYO
	XVxfl6z6kNMTfOsU6UvqOVZhi2si0YE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-1m5MmukrMRS9E4HHYe8cIA-1; Wed, 20 Dec 2023 11:11:36 -0500
X-MC-Unique: 1m5MmukrMRS9E4HHYe8cIA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5e6fe91c706so50977287b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088690; x=1703693490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hr8MPAJHFdPTjh5Rq/GtMEvXBHCwBjyrhMG94FUnKkw=;
        b=D6ZES4WWNcNy81YX3jn1zKN957b9RxuaeTfrZ2Jo/vx1ckc9xs6rA1Iu6U6sp9+ySS
         OYONbWv0Y5ubjrKMrdPc0HgF/35PfuZuFoAVjG72UUBYuL+Hy5LSoMQw7ysP7inD4T22
         6Zy27HohUwWbptIbShK6LSYMG0qxtDrDbziWQE8byfY0vyfuQ3C+w7Z19kWMGOd/GoJJ
         tT58oL7xS9jAG8euEtgtDq2Qtrdzy7gzUM8HYVmHJb1RZtshcxRcT1MSVZnO4g7RH7xq
         9wfUkUADux4CDDQi5T7VGDxb4hMFgzMhTZO4rZA8Gvm5BcblEVNICBfchYSTIZrJ/MVH
         gEog==
X-Gm-Message-State: AOJu0YxUJouLWf50FgQ8xGlrUw/piFcAhTR0n4nMwjNKwy6lZf+yQiAC
	QgGS0LpXbWcjxnyrxa6MMZlYxTl5EDaTTPKYRwYA4gvokV5FdAFdcvE63BmU+251h4ipHleZ9dg
	a/Pn1U1dzlVGxyLXc3GRWvlDlbiTI6X4gUVl7Er7R
X-Received: by 2002:a0d:c101:0:b0:5e2:51da:c3c7 with SMTP id c1-20020a0dc101000000b005e251dac3c7mr10305122ywd.21.1703088690313;
        Wed, 20 Dec 2023 08:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1/3P9BihNppwPcI9ZwmYIdbokvO4vu2D8gVryyj+uidHmGZ7fPxQNOeaB6BK51iRQjk9CdAWw+/VME/gOfzI=
X-Received: by 2002:a0d:c101:0:b0:5e2:51da:c3c7 with SMTP id
 c1-20020a0dc101000000b005e251dac3c7mr10305113ywd.21.1703088690077; Wed, 20
 Dec 2023 08:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-4-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:10:54 +0100
Message-ID: <CAJaqyWf7cVQ0VC2uLQPeP1B4XYCCQupKFcRFhpEge40=ci17zQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND
 flag
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The virtio spec doesn't allow changing virtqueue state after
> DRIVER_OK. Some devices do support this operation when the device is
> suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND flag
> advertises this support as a backend features.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  include/uapi/linux/vhost_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index aacd067afc89..848dadc95ca1 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -196,5 +196,9 @@ struct vhost_vdpa_iova_range {
>   * and is in state DRIVER_OK.
>   */
>  #define VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND  0x9
> +/* Device supports changing virtqueue state when device is suspended
> + * and is in state DRIVER_OK.
> + */
> +#define VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND  0x10

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

It would be great to find a shorter ID but I'm very bad at naming :(.
Maybe it is ok to drop the _BACKEND_ word? I'm ok with carrying the
acked-by if so.

Thanks!

>
>  #endif
> --
> 2.43.0
>


