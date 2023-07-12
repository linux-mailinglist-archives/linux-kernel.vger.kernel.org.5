Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB527510F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGLTHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGLTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:07:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB41FC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:07:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2452034a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689188856; x=1691780856;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P12/yloogXOzDhZA17e17hGhqvGduW+O8nRBGpE0kgo=;
        b=U3Keanq3++4XqhwoDO9wSHMTcdLV8SYXN6C7H59iGRVD223k713+bqjC8Ut6WUSOis
         nnnZpNBkhab3tQJ9yK+PaQLSIMm9uLBj7WEfYCjBPTekETkl2YBILpnq49SvxaLRI4AX
         3FXH5Icd6YebH6aPlTGcubiJsXplDSjjRF16X8P84IRqm0MIEVDPYcq20aQBxs83Uy+U
         Ne+MBh5+T+gNhB7BmKJ1aXCGOgmcgDQj8wl4hv4Qk4qiLmo2BUvgM/y7KXWvuyvTyUCq
         auZBbLw4BeWtXRx55ifoBigx5CW2s6BHYUsQnnxuWKuy05I9w7MkpeLTLmLaPS5Jfx+5
         EjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188856; x=1691780856;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P12/yloogXOzDhZA17e17hGhqvGduW+O8nRBGpE0kgo=;
        b=VnFEM6Erh55T2awXA/N0y9/QZ77Gvk35Ab8HscS0eQvWzkeRwbdaYreWpdAzWrIJT+
         qNZmMaRLZLiI2vzinU+MkUFN0e2QWSzRgdBpEgHZtWSVVLi+YkMXspj4sZ1qofTFc6lN
         n5I1tukMQU5eanaez60eKYVFpCfCmtVdwA5X+AKhq8FkrsYsZxxvihE4aNl8mRbV0c1a
         KO1ehevKjfJB1146TnzkABUOvShp9u02KCFqFNumAh4kI5SDmctaQDbrrIcLnt6CGXPw
         ry5N8TvO7UPn7z/j0d1wR/HdKMwc+2Tf47AO/IH1yOxF0yKDKUvTU0eUVI61iBE8hbGX
         juSw==
X-Gm-Message-State: ABy/qLbVFXri28WsxWpkY8sl9BxBi7Exhfy5XboazPbyPpozumSAcdPG
        3we8sA/m+DM0iCmzGhESi7YY5g==
X-Google-Smtp-Source: APBJJlHezAjfoPC7CLpGqkGdvN5Da1zk7gvnMbhlXHSIxofv3+d9rDwvWM2ue6pnMtgs8d9Mz1L8Hg==
X-Received: by 2002:a17:906:6492:b0:994:1805:1fad with SMTP id e18-20020a170906649200b0099418051fadmr4307254ejm.10.1689188855967;
        Wed, 12 Jul 2023 12:07:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090657d000b0098e42bef732sm2887999ejr.183.2023.07.12.12.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:07:35 -0700 (PDT)
Message-ID: <29cb4426-a15e-7186-1713-427f749bc187@linaro.org>
Date:   Wed, 12 Jul 2023 21:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/7] arm64: dts: imx93-11x11-evk: added nxp secure
 enclave fw
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-5-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712121219.2654234-5-pankaj.gupta@nxp.com>
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

On 12/07/2023 14:12, Pankaj Gupta wrote:
> Added support for NXP secure enclave called EdgeLock Enclave
> firmware (se-fw) for imx93-11x11-evk.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 8643612ace8c..2b0f901d2709 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2022 NXP
> + * Copyright 2022-2023 NXP
>   */
>  
>  #include <dt-bindings/clock/imx93-clock.h>
> @@ -863,5 +863,14 @@ ddr-pmu@4e300dc0 {
>  			reg = <0x4e300dc0 0x200>;
>  			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		ele_fw: se-fw {
> +			compatible = "fsl,imx93-ele";
> +			mboxes = <&s4muap 0 0 &s4muap 1 0>;

This should be two entries.

> +			mbox-names = "tx", "rx";
> +			fsl,mu-did = <3>;
> +			fsl,mu-id = <2>;

Drop both. Since you put it into the DTSI, it means it is compatible
specific.

> +			status = "okay";

Drop.



Best regards,
Krzysztof

