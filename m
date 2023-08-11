Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5277996C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjHKV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbjHKV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:28:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26EA171F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:28:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so37061641fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691789296; x=1692394096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xt5mnz8ISQqmYxGNJVf+kiUIsx9UCw2QRD8qaOXJ3UU=;
        b=Vj6lyy3aSWpOGfL55n3TAzzO/3ks+670ixgZNjECmySfTxPIteqfwKi41dFPOVv5lV
         t6JtgKeUFpW9gCx1omfa/7v3g8CbnHBb4IaXpLY/wUZTcRGyztCRJEzwsSzhjzkVq3kL
         8o3U6hRtzBEMAArkEe0TbaFJxZHK5GmMuT9m9mfikkDG5eKgFLpkPGAJjBrJOOQnYqiU
         2HUnzvamFrw16YeiScDALBIhYpcp8G5wrhgrfFjYQdfANX8yYwtLzrzY7Dsx6uV1UR39
         n6rVlT7vNLH3G779cFuuNnbZxF8uNyxQbe+xd3DoShTh9Y5Q+SlPBGG73qt0xA8see47
         TpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789296; x=1692394096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt5mnz8ISQqmYxGNJVf+kiUIsx9UCw2QRD8qaOXJ3UU=;
        b=jqEvnt9QPLIFLGp0g1tPyzi2uKZUGbiyIevM8fWypRGa19qSQ2xlryuG3qEtzLyL10
         6QjaGs82rBVPKw3FWHE9F2Fdg+eGJ+XeIr+TRQG73kkmC9NhEhDIETOXxCCRbkYnnUjH
         yp5Eo7Cl7hs66ZyZEyOSrxJe8MFAnIy4/kHJXjbttVuF7YYLHEs8v2IODNrpE6DFz5K7
         fPzUcf88r1ezis0Ov1J7DPpyTLNzINQOfOcntadlxG0wtcMR5v6ukjCHkibSA9EC87hK
         C5KAqFZ+qWlTMyP4J6eiPj2cXCygxzttrA+SmMcv0tbVxzoftpafmS2cq8JVUwMqxPgD
         Rxpg==
X-Gm-Message-State: AOJu0YwO8Good0MlMEJ9BSYEmAV7ZJLG5PjWvPCKWIGGItJrHnMrh41W
        LHg66L3ilVQXccsh7POcgte2Ig==
X-Google-Smtp-Source: AGHT+IEJJ5+2FVihtue7M1XfSKC9yWdR2nhsM//t2BVXoyu9gSoradGO7ql1Mn/CBN0Y07K7N35nJQ==
X-Received: by 2002:ac2:4d1a:0:b0:4fe:1c40:9266 with SMTP id r26-20020ac24d1a000000b004fe1c409266mr2209272lfi.17.1691789295946;
        Fri, 11 Aug 2023 14:28:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25630000000b004fb7848bacbsm860713lff.46.2023.08.11.14.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:28:15 -0700 (PDT)
Message-ID: <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org>
Date:   Fri, 11 Aug 2023 23:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811210142.403160-1-robimarko@gmail.com>
 <20230811210142.403160-2-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230811210142.403160-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 23:01, Robert Marko wrote:
> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
> as they should be under the partitions subnode and use the generic
> jedec,spi-nor compatible.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"

Konrad

>  arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> index 0714616c9e45..f7ac8f9d0b6f 100644
> --- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> @@ -75,11 +75,9 @@ &blsp1_spi1 {
>  	status = "okay";
>  	cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
>  
> -	mx25l25635e@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> +	flash@0 {
>  		reg = <0>;
> -		compatible = "mx25l25635e";
> +		compatible = "jedec,spi-nor";
>  		spi-max-frequency = <24000000>;
>  	};
>  };
