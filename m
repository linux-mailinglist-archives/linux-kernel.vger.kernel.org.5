Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474397F4125
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjKVJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjKVJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:02:55 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF71993
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:44 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2c5b2154so3900610a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700643703; x=1701248503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0loSkyS8Q4JF6tOXkRoeRXujNUfgvT0hvtKpAV8emU=;
        b=KAvIvFivGY+TipBdV1g7JBfrkp1sw2gCb1ozF989xwuibQZv9FQZETygNPbJcMtyu/
         TRU1deqgPz92H1iq6g/9FiyRBZprYU8smkjkSlPtaz0izQuB1pL6hXCipYC8KqQa8rjd
         twcc/F99724sdQFzPx35fUB0hlFGb3rxAh67/e1FncmFo3nSolzPaBjJuYttKO/Egk1g
         kk6pitb+qHExL235fC2ImLudgiaYYpJYJr25uqrK3yV5b3TLgsjHVJFQw+ty8HW4bIKT
         9pSDWRJRuLW3SVEGUrJOFIpifAk4uIB68MxADK4r4k42lHCyL/4roP7XnZuWKlCzMJJq
         4bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643703; x=1701248503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0loSkyS8Q4JF6tOXkRoeRXujNUfgvT0hvtKpAV8emU=;
        b=aA+fdvp5AIHVaoBi/4RZ03LRd+8QeoSDMKoRB3sni0ahsE36O5zAmNvh3RWfAtLBGt
         J2rL/RexeCZYf5F4g7hKkb8mO0OYRp8bYPv/FFYEH/vaj5jpLT5KavJPk2ZslD29XvsQ
         FOEeD81/sIBkXK9lbT/31FL5MQnDq21utQiQjsTEXVIB9cHx65RDGAXYBjOeOtx7jHzi
         k06TOgws3YY5YoJK+gEafffHep8htl8CWstsNtpQ8hieFaN9z6/tezCOnsrr7PoRlfRk
         Qxs52Pg7m5Bxll7JA4XLOFvALJNzmQTLngql8NQ7MaYGr3CGg63Ko8xFhl8OxIdS4MXN
         A/Aw==
X-Gm-Message-State: AOJu0YzaInO4L5kMl/Qx1oi9YLjXI3PUooQpShNF3McQRMlSBLfeb8Lj
        w7CpQZuq3zXE/WKofarUe6hJOV4lT+Ydy3coIbRwbv1N4w5lbw==
X-Google-Smtp-Source: AGHT+IG+AQeKCJw3Ukd8i/zIrx+/UVseMXxynPD4JgoySfRf0Ua5e6jnUPyIUhPJ9xHEAvoz76S7MQveOn6+oNImOzU=
X-Received: by 2002:a05:6870:ac0b:b0:1ea:2c8b:e18b with SMTP id
 kw11-20020a056870ac0b00b001ea2c8be18bmr2203709oab.35.1700643703182; Wed, 22
 Nov 2023 01:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20231116140910.1613508-1-tomeu@tomeuvizoso.net> <20231121063300.2273522-1-tomeu@tomeuvizoso.net>
In-Reply-To: <20231121063300.2273522-1-tomeu@tomeuvizoso.net>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Wed, 22 Nov 2023 10:01:31 +0100
Message-ID: <CAH9NwWemgaUOByCKMC5PMN3q1f91DE0yxEE90hwjhic47fj+Lw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: Expose a few more chipspecs to userspace
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 21. Nov. 2023 um 07:33 Uhr schrieb Tomeu Vizoso <tomeu@tomeuvizoso.net>:
>
> These ones will be needed to make use fo the NN and TP units in the NPUs
> based on Vivante IP.
>
> Also fix the number of NN cores in the VIPNano-qi.
>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
>

I have not checked all the new values but it looks fine to me.

Acked-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>
> v2: Update a few chipspecs that I had missed before. (Christian)
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 20 +++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 12 +++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 34 ++++++++++++++++++++++++++
>  include/uapi/drm/etnaviv_drm.h         |  5 ++++
>  4 files changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 9276756e1397..9055ed08cd7b 100644
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
> index 197e0037732e..7d5e9158e13c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -54,6 +54,18 @@ struct etnaviv_chip_identity {
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
> index 67201242438b..9eb8ca7c5034 100644
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
> @@ -48,6 +52,11 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .register_max = 64,
>                 .thread_count = 256,
>                 .shader_core_count = 1,
> +               .nn_core_count = 0,
> +               .nn_mad_per_core = 0,
> +               .tp_core_count = 0,
> +               .on_chip_sram_size = 0,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 8,
>                 .vertex_output_buffer_size = 512,
>                 .pixel_pipes = 1,
> @@ -80,6 +89,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
> @@ -112,6 +125,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
> @@ -143,6 +160,11 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .register_max = 64,
>                 .thread_count = 512,
>                 .shader_core_count = 2,
> +               .nn_core_count = 0,
> +               .nn_mad_per_core = 0,
> +               .tp_core_count = 0,
> +               .on_chip_sram_size = 0,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,
> @@ -175,6 +197,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
> @@ -207,6 +233,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .thread_count = 256,
>                 .shader_core_count = 1,
>                 .nn_core_count = 8,
> +               .nn_mad_per_core = 64,
> +               .tp_core_count = 4,
> +               .on_chip_sram_size = 524288,
> +               .axi_sram_size = 1048576,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,
> @@ -239,6 +269,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .thread_count = 256,
>                 .shader_core_count = 1,
>                 .nn_core_count = 6,
> +               .nn_mad_per_core = 64,
> +               .tp_core_count = 3,
> +               .on_chip_sram_size = 262144,
> +               .axi_sram_size = 0,
>                 .vertex_cache_size = 16,
>                 .vertex_output_buffer_size = 1024,
>                 .pixel_pipes = 1,
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
> 2.42.0
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
