Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C77AF8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjI0Dwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0DwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:52:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A9475E0;
        Tue, 26 Sep 2023 20:52:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so8574282a12.3;
        Tue, 26 Sep 2023 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695786736; x=1696391536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbudO+4G2j3i97UP7uLWqquSHrnG0YZoAgH3/yd4IYQ=;
        b=MO25+XY7Y+4rkcklBjDRGKCq2DnX21/jvoLTJ31MbvvNC+nyFCR+xUA1it0Gx0m0oe
         SPL4FYo8JwAv3RAjCdgoK5q6oB/taVrdz05eRiY4ynA2jDoyKmJa7WMp9wwzHgjC0+xQ
         352NA75Ytfbs6DY8KCe6+I5OdMWEOF5hU0AGm2DCgpLZj8KVBvB3CjJO8ZKn2qnRno1z
         eYkljUlypQFTvKOBj11fucP0ZlOY2On9kgNWE6IlHLddel6uNkrqL3LK/m26YL50xmYu
         YrUTYfK/h7TSsUKe4ivlUd68z/0IKGK1Z2a/9fWtOScE/JEiB8qEOhpcECYZZGXgMfoP
         XneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786736; x=1696391536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbudO+4G2j3i97UP7uLWqquSHrnG0YZoAgH3/yd4IYQ=;
        b=Y5Odra0XO4hNa1Hi9osGEC4A3M4BWbVZRBukSXKJa5DGdzBX/dffYKNqXi7anMR7sZ
         kLCKkoDq3NssaU9MJZBskQRc5pHJ625zSNa4qgcs4xUpr2oIz/6NDRqGr49YZ+aZZPrc
         pzL9tnNOqgDAIWNjoI/B7N/84vFqNXpejcmTruU3aWIfUVgLHWV+kiPqXJjBwpRJ77ta
         EnQQ1ydovdTXzWarZrJ4BIU1Rmco3MLR3U383asBDhyFFBiW5DbTHmCQQVyxHawSbBkc
         xT9urNMREPP1glM3U47Q+J34Lcn0ZSiL0iPf97ZaS7QWvTvb2yj3b2R6QP+i6x/GSWU5
         VVVg==
X-Gm-Message-State: AOJu0Yx39oDpQrIRBM3jhx2CjudbGuVvpuFCk8srByR4wXskdzmG9pjz
        W06HAKSp8+9IfP860l/xb5mKG1qY0h9DcCz5HMrMXXrexzo=
X-Google-Smtp-Source: AGHT+IHjLecfIjJaSS+8zDn1jdmYkVtgJJRdPD3qgAnh9MyfKbTdo/P7GLoNn6TCGPw+GhQbpuhlaIq7tmEuJoFL8zU=
X-Received: by 2002:a17:906:e291:b0:9ae:5c99:f2e2 with SMTP id
 gg17-20020a170906e29100b009ae5c99f2e2mr548477ejb.43.1695786736037; Tue, 26
 Sep 2023 20:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230926105146.10808-1-dakr@redhat.com>
In-Reply-To: <20230926105146.10808-1-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 27 Sep 2023 13:52:04 +1000
Message-ID: <CAPM=9tzVbuoufoEJuZ2t4LkDh0-Gj8xHYCs3iMPcCY=Ay1Jshw@mail.gmail.com>
Subject: Re: [PATCH] drm/gpuvm: doc: fix filename references
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, sfr@canb.auug.org.au,
        daniel.vetter@ffwll.ch, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 26 Sept 2023 at 20:52, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Commit f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to
> struct drm_gpuvm") did also change the corresponding filenames which are
> referenced from the documentation, but were not adjusted accordingly.
> Hence, fix up those filenames.

Acked-by: Dave Airlie <airlied@redhat.com>

>
> Fixes: f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/dri-devel/20230926150725.4cca5fc5@canb.auug.org.au/
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  Documentation/gpu/drm-mm.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index c19b34b1c0ed..602010cb6894 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -466,40 +466,40 @@ DRM MM Range Allocator Function References
>  .. kernel-doc:: drivers/gpu/drm/drm_mm.c
>     :export:
>
> -DRM GPU VA Manager
> -==================
> +DRM GPUVM
> +=========
>
>  Overview
>  --------
>
> -.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
> +.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
>     :doc: Overview
>
>  Split and Merge
>  ---------------
>
> -.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
> +.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
>     :doc: Split and Merge
>
>  Locking
>  -------
>
> -.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
> +.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
>     :doc: Locking
>
>  Examples
>  --------
>
> -.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
> +.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
>     :doc: Examples
>
> -DRM GPU VA Manager Function References
> ---------------------------------------
> +DRM GPUVM Function References
> +-----------------------------
>
> -.. kernel-doc:: include/drm/drm_gpuva_mgr.h
> +.. kernel-doc:: include/drm/drm_gpuvm.h
>     :internal:
>
> -.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
> +.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
>     :export:
>
>  DRM Buddy Allocator
> --
> 2.41.0
>
