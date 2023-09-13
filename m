Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCE79E2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbjIMJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbjIMJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:06:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69471999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:06:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8bba8125so202496066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694596003; x=1695200803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npEEuvyrxe+edVufA31/hnBZZi0ug9NLaKIp4p/ndJU=;
        b=Xvn4CJCpxccWWP327LNQr8IDea+UDcYsi8wbMOgppKzVl+7Bb9RAOmVpk71auaQoMN
         a/fMYZenHYKZWbPrSjHLWNf84Po2md99716Vfm426BsPZbCzvDJOHcD0iGnGG0gEa/hK
         ISd33SV34lzSw9R4Okz36hWy1PCSXklwsXtL6EAp1Q3A5ktaSFhQTrd6X5kPk+lv7N60
         wcbNrksrKNB+OEqzLLUQbs2kT7qnd7WIrrhBqE/jbsoWXwVx5O6f++Wh10PUPBq26L3m
         DHjShSVNe19x4p5x8ZZx+0FKGTMlqvhIvw7hL525e6q3o/SjBsZWU4uGADXL1vaoZ1fB
         zoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596003; x=1695200803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npEEuvyrxe+edVufA31/hnBZZi0ug9NLaKIp4p/ndJU=;
        b=Svsw0P1IjTlOOCJxhD13k0u7ls68VH8/kG+nURRAOqt/xPp7Ej7X+VtLfRFzMrI0Xo
         PIxWmES4laQVpx0o1xMrpccexOHPUbJKuHiHdCr3SaDOtgIsqN2C2fWwNRwKCy6ZgI1X
         ExCoRBMWIRVjzY62wTQjkCYZuGT0qvs8yfkyaPbUBdIemKMDJWVQCJYlDBXHA37IGkDf
         00piodZhMwy5a82ZfzfFXh6nUsi3A2ASRFw5JhJ4voyv9yH4jUduha2xJ5aSMFdejQ+N
         FkNVbt+TNehQZMnhl5ZelT+65962scpEbC/qJF9nvqF1Wgisn2uGXW/qW5UowbUi9d4X
         rKyQ==
X-Gm-Message-State: AOJu0YzBLrRf6skhFCDglJLJpXR6ZcJ8vWfQnNnDoViJGTSNoy1maiNV
        lpBUTW2gUShnJc2T4Jmvcf4c1Q==
X-Google-Smtp-Source: AGHT+IHW/dXSiduZfAbMj6mTqkDXHu3qLtn5ysXMD28wFKkFjNoGUtumPoAq5mYa+7vNfzsF4RlDew==
X-Received: by 2002:a17:907:761a:b0:9a2:185b:5376 with SMTP id jx26-20020a170907761a00b009a2185b5376mr1302033ejc.49.1694596003287;
        Wed, 13 Sep 2023 02:06:43 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00992b2c55c67sm8061434ejm.156.2023.09.13.02.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 02:06:42 -0700 (PDT)
Message-ID: <912f90ee-0816-43ae-bc6f-a9a9a3e33d8a@linaro.org>
Date:   Wed, 13 Sep 2023 11:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 19:41, Stephan Gerhold wrote:
> Most of the reserved firmware memory on MSM8916 can be relocated when
> respecting the required alignment. To avoid having to precompute the
> reserved memory regions in every board DT, describe the actual
> requirements (size, alignment, alloc-ranges) using the dynamic reserved
> memory allocation.
> 
> This approach has several advantages:
> 
>  1. We can define "templates" for the reserved memory regions in
>     msm8916.dtsi and keep only device-specific details in the board DT.
>     This is useful for the "mpss" region size for example, which varies
>     from device to device. It is no longer necessary to redefine all
>     firmware regions to shift their addresses.
> 
>  2. When some of the functionality (e.g. WCNSS, Modem, Venus) is not
>     enabled or needed for a device, the reserved memory can stay
>     disabled, freeing up the unused reservation for Linux.
> 
>  3. Devices with special requirements for one of the firmware regions
>     are handled automatically. For example, msm8916-longcheer-l8150
>     has non-relocatable "wcnss" firmware that must be loaded exactly
>     at address 0x8b600000. When this is defined as a static region,
>     the other dynamic allocations automatically adjust to a different
>     place with suitable alignment.
> 
> All in all this approach significantly reduces the boilerplate necessary
> to define the different firmware regions, and makes it easier to enable
> functionality on the different devices.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
[...]

>  
>  		mpss_mem: mpss@86800000 {
> +			/*
> +			 * The memory region for the mpss firmware is generally
> +			 * relocatable and could be allocated dynamically.
> +			 * However, many firmware versions tend to fail when
> +			 * loaded to some special addresses, so it is hard to
> +			 * define reliable alloc-ranges.
> +			 *
> +			 * alignment = <0x0 0x400000>;
> +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
> +			 */
Do we know of any devices that this would actually work on?

Konrad
