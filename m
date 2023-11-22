Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83D27F4392
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjKVKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjKVKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:20:02 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653811A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:54 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5caa401f151so30080777b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700648393; x=1701253193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa4yoDJ99qgDyOwb3Frc4L8eVPVTNWGXGxm7LgxKRAg=;
        b=SeG5X8VmsMGoVAmDpDe+DIZAqpDzrluG1awTSMgd8Y8fOyDto+u0F/TqSbGIN/SykC
         xw4N97XEzxOKG4PXdW2orkQ2/jOcx/n3r6n+CqrEGtKD2P2TkkJBCW5ls6I3MGVnzjCo
         DmgBJ7b4/7iffPyFnRP19bQJDXP+xuoXb3tao5fELzNuHbPdG1/OmcZxborD2NqEFRPK
         m4G5nuxOSnRG9WRxdwyEmdoNfpNRKvT7qMWNF4CM4ZnYrepBeONdbMIzFriFXXGqIA+t
         FZt6RTWJzcnWa2Yc5Kbq7mnr5MvgZszJDNBMz/NuM4flVP7n5ZEluBL4l5XX/l91QWQl
         wkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648393; x=1701253193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xa4yoDJ99qgDyOwb3Frc4L8eVPVTNWGXGxm7LgxKRAg=;
        b=F35ruT/Rl6HlZGyfKe/+KA+seqstS70vzgixmmUQjtn/xCePV+MlaREO6FrDhFY70Q
         CUwWrhTc3bCEF4llem6FST6gSJdIzs9ZpmwI0uhbJKFeur5BxN9kyxSgm8dUNEiX85x0
         hcRzGeHr/tib4KWUumJhhAnOz1bTV4vANmypbNbD0zMzh1D6CP8f5T0UUDRqYCm25M3b
         zyelsdE7WaMnErYpNZ9ujbTbLC0ArbD00CAvX4R/paQ6h4P8chLbu+Tvq9dFX/vMaftw
         rFir198O06vMFtAOZRC/kUnC/mDBFhv2uAfowrt6+/tM42mOrr9B2CrSJLwMJUgNevHv
         Uzyw==
X-Gm-Message-State: AOJu0Ywdtg+cAxa0h2YuPeqTmmP54aX0wYWsXV1XiZ8dqQ56C/yw+T3f
        bAKqmoqOVo/zpVNnIT8lDDp+CPbZw806RlCfNvKOZ2wLJtCuvFPX
X-Google-Smtp-Source: AGHT+IHyQL9bZ4Ghj5CX7F1v3C0dFVe3YZOmFxa/kONpM8WCFF4uftId1viFYuVU5ZYljfyaJ9ewMjF2XT5pRvvMjn0=
X-Received: by 2002:a0d:f683:0:b0:5cc:3695:6afd with SMTP id
 g125-20020a0df683000000b005cc36956afdmr1792638ywf.38.1700648393605; Wed, 22
 Nov 2023 02:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-5-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-5-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:19:42 +0200
Message-ID: <CAA8EJprPf+AOKLm4q8xjXUNkKkkZzkMw-9wenVP3Zws3dCf7gQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] phy: qcom-qmp: qserdes-com: Add v7 register offsets
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform bumps the HW version of QMP phy to v7 for USB
> and PCIE g3x2. Add the new qserdes com offsets in a dedicated
> header file.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h | 86 ++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 +
>  2 files changed, 88 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h
> new file mode 100644
> index 000000000000..c8775ca1ab6b
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_COM_V7_H_
> +#define QCOM_PHY_QMP_QSERDES_COM_V7_H_
> +
> +/* Only for QMP V6 PHY - QSERDES COM registers */

V7

> +
> +#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1                    0x00
> +#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1                    0x04
> +#define QSERDES_V7_COM_CP_CTRL_MODE1                           0x10
> +#define QSERDES_V7_COM_PLL_RCTRL_MODE1                         0x14
> +#define QSERDES_V7_COM_PLL_CCTRL_MODE1                         0x18
> +#define QSERDES_V7_COM_CORECLK_DIV_MODE1                       0x1c
> +#define QSERDES_V7_COM_LOCK_CMP1_MODE1                         0x20
> +#define QSERDES_V7_COM_LOCK_CMP2_MODE1                         0x24
> +#define QSERDES_V7_COM_DEC_START_MODE1                         0x28
> +#define QSERDES_V7_COM_DEC_START_MSB_MODE1                     0x2c
> +#define QSERDES_V7_COM_DIV_FRAC_START1_MODE1                   0x30
> +#define QSERDES_V7_COM_DIV_FRAC_START2_MODE1                   0x34
> +#define QSERDES_V7_COM_DIV_FRAC_START3_MODE1                   0x38
> +#define QSERDES_V7_COM_HSCLK_SEL_1                             0x3c
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE1                   0x40
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE1                   0x44
> +#define QSERDES_V7_COM_VCO_TUNE1_MODE1                         0x48
> +#define QSERDES_V7_COM_VCO_TUNE2_MODE1                         0x4c
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1              0x50
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1              0x54
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0              0x58
> +#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0              0x5c
> +#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0                    0x60
> +#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0                    0x64
> +#define QSERDES_V7_COM_CP_CTRL_MODE0                           0x70
> +#define QSERDES_V7_COM_PLL_RCTRL_MODE0                         0x74
> +#define QSERDES_V7_COM_PLL_CCTRL_MODE0                         0x78
> +#define QSERDES_V7_COM_PLL_CORE_CLK_DIV_MODE0                  0x7c
> +#define QSERDES_V7_COM_LOCK_CMP1_MODE0                         0x80
> +#define QSERDES_V7_COM_LOCK_CMP2_MODE0                         0x84
> +#define QSERDES_V7_COM_DEC_START_MODE0                         0x88
> +#define QSERDES_V7_COM_DEC_START_MSB_MODE0                     0x8c
> +#define QSERDES_V7_COM_DIV_FRAC_START1_MODE0                   0x90
> +#define QSERDES_V7_COM_DIV_FRAC_START2_MODE0                   0x94
> +#define QSERDES_V7_COM_DIV_FRAC_START3_MODE0                   0x98
> +#define QSERDES_V7_COM_HSCLK_HS_SWITCH_SEL_1                   0x9c
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE0                   0xa0
> +#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE0                   0xa4
> +#define QSERDES_V7_COM_VCO_TUNE1_MODE0                         0xa8
> +#define QSERDES_V7_COM_VCO_TUNE2_MODE0                         0xac
> +#define QSERDES_V7_COM_BG_TIMER                                        0xbc
> +#define QSERDES_V7_COM_SSC_EN_CENTER                           0xc0
> +#define QSERDES_V7_COM_SSC_PER1                                        0xcc
> +#define QSERDES_V7_COM_SSC_PER2                                        0xd0
> +#define QSERDES_V7_COM_PLL_POST_DIV_MUX                                0xd8
> +#define QSERDES_V7_COM_PLL_BIAS_EN_CLK_BUFLR_EN                        0xdc
> +#define QSERDES_V7_COM_CLK_ENABLE1                             0xe0
> +#define QSERDES_V7_COM_SYS_CLK_CTRL                            0xe4
> +#define QSERDES_V7_COM_SYSCLK_BUF_ENABLE                       0xe8
> +#define QSERDES_V7_COM_PLL_IVCO                                        0xf4
> +#define QSERDES_V7_COM_PLL_IVCO_MODE1                          0xf8
> +#define QSERDES_V7_COM_SYSCLK_EN_SEL                           0x110
> +#define QSERDES_V7_COM_RESETSM_CNTRL                           0x118
> +#define QSERDES_V7_COM_LOCK_CMP_EN                             0x120
> +#define QSERDES_V7_COM_LOCK_CMP_CFG                            0x124
> +#define QSERDES_V7_COM_VCO_TUNE_CTRL                           0x13c
> +#define QSERDES_V7_COM_VCO_TUNE_MAP                            0x140
> +#define QSERDES_V7_COM_VCO_TUNE_INITVAL2                       0x148
> +#define QSERDES_V7_COM_VCO_TUNE_MAXVAL2                                0x158
> +#define QSERDES_V7_COM_CLK_SELECT                              0x164
> +#define QSERDES_V7_COM_CORE_CLK_EN                             0x170
> +#define QSERDES_V7_COM_CMN_CONFIG_1                            0x174
> +#define QSERDES_V7_COM_SVS_MODE_CLK_SEL                                0x17c
> +#define QSERDES_V7_COM_CMN_MISC_1                              0x184
> +#define QSERDES_V7_COM_CMN_MODE                                        0x188
> +#define QSERDES_V7_COM_PLL_VCO_DC_LEVEL_CTRL                   0x198
> +#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1                    0x1a4
> +#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2                    0x1a8
> +#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3                    0x1ac
> +#define QSERDES_V7_COM_ADDITIONAL_MISC                         0x1b4
> +#define QSERDES_V7_COM_ADDITIONAL_MISC_2                       0x1b8
> +#define QSERDES_V7_COM_ADDITIONAL_MISC_3                       0x1bc
> +#define QSERDES_V7_COM_CMN_STATUS                              0x1d0
> +#define QSERDES_V7_COM_C_READY_STATUS                          0x1f8
> +
> +#endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
> index 21f6a56e7ae3..3a0512c3e07a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
> @@ -26,6 +26,8 @@
>  #include "phy-qcom-qmp-qserdes-txrx-v6_20.h"
>  #include "phy-qcom-qmp-qserdes-ln-shrd-v6.h"
>
> +#include "phy-qcom-qmp-qserdes-com-v7.h"
> +
>  #include "phy-qcom-qmp-qserdes-pll.h"
>
>  #include "phy-qcom-qmp-pcs-v2.h"
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
