Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1691772A70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjHGQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHGQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:21:06 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF810D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:21:05 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca38a6618so4036313a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425265; x=1692030065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qdhSHKQRIMTZzpksAfKTLhsTCnLJ8e90lPKFhVQAZo=;
        b=bvhiDDHiteijaY/QjGL96LOgdtUIXutA20l3dKbKx5vF65uC7pO8E37gF0qFen70fZ
         YWlikcaVtC/4FgGMBx2xbw5QU944OaCj5/Pl04yh+IYho/PPRMLaUqFGRoYdIB26SCfA
         3xoZ8FpzOu4dJL7hzdPEH2jyAj1XsnnIQjkzlbywdY3KJuYevgzK8W4kNmjwqvGT3V31
         d8I/PDe5S2LczaqsiXBRvX9FKfpAIob8PjPddv34Cy5v6kBpd7NEo/HWeaALL4Bwg2yD
         WuZcmHIWZZFtLcmTUw8lfH9ko3DBxagu/DrGQOfoc1ezwnksE0gp2Sot/hwZkf9xSqer
         SRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425265; x=1692030065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qdhSHKQRIMTZzpksAfKTLhsTCnLJ8e90lPKFhVQAZo=;
        b=JaQ9D7w+AXuO5bcq0uodSIJVmFlHoD+DtuzWKd0u6llBx8Ujc+zwRcxubdl9Z7nb7O
         bvp9DdlqBQrHVszfhhhyBo51rSK56vyz+Sq7/YrP1rALGLIAT9uEyTREtX9La4i99m4E
         puVZHCSjERvNJur3qp7tUMZwMLSyOftfuYHD8aZFiBKFr/u+IPDbisgOVDNJ9BG/Fj95
         RgtYBO7fpecZ/7ci5nHWKswgc2spSNTtJStsMWK9xP+PyvUtX96wLKT+N7fpT8nOxxmz
         HHhXKkZXmct/B7p2gWpcFcnP5HrMPVS6GLrvyD/0WwJjxIQiRfNW4gkL1BQbVEKFYE+6
         3rKw==
X-Gm-Message-State: AOJu0Yx28sMcqv6otjzqPHdVVkfeYBzG9A7c1FEc8jEb3ZjerSS0c+VH
        8xEK3bQcd8SH+UKMll4YS5MTQx9JR+OI0qy9bddIDkQF
X-Google-Smtp-Source: AGHT+IEBgJHKm4YZQsiROKtAjjgXuEh7bfHD2CzK9d1Yg8UYoKcOAC62IPpoaO/VmasLCDJ4K+m+OHzfabjSQRTa0ZE=
X-Received: by 2002:a05:6870:5b9c:b0:1ba:dbbd:31cf with SMTP id
 em28-20020a0568705b9c00b001badbbd31cfmr10688237oab.7.1691425264743; Mon, 07
 Aug 2023 09:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230801020052.4192-1-sunran001@208suo.com>
In-Reply-To: <20230801020052.4192-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:20:53 -0400
Message-ID: <CADnq5_O9oAvxwcd5x5aAiXbDF36GeO6hnRGySr0rkHcXWtMXUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in aldebaran_ppt.c
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

On Mon, Jul 31, 2023 at 10:01=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '=3D' (ctx:VxW)
> ERROR: else should follow close brace '}'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index ce50ef46e73f..8f26123ac703 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -94,8 +94,7 @@
>   */
>  #define SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION 0x00443300
>
> -static const struct smu_temperature_range smu13_thermal_policy[] =3D
> -{
> +static const struct smu_temperature_range smu13_thermal_policy[] =3D {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
>  };
> @@ -196,7 +195,7 @@ static const struct cmn2asic_mapping aldebaran_featur=
e_mask_map[SMU_FEATURE_COUN
>         ALDEBARAN_FEA_MAP(SMU_FEATURE_FW_CTF_BIT,                        =
       FEATURE_FW_CTF_BIT),
>         ALDEBARAN_FEA_MAP(SMU_FEATURE_THERMAL_BIT,                       =
       FEATURE_THERMAL_BIT),
>         ALDEBARAN_FEA_MAP(SMU_FEATURE_OUT_OF_BAND_MONITOR_BIT,  FEATURE_O=
UT_OF_BAND_MONITOR_BIT),
> -       ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,FEATURE_X=
GMI_PER_LINK_PWR_DWN),
> +       ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT, FEATURE_=
XGMI_PER_LINK_PWR_DWN),
>         ALDEBARAN_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT,                    F=
EATURE_DF_CSTATE),
>  };
>
> @@ -580,7 +579,7 @@ static int aldebaran_get_smu_metrics_data(struct smu_=
context *smu,
>                                           MetricsMember_t member,
>                                           uint32_t *value)
>  {
> -       struct smu_table_context *smu_table=3D &smu->smu_table;
> +       struct smu_table_context *smu_table =3D &smu->smu_table;
>         SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_tabl=
e;
>         int ret =3D 0;
>
> @@ -1906,8 +1905,7 @@ static int aldebaran_mode1_reset(struct smu_context=
 *smu)
>         smu_cmn_get_smc_version(smu, NULL, &smu_version);
>         if (smu_version < 0x00440700) {
>                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NUL=
L);
> -       }
> -       else {
> +       } else {
>                 /* fatal error triggered by ras, PMFW supports the flag
>                    from 68.44.0 */
>                 if ((smu_version >=3D 0x00442c00) && ras &&
> @@ -2116,7 +2114,7 @@ static const struct pptable_funcs aldebaran_ppt_fun=
cs =3D {
>         .register_irq_handler =3D smu_v13_0_register_irq_handler,
>         .set_azalia_d3_pme =3D smu_v13_0_set_azalia_d3_pme,
>         .get_max_sustainable_clocks_by_dc =3D smu_v13_0_get_max_sustainab=
le_clocks_by_dc,
> -       .baco_is_support=3D aldebaran_is_baco_supported,
> +       .baco_is_support =3D aldebaran_is_baco_supported,
>         .get_dpm_ultimate_freq =3D smu_v13_0_get_dpm_ultimate_freq,
>         .set_soft_freq_limited_range =3D aldebaran_set_soft_freq_limited_=
range,
>         .od_edit_dpm_table =3D aldebaran_usr_edit_dpm_table,
> --
> 2.17.1
>
