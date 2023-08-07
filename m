Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D4772BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHGQ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjHGQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:57:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF842105
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:57:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bcade59b24so3618743a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427421; x=1692032221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z9p5km3UZGZafdK1BmpwIiY/ihSWzczB8XWA2EWH3s=;
        b=ccB3GgXSCQRMNLG+BMreOOyUYdH/Yk6OtT9FMFT+DXInRGESpX3raYQ0RoHTYpfQWU
         HmOQLJCeOG+1LXrhn5PfvzV+cBCT6hRpxdHDKcsbKTAy/KWvaZ2h3SCCjWoYonnxtwTm
         bgjoa/tilS8y4hcg+Z83GJBeyFAsc6VdRowj8eG2v8DrgC6T8MxYpbjQujhnocnOi5Qw
         SbVdFX+en6tFJEreM4H9GAZNpKvw2skyF80hSKiU6D+4z23j24Ki6k7nC7Ed0AHBXO+f
         D33IdninngJcGEZwdFgdAj/wUPUat7sS28AGQ9nt/E2tvqxmGAOSa1xIx2zhiLotWffE
         RQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427421; x=1692032221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z9p5km3UZGZafdK1BmpwIiY/ihSWzczB8XWA2EWH3s=;
        b=eFajaYOSQCy/aFsOpzX9M0I+dyZlmdODsWHs03mEpZJL0J8L+P4dApsQ6KWuLMAJYL
         ixR/fVhp1CCGPmiPqo9emxIpai2fKeTYUycQhqhI/nCMCzhguh6CrELI0lxriNNmHqaW
         ysQNT2e76ZzWUbIDi7CaOTMyD7XWCIObm8h/kgkbgmNLfCSdyAeKLFbVYKKSfboUFUUg
         FYTWi3xj+gPdodqEqTa6fCstrTqL61j4lDqi+ed95CjfvaMDIlL1sZ3NPWMEd8fusumT
         qIa8LCwTO8aVsNMXOG0vkBWB94QZzQNDA8+n1qkxTdXKTD1VSxe0MRQh+lWrV3A77cVo
         zYBQ==
X-Gm-Message-State: AOJu0YwTXdTC+nj5xiZQ058HfrYY0CCTdV7SDBKkxSrCGpgT/KyRMFOx
        7jtSnt+yLebjfSfXYCFq7fX1l251+TRTAC7pn8Q=
X-Google-Smtp-Source: AGHT+IHutKy2W7kS9zpFH4IQRQX0bm5b40a62etfa2b+Z/ydT1Qppa1f31tW3yJSQ3rofB8cu7Q1gAtSyc6mZ+N3Ps8=
X-Received: by 2002:a05:6870:b48d:b0:1bb:a912:9339 with SMTP id
 y13-20020a056870b48d00b001bba9129339mr12467712oap.7.1691427421691; Mon, 07
 Aug 2023 09:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230802012903.8589-1-sunran001@208suo.com>
In-Reply-To: <20230802012903.8589-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:56:50 -0400
Message-ID: <CADnq5_PPWwnP7GUKC2hw2Eo9SdbXFuwHxATYtXHbg03a14eiMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu7_fusion.h
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

On Tue, Aug 1, 2023 at 9:29=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: space prohibited before open square bracket '['
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/inc/smu7_fusion.h    | 42 +++++++------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h b/drivers=
/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> index 78ada9ffd508..e130f52fe8d6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> @@ -36,8 +36,7 @@
>  #define SMU7_NUM_NON_TES 2
>
>  // All 'soft registers' should be uint32_t.
> -struct SMU7_SoftRegisters
> -{
> +struct SMU7_SoftRegisters {
>      uint32_t        RefClockFrequency;
>      uint32_t        PmTimerP;
>      uint32_t        FeatureEnables;
> @@ -80,8 +79,7 @@ struct SMU7_SoftRegisters
>
>  typedef struct SMU7_SoftRegisters SMU7_SoftRegisters;
>
> -struct SMU7_Fusion_GraphicsLevel
> -{
> +struct SMU7_Fusion_GraphicsLevel {
>      uint32_t    MinVddNb;
>
>      uint32_t    SclkFrequency;
> @@ -111,8 +109,7 @@ struct SMU7_Fusion_GraphicsLevel
>
>  typedef struct SMU7_Fusion_GraphicsLevel SMU7_Fusion_GraphicsLevel;
>
> -struct SMU7_Fusion_GIOLevel
> -{
> +struct SMU7_Fusion_GIOLevel {
>      uint8_t     EnabledForActivity;
>      uint8_t     LclkDid;
>      uint8_t     Vid;
> @@ -137,8 +134,7 @@ struct SMU7_Fusion_GIOLevel
>  typedef struct SMU7_Fusion_GIOLevel SMU7_Fusion_GIOLevel;
>
>  // UVD VCLK/DCLK state (level) definition.
> -struct SMU7_Fusion_UvdLevel
> -{
> +struct SMU7_Fusion_UvdLevel {
>      uint32_t VclkFrequency;
>      uint32_t DclkFrequency;
>      uint16_t MinVddNb;
> @@ -155,8 +151,7 @@ struct SMU7_Fusion_UvdLevel
>  typedef struct SMU7_Fusion_UvdLevel SMU7_Fusion_UvdLevel;
>
>  // Clocks for other external blocks (VCE, ACP, SAMU).
> -struct SMU7_Fusion_ExtClkLevel
> -{
> +struct SMU7_Fusion_ExtClkLevel {
>      uint32_t Frequency;
>      uint16_t MinVoltage;
>      uint8_t  Divider;
> @@ -166,8 +161,7 @@ struct SMU7_Fusion_ExtClkLevel
>  };
>  typedef struct SMU7_Fusion_ExtClkLevel SMU7_Fusion_ExtClkLevel;
>
> -struct SMU7_Fusion_ACPILevel
> -{
> +struct SMU7_Fusion_ACPILevel {
>      uint32_t    Flags;
>      uint32_t    MinVddNb;
>      uint32_t    SclkFrequency;
> @@ -181,8 +175,7 @@ struct SMU7_Fusion_ACPILevel
>
>  typedef struct SMU7_Fusion_ACPILevel SMU7_Fusion_ACPILevel;
>
> -struct SMU7_Fusion_NbDpm
> -{
> +struct SMU7_Fusion_NbDpm {
>      uint8_t DpmXNbPsHi;
>      uint8_t DpmXNbPsLo;
>      uint8_t Dpm0PgNbPsHi;
> @@ -197,8 +190,7 @@ struct SMU7_Fusion_NbDpm
>
>  typedef struct SMU7_Fusion_NbDpm SMU7_Fusion_NbDpm;
>
> -struct SMU7_Fusion_StateInfo
> -{
> +struct SMU7_Fusion_StateInfo {
>      uint32_t SclkFrequency;
>      uint32_t LclkFrequency;
>      uint32_t VclkFrequency;
> @@ -214,8 +206,7 @@ struct SMU7_Fusion_StateInfo
>
>  typedef struct SMU7_Fusion_StateInfo SMU7_Fusion_StateInfo;
>
> -struct SMU7_Fusion_DpmTable
> -{
> +struct SMU7_Fusion_DpmTable {
>      uint32_t                            SystemFlags;
>
>      SMU7_PIDController                  GraphicsPIDController;
> @@ -230,12 +221,12 @@ struct SMU7_Fusion_DpmTable
>      uint8_t                            SamuLevelCount;
>      uint16_t                           FpsHighT;
>
> -    SMU7_Fusion_GraphicsLevel         GraphicsLevel           [SMU__NUM_=
SCLK_DPM_STATE];
> +    SMU7_Fusion_GraphicsLevel         GraphicsLevel[SMU__NUM_SCLK_DPM_ST=
ATE];
>      SMU7_Fusion_ACPILevel             ACPILevel;
> -    SMU7_Fusion_UvdLevel              UvdLevel                [SMU7_MAX_=
LEVELS_UVD];
> -    SMU7_Fusion_ExtClkLevel           VceLevel                [SMU7_MAX_=
LEVELS_VCE];
> -    SMU7_Fusion_ExtClkLevel           AcpLevel                [SMU7_MAX_=
LEVELS_ACP];
> -    SMU7_Fusion_ExtClkLevel           SamuLevel               [SMU7_MAX_=
LEVELS_SAMU];
> +    SMU7_Fusion_UvdLevel              UvdLevel[SMU7_MAX_LEVELS_UVD];
> +    SMU7_Fusion_ExtClkLevel           VceLevel[SMU7_MAX_LEVELS_VCE];
> +    SMU7_Fusion_ExtClkLevel           AcpLevel[SMU7_MAX_LEVELS_ACP];
> +    SMU7_Fusion_ExtClkLevel           SamuLevel[SMU7_MAX_LEVELS_SAMU];
>
>      uint8_t                           UvdBootLevel;
>      uint8_t                           VceBootLevel;
> @@ -266,10 +257,9 @@ struct SMU7_Fusion_DpmTable
>
>  };
>
> -struct SMU7_Fusion_GIODpmTable
> -{
> +struct SMU7_Fusion_GIODpmTable {
>
> -    SMU7_Fusion_GIOLevel              GIOLevel                [SMU7_MAX_=
LEVELS_GIO];
> +    SMU7_Fusion_GIOLevel              GIOLevel[SMU7_MAX_LEVELS_GIO];
>
>      SMU7_PIDController                GioPIDController;
>
> --
> 2.17.1
>
