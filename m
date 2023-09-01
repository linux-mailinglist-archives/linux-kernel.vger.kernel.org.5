Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3378FD36
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbjIAM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIAM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:29:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D610E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:29:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500c6ff99acso3686921e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693571339; x=1694176139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rXyBxVHzh14H4lsJtqZsMfSNqjUOUgjpNJoum6M9uk=;
        b=lgTw8BRu+5UbgfzDdVF5bLOgb4/rUW/+nKwSk1J7fIDGKUxolGFts2mePxZ5MiQkEM
         xRhOkCxNRI6f/VRYSb6DErDckaZ5RLl53EKtDsaI1CScOiYTrp0wrFpSKm/nbD9I4+aQ
         HF0n1cu7k9tsksMFhgxaQIeYhC41mLh0xdm+furzT63YOu3zDy6XCcnQ2cYa+74SfLle
         yQWsgr+QEa4yrqALrH6g/GLQVVQeQHGpg3uWZqH+/hDWGfRtQrSy0fGQLdr9yk/YmcwB
         2tJX1QFbBN7GPJLVMugaE/Zno8IatTylu5vJ7jQ1RWl+UK8ifLueVi5KXSNWINuu/z7y
         FL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571339; x=1694176139;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rXyBxVHzh14H4lsJtqZsMfSNqjUOUgjpNJoum6M9uk=;
        b=Y6lRtZBkAr6/n36MiVL6/sHLL9S2kTmBP5SMsfSTQaJNLNwED3+EReBMvTphyvcl/S
         HMVJ+Fs0MpX9KYl6sOYOqWKm3wvIr6mV5x5s6wUdKgsgT7o+kZlKbkMAAc2YfYEBLDLl
         xpSCrSeZYsTr+K8htali1XInMgbgt/Z9JTkyxyNr5A0Bd/qMasph+bd6RQFgkZPUhrLk
         uklhw3Ts5Lc1jMHJ36aCFG4vdfpFbyd7I5Qi1GF/kqQ1/+mtGinivTeH07E8hD1zfqSP
         nUKGlVmCBWnXeNylMn9Cib+DySPp90O9lfeSYPGIGfmfLh0DqSNpe3lA8SIsYwp5EZCp
         vQvw==
X-Gm-Message-State: AOJu0YxXm+E4fDPjIvALha0c4NxehJVVQ3hH94CQdvUt3wUf1IDHoOBY
        Emb0N6AdKYcqUm7bD5t7NpuK9w==
X-Google-Smtp-Source: AGHT+IFKBVmf1Jrha0rdIrsWwiaj+lLI0uFYIFXXTas+Mbfuzwe1HTdf8ZaFhvxMbnEG93i0WxChFA==
X-Received: by 2002:a05:6512:159c:b0:500:b102:d1c9 with SMTP id bp28-20020a056512159c00b00500b102d1c9mr1833843lfb.29.1693571339234;
        Fri, 01 Sep 2023 05:28:59 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id o10-20020ac2434a000000b004fe20d1b288sm632572lfl.159.2023.09.01.05.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:28:58 -0700 (PDT)
Message-ID: <08a10dc1-bb8e-48b1-8d86-5ee513835196@linaro.org>
Date:   Fri, 1 Sep 2023 14:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in main
 pin config register
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230901090224.27770-1-krzysztof.kozlowski@linaro.org>
 <20230901090224.27770-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230901090224.27770-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.09.2023 11:02, Krzysztof Kozlowski wrote:
> Existing Qualcomm SoCs have the LPASS pin controller slew rate control
> in separate register, however this will change with upcoming Qualcomm
> SoCs.  The slew rate will be part of the main register for pin
> configuration, thus second device IO address space is not needed.
> 
> Prepare for supporting new SoCs by adding flag customizing the driver
> behavior for slew rate.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 20 ++++++++++++++------
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.h |  7 +++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index e2df2193a802..40eb58a3a8cd 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -190,6 +190,7 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
>  				    const struct lpi_pingroup *g,
>  				    unsigned int group, unsigned int slew)
>  {
> +	void __iomem *reg;
Aaalmost reverse-Christmas-tree!

>  	unsigned long sval;
>  	int slew_offset;
>  
> @@ -203,12 +204,17 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
>  	if (slew_offset == LPI_NO_SLEW)
>  		return 0;
>  
> +	if (pctrl->data->flags & LPI_FLAG_SLEW_RATE_SAME_REG)
> +		reg = pctrl->tlmm_base + LPI_TLMM_REG_OFFSET * group + LPI_GPIO_CFG_REG;
> +	else
> +		reg = pctrl->slew_base + LPI_SLEW_RATE_CTL_REG;
Perhaps lpi_gpio_read/write could be used here?

I guess both ways work though

Konrad
