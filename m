Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACF7EB174
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjKNOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKNOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:04:37 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BC4BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:04:34 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b565e35fedso3300498b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699970674; x=1700575474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qlOleY1sx1uSAUuif2xWluY3/a1BG3eRXZXp2fHeOw=;
        b=gzd18iplZHOjFkQftALid287EoKpfasga65qReV8V01JhMJ+ucrwgeSP9TJhOnlJg5
         FLw6XhO1oj8CKwWX8vX5n79A329xOwCv5I9XcEOOEyXvqMOR8gm8LGsjAXRgptERokUj
         QDfjYnLi/4OgWlVuRJ++p+ZkuadD+zD50cCTPPjL5V0kfmxNhvdt5AEk1QHAfbDvv11A
         OZ64N5xmiAUVtkL3HWnaokkvdqKuyIyX5zBpvtqDz8KbZwFo98DZSyXbMJWlx+Hf1oZi
         HPQkr3aoA6z45h1bmtgTgtf07t3Y+jtW+fjqur+K7tG1vMxJg8lP9RGN4LmnUZZkgtgg
         707Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970674; x=1700575474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qlOleY1sx1uSAUuif2xWluY3/a1BG3eRXZXp2fHeOw=;
        b=lqlNWEslBnh2D3Y31kq0ucIoupaMZbldr9Fo4dpnR57Q1DfmMGrDdlaQY9Jbfid7TI
         W0mRb6dNWGmVe5T6Rn9fWNhAyNxN1WoSpmyT/VQIdW1xqD1YraDhVp9G4QDb3WiUtRUA
         xJfBSV5djKCsIfJVvzjHlWF2pP85Dip5fxO9THvHNx0RnkrRiImNTitmryrjARGsW4Eh
         xzvSyBexEXRjvSw9rIPCP8RP9XDuutNIw2cQq/NI3/ktRUC8YBTsAOMeZZleOTbvlFcp
         50gCTVFnCjmQ/zZDGo1HkPWL35whfOrMVqjtocS1Jh2BbpKJm9wi6DWKslS0onWelBEk
         QTsA==
X-Gm-Message-State: AOJu0YwzAIck+tBH6pEq+h7WfuddpvhaFYU77W7KSphZ0cIYtQOgE1pe
        ejj7Unl2cfCTWkJ/FiU9d7ySoDyKh0R5ZDH7QrgK7A==
X-Google-Smtp-Source: AGHT+IEqrRkM174mwSoofUNLHBqExjN+6X2fwSMYZl0oH5qHedom76o2Xwq0biyqfX70tQoLsWSZbg0vBTSDPJqoYek=
X-Received: by 2002:a05:6808:320b:b0:3b5:9965:2bc2 with SMTP id
 cb11-20020a056808320b00b003b599652bc2mr13206804oib.23.1699970673856; Tue, 14
 Nov 2023 06:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20231114132713.403443-1-dipamt1729@gmail.com>
In-Reply-To: <20231114132713.403443-1-dipamt1729@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 16:04:22 +0200
Message-ID: <CAA8EJpo+38OVfnmyE0zqDkVOss5GfPbR52FuObTxswCbtYtkig@mail.gmail.com>
Subject: Re: [PATCH] Remove custom dumb_map_offset implementation in msm driver
To:     Dipam Turkar <dipamt1729@gmail.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 15:28, Dipam Turkar <dipamt1729@gmail.com> wrote:
>
> Make msm use drm_gem_create_map_offset() instead of its custom
> implementation for associating GEM object with a fake offset. Since,
> we already have this generic implementation, we don't need the custom
> implementation and it is better to standardize the code for GEM based drivers.
>
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c |  2 +-
>  drivers/gpu/drm/msm/msm_gem.c | 21 ---------------------
>  drivers/gpu/drm/msm/msm_gem.h |  2 --
>  3 files changed, 1 insertion(+), 24 deletions(-)
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

msm_gem_mmap_offset internally has locking around
drm_gem_create_mmap_offset() / drm_vma_node_offset_addr() calls, while
 drm_gem_dumb_map_offset() does not. Thus this patch does more than is
stated in the commit message.

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
