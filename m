Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D1782FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjHUSGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHUSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:06:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4144E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:06:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a81c593206so2534399b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692641195; x=1693245995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqax+MnI9SXQoENwXtIv+o1Bq2aoIE2picQ2A155qEY=;
        b=OYrAalsTqJXXhtG693ybwysvn7+k8VuDktHSQP9TH1WoK1tUbIPErm8V2fOUnUTgqo
         lz1EFR1XDZqBD+dtpGuRNXms+YdARLA9j6MvuvMl7iRRIoI+WreK/uuQCf9bWDIW0MYC
         +nl+z0NnVxsmx7pk2AKbE9sRaW0jySWVrmeacGazzpObsJdyB83pB+NjSgN7M7W9SLO3
         ynb4gUtBXFE5c3amfNZ6x9tjcjFZfxaCFgAqgpg1gDnFXRsgKAa4bioPp0jPRrHDumqc
         p/EfK9WBTZiC/YHxyagY5h9UAGW2jsTSMrnHia7fqmriCMWIUQ88KBGuvvtapvIYb1gJ
         MHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641195; x=1693245995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqax+MnI9SXQoENwXtIv+o1Bq2aoIE2picQ2A155qEY=;
        b=G+DmhJrXxI8h0LhDBiV+U0jsZORIGCVsbwyGXHLWEEd7f5YgKpuwgC1Jgtf3sUqGpV
         okh7PhdO+KTUrRKsPWgDXS0OA1/ax9h9fdTe+WjCq3+TLbTIQ9wikatg9E7UNfpEzrA8
         n1pmYpGsVQneI4s28J+w7BkxQ0VqQWROwZ1gwQLI7UfT6shBl6faRXXivKZ3xINDXhce
         gBm/hoFQ95SLDCUoKshhXUW5IK9cfnNKYcZa2HYng3dmxgSqAKl70taKEVNiO9crjWaw
         Ft2kOkA81wczogkA+nWQuqZDhALUsWI4uJLqAuo2awZHpSdsXUBWepat4ukESYkbwj71
         AGpQ==
X-Gm-Message-State: AOJu0YxVuKB4HTgM1qaStnUd5Hce6hMDxtq9x4l+zEBC8OtGLwp2hQ9T
        jw+WJofw2CK8U53HolI3vqaOsY+Rfu50RO5OmSU=
X-Google-Smtp-Source: AGHT+IEgrnJRbjoQCFPUCDgD32rzZanVrFjvgAt52ST2/EKn+YbV3CkRQoeq3EfzGk9Ay0eMEyGTwFX49fkerZzByZ0=
X-Received: by 2002:a05:6808:211b:b0:3a6:f5db:a86c with SMTP id
 r27-20020a056808211b00b003a6f5dba86cmr5635708oiw.1.1692641195090; Mon, 21 Aug
 2023 11:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230821064759.94223-1-Arvind.Yadav@amd.com> <20230821064759.94223-3-Arvind.Yadav@amd.com>
In-Reply-To: <20230821064759.94223-3-Arvind.Yadav@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Aug 2023 14:06:24 -0400
Message-ID: <CADnq5_PreqOHyhF2v5FxViJcBO2RKjEjCCE2_RoYXoD66TX4eA@mail.gmail.com>
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

Maybe rename this amdgpu_workload_profile_get() to align with put/get
naming semantics?

Alex

> +{
> +       struct amdgpu_smu_workload *workload =3D &adev->smu_workload;
> +       enum PP_SMC_POWER_PROFILE profile =3D ring_to_power_profile(ring_=
type);
> +       int ret;
> +
> +       if (profile =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
> +               return;
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
