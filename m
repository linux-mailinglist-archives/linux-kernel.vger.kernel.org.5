Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA28119F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378718AbjLMQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjLMQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:45:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4609BD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:46:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3331752d2b9so4724198f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702485963; x=1703090763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XXQ2ehWpDm3x0hzvGJwTzxoHhkRmFBd0RUpa4EeOwc=;
        b=G1IPRTt3WIg3eyDLl3hgoHWyIaKyG1BNIHdCjLeYPNg+OcUWgGsQJW9OSbR31sWkzt
         8319UIBhm3JU/Em1qHgG+IhBimrNEGuxQyWEmtNmH+ZVqfPrK9cZJeqgv9TExHTPEBmC
         exqrFh1UbMdoigIzSox6wsIgasC2wfLchq7F95MK2kQVegob+uz4hEBiVIBemte5Z9gP
         lsDLOh3dY8MHeEew1DOvGVXA0wwe2UFkxiPLvczmpqLhhjt7aznZi6WTnHvHqWije2Tn
         AzYhGKk24fosxv18sOs/nYr5vluJ7zk4lIEP5j9PSQgWc/u/6w6xcvYK+Si2/py6xHxy
         9qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485963; x=1703090763;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XXQ2ehWpDm3x0hzvGJwTzxoHhkRmFBd0RUpa4EeOwc=;
        b=LobwIT33g1qeVABz3RBZGD4XW9i95NZHOaDzJZv9eeAObyQ4DOYxc+DVADO5FImtuD
         uC5KvdpWZkIQZ3nEN8QbptY9XRfOGhp1otepz03SC8OTEwLUR/xYzZylL+djDcxrhcRK
         LNsNZj8AfLfmgSJYKaUiCtTPREjWpk8LpdZm6FM3yN4WsWzrd2Brv9mx9ceU2Xob62B0
         jIGZKU606X6AQsLQ3tRr2esx7sCuzmoFelTVtk29b3wUvrhOzsiGZTfd0FU3zfseBQcy
         nyAF7okJzkw9uBgCqj4D0+IR98/g9Pccs0+E1hHlecZkJj1TxTjUpmUQLDXUjEszX2ux
         9MIA==
X-Gm-Message-State: AOJu0YyjZ44JGUx+WDZo4hEZrprtx4NIfEn+rfevFM6gPxmy/1Pnstvz
        YQPj8vEVAY1oPBmZE4soMFTj9g==
X-Google-Smtp-Source: AGHT+IEB5rAi61NLHuaUfyijf9GcZGeT9vnyc9jfXHPcxAAOH4Oda+qVcK+pbIg1ntAsTaoKdPM2HQ==
X-Received: by 2002:adf:a3d5:0:b0:336:4372:748d with SMTP id m21-20020adfa3d5000000b003364372748dmr345981wrb.121.1702485962593;
        Wed, 13 Dec 2023 08:46:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ac4e:a5fe:7f71:8d59? ([2a01:e0a:982:cbb0:ac4e:a5fe:7f71:8d59])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d58c4000000b0033333bee379sm13767115wrf.107.2023.12.13.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:46:02 -0800 (PST)
Message-ID: <c21ace70-12c0-4fdc-9316-341876b871a6@linaro.org>
Date:   Wed, 13 Dec 2023 17:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8550: move Soundwire pinctrl
 to its nodes
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
 <20231213162856.188566-4-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231213162856.188566-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/12/2023 à 17:28, Krzysztof Kozlowski a écrit :
> Pin configuration for Soundwire bus should be set in Soundwire
> controller nodes, not in the associated macro codec node.  This
> placement change should not have big impact in general, because macro
> codec is a clock provider for Soundwire controller, thus its devices is
> probed first.  However it will have impact for disabled Soundwire buses,
> e.g. WSA2, because after this change the pins will be left in default
> state.
> 
> We also follow similar approach in newer SoCs, like Qualcomm SM8650.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 1f06fd33d1ce..d8f79b5895f5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2050,8 +2050,6 @@ lpass_wsa2macro: codec@6aa0000 {
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "wsa2-mclk";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&wsa2_swr_active>;
>   			#sound-dai-cells = <1>;
>   		};
>   
> @@ -2063,6 +2061,9 @@ swr3: soundwire-controller@6ab0000 {
>   			clock-names = "iface";
>   			label = "WSA2";
>   
> +			pinctrl-0 = <&wsa2_swr_active>;
> +			pinctrl-names = "default";
> +
>   			qcom,din-ports = <4>;
>   			qcom,dout-ports = <9>;
>   
> @@ -2096,8 +2097,6 @@ lpass_rxmacro: codec@6ac0000 {
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "mclk";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&rx_swr_active>;
>   			#sound-dai-cells = <1>;
>   		};
>   
> @@ -2109,6 +2108,9 @@ swr1: soundwire-controller@6ad0000 {
>   			clock-names = "iface";
>   			label = "RX";
>   
> +			pinctrl-0 = <&rx_swr_active>;
> +			pinctrl-names = "default";
> +
>   			qcom,din-ports = <1>;
>   			qcom,dout-ports = <11>;
>   
> @@ -2142,8 +2144,6 @@ lpass_txmacro: codec@6ae0000 {
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "mclk";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&tx_swr_active>;
>   			#sound-dai-cells = <1>;
>   		};
>   
> @@ -2161,8 +2161,6 @@ lpass_wsamacro: codec@6b00000 {
>   
>   			#clock-cells = <0>;
>   			clock-output-names = "mclk";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&wsa_swr_active>;
>   			#sound-dai-cells = <1>;
>   		};
>   
> @@ -2174,6 +2172,9 @@ swr0: soundwire-controller@6b10000 {
>   			clock-names = "iface";
>   			label = "WSA";
>   
> +			pinctrl-0 = <&wsa_swr_active>;
> +			pinctrl-names = "default";
> +
>   			qcom,din-ports = <4>;
>   			qcom,dout-ports = <9>;
>   
> @@ -2203,6 +2204,9 @@ swr2: soundwire-controller@6d30000 {
>   			clock-names = "iface";
>   			label = "TX";
>   
> +			pinctrl-0 = <&tx_swr_active>;
> +			pinctrl-names = "default";
> +
>   			qcom,din-ports = <4>;
>   			qcom,dout-ports = <0>;
>   			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
