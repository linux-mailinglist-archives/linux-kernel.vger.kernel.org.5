Return-Path: <linux-kernel+bounces-7271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A581A43F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C631C24261
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D404C630;
	Wed, 20 Dec 2023 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAYeNCKu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1A4AF73
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEaUEcnajrqgltfyosH4+omdF/fMexYhj4bOk+VvvgM=;
	b=aAYeNCKuFX0LtNZanY07NyIxH4iv+eNmZ4oc7aUEAz48jU/L3OTGNT5IDuaG2ffxGWJpXH
	m09PokzsUDXGLJg6oLyvBtHGu2vWNFcKOpCyXS5/g7Dr0DvUjONN0p47/NOk9o21ui4C5v
	0GfSZtMhMvpxzeudYHRYJjk2c6+RYfA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-eUD6fTTTM5Wc9-8TdDEccA-1; Wed, 20 Dec 2023 11:12:32 -0500
X-MC-Unique: eUD6fTTTM5Wc9-8TdDEccA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5e7c4de7198so21082017b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088752; x=1703693552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEaUEcnajrqgltfyosH4+omdF/fMexYhj4bOk+VvvgM=;
        b=EYhD4c+ctjm3ouWS6Tc7WSDWyoOrA1W14R6QlSyqryb7//+yn2XUsGJkcX4DTMsvUp
         r4YVTnAXm5ywT06gdfygE6oaCEAGRpE/CVhi1h8Lk1h2YU4A5XBRZlvk2F6ZCd9YjnV0
         ffE/eaXRMnXdUjzE1rnGFX3nOy8J9e4GHDF+rAHWI9JmSMMagzm5WHf6Ym/Mz7bOy6U3
         DIiNhbRksOtI1g8nr6UP3ZRnMnoi9+ZVrsb46brhyBxDFIFYS8wG2b3+KsrkD8ZuRyls
         D5ntMnSlxIHUwxc1fzfoBWJC2MMtXnYQ5J7xbqOZrefep4OV8Jh28qWC7ddJAbjUbZZ1
         d+5Q==
X-Gm-Message-State: AOJu0YycvmGSpb7AhVcZDSRfEHxxuu0gwgrsBnsWmSE9GGMP66Lc0B47
	v5UoEI08K0M+WN6f1Q7TNDvvonHldsoRay4WZGWvJlEHYSfhyw3wOaKGE1iIK3PVsK1NYQ7wf4/
	Q/7n1NeOhjhv0A7w3sqitb3jEoxLdsZb1/YvzN0e4
X-Received: by 2002:a25:b28c:0:b0:dbd:ae7b:fa8 with SMTP id k12-20020a25b28c000000b00dbdae7b0fa8mr579089ybj.89.1703088752248;
        Wed, 20 Dec 2023 08:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHWUzQ5gSLWTlGDWQ2EyGysa9J4p1aJm/bZyTvMiHKlVwkL61HZXv/dGZYlfl74NKZqaTdvxihWh9dq51N+XM=
X-Received: by 2002:a25:b28c:0:b0:dbd:ae7b:fa8 with SMTP id
 k12-20020a25b28c000000b00dbdae7b0fa8mr579074ybj.89.1703088752028; Wed, 20 Dec
 2023 08:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-5-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:11:55 +0100
Message-ID: <CAJaqyWeZK5WmZRnUv4+MF=A1ALsx_OOcWHXDV1EquwpBhTkVJQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 04/15] vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 backend feature
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
> If userland sets this feature, allow it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index da7ec77cdaff..2250fcd90e5b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -749,6 +749,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> +                                BIT_ULL(VHOST_BACKEND_F_CHANGEABLE_VQ_AD=
DR_IN_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> --
> 2.43.0
>


