Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E0A782FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjHUSKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjHUSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:10:29 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A891113
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:10:27 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-570bfbce160so1240884eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692641426; x=1693246226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+0c1bNjfyE75s7K3UnnW2WkHRxi8bGxuKvtd+0Q9GI=;
        b=Tb9uEfNphCu8hcDHtBPD8r/V2l/kjy0FGiYp3yigc2F9RDO+UqFEJfEd+UwgTaM4nM
         vMcJ1pLAxK90GKPhZQ8HfTUXeKKi0P1jWo3Dk/nsFLEeJgehyTSqwvsBt02O9aUjZzTJ
         IC6Ra5Yqm0NlentpaxdoP7/rcllhyKVCKRp/y1BFa0yNwk7Mwbd/joA8L3YPwmMdyZzY
         j592z2l24otXgVUGbFS6PBsRLgSsTbgik3hXLlfzmYw5EFwl+efkQypb7LDecufZ5B15
         dsy52dPFJjpspzXqJgR6SF3EPmBmPgGZSGmfwYMh2DnI974Xltl292f12ZuV/JEwFbHW
         5AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641426; x=1693246226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+0c1bNjfyE75s7K3UnnW2WkHRxi8bGxuKvtd+0Q9GI=;
        b=HiVOjR2IZ9i+BunrnQPVUne4wcGRsV7HsVRFvJmhpHYJT/Bp00Gv7xbgTsfoM8gexx
         9SQsZDM+jTS4qqQa1GQU7X7eDtiR1eCIoF+1Tbz1tRhHD0zRsCyJEKdz9DHmfJlZfGPE
         w3vR4WP9UyfNH0q2ca61aaVwOLzD7yLAg0YvBVePaw4iyEDHGyDKlFjWKNBeuvvJre2l
         ezAvfd+oMZPHtTV71KfuRyNJFZuMX2GIgYH9fgPeAZeufxeDZXS2uMkFLj1T7SbNQavl
         HgRK9PFGV60xK+C7HaJH6mXF3K178AnnvnmTXuhbyBmVJ731VGbTDc6pOA30WhFqJd55
         KncQ==
X-Gm-Message-State: AOJu0YzzCIc/GYRp6SamIDzKQa3t8kb16oVv11ICrGmI0SpwFcDaFwcg
        EGdEipWn/eQz5n93f6gCKRA8Q+2b1YifjNQY98w=
X-Google-Smtp-Source: AGHT+IFhbVjJRJdxdPrJ2yLplShGDmXoxEQ7AAJXyDzbzvmGpIZRWM+xzz1Y2SCaJwO1Vomiz1h/CTfzx4K3L/uFqEw=
X-Received: by 2002:a4a:245a:0:b0:569:ac56:ca98 with SMTP id
 v26-20020a4a245a000000b00569ac56ca98mr7800374oov.3.1692641426484; Mon, 21 Aug
 2023 11:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230821064759.94223-1-Arvind.Yadav@amd.com> <20230821064759.94223-3-Arvind.Yadav@amd.com>
 <CADnq5_OBLh=fzsifOEhV3F2F1XGOcCujtVAba3KZ75MkY+tKHg@mail.gmail.com> <fff2391b-fc18-af9f-6fe0-7b4c6650dcdd@amd.com>
In-Reply-To: <fff2391b-fc18-af9f-6fe0-7b4c6650dcdd@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Aug 2023 14:10:15 -0400
Message-ID: <CADnq5_PYYy6D__49h6jud9vpbzhnyHh8wossNmzDqryxkcRnqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Add new function to set GPU power profile
To:     "Yadav, Arvind" <arvyadav@amd.com>
Cc:     Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
        alexander.deucher@amd.com, shashank.sharma@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Mon, Aug 21, 2023 at 1:54=E2=80=AFPM Yadav, Arvind <arvyadav@amd.com> wr=
ote:
>
>
> On 8/21/2023 9:52 PM, Alex Deucher wrote:
> > On Mon, Aug 21, 2023 at 2:55=E2=80=AFAM Arvind Yadav <Arvind.Yadav@amd.=
com> wrote:
> >> This patch adds a function which will change the GPU
> >> power profile based on a submitted job. This can optimize
> >> the power performance when the workload is on.
> >>
> >> v2:
> >> - Splitting workload_profile_set and workload_profile_put
> >>    into two separate patches.
> >> - Addressed review comment.
> >>
> >> Cc: Shashank Sharma <shashank.sharma@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c  | 56 +++++++++++++++++=
++
> >>   drivers/gpu/drm/amd/include/amdgpu_workload.h |  3 +
> >>   2 files changed, 59 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_workload.c
> >> index 32166f482f77..e661cc5b3d92 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c
> >> @@ -24,6 +24,62 @@
> >>
> >>   #include "amdgpu.h"
> >>
> >> +static enum PP_SMC_POWER_PROFILE
> >> +ring_to_power_profile(uint32_t ring_type)
> >> +{
> >> +       switch (ring_type) {
> >> +       case AMDGPU_RING_TYPE_GFX:
> >> +               return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> >> +       case AMDGPU_RING_TYPE_COMPUTE:
> >> +               return PP_SMC_POWER_PROFILE_COMPUTE;
> >> +       case AMDGPU_RING_TYPE_UVD:
> >> +       case AMDGPU_RING_TYPE_VCE:
> >> +       case AMDGPU_RING_TYPE_UVD_ENC:
> >> +       case AMDGPU_RING_TYPE_VCN_DEC:
> >> +       case AMDGPU_RING_TYPE_VCN_ENC:
> >> +       case AMDGPU_RING_TYPE_VCN_JPEG:
> >> +               return PP_SMC_POWER_PROFILE_VIDEO;
> >> +       default:
> >> +               return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> >> +       }
> >> +}
> >> +
> >> +static int
> >> +amdgpu_power_profile_set(struct amdgpu_device *adev,
> >> +                        enum PP_SMC_POWER_PROFILE profile)
> >> +{
> >> +       int ret =3D amdgpu_dpm_switch_power_profile(adev, profile, tru=
e);
> >> +
> >> +       if (!ret) {
> >> +               /* Set the bit for the submitted workload profile */
> >> +               adev->smu_workload.submit_workload_status |=3D (1 << p=
rofile);
> >> +               atomic_inc(&adev->smu_workload.power_profile_ref[profi=
le]);
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +void amdgpu_workload_profile_set(struct amdgpu_device *adev,
> >> +                                uint32_t ring_type)
> >> +{
> >> +       struct amdgpu_smu_workload *workload =3D &adev->smu_workload;
> >> +       enum PP_SMC_POWER_PROFILE profile =3D ring_to_power_profile(ri=
ng_type);
> >> +       int ret;
> >> +
> >> +       if (profile =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
> >> +               return;
> > Why is this one skipped?  How do we get back to the boot up profile?
>
> Hi Alex,
>
> enum PP_SMC_POWER_PROFILE {
>      PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT =3D 0x0,
>      PP_SMC_POWER_PROFILE_FULLSCREEN3D =3D 0x1,
>      PP_SMC_POWER_PROFILE_POWERSAVING  =3D 0x2,
>      PP_SMC_POWER_PROFILE_VIDEO        =3D 0x3,
>      PP_SMC_POWER_PROFILE_VR           =3D 0x4,
>      PP_SMC_POWER_PROFILE_COMPUTE      =3D 0x5,
>      PP_SMC_POWER_PROFILE_CUSTOM       =3D 0x6,
>      PP_SMC_POWER_PROFILE_WINDOW3D     =3D 0x7,
>      PP_SMC_POWER_PROFILE_COUNT,
> };
>
> These are all the profiles. We are using which is >
> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT.
> Now suppose the profile was DEFAULT and we set it to VIDEO, SMU will
> move the profile to a higher level.
> When we reset the VIDEO profile then SMU will move back to the DEFAULT on=
e.
>
> Our job is to set the profile and reset it after the job is done.
> SMU will take care to move to a higher profile and after reset, it will
> move back to DEFAULT.

I guess that is the part I'm missing.  How does the call to the SMU to
set the profile back to DEFAULT actually happen?  It seems that both
the put and get functions return early in this case.

Alex


Alex


>
> ThankYou,
> ~Arvind
>
> >
> > Alex
> >
> >> +
> >> +       mutex_lock(&workload->workload_lock);
> >> +
> >> +       ret =3D amdgpu_power_profile_set(adev, profile);
> >> +       if (ret) {
> >> +               DRM_WARN("Failed to set workload profile to %s, error =
=3D %d\n",
> >> +                        amdgpu_workload_mode_name[profile], ret);
> >> +       }
> >> +
> >> +       mutex_unlock(&workload->workload_lock);
> >> +}
> >> +
> >>   void amdgpu_workload_profile_init(struct amdgpu_device *adev)
> >>   {
> >>          adev->smu_workload.adev =3D adev;
> >> diff --git a/drivers/gpu/drm/amd/include/amdgpu_workload.h b/drivers/g=
pu/drm/amd/include/amdgpu_workload.h
> >> index 5d0f068422d4..5022f28fc2f9 100644
> >> --- a/drivers/gpu/drm/amd/include/amdgpu_workload.h
> >> +++ b/drivers/gpu/drm/amd/include/amdgpu_workload.h
> >> @@ -46,6 +46,9 @@ static const char * const amdgpu_workload_mode_name[=
] =3D {
> >>          "Window3D"
> >>   };
> >>
> >> +void amdgpu_workload_profile_set(struct amdgpu_device *adev,
> >> +                                uint32_t ring_type);
> >> +
> >>   void amdgpu_workload_profile_init(struct amdgpu_device *adev);
> >>
> >>   void amdgpu_workload_profile_fini(struct amdgpu_device *adev);
> >> --
> >> 2.34.1
> >>
