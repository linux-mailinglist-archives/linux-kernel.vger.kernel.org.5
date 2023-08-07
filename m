Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FEF772BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjHGRFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHGRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:05:22 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EBFC2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:05:21 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56d455462c2so2244442eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427920; x=1692032720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DghBnRko2h2plSVoGsyhlMb00j8kHwkSqZ5jkj1qgv0=;
        b=feYLA5QsXKJAy8AOie6xuCZFZirSFHTW7+C5bStwxoydycrOEkpK+SuaAVonB6BKJV
         fPzDND9KFZaI/cUZ8/8CKXzAEXJ2YyATjt0ItUmPTGuDpThiJZlJ8q4wFtbO9D248BMl
         5MSUKoQpep5o7OvJ8XlbhoTkQE6CatFA87TIvhh+By4v1VkKpxviAw4w48n5Hr2BXj+s
         8Wh48iBpxK+LkBFmUkeBF0wteJ0uYN15lzg/hKcn5EgRafrQ54ekt4aDEMIEOyCqf9sr
         e91hutNNkuNtT8RhX8ByFGPfe4l/rIo89rpDJxG3QQwYbJ3gOoeguWT/kPoMXvpJHgFz
         V06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427920; x=1692032720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DghBnRko2h2plSVoGsyhlMb00j8kHwkSqZ5jkj1qgv0=;
        b=dmFbJJINt6DSbJZE83vcO2414zEC5RtaYWKOBcpJ+bimE0sDfxh1WiwCanBMSAJ3wt
         os+rI3Nlhu1nTKoMk0thYjmqKFIVooJLH5hXaZSvm5Or0GQ3gQ+RfWnWlDwPgg+VKXGE
         d9v/z0OMwyKX9oh+EOcF+0Qe1JU6ikCRDvYhC5uGCYt0gwKGwp7T1Gha/B0yk6w9KV1f
         rbAg3BFno81egtATxCMeEIkD2BHB8d851v4Wy9O0yxXkYyLwddSWkpjJd1YwMbMh/3MQ
         Yj8guPgQoZTxfyU+/nwDWkkmtIuN3DJGQUaE2Sw1Tkj30p5YX8clk011lT+1J5MxOffw
         eWtg==
X-Gm-Message-State: AOJu0Yw+pQ8yT6rKoJzu6nzE4oh6XQQjyqQGKtoFGQu7uV1Nel+V6prl
        u4abp5V27yzoW5MVynmW2fU1r+4iS3xu/aU2tB0=
X-Google-Smtp-Source: AGHT+IE3ZbbMAQaTXxIAS1dlfOqzf0EnYYmX2BCbObfrTOy45dE8VaaRH376NlTaWJf0ZFkEKMhuIj+X0njJiczYZZs=
X-Received: by 2002:a4a:3853:0:b0:56c:99e9:4d92 with SMTP id
 o19-20020a4a3853000000b0056c99e94d92mr10187657oof.3.1691427920362; Mon, 07
 Aug 2023 10:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230802022525.9814-1-sunran001@208suo.com>
In-Reply-To: <20230802022525.9814-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:05:09 -0400
Message-ID: <CADnq5_NWL1H6NjzGRgAuptw_JGTEdyctqd2D-qo5GhqfAo_nTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in sislands_smc.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 10:25=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/legacy-dpm/sislands_smc.h  | 63 +++++++------------
>  1 file changed, 21 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h b/drivers/g=
pu/drm/amd/pm/legacy-dpm/sislands_smc.h
> index c7dc117a688c..90ec411c5029 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> @@ -29,8 +29,7 @@
>
>  #define SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE 16
>
> -struct PP_SIslands_Dpm2PerfLevel
> -{
> +struct PP_SIslands_Dpm2PerfLevel {
>      uint8_t MaxPS;
>      uint8_t TgtAct;
>      uint8_t MaxPS_StepInc;
> @@ -47,8 +46,7 @@ struct PP_SIslands_Dpm2PerfLevel
>
>  typedef struct PP_SIslands_Dpm2PerfLevel PP_SIslands_Dpm2PerfLevel;
>
> -struct PP_SIslands_DPM2Status
> -{
> +struct PP_SIslands_DPM2Status {
>      uint32_t    dpm2Flags;
>      uint8_t     CurrPSkip;
>      uint8_t     CurrPSkipPowerShift;
> @@ -68,8 +66,7 @@ struct PP_SIslands_DPM2Status
>
>  typedef struct PP_SIslands_DPM2Status PP_SIslands_DPM2Status;
>
> -struct PP_SIslands_DPM2Parameters
> -{
> +struct PP_SIslands_DPM2Parameters {
>      uint32_t    TDPLimit;
>      uint32_t    NearTDPLimit;
>      uint32_t    SafePowerLimit;
> @@ -78,8 +75,7 @@ struct PP_SIslands_DPM2Parameters
>  };
>  typedef struct PP_SIslands_DPM2Parameters PP_SIslands_DPM2Parameters;
>
> -struct PP_SIslands_PAPMStatus
> -{
> +struct PP_SIslands_PAPMStatus {
>      uint32_t    EstimatedDGPU_T;
>      uint32_t    EstimatedDGPU_P;
>      uint32_t    EstimatedAPU_T;
> @@ -89,8 +85,7 @@ struct PP_SIslands_PAPMStatus
>  };
>  typedef struct PP_SIslands_PAPMStatus PP_SIslands_PAPMStatus;
>
> -struct PP_SIslands_PAPMParameters
> -{
> +struct PP_SIslands_PAPMParameters {
>      uint32_t    NearTDPLimitTherm;
>      uint32_t    NearTDPLimitPAPM;
>      uint32_t    PlatformPowerLimit;
> @@ -100,8 +95,7 @@ struct PP_SIslands_PAPMParameters
>  };
>  typedef struct PP_SIslands_PAPMParameters PP_SIslands_PAPMParameters;
>
> -struct SISLANDS_SMC_SCLK_VALUE
> -{
> +struct SISLANDS_SMC_SCLK_VALUE {
>      uint32_t    vCG_SPLL_FUNC_CNTL;
>      uint32_t    vCG_SPLL_FUNC_CNTL_2;
>      uint32_t    vCG_SPLL_FUNC_CNTL_3;
> @@ -113,8 +107,7 @@ struct SISLANDS_SMC_SCLK_VALUE
>
>  typedef struct SISLANDS_SMC_SCLK_VALUE SISLANDS_SMC_SCLK_VALUE;
>
> -struct SISLANDS_SMC_MCLK_VALUE
> -{
> +struct SISLANDS_SMC_MCLK_VALUE {
>      uint32_t    vMPLL_FUNC_CNTL;
>      uint32_t    vMPLL_FUNC_CNTL_1;
>      uint32_t    vMPLL_FUNC_CNTL_2;
> @@ -129,8 +122,7 @@ struct SISLANDS_SMC_MCLK_VALUE
>
>  typedef struct SISLANDS_SMC_MCLK_VALUE SISLANDS_SMC_MCLK_VALUE;
>
> -struct SISLANDS_SMC_VOLTAGE_VALUE
> -{
> +struct SISLANDS_SMC_VOLTAGE_VALUE {
>      uint16_t    value;
>      uint8_t     index;
>      uint8_t     phase_settings;
> @@ -138,8 +130,7 @@ struct SISLANDS_SMC_VOLTAGE_VALUE
>
>  typedef struct SISLANDS_SMC_VOLTAGE_VALUE SISLANDS_SMC_VOLTAGE_VALUE;
>
> -struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
> -{
> +struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL {
>      uint8_t                     ACIndex;
>      uint8_t                     displayWatermark;
>      uint8_t                     gen2PCIE;
> @@ -180,8 +171,7 @@ struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
>
>  typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PERFORM=
ANCE_LEVEL;
>
> -struct SISLANDS_SMC_SWSTATE
> -{
> +struct SISLANDS_SMC_SWSTATE {
>         uint8_t                             flags;
>         uint8_t                             levelCount;
>         uint8_t                             padding2;
> @@ -205,8 +195,7 @@ struct SISLANDS_SMC_SWSTATE_SINGLE {
>  #define SISLANDS_SMC_VOLTAGEMASK_VDDC_PHASE_SHEDDING 3
>  #define SISLANDS_SMC_VOLTAGEMASK_MAX   4
>
> -struct SISLANDS_SMC_VOLTAGEMASKTABLE
> -{
> +struct SISLANDS_SMC_VOLTAGEMASKTABLE {
>      uint32_t lowMask[SISLANDS_SMC_VOLTAGEMASK_MAX];
>  };
>
> @@ -214,8 +203,7 @@ typedef struct SISLANDS_SMC_VOLTAGEMASKTABLE SISLANDS=
_SMC_VOLTAGEMASKTABLE;
>
>  #define SISLANDS_MAX_NO_VREG_STEPS 32
>
> -struct SISLANDS_SMC_STATETABLE
> -{
> +struct SISLANDS_SMC_STATETABLE {
>         uint8_t                                 thermalProtectType;
>         uint8_t                                 systemFlags;
>         uint8_t                                 maxVDDCIndexInPPTable;
> @@ -254,8 +242,7 @@ typedef struct SISLANDS_SMC_STATETABLE SISLANDS_SMC_S=
TATETABLE;
>  #define SI_SMC_SOFT_REGISTER_svi_rework_gpio_id_svd   0x11c
>  #define SI_SMC_SOFT_REGISTER_svi_rework_gpio_id_svc   0x120
>
> -struct PP_SIslands_FanTable
> -{
> +struct PP_SIslands_FanTable {
>         uint8_t  fdo_mode;
>         uint8_t  padding;
>         int16_t  temp_min;
> @@ -285,8 +272,7 @@ typedef struct PP_SIslands_FanTable PP_SIslands_FanTa=
ble;
>  #define SMC_SISLANDS_SCALE_I  7
>  #define SMC_SISLANDS_SCALE_R 12
>
> -struct PP_SIslands_CacConfig
> -{
> +struct PP_SIslands_CacConfig {
>      uint16_t   cac_lkge_lut[SMC_SISLANDS_LKGE_LUT_NUM_OF_TEMP_ENTRIES][S=
MC_SISLANDS_LKGE_LUT_NUM_OF_VOLT_ENTRIES];
>      uint32_t   lkge_lut_V0;
>      uint32_t   lkge_lut_Vstep;
> @@ -308,23 +294,20 @@ typedef struct PP_SIslands_CacConfig PP_SIslands_Ca=
cConfig;
>  #define SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE 16
>  #define SMC_SISLANDS_MC_REGISTER_ARRAY_SET_COUNT 20
>
> -struct SMC_SIslands_MCRegisterAddress
> -{
> +struct SMC_SIslands_MCRegisterAddress {
>      uint16_t s0;
>      uint16_t s1;
>  };
>
>  typedef struct SMC_SIslands_MCRegisterAddress SMC_SIslands_MCRegisterAdd=
ress;
>
> -struct SMC_SIslands_MCRegisterSet
> -{
> +struct SMC_SIslands_MCRegisterSet {
>      uint32_t value[SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE];
>  };
>
>  typedef struct SMC_SIslands_MCRegisterSet SMC_SIslands_MCRegisterSet;
>
> -struct SMC_SIslands_MCRegisters
> -{
> +struct SMC_SIslands_MCRegisters {
>      uint8_t                             last;
>      uint8_t                             reserved[3];
>      SMC_SIslands_MCRegisterAddress      address[SMC_SISLANDS_MC_REGISTER=
_ARRAY_SIZE];
> @@ -333,8 +316,7 @@ struct SMC_SIslands_MCRegisters
>
>  typedef struct SMC_SIslands_MCRegisters SMC_SIslands_MCRegisters;
>
> -struct SMC_SIslands_MCArbDramTimingRegisterSet
> -{
> +struct SMC_SIslands_MCArbDramTimingRegisterSet {
>      uint32_t mc_arb_dram_timing;
>      uint32_t mc_arb_dram_timing2;
>      uint8_t  mc_arb_rfsh_rate;
> @@ -344,8 +326,7 @@ struct SMC_SIslands_MCArbDramTimingRegisterSet
>
>  typedef struct SMC_SIslands_MCArbDramTimingRegisterSet SMC_SIslands_MCAr=
bDramTimingRegisterSet;
>
> -struct SMC_SIslands_MCArbDramTimingRegisters
> -{
> +struct SMC_SIslands_MCArbDramTimingRegisters {
>      uint8_t                                     arb_current;
>      uint8_t                                     reserved[3];
>      SMC_SIslands_MCArbDramTimingRegisterSet     data[16];
> @@ -353,8 +334,7 @@ struct SMC_SIslands_MCArbDramTimingRegisters
>
>  typedef struct SMC_SIslands_MCArbDramTimingRegisters SMC_SIslands_MCArbD=
ramTimingRegisters;
>
> -struct SMC_SISLANDS_SPLL_DIV_TABLE
> -{
> +struct SMC_SISLANDS_SPLL_DIV_TABLE {
>      uint32_t    freq[256];
>      uint32_t    ss[256];
>  };
> @@ -374,8 +354,7 @@ typedef struct SMC_SISLANDS_SPLL_DIV_TABLE SMC_SISLAN=
DS_SPLL_DIV_TABLE;
>
>  #define SMC_SISLANDS_DTE_MAX_TEMPERATURE_DEPENDENT_ARRAY_SIZE 16
>
> -struct Smc_SIslands_DTE_Configuration
> -{
> +struct Smc_SIslands_DTE_Configuration {
>      uint32_t tau[SMC_SISLANDS_DTE_MAX_FILTER_STAGES];
>      uint32_t R[SMC_SISLANDS_DTE_MAX_FILTER_STAGES];
>      uint32_t K;
> --
> 2.17.1
>
