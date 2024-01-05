Return-Path: <linux-kernel+bounces-17677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCA082510F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F8A1C22F4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443F249E9;
	Fri,  5 Jan 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCjKYS6v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39331241F4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704447844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIwLDUnI8NrUa1yoEmDStM8G2YxoAzCn45gUwvCVLMU=;
	b=TCjKYS6v4udY0CyK+KRVnh8KLb2m40C1X61GHXJxHhk/tMIRwHTfSHOSeBKoqancNqZvJE
	6krblsJAaB5X5p/4SXj9vgsYu0KxK18IGGt9aDPU25bvzWmG1wMgyMPBFHOBDLDkqK2WdH
	1h8LQoJvl0wnuvbChryPj5tex083PcY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-4yDRF3ekNrKW7vMRSOkEkg-1; Fri, 05 Jan 2024 04:44:01 -0500
X-MC-Unique: 4yDRF3ekNrKW7vMRSOkEkg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5f1df517cf3so23345177b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447841; x=1705052641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIwLDUnI8NrUa1yoEmDStM8G2YxoAzCn45gUwvCVLMU=;
        b=oRTHdHKpHozQBAeH+rZvD6dWfIM9gDzdMqdwTEL0amZ9isg5y+O9GQ1euwYpy/JR8K
         fY6++AxELWpgzMZXy5TrpdahCadusXxdwcOMxWyKUUMtlECGLYLOw5g+yKFjQ/za5zVX
         QOY89RJDUUQsYib0wSU0OOiRG8WBNt2fjZXTM30ukXMh9Pb/TX4JJEHrseL1ISQjSi9y
         CzR47gGT5SZOwuVBz2EL5ua6+f5bnRealaPHWhNm+MIX24Ms2XY1HwARsyH7Frs31x4g
         FvGa3eUzkDnTPQXuZ1KHcnN66wRwXGIJT/gTyD5mWscMQvizfw5BlKEp8s+7cvhxKTOL
         16lw==
X-Gm-Message-State: AOJu0YxpVfRP5OjWItNnEDdcayc/7KyDpxS1H4Phl2yUwN7ImTeYKo9N
	6peKmsmro7i7Yh8w5G78lXrmSbZ6UYyLwS9c4uzC52ioyXKujyJ+7IzytmcnEOJ3AoNCJY91bsh
	w8IB2Jaj5SZd/s59zRmNWoiocRVSdcM3SCjGKOWHsRTVRld1A
X-Received: by 2002:a0d:c042:0:b0:5ee:26aa:3d4 with SMTP id b63-20020a0dc042000000b005ee26aa03d4mr2038717ywd.43.1704447841434;
        Fri, 05 Jan 2024 01:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdAnA+xpbtbCqAMIEPbTW4gOvzkqFdMNwKSJx2Twyuke/V55aRkeGQnX3n3kmSfq6u7un2p348fwv2H8hb6Zc=
X-Received: by 2002:a0d:c042:0:b0:5ee:26aa:3d4 with SMTP id
 b63-20020a0dc042000000b005ee26aa03d4mr2038711ywd.43.1704447841236; Fri, 05
 Jan 2024 01:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-2-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-2-maxime.coquelin@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Jan 2024 10:43:25 +0100
Message-ID: <CAJaqyWd4UGpzscP=veX3DeyOF2gF6B2crQ6-R_Eo2tncZLgyAg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] vduse: validate block features only with block devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:38=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch is preliminary work to enable network device
> type support to VDUSE.
>
> As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
> VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
> to Virtio-blk device type.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0ddd4b8abecb..0486ff672408 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1671,13 +1671,14 @@ static bool device_is_allowed(u32 device_id)
>         return false;
>  }
>
> -static bool features_is_valid(u64 features)
> +static bool features_is_valid(struct vduse_dev_config *config)
>  {
> -       if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> +       if (!(config->features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>                 return false;
>
>         /* Now we only support read-only configuration space */
> -       if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
> +       if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> +                       (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
>
>         return true;
> @@ -1704,7 +1705,7 @@ static bool vduse_validate_config(struct vduse_dev_=
config *config)
>         if (!device_is_allowed(config->device_id))
>                 return false;
>
> -       if (!features_is_valid(config->features))
> +       if (!features_is_valid(config))
>                 return false;
>
>         return true;
> --
> 2.43.0
>
>


