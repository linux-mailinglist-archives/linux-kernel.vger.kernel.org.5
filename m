Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638E8119ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378216AbjLMQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjLMQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:45:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C2DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:45:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso42893285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702485949; x=1703090749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4268jPr/0OJttZorSvmBG8xiPFN+a2mPnLk9WeKbfE=;
        b=puQ2MB23I7taxNr7gC5nOUCt1kh0llJ27FGsvYcgmOo1Xat4btPZPnL8vI8VIk9zQu
         /g5ROXBIEPmaQEloYq8Ngb4lmmz3z9gjsSwQFatNqK1b0+NjXnaZIEeIXAfgZ+oyIkoF
         hKXAnhXo3VLonHIKjU53W33ou22+CJcZJP9UcESgt4aSSHoLQuhSficFzAAOakvuOJjB
         gOJVEppgW39uhaSahdzYGJggwj6iq3pXo8UXfsLcuuFtoNicBNFPs4lyQKqp5OXYjSO3
         d+hzAa1yjAOeBmzTCTUzud+GlGd7QBbXp8EnsYHFDnIYzBLjuUEJFaOeRaVFJ3dpafoS
         mBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485949; x=1703090749;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4268jPr/0OJttZorSvmBG8xiPFN+a2mPnLk9WeKbfE=;
        b=O3ef6H5azHVm2ULPZTh11Sor4QJLtEsxf1gfhMooFjjAfRyl/9+5C+Sgj5sd8REeiL
         5mHepBlbqyWuFNFvXJ2NKzLkzy+HhGTgFEs9TAd7TPj8ZmP5lmMYEOFZ33q6tiEJHBnc
         ONRcbgMCw58XmULQf4/EzcAL5JfWw50FEQrXZ92jhRxjwtxo926paHLE3pgt3UKD6Pek
         LZCB381LZdPBtWuhQKebNXeNSSZUVr/xwBrwioWMLwF9sUOSY1XF8Wf0LTvtDDYTHatl
         rIa3TQxKF+Q48rSUcFOa7lRTva4fZOy7+/pYOcuXS87onUBJ8h2d+kedRWeA2K+uBAEg
         zYfg==
X-Gm-Message-State: AOJu0YwwRi7+aGiSVtIpOVb/0tzuwaiTvm2XQJrNAaOw8T2ZQnKvBJ4v
        eQ1tIGEIy5r01E8IDZbI0hZ+iw==
X-Google-Smtp-Source: AGHT+IEqVmTr37m3vxcZXwYOAMNcmjD9btbrxDDzn/X9RPfczr1wL71qTknPEVjaneWY3lr3bG0u5w==
X-Received: by 2002:a05:600c:444c:b0:40c:2d8d:ac1f with SMTP id v12-20020a05600c444c00b0040c2d8dac1fmr4780207wmn.61.1702485949230;
        Wed, 13 Dec 2023 08:45:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ac4e:a5fe:7f71:8d59? ([2a01:e0a:982:cbb0:ac4e:a5fe:7f71:8d59])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d58c4000000b0033333bee379sm13767115wrf.107.2023.12.13.08.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:45:48 -0800 (PST)
Message-ID: <61ccf07f-5efa-4c5b-98f6-5fd88816a6a6@linaro.org>
Date:   Wed, 13 Dec 2023 17:45:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8450: drop unneeded
 assigned-clocks from codec macros
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
 <20231213162856.188566-3-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231213162856.188566-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/12/2023 à 17:28, Krzysztof Kozlowski a écrit :
> The MCLK clocks of codec macros have fixed 19.2 MHz frequency and
> assigning clock rates is redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not tested on HW.
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 3b6ea9653d2a..52390220d909 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2154,9 +2154,6 @@ wsa2macro: codec@31e0000 {
>   				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>   				 <&vamacro>;
>   			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> -			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> -					  <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> -			assigned-clock-rates = <19200000>, <19200000>;
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "wsa2-mclk";
> @@ -2203,10 +2200,6 @@ rxmacro: codec@3200000 {
>   				 <&vamacro>;
>   			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>   
> -			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> -					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> -			assigned-clock-rates = <19200000>, <19200000>;
> -
>   			#clock-cells = <0>;
>   			clock-output-names = "mclk";
>   			#sound-dai-cells = <1>;
> @@ -2250,9 +2243,6 @@ txmacro: codec@3220000 {
>   				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>   				 <&vamacro>;
>   			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> -			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> -					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> -			assigned-clock-rates = <19200000>, <19200000>;
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "mclk";
> @@ -2269,10 +2259,6 @@ wsamacro: codec@3240000 {
>   				 <&vamacro>;
>   			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>   
> -			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> -					  <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> -			assigned-clock-rates = <19200000>, <19200000>;
> -
>   			#clock-cells = <0>;
>   			clock-output-names = "mclk";
>   			#sound-dai-cells = <1>;
> @@ -2348,8 +2334,6 @@ vamacro: codec@33f0000 {
>   				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>   				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>   			clock-names = "mclk", "macro", "dcodec", "npl";
> -			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> -			assigned-clock-rates = <19200000>;
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "fsgen";

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
