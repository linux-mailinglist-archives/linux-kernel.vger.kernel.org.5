Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166A9772BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjHGRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHGRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:00:33 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7D10D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:00:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bcae8c4072so3042396a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427630; x=1692032430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lku3mSpHphjbjAm2T6u+ieCGGFFROzE48as9JT2wvy4=;
        b=SX2EKjGXvall0/Z2aQXKNN40J9iu/5gt62fnBonYd4iTXwBUf+sCVaAzpVbMH5uCmM
         DJlUFt8PlDKS55Zjo2N8AKfj2T1amMgkvj0zCQizOhpTsXUvuFRFyzFgGJLy9xeUeET5
         Hg2ncSBCSFb04yEUlZDxCa13Eww314wCAWL9HMo7GoJjjwS+tI6e1kmH3AcDu9qfDhra
         hklB5dk0bpx4pg7+p1acdPn1J2RoTCfrTLNOmUeONPjXtd8Tv6VtQXMzaebsWGMXM8kN
         BahYXF0ckqo2jPL8pslZKxEKnrvj/1/k+BzuLLeI4MewshQC4I/cSV5tV4lSK03Ogn4A
         YkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427630; x=1692032430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lku3mSpHphjbjAm2T6u+ieCGGFFROzE48as9JT2wvy4=;
        b=jAAkNp+i8RHF/cx0QD2RCwyKOcxKVDhcWkW1kYQ52B1hwHU7gth9JziEnTFVqFHilv
         wIKO8NbcnvaAXEim0A6dLrGyIMqgj+AP0Xn0hlbpCPbrkkbJQW2LmJON0hAz4WmctlCv
         /rFOX6qDYWk5WBI5Yt6sJIBE8omZZDG/vzSKtcv0KbBUenYiTLfDhZWnKGp83joqLTu6
         oC4sWOe6X6S8NrKhzj0uF62jS73AbSKd8nIWQLZldx2VGGu9oarMsdgcfJy62npXSdnE
         YzMqHh4dEmZDETsXgvAZO7747Pn7seqdmf0Mm1bocogCz6Gg14t3fUm/bVwnf024L557
         Z0dA==
X-Gm-Message-State: AOJu0YxmwKR9BeXGJAM5+Kls7vazBqSHh7+QgALlLoGOGDtQ1bdY9EBp
        qYIPScErbD2/15v6nFUf5cXbCULR8SsKgioU7BoHWH5S
X-Google-Smtp-Source: AGHT+IEmC/Wgxm1ABfio+rgysFi4QGc2WlU+VbH6VcqTcPPP94QUOhpIpKpBepbgXQyZs7IiZs06eybqfXGakEDOmi4=
X-Received: by 2002:a9d:6449:0:b0:6b9:c7de:68e0 with SMTP id
 m9-20020a9d6449000000b006b9c7de68e0mr7794469otl.29.1691427630302; Mon, 07 Aug
 2023 10:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230802015557.9034-1-sunran001@208suo.com>
In-Reply-To: <20230802015557.9034-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:00:19 -0400
Message-ID: <CADnq5_PdmvM_hNcpJRgg1DLCO9TfPJ2krHtAWFBZYLY6wZOxcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu73.h
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

On Tue, Aug 1, 2023 at 9:56=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: space prohibited before open square bracket '['
> ERROR: "foo * bar" should be "foo *bar"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h | 45 ++++++++------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/smu73.h
> index c6b12a4c00db..cf4b2c3c65bc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> @@ -37,8 +37,7 @@ enum Poly3rdOrderCoeff {
>      POLY_3RD_ORDER_COUNT
>  };
>
> -struct SMU7_Poly3rdOrder_Data
> -{
> +struct SMU7_Poly3rdOrder_Data {
>      int32_t a;
>      int32_t b;
>      int32_t c;
> @@ -51,8 +50,7 @@ struct SMU7_Poly3rdOrder_Data
>
>  typedef struct SMU7_Poly3rdOrder_Data SMU7_Poly3rdOrder_Data;
>
> -struct Power_Calculator_Data
> -{
> +struct Power_Calculator_Data {
>    uint16_t NoLoadVoltage;
>    uint16_t LoadVoltage;
>    uint16_t Resistance;
> @@ -71,8 +69,7 @@ struct Power_Calculator_Data
>
>  typedef struct Power_Calculator_Data PowerCalculatorData_t;
>
> -struct Gc_Cac_Weight_Data
> -{
> +struct Gc_Cac_Weight_Data {
>    uint8_t index;
>    uint32_t value;
>  };
> @@ -187,8 +184,7 @@ typedef struct {
>  #define SMU73_THERMAL_CLAMP_MODE_COUNT 8
>
>
> -struct SMU7_HystController_Data
> -{
> +struct SMU7_HystController_Data {
>      uint16_t waterfall_up;
>      uint16_t waterfall_down;
>      uint16_t waterfall_limit;
> @@ -199,8 +195,7 @@ struct SMU7_HystController_Data
>
>  typedef struct SMU7_HystController_Data SMU7_HystController_Data;
>
> -struct SMU73_PIDController
> -{
> +struct SMU73_PIDController {
>      uint32_t Ki;
>      int32_t LFWindupUpperLim;
>      int32_t LFWindupLowerLim;
> @@ -215,8 +210,7 @@ struct SMU73_PIDController
>
>  typedef struct SMU73_PIDController SMU73_PIDController;
>
> -struct SMU7_LocalDpmScoreboard
> -{
> +struct SMU7_LocalDpmScoreboard {
>      uint32_t PercentageBusy;
>
>      int32_t  PIDError;
> @@ -261,8 +255,8 @@ struct SMU7_LocalDpmScoreboard
>      uint8_t  DteClampMode;
>      uint8_t  FpsClampMode;
>
> -    uint16_t LevelResidencyCounters [SMU73_MAX_LEVELS_GRAPHICS];
> -    uint16_t LevelSwitchCounters [SMU73_MAX_LEVELS_GRAPHICS];
> +    uint16_t LevelResidencyCounters[SMU73_MAX_LEVELS_GRAPHICS];
> +    uint16_t LevelSwitchCounters[SMU73_MAX_LEVELS_GRAPHICS];
>
>      void     (*TargetStateCalculator)(uint8_t);
>      void     (*SavedTargetStateCalculator)(uint8_t);
> @@ -315,8 +309,7 @@ typedef uint8_t (*VoltageChangeHandler_t)(uint16_t, u=
int8_t);
>
>  typedef uint32_t SMU_VoltageLevel;
>
> -struct SMU7_VoltageScoreboard
> -{
> +struct SMU7_VoltageScoreboard {
>      SMU_VoltageLevel TargetVoltage;
>      uint16_t MaxVid;
>      uint8_t  HighestVidOffset;
> @@ -354,7 +347,7 @@ struct SMU7_VoltageScoreboard
>
>      VoltageChangeHandler_t functionLinks[6];
>
> -    uint16_t * VddcFollower1;
> +    uint16_t *VddcFollower1;
>
>      int16_t  Driver_OD_RequestedVidOffset1;
>      int16_t  Driver_OD_RequestedVidOffset2;
> @@ -366,8 +359,7 @@ typedef struct SMU7_VoltageScoreboard SMU7_VoltageSco=
reboard;
>  // ---------------------------------------------------------------------=
----------------------------------------------------
>  #define SMU7_MAX_PCIE_LINK_SPEEDS 3 /* 0:Gen1 1:Gen2 2:Gen3 */
>
> -struct SMU7_PCIeLinkSpeedScoreboard
> -{
> +struct SMU7_PCIeLinkSpeedScoreboard {
>      uint8_t     DpmEnable;
>      uint8_t     DpmRunning;
>      uint8_t     DpmForce;
> @@ -396,8 +388,7 @@ typedef struct SMU7_PCIeLinkSpeedScoreboard SMU7_PCIe=
LinkSpeedScoreboard;
>  #define SMU7_SCALE_I  7
>  #define SMU7_SCALE_R 12
>
> -struct SMU7_PowerScoreboard
> -{
> +struct SMU7_PowerScoreboard {
>      uint32_t GpuPower;
>
>      uint32_t VddcPower;
> @@ -436,8 +427,7 @@ typedef struct SMU7_PowerScoreboard SMU7_PowerScorebo=
ard;
>  #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
>
>  // All 'soft registers' should be uint32_t.
> -struct SMU73_SoftRegisters
> -{
> +struct SMU73_SoftRegisters {
>      uint32_t        RefClockFrequency;
>      uint32_t        PmTimerPeriod;
>      uint32_t        FeatureEnables;
> @@ -493,8 +483,7 @@ struct SMU73_SoftRegisters
>
>  typedef struct SMU73_SoftRegisters SMU73_SoftRegisters;
>
> -struct SMU73_Firmware_Header
> -{
> +struct SMU73_Firmware_Header {
>      uint32_t Digest[5];
>      uint32_t Version;
>      uint32_t HeaderSize;
> @@ -708,9 +697,9 @@ typedef struct VFT_CELL_t VFT_CELL_t;
>
>  struct VFT_TABLE_t {
>    VFT_CELL_t    Cell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
> -  uint16_t      AvfsGbv [NUM_VFT_COLUMNS];
> -  uint16_t      BtcGbv  [NUM_VFT_COLUMNS];
> -  uint16_t      Temperature [TEMP_RANGE_MAXSTEPS];
> +  uint16_t      AvfsGbv[NUM_VFT_COLUMNS];
> +  uint16_t      BtcGbv[NUM_VFT_COLUMNS];
> +  uint16_t      Temperature[TEMP_RANGE_MAXSTEPS];
>
>    uint8_t       NumTemperatureSteps;
>    uint8_t       padding[3];
> --
> 2.17.1
>
