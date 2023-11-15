Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BFF7EC6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjKOPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbjKOPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:07:57 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6E8101
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:07:54 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5afbdbf3a19so78598687b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700060873; x=1700665673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAkdFR38VbZr+retwYJvC4pXK2CLkuRAU6TUrfj2Y/Q=;
        b=iD7dcYUa4VoSX4q9U3C7wFBJ8aDP6XbFtaho/fSFilRoBmPmqMUv0xSD6ZZ2ALQwd1
         vsDu6RAX3/Y4x3rqrUVnkymENzRx9WW1tCjl6YoiC1gH/7yBpuJoPtrFy/hwto8WYBq+
         FymlqAg2ThYH+3bYP+WGHeOEXN4odM0QSNIUVBV95BQ7wIjbD84k8tlFdDpLq8R1xfFm
         VeEWsVaKqMKLYAmFmg4z9ACV4jQUgo5DwriJ16vXA09q+q2EZVrdzGCLdIFL+YmgyqvJ
         e9tZ/n35dPy0fnipGS4pQr2PuBRwugp4U+9T0zF4+pHyKJA0LyxgRqFTQzvrjnygKPiH
         5wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060873; x=1700665673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAkdFR38VbZr+retwYJvC4pXK2CLkuRAU6TUrfj2Y/Q=;
        b=MDWYW5QZI7pT+mNwOeP1rPXSWP/qnt65yb1mJLeY5EIbCP1xilEtwYIMa2S1dZ7+GL
         PRnoMJnuVZJoTHrIHNkdjXTtbdMOXYJwV3QCMvaglr5NPdHq9cwYCkoSQdaYSPRbV2VL
         sz1bM5wYtvR+mT2DMRB2LHqZMFPpcLLBueHKDTN6tYBQ9v3Zt6KTh7eMA13vdzy3Tbdj
         CaOs+sDYTI+TJVJeWrCErwG1fS1QVeApAuZ51TalS2ox0mA5yt5bMl9qpe9i3L/b/zOi
         QF9cHjQrdLSbgje6aQw98UXVMNL/4N0TTzyPMauVjcSr71pjWNCc/RyA87bh/y7bT5kW
         MEdg==
X-Gm-Message-State: AOJu0Yz8j9lgyuPXAi3KdGxlUpKVVoRg4DHJyl5nZUE+xRyp6dPQusIA
        bUL+qYNxwghEEqzgDzcBa95ioG+It9R6YhqJOLJjfg==
X-Google-Smtp-Source: AGHT+IFWMAAPr69IJZOrpc5SNuEM+oacpGbG5vuVdTWdzsr6zLBxZ1vBt7gGnTY8n6wgmwhM4whO4LzzuHfj/jYhdaU=
X-Received: by 2002:a0d:cb0f:0:b0:5a7:dbd1:4889 with SMTP id
 n15-20020a0dcb0f000000b005a7dbd14889mr15802748ywd.2.1700060873202; Wed, 15
 Nov 2023 07:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20231115141928.429688-1-dipamt1729@gmail.com>
In-Reply-To: <20231115141928.429688-1-dipamt1729@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 17:07:41 +0200
Message-ID: <CAA8EJprqnUGQxmj4Y=qttVuj0zJxdD9B6neHa6sPseLLETpk5A@mail.gmail.com>
Subject: Re: [PATCH v2] Remove custom dumb_map_offset implementation in msm driver
To:     Dipam Turkar <dipamt1729@gmail.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 16:30, Dipam Turkar <dipamt1729@gmail.com> wrote:
>
> Make msm use drm_gem_create_map_offset() instead of its custom
> implementation for associating GEM object with a fake offset. Since,
> we already have this generic implementation, we don't need the custom
> implementation and it is better to standardize the code for GEM based
> drivers. This also removes the outdated locking leftovers.

Why are they outdated?

>
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c |  2 +-
>  drivers/gpu/drm/msm/msm_gem.c | 21 ---------------------
>  drivers/gpu/drm/msm/msm_gem.h |  2 --
>  3 files changed, 1 insertion(+), 24 deletions(-)
>
> Changes in v2:
> Modify commit message to include the absence of internal locking leftovers
> around allocating a fake offset in msm_gem_mmap_offset() in the generic
> implementation drm_gem_create_map_offset().
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index a428951ee539..86a15992c717 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1085,7 +1085,7 @@ static const struct drm_driver msm_driver = {
>         .open               = msm_open,
>         .postclose          = msm_postclose,
>         .dumb_create        = msm_gem_dumb_create,
> -       .dumb_map_offset    = msm_gem_dumb_map_offset,
> +       .dumb_map_offset    = drm_gem_dumb_map_offset,
>         .gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
>  #ifdef CONFIG_DEBUG_FS
>         .debugfs_init       = msm_debugfs_init,
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index db1e748daa75..489694ef79cb 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -671,27 +671,6 @@ int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>                         MSM_BO_SCANOUT | MSM_BO_WC, &args->handle, "dumb");
>  }
>
> -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
> -               uint32_t handle, uint64_t *offset)
> -{
> -       struct drm_gem_object *obj;
> -       int ret = 0;
> -
> -       /* GEM does all our handle to object mapping */
> -       obj = drm_gem_object_lookup(file, handle);
> -       if (obj == NULL) {
> -               ret = -ENOENT;
> -               goto fail;
> -       }
> -
> -       *offset = msm_gem_mmap_offset(obj);
> -
> -       drm_gem_object_put(obj);
> -
> -fail:
> -       return ret;
> -}
> -
>  static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 8ddef5443140..dc74a0ef865d 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -139,8 +139,6 @@ struct page **msm_gem_pin_pages(struct drm_gem_object *obj);
>  void msm_gem_unpin_pages(struct drm_gem_object *obj);
>  int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>                 struct drm_mode_create_dumb *args);
> -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
> -               uint32_t handle, uint64_t *offset);
>  void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj);
>  void *msm_gem_get_vaddr(struct drm_gem_object *obj);
>  void *msm_gem_get_vaddr_active(struct drm_gem_object *obj);
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
