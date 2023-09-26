Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660B7AF364
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjIZS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjIZS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:56:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7197111F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:56:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5044dd5b561so10089156e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695754581; x=1696359381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjOTSiRr1QYByHRomcjvEjQ4oNDx5RrtbuBvHCe/QwM=;
        b=aZHF7NUkdWWkiOwD/hQ1iyzjuMKSq6SAj9HMFsj6eCfc6PYMtigD2XMTaXIvn7eLPi
         sb1Izr65pmRvajnlAdghocPVAFOCg2tEqrIMPeUHdRNGpZ+a0nqDaKy3sQZBB5BXAHSt
         iZxJ4D88nIIJK7oj1JzTMGP0ubscodk83r1jWFoFIzKoGMPTzkUdqs+h5zgCG1MPtKrT
         eyjDxUtXYVcHAKwsPGwGnglLYWgld1MNsrgWtdhVLxiq0fDhCzv89gg87Xq9RvOaIcn6
         4GzZ4+3BHuU3JuJs3Z+JBlHT5J0Kcwdig/C/11RQGZH0+hAbpf1xgFhx5Bibto0eQKro
         NwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754581; x=1696359381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjOTSiRr1QYByHRomcjvEjQ4oNDx5RrtbuBvHCe/QwM=;
        b=pxdn0YZ+P0K/sXpy16HWauqeVF2BoDjpwajptkl4JTcnHEVHjcU5bAnnx7Ba3tuDte
         Q5Xuv2Pu+X/UYPbqeHKfParxDQwR9ixB66g+rivtVEWV7hKw1kO0BLgaSMhJStskFxnu
         /8HJNSp7SGzTWKlPm5LslV0XcuX+ZNYJX+vTsYil7WaDDfXvPQRPiL1jn4NTPERkT3g2
         cz9iA9uKVkQ/f6e9gMHeSVEqmZa+KVRJi1VOmfiawBUe5UsQkNeHp5Lq8xBQlxfJc8oF
         unSD+NFKLSx4Zh8WqPL+nzcCdzTZMdoPJwJgMlnjUmvAXwiCsrprPp6YEcpNJKXS0MIw
         BCCg==
X-Gm-Message-State: AOJu0Yws/04b5kcjSFeKmGtZHBVjXxr5Ew9FKs54L8MOPs6pz2nDDi7J
        IkSxGG7gfxhJp3qh/H5ocrvRwQ==
X-Google-Smtp-Source: AGHT+IFhS0HLyds3AlLnzZ4rnlPAmfrPrf8WmwXD1hazwRU1Bjp2Fa/VISnkYkKZRGaWGPBrjVyQug==
X-Received: by 2002:ac2:4c41:0:b0:504:7bb0:9d7e with SMTP id o1-20020ac24c41000000b005047bb09d7emr804632lfk.27.1695754580610;
        Tue, 26 Sep 2023 11:56:20 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id c6-20020ac244a6000000b00504230986fbsm2271509lfm.52.2023.09.26.11.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:56:20 -0700 (PDT)
Message-ID: <f66409be-8444-468e-9e48-cbca5e5a84f7@linaro.org>
Date:   Tue, 26 Sep 2023 20:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] arm64: dts: qcom: msm8916-wingtech-wt88047: Add
 sound and modem
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-6-398eec74bac9@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230926-msm8916-modem-v1-6-398eec74bac9@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 18:51, Stephan Gerhold wrote:
> Enable sound and modem for the Xiaomi Redmi 2. The setup
> is similar to most MSM8916 devices, i.e.:
> 
>  - QDSP6 audio
>  - Earpiece/headphones/microphones via digital/analog codec in
>    MSM8916/PM8916
>  - Audio jack detection via analog codec in PM8916
>  - WWAN Internet via BAM-DMUX
> 
> except:
> 
>  - Speaker amplifier is connected to HPH_R (headphones) output of the
>    analog codec. There is a separate analog switch that allows disabling
>    playback via the headphone jack.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> index 419f35c1fc92..600c225a2568 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> @@ -6,6 +6,8 @@
>  /dts-v1/;
>  
>  #include "msm8916-pm8916.dtsi"
> +#include "msm8916-modem-qdsp6.dtsi"
> +
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
> @@ -25,6 +27,28 @@ chosen {
>  		stdout-path = "serial0";
>  	};
>  
> +	speaker_amp: audio-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
> +		sound-name-prefix = "Speaker Amp";
> +		pinctrl-0 = <&speaker_amp_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	/*
> +	 * This seems to be actually an analog switch that either routes audio
> +	 * to the headphone jack or nowhere. Given that we need to enable a GPIO
> +	 * to get sound on headphones, modelling it as simple-audio-amplifier
> +	 * works just fine.
> +	 */
Funny phones, as always

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
