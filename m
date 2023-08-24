Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBC7872B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbjHXO4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbjHXOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:55:45 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99501BC8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:55:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a85b9c6ccdso3096504b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888940; x=1693493740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jbbb7aX/AkCc7cpA2XwQxu9e8hXKfl+ISvse/qujzGg=;
        b=gVxr9oIQtnsCOCNnMwke1KphBWQ4KPbmg9wClsiNDuhk39u2HDqFOprhDbrQ35Ij60
         +gYjV0SvB4AWSHYE+iKgSUR2WRw6QmIO3EbQFP0alvL+jyI1mZ1CnxOjAdUaYgSYhE1l
         hego1hdv3IBVMuqZFptNb+mALPzg4ZoL18jRUWYiELiJLLQylndbA9Q6MAbyEKoEqjXf
         fgD4B9rnfARzfNSX5OEfj2BkxfvVc6sgpbKe/VqbbwgbT6yl4S2CQ8g8Nt96AGRJCL5L
         SjD/v8uUrQs4UcvtapeILd0tI7ZdPDmLJf0uLNm2DGdwb/1qCUvyAZzhYvoMNCLDn151
         uI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888940; x=1693493740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jbbb7aX/AkCc7cpA2XwQxu9e8hXKfl+ISvse/qujzGg=;
        b=AWImVaq0Gl42o8y3kwLFxPuvveU8kOyZrEfd7kaK58rgnAn2EBafwx942UWFoyR0xW
         503wqHgWdeKM7nLNyaPjcl85aFVJ1kEkzmytAAE5L35JBCuwYddaQZQEDe2YmuFxhN3j
         eTXnQbOZ2Jj5c1ECQTBlSZ+vUrshLBjmVko2XaYG7AVyHYJQJkEIWE+9iF5PZ7MNatMa
         H2b+asxl5k0vOor15eF2+L4cBNuA4i9FDaUM4SyeNmoVH4o7GVqSRm325gkB8v1Lk0RD
         Ohkcfw6U3tXHkVkbgIeSV+ftvQfIKglVvijfghKKlRCv8jwGDBZl1r+ia9iOXWqLITAs
         zciw==
X-Gm-Message-State: AOJu0YzfwXa/uE724G1XpHOY+meGO/xRdPvsruPVNckw+aXJO+0CiQ+c
        fosnt3iK3LW17+sKXX4lvQfi7qt5lZHX6m0L6AtqdNqD
X-Google-Smtp-Source: AGHT+IHFrvyvkxJtRo6wF6qRXhH37rfIWRuLntVdyovafjrkWNWzmzu2++kD4BRzIqoQe8pwwnaMQR/q0nyPXZERQ18=
X-Received: by 2002:a54:4d9b:0:b0:3a7:55f2:552d with SMTP id
 y27-20020a544d9b000000b003a755f2552dmr15331218oix.58.1692888939948; Thu, 24
 Aug 2023 07:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-18-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-18-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:55:28 -0400
Message-ID: <CADnq5_MethMGBe2n4kfeGEhuh_aHZkUsu-yD9zWSR+iB+ZFZag@mail.gmail.com>
Subject: Re: [PATCH 17/20] drm/amd/amdgpu/amdgpu_ras: Increase buffer size to
 account for all possible values
To:     Lee Jones <lee@kernel.org>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

Applied.  Thanks!

On Thu, Aug 24, 2023 at 3:38=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function =E2=80=98amdgpu_ras=
_sysfs_create=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1406:20: warning: =E2=80=98_err_=
count=E2=80=99 directive output may be truncated writing 10 bytes into a re=
gion of size between 1 and 32 [-Wformat-truncation=3D]
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1405:9: note: =E2=80=98snprintf=
=E2=80=99 output between 11 and 42 bytes into a destination of size 32
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h
> index ffb49b2d533ad..7999d202c9bc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -436,7 +436,7 @@ struct amdgpu_ras {
>  };
>
>  struct ras_fs_data {
> -       char sysfs_name[32];
> +       char sysfs_name[48];
>         char debugfs_name[32];
>  };
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
