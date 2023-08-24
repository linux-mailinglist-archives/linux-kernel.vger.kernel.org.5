Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B47787177
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbjHXOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbjHXOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:25:16 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D61FD9;
        Thu, 24 Aug 2023 07:25:10 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c26bb27feeso4574158fac.0;
        Thu, 24 Aug 2023 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692887109; x=1693491909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jj+VsxPNlYygxR0YWp1qEk+PHqvGIcv1NZFfF1gn04=;
        b=LZA044mX8DLFktOaXrGFSp/RcXyh5URTciSLev7oFFAGezD2/hScyKGYxysgaXoXBH
         XbBcKk1XjJVGFgsgg/kwM9OJLUmG+WvTKc/rqfJYOGfl4N46esY8ufvgOE60EbHsb0YH
         hDpc7wMrAPE+iCIabCquj4gJa6v5k4FlcOV0fFkh3AR/U3dLoyLasp3hNqGerthBNI70
         YN/fi9PT77+3FkTAGDthLSLMTCaD8kDdWkvoM0cYZt6NCYKBs7cb+3Y5vB5In2Y+/7KK
         yjWBvpCYpLgBb8z4kRL7ujHG9ZAO3uT1ik6UQ4Kl68tg6iJ6eRCb15C/XXdHKJmt2BZi
         sSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887109; x=1693491909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jj+VsxPNlYygxR0YWp1qEk+PHqvGIcv1NZFfF1gn04=;
        b=iDN2JEOByfHKeWsfYpuZjfSpWsikPbkzk+Cu5dTMAkAOvo2nEYOuzxk33LWV4sZCLf
         hTl2J/SZFWJ8LT1oJlzk8q0a8z+ZTt72KFEdeu6KhVo/Pbb8mn6vNt0pjQaL5OA0D1Xr
         yD/H/LIvySiIy5h59xtXOJH8igauQJrP7geR6Qi8pI6aOI2jytJ5UVD/iRfDgW5dh0P8
         voCHMV5Dnnk/AyZ+rlsIrf+Q+rHZkZFZsCAHX4rpaD5Pj2kil6F7wlw9Zx/c0WukF38f
         R1EsDo8OodXuCeZ8KFitbCmFAT1gp66IufjCCjSuexVq+HhmfToLIKDdtojChKd1NPxP
         +kWQ==
X-Gm-Message-State: AOJu0YzXZpAsDcIcu6m8HZJbJO7yX08f3DPwVrZKMLnU/f8AVVam5pnF
        RRnyBsaK5I+hM4ROlSrPJbBId8g4MXqlAKvrKlBLqIyE
X-Google-Smtp-Source: AGHT+IFDDRQe/ZcAWLpqIFG8ZkwVnJ2S73S5T2E6cIqdd0/6XZWYewu0LM3ybZy276+QGrFZQcOUPJlQOWThlrvPXV8=
X-Received: by 2002:a05:6870:41d2:b0:1c8:b82b:cbdb with SMTP id
 z18-20020a05687041d200b001c8b82bcbdbmr18609632oac.33.1692887108906; Thu, 24
 Aug 2023 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230822113553.3551206-1-sashal@kernel.org> <20230822113553.3551206-10-sashal@kernel.org>
In-Reply-To: <20230822113553.3551206-10-sashal@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:24:57 -0400
Message-ID: <CADnq5_NGRLrgh=f1=4nyWAMv3_HhV5zCJxV9UYc1GLCygVjp1w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.4 10/11] drm/amdkfd: disable IOMMUv2 support for KV/CZ
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mike Lothian <mike@fireburn.co.uk>,
        Felix Kuehling <Felix.Kuehling@amd.com>, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
        airlied@gmail.com,
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

On Tue, Aug 22, 2023 at 7:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> [ Upstream commit 616f92d188ee7142a95a52068efdbea82645f859 ]
>
> Use the dGPU path instead.  There were a lot of platform
> issues with IOMMU in general on these chips due to windows
> not enabling IOMMU at the time.  The dGPU path has been
> used for a long time with newer APUs and works fine.  This
> also paves the way to simplify the driver significantly.
>
> v2: use the dGPU queue manager functions
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Tested-by: Mike Lothian <mike@fireburn.co.uk>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not necessary for stable.

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 6 ------
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +-------
>  2 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 00f528eb98126..9c8197573dee7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -224,10 +224,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd=
,
>                     asic_type !=3D CHIP_TONGA)
>                         kfd->device_info.supports_cwsr =3D true;
>
> -               if (asic_type =3D=3D CHIP_KAVERI ||
> -                   asic_type =3D=3D CHIP_CARRIZO)
> -                       kfd->device_info.needs_iommu_device =3D true;
> -
>                 if (asic_type !=3D CHIP_HAWAII && !vf)
>                         kfd->device_info.needs_pci_atomics =3D true;
>         }
> @@ -240,7 +236,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *a=
dev, bool vf)
>         uint32_t gfx_target_version =3D 0;
>
>         switch (adev->asic_type) {
> -#ifdef KFD_SUPPORT_IOMMU_V2
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>         case CHIP_KAVERI:
>                 gfx_target_version =3D 70000;
> @@ -253,7 +248,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *a=
dev, bool vf)
>                 if (!vf)
>                         f2g =3D &gfx_v8_kfd2kgd;
>                 break;
> -#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>         case CHIP_HAWAII:
>                 gfx_target_version =3D 70001;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 7a95698d83f73..c73417e79745e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2335,18 +2335,12 @@ struct device_queue_manager *device_queue_manager=
_init(struct kfd_dev *dev)
>         }
>
>         switch (dev->adev->asic_type) {
> -       case CHIP_CARRIZO:
> -               device_queue_manager_init_vi(&dqm->asic_ops);
> -               break;
> -
>         case CHIP_KAVERI:
> -               device_queue_manager_init_cik(&dqm->asic_ops);
> -               break;
> -
>         case CHIP_HAWAII:
>                 device_queue_manager_init_cik_hawaii(&dqm->asic_ops);
>                 break;
>
> +       case CHIP_CARRIZO:
>         case CHIP_TONGA:
>         case CHIP_FIJI:
>         case CHIP_POLARIS10:
> --
> 2.40.1
>
