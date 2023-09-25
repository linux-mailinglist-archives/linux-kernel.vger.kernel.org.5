Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DF7ACD47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjIYAnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjIYAnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:43:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1FFE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:42:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso644946966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695602566; x=1696207366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmy5JexBXWcDO5nMMXegOq/JNnbovpsIKxOY5tt3G3A=;
        b=jeZuHTeC0HQLgUg9+mUw+FN3ixnf+edslKVa3Ff2n1ycGNPmpE7r2PEWTK00wGQLG+
         0WPDBuymRtx/m7ZKJm6owzZSC1hU3vOsOMXo0XqcT6L8JaqicrORUpU06c0UfOuJy6Yf
         GIBoeuk/DQ1QM1BPnz9I1LgbAmdIzjwdJoKsET3SuRXfplgEO0HAj8Se0RqwUcvfNaJp
         GxrL677iGunRUnZY8yL4pb2+Robil7Qqa0GI6Z6hB0PORIJTN5X+2wLvKFEnRJUFfJJi
         Sv7v3HpZsFruPa3IxlpLy5dDTuzNOomIByL0ik8yebfIVJ01AAVSzK0krBKETd/UvCiU
         mLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695602566; x=1696207366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmy5JexBXWcDO5nMMXegOq/JNnbovpsIKxOY5tt3G3A=;
        b=Dt93TZxI8eUAYvAgu5J/62OnSvc5AWbht3ekCdGT+eo8mta0plrHEOMVZtIXyHLqjp
         zLb8w2wWZVInLpvMY+kWtP95bF3BFamnInKL8towxjgVgNwfvDmxgj5Kjhu7YLdc+a3l
         YC4PEk1YPY91Oq7C+S4JrvOiRL70aVSCOtDTqqLZmQ0Zc6Xkk0CjNmfOM6QszNvrdrUX
         xwrHw5qXj5ClOpbSqXUH8esHvlGS1l5Y4UPf4nfAbjrSQbBmmwRv6QIJAfZ24f2ksJ7V
         dAY98BK76YasilmPmEeXEjTSn0Ke5HbNq6EWdMLK7SDPvOKC7+STW98sNgWpTyciTiNA
         78Mw==
X-Gm-Message-State: AOJu0YwgFZEh7Y6AgUlpW6vhHHNamd9wRzNwAe7+h9fUHZlkZfkabhHa
        SG4BLZRokhGlbnBqUQabiG4tp/Erip3xUrhNGAw=
X-Google-Smtp-Source: AGHT+IHBYsgLmFq/vhzb5PS2Nn02df+XkE36DkYvOiY/NDldgh3WAxZbVJeipgPUNIKS2CPaA7UdVYVsQ69LbETxjis=
X-Received: by 2002:a17:907:78cc:b0:9b2:8c37:820 with SMTP id
 kv12-20020a17090778cc00b009b28c370820mr59580ejc.65.1695602566451; Sun, 24 Sep
 2023 17:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230920144343.64830-1-dakr@redhat.com> <20230920144343.64830-3-dakr@redhat.com>
In-Reply-To: <20230920144343.64830-3-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 25 Sep 2023 10:42:35 +1000
Message-ID: <CAPM=9tzHPqviNL0VX5GnSZKkpJz0xy8520S5n_3SZaJr5ZdM-w@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v4 2/8] drm/gpuvm: allow building as module
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 00:43, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Currently, the DRM GPUVM does not have any core dependencies preventing
> a module build.
>
> Also, new features from subsequent patches require helpers (namely
> drm_exec) which can be built as module.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>

> ---
>  drivers/gpu/drm/Kconfig         | 7 +++++++
>  drivers/gpu/drm/Makefile        | 2 +-
>  drivers/gpu/drm/drm_gpuvm.c     | 3 +++
>  drivers/gpu/drm/nouveau/Kconfig | 1 +
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index ab9ef1c20349..0f78a03e4e84 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -216,6 +216,13 @@ config DRM_EXEC
>         help
>           Execution context for command submissions
>
> +config DRM_GPUVM
> +       tristate
> +       depends on DRM && DRM_EXEC
> +       help
> +         GPU-VM representation providing helpers to manage a GPUs virtua=
l
> +         address space
> +
>  config DRM_BUDDY
>         tristate
>         depends on DRM
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 7a84b3cddeab..8e1bde059170 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -45,7 +45,6 @@ drm-y :=3D \
>         drm_vblank.o \
>         drm_vblank_work.o \
>         drm_vma_manager.o \
> -       drm_gpuvm.o \
>         drm_writeback.o
>  drm-$(CONFIG_DRM_LEGACY) +=3D \
>         drm_agpsupport.o \
> @@ -81,6 +80,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) +=3D drm_pan=
el_orientation_quirks.o
>  #
>  #
>  obj-$(CONFIG_DRM_EXEC) +=3D drm_exec.o
> +obj-$(CONFIG_DRM_GPUVM) +=3D drm_gpuvm.o
>
>  obj-$(CONFIG_DRM_BUDDY) +=3D drm_buddy.o
>
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index 7074bcad5b28..bfea4a8a19ec 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1723,3 +1723,6 @@ drm_gpuva_ops_free(struct drm_gpuvm *gpuvm,
>         kfree(ops);
>  }
>  EXPORT_SYMBOL_GPL(drm_gpuva_ops_free);
> +
> +MODULE_DESCRIPTION("DRM GPUVM");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kc=
onfig
> index c52e8096cca4..1e6aaf95ff7c 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -11,6 +11,7 @@ config DRM_NOUVEAU
>         select DRM_TTM
>         select DRM_TTM_HELPER
>         select DRM_EXEC
> +       select DRM_GPUVM
>         select DRM_SCHED
>         select I2C
>         select I2C_ALGOBIT
> --
> 2.41.0
>
