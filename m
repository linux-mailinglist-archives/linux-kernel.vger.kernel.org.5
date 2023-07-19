Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B277592D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjGSKYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjGSKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:24:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5771BFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:23:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1413082a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689762224; x=1692354224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3pJ8/rAhj7NYYJOhmqVYLudMFrx8gs19kteCOdK6ME=;
        b=REFy3lfHdamB0ISB9cfcvAlnp1ANO8B7PvMomD/R8EWPuyyd7ItQF0bpLv2WocJKA0
         9eSA9HSeSW0ct92RmNbzYNzIUVGf0lEnWjuQpnjNBiC4Zp7e7yvTrYJ+qufsynUM960R
         hWwSRU1x4Iyx+vWdcZqasaQI3A8P7YhwNzRnK96fmugysLKnpebOjf8gitmEbZrKIeZj
         Q7zQ2BirllI4mIfL7etOOdYz4vm1mNlIuYFwzh8EfbhRIeHrVwwc74Rnvl3fhKmsM+4g
         85OtZ/SymqM2yHrl7UNftuRQCfdXPVrcGXOIS4B7aLeQL0/JpzmAsdKNob1MKVq1POlD
         raFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762224; x=1692354224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3pJ8/rAhj7NYYJOhmqVYLudMFrx8gs19kteCOdK6ME=;
        b=hU+21hFw8/qO4kh6xp9qhtN1BsS9Alhe9zqYcXM7ULUk5PcIKWjLnIYgpFDB7D0/62
         ICZ0G/Rgd8KDmvE5CtpmrF8ilCmDhdOAekZ3mwUZ1UKq69tvvByzdtuFXi7HYUqbZwr3
         LuggBIegG8Xon1R/QhEPsZdJSA97LwmnUqo9bI9iug7UNz+5W+955/aBFn5oMqAHa6A9
         Jwh4sNEX3eDBvVeSUle6g85+sbQ64OShtVtOSnJz2JseZoMnLNaSTcFZaEwX32a/c0T5
         SBdIHSJi3h9SyTllBCB5Rnvq4O6ODCJa6jDqOLJ1LYz6XueiHVH49CY8RPpEG3sq5RR8
         n8cQ==
X-Gm-Message-State: ABy/qLbeAwn5XFbo4qAqw/MiKf/Fv7p8/n3j9cJVJ60QNSlCNnIba65h
        n4IEI9pBMzS4mYU8AIsIHw2gVw==
X-Google-Smtp-Source: APBJJlF1wwGr3hspyNb41RaEmnIMSEb8P79fMj+m+4PqePeCSrMa2f89+1bBjbUK73iq2EIjYDHijw==
X-Received: by 2002:a05:6402:51c6:b0:51e:5e3d:cb92 with SMTP id r6-20020a05640251c600b0051e5e3dcb92mr1816302edd.16.1689762224570;
        Wed, 19 Jul 2023 03:23:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7d50b000000b0051e2a4edfd5sm2484238edq.21.2023.07.19.03.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:23:44 -0700 (PDT)
Message-ID: <def2f081-49a6-3ab9-6bf4-d8672fa28a31@linaro.org>
Date:   Wed, 19 Jul 2023 12:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-3-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719100135.21325-3-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 12:01, Tengfei Fan wrote:
> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |  1 +
>  arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..a0cfd37e674b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -215,3 +215,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb

Messed order.

> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> new file mode 100644
> index 000000000000..851a6761a6ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4450.dtsi"
> +/ {
> +	model = "Qualcomm Technologies, Inc. SM4450 QRD";
> +	compatible = "qcom,sm4450-qrd", "qcom,sm4450";

Missing bindings.

> +
> +	aliases { };
> +
> +	chosen {
> +		bootargs = " ";

Drop, useless.

OTOH, you miss here several properties. This is not even a basic board -
nothing works here, right? Please submit when you have at least serial
working.

> +	};
> +};

Best regards,
Krzysztof

