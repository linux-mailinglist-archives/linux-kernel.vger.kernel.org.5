Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F671787266
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbjHXOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjHXOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:53:18 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A38419A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:53:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bd0425ad4fso4818217a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888791; x=1693493591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEgAJuBvB5RrueW913Bvc0IDd42WONx4EX0C4ngeyAc=;
        b=cvzc/Ma42+/EH5GnV6gaAnBXY5rYSiYhq4y7y1CG0RIlz3m5ivrGOqHDG9qJYtccXi
         CtNva/9uHFWsO5lCrNmZ+QsUe3y1P/ANtqnuJdTfI46L+8TecVzb9Sgj4KkjQDT4pmKp
         TMtmCnIHMqlVovR/5d96sRjp2QDxVVxGOTXbs8RaciNESp00L0YrG0IlVztW+P1EL7sY
         hN9k2rc34EvMEV1xZ8+wa+TAfvX05EEwHA22eg0XHr+n4KZcJaiQLru90PKsOqzwFXqu
         qLl6cOCDlS5BfpT8K/ATHjsxe+xEvExHpSvTUv9lmd0hxNu7M5KMmldvJaiuL2LMFzgM
         X2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888791; x=1693493591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEgAJuBvB5RrueW913Bvc0IDd42WONx4EX0C4ngeyAc=;
        b=A7li0FlpUgwlndHVablaPGhpNCcWarBTQ/YqMpmDnIFZgob7nvye+U+8AyQZLGD5xQ
         MQSF48We5S0VQM9TJ2I38gtFl1U+sVItNHlm8LGnw1f1jLwTa3CdxsX4nqYhm/AOJwVl
         //3Xont5CLc2Qg96CNy3HqPZY6trau2SZ+OPmdR1EZEvvJxUVbv8JbYZcNUIIvKhbXyq
         xeJR798hwjuTcQ5EtM40TmIRjFv0dSseQPcFkqtcwaqNbfY9OFc1MuSSZIWQOBWhLSlf
         h3yU+dwBXkXAWCq+wPr7I0vPVmZidkhNB10cYMFqxcQ1fwe+z+YiyPWNQFSLsk5XHulH
         SmIg==
X-Gm-Message-State: AOJu0YwEKIjXl+aw0JuDLwssAPgYtj1BgbgKP1W+YfGzpT9m7P1tZ2P4
        DojzJssA/pBGIJlXMT/Zgrj4Kdw9eSBXH4lf6ak=
X-Google-Smtp-Source: AGHT+IHkkjwf7Pf1Rx/dcEiwdD8uFdhQ76ZVl2mt75hB4yRbeXBGdMKP9T/bACPndUFjk98cNFZLiNjyEpjNR0fqUuY=
X-Received: by 2002:a05:6870:9722:b0:1b7:4521:14b6 with SMTP id
 n34-20020a056870972200b001b7452114b6mr19020700oaq.5.1692888791355; Thu, 24
 Aug 2023 07:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-8-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-8-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:53:00 -0400
Message-ID: <CADnq5_O7m7QPEOi8Fgr5a4V6HcLNUyOuYO23Y=sGYtbnF6r_CQ@mail.gmail.com>
Subject: Re: [PATCH 07/20] drm/radeon/radeon_ttm: Remove unused variable 'rbo'
 from radeon_bo_move()
To:     Lee Jones <lee@kernel.org>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Jerome Glisse <glisse@freedesktop.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied.  Thanks!

On Thu, Aug 24, 2023 at 3:37=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_ttm.c: In function =E2=80=98radeon_bo_move=
=E2=80=99:
>  drivers/gpu/drm/radeon/radeon_ttm.c:201:27: warning: variable =E2=80=98r=
bo=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jerome Glisse <glisse@freedesktop.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index 4eb83ccc4906a..de4e6d78f1e12 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -197,7 +197,6 @@ static int radeon_bo_move(struct ttm_buffer_object *b=
o, bool evict,
>  {
>         struct ttm_resource *old_mem =3D bo->resource;
>         struct radeon_device *rdev;
> -       struct radeon_bo *rbo;
>         int r;
>
>         if (new_mem->mem_type =3D=3D TTM_PL_TT) {
> @@ -210,7 +209,6 @@ static int radeon_bo_move(struct ttm_buffer_object *b=
o, bool evict,
>         if (r)
>                 return r;
>
> -       rbo =3D container_of(bo, struct radeon_bo, tbo);
>         rdev =3D radeon_get_rdev(bo->bdev);
>         if (!old_mem || (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
>                          bo->ttm =3D=3D NULL)) {
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
