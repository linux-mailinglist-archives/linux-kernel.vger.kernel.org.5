Return-Path: <linux-kernel+bounces-2945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4B81650C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D6B21A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC05398;
	Mon, 18 Dec 2023 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC7PTVVz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74C5225
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a23566e91d5so56132466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702867837; x=1703472637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plG12lSDyDuxlkDPtZnEjC2S6Qb2QVgjcs0gVM2j3dA=;
        b=KC7PTVVzZfu4925ddiZ69Z8EH3sZodROm004/aUaEXyVU3hNraGw9Y0fZ3v4c45ZAP
         lO3vVeo2DdiL+XnsdZkdzMXEl2/pzo28bgxk4ZmI9VWMpI3bnbrJUcd26WvXP8mDpVEA
         /oc4ff5X4TX+QrxLmaWGVBNB2ATko0/Iay1Sop74KHCpjJb/TxB6uXEAFKGZcZPL1GSF
         XcDVfehwokLFS1MCv5ZEaoZYr79LdEybJk0Tm8YXDRqrAhQOh6HsLT0Jp/x0qPeYHVO6
         y1yHJj2U5Fh33TuCymqvdF2wzi8VFk+aSnthvBbho0m40zMGBdlImkq/1/xx8f00AFEA
         cTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867837; x=1703472637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plG12lSDyDuxlkDPtZnEjC2S6Qb2QVgjcs0gVM2j3dA=;
        b=qRyMlRCuY8KS8PenCMCCK+xKGdMH4FiZcevl+k1elX5fFIBYKeAY4n7onaVofG8clN
         4TbXr3w7urIqNYefjNJfVkHj31f527/gBc+MVujavk6T0MHlaAbKZQmQExddU7aREShj
         Rto+E8/4iLQuIq5DKDBaIANH13945HkBj8dRqLicqvRxk/8+bZT+/ZlLEz0y1PrVJ8Xh
         /I3XjnXsmlIqgUaXyQLCF1fB7xXE57nP7PQL3HMsplV6KS+yxucE04AqsCHz7J9vWR+f
         wNk5X34gOUcvoaUttIPaMZIWRmN47n41uOtQCAWo/u6ixb1QeTR26m7DJuoeheX1lYyw
         j3Wg==
X-Gm-Message-State: AOJu0YxrOaXcTDuQvxyHVPUk4fH0vMREk/GOEU5QsHvspoYRh23naVsh
	P3uBbaRD8V9iDJmtQfAt5XrgL2TqMzn/nLJLB0Y=
X-Google-Smtp-Source: AGHT+IH3xTMpI6k/TuR+4b7fRy5zESV+Xlb4WnWxoLaqeTU9NjWTCyg/XMD9Un9QrZLQlht2/pzqYpmHGop0f1/gqoU=
X-Received: by 2002:a17:907:c9a2:b0:a23:3629:f7b9 with SMTP id
 uj34-20020a170907c9a200b00a233629f7b9mr493431ejc.90.1702867836730; Sun, 17
 Dec 2023 18:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214091215.2435-1-alban.browaeys@gmail.com>
In-Reply-To: <20231214091215.2435-1-alban.browaeys@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 18 Dec 2023 10:50:24 +0800
Message-ID: <CAKGbVbtkN+asaDWUs4WKqtjXg6iX40Dgk4cy50ysJ5TrnPGY5A@mail.gmail.com>
Subject: Re: [PATCH] RFC: drm/lima: fix calling drm_mm_init with an empty range
To: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix. It could be done in a simpler way that swap the
va_start/va_end init/fini and empty_vm create/release.

On Thu, Dec 14, 2023 at 5:04=E2=80=AFPM Alban Browaeys <alban.browaeys@gmai=
l.com> wrote:
>
> For the empty_vm initialization the range is empty which is not supported
> by drm_mm_init.
>
> With CONFIG_DRM_DEBUG_MM set, I get:
> ------------[ cut here ]------------
>  kernel BUG at drivers/gpu/drm/drm_mm.c:965!
>  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>  Modules linked in: lima(+) drm_shmem_helper gpu_sched s5p_jpeg s5p_g2d
>  videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2
>  videobuf2_common s5p_cec tun fuse configfs auth_rpcgss sunrpc ip_tables
>  x_tables autofs4 btrfs lzo_compress zlib_deflate raid10 raid456
>  async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon
>  raid6_pq libcrc32c raid1 raid0 linear md_mod dm_mirror dm_region_hash
>  dm_log hid_logitech_hidpp hid_logitech_dj
>  CPU: 0 PID: 1033 Comm: systemd-udevd Not tainted 6.4.0-rc1-debug+ #230
>  Hardware name: Samsung Exynos (Flattened Device Tree)
>  PC is at drm_mm_init+0x94/0x98
>  LR is at 0x0
>  Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>   drm_mm_init from lima_vm_create+0xcc/0x108 [lima]
>   lima_vm_create [lima] from lima_device_init+0xd8/0x4a0 [lima]
>   lima_device_init [lima] from lima_pdev_probe.part.0+0x6c/0x158 [lima]
>   lima_pdev_probe.part.0 [lima] from platform_probe+0x64/0xc0
>   platform_probe from call_driver_probe+0x2c/0x110
>
> The drm_mm.c line 965 is:
> drivers/gpu/drm/drm_mm.c
> void drm_mm_init(struct drm_mm *mm, u64 start, u64 size)
> {
>         DRM_MM_BUG_ON(start + size <=3D start);
>
> lima_vm_create is called with va_start and va_end both unset
> in lima_device_init line 371:
> ldev->empty_vm =3D lima_vm_create(ldev);
>
> Signed-off-by: Alban Browaeys <alban.browaeys@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_device.c |  2 +-
>  drivers/gpu/drm/lima/lima_drv.c    |  2 +-
>  drivers/gpu/drm/lima/lima_vm.c     | 10 +++++++---
>  drivers/gpu/drm/lima/lima_vm.h     |  3 ++-
>  4 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/li=
ma_device.c
> index 02cef0cea657..bd3afff0f44a 100644
> --- a/drivers/gpu/drm/lima/lima_device.c
> +++ b/drivers/gpu/drm/lima/lima_device.c
> @@ -368,7 +368,7 @@ int lima_device_init(struct lima_device *ldev)
>         if (err)
>                 goto err_out0;
>
> -       ldev->empty_vm =3D lima_vm_create(ldev);
> +       ldev->empty_vm =3D lima_vm_create(ldev, false);
>         if (!ldev->empty_vm) {
>                 err =3D -ENOMEM;
>                 goto err_out1;
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_=
drv.c
> index 10fd9154cc46..ca09142e0ac1 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -219,7 +219,7 @@ static int lima_drm_driver_open(struct drm_device *de=
v, struct drm_file *file)
>         if (!priv)
>                 return -ENOMEM;
>
> -       priv->vm =3D lima_vm_create(ldev);
> +       priv->vm =3D lima_vm_create(ldev, true);
>         if (!priv->vm) {
>                 err =3D -ENOMEM;
>                 goto err_out0;
> diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_v=
m.c
> index 2b2739adc7f5..7f9775eefd78 100644
> --- a/drivers/gpu/drm/lima/lima_vm.c
> +++ b/drivers/gpu/drm/lima/lima_vm.c
> @@ -197,7 +197,7 @@ u32 lima_vm_get_va(struct lima_vm *vm, struct lima_bo=
 *bo)
>         return ret;
>  }
>
> -struct lima_vm *lima_vm_create(struct lima_device *dev)
> +struct lima_vm *lima_vm_create(struct lima_device *dev, bool has_drm_mm)
>  {
>         struct lima_vm *vm;
>
> @@ -221,7 +221,10 @@ struct lima_vm *lima_vm_create(struct lima_device *d=
ev)
>                         goto err_out1;
>         }
>
> -       drm_mm_init(&vm->mm, dev->va_start, dev->va_end - dev->va_start);
> +       if (has_drm_mm) {
> +               vm->has_drm_mm =3D true;
> +               drm_mm_init(&vm->mm, dev->va_start, dev->va_end - dev->va=
_start);
> +       }
>
>         return vm;
>
> @@ -237,7 +240,8 @@ void lima_vm_release(struct kref *kref)
>         struct lima_vm *vm =3D container_of(kref, struct lima_vm, refcoun=
t);
>         int i;
>
> -       drm_mm_takedown(&vm->mm);
> +       if (vm->has_drm_mm)
> +               drm_mm_takedown(&vm->mm);
>
>         for (i =3D 0; i < LIMA_VM_NUM_BT; i++) {
>                 if (vm->bts[i].cpu)
> diff --git a/drivers/gpu/drm/lima/lima_vm.h b/drivers/gpu/drm/lima/lima_v=
m.h
> index 3a7c74822d8b..e7443f410d6d 100644
> --- a/drivers/gpu/drm/lima/lima_vm.h
> +++ b/drivers/gpu/drm/lima/lima_vm.h
> @@ -30,6 +30,7 @@ struct lima_vm {
>         struct mutex lock;
>         struct kref refcount;
>
> +       bool has_drm_mm;
>         struct drm_mm mm;
>
>         struct lima_device *dev;
> @@ -43,7 +44,7 @@ void lima_vm_bo_del(struct lima_vm *vm, struct lima_bo =
*bo);
>
>  u32 lima_vm_get_va(struct lima_vm *vm, struct lima_bo *bo);
>
> -struct lima_vm *lima_vm_create(struct lima_device *dev);
> +struct lima_vm *lima_vm_create(struct lima_device *dev, bool has_drm_mm)=
;
>  void lima_vm_release(struct kref *kref);
>
>  static inline struct lima_vm *lima_vm_get(struct lima_vm *vm)
> --
> 2.39.2
>

