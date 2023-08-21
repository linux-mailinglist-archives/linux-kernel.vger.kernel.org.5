Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F8782E49
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjHUQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjHUQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:23:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C030E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:23:05 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a82db15081so2115577b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692634984; x=1693239784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RKwxKRkMzZSYtscwR1pkHOqnFjGeKqGQ4WnufmDBk4=;
        b=kdPKRxX9KHaGlN5kVEpCehk6uag26GOrp3ybg79+zulHdrv0AX8MWcXh4t4tdgTY6O
         sddS4OjJjZ35YqM94kEeEDnzold9o5WHUrQn297//pE1XBZYfu6jEJfcuNobVvVCfaFn
         +SSqKu+UExyYdrQShCYzxre5rw90xUVJ7dHprWiEXPM7yIHJrIbzjtNO7HBTLOb4TSyJ
         QFHO1Yjv/QnA7JaE/v43Nc79sYQQ6UM/GawYdO/sASt0dD2tsHeMEqJWendqPl1ctJEK
         xCsPIBqkBCnOcBHhWQY/51Dk0vbUovjg7X1EzKW8sg/v2kIvz6w3yH/ccpGr3kRVM4FC
         nyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692634984; x=1693239784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RKwxKRkMzZSYtscwR1pkHOqnFjGeKqGQ4WnufmDBk4=;
        b=hzXPHFpjh/3blKAsxv+NupuidU6gtvvKYwdeQjujJsvkOEd/ecEhCA5/I2KKQCXGlL
         gbnb/aK5ywjEDqctdkt4x83JXqQrAANA1cKCcLBlq8BY9WU7JgTV3DLxbVJlzNYrjnsa
         lH9oNCJJhaLOaAVguHDZwnp91OzjMO/tEUj+iYf6Xgm0tsabaDlfGR3VoeuIqdo6bk6a
         J44gza85dICb4SmpcyLrzP8mp3cgiMuhAd+SVJRmwiS3Vjf3lJfa7zprLtDnDRzngTXD
         uR0aBxIJDChsQK+KwWpEwnyvOtGLC1iNavomlo24saf4htIou/cHAg3tQPHH2A4dmzQH
         NM8Q==
X-Gm-Message-State: AOJu0Yzpa4uZjB4crrrRHYP4pHdu5gfRbUv2/dpTpYyt1mb4rXRdzvjD
        j8Fos/UhQb16nMhJN0aVMnbRM6fkJUYdbo553DI=
X-Google-Smtp-Source: AGHT+IE9m+IX0s7oZYwozku7frA1dKIZ/wdMj3Y+CYYSZ5sAjVTdndqY6fOXWIpdYnnJaF7MUs0prM8xXNbY8ZmVOHo=
X-Received: by 2002:a05:6808:1904:b0:3a7:6385:28ac with SMTP id
 bf4-20020a056808190400b003a7638528acmr8990498oib.4.1692634984653; Mon, 21 Aug
 2023 09:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230821064759.94223-1-Arvind.Yadav@amd.com> <20230821064759.94223-3-Arvind.Yadav@amd.com>
In-Reply-To: <20230821064759.94223-3-Arvind.Yadav@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Aug 2023 12:22:53 -0400
Message-ID: <CADnq5_OBLh=fzsifOEhV3F2F1XGOcCujtVAba3KZ75MkY+tKHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Add new function to set GPU power profile
To:     Arvind Yadav <Arvind.Yadav@amd.com>
Cc:     Christian.Koenig@amd.com, alexander.deucher@amd.com,
        shashank.sharma@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Mon, Aug 21, 2023 at 2:55=E2=80=AFAM Arvind Yadav <Arvind.Yadav@amd.com>=
 wrote:
>
> This patch adds a function which will change the GPU
> power profile based on a submitted job. This can optimize
> the power performance when the workload is on.
>
> v2:
> - Splitting workload_profile_set and workload_profile_put
>   into two separate patches.
> - Addressed review comment.
>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c  | 56 +++++++++++++++++++
>  drivers/gpu/drm/amd/include/amdgpu_workload.h |  3 +
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_workload.c
> index 32166f482f77..e661cc5b3d92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c
> @@ -24,6 +24,62 @@
>
>  #include "amdgpu.h"
>
> +static enum PP_SMC_POWER_PROFILE
> +ring_to_power_profile(uint32_t ring_type)
> +{
> +       switch (ring_type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +               return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +               return PP_SMC_POWER_PROFILE_COMPUTE;
> +       case AMDGPU_RING_TYPE_UVD:
> +       case AMDGPU_RING_TYPE_VCE:
> +       case AMDGPU_RING_TYPE_UVD_ENC:
> +       case AMDGPU_RING_TYPE_VCN_DEC:
> +       case AMDGPU_RING_TYPE_VCN_ENC:
> +       case AMDGPU_RING_TYPE_VCN_JPEG:
> +               return PP_SMC_POWER_PROFILE_VIDEO;
> +       default:
> +               return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +       }
> +}
> +
> +static int
> +amdgpu_power_profile_set(struct amdgpu_device *adev,
> +                        enum PP_SMC_POWER_PROFILE profile)
> +{
> +       int ret =3D amdgpu_dpm_switch_power_profile(adev, profile, true);
> +
> +       if (!ret) {
> +               /* Set the bit for the submitted workload profile */
> +               adev->smu_workload.submit_workload_status |=3D (1 << prof=
ile);
> +               atomic_inc(&adev->smu_workload.power_profile_ref[profile]=
);
> +       }
> +
> +       return ret;
> +}
> +
> +void amdgpu_workload_profile_set(struct amdgpu_device *adev,
> +                                uint32_t ring_type)
> +{
> +       struct amdgpu_smu_workload *workload =3D &adev->smu_workload;
> +       enum PP_SMC_POWER_PROFILE profile =3D ring_to_power_profile(ring_=
type);
> +       int ret;
> +
> +       if (profile =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
> +               return;

Why is this one skipped?  How do we get back to the boot up profile?

Alex

> +
> +       mutex_lock(&workload->workload_lock);
> +
> +       ret =3D amdgpu_power_profile_set(adev, profile);
> +       if (ret) {
> +               DRM_WARN("Failed to set workload profile to %s, error =3D=
 %d\n",
> +                        amdgpu_workload_mode_name[profile], ret);
> +       }
> +
> +       mutex_unlock(&workload->workload_lock);
> +}
> +
>  void amdgpu_workload_profile_init(struct amdgpu_device *adev)
>  {
>         adev->smu_workload.adev =3D adev;
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_workload.h b/drivers/gpu/=
drm/amd/include/amdgpu_workload.h
> index 5d0f068422d4..5022f28fc2f9 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_workload.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_workload.h
> @@ -46,6 +46,9 @@ static const char * const amdgpu_workload_mode_name[] =
=3D {
>         "Window3D"
>  };
>
> +void amdgpu_workload_profile_set(struct amdgpu_device *adev,
> +                                uint32_t ring_type);
> +
>  void amdgpu_workload_profile_init(struct amdgpu_device *adev);
>
>  void amdgpu_workload_profile_fini(struct amdgpu_device *adev);
> --
> 2.34.1
>
