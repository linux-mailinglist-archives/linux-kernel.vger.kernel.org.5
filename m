Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745D78867C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbjHYL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbjHYL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:57:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430F1736
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:57:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5007abb15e9so1267526e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692964669; x=1693569469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mI7LozyFnLw8X2nfK3M7EIsWWR+IuMlSQ82oLzCFyxQ=;
        b=ANjRosRmqwfEkh2Bq99SkEV9Vgk1avFkNRtuIwM7yM/idaVfqIQqoa23ARNEbMWk4x
         innLza2bIEkZwi+wjuYOix4GAlnribLsJiv05qD7RRv9qS2NLmtbiS84yD3ay9yjmVIX
         8XiELTblkR04P5Z6Wv7dy9TfF9B0nPtLitQnmWFZfR/aXrwVcTY2EVA4sJcS8E+u5F75
         A96Gj4CBIfHVTfjyj6TegWK3cmqHZl+t4qRxMuJhUGEgDhdDyDdXIzd03/Ngn0jQXm+w
         hc7KX1nY3nnYCaMmnxa4Kqaa+pVgrDIqjgT9TR2ES1TFOURR5ooEi6qIluVG2CtD9+ei
         tqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692964669; x=1693569469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI7LozyFnLw8X2nfK3M7EIsWWR+IuMlSQ82oLzCFyxQ=;
        b=FtmSpDGrRhnxd8UFQ0atq9YXoxG1PomZfV2SjHYxhpiPQBUmSAJvI+JxYQgOpA0EUf
         6bgvvGXwq6jY5eQUAF6bDOwR2EaiopCIx96n93fcr8sU/CJGsDz/QZKXkqs24353MgUo
         gsV+azxdRfdeaMUiOVxEr9Nh8TtQ5Fpcy+YDrtRNmCY3O6210QtjUb2Zrtl5Vi2d4CS0
         SO6EQCIpjzIFW1SPspcqD4inCpGkO3mkb0LhV0MCHxGejIPW1ZHUa0nPpHU2kaRBtiFZ
         dZUe8oRtb1rQCRWoI/yVoQelzNVsAIwdCsTvg0w0snQr3vljeTzOowKjzGWs0TtQWoZg
         WsRQ==
X-Gm-Message-State: AOJu0YyigLLOQUIFtUaJwCIzXzxnA0PtvejdnOJvlYpy+kJsYUl6CftT
        XTgtJS3QAEFeExczQJIkDv7bjw==
X-Google-Smtp-Source: AGHT+IFWg1yOq0L4H8y4xkE4vY/TfiOIhcqqBSADkWR9pfsWJHmvSXKgeslKs+QfJr7PY2t2Q6gJFQ==
X-Received: by 2002:a05:6512:3150:b0:500:9d4a:8a02 with SMTP id s16-20020a056512315000b005009d4a8a02mr3450258lfi.62.1692964668752;
        Fri, 25 Aug 2023 04:57:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk232.neoplus.adsl.tpnet.pl. [83.9.30.232])
        by smtp.gmail.com with ESMTPSA id v12-20020ac2560c000000b004f86d3e52c0sm264602lfd.4.2023.08.25.04.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 04:57:48 -0700 (PDT)
Message-ID: <bfacff27-e3b2-43e8-b50e-3da0f13feb5c@linaro.org>
Date:   Fri, 25 Aug 2023 13:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: apq8960: reflect that memory node starts
 at offset 0
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230812183218.374157-1-david@ixit.cz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230812183218.374157-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2023 20:32, David Heidelberg wrote:
> Fixes warning generated by `make qcom-msm8960-cdp.dtb`:
> arch/arm/boot/dts/qcom-msm8960-cdp.dt.yaml: /: memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 0]]}
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
But does it really?

i.e., if you boot it on a device and xxd /sys/firmware/devicetree/base/memory
or decompile /sys/firmware/fdt, is it updated to <0x0 0xsomesize>?

Konrad
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> index c10797f3793c..c20f16845a97 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
> @@ -47,7 +47,7 @@ L2: l2-cache {
>  		};
>  	};
>  
> -	memory {
> +	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0>;
>  	};
