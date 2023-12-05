Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC38051DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376979AbjLELRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjLELRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:17:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62549E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:17:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cd8f5bb5cso2121812a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701775037; x=1702379837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bFWvbHdZ+yBWjkG2AjCOWgUeQFJsO6N0KpFAtG5kgs=;
        b=Be41f6x48JSYW40Nf+sf7VQmx2ksdDqrd/auftSDo6qYt9rI/nCKTELdIumiJFxfZx
         Fk9m6piQfiWC/wyJnkTFjQEN0NXLRWcDFqft/mqgywFzC4KnxM0z9G/tKbUMJP3mluyk
         NeUK2uCOI4cMpKbzKWdiRQfDPRJHI6gRbjyEnAcum0BNdGOcmibzwjRFyG4lSwQ15rNy
         BcfG6RPFvcronsd0X1hYtisZxk3s8SqOGEOH/BlnRAK7Tx71baqlTK1f7DPFJcVH4gN1
         vfpoThtPAJXofP0UNflMxmeiPGraklWHmMl1c/p4nf7tcayFy88iicVLQH3ijWn/N2xv
         153Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775037; x=1702379837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bFWvbHdZ+yBWjkG2AjCOWgUeQFJsO6N0KpFAtG5kgs=;
        b=VPmr1vQ8s0mwgt+c9hhD2Qw4WRHNHFPhJHVUazYqpKnTmQPFOV71d9qnrJAvswAjvq
         lzuLtuiBzGibrb+dD/5Cp57c8WpjZrpVylQs2j+8yAsL5SdOPSAzcsmjZ6wkcWutUMkZ
         fuciZqufNbGu4rv8Pw16gHEAVAGnrM39kDo3rpIV2+w7WrrKHI6jqSsewDdNL+XMLa7I
         DRDTG74HgjpfYrPZjjHk1vj92WPNg4/21YivEY6r6WsKQiAeDo3JeihKFI4VBXtDeoW7
         FaMutvC3gv7lqzsP5zDG9eEeJlUeMOP29IexeyVqaraGQn1aRi71A2mOcmrQokQNp2HR
         o83A==
X-Gm-Message-State: AOJu0YxmO3qQTU5D9pqSz0P+fC7+MwI0bLKz1MaPZsCeChSGP054llFE
        wmZBuzYjQ0K2O3OLgN7Lbamblg==
X-Google-Smtp-Source: AGHT+IFxEB0bUAN14B30xmG0RvzRxnAklPYvA45XIZ8ORyABH1tKv+IfQodqEJ35m4YFxPMADQHx5A==
X-Received: by 2002:a05:6402:5190:b0:54c:c744:da7e with SMTP id q16-20020a056402519000b0054cc744da7emr1929309edd.40.1701775037298;
        Tue, 05 Dec 2023 03:17:17 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id g21-20020aa7c595000000b0054b3d8e65d7sm935118edq.47.2023.12.05.03.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 03:17:16 -0800 (PST)
Message-ID: <1c62dd8b-72b2-4204-8284-a1dd90d4f909@linaro.org>
Date:   Tue, 5 Dec 2023 12:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916/39-samsung-a2015: Add PMIC and
 charger
Content-Language: en-US
To:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20231205093841.24325-1-raymondhackley@protonmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231205093841.24325-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 10:38, Raymond Hackley wrote:
> The phones listed below have Richtek RT5033 PMIC and charger.
> Add them to the device trees.
> 
> - Samsung Galaxy A3/A5/A7 2015
> - Samsung Galaxy E5/E7
> - Samsung Galaxy Grand Max
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>   .../qcom/msm8916-samsung-a2015-common.dtsi    | 59 +++++++++++++++++-
>   .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  6 ++
>   .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  6 ++
>   .../qcom/msm8916-samsung-e2015-common.dtsi    |  6 ++
>   .../boot/dts/qcom/msm8916-samsung-e5.dts      |  6 ++
>   .../boot/dts/qcom/msm8916-samsung-e7.dts      |  7 +++
>   .../dts/qcom/msm8916-samsung-grandmax.dts     |  6 ++
>   .../boot/dts/qcom/msm8939-samsung-a7.dts      | 62 ++++++++++++++++++-
>   8 files changed, 156 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> index 2937495940ea..e6355e5e2177 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> @@ -28,6 +28,12 @@ tz-apps@85500000 {
>   		};
>   	};
>   
> +	battery: battery {
> +		compatible = "simple-battery";
> +		precharge-current-microamp = <450000>;
> +		precharge-upper-limit-microvolt = <3500000>;
> +	};
> +
>   	clk_pwm: pwm {
>   		compatible = "clk-pwm";
>   		#pwm-cells = <2>;
> @@ -128,6 +134,12 @@ muic: extcon@25 {
>   
>   			pinctrl-names = "default";
>   			pinctrl-0 = <&muic_int_default>;
> +
> +			usb_con: connector {
> +				compatible = "usb-b-connector";
> +				label = "micro-USB";
> +				type = "micro";
> +			};

It would be nice to break this up into individual patches

One patch for the battery, one patch for the usb-b-connector per device 
you are targetting.

More work but better practice to have more granular commits.


> +		regulators {
> +			rt5033_reg_safe_ldo: SAFE_LDO {
> +				regulator-min-microvolt = <4900000>;
> +				regulator-max-microvolt = <4900000>;
> +				regulator-always-on;
> +			};
> +
> +			/*
> +			 * Needed for camera, but not used yet.
> +			 * Define empty nodes to allow disabling the unused
> +			 * regulators.
> +			 */
> +			LDO {};
> +			BUCK {};
> +		};

Aren't the camera regulators off until enabled ?

---
bod

