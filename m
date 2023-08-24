Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374367865A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbjHXC5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbjHXC5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:57:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CB124
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:57:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcfe28909so789020766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692845850; x=1693450650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glCjo1F94JBmzvms27OTmepsDv2N1ouu2CLlsTqKN9I=;
        b=gLwkzFmrl8u8ZfHEDU8+AyiL0Fw6bZIaU3W/c0DWF1ETSG8JXJpKy3T46gfg+t5bSR
         u0/y9oC0oXIjE2NFWprih7iP+l/GR5PMFHhaePj2TxYG+JMHIYwcke+HVgUO/MwQSLep
         lsyP303pnccf0vngf9Nx56bClDyB0O9eCj82cq/0nBBJopEW5mFMaA48oasjwpcahvCv
         SIkgImruCNKt9L7FiFkDdRQnmjFv0A3P3rI0l7mBy45WXAU0Cpt/Yil5ao5K77HfnQqE
         AMA+/9BvdEChQvGkxSJBz/KfnVfjB1eU4pj7/OF84u1d9V1V+seZIfVHU5d6GAON/IVd
         qRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692845850; x=1693450650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glCjo1F94JBmzvms27OTmepsDv2N1ouu2CLlsTqKN9I=;
        b=ZkzMR030ERXNLK/yBiwcsg5RrSNGh/4utuC0F9mq+PSalnZsmE4Qom7d0ghM2epys5
         Ovw0UHErTT8rhTbR1XmpPiSHI1+BaEPse14kju/ChzMxYVsHTNpohtphXofUxsCW+U+n
         DfheilfWJ8NMP6SbQdEDPPTrjELMKHCxuMvZIrIF2DJxNpjfSkEN3/Qvu3KsBQRz6Ic8
         56ncdr52Kx6SVyvNwW3nZWDR90Nv+XPsHqoFWTcIs+3Z5KUdC41silqtfzk52gZ6RrVy
         x3J4ujvpgkczg0Tre/Iefyw/ZCRKEBkiV9ud8W5MJmno8s03FrjUEqrySWuM0Pd1i4KE
         W10Q==
X-Gm-Message-State: AOJu0YzVGIHhHRXXMu7Yx+G9JYGo6mM9LM4VdSad9rp1X+uv6QqcUG5v
        eYHb8qBBdm3aGAjFbKVAZDCH89EF2fIKcJCS8Yk=
X-Google-Smtp-Source: AGHT+IGGs4hhDpkZJt5peSF19rdmbtl1bCN4ozS6KikecPNkQYyMYUkDlwhO9dKwKbz/kOan7UFvj/xcmq5erc+izak=
X-Received: by 2002:a17:906:7391:b0:9a1:c659:7c62 with SMTP id
 f17-20020a170906739100b009a1c6597c62mr4052476ejl.66.1692845849977; Wed, 23
 Aug 2023 19:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230823233119.2891-1-dakr@redhat.com>
In-Reply-To: <20230823233119.2891-1-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 24 Aug 2023 12:57:18 +1000
Message-ID: <CAPM=9twmbMC8VSoShxZUDW2+7=Kp0kBXsV33v7+4crrDyzfMAg@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next] drm/gpuva_mgr: remove unused prev pointer
 in __drm_gpuva_sm_map()
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, boris.brezillon@collabora.com,
        matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 09:31, Danilo Krummrich <dakr@redhat.com> wrote:
>
> The prev pointer in __drm_gpuva_sm_map() was used to implement automatic
> merging of mappings. Since automatic merging did not make its way
> upstream, remove this leftover.
>
> Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/drm_gpuva_mgr.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gpuva_mgr.c b/drivers/gpu/drm/drm_gpuva_mgr.c
> index 1bc91fc60ef3..3e1ca878cb7e 100644
> --- a/drivers/gpu/drm/drm_gpuva_mgr.c
> +++ b/drivers/gpu/drm/drm_gpuva_mgr.c
> @@ -1743,7 +1743,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
>                    u64 req_addr, u64 req_range,
>                    struct drm_gem_object *req_obj, u64 req_offset)
>  {
> -       struct drm_gpuva *va, *next, *prev = NULL;
> +       struct drm_gpuva *va, *next;
>         u64 req_end = req_addr + req_range;
>         int ret;
>
> @@ -1773,7 +1773,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
>                                 ret = op_unmap_cb(ops, priv, va, merge);
>                                 if (ret)
>                                         return ret;
> -                               goto next;
> +                               continue;
>                         }
>
>                         if (end > req_end) {
> @@ -1818,7 +1818,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
>                                 ret = op_remap_cb(ops, priv, &p, NULL, &u);
>                                 if (ret)
>                                         return ret;
> -                               goto next;
> +                               continue;
>                         }
>
>                         if (end > req_end) {
> @@ -1851,7 +1851,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
>                                 ret = op_unmap_cb(ops, priv, va, merge);
>                                 if (ret)
>                                         return ret;
> -                               goto next;
> +                               continue;
>                         }
>
>                         if (end > req_end) {
> @@ -1872,8 +1872,6 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
>                                 break;
>                         }
>                 }
> -next:
> -               prev = va;
>         }
>
>         return op_map_cb(ops, priv,
> --
> 2.41.0
>
