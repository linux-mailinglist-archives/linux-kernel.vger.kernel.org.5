Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0F7F435F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbjKVKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjKVKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:15:59 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B7112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:15:55 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cc77e23218so4217247b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700648155; x=1701252955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgkvyLwfQR26thZuHZr5M17A0Ohem0nIDMb8RLB6UYs=;
        b=r8fcXzdJhk4j5jldofapXyE3N/Tyl09fpEUY+m5NqEXEjROz50uKEaTBwMusJufdLa
         HPR762mdbn5gC3CaTUvaJjPozz5ONmi+GkkFy5Kks8j2ArMz1Qc9vmbaShdMd2B/YlRK
         Bl7ABymoZKM784c5lGNTBvmajRutsSk0eemoQirByj7Vw7muZWfvnOUgTsMz9jgA+6Z8
         +gvoThWi4mzO7FHXzjpacUS3Rvg0H2QMbBw5NSiQ0+EWPk8lNTVmmHvmxMlvbaTI2eoB
         Srd1EctnV1os/5+z0cyGqeK+ZfDTmI8llUyCfoZlwpmCr9lIzxJ0wA35A+ZM/H+Mvtu7
         i5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648155; x=1701252955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgkvyLwfQR26thZuHZr5M17A0Ohem0nIDMb8RLB6UYs=;
        b=so673m6bGDXdWI6/pKYQq6B/YeGd5VyEiwB6imlGHIwFY+hcQjaX5IjTSQwlmhS8KR
         K4ZGGPS010PRCD7N1zoKNRHEse+f+2kxcDxQAFae87n3vkTYR5OxXY2YOsDSlgIKLyTE
         CVICt5WXp2GKR9cWn8/VBie7cZdaIZ/+hqK0Fk83d5aBhnKHkCZv5GFXBS8/AATJQQ0Y
         2m/z4FzbuWjcMTM/Uuq8pN900D7vjOZ971VfazlK+MBcLcxYJc89mencr7BOa36JqeAg
         ProWtsnNdi+UDDDdw1p+GpW9oD0BQMh9o0wY2R6CbLynt1jONfFFKAFmW1c3CZSDCcdd
         as7A==
X-Gm-Message-State: AOJu0YzZbGM3GURtWNpR7j6k7L2kBE8yf2CZuAI9CFzFmYZx/i7mVuwF
        yu6yqFJyq283oBrwTzabxb/ZsXHFT4o/VQybXH+r5Q==
X-Google-Smtp-Source: AGHT+IEkdUG9+zaFUBVAnoJGDXIM87u6PIrFmQ+T/ZMjVtONGnL/iE3hI7EqXnjaRE+awRnTSMD0+xsOQ6T0bnb+1T4=
X-Received: by 2002:a81:4746:0:b0:5a7:baac:7b34 with SMTP id
 u67-20020a814746000000b005a7baac7b34mr1621814ywa.28.1700648154790; Wed, 22
 Nov 2023 02:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-3-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-3-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:15:43 +0200
Message-ID: <CAA8EJpq5NdZKaDSjKnJhFBCD+pwb3jaHgsSXAu6ODmSPU+g_ww@mail.gmail.com>
Subject: Re: [PATCH 3/7] phy: qcom-qmp: pcs: Add v7 register offsets
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform bumps the HW version of QMP phy to v7 for USB,
> and PCIe. Add the new PCS offsets in a dedicated header file.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h | 28 ++++++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h        |  2 ++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
> new file mode 100644
> index 000000000000..520f28d802f6
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_V7_H_
> +#define QCOM_PHY_QMP_PCS_V7_H_
> +
> +/* Only for QMP V6 PHY - USB/PCIe PCS registers */

V7

> +
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG1                        0xc4
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG2                        0xc8
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG3                        0xcc
> +#define QPHY_V7_PCS_LOCK_DETECT_CONFIG6                        0xd8
> +#define QPHY_V7_PCS_REFGEN_REQ_CONFIG1                 0xdc
> +#define QPHY_V7_PCS_RX_SIGDET_LVL                      0x188
> +#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L               0x190
> +#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H               0x194
> +#define QPHY_V7_PCS_RATE_SLEW_CNTRL1                   0x198
> +#define QPHY_V7_PCS_RX_CONFIG                          0x1b0
> +#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG1               0x1c0
> +#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG2               0x1c4
> +#define QPHY_V7_PCS_PCS_TX_RX_CONFIG                   0x1d0
> +#define QPHY_V7_PCS_EQ_CONFIG1                         0x1dc
> +#define QPHY_V7_PCS_EQ_CONFIG2                         0x1e0
> +#define QPHY_V7_PCS_EQ_CONFIG5                         0x1ec
> +
> +#endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
> index 71f063f4a56e..21f6a56e7ae3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
> @@ -44,6 +44,8 @@
>
>  #include "phy-qcom-qmp-pcs-v6_20.h"
>
> +#include "phy-qcom-qmp-pcs-v7.h"
> +
>  /* Only for QMP V3 & V4 PHY - DP COM registers */
>  #define QPHY_V3_DP_COM_PHY_MODE_CTRL                   0x00
>  #define QPHY_V3_DP_COM_SW_RESET                                0x04
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
