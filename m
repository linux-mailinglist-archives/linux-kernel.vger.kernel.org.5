Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D0760136
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGXVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGXVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:32:55 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C9D8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:32:53 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b06a46e1a9so3714936fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234373; x=1690839173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8e7IVYcBlwWQNVn4hiDgg6+74rwVgl9W2gxpOOqptdY=;
        b=Zo2AvV9fkAyjihS/UohAmVp234u06qw+uvOuBth7GnflnCivBCUkFUGCFw6SGdhvII
         YzCSVvOifZjnlU2DXZQlRMIjVjdMqXCvKFPksXjFFfHBou8G31Zmu6Y/3VFI0PsOeJIU
         qQkOWMKSHwDx4rzFC9b/H8keg5gp1Mmhj3Zcjsl3MZh2tJVw1U3sLWTaXRFFoWDNPada
         R932Uw0wEmOU1McVaK0gQiithwtyQBg5c4dQyG4vjG+kNyn2HJju8ZE61UQZq0Es1dCh
         DB79ZZyhy+Od96KAHBrELvs27mW31foBqA0nYDaR8dP+vrUuHBlaLa214yMHIpRFMwEs
         Kd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234373; x=1690839173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8e7IVYcBlwWQNVn4hiDgg6+74rwVgl9W2gxpOOqptdY=;
        b=k1iUrteo8axxl9HZ/ztL8ArA2mIYENxkElbwI70eOYEOiPeSZ0LEeeha1VLw1GQTa/
         +95ndaUW+2q04n2grCsfZemeVpVD1odajRkdGdCx90dm0ItLRmouC3EtfimY2y8YSU+v
         ZS8XcznJnryxhBiy4zkfuRG54zq0koOrbPm9pRErrp2nR/N2ELT85IwusBAEKcsSqWWn
         OoAlJMpRHK6WgMXuzT4Qt/3q4GYOLN637hGZBljZi5LJbeFWdFDvMpETB/9kMqadAftv
         LeWpE3drUTgGE5+fF+zU/rDWGWjAkqgyzEmKiDsJlKI5uPP4yi23Cgx+3taGr2Mc6mKO
         GA8w==
X-Gm-Message-State: ABy/qLbzDUU1lLPUaUrY0zGQXPRtxutB6jRufPFvMqReSla82JpAT8IC
        msMaR9h+p3woSh81p9vqlTbQzoILyz2KlZHBVhI=
X-Google-Smtp-Source: APBJJlECIFk7DDioyHbB/3O/WDvts2+uG4y5qmauwMJaMiBVZfRdI50fPuHApdf6W/vqNI8yjkkz6MlkhgpNe7yGNzE=
X-Received: by 2002:a05:6870:a2c9:b0:1ba:df9e:f2e9 with SMTP id
 w9-20020a056870a2c900b001badf9ef2e9mr12602392oak.0.1690234373108; Mon, 24 Jul
 2023 14:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230724025235.7416-1-xujianghui@cdjrlc.com> <51039d36001a36bd132397164045d6c6@208suo.com>
In-Reply-To: <51039d36001a36bd132397164045d6c6@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:32:41 -0400
Message-ID: <CADnq5_NN8zMzETHK+RsqiGbuEcWNP9jDie2cPMZ1QjnMkiWtjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/si_dpm: open brace '{' following struct go on
 the same line
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Applied.  Thanks.

Alex

On Sun, Jul 23, 2023 at 10:55=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/sislands_smc.h | 51 +++++++++------------------
>   1 file changed, 17 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/sislands_smc.h
> b/drivers/gpu/drm/radeon/sislands_smc.h
> index 4ea1cb2e45a3..4b7dee3cf58b 100644
> --- a/drivers/gpu/drm/radeon/sislands_smc.h
> +++ b/drivers/gpu/drm/radeon/sislands_smc.h
> @@ -89,8 +89,7 @@ struct PP_SIslands_PAPMStatus
>   };
>   typedef struct PP_SIslands_PAPMStatus PP_SIslands_PAPMStatus;
>
> -struct PP_SIslands_PAPMParameters
> -{
> +struct PP_SIslands_PAPMParameters {
>       uint32_t    NearTDPLimitTherm;
>       uint32_t    NearTDPLimitPAPM;
>       uint32_t    PlatformPowerLimit;
> @@ -100,8 +99,7 @@ struct PP_SIslands_PAPMParameters
>   };
>   typedef struct PP_SIslands_PAPMParameters PP_SIslands_PAPMParameters;
>
> -struct SISLANDS_SMC_SCLK_VALUE
> -{
> +struct SISLANDS_SMC_SCLK_VALUE {
>       uint32_t    vCG_SPLL_FUNC_CNTL;
>       uint32_t    vCG_SPLL_FUNC_CNTL_2;
>       uint32_t    vCG_SPLL_FUNC_CNTL_3;
> @@ -113,8 +111,7 @@ struct SISLANDS_SMC_SCLK_VALUE
>
>   typedef struct SISLANDS_SMC_SCLK_VALUE SISLANDS_SMC_SCLK_VALUE;
>
> -struct SISLANDS_SMC_MCLK_VALUE
> -{
> +struct SISLANDS_SMC_MCLK_VALUE {
>       uint32_t    vMPLL_FUNC_CNTL;
>       uint32_t    vMPLL_FUNC_CNTL_1;
>       uint32_t    vMPLL_FUNC_CNTL_2;
> @@ -129,8 +126,7 @@ struct SISLANDS_SMC_MCLK_VALUE
>
>   typedef struct SISLANDS_SMC_MCLK_VALUE SISLANDS_SMC_MCLK_VALUE;
>
> -struct SISLANDS_SMC_VOLTAGE_VALUE
> -{
> +struct SISLANDS_SMC_VOLTAGE_VALUE {
>       uint16_t    value;
>       uint8_t     index;
>       uint8_t     phase_settings;
> @@ -138,8 +134,7 @@ struct SISLANDS_SMC_VOLTAGE_VALUE
>
>   typedef struct SISLANDS_SMC_VOLTAGE_VALUE SISLANDS_SMC_VOLTAGE_VALUE;
>
> -struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
> -{
> +struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL {
>       uint8_t                     ACIndex;
>       uint8_t                     displayWatermark;
>       uint8_t                     gen2PCIE;
> @@ -180,8 +175,7 @@ struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
>
>   typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
> SISLANDS_SMC_HW_PERFORMANCE_LEVEL;
>
> -struct SISLANDS_SMC_SWSTATE
> -{
> +struct SISLANDS_SMC_SWSTATE {
>         uint8_t                             flags;
>         uint8_t                             levelCount;
>         uint8_t                             padding2;
> @@ -205,8 +199,7 @@ struct SISLANDS_SMC_SWSTATE_SINGLE {
>   #define SISLANDS_SMC_VOLTAGEMASK_VDDC_PHASE_SHEDDING 3
>   #define SISLANDS_SMC_VOLTAGEMASK_MAX   4
>
> -struct SISLANDS_SMC_VOLTAGEMASKTABLE
> -{
> +struct SISLANDS_SMC_VOLTAGEMASKTABLE {
>       uint32_t lowMask[SISLANDS_SMC_VOLTAGEMASK_MAX];
>   };
>
> @@ -214,8 +207,7 @@ typedef struct SISLANDS_SMC_VOLTAGEMASKTABLE
> SISLANDS_SMC_VOLTAGEMASKTABLE;
>
>   #define SISLANDS_MAX_NO_VREG_STEPS 32
>
> -struct SISLANDS_SMC_STATETABLE
> -{
> +struct SISLANDS_SMC_STATETABLE {
>         uint8_t                                 thermalProtectType;
>         uint8_t                                 systemFlags;
>         uint8_t                                 maxVDDCIndexInPPTable;
> @@ -254,8 +246,7 @@ typedef struct SISLANDS_SMC_STATETABLE
> SISLANDS_SMC_STATETABLE;
>   #define SI_SMC_SOFT_REGISTER_svi_rework_gpio_id_svd   0x11c
>   #define SI_SMC_SOFT_REGISTER_svi_rework_gpio_id_svc   0x120
>
> -struct PP_SIslands_FanTable
> -{
> +struct PP_SIslands_FanTable {
>         uint8_t  fdo_mode;
>         uint8_t  padding;
>         int16_t  temp_min;
> @@ -285,8 +276,7 @@ typedef struct PP_SIslands_FanTable
> PP_SIslands_FanTable;
>   #define SMC_SISLANDS_SCALE_I  7
>   #define SMC_SISLANDS_SCALE_R 12
>
> -struct PP_SIslands_CacConfig
> -{
> +struct PP_SIslands_CacConfig {
>       uint16_t
> cac_lkge_lut[SMC_SISLANDS_LKGE_LUT_NUM_OF_TEMP_ENTRIES][SMC_SISLANDS_LKGE=
_LUT_NUM_OF_VOLT_ENTRIES];
>       uint32_t   lkge_lut_V0;
>       uint32_t   lkge_lut_Vstep;
> @@ -308,23 +298,20 @@ typedef struct PP_SIslands_CacConfig
> PP_SIslands_CacConfig;
>   #define SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE 16
>   #define SMC_SISLANDS_MC_REGISTER_ARRAY_SET_COUNT 20
>
> -struct SMC_SIslands_MCRegisterAddress
> -{
> +struct SMC_SIslands_MCRegisterAddress {
>       uint16_t s0;
>       uint16_t s1;
>   };
>
>   typedef struct SMC_SIslands_MCRegisterAddress
> SMC_SIslands_MCRegisterAddress;
>
> -struct SMC_SIslands_MCRegisterSet
> -{
> +struct SMC_SIslands_MCRegisterSet {
>       uint32_t value[SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE];
>   };
>
>   typedef struct SMC_SIslands_MCRegisterSet SMC_SIslands_MCRegisterSet;
>
> -struct SMC_SIslands_MCRegisters
> -{
> +struct SMC_SIslands_MCRegisters {
>       uint8_t                             last;
>       uint8_t                             reserved[3];
>       SMC_SIslands_MCRegisterAddress
> address[SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE];
> @@ -333,8 +320,7 @@ struct SMC_SIslands_MCRegisters
>
>   typedef struct SMC_SIslands_MCRegisters SMC_SIslands_MCRegisters;
>
> -struct SMC_SIslands_MCArbDramTimingRegisterSet
> -{
> +struct SMC_SIslands_MCArbDramTimingRegisterSet {
>       uint32_t mc_arb_dram_timing;
>       uint32_t mc_arb_dram_timing2;
>       uint8_t  mc_arb_rfsh_rate;
> @@ -344,8 +330,7 @@ struct SMC_SIslands_MCArbDramTimingRegisterSet
>
>   typedef struct SMC_SIslands_MCArbDramTimingRegisterSet
> SMC_SIslands_MCArbDramTimingRegisterSet;
>
> -struct SMC_SIslands_MCArbDramTimingRegisters
> -{
> +struct SMC_SIslands_MCArbDramTimingRegisters {
>       uint8_t                                     arb_current;
>       uint8_t                                     reserved[3];
>       SMC_SIslands_MCArbDramTimingRegisterSet     data[16];
> @@ -353,8 +338,7 @@ struct SMC_SIslands_MCArbDramTimingRegisters
>
>   typedef struct SMC_SIslands_MCArbDramTimingRegisters
> SMC_SIslands_MCArbDramTimingRegisters;
>
> -struct SMC_SISLANDS_SPLL_DIV_TABLE
> -{
> +struct SMC_SISLANDS_SPLL_DIV_TABLE {
>       uint32_t    freq[256];
>       uint32_t    ss[256];
>   };
> @@ -374,8 +358,7 @@ typedef struct SMC_SISLANDS_SPLL_DIV_TABLE
> SMC_SISLANDS_SPLL_DIV_TABLE;
>
>   #define SMC_SISLANDS_DTE_MAX_TEMPERATURE_DEPENDENT_ARRAY_SIZE 16
>
> -struct Smc_SIslands_DTE_Configuration
> -{
> +struct Smc_SIslands_DTE_Configuration {
>       uint32_t tau[SMC_SISLANDS_DTE_MAX_FILTER_STAGES];
>       uint32_t R[SMC_SISLANDS_DTE_MAX_FILTER_STAGES];
>       uint32_t K;
