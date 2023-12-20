Return-Path: <linux-kernel+bounces-6337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC63819767
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402FA1F25833
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2968C121;
	Wed, 20 Dec 2023 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbe9WYQV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93548F45
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIn5APMs5q/H2mkbVIU64Mx79XhFiyV1fy9ppFrUsQ0=;
	b=Qbe9WYQVvKZsvb9ts2k2tf3a5aNhVgfH4JJSnmb3t+ljzR7Y7wE/GG8e0qydiuUTrO2NWz
	pIW2Z7X8GzJeNyZ87xQflhObIAlPuEhmUBjXWZhqPmb3vrPyMmPEjF/7lh1Fn8buqPutlm
	Io8MzpIpvAw3B8HjruIEYmdChb2pRko=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-Kd_i5WbTPPquJ2lW7XZnXw-1; Tue, 19 Dec 2023 22:52:57 -0500
X-MC-Unique: Kd_i5WbTPPquJ2lW7XZnXw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c65e666609so4726799a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044377; x=1703649177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIn5APMs5q/H2mkbVIU64Mx79XhFiyV1fy9ppFrUsQ0=;
        b=il1HLZ7Psk5UFKxudOn44PYn4+sKxdesMD5BhU8W3DMTG0Iy6Gqhihs96cIR7R4e1D
         cm070APeqxI5q8u9nR/4czfu0oMeY9Oc08hRhQKRnTSfQGP6cq2bmPHOgzDNbIWbiyvc
         ppt7Xi8LZqIq3DJ7sqACKoxJB+4cjLJZcj7MCUPEx0bT7kEw0YbMqKzq7+4pyk+KVgTq
         9PuEYqO2yOBO14YbffBDjfLd/+YI9aU+xSezjYA4BD7KUh+rs3EvFm4euGoUAQlVdwrE
         bVeMC7zbY4uWxwiNTC7KIEaUGxGJeu5nYCNN1Sf6RazbFw93697dJNFKBtaRk1h5XRy5
         nvVQ==
X-Gm-Message-State: AOJu0YwbwwXBX76VD3nggNOL+4m1LXsRenIf/Od5Q5kk2b3p5sIBszAw
	vqT2KfX57HvH6uHkKPVMen94qIuNUz6kBKZKXvU7kKJIYCxloJTugZADP/Jo5zLY4EccU/gVheg
	P0ebugphbBHKQxgKdqL3hcXBjGDJrrLKEswOMPxUQ
X-Received: by 2002:a05:6a20:9225:b0:194:cb44:b0b4 with SMTP id i37-20020a056a20922500b00194cb44b0b4mr526130pzf.2.1703044376849;
        Tue, 19 Dec 2023 19:52:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnMr21VcQdQT+Lk5xChXSsBuDnDzHafReZLcU6LBc8taYyagaiLau7y0wRNSCh7k4SnAF95Kz+VAAjOKYBcWA=
X-Received: by 2002:a05:6a20:9225:b0:194:cb44:b0b4 with SMTP id
 i37-20020a056a20922500b00194cb44b0b4mr526122pzf.2.1703044376631; Tue, 19 Dec
 2023 19:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d7534cc4caf4ff9d6b072744352c1b69487779ea.1702230703.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d7534cc4caf4ff9d6b072744352c1b69487779ea.1702230703.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:52:45 +0800
Message-ID: <CACGkMEuE5a29uXXWfy1Ma+ZqSzWKhS1J1b2XHvhyC90wDFP02g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:52=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> This is less verbose.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..d0695680b282 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -131,7 +131,7 @@ static void vdpa_release_dev(struct device *d)
>         if (ops->free)
>                 ops->free(vdev);
>
> -       ida_simple_remove(&vdpa_index_ida, vdev->index);
> +       ida_free(&vdpa_index_ida, vdev->index);
>         kfree(vdev->driver_override);
>         kfree(vdev);
>  }
> @@ -205,7 +205,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device=
 *parent,
>         return vdev;
>
>  err_name:
> -       ida_simple_remove(&vdpa_index_ida, vdev->index);
> +       ida_free(&vdpa_index_ida, vdev->index);
>  err_ida:
>         kfree(vdev);
>  err:
> --
> 2.34.1
>


