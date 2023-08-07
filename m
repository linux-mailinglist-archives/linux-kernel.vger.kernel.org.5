Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB2772B38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHGQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjHGQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:39:55 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C8F198C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:39:30 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so3606396fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426369; x=1692031169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9yUnR7nsNv1o01EBdb9R3AQ7xuPUTH6LIX5UBFQZMY=;
        b=oPDur4jPpCx7f7YzSeCLQreLcbz3FpnWjb31PqKtTs/7xpN56hWgNhgNaxyVPYENKp
         s8mmGGiw0V/Jz17uI3cw/YudyAWmKvPxD569K+iLUJMCAXQpOiN0mAKABp5FPpPVfkVF
         NTgI+ZSvpczr4O88ygMMktyh1MdaNPmJCRqZdBPlg4q6A9qMTBkuWqN6GCDEgN+SnQH8
         tcMmUUi2pqAgYQtFL4jDd+oW68zzb8spLZ8v5Nq4YmJU37L+1omU4KtflQwRD49CC0fW
         XEz2Bpvf4k31FltocClFuBhOIPHWSY4hAk79QDE0fTEwlR9N59afFAWlv4UDz2gGysfr
         dkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426369; x=1692031169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9yUnR7nsNv1o01EBdb9R3AQ7xuPUTH6LIX5UBFQZMY=;
        b=AZ4qeF/9PgwIgJBrBtMtzcqqfpJe28JIRbB31ELvfK6EDUhZicJusdcxfHO6/Z3kNg
         7LWW1D35wk5rdFP4CU9CIIkWRCNBj68/Sle1h387RAZxM9jIUnsgP1llkNn4IohV0cHa
         3A3TzQ14M4H05G1z1l4PDow6LJQkMmDNd4Rt+5uVufmW0ULaZOalFu+dhDLbtQWevEWv
         235KJE1tXTqN3aIB4KX5wl3wQfRB/Hon8d0c5bKkxjwcKNW6ESSHMaMhty3zwttmSu5A
         fo4qJRYQYwNzDxEeQvgd/kyIxD/FOYcKY8S0mxorBGfNSXTuYYrdTcXFlYL9AO+mt0t7
         tY1g==
X-Gm-Message-State: AOJu0Yz419iQmd/BLdF7Cy1gFKd3oEyqtbyLXPN1gqXo0gGYNsWgMGMJ
        mSqbtZlTGGLkh7QDSy1Q+cHMKfhOvPH4gT7tXHI=
X-Google-Smtp-Source: AGHT+IE2GPyyJrHzsARaHdO1xvxFVTB/cNtv7O0obdNL10a/BLlwOtmxjQnADH7tMInZQ4OAGW90SEy9TdTjEnoUplg=
X-Received: by 2002:a05:6870:ac12:b0:1bf:7c28:9483 with SMTP id
 kw18-20020a056870ac1200b001bf7c289483mr11514890oab.38.1691426369387; Mon, 07
 Aug 2023 09:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090022.6923-1-sunran001@208suo.com>
In-Reply-To: <20230801090022.6923-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:39:18 -0400
Message-ID: <CADnq5_Oe8gktj8EMc3dRkbd=LojOiCh8W1MoEghOJnRA+eRW8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Clean up errors in smu7_hwmgr.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 5:00=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: spaces required around that '=3D' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 26 +++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 1cb402264497..425859682fab 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -83,15 +83,15 @@
>  #define PCIE_BUS_CLK                10000
>  #define TCLK                        (PCIE_BUS_CLK / 10)
>
> -static struct profile_mode_setting smu7_profiling[7] =3D
> -                                       {{0, 0, 0, 0, 0, 0, 0, 0},
> +static struct profile_mode_setting smu7_profiling[7] =3D {
> +                                        {0, 0, 0, 0, 0, 0, 0, 0},
>                                          {1, 0, 100, 30, 1, 0, 100, 10},
>                                          {1, 10, 0, 30, 0, 0, 0, 0},
>                                          {0, 0, 0, 0, 1, 10, 16, 31},
>                                          {1, 0, 11, 50, 1, 0, 100, 10},
>                                          {1, 0, 5, 30, 0, 0, 0, 0},
>                                          {0, 0, 0, 0, 0, 0, 0, 0},
> -                                       };
> +};
>
>  #define PPSMC_MSG_SetVBITimeout_VEGAM    ((uint16_t) 0x310)
>
> @@ -950,7 +950,7 @@ static int smu7_odn_initial_default_setting(struct pp=
_hwmgr *hwmgr)
>         odn_table->odn_core_clock_dpm_levels.num_of_pl =3D
>                                                 data->golden_dpm_table.sc=
lk_table.count;
>         entries =3D odn_table->odn_core_clock_dpm_levels.entries;
> -       for (i=3D0; i<data->golden_dpm_table.sclk_table.count; i++) {
> +       for (i =3D 0; i < data->golden_dpm_table.sclk_table.count; i++) {
>                 entries[i].clock =3D data->golden_dpm_table.sclk_table.dp=
m_levels[i].value;
>                 entries[i].enabled =3D true;
>                 entries[i].vddc =3D dep_sclk_table->entries[i].vddc;
> @@ -962,7 +962,7 @@ static int smu7_odn_initial_default_setting(struct pp=
_hwmgr *hwmgr)
>         odn_table->odn_memory_clock_dpm_levels.num_of_pl =3D
>                                                 data->golden_dpm_table.mc=
lk_table.count;
>         entries =3D odn_table->odn_memory_clock_dpm_levels.entries;
> -       for (i=3D0; i<data->golden_dpm_table.mclk_table.count; i++) {
> +       for (i =3D 0; i < data->golden_dpm_table.mclk_table.count; i++) {
>                 entries[i].clock =3D data->golden_dpm_table.mclk_table.dp=
m_levels[i].value;
>                 entries[i].enabled =3D true;
>                 entries[i].vddc =3D dep_mclk_table->entries[i].vddc;
> @@ -1813,13 +1813,13 @@ static void smu7_init_dpm_defaults(struct pp_hwmg=
r *hwmgr)
>         data->static_screen_threshold =3D SMU7_STATICSCREENTHRESHOLD_DFLT=
;
>         data->static_screen_threshold_unit =3D SMU7_STATICSCREENTHRESHOLD=
UNIT_DFLT;
>         data->voting_rights_clients[0] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT0=
;
> -       data->voting_rights_clients[1]=3D SMU7_VOTINGRIGHTSCLIENTS_DFLT1;
> +       data->voting_rights_clients[1] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT1=
;
>         data->voting_rights_clients[2] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT2=
;
> -       data->voting_rights_clients[3]=3D SMU7_VOTINGRIGHTSCLIENTS_DFLT3;
> -       data->voting_rights_clients[4]=3D SMU7_VOTINGRIGHTSCLIENTS_DFLT4;
> -       data->voting_rights_clients[5]=3D SMU7_VOTINGRIGHTSCLIENTS_DFLT5;
> -       data->voting_rights_clients[6]=3D SMU7_VOTINGRIGHTSCLIENTS_DFLT6;
> -       data->voting_rights_clients[7]=3D SMU7_VOTINGRIGHTSCLIENTS_DFLT7;
> +       data->voting_rights_clients[3] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT3=
;
> +       data->voting_rights_clients[4] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT4=
;
> +       data->voting_rights_clients[5] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT5=
;
> +       data->voting_rights_clients[6] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT6=
;
> +       data->voting_rights_clients[7] =3D SMU7_VOTINGRIGHTSCLIENTS_DFLT7=
;
>
>         data->mclk_dpm_key_disabled =3D hwmgr->feature_mask & PP_MCLK_DPM=
_MASK ? false : true;
>         data->sclk_dpm_key_disabled =3D hwmgr->feature_mask & PP_SCLK_DPM=
_MASK ? false : true;
> @@ -2002,7 +2002,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr =
*hwmgr)
>         } else if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision=
) ||
>                    ASICID_IS_P31(adev->pdev->device, adev->pdev->revision=
)) {
>                 min =3D 900;
> -               max=3D 2100;
> +               max =3D 2100;
>         } else if (hwmgr->chip_id =3D=3D CHIP_POLARIS10) {
>                 if (adev->pdev->subsystem_vendor =3D=3D 0x106B) {
>                         min =3D 1000;
> @@ -4018,7 +4018,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr,=
 int idx,
>                 offset =3D data->soft_regs_start + smum_get_offsetof(hwmg=
r,
>                                                                 SMU_SoftR=
egisters,
>                                                                 (idx =3D=
=3D AMDGPU_PP_SENSOR_GPU_LOAD) ?
> -                                                               AverageGr=
aphicsActivity:
> +                                                               AverageGr=
aphicsActivity :
>                                                                 AverageMe=
moryActivity);
>
>                 activity_percent =3D cgs_read_ind_register(hwmgr->device,=
 CGS_IND_REG__SMC, offset);
> --
> 2.17.1
>
