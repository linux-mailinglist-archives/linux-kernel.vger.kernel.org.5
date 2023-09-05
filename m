Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DD793027
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjIEUi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjIEUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:38:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F584CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:38:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso461128866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693946332; x=1694551132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qISIWFWT+90Xd6ZFQOF4flQ0s4igN8yW6IgB7edRboU=;
        b=EXUsCprzN/8aLF0Iu/mxNAx95RkFFRi84JZSccKHyfRknf3ADFEJyxJ1WO9tzF+spd
         EiBJ4xkFWcdGMhdZWMzfR3bjm7LfOZ3VayL6AtkPl0qUzsD5P1OIMUWXiySg4xlTs1K+
         beP4tIL/tLgoxCD5StNEOBXFR8rbEnDKy3eY3VmGLi9Jz5o9JDeQ4ufw9h3LTzih3KG3
         17My8+VXp+IUb4xrzQ6C85RFp6Hmp4IRQw83p8kpRBhII3nGMGvIH3vmutsnX0RBRwHx
         AOSlsiqRHfpLzE9Oxmco9A3wrlq70sbGNYt22OO4G/2+E3DXNur5xgQ1OwVJtpKEqdll
         Ej6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946332; x=1694551132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qISIWFWT+90Xd6ZFQOF4flQ0s4igN8yW6IgB7edRboU=;
        b=IONhVmjkpY5QrNPH/kS00AbcVPLIAoYt84cfeahUJ0ZDIdqVZpjmokSXSqmdDc5/8C
         EquTV3KGnhg6wvfXXBJgLbyBZ3kVQuliwHeMc96TinvpMutXih2WI6HtHOyabEZ6QsUT
         pIJkq7ZosKMMU9RN0Kgu554B6FWmk/c5dZ+vslJXMNZcpLQe64J6mXFu3n6bzlpYAWbo
         dxOyFPPfRw1wb9WHJRkgY/dWsSLHqErUYSyaYMfA03tTy4YveUyHDxWjXRXX6jpViL9x
         fVJ8xAJ270uKXR4Rcf8yvohniR2HiMK3Nz7O1RWmQIZHO+BaZZxs++1o3p0/cy5L0hqi
         DkkA==
X-Gm-Message-State: AOJu0Yy5TB5vtM/DqxQL9oBmBWil/rHtTKvzD5kr1HRL7HInJM2xk1gs
        xEvldDsyamTc/t5aJLksw/VV9A==
X-Google-Smtp-Source: AGHT+IEwOKhjqGOu2h/QRhHr/SAOH0IQAohqcX26Y4rMgNvLsbCvrMoYVYHzeWdQFLWTxxzvuqgoEQ==
X-Received: by 2002:a17:906:5a70:b0:9a1:c370:1aef with SMTP id my48-20020a1709065a7000b009a1c3701aefmr695845ejc.55.1693946332043;
        Tue, 05 Sep 2023 13:38:52 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b009937e7c4e54sm8001110eju.39.2023.09.05.13.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:38:51 -0700 (PDT)
Message-ID: <8aefd8f9-cfe9-4011-a24b-ebb13d28faa0@linaro.org>
Date:   Tue, 5 Sep 2023 23:38:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY
 support
Content-Language: en-GB
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1693909838-6682-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 13:30, Rohit Agarwal wrote:
> Add support for USB3 QMP PHY found in SDX75 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 158 ++++++++++++++++++++++++++++++++
>   1 file changed, 158 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 0130bb8..57b8b5b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -23,6 +23,7 @@
>   #include "phy-qcom-qmp-pcs-misc-v3.h"
>   #include "phy-qcom-qmp-pcs-usb-v4.h"
>   #include "phy-qcom-qmp-pcs-usb-v5.h"
> +#include "phy-qcom-qmp-pcs-usb-v6.h"
>   
>   /* QPHY_SW_RESET bit */
>   #define SW_RESET				BIT(0)
> @@ -858,6 +859,134 @@ static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_rx_tbl[] = {

[skipped the tables]

> @@ -1556,6 +1685,32 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
>   	.has_pwrdn_delay	= true,
>   };
>   
> +static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
> +	.lanes			= 1,
> +	.offsets		= &qmp_usb_offsets_v5,

v6?

> +
> +	.serdes_tbl		= sdx75_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= sdx75_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= sdx75_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= sdx75_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= sdx75_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
> +	.clk_list		= qmp_v4_sdx55_usbphy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_sdx55_usbphy_clk_l),
> +	.reset_list		= msm8996_usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),

Clocks and resets are gone in 
https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/

> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,

This must be v6, if the rest of the PHY is using v6 register names.

> +	.pcs_usb_offset		= 0x1000,
> +
> +	.has_pwrdn_delay	= true,
> +};
> +
>   static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>   	.lanes			= 1,
>   
> @@ -2256,6 +2411,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>   		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
>   		.data = &sdx65_usb3_uniphy_cfg,
>   	}, {
> +		.compatible = "qcom,sdx75-qmp-usb3-uni-phy",
> +		.data = &sdx75_usb3_uniphy_cfg,
> +	}, {
>   		.compatible = "qcom,sm6115-qmp-usb3-phy",
>   		.data = &qcm2290_usb3phy_cfg,
>   	}, {

-- 
With best wishes
Dmitry

