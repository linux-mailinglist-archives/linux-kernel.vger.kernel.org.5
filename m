Return-Path: <linux-kernel+bounces-28947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3254B830505
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54EB1F25753
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4F1DFE2;
	Wed, 17 Jan 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnYWH0QE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1B1DFC7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493666; cv=none; b=NjY7En/vLve/3tF64ucfCTROYdgxNHqBf0Uq9ZmuQBGEwYRJDl4QT/g1l/mJHfVu00J/PJk8ktyvpAPqIRNQM6197bYs/PgWS2fAHdSPAiPGau0Ljsp/FW1fZgPhJwXb+dZnDqsqXqShaO+gcL/pLGiIStEB7lSRb4+M1Kb1R5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493666; c=relaxed/simple;
	bh=9hVK2zsyhbMNgnba9kHodPE2CXCC6M2YOk6Fqce5lfg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=OgnYVsO0xXMY8eSHi+o6EMEFZSQQHnZDLYQturnB47E9M/x4CyS9r2D7+Dxpol/t6s9X0thfYupZWLHSVgf/4unfNihs3sFWx1FircOSuKIfx8o3d91QkL+Pucv5OY0gOK9fxtWwEKrMo7pZocPrf1+cfvG7vmc7AX4ZV9pFAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnYWH0QE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ec948ad31so10985677e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705493661; x=1706098461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3cnt7gyC+lpqdMXbg30DVvgkbh9UK/R9kQWe9GwuLk=;
        b=cnYWH0QEUgdlZrEZwIS+pmOhyRnj05cta0+x1W/69HKy0B0VWFKyk7Gjd8XuzUDtnq
         gn8pbkVblLrgPN95ajW1fFG+wA7S7ijF5xSVR/Ob0+efzaD5A7YlYmDm0wOFwY31QHgk
         opyZ7DPeK09q2C2OaAmrLuywinY/fetfW8a0pAqjOt9FTNrM1gA+O2HZz5lt2+j1Cber
         h9GMPekEpkySmAlxL/ddJYtdD75qky5Uxoou7h/W2D19paAmenmGvZ9l8Dr4MEWojG/m
         Mup3w/P50wqifsWnuginuOUEzWEW47o2GSrTUE/nxrbpOQcnnsjzn4RBdwjhGc8mZrPA
         HU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705493661; x=1706098461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3cnt7gyC+lpqdMXbg30DVvgkbh9UK/R9kQWe9GwuLk=;
        b=P3Tjs5tCGFK7fYU+8EFuGWlY3hz89zNu3Ak9hli66TQo2rKHw0FkfzMM+xQMwyfYJO
         frRVlPMks9q92D2IgGyWpX5TQ/BFx2wRmVGzRF9piDQRv+P8V4XI1ycRXCutPWNfYiFr
         JgKddbnRVkBmoQGVpr7qDhrbgloYByUX4tR+O0swDCWoLn6fQhE1V9RAoLuzkZo2zKaT
         XXRFjQg0RXMUBksmPO59Xg0D6MocH6c+bD/Jq8Gd04xmgibk/z1FbxrrKP9VEnzPchg1
         +YLY9uYNFMpr2TijmI1lFBjuSTI55iAw44CZ1xeDAzcDZ3kSSAslmY5QfSfqTohpCZay
         hVFA==
X-Gm-Message-State: AOJu0YwZ6ZyeQQAPYMT0I1g9RXiphk1r0yLOUTU3mhlVEJWnVyVlFriq
	Jezor1DZjk3djfkUoKs+uFSG0zN0adVqeyd808I=
X-Google-Smtp-Source: AGHT+IEZIui8gp91ARMAjRQ8QVaPafjM7rs6iZolQcaT2PPkHja/tMyc/Y0UlszOpLc1VLVkvpOR1DwVIQs/UrmndpM=
X-Received: by 2002:a05:6512:2201:b0:50e:53bc:3f9b with SMTP id
 h1-20020a056512220100b0050e53bc3f9bmr5144540lfu.113.1705493661288; Wed, 17
 Jan 2024 04:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117071328.3811480-1-alexious@zju.edu.cn>
In-Reply-To: <20240117071328.3811480-1-alexious@zju.edu.cn>
From: Qiang Yu <yuq825@gmail.com>
Date: Wed, 17 Jan 2024 20:14:08 +0800
Message-ID: <CAKGbVbuEyKaeZbvU-SREQkto5AqdQo-wjx=cjf2Sx3eDCnah+Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/lima: fix a memleak in lima_heap_alloc
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Wed, Jan 17, 2024 at 3:14=E2=80=AFPM Zhipeng Lu <alexious@zju.edu.cn> wr=
ote:
>
> When lima_vm_map_bo fails, the resources need to be deallocated, or
> there will be memleaks.
>
> Fixes: 6aebc51d7aef ("drm/lima: support heap buffer creation")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
>
> v2: rearrange the error-handling to ladder tags.
> ---
>  drivers/gpu/drm/lima/lima_gem.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_=
gem.c
> index 4f9736e5f929..d3d82ee7fb4c 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -75,29 +75,36 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_v=
m *vm)
>         } else {
>                 bo->base.sgt =3D kmalloc(sizeof(*bo->base.sgt), GFP_KERNE=
L);
>                 if (!bo->base.sgt) {
> -                       sg_free_table(&sgt);
> -                       return -ENOMEM;
> +                       ret =3D -ENOMEM;
> +                       goto err_out0;
>                 }
>         }
>
>         ret =3D dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
>         if (ret) {
> -               sg_free_table(&sgt);
> -               kfree(bo->base.sgt);
> -               bo->base.sgt =3D NULL;
> -               return ret;
> +               goto err_out1;
>         }
>
>         *bo->base.sgt =3D sgt;
>
>         if (vm) {
>                 ret =3D lima_vm_map_bo(vm, bo, old_size >> PAGE_SHIFT);
> -               if (ret)
> -                       return ret;
> +               if (ret) {
> +                       goto err_out2;
> +               }
>         }
>
>         bo->heap_size =3D new_size;
>         return 0;
> +
> +err_out2:
> +       dma_unmap_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
> +err_out1:
> +       kfree(bo->base.sgt);
> +       bo->base.sgt =3D NULL;
> +err_out0:
> +       sg_free_table(&sgt);
> +       return ret;
>  }
>
>  int lima_gem_create_handle(struct drm_device *dev, struct drm_file *file=
,
> --
> 2.34.1
>

