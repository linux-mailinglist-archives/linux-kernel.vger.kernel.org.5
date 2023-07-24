Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8376019B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGXV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGXV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:56:52 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37E118
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:56:51 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bb74752ddbso912055fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235811; x=1690840611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pN8GLV6mblrpyzl4xCBtTwLW6T0bqIm6dP2+4c2Ijg=;
        b=ex1Wo45D08B5F2BxqCHr1dwrTMI7e7zjs+AjJLkeYi14cZrldGKTq2l/qJkpVpH7s4
         lTgewYPuMEyXG6od4I0TuIJU3C5/qmnFu+4TAOtWSKm0TwFtBZiEFY0xJwGFdRRTvRgh
         2SPXaaSZM2HtbmtB8dbh0gaoS/S/x0KfsahSHkkXfLr2/o1dXDIAoChBs6kYinmOko2F
         MGlzCMF0039V6Jy2PqhaPf/6aY+ktsZKsyvdnZmsl2bn+Ch0dtE2EAiTEUAE98XbEFO4
         Nzw/fjQHB3GxedKwU7Oy5nRl2kFV/FwSlQOtgFJiZiAzA7/VyTG4AWcGdcfn66Y2GY7t
         MMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235811; x=1690840611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pN8GLV6mblrpyzl4xCBtTwLW6T0bqIm6dP2+4c2Ijg=;
        b=iPCcGVkvVVq+1oPTQ1+9e7f8gQB9ChIHLmfLGSfcpW1IR2tD0QGjct6eiRRMiPBCfH
         u6uUNFqcrpPHqm4aDzmJLsxgJoRho99lRKNlgfz0NlaL40Y6MUFeI5IErXFUQMRwBXRO
         mwqLqtQh50irfPzSVhMZcrUThG8pT5aKQi8TX6wLR5xCnXjnCmoXfWL1hmtm4ZxhyWUa
         QYnfYNNLewaI3YBImE4M2fVQcIys5mjro5DhOau6x6AOQpHDPy3FeIYTo1MnmZ7E5EoL
         4eMtgjBUIWUmBgfjgGSIgn3SDXMtE2m8ODV4Wo/DvG9VCNwLM1BmGmJrc9ElmAsWlJ+Z
         5H0A==
X-Gm-Message-State: ABy/qLZaVbii76QRKcvQ8a2oL8Hces0ZDh9XmsBSRk1hTvr35LIXMou0
        AfAY0Wj8wXbmIQm+unUQVoirarDQoWcb5086yRU=
X-Google-Smtp-Source: APBJJlGDsEk+lu7TEMF7QOIWoj98nmSPrGfYqGkKJGH9iJWRwyycyEi0//AJPXVHIEzwD2JOcGvt1Ci8pCBeeG0l/s0=
X-Received: by 2002:a05:6870:d14b:b0:1bb:6b9b:bc78 with SMTP id
 f11-20020a056870d14b00b001bb6b9bbc78mr5243129oac.42.1690235810709; Mon, 24
 Jul 2023 14:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230724085303.9607-1-xujianghui@cdjrlc.com> <c5575527bac1642f2cf896ae0ee9f582@208suo.com>
In-Reply-To: <c5575527bac1642f2cf896ae0ee9f582@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:56:39 -0400
Message-ID: <CADnq5_NXmmjFp02YqOyzKn2ta+6s_3KedUTq3Tu1o0jpNbGd=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v11_0_7_pptable.h
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one doesn't apply cleanly.

Alex

On Mon, Jul 24, 2023 at 4:54=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing whitespace
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   .../amd/pm/swsmu/inc/smu_v11_0_7_pptable.h    | 41 +++++++++----------
>   1 file changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> index 1cb399dbc7cc..64d60d48846a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> @@ -42,23 +42,23 @@
>   #define SMU_11_0_7_PP_POWERSAVINGCLOCK_VERSION            0x01
>   // Power Saving Clock Table Version 1.00
>
>   enum SMU_11_0_7_ODFEATURE_CAP {
> -    SMU_11_0_7_ODCAP_GFXCLK_LIMITS =3D 0,
> -    SMU_11_0_7_ODCAP_GFXCLK_CURVE,
> -    SMU_11_0_7_ODCAP_UCLK_LIMITS,
> -    SMU_11_0_7_ODCAP_POWER_LIMIT,
> -    SMU_11_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
> -    SMU_11_0_7_ODCAP_FAN_SPEED_MIN,
> -    SMU_11_0_7_ODCAP_TEMPERATURE_FAN,
> -    SMU_11_0_7_ODCAP_TEMPERATURE_SYSTEM,
> -    SMU_11_0_7_ODCAP_MEMORY_TIMING_TUNE,
> -    SMU_11_0_7_ODCAP_FAN_ZERO_RPM_CONTROL,
> -    SMU_11_0_7_ODCAP_AUTO_UV_ENGINE,
> -    SMU_11_0_7_ODCAP_AUTO_OC_ENGINE,
> -    SMU_11_0_7_ODCAP_AUTO_OC_MEMORY,
> +    SMU_11_0_7_ODCAP_GFXCLK_LIMITS =3D 0,
> +    SMU_11_0_7_ODCAP_GFXCLK_CURVE,
> +    SMU_11_0_7_ODCAP_UCLK_LIMITS,
> +    SMU_11_0_7_ODCAP_POWER_LIMIT,
> +    SMU_11_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
> +    SMU_11_0_7_ODCAP_FAN_SPEED_MIN,
> +    SMU_11_0_7_ODCAP_TEMPERATURE_FAN,
> +    SMU_11_0_7_ODCAP_TEMPERATURE_SYSTEM,
> +    SMU_11_0_7_ODCAP_MEMORY_TIMING_TUNE,
> +    SMU_11_0_7_ODCAP_FAN_ZERO_RPM_CONTROL,
> +    SMU_11_0_7_ODCAP_AUTO_UV_ENGINE,
> +    SMU_11_0_7_ODCAP_AUTO_OC_ENGINE,
> +    SMU_11_0_7_ODCAP_AUTO_OC_MEMORY,
>       SMU_11_0_7_ODCAP_FAN_CURVE,
>       SMU_11_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT,
> -    SMU_11_0_7_ODCAP_POWER_MODE,
> -    SMU_11_0_7_ODCAP_COUNT,
> +    SMU_11_0_7_ODCAP_POWER_MODE,
> +    SMU_11_0_7_ODCAP_COUNT,
>   };
>
>   enum SMU_11_0_7_ODFEATURE_ID {
> @@ -130,8 +130,7 @@ enum SMU_11_0_7_PWRMODE_SETTING {
>   };
>   #define SMU_11_0_7_MAX_PMSETTING      32        //Maximum Number of
> PowerMode Settings
>
> -struct smu_11_0_7_overdrive_table
> -{
> +struct smu_11_0_7_overdrive_table {
>       uint8_t  revision;
> //Revision =3D SMU_11_0_7_PP_OVERDRIVE_VERSION
>       uint8_t  reserve[3];                                      //Zero
> filled field reserved for future use
>       uint32_t feature_count;                                   //Total
> number of supported features
> @@ -160,8 +159,7 @@ enum SMU_11_0_7_PPCLOCK_ID {
>   };
>   #define SMU_11_0_7_MAX_PPCLOCK      16          //Maximum Number of PP
> Clocks
>
> -struct smu_11_0_7_power_saving_clock_table
> -{
> +struct smu_11_0_7_power_saving_clock_table {
>       uint8_t  revision;
> //Revision =3D SMU_11_0_7_PP_POWERSAVINGCLOCK_VERSION
>       uint8_t  reserve[3];                                      //Zero
> filled field reserved for future use
>       uint32_t count;
> //power_saving_clock_count =3D SMU_11_0_7_PPCLOCK_COUNT
> @@ -169,8 +167,7 @@ struct smu_11_0_7_power_saving_clock_table
>       uint32_t min[SMU_11_0_7_MAX_PPCLOCK];
> //PowerSavingClock Mode Clock Minimum array In MHz
>   };
>
> -struct smu_11_0_7_powerplay_table
> -{
> +struct smu_11_0_7_powerplay_table {
>         struct atom_common_table_header header;       //For
> sienna_cichlid, header.format_revision =3D 15, header.content_revision =
=3D 0
>         uint8_t  table_revision;                      //For
> sienna_cichlid, table_revision =3D 2
>         uint16_t table_size;                          //Driver portion
> table size. The offset to smc_pptable including header size
> @@ -178,7 +175,7 @@ struct smu_11_0_7_powerplay_table
>         uint32_t golden_revision;                     //PPGen use only:
> PP Table Revision on the Golden Data Base
>         uint16_t format_id;                           //PPGen use only:
> PPTable for different ASICs. For sienna_cichlid this should be 0x80
>         uint32_t platform_caps;
> //POWERPLAYABLE::ulPlatformCaps
> -
> +
>         uint8_t  thermal_controller_type;             //one of
> SMU_11_0_7_PP_THERMALCONTROLLER
>
>         uint16_t small_power_limit1;
