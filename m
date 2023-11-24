Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4037F6D33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjKXHuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344729AbjKXHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:50:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F77D67
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:50:54 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54af1776bc5so455231a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700812252; x=1701417052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t72f4wPL/KQKtbypIvo76yycy/dSaAM33evdOmYUjh8=;
        b=LLLUza2mP3dr986i9/QUFzxT0Jfof+0DXPbY3p8t47XB4S94UdXhSF+H0Xo09lXKoY
         jaddfP8eWJPXMrsloOaZVoA0yZlLyBqTmQHYLnX9hNNuuPtljpkYi6TNiYbQwLNAIt81
         Av8RxEnIRWfmvbRbTDlc/7uhxLJ0EOxdfOGBW2G9IrJWjbK+TvIDF12DdGLdNytujpUI
         y8FtdKTfNSNI8k2wd1CVjTizSOXTrMpSqRt7xpggzAUjzXZCqqqsgmlMJA+zc9NveX1n
         +IHDeVV77bKVffMxr+sTuPNiR8reUcbQoN8mCU+Y3hAkV8WMu/vquwI4JL07IZU78dEh
         gO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700812252; x=1701417052;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t72f4wPL/KQKtbypIvo76yycy/dSaAM33evdOmYUjh8=;
        b=dW9n+BV8u8Z0Q6DT3wQscgWb2SXc6KfYv+0bDGnX9GU9swtw5rUjTfD0Ehgu7OJd2z
         +YUncZOTtpX59knEJQxqzjLwvHJ2S2yxOaaCFoGaVd99aVn6FKpfYZB+qOTbVGs8Z1y8
         /LxuePtAa8bsbslcKbzOiTCnNbo+lLYOs5d5AFZHgyJIqvIwh5ph+GNxSURlEbg6iFCG
         I8Y9J76UQt1DlJWHo6CUs9inEtizcygfyQN26s2Ezajy4os4vY06BtHgxd1TlHTLlLHr
         WO/MV4pySymDEqDbwmwxvCu/Cnm1DZKKqUmpHj/CS5ZS91rY2zGGogEujsDvLMvwuSZj
         ZClw==
X-Gm-Message-State: AOJu0YxhCE5qWq+jvCrt5Y3+zDwdTsscMLfL00dU8aTEV3EZkJZGWBfd
        rWeVn50bMKTkria7DJ2ZA2tNtA==
X-Google-Smtp-Source: AGHT+IFTS3GA2nqCP5ApuCMI7aWQTy4ZEQZBx6Y0ZVQJDa4emFpcGOdRBVkg08GRDVlg+VnubJJbrw==
X-Received: by 2002:aa7:da57:0:b0:54a:f72d:38bc with SMTP id w23-20020aa7da57000000b0054af72d38bcmr816993eds.1.1700812252445;
        Thu, 23 Nov 2023 23:50:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id i1-20020aa7dd01000000b00548657c5efdsm1483540edv.10.2023.11.23.23.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 23:50:52 -0800 (PST)
Message-ID: <47406b19-811f-47ab-8c08-dd8c4cc5d8bd@linaro.org>
Date:   Fri, 24 Nov 2023 08:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Fix the warnings from coresight
 bindings
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231124061739.2816-1-quic_jinlmao@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231124061739.2816-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 07:17, Mao Jinlong wrote:
> Fix all warnings in Qualcomm boards coming from Coresight bindings.

One logical thing, one patch. That applies not only to Linux kernel, but
to all software projects.

> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 ----------------------
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++----------
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  |  5 +----
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  |  5 +----
>  arch/arm64/boot/dts/qcom/sm8250.dtsi  | 24 ++++----------------
>  5 files changed, 26 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 6ba9da9e6a8b..e42c22b26adc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2637,24 +2637,6 @@ funnel1_out: endpoint {
>  			};
>  		};
>  
> -		funnel@3023000 {
> -			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> -			reg = <0x3023000 0x1000>;
> -
> -			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> -			clock-names = "apb_pclk", "atclk";
> -
> -
> -			out-ports {
> -				port {
> -					funnel2_out: endpoint {
> -						remote-endpoint =
> -						  <&merge_funnel_in2>;
> -					};
> -				};
> -			};
> -		};

Why do you remove nodes? How is this anyhow related to commit msg?
Nothing here is explained.

> -
>  		funnel@3025000 {
>  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>  			reg = <0x3025000 0x1000>;
> @@ -2681,14 +2663,6 @@ merge_funnel_in1: endpoint {
>  						  <&funnel1_out>;
>  					};
>  				};
> -
> -				port@2 {
> -					reg = <2>;
> -					merge_funnel_in2: endpoint {
> -						remote-endpoint =
> -						  <&funnel2_out>;
> -					};

Why?

> -				};
>  			};
>  
>  			out-ports {
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index b485bf925ce6..ebc5ba1b369e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -2031,9 +2031,11 @@ etm5: etm@7c40000 {
>  
>  			cpu = <&CPU4>;
>  
> -			port {
> -				etm4_out: endpoint {
> -					remote-endpoint = <&apss_funnel_in4>;
> +			out-ports {
> +				port {

So you want to say out-ports is missing? Commit msg is really not
explaining anything.

> +					etm4_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in4>;
> +					};
>  				};


Best regards,
Krzysztof

