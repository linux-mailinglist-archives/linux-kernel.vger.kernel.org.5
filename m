Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4227AF3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjIZTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIZTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:04:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D30180
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:04:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50337b43ee6so15824365e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695755063; x=1696359863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmA/G1DduQEvKKUEDX6DUZAubV5hEh6IhETLhiRVy9Q=;
        b=VxKhWLrXLF9uHOjgOR1hqrMT/KGsxJs0DmZCCG6AiinMhoNPw3psz43r9sJcwfKcEu
         yLiu7duv7O7mPkxxIe0ql7QPhuRI8jWLUtGvIrvmJWZMIDFWAL6/XnG2jAoMCf1kzTxr
         JhT4sCHpWx80JGB2yJFtsmvO53n9YoEt8x/8HaGsYaqc96IoYkmRidyFgtR7Qly3Q3/u
         39TV2oJdCp4dboAxWQES1bsHu3tdhkYqIAKxKDSP8D6CmYVptZ4UIK0x3ySgarq1kwb7
         S5653cNTiTsA5jpsE5qxSRJdDKXXQl9TAnfjQkpiQfRU8mZXOLss+FcqQTrV0s2BEgVX
         MEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755063; x=1696359863;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmA/G1DduQEvKKUEDX6DUZAubV5hEh6IhETLhiRVy9Q=;
        b=KugwXMKCIXjA1eRd3D0kC3/n1ktmfsZGfbolZSuFjk5SLnP4/834RXWgvUlKrC4Jfp
         b1buuz7n7WAJVGuRqrPDSD/speeShZ/7tI/qKlTq28T+unsCpB+tbU+yGZOFXX/dbhGv
         8v4kXNinRK4R0fcKf2vrfqti1fqHCBmUTtrzimd9FyAM63K0aUGfYxZbP7rpcEd4bVOc
         qQ8QDki6+09/6+mIPCW2aIVBHA61z5e7Czq68ZFUwppSkF1aJTWGjPiqiaGVjTsaYKUn
         i/VCwJhniNnCBNZ0Ki9f4st1XRufeky7V5/k7TL0IY2owNT1iatVp2W2nPFAq3zcIM+s
         Wmjg==
X-Gm-Message-State: AOJu0YxsEmVmDO7cUqwyGnNehJ6CaJiug4d3V7Bg2+eEzfFzgrlWrD0/
        JthYdv3xXSaZRIKj0DtH2QNLgEzu4WygaxUH4dVBbw==
X-Google-Smtp-Source: AGHT+IEW7fdu6dA3sOIjvjUN49UidyoreyDLPBUdHYjoLw27fkNtm6mPjvSxismxxmmifWKPtvTYIg==
X-Received: by 2002:a05:6512:3ca2:b0:503:1c07:f7f9 with SMTP id h34-20020a0565123ca200b005031c07f7f9mr11615591lfv.29.1695755063516;
        Tue, 26 Sep 2023 12:04:23 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id h19-20020ac25973000000b00500cfb168a3sm2283303lfp.139.2023.09.26.12.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:04:23 -0700 (PDT)
Message-ID: <9d0ad1cf-77d5-4704-9861-4eaae4cbec42@linaro.org>
Date:   Tue, 26 Sep 2023 21:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] arm64: dts: qcom: msm8916-samsung-j5: Add sound and
 modem
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-12-398eec74bac9@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230926-msm8916-modem-v1-12-398eec74bac9@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 18:51, Stephan Gerhold wrote:
> From: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> 
> Enable sound and modem for the Samsung J5 smartphones. The setup is
> similar to most MSM8916 devices, i.e.:
> 
>  - QDSP6 audio
>  - Speaker/earpiece/headphones/microphones via digital/analog codec
>    in MSM8916/PM8916
>  - WWAN Internet via BAM-DMUX
> 
> except:
> 
>  - There is no secondary microphone, so a different "model" is used to
>    differentiate that in the UCM configuration.
>  - Samsung-specific audio jack detection (not supported yet)
> 
> Co-developed-by: Markuss Broks <markuss.broks@gmail.com>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> [Stephan: Add consistent commit message]
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi | 15 +++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts         |  4 ++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> index fe59be3505fe..2caa820b0c26 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include "msm8916-pm8916.dtsi"
> +#include "msm8916-modem-qdsp6.dtsi"
> +
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -135,6 +137,10 @@ &blsp_uart2 {
>  	status = "okay";
>  };
>  
> +&mpss_mem {
> +	reg = <0x0 0x86800000 0x0 0x5800000>;
> +};
> +
>  &pm8916_resin {
>  	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> @@ -154,6 +160,15 @@ &sdhc_2 {
>  	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
>  };
>  
> +&sound {
> +	model = "msm8916-1mic";
That's.. vague.. Is that intended?

I also noticed only now that random patches have status
at random places in the property tree.. Removing the disablement
would aid that as well (wink wink)!

Konrad
