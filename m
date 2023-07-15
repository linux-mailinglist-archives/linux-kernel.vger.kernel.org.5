Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B89754941
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGOORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjGOORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:17:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9263589
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:16:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso4812153e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689430616; x=1692022616;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fo1k/DQJKWK7eKDw0jXd1pagArbjShWTxq504FR2pi8=;
        b=tarcpxCpvBeEgLF6Ei4kqYI55LYNEEIubN3fx9YaHiIMCPy6euOvXmKkGOFeJ3/GG+
         LCP1PD2H++CIm2HMtlx5mkcr55kva1rxg6bjpNFRzY/xkLbfFRbckDRKwcgzUhmtUPTi
         hwVaaqjTmN4TjoBOZuCn+2TVuvpXBa6QRnYMT391I456qSF2Zp7GQHY9YapbJAW1qSJG
         JmJRThPzrN0lsq14gdkaSnrFJm5vh/07XwAkdnC4uduEuYq149DJOef9qzh5629f/zJz
         9MMhvz9hwqkikUp3jwF6Iocjdh8jFsttYQaJ7DFUh2OnXQ3vu6DeIL7WwJJOKv/hV+aB
         KN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689430616; x=1692022616;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo1k/DQJKWK7eKDw0jXd1pagArbjShWTxq504FR2pi8=;
        b=UGrv8BF2qEwbh0aX/CJ7sOIpXbC/PrhgN40327VBDb+1tbmd1Km0zRmNcfvbhdzHC6
         rGmEHl9G+AiAv0UxYqAVv4ccVFs1Ivw2lVTR/uPnRppDGQpTuzr9qwtUGdMvAK1PwxPR
         o2mMW2s6qfRw6eURY4PUiPg+T2RZfsWAFhXQ9VcluB5o4GhIQMxlQg0aQorlB/qYdYR9
         /hWsiiVOnHnOXvKOoKF2zlgWOoWrFH6EOIVnicwBDM+jFKA+ii5vNMB4EUeQm6S7ElvP
         yO84Kkzm9Lw05Y3OfzrR9Sny2ErlWHxko6x1Ltoy+CIVvagjUnlye6dIDr5h5EkypH/S
         OF2A==
X-Gm-Message-State: ABy/qLbPzLTpnc1jz3t1asZpoCEoz3ILOoIy1auDAQ5R1CoFucP/dkH0
        k++KvVLNfwx1DOUWUFrakjfElQ==
X-Google-Smtp-Source: APBJJlEptOc8JSycjXgkzv234hYnGER26otvf/5i9LrFcsFMCtV2BuSzRBQLaFKcLo0T1SStc7VYBQ==
X-Received: by 2002:a2e:9606:0:b0:2b6:cd6a:17f7 with SMTP id v6-20020a2e9606000000b002b6cd6a17f7mr6087996ljh.20.1689430616427;
        Sat, 15 Jul 2023 07:16:56 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e94c7000000b002b6fe751b6esm2517593ljh.124.2023.07.15.07.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:16:56 -0700 (PDT)
Message-ID: <07176a10-0ef6-291a-cfea-71ec39a38427@linaro.org>
Date:   Sat, 15 Jul 2023 16:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4 2/2] arm64: dts: qcom: ipq9574: enable GPIO based LEDs
Content-Language: en-US
To:     Sridharan S N <quic_sridsn@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616083238.20690-1-quic_sridsn@quicinc.com>
 <20230616083238.20690-3-quic_sridsn@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616083238.20690-3-quic_sridsn@quicinc.com>
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

On 16.06.2023 10:32, Sridharan S N wrote:
> Add support for wlan-2g LED on GPIO 64.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in V4:
> 	- Added patch dependency. This change depends on below patch set
> 	  https://lore.kernel.org/linux-arm-msm/20230614085040.22071-2-quic_anusha@quicinc.com/
> 
> Changes in V3:
> 	- Updated patch series title. Mentioned platform in series
> 	  title
> 
> Changes in V2:
> 	- No changes
>  
> .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> index fd5326dc1773..25424cecd834 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> @@ -34,6 +34,18 @@
>  			debounce-interval = <60>;
>  		};
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>  };
>  
>  &blsp1_spi0 {
> @@ -137,6 +149,14 @@
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio64";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
>  };
>  
>  &xo_board_clk {
