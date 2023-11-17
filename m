Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8A7EEDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbjKQIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345715AbjKQIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:51:17 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188891A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:51:14 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ea98ad294cso784497fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700211073; x=1700815873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BMjYq8KIiIVaTPNF6OfRzBg75TE8YFMdh3udmnKItcQ=;
        b=J+XqX4JmLZvHTpQOD2tNHYQHlS7BnakQyROnhs3SLKMPD+6HjVsio5p/kJj/xBVlIt
         /U8v2dHJGnm3Rh7GAc2R835me3LsnYd7+zYxPbWrGD/ocDrGqqruc0q3B90Y+CGaR92P
         Xk5Rly8G0QwDHJxCJnm8Ot+/BXAdZxe0SHCj3ZT6zCsYjrsBtQ0zMahKtrRbY0LU9EpO
         zVKOwznk0kFDHXutvUyJyNl+R+u+2g9j/hBKZ6LXGzXIvyJk6Dw6TgibhQm/448K6Diu
         ijGCgPkfKrKYUu/cqEEEJlKZDg6NMzz4itZWCLdF04LII/Pvk5RVYLtV8Jl4ImOYQdQj
         HlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211073; x=1700815873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMjYq8KIiIVaTPNF6OfRzBg75TE8YFMdh3udmnKItcQ=;
        b=fX1VrnwarR/VMmApoG9fJLTR0kFUvtzEPHwaFriEajHMm+ukl7Cr8vj1Uo4Wj9LZRI
         xRf8EzVnsbOvil9tHwf0acjFeHI4hXmvyVOs1iemw9QuhqjEw6UJpnNPJ8/NLGO6yDSg
         UnTK76mIWOu4wWrjbwVKC8JqeeDh/UQF4OrpQ0XUT009YUmOswh+6sDdVApbXkAMZfyE
         9+yCfb4HspWVgn96wwUolMOY58mN0Vn+w4nWuX7PglfkyoB81EUKhfMuW1Zne9FyYNn+
         cYKl+YmOuZ4/oh8V3Qv+VezcrrrbtvsJIUj9u43+j9aWE8Sg9eVYheNIIK9HtvkMbaz1
         tERg==
X-Gm-Message-State: AOJu0Yz5gMmKaIMiqSYK3/0otskxIJeSc8f8xwjpun3BKjj8if61ZNAB
        Pg0QI5mNrHAxsGruJT6Ui3hkT7Eq1HTsBgnJWPg=
X-Google-Smtp-Source: AGHT+IGWZnSkqKhI+H8sbF8oGYpyll/AkRs+lhfeBggoCHDmnifbR7umqBjbXHSJvxCYHfWQ4/py9REJrFq1WaFqEGU=
X-Received: by 2002:a05:6870:eca1:b0:1e9:bc79:9fa6 with SMTP id
 eo33-20020a056870eca100b001e9bc799fa6mr20244496oab.50.1700211073311; Fri, 17
 Nov 2023 00:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20231116140910.1613508-1-tomeu@tomeuvizoso.net>
In-Reply-To: <20231116140910.1613508-1-tomeu@tomeuvizoso.net>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 17 Nov 2023 09:51:02 +0100
Message-ID: <CAH9NwWc6Dw-M90eQsYG4mej=oWdtc+UdvYVp-u05c_PyqzHZUg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Expose a few more chipspecs to userspace
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomeu


>
> These ones will be needed to make use fo the NN and TP units in the NPUs
> based on Vivante IP.
>
> Also fix the number of NN cores in the VIPNano-qi.
>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 20 ++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 12 ++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 22 +++++++++++++++++++++-
>  include/uapi/drm/etnaviv_drm.h         |  5 +++++
>  4 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 5f96e7b1a9ec..9a18b5431975 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -164,6 +164,26 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
>                 *value = gpu->identity.eco_id;
>                 break;
>
> +       case ETNAVIV_PARAM_GPU_NN_CORE_COUNT:
> +               *value = gpu->identity.nn_core_count;
> +               break;
> +
> +       case ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE:
> +               *value = gpu->identity.nn_mad_per_core;
> +               break;
> +
> +       case ETNAVIV_PARAM_GPU_TP_CORE_COUNT:
> +               *value = gpu->identity.tp_core_count;
> +               break;
> +
> +       case ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE:
> +               *value = gpu->identity.on_chip_sram_size;
> +               break;
> +
> +       case ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE:
> +               *value = gpu->identity.axi_sram_size;
> +               break;
> +
>         default:
>                 DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index c8f3ad2031ce..83ef3c06da5d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -53,6 +53,18 @@ struct etnaviv_chip_identity {
>         /* Number of Neural Network cores. */
>         u32 nn_core_count;
>
> +       /* Number of MAD units per Neural Network core. */
> +       u32 nn_mad_per_core;
> +
> +       /* Number of Tensor Processing cores. */
> +       u32 tp_core_count;
> +
> +       /* Size in bytes of the SRAM inside the NPU. */
> +       u32 on_chip_sram_size;
> +
> +       /* Size in bytes of the SRAM across the AXI bus. */
> +       u32 axi_sram_size;
> +
>         /* Size of the vertex cache. */
>         u32 vertex_cache_size;
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> index 0cb5aacaf384..93f15cce6d22 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -17,6 +17,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .thread_count = 128,
>                 .shader_core_count = 1,
>                 .nn_core_count = 0,
> +               .nn_mad_per_core = 0,
> +               .tp_core_count = 0,
> +               .on_chip_sram_size = 0,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 8,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,
> @@ -49,6 +53,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .thread_count = 512,
>                 .shader_core_count = 2,
>                 .nn_core_count = 0,
> +               .nn_mad_per_core = 0,
> +               .tp_core_count = 0,
> +               .on_chip_sram_size = 0,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,
> @@ -81,6 +89,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .thread_count = 512,
>                 .shader_core_count = 2,
>                 .nn_core_count = 0,
> +               .nn_mad_per_core = 0,
> +               .tp_core_count = 0,
> +               .on_chip_sram_size = 0,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,
> @@ -113,6 +125,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .thread_count = 1024,
>                 .shader_core_count = 4,
>                 .nn_core_count = 0,
> +               .nn_mad_per_core = 0,
> +               .tp_core_count = 0,
> +               .on_chip_sram_size = 0,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 2,
> @@ -144,7 +160,11 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .register_max = 64,
>                 .thread_count = 256,
>                 .shader_core_count = 1,
> -               .nn_core_count = 1,
> +               .nn_core_count = 8,
> +               .nn_mad_per_core = 64,
> +               .tp_core_count = 4,
> +               .on_chip_sram_size = 524288,
> +               .axi_sram_size = 1048576,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,

I am counting 8 entries in the etnaviv_chip_identities array and you
are just updating 5 of them.

> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
> index af024d90453d..d87410a8443a 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -77,6 +77,11 @@ struct drm_etnaviv_timespec {
>  #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
>  #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
>  #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
> +#define ETNAVIV_PARAM_GPU_NN_CORE_COUNT             0x1f
> +#define ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE           0x20
> +#define ETNAVIV_PARAM_GPU_TP_CORE_COUNT             0x21
> +#define ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE         0x22
> +#define ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE             0x23
>
>  #define ETNA_MAX_PIPES 4
>
> --
> 2.41.0
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
