Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8FF772B54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjHGQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjHGQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:43:26 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5379D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:43:25 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a28de15c8aso3588451fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426604; x=1692031404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnJspdP6uFshcd/ClPJoHP/OplKyZfFGjP8C4TEvEX0=;
        b=GP5AjxymDdX6TPUAaEC8uc/2Xr8X4pwTOPjPy3RXD1RaNBARQFqTHQIVGcYspRpACx
         Ev8DfZTes/e3EcsFMn9HyCXFwUnC34bi+r9cq/nCavbhdzMZejL/gNFrVmPVPZqTnwU8
         cbGg4y3Tes4iI/759ZSwunBiQ0fquE3mqckX0tr2EpsPEXbJ+vs/oSVqJVzn4brjWkO2
         odhZMac7HXGvm1DOA3EfrcOria3ksRyz7ZkWdGKWLkqSSgdcOm1ThbzgHuZ81AU/uVcr
         q01/+M/Vne1T35C25Qfc5pdtMJCnwlZTNgbPO2tsMxKpVN++piqIR69Bo5wp8pzsAYeW
         zM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426604; x=1692031404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnJspdP6uFshcd/ClPJoHP/OplKyZfFGjP8C4TEvEX0=;
        b=PNnBytCB3OgOPwfyjPUzEvZM9e8F3D8uVTEYxrmtm9zAeAewRd9fXy6CeO8QoMP2wY
         aiGmSoLRs3E9rp1nba7Jjq/VTC+kOdzwbYc64WQgrs8pZUUD0F7k/3UnL7b/CEhIeZGY
         fYS68DbfMXpF3KrIgj9KVZ1A/V878kBdF/EmeGt2GI9z1jUMEsRFBwfwCI2pWH9EwHSp
         YB4ofQVHVgMZ3lebg8tqpmNd7NtXNkqxM6DJedQpE0Bwoj+jqmuiP49hnwP00vYMddwH
         R9fspdnDyGhC5zxyNKIcS9DwbGcFUtmQ9v+PnzesuiutJHYTwm2MHRpH4CHLDnTA11cA
         878Q==
X-Gm-Message-State: AOJu0YybqYhbxr9KHTC5+PHRhMWgMWLRSuQjoBX/Jg/SpoqMI0Mo8LdW
        b8yHyy6tYYRhWECrOrUeLloSIvJGTcg/fypimyM=
X-Google-Smtp-Source: AGHT+IHLSWBhQgqchaBUBCE8UV4V5n1zKpJe1asRH0MnfD/Ysu4F/DvU3E8c2WYCysDQbC1u4zoH5D1kb13yO5sZcm8=
X-Received: by 2002:a05:6871:821:b0:1bb:d808:da72 with SMTP id
 q33-20020a056871082100b001bbd808da72mr11632433oap.57.1691426604555; Mon, 07
 Aug 2023 09:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230801092821.7495-1-sunran001@208suo.com>
In-Reply-To: <20230801092821.7495-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:43:13 -0400
Message-ID: <CADnq5_NsAjYq=Fq8oSYYdfh+QB=TMgSjTZS+cLWWezunzzHU6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Clean up errors in vega20_hwmgr.c
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

On Tue, Aug 1, 2023 at 5:28=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: code indent should use tabs where possible
> ERROR: space required before the open parenthesis '('
> ERROR: space prohibited before that close parenthesis ')'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 4e19ccbdb807..492ca33637d6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -1402,7 +1402,7 @@ static int vega20_od8_set_settings(
>                         "Failed to export over drive table!",
>                         return ret);
>
> -       switch(index) {
> +       switch (index) {
>         case OD8_SETTING_GFXCLK_FMIN:
>                 od_table.GfxclkFmin =3D (uint16_t)value;
>                 break;
> @@ -2360,7 +2360,7 @@ static int vega20_notify_smc_display_config_after_p=
s_adjustment(
>                 dpm_table->dpm_state.hard_min_level =3D min_clocks.memory=
Clock / 100;
>                 PP_ASSERT_WITH_CODE(!(ret =3D smum_send_msg_to_smc_with_p=
arameter(hwmgr,
>                                 PPSMC_MSG_SetHardMinByFreq,
> -                               (PPCLK_UCLK << 16 ) | dpm_table->dpm_stat=
e.hard_min_level,
> +                               (PPCLK_UCLK << 16) | dpm_table->dpm_state=
.hard_min_level,
>                                 NULL)),
>                                 "[SetHardMinFreq] Set hard min uclk faile=
d!",
>                                 return ret);
> @@ -3579,7 +3579,7 @@ static int vega20_set_uclk_to_highest_dpm_level(str=
uct pp_hwmgr *hwmgr,
>                 dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_le=
vels[dpm_table->count - 1].value;
>                 PP_ASSERT_WITH_CODE(!(ret =3D smum_send_msg_to_smc_with_p=
arameter(hwmgr,
>                                 PPSMC_MSG_SetHardMinByFreq,
> -                               (PPCLK_UCLK << 16 ) | dpm_table->dpm_stat=
e.hard_min_level,
> +                               (PPCLK_UCLK << 16) | dpm_table->dpm_state=
.hard_min_level,
>                                 NULL)),
>                                 "[SetUclkToHightestDpmLevel] Set hard min=
 uclk failed!",
>                                 return ret);
> @@ -3605,7 +3605,7 @@ static int vega20_set_fclk_to_highest_dpm_level(str=
uct pp_hwmgr *hwmgr)
>                 dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_le=
vels[dpm_table->count - 1].value;
>                 PP_ASSERT_WITH_CODE(!(ret =3D smum_send_msg_to_smc_with_p=
arameter(hwmgr,
>                                 PPSMC_MSG_SetSoftMinByFreq,
> -                               (PPCLK_FCLK << 16 ) | dpm_table->dpm_stat=
e.soft_min_level,
> +                               (PPCLK_FCLK << 16) | dpm_table->dpm_state=
.soft_min_level,
>                                 NULL)),
>                                 "[SetFclkToHightestDpmLevel] Set soft min=
 fclk failed!",
>                                 return ret);
> @@ -3727,8 +3727,8 @@ static int vega20_apply_clocks_adjust_rules(struct =
pp_hwmgr *hwmgr)
>         uint32_t i, latency;
>
>         disable_mclk_switching =3D ((1 < hwmgr->display_config->num_displ=
ay) &&
> -                           !hwmgr->display_config->multi_monitor_in_sync=
) ||
> -                            vblank_too_short;
> +                               !hwmgr->display_config->multi_monitor_in_=
sync) ||
> +                               vblank_too_short;
>         latency =3D hwmgr->display_config->dce_tolerable_mclk_in_active_l=
atency;
>
>         /* gfxclk */
> --
> 2.17.1
>
