Return-Path: <linux-kernel+bounces-7301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFD81A531
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237A11F26447
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156146432;
	Wed, 20 Dec 2023 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAPF6p5A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBA41841
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703089984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otTibsUCfMz/7ItOEyfiSpPc/e6QlSfHglq36d1YbNk=;
	b=KAPF6p5Ay007b7Cc4R24BpG+HysFjSRlb2RE0Tc0p7wC50elNRYq9PtADvyaH3kprecLbd
	QBedomuswDUjUP76J+WmHp/KqDQYNKSfbbfEl0ViTQLnT2L0EinL+kMd4hNZi4NB3KnSQj
	wDMlmlfkzF7Y0Psnbu/ROoEIGiNDgQU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-g-D_P319OHKG86HwzA1h2Q-1; Wed, 20 Dec 2023 11:33:02 -0500
X-MC-Unique: g-D_P319OHKG86HwzA1h2Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5deda822167so80482337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089982; x=1703694782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otTibsUCfMz/7ItOEyfiSpPc/e6QlSfHglq36d1YbNk=;
        b=i37/OQmvhj61O79XXMe0rtuMmzsWTYFrgbk+e9yY8fVty/s2N/K4G5U41/Jlz4DO/3
         0GpHkxyejgpLZtMtz7neQcpIq1UDjKnMbISgvWakPvtiBURXIxzbfSHSf8vpsqP3D59d
         kaBYBp7arIdmsD6KarvjHS3EDTVbh0AHOfAqBt/DiP6eNrV/8elC1oQqUKP7XBcy0NjO
         L8XF6sTvSbsPBiBCOjv4/nsN1q2YRKpTqIwyq41FSFqVKJ10AxmbxyoS6IiVsi6rcjwC
         nJFKNIHV7D4TK9sAkaQcWoc+aRPz9YwtT4o21aU6TXjBFMpz217WYiDmnBhj9R2Wg+Ob
         tUyQ==
X-Gm-Message-State: AOJu0YwjjaAsK2KHbLJc78UvUX4JbwqKEECLm9GBpQ2e5gmRwydBpG3u
	4P3SOY04cInlG73vWD1OTntRDZXARHhjtnS7vJsQR3GcZSN4I/OlD6JdJ93/BMMRkA1xQUSaTlw
	W6fEno3vixUXBEZvORsdXfitvCfb9mWYJKxGr2jas
X-Received: by 2002:a5b:c05:0:b0:dbd:a328:1c2f with SMTP id f5-20020a5b0c05000000b00dbda3281c2fmr1023260ybq.41.1703089982181;
        Wed, 20 Dec 2023 08:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxhOo8JZya50yoD++DuZn2aQCcR+4aKP5ovWmXTbl92nbHy9Oe+57z2KJM2qPl/cwWRbY/iOnjD143LPLkDL8=
X-Received: by 2002:a5b:c05:0:b0:dbd:a328:1c2f with SMTP id
 f5-20020a5b0c05000000b00dbda3281c2fmr1023239ybq.41.1703089981874; Wed, 20 Dec
 2023 08:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-9-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-9-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:32:26 +0100
Message-ID: <CAJaqyWfhO532qW+9eWmJqV3JxvvqnB2QZfi1JqUYXPLuiAsggQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 08/15] vdpa: Block vq state change in DRIVER_OK
 unless device supports it
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:10=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Virtqueue state change during DRIVE_OK is not supported by the virtio
> standard. Allow this op in DRIVER_OK only for devices that support
> changing the state during DRIVER_OK if the device is suspended.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6bfa3391935a..77509440c723 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -641,6 +641,9 @@ static bool vhost_vdpa_vq_config_allowed(struct vhost=
_vdpa *v, unsigned int cmd)
>         case VHOST_SET_VRING_ADDR:
>                 feature =3D VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND=
;
>                 break;
> +       case VHOST_SET_VRING_BASE:
> +               feature =3D VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEN=
D;
> +               break;
>         default:
>                 return false;
>         }
> @@ -737,6 +740,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                 break;
>
>         case VHOST_SET_VRING_BASE:
> +               if (!vhost_vdpa_vq_config_allowed(v, cmd))
> +                       return -EOPNOTSUPP;
> +
>                 if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>                         vq_state.packed.last_avail_idx =3D vq->last_avail=
_idx & 0x7fff;
>                         vq_state.packed.last_avail_counter =3D !!(vq->las=
t_avail_idx & 0x8000);
> --
> 2.43.0
>


