Return-Path: <linux-kernel+bounces-7052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52C81A102
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C148A1C21134
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7338F93;
	Wed, 20 Dec 2023 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isE/ABml"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A138F89
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-336755f1688so1480112f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703082105; x=1703686905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxbXEbSocFDzoaHH/J7pkiKajtGxggwex6rm+kId5JA=;
        b=isE/ABmlhwNh7qIAuylNmlZ4R626Ka8/nxJQ7RGIsX2z/CF4WxneUfPur0nADasLu5
         GM52aN/1LFr+94T+rD6xcf07cI/P5wohkpaBQN8/iFXYTLCED0/lXhjNo18twUUMCthX
         S4bvP0B2Fk8sWFQWpeEzHeUrIRy0JqJynElVs6xRd3/AmPWNEI5pnQZ7+DurJnbUcvOJ
         q3Sqpy5TqWkNS0wJ+R6SjLHhSWJgXugGQW59osqT+2iJafHefBfrJbe0bwxDQa0NWDlF
         nAJleXrsrQ55dClMqOT+/IRvw9WwXZla6iDefeeRzeKA68USDP9/W4KUs1VhDRbdGR2Q
         KUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703082105; x=1703686905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxbXEbSocFDzoaHH/J7pkiKajtGxggwex6rm+kId5JA=;
        b=hmF5uE2dbw0soMnVTQiaz7b+xBfYpc0AxLZfROrrnvFY0fgObvyJCygSmrNp3Fi2l0
         /1zWzoOuMs1BHJChWkQC5CG8MKH000q/dLstK1gwri/L2whUcOxMUnu1muKBHXQCzCHU
         dXQjKWEoziHyXWXaaSEBMt4zHYyd9t3MRPvX0IYLWRWDFBQGwTEEcXmFJvoQKdgHRDtq
         paHhPApV6d5oqJOb+aNwMizuMzwgYhAGhurc1w/gXS9+xfE4gwPEkCyJDBxUoX7JFQwV
         Oq4EtEu85WVo7O3Ed9YmPP40Y772iDlo4D37fFFtMhmiaMs7xOefYoPum0vomYKUg4RO
         s8IA==
X-Gm-Message-State: AOJu0YzBJpKvTAkK6ssqPDaFufgKjmslNoLplgdGoyeH1Wtk/WjDESh8
	q3S+gSZKzEvd2mPMQ73K+3E=
X-Google-Smtp-Source: AGHT+IE1Txlhb6IqpE2VMlGD9cEZkAwPfqJOHX9qCWv76vm9q4yNOmfxYyUCxyFVFxcY5KEhintABg==
X-Received: by 2002:adf:ee4a:0:b0:336:5f35:f4b0 with SMTP id w10-20020adfee4a000000b003365f35f4b0mr3596478wro.26.1703082104255;
        Wed, 20 Dec 2023 06:21:44 -0800 (PST)
Received: from hermes.prahal.homelinux.net (91-175-163-178.subs.proxad.net. [91.175.163.178])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b0033677a4e0d6sm2701998wrp.13.2023.12.20.06.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:21:43 -0800 (PST)
Message-ID: <857e5eeada6720b0cbcb8a28bb7619eca69a8c72.camel@gmail.com>
Subject: Re: [PATCH] RFC: drm/lima: fix calling drm_mm_init with an empty
 range
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Qiang Yu <yuq825@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 20 Dec 2023 15:21:42 +0100
In-Reply-To: <CAKGbVbtkN+asaDWUs4WKqtjXg6iX40Dgk4cy50ysJ5TrnPGY5A@mail.gmail.com>
References: <20231214091215.2435-1-alban.browaeys@gmail.com>
	 <CAKGbVbtkN+asaDWUs4WKqtjXg6iX40Dgk4cy50ysJ5TrnPGY5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 18 d=C3=A9cembre 2023 =C3=A0 10:50 +0800, Qiang Yu a =C3=A9crit=C2=
=A0:
> Thanks for the fix. It could be done in a simpler way that swap the
> va_start/va_end init/fini and empty_vm create/release.

The thing is I do not get what you suggest by swaping :-/

Do you mean I should check for "dev->va_end - dev->va_start"  not to be
zero instead of passing a boolean and setting a flag on the structure?

PS: This was an RFC to raise the issue, that would be fine to me if you
take it further.


Alban

> On Thu, Dec 14, 2023 at 5:04=E2=80=AFPM Alban Browaeys
> <alban.browaeys@gmail.com> wrote:
> >=20
> > For the empty_vm initialization the range is empty which is not
> > supported
> > by drm_mm_init.
> >=20
> > With CONFIG_DRM_DEBUG_MM set, I get:
> > ------------[ cut here ]------------
> > =C2=A0kernel BUG at drivers/gpu/drm/drm_mm.c:965!
> > =C2=A0Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > =C2=A0Modules linked in: lima(+) drm_shmem_helper gpu_sched s5p_jpeg
> > s5p_g2d
> > =C2=A0videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2
> > =C2=A0videobuf2_common s5p_cec tun fuse configfs auth_rpcgss sunrpc
> > ip_tables
> > =C2=A0x_tables autofs4 btrfs lzo_compress zlib_deflate raid10 raid456
> > =C2=A0async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> > xor_neon
> > =C2=A0raid6_pq libcrc32c raid1 raid0 linear md_mod dm_mirror
> > dm_region_hash
> > =C2=A0dm_log hid_logitech_hidpp hid_logitech_dj
> > =C2=A0CPU: 0 PID: 1033 Comm: systemd-udevd Not tainted 6.4.0-rc1-debug+
> > #230
> > =C2=A0Hardware name: Samsung Exynos (Flattened Device Tree)
> > =C2=A0PC is at drm_mm_init+0x94/0x98
> > =C2=A0LR is at 0x0
> > =C2=A0Flags: nZCv=C2=A0 IRQs on=C2=A0 FIQs off=C2=A0 Mode SVC_32=C2=A0 =
ISA ARM=C2=A0 Segment none
> > =C2=A0 drm_mm_init from lima_vm_create+0xcc/0x108 [lima]
> > =C2=A0 lima_vm_create [lima] from lima_device_init+0xd8/0x4a0 [lima]
> > =C2=A0 lima_device_init [lima] from lima_pdev_probe.part.0+0x6c/0x158
> > [lima]
> > =C2=A0 lima_pdev_probe.part.0 [lima] from platform_probe+0x64/0xc0
> > =C2=A0 platform_probe from call_driver_probe+0x2c/0x110
> >=20
> > The drm_mm.c line 965 is:
> > drivers/gpu/drm/drm_mm.c
> > void drm_mm_init(struct drm_mm *mm, u64 start, u64 size)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_MM_BUG_ON(start + size <=
=3D start);
> >=20
> > lima_vm_create is called with va_start and va_end both unset
> > in lima_device_init line 371:
> > ldev->empty_vm =3D lima_vm_create(ldev);
> >=20
> > Signed-off-by: Alban Browaeys <alban.browaeys@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/lima/lima_device.c |=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/lima/lima_drv.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/lima/lima_vm.c=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++=
++---
> > =C2=A0drivers/gpu/drm/lima/lima_vm.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 =
++-
> > =C2=A04 files changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/lima/lima_device.c
> > b/drivers/gpu/drm/lima/lima_device.c
> > index 02cef0cea657..bd3afff0f44a 100644
> > --- a/drivers/gpu/drm/lima/lima_device.c
> > +++ b/drivers/gpu/drm/lima/lima_device.c
> > @@ -368,7 +368,7 @@ int lima_device_init(struct lima_device *ldev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err_out0;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldev->empty_vm =3D lima_vm_create=
(ldev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldev->empty_vm =3D lima_vm_create=
(ldev, false);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ldev->empty_vm) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err_out1;
> > diff --git a/drivers/gpu/drm/lima/lima_drv.c
> > b/drivers/gpu/drm/lima/lima_drv.c
> > index 10fd9154cc46..ca09142e0ac1 100644
> > --- a/drivers/gpu/drm/lima/lima_drv.c
> > +++ b/drivers/gpu/drm/lima/lima_drv.c
> > @@ -219,7 +219,7 @@ static int lima_drm_driver_open(struct
> > drm_device *dev, struct drm_file *file)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!priv)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->vm =3D lima_vm_create(ldev)=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->vm =3D lima_vm_create(ldev,=
 true);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!priv->vm) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err_out0;
> > diff --git a/drivers/gpu/drm/lima/lima_vm.c
> > b/drivers/gpu/drm/lima/lima_vm.c
> > index 2b2739adc7f5..7f9775eefd78 100644
> > --- a/drivers/gpu/drm/lima/lima_vm.c
> > +++ b/drivers/gpu/drm/lima/lima_vm.c
> > @@ -197,7 +197,7 @@ u32 lima_vm_get_va(struct lima_vm *vm, struct
> > lima_bo *bo)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > =C2=A0}
> >=20
> > -struct lima_vm *lima_vm_create(struct lima_device *dev)
> > +struct lima_vm *lima_vm_create(struct lima_device *dev, bool
> > has_drm_mm)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct lima_vm *vm;
> >=20
> > @@ -221,7 +221,10 @@ struct lima_vm *lima_vm_create(struct
> > lima_device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
err_out1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_mm_init(&vm->mm, dev->va_star=
t, dev->va_end - dev-
> > >va_start);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (has_drm_mm) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vm->has_drm_mm =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 drm_mm_init(&vm->mm, dev->va_start, dev->va_end -
> > dev->va_start);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vm;
> >=20
> > @@ -237,7 +240,8 @@ void lima_vm_release(struct kref *kref)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct lima_vm *vm =3D conta=
iner_of(kref, struct lima_vm,
> > refcount);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_mm_takedown(&vm->mm);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vm->has_drm_mm)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 drm_mm_takedown(&vm->mm);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < LIMA_VM_NU=
M_BT; i++) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (vm->bts[i].cpu)
> > diff --git a/drivers/gpu/drm/lima/lima_vm.h
> > b/drivers/gpu/drm/lima/lima_vm.h
> > index 3a7c74822d8b..e7443f410d6d 100644
> > --- a/drivers/gpu/drm/lima/lima_vm.h
> > +++ b/drivers/gpu/drm/lima/lima_vm.h
> > @@ -30,6 +30,7 @@ struct lima_vm {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kref refcount;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_drm_mm;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_mm mm;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct lima_device *dev;
> > @@ -43,7 +44,7 @@ void lima_vm_bo_del(struct lima_vm *vm, struct
> > lima_bo *bo);
> >=20
> > =C2=A0u32 lima_vm_get_va(struct lima_vm *vm, struct lima_bo *bo);
> >=20
> > -struct lima_vm *lima_vm_create(struct lima_device *dev);
> > +struct lima_vm *lima_vm_create(struct lima_device *dev, bool
> > has_drm_mm);
> > =C2=A0void lima_vm_release(struct kref *kref);
> >=20
> > =C2=A0static inline struct lima_vm *lima_vm_get(struct lima_vm *vm)
> > --
> > 2.39.2
> >=20


