Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29977772A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjHGQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHGQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:25:51 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0F10CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:25:47 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a1fa977667so3582969fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425546; x=1692030346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WiRoo0vL6kJ0w8/dkfqWYfJVOit9SFqabx1jj5i4xE=;
        b=MvZlnZBWLkQV8gMSfR7hfCYwLdRhK3YICmTNiPt26cN+I+OrIUHngzBL+nCym/cPRX
         NdS2LnVSU9qr41ss0lf+5GBtc4Gwk1o2KvWB3WuBj2yOBk9ZVBz0CzCABKDKWb8TYci9
         4usW7ZHcm40vToln4809gQlVLasWfqPGB+DZGkJj5Mc8maib8t1a/0Tu7w0bmeqk9mDq
         bpKd+Omc4SGwT+76iqWRTidAWW54Fa/idbWR6lNei2QM7D+XLh1Dlrzs2rnrP3umd+FT
         fKk9LPRFPMYeWMkNrm5OS8zbcmtIHYWrKF2ZSKsrvfstf6EQe4P0PcmA92qhCxrhIk57
         Wa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425546; x=1692030346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WiRoo0vL6kJ0w8/dkfqWYfJVOit9SFqabx1jj5i4xE=;
        b=HBFdbWCCBKAH5p4oIrH10rhjF4oTt7WawmRr0hwcCeInkpfXBu3icU8S0p02soe/ZM
         h0yl13YRqrvVsuNJgYaLa09LtCgNC2tYNuYh3us06URcCCXJW2Y9eoN4KV6iDHUfUVAe
         f0jffDCgK31UKMUxmzatB/aBXo8Du9SVrFQEN/9ONJpSgpWGCu7Qn7RkIYwQ1aaQDECD
         AN2w3FGPFeL/wc7RfZuy181cvDGqsC5M/fMtolb4Axc6Cy1IcM/Wg2U7kSprB/dkRMHo
         q7ef1m2jv4LFkIHAG8z1MiHytygjomsFMkKdQ46rWqtbhCYOnVAslWqsTpDkUg05VkfZ
         Qujg==
X-Gm-Message-State: AOJu0Yy3vqEd8nq4vQ0c0gOJ4wypT40EiW88Rheftdz66J+6UWr2c/5g
        9t42G5PBaGeG15uvIuHoidvTkEmYsUbsYfd5rVY=
X-Google-Smtp-Source: AGHT+IFg5y/8EPsteDlZHT0mE68zLPv3NjXJQrYnMkt2dG/pGwKCgDInQFjJZaPyiy8PnosX7rv/QyIDNJa+dA7mxBY=
X-Received: by 2002:a05:6870:d147:b0:1b0:653a:af92 with SMTP id
 f7-20020a056870d14700b001b0653aaf92mr11357377oac.8.1691425546593; Mon, 07 Aug
 2023 09:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230801025703.4979-1-sunran001@208suo.com>
In-Reply-To: <20230801025703.4979-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:25:35 -0400
Message-ID: <CADnq5_NLSmco8_zs7pt9KSr7hia-2HcjpLR6PEN6YLZs3Nf=7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega12_hwmgr.c
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

On Mon, Jul 31, 2023 at 10:57=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: need consistent spacing around '/' (ctx:WxV)
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index 1937be1cf5b4..4bd573d815ff 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1623,13 +1623,13 @@ static int vega12_notify_smc_display_config_after=
_ps_adjustment(
>
>         if (data->smu_features[GNLD_DPM_DCEFCLK].supported) {
>                 clock_req.clock_type =3D amd_pp_dcef_clock;
> -               clock_req.clock_freq_in_khz =3D min_clocks.dcefClock/10;
> +               clock_req.clock_freq_in_khz =3D min_clocks.dcefClock / 10=
;
>                 if (!vega12_display_clock_voltage_request(hwmgr, &clock_r=
eq)) {
>                         if (data->smu_features[GNLD_DS_DCEFCLK].supported=
)
>                                 PP_ASSERT_WITH_CODE(
>                                         !smum_send_msg_to_smc_with_parame=
ter(
>                                         hwmgr, PPSMC_MSG_SetMinDeepSleepD=
cefclk,
> -                                       min_clocks.dcefClockInSR /100,
> +                                       min_clocks.dcefClockInSR / 100,
>                                         NULL),
>                                         "Attempt to set divider for DCEFC=
LK Failed!",
>                                         return -1);
> @@ -2354,8 +2354,8 @@ static int vega12_apply_clocks_adjust_rules(struct =
pp_hwmgr *hwmgr)
>         uint32_t i, latency;
>
>         disable_mclk_switching =3D ((1 < hwmgr->display_config->num_displ=
ay) &&
> -                                 !hwmgr->display_config->multi_monitor_i=
n_sync) ||
> -                                 vblank_too_short;
> +                               !hwmgr->display_config->multi_monitor_in_=
sync) ||
> +                               vblank_too_short;
>         latency =3D hwmgr->display_config->dce_tolerable_mclk_in_active_l=
atency;
>
>         /* gfxclk */
> @@ -2522,7 +2522,7 @@ static int vega12_set_uclk_to_highest_dpm_level(str=
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
> --
> 2.17.1
>
