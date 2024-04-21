Return-Path: <linux-kernel+bounces-152455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB418ABEB4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FBB1C208BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B6D528;
	Sun, 21 Apr 2024 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="zD1nVjH5"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4B4C70
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713683478; cv=none; b=J7ONMJ8WE1OwvHje+e96Yo7Tp4l5HO5Mpujg7Th1dkzASTH+4f+3Jyo0KQNXb8LgYcp7Qu3mRV9/vyXjgeMsi20TY+4tfVBP2z6bLSHIRW6+Rps6JH9XQLGNb+YjLGphJTkUTbw4+RSol8YyTfEzJ/tpMJbuSCo0sdps9CMJBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713683478; c=relaxed/simple;
	bh=hpljVcSYO34ziTYaWd2ydStOFV7waO606wXlhmUNbBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmGMrTNAYNjIXMOvaYbZFGbS92P+cVxZ8q6hxfgqrX3FKyOFzs+qxLhc8nY1XCXpyZBrDW8t01cTQ7z8hNRR2sgUi2ijtg1YDeGcG+ymyyeRT9L3Au3gmblOqHrkDcrzMkrNzVcyEvsOHMnTxobQfIGXnUjTsWjuywGUPr1inyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=zD1nVjH5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-618874234c9so37331347b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1713683473; x=1714288273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evj6QeiKgaPz6ngMgofjmH590OyUhTsBSPNeTpTFRVY=;
        b=zD1nVjH5QJ83Pa2SvcSO6ZGTQVSd9KMMdbmOSKxQ+rxoMBFHktRFIQsFJnBiKOJ+7f
         Jv87JktmQb1Gbu2UL2r0j15/BKnwgH2mdfZZqXkgm4644ND6zXG3YteG6wWp+cIZLo3w
         v+h8eCUa1K+5aHV/W4QWBt8aXyv9kG0gjcywk/jTexquy5BloeMRtXH3JnjZ+6n3aLBG
         QWj1YI5227YopJfZ7GWv1syMXSIMp5wlffH4jfXWz0BN3fA5N/IX0S0c+Rm8zpIekySo
         /vvM7W8+4VO9kRSJxWipx3cyn87PF9LAoJpF9Q1clirhAD50VRJv1g51vg2dmm2KXiiP
         +U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713683473; x=1714288273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evj6QeiKgaPz6ngMgofjmH590OyUhTsBSPNeTpTFRVY=;
        b=OowKfW4HZqS9/D/GWnk+ZKyO+BAHG6nJWiMgL6L3xj65iK/tV++PaIXELwtb5/RUtg
         0BEbtkfnhiYaMcT1rSHh4XIQP6Cxg4hw8bkkBaafqyPl+76Vj1koqHRzZUvOmwnJ2xsf
         9UnVadPi07POuAX3URDWS2jl41rOBpOUeO5ZRqEH5F5W/fYJbV1zEivvkxcXa484Y9D1
         yPpg/lChWQ8fTMSAD5V9y9qvQ96jjzdVr9FKJAJaX3t0AIRK85tF+8pA5EOHQa2RyFT8
         ZYU7DHEQ8pxlJWvYq4bYERoGzYEzLumESAkTuiaJHujuPSehjY1JhqV2Cv44Q7dvIfI+
         IGWA==
X-Forwarded-Encrypted: i=1; AJvYcCWxur5qH+fVv4oD+RYwGyNsHZefI+4J+IclhxxdKczaavvlE93WFAT41R3rLdqPEWYQqRfQl3FTDzaf7iQH0h7aJQHZaaWCeYFLUbGI
X-Gm-Message-State: AOJu0YxRY8jJ58wIH5LOoRfc86HMLmGhlKfB3qFCpxL7FReFN0AHqtwa
	QcK6HZ+WGNVE3RQhhZl9Jj1ygNGG5PBEy9M6yKvDHJ0y+W0YCYSOClZVOb6LHwMDJAaQZ+bxIwO
	LiZg=
X-Google-Smtp-Source: AGHT+IEnUlpb4XX0/TWzr5rjBLFC1aM0Qt4W4d0AOGqdzVwbJzTbJFqZhbRohs6pYrrP9LQKMSWd0g==
X-Received: by 2002:a05:690c:7209:b0:61b:33b6:41dd with SMTP id jl9-20020a05690c720900b0061b33b641ddmr7144912ywb.37.1713683473128;
        Sun, 21 Apr 2024 00:11:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n7-20020a81af07000000b0061ae4039593sm1511961ywh.19.2024.04.21.00.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 00:11:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de462979e00so3975061276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 00:11:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVijS5FLxPzqQIS+hQDbf/hh84yzTgeUXeuvQ77S5W0wG5PwG0QfAV+DqXardhHSMy1XmhoxFH2XmfG36eGqBmPeEvjhsWjClp0V+Ry
X-Received: by 2002:a25:d354:0:b0:dcb:e0dc:67ee with SMTP id
 e81-20020a25d354000000b00dcbe0dc67eemr6744553ybf.45.1713683471702; Sun, 21
 Apr 2024 00:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420134159.110509-1-christian.gmeiner@gmail.com>
In-Reply-To: <20240420134159.110509-1-christian.gmeiner@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sun, 21 Apr 2024 09:11:00 +0200
X-Gmail-Original-Message-ID: <CAAObsKBT3udZ-=iKRq_ekoxxnmseR_ZH59WvNFzdywWx2E_W3A@mail.gmail.com>
Message-ID: <CAAObsKBT3udZ-=iKRq_ekoxxnmseR_ZH59WvNFzdywWx2E_W3A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/etnaviv: Expose a few more chipspecs to userspace"
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Christian Gmeiner <cgmeiner@igalia.com>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, thanks for doing this, Christian.

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Cheers,

Tomeu

On Sat, Apr 20, 2024 at 3:41=E2=80=AFPM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> From: Christian Gmeiner <cgmeiner@igalia.com>
>
> This reverts commit 1dccdba084897443d116508a8ed71e0ac8a031a4.
>
> In userspace a different approach was choosen - hwdb. As a result, there
> is no need for these values.
>
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 20 ---------------
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 12 ---------
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 34 --------------------------
>  include/uapi/drm/etnaviv_drm.h         |  5 ----
>  4 files changed, 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 734412aae94d..e47e5562535a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -164,26 +164,6 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u=
32 param, u64 *value)
>                 *value =3D gpu->identity.eco_id;
>                 break;
>
> -       case ETNAVIV_PARAM_GPU_NN_CORE_COUNT:
> -               *value =3D gpu->identity.nn_core_count;
> -               break;
> -
> -       case ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE:
> -               *value =3D gpu->identity.nn_mad_per_core;
> -               break;
> -
> -       case ETNAVIV_PARAM_GPU_TP_CORE_COUNT:
> -               *value =3D gpu->identity.tp_core_count;
> -               break;
> -
> -       case ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE:
> -               *value =3D gpu->identity.on_chip_sram_size;
> -               break;
> -
> -       case ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE:
> -               *value =3D gpu->identity.axi_sram_size;
> -               break;
> -
>         default:
>                 DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.h
> index 7d5e9158e13c..197e0037732e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -54,18 +54,6 @@ struct etnaviv_chip_identity {
>         /* Number of Neural Network cores. */
>         u32 nn_core_count;
>
> -       /* Number of MAD units per Neural Network core. */
> -       u32 nn_mad_per_core;
> -
> -       /* Number of Tensor Processing cores. */
> -       u32 tp_core_count;
> -
> -       /* Size in bytes of the SRAM inside the NPU. */
> -       u32 on_chip_sram_size;
> -
> -       /* Size in bytes of the SRAM across the AXI bus. */
> -       u32 axi_sram_size;
> -
>         /* Size of the vertex cache. */
>         u32 vertex_cache_size;
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etn=
aviv/etnaviv_hwdb.c
> index d8e7334de8ce..8665f2658d51 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -17,10 +17,6 @@ static const struct etnaviv_chip_identity etnaviv_chip=
_identities[] =3D {
>                 .thread_count =3D 128,
>                 .shader_core_count =3D 1,
>                 .nn_core_count =3D 0,
> -               .nn_mad_per_core =3D 0,
> -               .tp_core_count =3D 0,
> -               .on_chip_sram_size =3D 0,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 8,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 1,
> @@ -52,11 +48,6 @@ static const struct etnaviv_chip_identity etnaviv_chip=
_identities[] =3D {
>                 .register_max =3D 64,
>                 .thread_count =3D 256,
>                 .shader_core_count =3D 1,
> -               .nn_core_count =3D 0,
> -               .nn_mad_per_core =3D 0,
> -               .tp_core_count =3D 0,
> -               .on_chip_sram_size =3D 0,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 8,
>                 .vertex_output_buffer_size =3D 512,
>                 .pixel_pipes =3D 1,
> @@ -89,10 +80,6 @@ static const struct etnaviv_chip_identity etnaviv_chip=
_identities[] =3D {
>                 .thread_count =3D 512,
>                 .shader_core_count =3D 2,
>                 .nn_core_count =3D 0,
> -               .nn_mad_per_core =3D 0,
> -               .tp_core_count =3D 0,
> -               .on_chip_sram_size =3D 0,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 16,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 1,
> @@ -125,10 +112,6 @@ static const struct etnaviv_chip_identity etnaviv_ch=
ip_identities[] =3D {
>                 .thread_count =3D 512,
>                 .shader_core_count =3D 2,
>                 .nn_core_count =3D 0,
> -               .nn_mad_per_core =3D 0,
> -               .tp_core_count =3D 0,
> -               .on_chip_sram_size =3D 0,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 16,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 1,
> @@ -160,11 +143,6 @@ static const struct etnaviv_chip_identity etnaviv_ch=
ip_identities[] =3D {
>                 .register_max =3D 64,
>                 .thread_count =3D 512,
>                 .shader_core_count =3D 2,
> -               .nn_core_count =3D 0,
> -               .nn_mad_per_core =3D 0,
> -               .tp_core_count =3D 0,
> -               .on_chip_sram_size =3D 0,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 16,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 1,
> @@ -197,10 +175,6 @@ static const struct etnaviv_chip_identity etnaviv_ch=
ip_identities[] =3D {
>                 .thread_count =3D 1024,
>                 .shader_core_count =3D 4,
>                 .nn_core_count =3D 0,
> -               .nn_mad_per_core =3D 0,
> -               .tp_core_count =3D 0,
> -               .on_chip_sram_size =3D 0,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 16,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 2,
> @@ -233,10 +207,6 @@ static const struct etnaviv_chip_identity etnaviv_ch=
ip_identities[] =3D {
>                 .thread_count =3D 256,
>                 .shader_core_count =3D 1,
>                 .nn_core_count =3D 8,
> -               .nn_mad_per_core =3D 64,
> -               .tp_core_count =3D 4,
> -               .on_chip_sram_size =3D 524288,
> -               .axi_sram_size =3D 1048576,
>                 .vertex_cache_size =3D 16,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 1,
> @@ -269,10 +239,6 @@ static const struct etnaviv_chip_identity etnaviv_ch=
ip_identities[] =3D {
>                 .thread_count =3D 256,
>                 .shader_core_count =3D 1,
>                 .nn_core_count =3D 6,
> -               .nn_mad_per_core =3D 64,
> -               .tp_core_count =3D 3,
> -               .on_chip_sram_size =3D 262144,
> -               .axi_sram_size =3D 0,
>                 .vertex_cache_size =3D 16,
>                 .vertex_output_buffer_size =3D 1024,
>                 .pixel_pipes =3D 1,
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_dr=
m.h
> index d87410a8443a..af024d90453d 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -77,11 +77,6 @@ struct drm_etnaviv_timespec {
>  #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
>  #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
>  #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
> -#define ETNAVIV_PARAM_GPU_NN_CORE_COUNT             0x1f
> -#define ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE           0x20
> -#define ETNAVIV_PARAM_GPU_TP_CORE_COUNT             0x21
> -#define ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE         0x22
> -#define ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE             0x23
>
>  #define ETNA_MAX_PIPES 4
>
> --
> 2.44.0
>

