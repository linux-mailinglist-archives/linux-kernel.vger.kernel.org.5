Return-Path: <linux-kernel+bounces-23011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6920882A653
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA91F23F34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8015D5;
	Thu, 11 Jan 2024 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSj5NrFL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010715A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC5e9WRB2cisP0/PxP21NqudRB4e9ferLpZ3ANHXECg=;
	b=LSj5NrFLkD+vVOCcmoc20dJ3VAucublO2n0bndV+rkkowBvFut2WE3USba0zBHncFmYIHC
	paiAlI/DWEX5JuuB4PzmBP7FkBj2EF2Zw73Msrf/KGDotJ+Jhnq4qTwd/qrTXCTWsjaDGQ
	gbSQ6ShPwZ2FBqnpEUe7jtQ2r8xFBPI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Wnu27jQANF-GkoIqlf8EmQ-1; Wed, 10 Jan 2024 22:09:32 -0500
X-MC-Unique: Wnu27jQANF-GkoIqlf8EmQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ddec7b52e7so2105871a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942571; x=1705547371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC5e9WRB2cisP0/PxP21NqudRB4e9ferLpZ3ANHXECg=;
        b=a6+FWEUDMh+f4VBS2QbndUJpJx7fvNovTYU8RVYdeRBsvBIqdRVlog4uOIxr2XweGi
         xYG1dNnd7hhELEVYr4nmDO6CJPn7gryFD2lhko7O5OJGNAzvJYkmfNW0QSRRfylTmRnN
         fvW9TZuqXnwDYv+nQqYAz6NJ5WLhifHZgOMfhA4MXOwo9o09WyzpHexRl9xVhaRY0aBX
         feb3RPzPqJHOMD9qsbXXyh7hGITZX6BRVznvqOTArqfItKcgBjo9KOHuq2UV8NZi8G3U
         W1tz1uqEJWMB227c35wSwXlUaUN60+3bX/X+utu7XyO8No7c8ncEqIqpsUlEeVKbpBjk
         YCMg==
X-Gm-Message-State: AOJu0YwipVg0ctxMcs2rZxeEKhPQjBrL1w2urh+S8BlZdUyxRH9e9Ag5
	Sh6A5o18eBVZ/IvSZqFBc6zCFPoU4+Tcu70o83lgaQhNAUTYQw1exaW0KeABsSClE2B3F/cP+Sz
	uE0kxnkrGjjtARI37hgEz5iTKvndHll/MzCpkUUyEH1PxwiSFDZ9dA1sq
X-Received: by 2002:a9d:7f82:0:b0:6df:2c26:c5e with SMTP id t2-20020a9d7f82000000b006df2c260c5emr179202otp.31.1704942571526;
        Wed, 10 Jan 2024 19:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFrnXhh1+r1aWEfuOYbZcJQnI9BifUyc1+kAgcYl0a9OJPFVe8flUkKOSFk4S22VkfZnW1C8f7ecuVkPK1LjM=
X-Received: by 2002:a9d:7f82:0:b0:6df:2c26:c5e with SMTP id
 t2-20020a9d7f82000000b006df2c260c5emr179189otp.31.1704942571315; Wed, 10 Jan
 2024 19:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:09:20 +0800
Message-ID: <CACGkMEv8TXXTrCW=hf1sJ+V2a0eD3w1b1Yub4FnGZ0=Du-RbtQ@mail.gmail.com>
Subject: Re: [RFC V1 07/13] vhost-vdpa: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> To pass ownership of a live vdpa device to a new process, the user
> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
> mm.  Flush workers in suspend to guarantee that no worker sees the new
> mm and old VA in between.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8fe1562d24af..9673e8e20d11 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -591,10 +591,14 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> +       struct vhost_dev *vdev =3D &v->vdev;
>
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> +       if (vdev->use_worker)
> +               vhost_dev_flush(vdev);

It looks to me like it's better to check use_woker in vhost_dev_flush.

Thanks


> +
>         return ops->suspend(vdpa);
>  }
>
> --
> 2.39.3
>


