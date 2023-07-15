Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C22754971
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGOOpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGOOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:45:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0992715
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:45:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so4862889e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689432319; x=1692024319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4EcfZJuKQ20RuePztd2+oZPnl4lVWexyu50zCxyk80=;
        b=bHcBYV2lGQ5yXfUUDnNTpUS5sLmA/OsHsZPCH6ZXM2IoFZTRkhfGaIF2Pws3q4BJQG
         rOD9hIRBttzzoflwQknVukwJd5gOX9EBBmhqWjHInCyWLseaTWgHn6JZxj1QRlKdqkUN
         9j0aTYF+eJ5lExCG0wNNF0Nz8usncmV06q/P42UyyS1HkD5PeE8YLk3tqw9vbI/6tXrh
         /xlakgYkFf8pqjjR1jDapfFYOjVvCLHwdIgyss2WcCJYRuYdYwApdaZJ02UgtUBp2eUk
         tcMejnlI43xp8vpCvWYQqiTlUQYgPNQzzpEwEKZiBPBEBs/MpmGjZjrGqOjPywoOhN+l
         q5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689432319; x=1692024319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4EcfZJuKQ20RuePztd2+oZPnl4lVWexyu50zCxyk80=;
        b=bzXRJSwhAZ6+xL0+xlE+8Z10/AdQkCf8iTuAuv7N/CXqeGDDGZTI65lFyqOwV1E/hK
         ierEk6AKIEMqxGbTBc31tjc2K7nwy7s897weYOJep1ajWCO+1ASIwGDtU8wCwACMyfRo
         NC3S7tO7xFBqBewsqNy5E4aO9tCVsZ4LbZkduRmrrU+Qxr1IajuZPu7GFIRjCeDs33nF
         dgbHntT//4EvBNv50PdsUfaugiWx92MJpn+kT9oUqkQbiMWIEOFuBvGbzXigAyIfn5X7
         vVDI9yJwywMFy0EwbmYbmlbWY7D+uazy0HwOW6CA2/i6D9MTbstTB8WYEw6juS8wKZbn
         P/jQ==
X-Gm-Message-State: ABy/qLaRJ7enHSuiN/+pSpXCouBJRzsct+MPmRPTawq/BFArTCYMG9WB
        af2wfU/sIN1kf6Gu73LLwxB/oQ==
X-Google-Smtp-Source: APBJJlGnBNcV5pZoslsf+BH81Sv+QZRw/Cxxxtw3P5X/b//RW33B0I9CTJjKIfmz/P1rXPDXQbyAnA==
X-Received: by 2002:a05:6512:3d8a:b0:4f8:70b8:12b1 with SMTP id k10-20020a0565123d8a00b004f870b812b1mr5735526lfv.4.1689432319095;
        Sat, 15 Jul 2023 07:45:19 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651203c200b004f87024742fsm1905710lfp.235.2023.07.15.07.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:45:18 -0700 (PDT)
Message-ID: <e6ae5c3e-f823-634a-f4e5-b13b238fe6a4@linaro.org>
Date:   Sat, 15 Jul 2023 16:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>
References: <20230715091932.161507-1-davidwronek@gmail.com>
 <20230715091932.161507-6-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230715091932.161507-6-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2023 11:16, David Wronek wrote:
> Add support for the RTC which is the same as on other PMICs and add the
> resin child node to the PM6150 PON device, both disabled by default.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Tested-by: Nikita Travkin <nikita@trvn.ru>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> index 2e6afa296141..af51eb0646ba 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> @@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
>  				bias-pull-up;
>  				linux,code = <KEY_POWER>;
>  			};
> +
> +			pm6150_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};
>  		};
>  
>  		pm6150_temp: temp-alarm@2400 {
> @@ -88,6 +96,14 @@ pm6150_adc_tm: adc-tm@3500 {
>  			status = "disabled";
>  		};
>  
> +		pm6150_rtc: rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
>  		pm6150_gpios: gpio@c000 {
>  			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
