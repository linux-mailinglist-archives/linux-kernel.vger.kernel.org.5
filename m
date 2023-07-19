Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4F75928E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGSKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGSKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:17:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3A1FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:17:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso2559826e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689761828; x=1690366628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0FHMjrGmCXIw0/DZBD+IQ1a60ZI2uMLDW9c0NrQHlI=;
        b=etGEow4RvOH5lMWiG86zx5Nr4kAteEEBWUdgjZvmzgXjEJ1yEEuLhdcEkcBbpz92Z8
         ph4OxAbDyOXatQhzoiYHE2XlAC2W8IwuHOfc8GtYiecQ3X5RjwsUR6r3eo3h3MWtecyn
         o/aBPXzGcFQk837zaUpLJbdE7QPkPxoy5D5qKHAQgzZP8RmoLu2Gr+YqMoCVQu0iUTB5
         ILpCFLqnJTAn+ZZ/76At1SkdZhJ9oT1dybWN2TOe8DzHfJ5b8LEx6ceSonwu7nhhr311
         CJ7bJTZiHOBg355/yfAMTZG9hRhuPAcl3y53W58lRFkVGChRLhWvhmi+XnyNBFio27fi
         cxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761828; x=1690366628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0FHMjrGmCXIw0/DZBD+IQ1a60ZI2uMLDW9c0NrQHlI=;
        b=DqnenpVrHOphtUECXCL/C2J/sCVlPbYbJmWKUyzpmXorKkQG2saOAR+DmNVMFLs5n5
         L6Nz5lkZ9Dx5160+Cf/ehNVtO6EPyQvAnmfU3LtaI9luMbGNp15yEsrZ6/edsL3Db8GO
         HjBPZia9E4/kIEe9lQxIp/L9SPrcywpaY4IqacZZd9bJctjqze4DekCi9wuvGmm+/NU/
         AK/vASTBJ9CAum0FZ1jhH56cGsJqFKVfr/5DbicQEZmXIcNAHD2DrhS2a61hg1X/yER0
         yaiCLCBzvnof1d9UiI8V0h0RSG/L80DGbAMSeORHDR4xoMcr2mDgj7dQ4x+YbZqG2SEK
         Z8CA==
X-Gm-Message-State: ABy/qLanCaVLMy1UXlalG+HQAB1yGjtV20zoQenKNtSi9yVyrhubdrNi
        5E3TA6fOmSvmPNUa6oaWOa9mWg==
X-Google-Smtp-Source: APBJJlEnoluqRJ5HQQAwtaILFzOiwW2HMLqH/12MYBtrVGwkX0/dPhXrorNJ57McribBJ8TvLpO44Q==
X-Received: by 2002:a05:6512:1328:b0:4f8:5ab0:68c4 with SMTP id x40-20020a056512132800b004f85ab068c4mr1629899lfu.59.1689761828252;
        Wed, 19 Jul 2023 03:17:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d14-20020ac25ece000000b004fdc0023a50sm869383lfq.232.2023.07.19.03.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:17:07 -0700 (PDT)
Message-ID: <484822a3-939f-599d-434c-38f7a560a015@linaro.org>
Date:   Wed, 19 Jul 2023 13:17:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-GB
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230719100135.21325-3-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 13:01, Tengfei Fan wrote:
> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile       |  1 +
>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..a0cfd37e674b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -215,3 +215,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb

You guess, this should be sorted.

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
> +
> +	aliases { };
> +
> +	chosen {
> +		bootargs = " ";

Do you need this?

> +	};
> +};

-- 
With best wishes
Dmitry

