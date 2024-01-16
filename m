Return-Path: <linux-kernel+bounces-26906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087C82E7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE6C1C22CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBA79F6;
	Tue, 16 Jan 2024 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ1/Ogje"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5379C0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28ab7ae504so883200066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705368292; x=1705973092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW8IeT94sqxk9dJoctrT0QMHmgttzl2Wny6AX+IZ+rw=;
        b=LJ1/OgjeHUsnuudCGG9EbzhhbSP5dlROs9gcnVeAfBPiAJsUI+L1PwqPz5UwcfjyH9
         pQzBs9C/eLOKLycVIyFtGS1WgwgkprdgicwHIIdpXjnV/wBQtFB+ZRDcFNHyUKBA/FRG
         3sRps7LB3bZzLagUW9ITkyL50SErX9nUaRQ3KBpGDlHzWo/YZgoKUvo1/5D1KdOe/OmA
         BVjfK95qHHettH+KrNHeokHpyE1Tvu+BmPDFwhywlv+lxG4aGc4EDIy2gGPU6HCUrbqV
         ENt5eJpkgVdntQuREH4L7Nor4GpD4Br6M/pC9C/KfeD4WQPG6npKrfso58oiHa7+OBun
         jnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705368292; x=1705973092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW8IeT94sqxk9dJoctrT0QMHmgttzl2Wny6AX+IZ+rw=;
        b=Sr/a3TH+Rn75S8Xwy4OglGZpUqka9WviDHcY8sooMoGlrftITFdWy+JVNGukAcA0dK
         OfK1LqRyj8BJZtnFNUit8eiCgWkReG/unzffQhVvozJIaQrkUdsPBzrR4JWQ0CaDZtUV
         vL10/79yBnO2Qm9uLqUPPFon+wLKxMbKN9UFGiTO6X9OVlT/JFWKp2BcsoDjoDtNddRI
         iL1D62gomJy6wk9P+Bqi+yrJbdntcsXxRN+K07jZyagemFhIMm0qZQpJanP2RRlpSUIW
         6BpYq8PnEYZzWYD8sTvzQfx3nrm4FeQjiwZM/Zk/Q4ycQgWUQQMpkm681igUpaLqfNBK
         3Mvg==
X-Gm-Message-State: AOJu0Ywj16jK9BDi9enszML17TyMT5hqHlxcwwpBswrRUhmfW/ahOQXA
	41zd4F7n4iA3JvoBk8qpKh0CK1VnnH5ODx203mU=
X-Google-Smtp-Source: AGHT+IE7foSY+Dx2N5bmgzzoWLNyF/v3T+JuHVyumUdu2biAyJgYRltBRPWbCD/dA9o3J15XrHunE5FfBHCNomI2V2Y=
X-Received: by 2002:a17:906:c058:b0:a27:b278:b3e with SMTP id
 bm24-20020a170906c05800b00a27b2780b3emr2593812ejb.83.1705368292224; Mon, 15
 Jan 2024 17:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112084750.3729837-1-alexious@zju.edu.cn>
In-Reply-To: <20240112084750.3729837-1-alexious@zju.edu.cn>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 16 Jan 2024 09:24:37 +0800
Message-ID: <CAKGbVbswTUYJsZDLWao58MTyt7yAYMMXA5zjeYVBTRvd9X3n0g@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: fix a memleak in lima_heap_alloc
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix. As the error handling gets longer and duplicated,
could you rearrange them like the lima_gem_submit():
err_out2:
    dma_unmap_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
err_out1:
    kfree(bo->base.sgt);
    bo->base.sgt =3D NULL;
err_out0:
    sg_free_table(&sgt);
    return ret.

Regards,
Qiang

On Fri, Jan 12, 2024 at 4:49=E2=80=AFPM Zhipeng Lu <alexious@zju.edu.cn> wr=
ote:
>
> When lima_vm_map_bo fails, the resources need to be deallocated, or
> there will be memleaks.
>
> Fixes: 6aebc51d7aef ("drm/lima: support heap buffer creation")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/gpu/drm/lima/lima_gem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_=
gem.c
> index 4f9736e5f929..824ed22141c7 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -92,8 +92,13 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm=
 *vm)
>
>         if (vm) {
>                 ret =3D lima_vm_map_bo(vm, bo, old_size >> PAGE_SHIFT);
> -               if (ret)
> +               if (ret) {
> +                       dma_unmap_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0=
);
> +                       sg_free_table(&sgt);
> +                       kfree(bo->base.sgt);
> +                       bo->base.sgt =3D NULL;
>                         return ret;
> +               }
>         }
>
>         bo->heap_size =3D new_size;
> --
> 2.34.1
>

