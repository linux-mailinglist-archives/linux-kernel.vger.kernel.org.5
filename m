Return-Path: <linux-kernel+bounces-6327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3B819747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8533F1C2541F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC352156E2;
	Wed, 20 Dec 2023 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGzs/JmH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B28134C9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9w+rATDkUtjVeCwGcF601wo/RABwY+YM2dZRh5W8pOM=;
	b=fGzs/JmHb4VQNOWJF8CtyexwLFIWZhHq21jGKhW9Tpmf2u0Bv0CjK2nq/dy19VZ1mvRGU+
	swUh0T/hEqy1k0yH9KM72MuoBzkmjWMSCloGI0zBfp3JRhrPFZcHKXMW5tLFuZhJEVSYU+
	BbSNhT0aF8aVCSF/VFcGx2OjIAmbveI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-utHKdozSOjGxDuXkgw7AGA-1; Tue, 19 Dec 2023 22:47:06 -0500
X-MC-Unique: utHKdozSOjGxDuXkgw7AGA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9f111c18dso7269590b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044026; x=1703648826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w+rATDkUtjVeCwGcF601wo/RABwY+YM2dZRh5W8pOM=;
        b=OyFfD7r9SPC9zIz2GfqSWjD880MQq9jnrdOTFHXJ2GkO5baPjv+495Jb7nl0ow8tlr
         dX9pHfsHZfUUA+Ugpd0FhR4p1JtXJJWSBsu1AMimr66QHogoHr2qTNxkIxMYNErAURa/
         YIWSl3frC5CJZTdl1ZFJRKb4yZA/pRpxC0YE/ZVmiVHEk3p3e7EaL4rP+qggO6Rw6iAz
         +7GWvnw9jghHGzaYO3qsUJKrbKoeUfz05KY7o97YQU/5pNJ93B7I3NZvifJKY85SGsaR
         H8t/I1QUhpyhXRhlBNVN7IwiL+RgBGIzs6Vudc3yF8nESg0rje5/C14xRHrncgP0KrMi
         np9Q==
X-Gm-Message-State: AOJu0YxmUPehg9LSoCGgTqS6juliDReQk+6aaIMD3ZVwW0dqeTbLoBnB
	8LMIwQnINwKVWZT/edufJ+isA+exw0ryCdI8KC6XdH2VXgqbD7nxisUHBp2TrKp9BND8MRaIitD
	yqBe1+jfn9a+hkjjnR+coZ9dj31BuA0lW1JJX5dTZ
X-Received: by 2002:a05:6808:f91:b0:3b8:b20d:cecd with SMTP id o17-20020a0568080f9100b003b8b20dcecdmr25104407oiw.32.1703044026073;
        Tue, 19 Dec 2023 19:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN31V4IDc9YdM/jG9vbcC5ujWxgZW0OEmEotp+PSSsAUbfJELk/1CFnUoFJlwk0MWCN004qTKhi5PhO5Y4oo0=
X-Received: by 2002:a05:6808:f91:b0:3b8:b20d:cecd with SMTP id
 o17-20020a0568080f9100b003b8b20dcecdmr25104401oiw.32.1703044025883; Tue, 19
 Dec 2023 19:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-7-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-7-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:46:53 +0800
Message-ID: <CACGkMEs_kf2y9Khr==zY3RRHffaPRwS51XK33Lgv1eeanQdRpg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 06/15] vdpa: Track device suspended state
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Set vdpa device suspended state on successful suspend. Clear it on
> successful resume and reset.
>
> The state will be locked by the vhost_vdpa mutex. The mutex is taken
> during suspend, resume and reset in vhost_vdpa_unlocked_ioctl. The
> exception is vhost_vdpa_open which does a device reset but that should
> be safe because it can only happen before the other ops.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b4e8ddf86485..00b4fa8e89f2 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -59,6 +59,7 @@ struct vhost_vdpa {
>         int in_batch;
>         struct vdpa_iova_range range;
>         u32 batch_asid;
> +       bool suspended;

Any reason why we don't do it in the core vDPA device but here?

Thanks


