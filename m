Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC647F4353
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjKVKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjKVKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:12:18 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC01A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:12:12 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so6462201276.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647932; x=1701252732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSREVsoB+CesK7N1lJ9hwky3qVq4cMcaEkJfYCXHc2o=;
        b=vcS4qQIwzKHi9nBoZmfaH3sxKzDqDA/ZpVOh/ETXLV1sEEAqA4/3jNvbMfyIe1rmDH
         ESkrFFAVXDgKYfEjUbhXiN4+e+gOuQmh7CRiFeuusOsWIJaKad4QWBvQWBi3XzNKwhlR
         PPZY3+879Kb2295YJCjvyDiV7UdKHSlZprjlYlFWUI4wCu73NSGw1HIaHvjnFw+rs9kW
         UHYUb+XZGDtdK+UiCY9Pz07PHj6pDJazzj8bpOMp/ezT04kCgXzcuQuDXs5krCgWSWrL
         gpp/gNUq9Fp9cfRpgO6ja2In/AqGfTTyJaQYUkER9dUVDQaCHGQ3287fCiBjpbqRk/7g
         byLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647932; x=1701252732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSREVsoB+CesK7N1lJ9hwky3qVq4cMcaEkJfYCXHc2o=;
        b=NWY7z03oYf0QqwnTt4Ekb7ASf3N58E+TZHnn+xaJaK/JBchLSN+GoLAmsghl0LuVfb
         OHXB9noRwda8Ab7CXEfvsIUlIjWflpJ4iW9u/ZVn6yfTv+kUuREpAnD5nYjkLKH2s1+D
         eLso9tY1oVJkySHqQH5lBOVpqeYDwykjSPwK6HGXexolmC46j9/vWbMcv8CsfVni8xeu
         yX+A4wygk0uMHx0giAwpBFpRSdTYTKmsdpBg60QUAlVjhqJvj255dpTYLRT4ONOVX1yv
         a3KgLx0cML7lcQ3eeaYryRgWq5ToSNeEpbIZRGht3UOh70IlQGjwR+j9SL9MeE1qsPez
         Q1Lw==
X-Gm-Message-State: AOJu0YxnkbwaHLrTScoUvZ93Ng/u7APAF9jdlY3Fn75h3pJGxfIeoT5K
        nof0BvyIj4PEdW9NUiFyFR31lMmY8W7oZus7nzCaXg==
X-Google-Smtp-Source: AGHT+IFoK6s2cp0X+5kb85bnx93gSvCPfnd5ajslb+t2IOP8hiHp9ntEKCFuwd1BgpAjTsed4Xf9HwYDAoGgI2aS+Os=
X-Received: by 2002:a0d:d6cb:0:b0:5c6:4de5:168f with SMTP id
 y194-20020a0dd6cb000000b005c64de5168fmr1594152ywd.10.1700647931878; Wed, 22
 Nov 2023 02:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:12:00 +0200
Message-ID: <CAA8EJpr2HhiXEbp0QsN-qB+L4WQWiV3o2yCc-f5oqdhdKZGL9A@mail.gmail.com>
Subject: Re: [PATCH 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add some missing v6.20 registers offsets that are needed by the new
> Snapdragon X Elite (X1E80100) platform.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> index 5385a8b60970..7402a94d1be8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> @@ -14,11 +14,14 @@
>  #define QSERDES_V6_20_TX_LANE_MODE_3                           0x80
>
>  #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2                   0x08
> +#define QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2                   0x18
>  #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3                   0x0c

As a side note, this should be probably 0x1c. Could you please verify
it and send a fix?

>  #define QSERDES_V6_20_RX_UCDR_PI_CONTROLS                      0x20
>  #define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3         0x34
>  #define QSERDES_V6_20_RX_IVCM_CAL_CTRL2                                0x9c
>  #define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET                   0xa0
> +#define QSERDES_V6_20_RX_DFE_1                                 0xac
> +#define QSERDES_V6_20_RX_DFE_2                                 0xb0
>  #define QSERDES_V6_20_RX_DFE_3                                 0xb4
>  #define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL                       0xe8
>  #define QSERDES_V6_20_RX_GM_CAL                                        0x10c
> @@ -41,5 +44,6 @@
>  #define QSERDES_V6_20_RX_MODE_RATE3_B4                         0x220
>  #define QSERDES_V6_20_RX_MODE_RATE3_B5                         0x224
>  #define QSERDES_V6_20_RX_MODE_RATE3_B6                         0x228
> +#define QSERDES_V6_20_RX_BKUP_CTRL1                            0x22c
>
>  #endif
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
