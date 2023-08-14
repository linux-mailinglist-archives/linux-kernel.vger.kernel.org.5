Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070A77BCE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjHNPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjHNPVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:21:09 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD41B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:21:08 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c4c6717e61so1320444fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692026467; x=1692631267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmXw42vYBpIHlr9RAwRjVQ1bt932a1P48E68S21Ma7s=;
        b=bz0d+t0taE/XIUwE5yB1i6jZO7iCZ2KpaIDT8A72j/OWZ9ZnAq2WtWvqTpnA0lXOOh
         EiK6ts7yrauGGPk8XTN4hp/4xuQyVo6TF15LEiLD8vvBJ5sy5fStHYab5oHja2SuEWVF
         6fK1Le9+BQAZo+bouWU8FvPcjTekIdFMdexnRGOLii/HhlXzMwmaTCa57zhRwLEdjzlP
         Wzh3Ag6VYpPgxpN/bsRg2xpqmcNIoZWcf6tIsoFDTVKiL0/qUm4zCtbEwGvR38bFofP2
         6430SWyVzXQC4Z/vhQxhrfvC3YwZGtX5lYbt6wgKHOHrsyItXwYAMDYb8HpOwABDOV9n
         4y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026468; x=1692631268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmXw42vYBpIHlr9RAwRjVQ1bt932a1P48E68S21Ma7s=;
        b=jmfj3yvfQyEUaw7Hmz7DjPZ2BQgZ1gB5nv0XmqOsXvozFjDJ+Xe14+Klahx9vdIFPt
         pZBHQ7eRg0FgD6RjXOY1k8FWqrhdktVAxEWwBtVFczmFKd9RAxzIGI1Nujsm6MOW3k78
         0+5mPPgqva3OLjjKwGkDQwb2lQ3mlsKVCJaMJg+apjV76sl0AaZE5USJrWPpQcEhWcHD
         IZookumHMZjsS7CBs2igeiiBgavhKO1UUbkHExBVFUPLNjd3o6GXE1EHsrMGMJSU0IEp
         dD7TNc61otQvodm9pSXlqicsjEZbTFZXpiu8e435oKpf3Jri0k7evhgO2m7G9n6xmj31
         SiMA==
X-Gm-Message-State: AOJu0YxpOkl4IXdeMly/zaMzrVJC+u8F47fG+l6lvfmeH2ILe6HbpsaV
        C5LbZ6wt6OpbzkIRFAQV7R/39HjK9c2QiOac+E345KGO
X-Google-Smtp-Source: AGHT+IExI1BCHAJZsWHfZXqnovYZQwJBpzrdyL8X1s0k+w/NekJG5/m8afptD7TkZqUpPpfaWYxJV6tDDX7GisZHzYY=
X-Received: by 2002:a05:6870:31c5:b0:1bb:4ec1:50ae with SMTP id
 x5-20020a05687031c500b001bb4ec150aemr10285499oac.24.1692026467748; Mon, 14
 Aug 2023 08:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230814073438.10682-1-Arvind.Yadav@amd.com> <20230814073438.10682-4-Arvind.Yadav@amd.com>
In-Reply-To: <20230814073438.10682-4-Arvind.Yadav@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Aug 2023 11:20:56 -0400
Message-ID: <CADnq5_M3_N-rXTcvsQ76QGo1bjBc92SPPHfwFayNbroq-Ph_iw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "drm/amd/amdgpu: switch on/off vcn power
 profile mode"
To:     Arvind Yadav <Arvind.Yadav@amd.com>
Cc:     Christian.Koenig@amd.com, alexander.deucher@amd.com,
        shashank.sharma@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

KFD also changes the profile when queues are active.  Please make sure
that is properly taken into account as well.

Alex

On Mon, Aug 14, 2023 at 3:36=E2=80=AFAM Arvind Yadav <Arvind.Yadav@amd.com>=
 wrote:
>
> This reverts commit 5ce71f59bb9bd3d8a09b96afdbc92975cb6dc303.
>
> Reason for revert: New amdgpu_smu* api is added to switch
> on/off profile mode. These new api will allow to change the
> GPU power profile based on a submitted job.
>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 2d94f1b63bd6..70777fcfa626 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -363,7 +363,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_=
struct *work)
>                 container_of(work, struct amdgpu_device, vcn.idle_work.wo=
rk);
>         unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0=
};
>         unsigned int i, j;
> -       int r =3D 0;
>
>         for (j =3D 0; j < adev->vcn.num_vcn_inst; ++j) {
>                 if (adev->vcn.harvest_config & (1 << j))
> @@ -392,10 +391,6 @@ static void amdgpu_vcn_idle_work_handler(struct work=
_struct *work)
>         if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
>                        AMD_PG_STATE_GATE);
> -               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> -                               false);
> -               if (r)
> -                       dev_warn(adev->dev, "(%d) failed to disable video=
 power profile mode\n", r);
>         } else {
>                 schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIME=
OUT);
>         }
> @@ -404,16 +399,11 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       int r =3D 0;
>
>         atomic_inc(&adev->vcn.total_submission_cnt);
>
> -       if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> -               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> -                               true);
> -               if (r)
> -                       dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
> -       }
> +       if (!cancel_delayed_work_sync(&adev->vcn.idle_work))
> +               amdgpu_gfx_off_ctrl(adev, false);
>
>         mutex_lock(&adev->vcn.vcn_pg_lock);
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
> --
> 2.34.1
>
