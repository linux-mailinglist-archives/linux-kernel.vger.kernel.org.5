Return-Path: <linux-kernel+bounces-7263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D585981A401
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2FB22B54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7C46422;
	Wed, 20 Dec 2023 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwf+3d/j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEB46438
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBF/2A/nktRQkyV9wK9FTmKMlXm8fHaSo0cgylBofKE=;
	b=dwf+3d/jQ0gZAQfowE5Txei7sRqtLmPL2bURIda2ktHYAToZNHj8Nps5eAPJciQ8r/EwPM
	eFf6NFgsp1Jg4L4T1x2jJJwmXTjZtGIYZREBnt6gTnPvhAYvXO5YhUUuQ2s4wkTShsg4zZ
	3vbUcQLz14zEq85vUOurFUxn2RdRgFE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-h3_P7uJbMBS2Lzi_hkiH3A-1; Wed, 20 Dec 2023 11:10:01 -0500
X-MC-Unique: h3_P7uJbMBS2Lzi_hkiH3A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5deda822167so80033177b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088601; x=1703693401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBF/2A/nktRQkyV9wK9FTmKMlXm8fHaSo0cgylBofKE=;
        b=cG8yfeXy4qZJBGwr3F3m0oE2A/p7FcbT0Ui1o2TitLlkCUofqU0/PzR91qpxJrb6Vd
         8cVzYpp6CWi7WImIMME5gPPfb4VSpM7s9fl33gHOLh4bBGiwpAIbAjAv7uiwUbutSoeg
         W49pE/eO0qH5zPGEk8NBKK79yWZT+2Y5QopPxsXvP2XPQb+9U3QXs04AT3nedfBOlz4/
         r5VbstM9RbldKlBdcg30Ekp5oHvYpnJhEqLUIhwsQ2QZyN/A+qs2J6eCx5EqFkEqJH/y
         bCdeDdoUjSrkIcsKoHA7nNqjZwpP4RVkUN+6Y2GXKQdxYGgoDQiLckwztkGjIQClHI0V
         xVqQ==
X-Gm-Message-State: AOJu0YzaO6ohTpFKk8tiOsHWErcs1xm7rEUk5wdRWEACdaB3FzsFAADu
	+8UWXWmFCgjISp4Ldq2G1SKEvkDtXbiD4ennqRRMA/BKhPfw5cbwg64biVm9IwiIUWTO8bYT4Qf
	s4xbItliJsF2WqJ8bvUbuoNshCg28THKNFdkpyf34
X-Received: by 2002:a81:4ec9:0:b0:5e5:ebd3:b1dd with SMTP id c192-20020a814ec9000000b005e5ebd3b1ddmr4627328ywb.10.1703088601331;
        Wed, 20 Dec 2023 08:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+IU3w6JnHUfVUtttpnXPZjgZ7nb7xBxPxfi9miRXjvISa+OseECRxvd3Zk1HEe8rGhYPjUps3bz6+ROD1cps=
X-Received: by 2002:a81:4ec9:0:b0:5e5:ebd3:b1dd with SMTP id
 c192-20020a814ec9000000b005e5ebd3b1ddmr4627306ywb.10.1703088601106; Wed, 20
 Dec 2023 08:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:09:24 +0100
Message-ID: <CAJaqyWeOJSne+qfj1pq_bgzML2Hc49MBCQm735fqrRThkeJAyQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
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
> The virtio spec doesn't allow changing virtqueue addresses after
> DRIVER_OK. Some devices do support this operation when the device is
> suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
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
> index d7656908f730..aacd067afc89 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -192,5 +192,9 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>  /* IOTLB don't flush memory mapping across device reset */
>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
> +/* Device supports changing virtqueue addresses when device is suspended
> + * and is in state DRIVER_OK.
> + */
> +#define VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND  0x9
>

If we go by feature flag,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  #endif
> --
> 2.43.0
>


