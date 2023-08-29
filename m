Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3791E78C6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjH2OJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjH2OJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:09:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3064114
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:09:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a76d882080so3306848b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693318178; x=1693922978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NXVMwpSZjzi1EW/drhoYIcfeMOkgEiQn8oAztJMHeQ=;
        b=V0OGk5Vadr83Qa7RVuH/qYseQvGodk8qHCsO+ZMngUYwP89xFUMkMU4tvJIDIwkya6
         YDNYgptbxamCvqBlgiYALIRrUMWU7MtR50Dsj0h1g09SXkcQQd/1TiHoewUwyj8DuPTD
         s7GgROLycZawpcoWxbaogsaEhfHXjqojCQDOAU9BUF6andZUs/ickWBagz5kPtWUvPjo
         0k6p/2CIWdcXohaQ1U6lpfKjh3LOMBOsP75RSSG6s2l7v1MPMPo5gvhiKEYbckh/4Xs4
         3d9ulwZ9ZimqccxHpE1mcFkL0sFg1vp4o5nVW1tZPXvrQ2yeAnf5D+Nar/aWUZxb9TP5
         BdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318178; x=1693922978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NXVMwpSZjzi1EW/drhoYIcfeMOkgEiQn8oAztJMHeQ=;
        b=MDIkyB8E/vFgLypB/tnnBCAGjR9wD9YOYZeAetMpI/FYy+kw1IOzV5YCpwd1XVK0Hc
         2xU4Jc6jZLxW2gJS5vhO5DEEn0i1eshnoEr0jSc5TcyhZJgd2oP2eIxd63XYZ6r8L9JY
         U82uui2mFcRVxKKUBBh4PN10Etvynlr1CNuG25AtEwvYWsB2YtEBF1uY5lIRK+MkCB/p
         BFP2zGGWaxZSX1C5u33Vko4Y/BqUhfluKY05pV8+E+x1Lu6amSessHp/SomwDDniZD2i
         evEHyv+Mjp3EAa+X4Jv2XINBROVE4I8NSvIaH25FUa0xJ/6/Hgksz5QUi02zpzF7xLnh
         qQgg==
X-Gm-Message-State: AOJu0Yx9kF0WBuzA+QLjzGq4rz0Lasm5BHUe3iXXpi8SGoogKKh5e1l1
        OJxjZMg41WNQAQPu6hihgvoe6MJfWEeDJ1GATMjcONjH
X-Google-Smtp-Source: AGHT+IHW07rLwA6rZ5tH8YoyiIaIaYTgVDGlb89CQpVWFwR0auPKiPgl5x5XnismG3SxABECMPqSHYzqoGqL6wDlBfE=
X-Received: by 2002:a05:6808:1a84:b0:3a4:38fa:2e08 with SMTP id
 bm4-20020a0568081a8400b003a438fa2e08mr13873870oib.7.1693318177948; Tue, 29
 Aug 2023 07:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230829113931.54391-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230829113931.54391-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Aug 2023 10:09:26 -0400
Message-ID: <CADnq5_MV+hVLRcMLrN4TE1xX1Q5dfMzi7+aWwZFcenF1uk+9iQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Revert "drm/amd/display: Implement zpos property""
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Leo Li <sunpeng.li@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, David Tadokoro <davidbtadokoro@usp.br>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Choi <Nicholas.Choi@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Joshua Ashton <joshua@froggi.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 7:40=E2=80=AFAM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> This reverts commit 984612bd4649c91f12e9c7c7f9e914fdc8ba7d3f.
>
> The problematic IGT test case (i.e. kms_atomic@plane-immutable-zpos) has
> been fixed as of commit cb77add45011 ("tests/kms_atomic: remove zpos <
> N-planes assert") to the IGT repo. So, reintroduce the reverted code.
>
> Link: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/cb77add45=
011b129e21f3cb2a4089a73dde56179
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 894bc7e4fdaa..df568a7cd005 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1469,6 +1469,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>                 drm_plane_create_blend_mode_property(plane, blend_caps);
>         }
>
> +       if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> +               drm_plane_create_zpos_immutable_property(plane, 0);
> +       } else if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
> +               unsigned int zpos =3D 1 + drm_plane_index(plane);
> +               drm_plane_create_zpos_property(plane, zpos, 1, 254);
> +       } else if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> +               drm_plane_create_zpos_immutable_property(plane, 255);
> +       }
> +
>         if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY &&
>             plane_cap &&
>             (plane_cap->pixel_format_support.nv12 ||
> --
> 2.41.0
>
